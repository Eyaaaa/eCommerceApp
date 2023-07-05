import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../auth/PhoneSignIn.dart';
import '../config/settings.dart';



class SignupPhonePage extends StatefulWidget {
  @override
  _SignupPhonePageState createState() => _SignupPhonePageState();
}

class _SignupPhonePageState extends State<SignupPhonePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  Map<String, dynamic> _settings = {};



  Future<User?> _signUp() async {
    setState(() {

    });

    // Get the user's phone number from the input field
    String phoneNumber = _phoneNumberController.text;

    User? user = await AuthService().signUpWithPhone(context, phoneNumber);

    setState(() {
    });

    if (user != null) {

    }

    return user;
  }





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
   //background color
      backgroundColor: _settings.containsKey('backgroundColor')
          ? Color(int.parse(_settings['backgroundColor'].replaceAll("#", "0xFF")))
          : Colors.white,

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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

                  'Please Enter Your Phone Number',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    //text color
                    color: _settings.containsKey('text_color')
                        ? Color(int.parse(_settings['text_color'].replaceAll("#", "0xFF")))
                        : Colors.white,
                  ),
                ),

                //PHonetextfield

                SizedBox(height:50.0 ),
                Container(

                  child: TextFormField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Enter phone number",
                      prefixIcon: Icon(Icons.phone, color: Colors.grey,),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number.';
                      } else if (!RegExp(r'^[+0-9]{10,13}$').hasMatch(value)) {
                        return 'Please enter a valid phone number.';
                      }
                      return null;
                    },
                  ),
                ),

                //signUp Button
                SizedBox(height:60.0 ),
                Padding(
                  padding:
                  const EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 8.0),
                  child: Material(
                      borderRadius: BorderRadius.circular(13.0),
                     //button color
                      color : _settings.containsKey('buttonColor')
                          ? Color(int.parse(_settings['buttonColor'].replaceAll("#", "0xFF")))
                          : Colors.white,

                      elevation: 0.0,
                      child: MaterialButton(
                        onPressed: () async {
                          //Call the signup function if the form is validated
                          if (_formKey.currentState!.validate()) {
                          await _signUp();
                          }
                        },

                        minWidth: MediaQuery.of(context).size.width,
                        child: Text(
                          "Signup",
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
      ),
    );
  }
}




