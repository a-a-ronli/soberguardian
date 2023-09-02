import 'package:flutter/material.dart';

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
            appBar: AppBar(),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            // Expanded(child: SizedBox(child: ListView())),
                            // Expanded(child: SizedBox(child: ListView()))
                            Container(
                                width: 100,
                                height: 100,
                                color: Colors.red,

                            ),
                            Container(
                                width: 100,
                                height: 100,
                                color: Colors.blue,
                                
                            )
                        ],
                    )
                ],
            )
        );
    }
}