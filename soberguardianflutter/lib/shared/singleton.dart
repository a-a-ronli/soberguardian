import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:camera/camera.dart';

class Singleton extends ChangeNotifier {
    static final Singleton _instance = Singleton._internal();

    factory Singleton() => _instance;

    Singleton._internal();

    DataSnapshot? userData;

    CameraDescription? selfieCamera;

    String currentCategory = "";

    void notifyAllListeners() {
        notifyListeners();
    }
}