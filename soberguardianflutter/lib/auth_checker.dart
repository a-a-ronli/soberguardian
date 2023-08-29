import 'package:flutter/material.dart';
import 'package:soberguardian/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:soberguardian/main.dart';
import 'package:soberguardian/home.dart';
import 'package:soberguardian/shared/singleton.dart';

class AuthChecker extends StatelessWidget {
  AuthChecker({super.key});

  final Singleton _singleton = Singleton();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref("user/${Auth().user?.uid}").onValue, 
      builder: ((BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {

        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          // TODO: replace with proper loading screen
          return Text("Loading");
        }

        print("Here is the data: ${snapshot.data?.snapshot}");
        print("Here is the type: ${snapshot.data?.snapshot.runtimeType}");
        print("path: ${Auth().user?.uid}");

        if (snapshot.data != null) {
          // Save to local copy

          _singleton.userData = snapshot.data?.snapshot;
          print(_singleton.userData?.value);
        }

        User? user = Auth().user;

        if (user == null) {
            return const TitleWidget();
        } else {
            return const HomePageWidget();
        }
    }));

    
  }
}