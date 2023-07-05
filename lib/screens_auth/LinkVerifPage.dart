import 'dart:async';

import 'package:ecommerce_app1/screens_auth/congrats.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../config/settings.dart';



class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  late Timer timer;
  Map<String, dynamic> _settings = {};

  @override
  void initState() {
    super.initState();
    startTimer();

    loadSettings().then((settings) {
      setState(() {
        _settings = settings;
      });
    });
  }


// start a timer to check email verification every 3 seconds -------
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerification();
    });
  }

  void checkEmailVerification() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      //reload the user data to get the latest email verification status.
      await user.reload();
      // if email is verified navigate to the next screen
      if (user.emailVerified) {
        print('User email verified!');
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CongratsPage()),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: _settings.containsKey('backgroundColor')
          ? Color(int.parse(_settings['backgroundColor'].replaceAll("#", "0xFF")))
          : Colors.white,

      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(



            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_sharp),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              SizedBox(height:30.0 ),

              if (_settings.containsKey('verification_img'))
                Image.asset(
                  _settings['verification_img'],
                  width: 150,
                  height: 130,
                ),
              SizedBox(height: 80.0),
              Text(
                'Verification Email Sent',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: _settings.containsKey('verificationPage_text')
                      ? Color(int.parse(_settings['verificationPage_text'].replaceAll("#", "0xFF")))
                      : Colors.white,
                ),
              ),
              SizedBox(height: 25.0),
              Text(
                'Please check your email for a verification link. Once you have verified your email, you will be able to log in.',
                textAlign: TextAlign.center,
                style: TextStyle(

                  fontWeight: FontWeight.bold,
                  color: _settings.containsKey('verificationPage_text')
                      ? Color(int.parse(_settings['verificationPage_text'].replaceAll("#", "0xFF")))
                      : Colors.white,
                ),
              ),
              SizedBox(height: 40.0),


              TextButton(
                style: TextButton.styleFrom(

                ),
                onPressed: () {
                  FirebaseAuth.instance.currentUser?.sendEmailVerification();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Verification Email Sent'),
                        content: Text('Please check your email for a verification link.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'Resend Verification Email',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 16.0,
                    color: _settings.containsKey('resend_verification_txt_btn')
                        ? Color(int.parse(_settings['resend_verification_txt_btn'].replaceAll("#", "0xFF")))
                        : Colors.white,
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
