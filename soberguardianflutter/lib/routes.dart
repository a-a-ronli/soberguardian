import 'package:flutter/material.dart';
import 'package:soberguardian/screens/settings.dart';
import 'package:soberguardian/screens/login.dart';
import 'package:soberguardian/screens/signup.dart';
import 'package:soberguardian/screens/home.dart';
import 'package:soberguardian/auth_checker.dart';
// import 'package:soberguardian/screens/sober.dart';
import 'package:soberguardian/main.dart';
import 'package:soberguardian/screens/sober.dart';
import 'package:soberguardian/screens/drunk.dart';
import 'package:soberguardian/screens/test_breath.dart';
import 'package:soberguardian/screens/test_photo.dart';
import 'package:soberguardian/screens/test_result.dart';

var routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => AuthChecker(),
  "/title": (BuildContext context) => const TitleWidget(),
  "/home": (BuildContext context) => const HomePageWidget(),
  "/login": (BuildContext context) => const LoginWidget(),
  "/signup": (BuildContext context) => const SignUpWidget(),
  "/settings": (BuildContext context) => const SettingsScreen(),
  "/sober": (BuildContext context) => const SoberWidget(),
  "/drunk": (BuildContext context) => const DrunkWidget(),
  "/test_breath": (BuildContext context) => const BreathScreen(),
  "/test_photo": (BuildContext context) => const PhotoScreen(),
  "/test_result": (BuildContext context) => ResultScreen(),
  // "/notification": (BuildContext context) => NotificationScreen(),
  // "/notification_list": (BuildContext context) => NotificationListScreen(),
  // "/notification_reaction": (BuildContext context) => NotificationReactionScreen(),
};
