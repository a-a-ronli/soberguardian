import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Auth {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  Future register(email, password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Updating database
    final ref = FirebaseDatabase.instance.ref("users");
    await ref.update({
      FirebaseAuth.instance.currentUser?.uid as String: {
        'pt': {
          '1': '',
          '2': '',
          '3': '',
          '4': '',
          '5': '',
        },
        'contacts': {
          'emergency': '911',
        },
        'alcohol_detected': false,
      }
    });
    return null;
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    return null;
  }
}
