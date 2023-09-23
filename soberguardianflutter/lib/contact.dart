import 'package:flutter/material.dart';
import 'package:soberguardian/add_contact.dart';

class ContactsPage extends StatefulWidget {
    final String categoryName;
    final Color? categoryColor;
  const ContactsPage({super.key, required this.categoryName, required this.categoryColor});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
    String name = "";
    String number = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.categoryName),),
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
                                  ElevatedButton(onPressed: () {}, child: Text("Send Location", style: TextStyle(color: Colors.black)), style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 243, 214, 117))),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.25,
                                    child: ListView(
                                        padding: EdgeInsets.all(10.0),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        children: [
                                            ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.white), child: Text("Lorem ipsum dolor sit amet.", style: TextStyle(color: Colors.black))),
                                            ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.white), child: Text("Lorem ipsum dolor sit amet.", style: TextStyle(color: Colors.black))),
                                            ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.white), child: Text("Lorem ipsum dolor sit amet.", style: TextStyle(color: Colors.black))),
                                            ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.white), child: Text("Lorem ipsum dolor sit amet.", style: TextStyle(color: Colors.black))),
                                            ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.white), child: Text("Lorem ipsum dolor sit amet.", style: TextStyle(color: Colors.black))),
                                        ],
                                    ),
                                  )
                              ],
                            ),
                          )
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            ElevatedButton(onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddContact()));
                            }, child: Text("Add Contact"), style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                            )),
                            ElevatedButton(onPressed: () {
                            }, child: Text("Delete Contact"), style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                            )),
                        ],
                      ),
                  ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                        ContactCard(
                            categoryColor: widget.categoryColor, 
                            name: "John Appleseed", 
                            number: "123-456-7890",
                            onCardTap: () {
                                setState(() {
                                    name = "John Appleseed";
                                    number = "123-456-7890";
                                });
                            },
                        ),
                        ContactCard(
                            categoryColor: widget.categoryColor, 
                            name: "Jane Doe", 
                            number: "123-456-7890",
                            onCardTap: () {
                                setState(() {
                                    name = "Jane Doe";  
                                    number = "123-456-7890";                   
                                });
                            },
                        ),
                    ],
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
  const ContactCard({
        super.key, 
        required this.categoryColor, 
        required this.name, 
        required this.number, 
        required this.onCardTap
    });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onCardTap(),
      child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Card(
              color: categoryColor,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                            children: [
                                Text(number, style: TextStyle(fontSize: 20))
                            ]
                        ),
                      )
                  ]
              ),
          ),
      ),
    );
  }
}