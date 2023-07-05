// Import the necessary packages for testing the Google Sign-In functionality using mocks.
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:test/test.dart';

// The entry point of the test file.
void main() {
  // Declare a variable to hold an instance of the MockGoogleSignIn class.
  late MockGoogleSignIn googleSignIn;
  // Set up the mock instance before each test is run.
  setUp(() {
    googleSignIn = MockGoogleSignIn();
  });

  // Test that the signIn method returns valid idToken and accessToken objects.
  test('should return idToken and accessToken when authenticating', () async {
    final signInAccount = await googleSignIn.signIn();
    final signInAuthentication = await signInAccount!.authentication;
    expect(signInAuthentication, isNotNull);
    expect(googleSignIn.currentUser, isNotNull);
    expect(signInAuthentication.accessToken, isNotNull);
    expect(signInAuthentication.idToken, isNotNull);
  });

  // Test that the signIn method returns null when the user cancels the login process.
  test('should return null when google login is cancelled by the user',
          () async {
        googleSignIn.setIsCancelled(true);
        final signInAccount = await googleSignIn.signIn();
        expect(signInAccount, isNull);
      });

  // Test the signIn method twice in the same test, once when cancelled and once when not cancelled.
  test('testing google login twice, once cancelled, once not cancelled at the same test.', () async {
    googleSignIn.setIsCancelled(true);
    final signInAccount = await googleSignIn.signIn();
    expect(signInAccount, isNull);
    googleSignIn.setIsCancelled(false);
    final signInAccountSecondAttempt = await googleSignIn.signIn();
    expect(signInAccountSecondAttempt, isNotNull);
  });
}
