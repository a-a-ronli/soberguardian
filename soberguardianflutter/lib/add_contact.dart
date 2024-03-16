import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
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
                Text("Name"),
                TextField(
                    controller: nameController,
                    onChanged: (value) {
                      setState(() {
                        nameController.text = value;
                      });
                    }),
                SizedBox(height: 25),
                Text("Number"),
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
                        ? () {
                            // get the uid of the user with the friend code
                            var ref = FirebaseDatabase.instance
                                .ref("lobbies/${friendCodeController.text}");
                            ref.once().then((DataSnapshot snapshot) {
                                  print("UID: ${snapshot.value}");

                                  // write the request info to rtdb
                                  ref = FirebaseDatabase.instance.ref(
                                      "users/${snapshot.value}/requests/incoming/${Auth().user?.uid}");
                                  ref.update({
                                    "name": nameController.text,
                                    "number": numberController.text
                                  });
                                } as FutureOr Function(DatabaseEvent value));
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
                  child: ListView(
                    padding: const EdgeInsets.all(10.0),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Card(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "John Doe - 123-456-7890",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green),
                                        onPressed: () {
                                          // Accept

                                          // Add to contacts

                                          // Remove from pending
                                        },
                                        child: Text("Accept",
                                            style: TextStyle(
                                                color: Colors.white))),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red),
                                        onPressed: () {
                                          // Decline

                                          // Remove from pending
                                        },
                                        child: Text("Decline",
                                            style:
                                                TextStyle(color: Colors.white)))
                                  ],
                                )
                              ],
                            ),
                          ))

                      // ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.of(context).push(MaterialPageRoute(
                      //           builder: (context) => ContactResultScreen(
                      //               response:
                      //                   "Can you come pick me up.")));
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //         backgroundColor: Colors.blue),
                      //     child: Text("Can you come pick me up.",
                      //         style: TextStyle(color: Colors.white))),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.of(context).push(MaterialPageRoute(
                      //           builder: (context) => ContactResultScreen(
                      //               response:
                      //                   "I'm currently drunk, can you get help?")));
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //         backgroundColor: Colors.red),
                      //     child: Text(
                      //         "I'm currently drunk, can you get help?",
                      //         style: TextStyle(color: Colors.white))),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.of(context).push(MaterialPageRoute(
                      //           builder: (context) => ContactResultScreen(
                      //               response:
                      //                   "Someone is driving me home")));
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //         backgroundColor: Colors.green),
                      //     child: Text("Someone is driving me home.",
                      //         style: TextStyle(color: Colors.white))),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.of(context).push(MaterialPageRoute(
                      //           builder: (context) => ContactResultScreen(
                      //               response:
                      //                   "I'm staying somewhere for the night.")));
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //         backgroundColor: Colors.purple),
                      //     child: Text(
                      //         "I'm staying somewhere for the night.",
                      //         style: TextStyle(color: Colors.white))),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.of(context).push(MaterialPageRoute(
                      //           builder: (context) => ContactResultScreen(
                      //               response:
                      //                   "Can I stay by your house?.")));
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //         backgroundColor: Colors.white),
                      //     child: Text("Can I stay by your house?.",
                      //         style: TextStyle(color: Colors.black))),
                    ],
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
  PendingRequest({super.key, required this.name, required this.number});

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
                        contacts.add({"name": name, "number": number});
                        ref.set(contacts);
                        Navigator.pop(context);
                      },
                      child: Text("Accept",
                          style: TextStyle(color: Colors.white))),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        // Decline
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
