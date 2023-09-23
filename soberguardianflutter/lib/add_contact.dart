import 'package:flutter/material.dart';

class AddContact extends StatelessWidget {
    AddContact({super.key});
  final TextEditingController nameController = TextEditingController();
    final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Text("Name"),
                TextField(
                    controller: nameController,
                    onChanged: (value) => nameController.text,
                ),
                Text("Number"),
                TextField(
                    controller: numberController,
                    onChanged: (value) => numberController.text,
                ),
                ElevatedButton(onPressed: (nameController.text != "" && numberController.text != "") ? 
                () {} : null, 
                child: Text("Confirm")),
            ],
        )
    );
  }
}