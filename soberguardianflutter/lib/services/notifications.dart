import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_database/firebase_database.dart';

class Notifications {
  FirebaseMessaging messenger = FirebaseMessaging.instance;

  Future<void> init() async {
    // Request permission
    await requestPermission();

    // Get token
    String? token = await getDeviceToken();
    print("Token: $token");

    // Listen to messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Message received");
      print(message.notification?.body);
      print(message.data);
    });
  }

  Future<void> requestPermission() async {
    NotificationSettings settings = await messenger.requestPermission(
        alert: true, badge: true, sound: true, provisional: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User is authorized!");
    } else {
      print("Notification permissions have not been granted");
    }
  }

  Future<String?> getDeviceToken() async {
    return await messenger.getToken();
  }

  void sendNotification(String deviceToken) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'sendNotification',
    );

    try {
      await callable.call(
        <String, dynamic>{
          'token': deviceToken,
          'title': 'Test notification',
          'body': 'This is a test notification',
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void sendAltNotification(String uid) {
    // write a notification the uid's node in the database in a notifiction subnode
    final ref = FirebaseDatabase.instance.ref("users/$uid/notifications");
  }
}
