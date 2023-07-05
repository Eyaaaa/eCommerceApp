import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<UserCredential?> signInWithEmail(String email, String password) async {
  try {
    final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final String firebaseToken = await userCredential.user!.getIdToken();
    print('Firebase Auth token: $firebaseToken');

    // Query the `users` collection in Firestore with the user's UID
    final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .get();

    final String name = userSnapshot.get('name'); // Get the user's name from the `name` field in Firestore
    final String role = userSnapshot.get('role');
    print(role);


    return userCredential;
  } on FirebaseAuthException catch (e) {
    throw e;
  }
}
