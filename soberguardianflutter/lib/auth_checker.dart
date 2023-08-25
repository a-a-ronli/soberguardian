import 'package:flutter/material.dart';
import 'package:soberguardian/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soberguardian/main.dart';
import 'package:soberguardian/home.dart';

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {

    User? user = Auth().user;

    if (user == null) {
        return const TitleWidget();
    } else {
        return const HomePageWidget();
    }
  }
}