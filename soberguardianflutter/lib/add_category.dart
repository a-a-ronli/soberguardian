import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:soberguardian/services/auth.dart';
import 'package:soberguardian/shared/singleton.dart';

import 'package:soberguardian/icons.dart';
import 'package:soberguardian/colors.dart';
import 'package:soberguardian/shared/colors_reference.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
    late TextEditingController categoryNameController;
    IconData iconSelection = supportedIcons[0].last;
    Color colorSelection = supportedColors[0];

    final Singleton _singleton = Singleton();

    @override
    void initState() {
        super.initState();
        categoryNameController = TextEditingController();
    }

    @override
    void dispose() {
        categoryNameController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("Add Category"),
            ),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          child: TextField(
                              controller: categoryNameController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Category Name'
                              ),
                          ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          // color: Colors.grey,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              SizedBox(
                                  width: MediaQuery.sizeOf(context).width / 2.1,
                                  child: Icon(iconSelection, size: MediaQuery.sizeOf(context).width / 10,)),
                              SizedBox(width: MediaQuery.of(context).size.width / 7),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: colorSelection,
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    height: MediaQuery.of(context).size.height / 10,
                                    width: MediaQuery.of(context).size.height / 10,
                                ),
                          ],)
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            // Expanded(child: SizedBox(child: ListView())),
                            // Expanded(child: SizedBox(child: ListView()))
                            Container(
                                width: MediaQuery.sizeOf(context).width / 2,
                                height: MediaQuery.sizeOf(context).height / 2,
                                // color: Colors.red,
                                child: ListView(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    children: supportedIcons.map((pair) => 
                                        Column(
                                          children: [
                                            IconButton(
                                                tooltip: pair.first,
                                                onPressed: () {
                                                    if (mounted) {
                                                      setState(() {
                                                        iconSelection=pair.last;            
                                                    });
                                                    }
                                                }, 
                                                icon: Icon(pair.last, size: MediaQuery.sizeOf(context).width / 10,)),
                                            Text(pair.first),
                                          ],
                                        )).toList(),
                                )
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.height / 2,
                                // color: Colors.blue,
                                child: ListView.separated(
                                    padding: EdgeInsets.fromLTRB(70, 0, 70, 0),
                                    itemCount: supportedColors.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                        Color color = supportedColors[index];
                                        return SizedBox(
                                            width: MediaQuery.of(context).size.width / 10,
                                            height: MediaQuery.of(context).size.width / 10,
                                            // decoration: BoxDecoration(
                                            // color: color,
                                            // shape: BoxShape.circle,
                                            // ),
                                          child: ElevatedButton(onPressed: () {
                                            if (mounted) {
                                              setState(() {
                                                colorSelection=color;
                                            });
                                            }
                                          }, child: Text(""), style: ElevatedButton.styleFrom(
                                              backgroundColor: color
                                          )),
                                        );
                                    },
                                    separatorBuilder: (context, index) {
                                        return SizedBox(height:10);
                                    },
                                    ),
                                ),
                        
                        ],
                    ),
                    SizedBox(
                        width: MediaQuery.sizeOf(context).width / 2,
                        height: 50,
                        child: ElevatedButton(onPressed: (categoryNameController.text != "") ? () {
                            final ref =  FirebaseDatabase.instance.ref("user/${Auth().user?.uid}/categories");
                            print("users/${Auth().user?.uid}/categories");
                            List<dynamic> user_categories = List<dynamic>.from(_singleton.userData?.child("categories").value as List<dynamic>);
                            user_categories.add({"name": categoryNameController.text, "color": colorToName[colorSelection], "icon": iconsToString[iconSelection]});
                            ref.set(user_categories);
                            Navigator.pop(context);
                        //     ref.once().then((DatabaseEvent event) {
                        //         DataSnapshot snapshot = event.snapshot;
                        //         if (snapshot.value)
                        //         List<dynamic> arr = List<dynamic>.from(snapshot.value as List<dynamic>);
                        //         arr.add({"name": "Test"});
                        //         ref.set(arr);
                        // });
                        } : null, child: const Text("Confirm")),
                    ),
                ],
            )
        );
    }
}

