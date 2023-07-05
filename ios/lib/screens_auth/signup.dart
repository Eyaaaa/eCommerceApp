import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ecommerce_app1/auth/emailSignUp.dart';
import 'package:ecommerce_app1/auth/facebookSignIn.dart';
import 'package:ecommerce_app1/auth/googleSignIn.dart';
import 'package:ecommerce_app1/screens_auth/signOut.dart';
import 'package:ecommerce_app1/screens_auth/sigupPhone.dart';
import 'package:http/http.dart' as http;
import '../config/settings.dart';
import 'signin.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  final firebaseUid = FirebaseAuth.instance.currentUser?.uid;
  AuthService get authService => AuthService();
  User? user = FirebaseAuth.instance.currentUser;

  Map<String, dynamic> _settings = {};
  final Uri url = Uri.parse('http://10.0.2.2:8000/api/users/');

  @override
  void initState() {
    super.initState();
    loadSettings().then((settings) {
      setState(() {
        _settings = settings;
      });
    });

  }
  Future<void> registerUser() async {

    String? firebaseToken = await user?.getIdToken();
    print('$firebaseToken');
    // Create a JSON data
    Map<String, dynamic> data = {
      "firebase_uid": firebaseUid,
      "nom": _nameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "confirm_password": _confirmPasswordController.text,
    };
    try{

      final response = await http.post(
        url,
        body: data,

        headers: {'Authorization': 'Bearer $firebaseToken'},
      ).timeout( Duration(seconds: 90))
          . then((value) => {

        print('modeluser=======> $data')});
      print('++++++++++++++++++++++++++++++++++++++$response');
    }
    catch(e){
      print('error============> $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: _settings.containsKey('backgroundColor')
          ? Color(int.parse(_settings['backgroundColor'].replaceAll("#", "0xFF")))
          : Colors.white,


      body: Padding(

        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(

              //-----------logo---------
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                // Bouton de la flèche dans le coin supérieur gauche
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_sharp),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                SizedBox(height:10.0 ),

                if (_settings.containsKey('logo'))
                  Image.asset(
                    _settings['logo'],
                    width: 150,
                    height: 130,
                  ),


                SizedBox(height:10.0 ),


                // --------create an account-----------
                Text(

                  'Create an Account',
                  style: TextStyle(
                    color: _settings.containsKey('text_color')
                        ? Color(int.parse(_settings['text_color'].replaceAll("#", "0xFF")))
                        : Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),


                //-----------Name textFormField-----------------------------------------------------
                SizedBox(height:10.0 ),
                Container(

                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "Full name",
                      prefixIcon: Icon(Icons.person, color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),


                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return ' Please enter your name !';
                      }
                    },

                  ),
                ),
                SizedBox(height:10.0 ),

//--------------------Email textFormField---------------------------------


                Container(

                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email ",
                      prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),


                    validator: (value) {
                      // validate email
                      if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value!)) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },

                  ),
                ),

                //-----------Password TextFormField--------------------------------------

                SizedBox(height:10.0 ),
                Container(

                    child: TextFormField(
                      obscureText: !_isPasswordVisible,
                      controller: _passwordController,
                      decoration: InputDecoration(
                       hintText: 'Password',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        prefixIcon: Icon(Icons.lock_outline, color: Colors.grey,),
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

                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }

                        // add more conditions as needed
                        return null;
                      },

                    )
                ),


                //-------------confirm password-----------------------------------

                SizedBox(height:10.0 ),
                Container(

                  child: TextFormField(
                    obscureText: !_isPasswordVisible,
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      prefixIcon:Icon(Icons.lock_outline,color: Colors.grey,),



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
                      if (value != null && value.isNotEmpty && value == _passwordController.text) {
                        return null;
                      } else {
                        return 'Passwords do not match !';
                      }
                    },

                  ),
                ),

                //-------------------------------


//-------------------signup button----------------------------------
                SizedBox(height:15.0 ),
                Padding(
                  padding:
                  const EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 8.0),
                  child: Material(
                      borderRadius: BorderRadius.circular(13.0),


                      color : _settings.containsKey('buttonColor')
                          ? Color(int.parse(_settings['buttonColor'].replaceAll("#", "0xFF")))
                          : Colors.white,

                      elevation: 0.0,
                      child: MaterialButton(

                        //
                        onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final result = await authService.signUpWithEmail(
                          _emailController.text, _passwordController.text,
                          _confirmPasswordController.text, _nameController.text,
                          context);
                      registerUser();

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

  //-------------------------Or---------------


                SizedBox(height: 8),
                Text("OR"),
                SizedBox(height: 6),



                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[




                  ],
                ),
//----------------------------
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0,4.0),
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

         //----------------------Google login -------------


                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 4.0),
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
                                fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),


//*--------------------------facebook login -----------------
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 4.0),
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


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(1,10, 1, 8),
                      child:
                      Text(

                        "Already a member?",
                        style: TextStyle(  color: _settings.containsKey('text_color')
                            ? Color(int.parse(_settings['text_color'].replaceAll("#", "0xFF")))
                            : Colors.white,fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5,10, 10, 8),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()
                              )
                          );
                        },
                        child:

                        Text(

                          "Login!",
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
      ),


    );
  }
}




