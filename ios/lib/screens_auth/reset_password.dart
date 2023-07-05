
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../auth/PhoneSignIn.dart';
import '../auth/reset_pass.dart';

import '../config/settings.dart';


class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}
// initialize necessary variables and controllers
class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  AuthService get authService => AuthService();
  Map<String, dynamic> _settings = {};

  // load the settings from the local storage and set the state
  @override
  void initState() {
    super.initState();
    loadSettings().then((settings) {
      setState(() {
        _settings = settings;
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // set the background color of the page
      backgroundColor: _settings.containsKey('backgroundColor')
          ? Color(int.parse(_settings['backgroundColor'].replaceAll("#", "0xFF")))
          : Colors.white,



      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(

            children: <Widget>[

              //arrox back
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_sharp),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              SizedBox(height:160.0 ),


              Text(

                'Please Enter Your Email Address\n      to Reset Your Password',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: _settings.containsKey('text_color')
                      ? Color(int.parse(_settings['text_color'].replaceAll("#", "0xFF")))
                      : Colors.white,
                ),
              ),

              //PHonetextfield
              SizedBox(height:50.0 ),

              TextFormField(

                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined, color: Colors.grey,),),

                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email.';

                  }
                  return null;
                },
              ),


              Padding(
                padding:
                const EdgeInsets.fromLTRB(5.0, 50.0, 5.0, 8.0),
                child: Material(
                    borderRadius: BorderRadius.circular(13.0),
                 // set button color
                    color : _settings.containsKey('buttonColor')
                        ? Color(int.parse(_settings['buttonColor'].replaceAll("#", "0xFF")))
                        : Colors.white,

                    elevation: 0.0,
                    child: MaterialButton(
                      // Call the resetPassword function to reset the user's password
                      onPressed: () async {
                        await resetPassword(context, _formKey, _emailController);
                      },

                        minWidth: MediaQuery.of(context).size.width,
                      child: Text(
                        "Reset Password",


                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    )
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
