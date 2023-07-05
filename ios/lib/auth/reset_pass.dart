import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens_auth/signin.dart';

Future<void> resetPassword(BuildContext context, GlobalKey<FormState> formKey, TextEditingController emailController) async {
  // validate the form
  if (formKey.currentState!.validate()) {
    try {

      // send the reset password email to the user's email
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      // show a dialog box to inform the user that the password reset email has been sent
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Password Reset'),
            content: Text('Password reset email has been sent.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK', style: TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      // show a dialog box if there was an error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                child: Text('OK', style: TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.of(context).pop(); // close the dialog box
                },
              ),
            ],
          );
        },
      );
    }
  }
}
