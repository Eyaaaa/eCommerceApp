import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens_auth/congrats.dart';

Future<void> verifyOTP(BuildContext context, GlobalKey<FormState> formKey, String otp, String verificationId) async {
  if (formKey.currentState!.validate()) {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      // User successfully verified OTP
      // Navigate to next page

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CongratsPage()),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'invalid-verification-code') {
        // Invalid OTP entered
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Invalid OTP'),
        ));
      }
    }
  }
}
