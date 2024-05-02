import 'package:flutter/material.dart';

Map<String, Color> nameToColors = {
  "brown": Color(0xff5c4033),
  "red": const Color.fromARGB(255, 244, 67, 54),
  "orange": const Color.fromARGB(255, 255, 152, 0),
  "yellow": const Color.fromARGB(255, 255, 235, 59),
  "green": const Color.fromARGB(255, 76, 175, 80),
  "blue": const Color.fromARGB(255, 33, 150, 243),
  "purple": const Color.fromARGB(255, 63, 81, 181),
  "white": const Color.fromARGB(255, 255, 255, 255),
  "black": const Color.fromARGB(255, 0, 0, 0)
};

Map<Color, String> colorToName = {
  Color(0xff5c4033): "brown",
  Color.fromARGB(255, 244, 67, 54): "red",
  Color.fromARGB(255, 255, 152, 0): "orange",
  Color.fromARGB(255, 255, 235, 59): "yellow",
  Color.fromARGB(255, 76, 175, 80): "green",
  Color.fromARGB(255, 33, 150, 243): "blue",
  Color.fromARGB(255, 63, 81, 181): "purple",
  Color.fromARGB(255, 255, 255, 255): "white",
  Color.fromARGB(255, 0, 0, 0): "black"
};
