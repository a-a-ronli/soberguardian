import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:camera/camera.dart';
import 'package:location/location.dart';

class Singleton extends ChangeNotifier {
  static final Singleton _instance = Singleton._internal();

  factory Singleton() => _instance;

  Singleton._internal();

  DataSnapshot? userData;

  Map<Object?, Object?> userMap = {};

  Map<String, String> uidToName = {};

  String aiServerUrl = "";

  bool isDrunk = false;

  CameraDescription? selfieCamera;

  List<CameraDescription> cameras = [];

  String currentCategory = "";

  StreamController<LocationData> locationStreamController =
      StreamController<LocationData>.broadcast();

  LocationData? locationData;
  void updateLocationData(LocationData data) {
    locationData = data;

    locationStreamController.add(data);

    notifyListeners();
  }

  void notifyAllListeners() {
    notifyListeners();
  }
}
