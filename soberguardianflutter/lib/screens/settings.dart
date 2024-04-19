import 'package:flutter/material.dart';
import 'package:soberguardian/shared/singleton.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Singleton singleton = Singleton();

  @override
  void initState() {
    super.initState();
    // Start scanning
    FlutterBluePlus.startScan(timeout: Duration(seconds: 4));
    // Listen to scan results
    var subscription = FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        print('${r.device.platformName} found! rssi: ${r.rssi}');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    FlutterBluePlus.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    var emailFieldController = TextEditingController();
    var passwordFieldController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("Pair Device", style: TextStyle(fontSize: 20)),
          TextField(
            controller: emailFieldController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: passwordFieldController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          ElevatedButton(onPressed: () {}, child: Text("Pair Device")),
          Text("Pair Status: ${singleton.deviceConnected}"),
        ],
      ),
    );
  }
}
