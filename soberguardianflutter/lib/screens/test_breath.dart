import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:soberguardian/screens/test_result.dart';

class BreathScreen extends StatefulWidget {
  const BreathScreen({super.key});

  @override
  State<BreathScreen> createState() => _BreathScreenState();
}

class _BreathScreenState extends State<BreathScreen> {
  double breathalyzerProgress = 1.0;
  @override
  Widget build(BuildContext context) {
    // if (breathalyzerProgress >= 1.0) {
    //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResultScreen()));
    // }
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Please breath into the tube and wait for results"),
          LinearPercentIndicator(
            percent: breathalyzerProgress,
            width: MediaQuery.sizeOf(context).width,
            lineHeight: 24,
            animation: true,
            animationDuration: 15000,
            progressColor: const Color(0xFF186FF0),
            backgroundColor: const Color(0xFFF1F4F8),
            // center: const Text(
            //     '50%',
            //     style: TextStyle(
            //         fontFamily: 'Poppins',
            //         color: Color(0xFF5C4033),
            //         ),
            // ),
            padding: EdgeInsets.zero,
            onAnimationEnd: () {
              print("test");
              if (breathalyzerProgress >= 1.0) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ResultScreen()));
              }
            },
          ),
          // ElevatedButton(onPressed: () {
          //     setState(() {
          //         breathalyzerProgress = 1.0;
          //     });
          // }, child: const Text("Simulate Completion"))
        ],
      ),
    );
  }
}
