import 'package:flutter/material.dart';
import 'package:soberguardian/screens/sober.dart';
import 'package:soberguardian/screens/drunk.dart';
// import 'package:soberguardian/shared/loading.dart';
import 'package:soberguardian/shared/singleton.dart';

// ignore: must_be_immutable
class ResultScreen extends StatelessWidget {
  ResultScreen({super.key});

  bool sober = true;

  final Singleton _singleton = Singleton();

  @override
  Widget build(BuildContext context) {
    if (_singleton.userMap["alcohol_detected"] == true) {
      return const DrunkWidget();
    } else {
      return const SoberWidget();
    }

    // return Scaffold(
    //     body: SizedBox(
    //   width: MediaQuery.of(context).size.width,
    //   child: const Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Text("Processing results..."),
    //       SizedBox(height: 15),
    //       LoadingWheel(),
    //       SizedBox(height: 15),
    //       // ElevatedButton(
    //       //     onPressed: () {
    //       //       Navigator.pushAndRemoveUntil(
    //       //           context,
    //       //           MaterialPageRoute(
    //       //               builder: (BuildContext context) => HomePageWidget()),
    //       //           (route) => false);
    //       //     },
    //       //     child: const Text("Cancel")),
    //       // ElevatedButton(
    //       //   onPressed: () {
    //       //     Navigator.of(context)
    //       //         .push(MaterialPageRoute(builder: (context) => SoberWidget()));
    //       //   },
    //       //   child: const Text('Sober'),
    //       // ),
    //       // ElevatedButton(
    //       //   onPressed: () {
    //       //     Navigator.of(context)
    //       //         .push(MaterialPageRoute(builder: (context) => DrunkWidget()));
    //       //   },
    //       //   child: const Text('Drunk'),
    //       // ),
    //     ],
    //   ),
    // ));
  }
}
