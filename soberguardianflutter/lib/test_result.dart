import 'package:flutter/material.dart';
import 'package:soberguardian/sober.dart';
import 'package:soberguardian/drunk.dart';
import 'package:soberguardian/shared/loading.dart';
import 'package:soberguardian/home.dart';

// ignore: must_be_immutable
class ResultScreen extends StatelessWidget {
    ResultScreen({super.key});

  bool sober = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  const Text("Processing results..."),
                  const SizedBox(
                    height: 15
                  ),
                  const LoadingWheel(),
                  const SizedBox(
                    height: 15
                  ),
                  ElevatedButton(onPressed: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => HomePageWidget()), (route) => false);
                  }, child: const Text("Cancel")),
                  ElevatedButton(
                      onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SoberWidget()));
                      },
                      child: const Text('Sober'),
                  ),
                  ElevatedButton(
                      onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DrunkWidget()));
                      },
                      child: const Text('Drunk'),
                  ),
              ],
          ),
        )
    );
  }
}