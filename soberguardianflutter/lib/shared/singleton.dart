import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Singleton extends ChangeNotifier {
    static final Singleton _instance = Singleton._internal();

    factory Singleton() => _instance;

    Singleton._internal();

    DataSnapshot? userData;
}