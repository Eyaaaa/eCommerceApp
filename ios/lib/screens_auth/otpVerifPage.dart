
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

import '../auth/otp_verification.dart';
import '../auth/resentVerifOtp.dart';

import '../config/settings.dart';

class OTPVerificationPage extends StatefulWidget {
  final String verificationId;

  OTPVerificationPage({required this.verificationId});

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  // The entered OTP
  String _otp = "";
   // An instance of OTPService
  final otpService = OTPService('+21693593768');
  // The key for the verification form
  final _formKey = GlobalKey<FormState>();
  // The settings for the page
  Map<String, dynamic> _settings = {};


  @override
  void initState() {
    super.initState();
    // Load the settings for the page
    loadSettings().then((settings) {
      setState(() {
        _settings = settings;
      });
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      //background color
      backgroundColor: _settings.containsKey('backgroundColor')
          ? Color(int.parse(_settings['backgroundColor'].replaceAll("#", "0xFF")))
          : Colors.white,

      body: Container(
        padding: EdgeInsets.all(16.0),

        child: SingleChildScrollView(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add a back button to the top left corner of the page
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_sharp),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),

              SizedBox(height:10.0 ),


              // Display an image if it's set in the settings
              if (_settings.containsKey('verification_img'))
                Image.asset(
                  _settings['verification_img'],
                  width: 150,
                  height: 130,
                ),

              SizedBox(
                height: 20,
              ),
              Text(
                "Verification Code",
                style: TextStyle(fontSize:28, fontWeight: FontWeight.bold, color : _settings.containsKey('verificationPage_text')
                    ? Color(int.parse(_settings['verificationPage_text'].replaceAll("#", "0xFF")))
                    : Colors.white,),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "We'll send you a One Time \n\nPasscode to your Phone ",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold , color : _settings.containsKey('verificationPage_text')
                    ? Color(int.parse(_settings['verificationPage_text'].replaceAll("#", "0xFF")))
                    : Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(
                height: 30,
              ),
              Text(
                "Please enter the code  ",
                style: TextStyle(
                  fontSize: 16,color : _settings.containsKey('verificationPage_text')
              ? Color(int.parse(_settings['verificationPage_text'].replaceAll("#", "0xFF")))
               : Colors.white,
                ),


                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Pinput(
                  length: 6,
                  // Set the cursor to be visible
                  showCursor: true,
                  // Update the OTP value when the user enters or deletes a digit
                  onChanged: (value) {
                    setState(() {
                      _otp = value;
                    });
                  },
                  onCompleted: (pin) => print(pin),
                ),
              ),
              SizedBox(
                height: 20,
              ),


              // Verify button
              Padding(
                padding:
                const EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 8.0),
                child: Material(
                    borderRadius: BorderRadius.circular(13.0),

                    color : _settings.containsKey('buttonColor')
                        ? Color(int.parse(_settings['buttonColor'].replaceAll("#", "0xFF")))
                        : Colors.white,

                    elevation: 0.0,
                    child: MaterialButton(

                      onPressed: () async {
                        // Call the verifyOTP function when the button is pressed
                        await verifyOTP(context, _formKey, _otp, widget.verificationId);
                      },

                      minWidth: MediaQuery.of(context).size.width,
                      child: Text(
                        "Verify",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    )
                ),
              ),


              SizedBox(height: 30.0,),


              TextButton(
                onPressed: () async {
                  await otpService.resendVerificationCode();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Verification Code Resent"),
                        content: Text("A new verification code has been sent to your phone."),
                        actions: <Widget>[
                          TextButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'Resend Verification Code',
                  style: TextStyle(
                    fontSize: 16.0,
                    decoration: TextDecoration.underline,
                    color : _settings.containsKey('resend_verification_txt_btn')
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