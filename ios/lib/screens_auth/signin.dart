
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ecommerce_app1/screens_auth/reset_password.dart';
import 'package:ecommerce_app1/screens_auth/signOut.dart';
import 'package:ecommerce_app1/screens_auth/signup.dart';
import 'package:ecommerce_app1/screens_auth/sigupPhone.dart';

import '../auth/emailSignIn.dart';
import '../auth/facebookSignIn.dart';
import '../auth/googleSignIn.dart';

import '../profile/profile_page.dart';
import '../config/settings.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  late SharedPreferences _prefs;
  bool _rememberMe = false;
  bool _isPasswordVisible = false;
  late final _emailController = TextEditingController();
  late final _passwordController = TextEditingController();

  User? userObject = FirebaseAuth.instance.currentUser;

  Map<String, dynamic> _settings = {};


  @override
  void initState() {
    super.initState();
    _initPrefs();
    loadSettings().then((settings) {
      setState(() {
        _settings = settings;
      });
    });
  }



  void _signInWithEmailAndPassword() async {
    // validate the form
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential? userCredential = await signInWithEmail(
          _emailController.text,
          _passwordController.text,
        );

        if (userCredential != null) {
          // Navigate to the next screen
          Navigator.push(
            context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
           // MaterialPageRoute(builder: (context) => HomePage2(user: userCredential.user)),
          );
        }
      } on FirebaseAuthException catch (e) {

        // Handle authentication error
        print('error');
        _showErrorSnackBar('Invalid email or password');
      }
    }
  }


  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }





  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      //set the _rememberMe variable to the value stored with the key 'rememberMe'
      _rememberMe = _prefs.getBool('rememberMe') ?? false;
    });

    if (_rememberMe) {
      //get the email and password
      _emailController.text = _prefs.getString('username') ?? '';
      _passwordController.text = _prefs.getString('password') ?? '';
    }
  }

  Future<void> _setRememberMe(bool value) async {
    await _prefs.setBool('rememberMe', value);
  }


  void _onRememberMeChanged(bool? newValue) {

    setState(() {
      _rememberMe = newValue ?? false;
      _setRememberMe(_rememberMe);
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

                // arrow_back
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_sharp),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),

                SizedBox(height:10.0 ),
             //logo
                if (_settings.containsKey('logo'))
                  Image.asset(
                    _settings['logo'],
                    width: 150,
                    height: 130,
                  ),

                SizedBox(height:10.0 ),

                Text(

                  'Login to Your Account',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,

                    //text color

                    color: _settings.containsKey('text_color')
                      ? Color(int.parse(_settings['text_color'].replaceAll("#", "0xFF")))
                      : Colors.white,

                ),
                ),

                SizedBox(height:20.0 ),

                //Email TextFormField

                Container(

                  child: TextFormField(
                    controller: _emailController,

                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),

                    // A validator function to check if the email address is valid
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email address cannot be empty.';
                      }
                      if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value)) {
                        return 'Wrong or invalid email address. Please correct and try again.';
                      }
                      return null;
                    },


                  ),
                ),


                //password TextFormField

                SizedBox(height:10.0 ),
                Container(

                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline , color: Colors.grey,),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }

                      // add more conditions as needed
                      return null;
                    },

                  ),
                ),


                SizedBox(height: 10.0 ),
                //Remember me checkbox

                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _rememberMe,
                      onChanged: _onRememberMeChanged,
                    ),
                    Text('Remember Me',  style: TextStyle(

                      fontWeight: FontWeight.bold,
                      //text color
                      color: _settings.containsKey('text_color')
                          ? Color(int.parse(_settings['text_color'].replaceAll("#", "0xFF")))
                          : Colors.white,

                    ),),
                  ],
                ),

                //signin button
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(13.0),
                   color : _settings.containsKey('buttonColor')
                      ? Color(int.parse(_settings['buttonColor'].replaceAll("#", "0xFF")))
                      : Colors.white,

                    elevation: 0.0,
                    child: MaterialButton(
                      onPressed: () async {
                        // Check if rememberMe checkbox is selected
                        if (_rememberMe) {
                          // Store username and password in SharedPreferences
                          await _prefs.setString('username', _emailController.text);
                          await _prefs.setString('password', _passwordController.text);
                        }
                        // Call _signInWithEmailAndPassword method to sign in the user
                        _signInWithEmailAndPassword();
                      },
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.fromLTRB(200, 5, 10, 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetPasswordPage()
                              )
                          );
                        },
                        child:

                        Text(

                          "Forgot password?",
                          style: TextStyle( color: _settings.containsKey('text_color')
                              ? Color(int.parse(_settings['text_color'].replaceAll("#", "0xFF")))
                              : Colors.white,),
                        ),


                      ),
                    )


                  ],
                ),

                // or
                SizedBox(height: 5),
                Text("OR"),
                SizedBox(height: 5),
                //Signin with phone button
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(7.0),

                    color : _settings.containsKey('phone_btn_Color')
                        ? Color(int.parse(_settings['phone_btn_Color'].replaceAll("#", "0xFF")))
                        : Colors.white,


                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: ()  {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupPhonePage()
                            )
                        );
                      },

                      minWidth: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/phonee.jpg',
                            height: 28.0,
                            width: 28.0,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 13.0),
                          Text(
                            "          Login with Phone number ",
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.normal,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),



                //google login button


                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(7.0),
                    color : _settings.containsKey('google_btn_Color')
                        ? Color(int.parse(_settings['google_btn_Color'].replaceAll("#", "0xFF")))
                        : Colors.white,

                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async {
                        UserCredential? userCredential = await signInWithGoogle();
                        if (userCredential != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage2(user: userCredential.user)),
                          );
                        } else {
                          print('no');

                          // Display an error message or perform any other action here
                        }
                      },

                      minWidth: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/google.png',
                            height: 28.0,
                            width: 28.0,
                            fit: BoxFit.cover,
                          ),


                          SizedBox(width: 10.0),
                          Text(
                            "          Login with Google ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //Facebook login button
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Material(

                    borderRadius: BorderRadius.circular(7.0),
                    color : _settings.containsKey('fb_btn_Color')
                        ? Color(int.parse(_settings['fb_btn_Color'].replaceAll("#", "0xFF")))
                        : Colors.white,

                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async {

                        await  signInWithFacebook() ;
                      },
                      minWidth: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/facebook.png',
                            height: 30.0,
                            width: 30.0,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            "          Login with Facebook ",
                            style: TextStyle(
                                color: Colors.white,

                                fontWeight: FontWeight.normal,
                                fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //dont have an account text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(1,10, 1, 20),
                      child:
                      Text(

                        "Don't have an account? Click here to",
                        style: TextStyle(  color: _settings.containsKey('text_color')
                            ? Color(int.parse(_settings['text_color'].replaceAll("#", "0xFF")))
                            : Colors.white,fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5,10, 10, 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()
                              )
                          );
                        },
                        child:

                        Text(

                          "Signup !",
                          style: TextStyle(color: Colors.red,fontSize: 15),
                        ),

                      ),
                    )

                  ],
                ),

              ],
            ),
          ),
        ),
      ),);
  }


}
