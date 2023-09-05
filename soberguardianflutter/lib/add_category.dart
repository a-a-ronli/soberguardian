import 'package:flutter/material.dart';
import 'package:soberguardian/icons.dart';
import 'package:soberguardian/colors.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
    late TextEditingController categoryNameController;

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
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        color: Colors.grey,
                        child: Row(children: [],)
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
                                                    print(pair.first);
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
                                          child: ElevatedButton(onPressed: () {}, child: Text(""), style: ElevatedButton.styleFrom(
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
                        child: ElevatedButton(onPressed: () {}, child: Text("Confirm")),
                        width: MediaQuery.sizeOf(context).width / 2,
                        height: 50,
                    ),
                ],
            )
        );
    }
}

