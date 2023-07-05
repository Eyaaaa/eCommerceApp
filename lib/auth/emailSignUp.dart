import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens_auth/LinkVerifPage.dart';



class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthService() {
    // listen for changes in the authentication state of the user
    _firebaseAuth.userChanges().listen((user) async {
      if (user != null && user.emailVerified) {
        await updateEmailVerificationStatus(user.uid);
      }
    });
  }

  Future<User?> signUpWithEmail(String email, String password, String confirmPassword, String name, BuildContext context) async {
    if (password != confirmPassword) {
      return null;
    }
    try {
      final UserCredential userCredential =
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        // add user data to firestore
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'isEmailVerified': false,// add a field to indicate if email is verified
          'role': 'consommateur',
        });
        await sendVerificationEmail(email); // send verification email
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VerificationPage()),
        ); // navigate to verification screen
        return user;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
// Function to send a verification email to a given email address
  Future<void> sendVerificationEmail(String email) async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    }
  }

  Future<bool> isEmailVerified() async {
    User? user = _firebaseAuth.currentUser;
    // reload the user data to get the latest email verification status
    await user?.reload();
    return user?.emailVerified ?? false;
  }

  Future<void> updateEmailVerificationStatus(String userId) async {
    // update the `isEmailVerified` field in Firestore

    await _firestore.collection('users').doc(userId).update({

      'isEmailVerified': true,

    });

  }
}
