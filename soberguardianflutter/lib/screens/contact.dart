import 'package:flutter/material.dart';
import 'package:soberguardian/screens/add_contact.dart';
import 'package:soberguardian/shared/singleton.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:soberguardian/services/auth.dart';
import 'package:soberguardian/screens/contact_result.dart';

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
    List<Widget> contactCards = [];
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
    contactCards = contacts
        .map((contact) => Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: ContactCard(
                categoryColor: widget.categoryColor,
                name: contact["name"],
                number: contact["number"].toString(),
                onCardTap: () {
                  setState(() {
                    name = contact["name"];
                    number = contact["number"].toString();
                  });
                },
              ),
            ))
        .toList();

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
                          Text(name,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white)),
                          Text(number,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white)),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ContactResultScreen(
                                        response: "Send Location")));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 243, 214, 117)),
                              child: const Text("Send Location",
                                  style: TextStyle(color: Colors.black))),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: ListView(
                              padding: const EdgeInsets.all(10.0),
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
                                    child: const Text(
                                        "Can you come pick me up.",
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
                                    child: const Text(
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
                                    child: const Text(
                                        "Someone is driving me home.",
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
                                    child: const Text(
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
                                    child: const Text(
                                        "Can I stay by your house?.",
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text("Add Contact",
                        style: TextStyle(color: Colors.white))),
                ElevatedButton(
                    onPressed: () {
                      print("DELETING CONTACT");
                      List<dynamic> update = [];
                      // for (int i = 0; i < contacts.length; i++) {
                      //   if (contacts[i]["number"] != number) {
                      //     update.add(contacts[i]);
                      //   }
                      // }

                      for (int i = 0; i < contactCards.length; i++) {
                        if (((contactCards[i] as Padding).child as ContactCard)
                                .selected ==
                            false) {
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text("Delete Contact",
                        style: TextStyle(color: Colors.white))),
              ],
            ),
            Expanded(
              child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: contactCards),
            )
          ],
        ),
      ),
    );
  }
}

class ContactCard extends StatefulWidget {
  final Color? categoryColor;
  final String name;
  final String number;
  final Function onCardTap;
  late bool selected;

  ContactCard(
      {super.key,
      required this.categoryColor,
      required this.name,
      required this.number,
      required this.onCardTap,
      this.selected = true});

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.selected = !widget.selected;
        print(widget.selected);
        widget.onCardTap();
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Card(
          color: widget.selected ? widget.categoryColor : Colors.grey,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            (widget.selected)
                ? const Icon(Icons.check, color: Colors.green)
                : Container(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.name,
                      style:
                          const TextStyle(fontSize: 20, color: Colors.white)),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.number,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white))
                  ]),
            )
          ]),
        ),
      ),
    );
  }
}
