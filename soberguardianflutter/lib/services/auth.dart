import 'package:firebase_auth/firebase_auth.dart';

class Auth {
    final userStream = FirebaseAuth.instance.authStateChanges();
    final user = FirebaseAuth.instance.currentUser;

    Future logout() async {
        await FirebaseAuth.instance.signOut();
        return null;
    }
}