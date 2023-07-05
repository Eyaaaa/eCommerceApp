
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;


Future<UserCredential?> signInWithGoogle() async {
  // Trigger the Google Sign-In flow.
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

  // If the user didn't select an account, return null.
  if (googleUser == null) {
    return null;
  }

  // Sign out of the current account.
  await _googleSignIn.signOut();

  // Allow the user to select a Google account to sign in with.
  final GoogleSignInAccount? selectedGoogleUser = await _googleSignIn.signIn();

  // If the user didn't select an account, return null.
  if (selectedGoogleUser == null) {
    return null;
  }

  // Obtain the auth details from the request.
  final GoogleSignInAuthentication googleAuth =
  await selectedGoogleUser.authentication;

  // Create a new credential.
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Sign in to Firebase with the Google credential.
  return await _auth.signInWithCredential(credential);
}

