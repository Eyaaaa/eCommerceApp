import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;



  Future sendVerificationEmail(String email) async {
    User? user = _auth.currentUser;

    if (user == null) {
      return null;
    }

    try {
      await user.sendEmailVerification();
    } catch (e) {
      print('Error sending verification email: $e');
    }
  }
}