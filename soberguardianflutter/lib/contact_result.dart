import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:soberguardian/shared/singleton.dart';
import 'package:soberguardian/shared/loading.dart';
import 'package:soberguardian/home.dart';
import 'package:soberguardian/contact.dart';
// import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:soberguardian/services/auth.dart';

class ContactResultScreen extends StatefulWidget {
  final String response;
  bool messageSent = false;
  ContactResultScreen({super.key, required this.response});

  @override
  State<ContactResultScreen> createState() => _ContactResultScreenState();
}

class _ContactResultScreenState extends State<ContactResultScreen> {
  Future<void> sendMessage() async {
    try {
      await FirebaseDatabase.instance
          .ref("users/${Auth().user?.uid}/notifications")
          .set({
        "message": widget.response,
        "time": DateTime.now().millisecondsSinceEpoch,
      }).then((value) {
        setState(() {
          widget.messageSent = true;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.response != "Send Location") {
      sendMessage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (!widget.messageSent)
                ? Text("Sending response:\n${widget.response}")
                : Text("Response sent:\n${widget.response}"),
            const SizedBox(
              height: 15,
            ),
            (!widget.messageSent) ? const LoadingWheel() : Container(),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                if (widget.messageSent) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePageWidget()),
                  );
                } else {
                  Navigator.pop(context);
                }
              },
              child: (!widget.messageSent)
                  ? const Text("Cancel")
                  : const Text("Return to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
