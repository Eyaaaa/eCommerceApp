import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<UserCredential> signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();

  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

  // Once signed in, return the UserCredential
  final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  final user = userCredential.user;

  // Add the user to Firestore
  final firestoreInstance = FirebaseFirestore.instance;
  await firestoreInstance.collection("users").doc(user!.uid).set({
    "name": user!.displayName,
    "email": user!.email,

  });

  return userCredential;
}
