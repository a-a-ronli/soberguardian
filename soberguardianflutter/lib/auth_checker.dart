import 'package:flutter/material.dart';
import 'package:soberguardian/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:soberguardian/main.dart';
import 'package:soberguardian/screens/home.dart';
import 'package:soberguardian/shared/singleton.dart';
import 'package:soberguardian/shared/loading.dart';
import 'package:soberguardian/size_config.dart';

class AuthChecker extends StatelessWidget {
  AuthChecker({super.key});

  final Singleton _singleton = Singleton();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return FutureBuilder(
      future: FirebaseDatabase.instance.ref("ai_server_url").once(),
      builder: ((BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        }

        // print("Here is the data: ${snapshot.data?.snapshot}");
        // print("Here is the type: ${snapshot.data?.snapshot.runtimeType}");

        if (snapshot.data != null) {
          // Save to local copy
          _singleton.aiServerUrl = snapshot.data?.snapshot.value as String;
          print("Here is the server URL: ${snapshot.data?.snapshot.value}");
        }

        return StreamBuilder(
            stream: FirebaseDatabase.instance
                .ref("users/${Auth().user?.uid}")
                .onValue,
            builder:
                ((BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingScreen();
              }

              print("Here is the data: ${snapshot.data?.snapshot}");
              print("Here is the type: ${snapshot.data?.snapshot.runtimeType}");
              print("path: ${Auth().user?.uid}");

              if (snapshot.data != null) {
                // Save to local copy

                _singleton.userData = snapshot.data?.snapshot;
                print("Here is the data: ${snapshot.data?.snapshot.value}");

                // Convert snapshot data to map
                if (snapshot.data?.snapshot.value is String == false &&
                    snapshot.data?.snapshot.value != null) {
                  _singleton.userMap =
                      snapshot.data?.snapshot.value as Map<Object?, Object?>;
                }

                if (_singleton.userMap["alcohol_detected"] != null) {
                  _singleton.isDrunk =
                      _singleton.userMap["alcohol_detected"] as bool;
                }

                _singleton.notifyAllListeners();
                print(_singleton.userData?.value);
              }

              User? user = Auth().user;

              if (user == null) {
                return const TitleWidget();
              } else {
                return const HomePageWidget();
              }
            }));
      }),
    );
  }
}

            // // get the value of ai_server_url at rtdb root
            // DatabaseReference ref = FirebaseDatabase.instance.ref("ai_server_url");
            // ref.once().then((DataSnapshot snapshot) {
            //   _singleton.aiServerUrl = snapshot.value as String;
            // });