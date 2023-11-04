import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  final LatLng center;

  MapScreen({Key? key, required this.center}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map Sample')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: center, // Your coordinates
          initialZoom: 13.0,
        ),
        children: [
        //   TileLayerOptions(
        //     // Note: Please choose an appropriate tile provider
        //     urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
        //     subdomains: ['a', 'b', 'c'],
        //   ),
        //   MarkerLayerOptions(
        //     markers: [
        //       Marker(
        //         width: 80.0,
        //         height: 80.0,
        //         point: center, // Your coordinates
        //         builder: (ctx) =>
        //           Container(
        //             child: Icon(Icons.location_pin, color: Colors.red,),
        //           ),
        //       ),
        //     ],
        //   ),
        ],
      ),
    );
  }
}
