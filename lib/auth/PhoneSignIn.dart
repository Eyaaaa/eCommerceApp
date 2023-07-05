import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens_auth/otpVerifPage.dart';


class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _verificationId = '';

  Future<User?> signUpWithPhone(
      BuildContext context, String phoneNumber) async {


    Completer<User?> completer = Completer<User?>();

    try {
      // Send a verification code to the user's phone number
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Sign in the user with the verification credential
          UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
          User? user = userCredential.user;
          if (user != null) {
            // Add user data to Firestore
            await _firestore.collection('users').doc(user.uid).set({

              'phoneNumber': phoneNumber,
            });
            completer.complete(user);

            // Navigate to the next screen

          }
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure
          print("failed");

          print(e);
          completer.complete(null);
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OTPVerificationPage(verificationId:_verificationId ,)),
          );
          // Save the verification ID for later use

        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print(e);
      completer.complete(null);
    }

    return completer.future;
  }
}
