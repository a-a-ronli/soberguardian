// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:soberguardian/size_config.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

String formatTimestamp(int timestamp) {
  DateTime now = DateTime.now();
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);

  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime eventDate = DateTime(date.year, date.month, date.day);

  if (today == eventDate) {
    var formatter = DateFormat('HH:mm');
    return formatter.format(date);
  } else {
    var formatter = DateFormat('MMM d');
    return formatter.format(date);
  }
}

class IntegratedNotificationCard extends StatelessWidget {
  final String name;
  final String message;
  final double latitude;
  final double longitude;
  final int timestamp;
  const IntegratedNotificationCard(
      {super.key,
      required this.name,
      required this.message,
      required this.latitude,
      required this.longitude,
      required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: SizeConfig.blockSizeHorizontal! * 90,
        height: SizeConfig.blockSizeHorizontal! * 20,
        child: Card(
            color: const Color.fromARGB(200, 75, 75, 75),
            child: InkWell(
              onTap: () {
                // Go to notification reaction screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationReactionScreen(
                              name: name,
                              message: message,
                              latitude: latitude,
                              longitude: longitude,
                              timestamp: timestamp,
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          formatTimestamp(timestamp),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Text(message, style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            )));
  }
}

class NotificationReactionScreen extends StatelessWidget {
  final String name;
  final String message;
  final double latitude;
  final double longitude;
  final int timestamp;
  const NotificationReactionScreen({
    super.key,
    required this.name,
    required this.message,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(formatTimestamp(timestamp),
                  style: const TextStyle(fontSize: 16)),
              Text(name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              Text(message, style: const TextStyle(fontSize: 16)),
              ElevatedButton(
                  onPressed: () async {
                    final availableMaps = await MapLauncher.installedMaps;
                    await availableMaps.first.showMarker(
                      coords: Coords(latitude, longitude),
                      title: name,
                    );
                  },
                  child: const Text("Open in Maps")),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal! * 90,
                height: SizeConfig.blockSizeVertical! * 70,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(latitude, longitude),
                    initialZoom: 13.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(latitude, longitude),
                          width: 80,
                          height: 80,
                          child: Image.asset("assets/images/Android Icon.png"),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
