import 'package:firebase_messaging/firebase_messaging.dart';

class Notifications {
    FirebaseMessaging messenger = FirebaseMessaging.instance;

    Future<void> init() async {

    }

    void requestPermission() async {
        NotificationSettings settings = await messenger.requestPermission(
            alert: true,
            badge: true,
            sound: true,
            provisional: true
        );

        if (settings.authorizationStatus == AuthorizationStatus.authorized) {
            print("User is authorized!");
        } else {
            print("Notification permissions have not been granted");
        }
    }

    Future<String?> getDeviceToken() async {
        return await messenger.getToken();
    }

    void sendNotification() {

    }
}