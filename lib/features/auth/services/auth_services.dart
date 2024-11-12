import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static Future<void> signup(String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }
}
