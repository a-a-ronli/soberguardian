import 'package:flutter/material.dart';
import 'package:soberguardian/add_contact.dart';
import 'package:soberguardian/shared/singleton.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:soberguardian/services/auth.dart';
import 'package:soberguardian/contact_result.dart';

class ContactsPage extends StatefulWidget {
  final String categoryName;
  final Color? categoryColor;
  const ContactsPage(
      {super.key, required this.categoryName, required this.categoryColor});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  String name = "";
  String number = "";

  Singleton _singleton = Singleton();

  // TODO: fix later
  // @override
  // void initState() {
  //     super.initState();
  //     _singleton.addListener(() { setState(() {

  //             });});
  // }

  @override
  Widget build(BuildContext context) {
    // print("TEST: contacts/${_singleton.currentCategory}");
    // print(_singleton.userData?.child("contacts").child(_singleton.currentCategory).value as List<dynamic>);
    List<dynamic> contacts = [];
    if (_singleton.userData
            ?.child("contacts")
            .child(_singleton.currentCategory)
            .value !=
        null) {
      contacts = _singleton.userData
          ?.child("contacts")
          .child(_singleton.currentCategory)
          .value as List<dynamic>;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                    color: widget.categoryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(name, style: TextStyle(fontSize: 16)),
                          Text(number, style: TextStyle(fontSize: 16)),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ContactResultScreen(
                                        response: "Send Location")));
                              },
                              child: Text("Send Location",
                                  style: TextStyle(color: Colors.black)),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 243, 214, 117))),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: ListView(
                              padding: EdgeInsets.all(10.0),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => ContactResultScreen(
                                              response:
                                                  "Can you come pick me up.")));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue),
                                    child: Text("Can you come pick me up.",
                                        style: TextStyle(color: Colors.white))),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => ContactResultScreen(
                                              response:
                                                  "I'm currently drunk, can you get help?")));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    child: Text(
                                        "I'm currently drunk, can you get help?",
                                        style: TextStyle(color: Colors.white))),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => ContactResultScreen(
                                              response:
                                                  "Someone is driving me home")));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green),
                                    child: Text("Someone is driving me home.",
                                        style: TextStyle(color: Colors.white))),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => ContactResultScreen(
                                              response:
                                                  "I'm staying somewhere for the night.")));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.purple),
                                    child: Text(
                                        "I'm staying somewhere for the night.",
                                        style: TextStyle(color: Colors.white))),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => ContactResultScreen(
                                              response:
                                                  "Can I stay by your house?.")));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white),
                                    child: Text("Can I stay by your house?.",
                                        style: TextStyle(color: Colors.black))),
                              ],
                            ),
                          )
                        ],
                      ),
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddContact()));
                    },
                    child: Text("Add Contact"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    )),
                ElevatedButton(
                    onPressed: () {
                      print("DELETING CONTACT");
                      List<dynamic> update = [];
                      for (int i = 0; i < contacts.length; i++) {
                        if (contacts[i]["number"] != number) {
                          update.add(contacts[i]);
                        }
                      }
                      print(update);
                      final ref = FirebaseDatabase.instance.ref(
                          "users/${Auth().user?.uid}/contacts/${_singleton.currentCategory}");
                      print(
                          "users/${Auth().user?.uid}/contacts/${_singleton.currentCategory}");
                      ref.set(update).then((result) {
                        setState(() {});
                      });
                    },
                    child: Text("Delete Contact"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    )),
              ],
            ),
            Expanded(
              child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: contacts
                      .map((contact) => ContactCard(
                            categoryColor: widget.categoryColor,
                            name: contact["name"],
                            number: contact["number"].toString(),
                            onCardTap: () {
                              setState(() {
                                name = contact["name"];
                                number = contact["number"].toString();
                              });
                            },
                          ))
                      .toList()
                  // children: [
                  //     ContactCard(
                  //         categoryColor: widget.categoryColor,
                  //         name: "John Appleseed",
                  //         number: "123-456-7890",
                  //         onCardTap: () {
                  //             setState(() {
                  //                 name = "John Appleseed";
                  //                 number = "123-456-7890";
                  //             });
                  //         },
                  //     ),
                  //     ContactCard(
                  //         categoryColor: widget.categoryColor,
                  //         name: "Jane Doe",
                  //         number: "123-456-7890",
                  //         onCardTap: () {
                  //             setState(() {
                  //                 name = "Jane Doe";
                  //                 number = "123-456-7890";
                  //             });
                  //         },
                  //     ),
                  // ],
                  ),
            )
          ],
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final Color? categoryColor;
  final String name;
  final String number;
  final Function onCardTap;
  const ContactCard(
      {super.key,
      required this.categoryColor,
      required this.name,
      required this.number,
      required this.onCardTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onCardTap(),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Card(
          color: categoryColor,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(name, style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(number, style: TextStyle(fontSize: 20))]),
            )
          ]),
        ),
      ),
    );
  }
}
