import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soberguardian/shared/singleton.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

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
        if (r.advertisementData.serviceUuids.isNotEmpty &&
            r.advertisementData.serviceUuids[0].toString() ==
                "12345678-1234-5678-1234-56789abcdef0") {
          print("Device detected!");
          FlutterBluePlus.stopScan();
          connectToDevice(r.device);
          break;
        }
        // print(
        //     '${r.device.platformName} found! Advertisment UUIDs: ${r.advertisementData.serviceUuids}');
        // print(r.advertisementData.serviceUuids.runtimeType);
      }
    });
  }

  void connectToDevice(BluetoothDevice device) async {
    await device.connect().then((value) {
      print("Connected to device");
      singleton.deviceConnected = true;
      singleton.notifyAllListeners();
      discoverServices(device);
    });
  }

  void discoverServices(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    for (var service in services) {
      print("Service: ${service.uuid}");
      if (service.uuid.toString().toUpperCase() ==
          "12345678-1234-5678-1234-56789abcdef0") {
        print("Service found!");
        // Attempt to find the characteristic
        var characteristic = service.characteristics.firstWhere(
          (c) =>
              c.uuid.toString().toUpperCase() ==
              "12345678-1234-5678-1234-56789abcdef1",
        );
        performActions(characteristic);
      }
    }
  }

  void performActions(BluetoothCharacteristic characteristic) {
    // To write to the characteristic
    characteristic
        .write([0x0F]); // Example to write byte 0x0F as per your server setup

    // To read from the characteristic
    characteristic.read().then((value) {
      print('Read value: $value');
    });

    // Optionally set up notifications to receive updates
    characteristic.setNotifyValue(true);
    characteristic.lastValueStream.listen((value) {
      print('Received notification: $value');
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
          Consumer(builder: (context, singletonCon, snapshot) {
            return Text("Pair Status: ${singleton.deviceConnected}");
          }),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                // Delete account
                FirebaseDatabase.instance
                    .ref("users/${FirebaseAuth.instance.currentUser?.uid}")
                    .remove();
                FirebaseAuth.instance.currentUser?.delete();

                // Sign out and restart the app
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);
              },
              child: const Text("Delete Account",
                  style: TextStyle(color: Colors.white)))
        ],
      ),
    );
  }
}
