import 'package:soberguardian/shared/singleton.dart';
import 'package:soberguardian/integrated_notification.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Data {
  Set<String> getContactUids() {
    Set<String> contactUids = {};
    if (Singleton().userMap.containsKey("contacts")) {
      Map<String, dynamic> userMap =
          Singleton().userMap.cast<String, dynamic>();

      // print("USER MAAAAPPP: $userMap");
      for (String key in userMap["contacts"].keys) {
        // print("key: $key");
        // print(userMap["contacts"][key]);
        List<Object?> contacts = userMap["contacts"][key];
        for (Map<Object?, Object?> contact
            in contacts.cast<Map<Object?, Object?>>()) {
          // print(contact);
          contactUids.add(contact["uid"] as String);

          Singleton().uidToName[contact["uid"] as String] =
              contact["name"] as String;
        }
      }
    }
    return contactUids;
  }

  List<Widget> getIntegratedNotifications(Set<String> contactUids) {
    List<Widget> notificationWidgets = [];

    Singleton _singleton = Singleton();

    // Check if any of the contacts are in danger by going to users/uid/notifications
    for (String uid in contactUids) {
      print("Getting info for $uid");
      FirebaseDatabase.instance
          .ref("users/$uid/notifications")
          .once()
          .then((snapshot) {
        if (snapshot.snapshot.value != null) {
          Map<String, dynamic> notifications =
              (snapshot.snapshot.value as Map<Object?, Object?>)
                  .cast<String, dynamic>();

          notificationWidgets.add(IntegratedNotificationCard(
            name: Singleton().uidToName[uid] as String,
            latitude: notifications["latitude"] * 1.0,
            longitude: notifications["longitude"] * 1.0,
            message: notifications["message"],
            timestamp: notifications["time"],
          ));

          // print(notifications.keys);
          // for (String key in notifications.keys) {
          //   print("NOTIFICATION: $notifications");

          //   if (notifications["alcohol_detected"] == "danger") {
          //     print("DANGER: ${notifications['alcohol_detected']}");

          //     // Send a notification to the user
          //     // FirebaseMessaging.instance.send(
          //     //   RemoteMessage(
          //     //     data: {
          //     //       'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          //     //       'id': '1',
          //     //       'status': 'done',
          //     //     },
          //     //     notification: RemoteNotification(
          //     //       title: 'Emergency',
          //     //       body: 'Your friend is in danger!',
          //     //     ),
          //     //     to: '/topics/$uid',
          //     //   ),
          //     // );
          //   }
          // }
        }
      });
    }

    _singleton.notifyAllListeners();

    return notificationWidgets;
  }
}
