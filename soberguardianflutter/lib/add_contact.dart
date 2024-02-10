import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:soberguardian/services/auth.dart';
import 'package:soberguardian/shared/singleton.dart';

class AddContact extends StatefulWidget {
  AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController numberController = TextEditingController();

  Singleton _singleton = Singleton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Add Contact")),
        body: Column(
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
            ElevatedButton(
                onPressed:
                    (nameController.text != "" && numberController.text != "")
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
        ));
  }
}
