import 'package:flutter/material.dart';
import 'package:soberguardian/test_breath.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
    bool photoTaken = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: (!photoTaken) ? [
                Container(
                    color: Colors.amber,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                SizedBox(
                    width: MediaQuery.of(context).size.height * 0.10,
                    height: MediaQuery.of(context).size.height * 0.10,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(75),
                          ),
                      ),
                      onPressed: () {
                        setState(() {
                            photoTaken = true;
                        });
                      }, 
                      child: null
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.045),
            ] : [
                Container(
                    color: Colors.amber,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.045),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: ElevatedButton(onPressed: () {
                                setState(() {
                                    photoTaken = false;
                                });
                            }, child: Text("Retake"))),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: ElevatedButton(onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => BreathScreen()));
                            }, child: Text("Confirm")))
                    ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            ],
        ),
    );
  }
}