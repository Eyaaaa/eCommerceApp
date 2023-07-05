import 'package:firebase_auth/firebase_auth.dart';

class OTPService {
  final String phoneNumber;

  // Declare codeSent here
  late PhoneCodeSent codeSent;

  OTPService(this.phoneNumber);

  Future<void> resendVerificationCode() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) {};

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {};

    // Update the existing codeSent instead of declaring a new one
    codeSent = (String verificationId, [int? forceResendingToken]) async {
      await Future.delayed(Duration(seconds: 60));
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: Duration(seconds: 60),
        forceResendingToken: forceResendingToken,
      );
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {};

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent, // Use the existing codeSent
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      timeout: Duration(seconds: 60),
    );
  }
}
