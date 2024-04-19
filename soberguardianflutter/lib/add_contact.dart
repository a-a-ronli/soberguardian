import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:soberguardian/services/auth.dart';
import 'package:soberguardian/shared/singleton.dart';
import 'package:soberguardian/size_config.dart';

class AddContact extends StatefulWidget {
  AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController numberController = TextEditingController();

  final TextEditingController friendCodeController = TextEditingController();

  String lobbyCode = "";

  Singleton _singleton = Singleton();

  // function to generate a random string of length n
  String getRandomString(int n) {
    var charset =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    var random = Random.secure();
    return List.generate(n, (index) {
      return charset[random.nextInt(charset.length)];
    }).join();
  }

  @override
  void initState() {
    super.initState();
    lobbyCode = getRandomString(6);
    print("CODE: $lobbyCode");

    // write the lobby code into the rtdb
    final ref = FirebaseDatabase.instance.ref("lobbies");
    ref.update({lobbyCode: Auth().user?.uid});
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    friendCodeController.dispose();

    // remove the lobby code from the rtdb
    final ref = FirebaseDatabase.instance.ref("lobbies");
    ref.child(lobbyCode).remove();

    super.dispose();
  }

  List<Widget> getPendingRequests() {
    List<Widget> pendingRequests = [];

    // alternatively, get it from the singleton's userMap
    if (_singleton.userMap.containsKey("requests")) {
      var untypedRequests = _singleton.userMap["requests"];

      print("UNTYPE REQUESTS: $untypedRequests");

      // Check if the data is actually a Map and cast it manually
      if (untypedRequests is Map) {
        // Cast each key and value to String, dynamic respectively
        var requests = <String, dynamic>{};
        for (var key in untypedRequests.keys) {
          if (key is String && untypedRequests[key] is Map) {
            requests[key] = Map<String, dynamic>.from(untypedRequests[key]);
          }
        }

        print("REQUESTSSS: $requests");

        for (String key in requests.keys) {
          if (key == "incoming" && requests[key] is Map) {
            requests = Map<String, dynamic>.from(requests[key]);
            for (String key in requests.keys) {
              var request = requests[key];
              print("AHA: $request");
              // Proceed as before, now that we have a safely typed map
              if (request != null &&
                  request.containsKey("name") &&
                  request.containsKey("number")) {
                pendingRequests.add(PendingRequest(
                    name: request["name"] as String,
                    number: request["number"] as String,
                    uid: key));
              }
            }
          }
        }
      }
    }

    return pendingRequests;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Add ${_singleton.currentCategory} Contact"),
            bottom: const TabBar(tabs: [
              Tab(text: "Add Contact"),
              Tab(text: "Receive Contact"),
            ]),
          ),
          body: TabBarView(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Your Name"),
                TextField(
                    controller: nameController,
                    onChanged: (value) {
                      setState(() {
                        nameController.text = value;
                      });
                    }),
                SizedBox(height: 25),
                Text("Your Number"),
                TextField(
                    controller: numberController,
                    onChanged: (value) {
                      setState(() {
                        numberController.text = value;
                      });
                    }),
                SizedBox(height: 25),
                Text("Friend Code"),
                TextField(
                    controller: friendCodeController,
                    onChanged: (value) {
                      setState(() {
                        friendCodeController.text = value;
                      });
                    }),
                SizedBox(height: 25),
                ElevatedButton(
                    onPressed: (nameController.text != "" &&
                            numberController.text != "" &&
                            friendCodeController.text != "")
                        ? () async {
                            // get the uid of the user with the friend code
                            var ref = FirebaseDatabase.instance
                                .ref("lobbies/${friendCodeController.text}");
                            ref.once().then((DatabaseEvent event) {
                              var snapshot = event.snapshot;
                              print("UID: ${snapshot.value}");

                              // write the request info to rtdb
                              ref = FirebaseDatabase.instance.ref(
                                  "users/${snapshot.value}/requests/incoming/${Auth().user?.uid}");
                              ref.update({
                                "name": nameController.text,
                                "number": numberController.text
                              });
                            });
                          }
                        : null,
                    child: const Text("Send Request")),
                ElevatedButton(
                    onPressed: (nameController.text != "" &&
                            numberController.text != "" &&
                            friendCodeController.text != "")
                        ? () {
                            print(
                                "CURRENT CATEGORY: ${_singleton.currentCategory}");
                            final ref = FirebaseDatabase.instance.ref(
                                "users/${Auth().user?.uid}/contacts/${_singleton.currentCategory}");
                            print(
                                "users/${Auth().user?.uid}/contacts/${_singleton.currentCategory}");
                            List<dynamic> contacts = [];
                            if (_singleton.userData
                                    ?.child("contacts")
                                    .child(_singleton.currentCategory)
                                    .value !=
                                null) {
                              contacts = List<dynamic>.from(_singleton.userData
                                  ?.child("contacts")
                                  .child(_singleton.currentCategory)
                                  .value as List<dynamic>);
                            }
                            contacts.add({
                              "name": nameController.text,
                              "number": numberController.text
                            });
                            ref.set(contacts);
                            Navigator.pop(context);
                          }
                        : null,
                    child: Text("Confirm")),
              ],
            ),
            Column(
              children: [
                // Lobby Code user should tell friends to use
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal! * 90,
                  child: Card(
                    child: Center(
                      child: Text(
                        "Your code is: $lobbyCode",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),

                // List of pending requests
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Consumer<Singleton>(
                    builder: (context, singleton, snapshot) {
                      var requests = getPendingRequests();
                      return ListView.builder(
                        padding: const EdgeInsets.all(10.0),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: requests.length,
                        itemBuilder: (context, index) {
                          return requests[index];
                        },
                      );
                    },
                  ),
                ),
              ],
            )
          ])),
    );
  }
}

class PendingRequest extends StatelessWidget {
  final String name;
  final String number;
  final String uid;
  PendingRequest(
      {super.key, required this.name, required this.number, required this.uid});

  final Singleton _singleton = Singleton();

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "$name - $number",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        // Accept

                        print(
                            "CURRENT CATEGORY: ${_singleton.currentCategory}");
                        final ref = FirebaseDatabase.instance.ref(
                            "users/${Auth().user?.uid}/contacts/${_singleton.currentCategory}");
                        print(
                            "users/${Auth().user?.uid}/contacts/${_singleton.currentCategory}");
                        List<dynamic> contacts = [];
                        if (_singleton.userData
                                ?.child("contacts")
                                .child(_singleton.currentCategory)
                                .value !=
                            null) {
                          contacts = List<dynamic>.from(_singleton.userData
                              ?.child("contacts")
                              .child(_singleton.currentCategory)
                              .value as List<dynamic>);
                        }
                        contacts
                            .add({"name": name, "number": number, "uid": uid});
                        ref.set(contacts);

                        // Delete the request from the users incoming requests and delete self from the other user's outgoing requests
                        var ref1 = FirebaseDatabase.instance.ref(
                            "users/${Auth().user?.uid}/requests/incoming/$uid");
                        ref1.remove();

                        var ref2 = FirebaseDatabase.instance.ref(
                            "users/$uid/requests/outgoing/${Auth().user?.uid}");
                        ref2.remove();
                      },
                      child: Text("Accept",
                          style: TextStyle(color: Colors.white))),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        // Delete the request from the users incoming requests and delete self from the other user's outgoing requests
                        var ref = FirebaseDatabase.instance.ref(
                            "users/${Auth().user?.uid}/requests/incoming/$uid");
                        ref.remove();

                        ref = FirebaseDatabase.instance.ref(
                            "users/$uid/requests/outgoing/${Auth().user?.uid}");
                        ref.remove();
                      },
                      child: Text("Decline",
                          style: TextStyle(color: Colors.white)))
                ],
              )
            ],
          ),
        ));
  }
}
