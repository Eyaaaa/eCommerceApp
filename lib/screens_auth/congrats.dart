import 'dart:async'; // import the async library

import 'package:flutter/material.dart'; // import the Material Design framework
import 'package:flutter/services.dart'; // import services for accessing platform channels

import 'package:ecommerce_app1/screens_auth/signin.dart'; // import the signin screen
import '../config/settings.dart'; // import the settings file

class CongratsPage extends StatefulWidget { // define a new StatefulWidget called CongratsPage
  @override
  _CongratsPageState createState() => _CongratsPageState(); // create a new instance of the _CongratsPageState stateful widget
}

class _CongratsPageState extends State<CongratsPage> { // define the _CongratsPageState stateful widget

  Map<String, dynamic> _settings = {}; // initialize an empty map for settings

  @override
  void initState() { // define the initState method
    super.initState(); // call the initState method of the parent class

    loadSettings().then((settings) { // load the settings
      setState(() {
        _settings = settings; // set the settings state
      });
    });

    //Display the congrats page for 3 seconds, then navigate to the next screen
    Timer(Duration(seconds: 3), () { // set a timer for 3 seconds
      Navigator.of(context).pushReplacement( // navigate to the login screen

        MaterialPageRoute(
          builder: (context) => LoginPage (), // create an instance of the LoginPage class
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) { // define the build method for the CongratsPage widget
    return MaterialApp( // return a new MaterialApp widget
      debugShowCheckedModeBanner: false, // hide the debug banner
      home: Scaffold( // create a new Scaffold widget
        backgroundColor: _settings.containsKey('backgroundColor')
            ? Color(int.parse(_settings['backgroundColor'].replaceAll("#", "0xFF"))) // set the background color
            : Colors.white, // set the default background color to white
        body: Center( // center the contents of the page
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 150), // add an empty space with a height of 150

                if (_settings.containsKey('congrats_page_img')) // check if an image for the congratulations page is set in the settings
                  Image.asset(
                    _settings['congrats_page_img'], // display the image
                    width: 150,
                    height: 130,
                  ),

                SizedBox(height: 20), // add an empty space with a height of 20

                Text(
                  'Congratulations', // display the congratulations message
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),

                ),
                SizedBox(height: 25), // add an empty space with a height of 25

                Text(
                  'Your account has been verified', // display the account verification message

                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color:_settings.containsKey('congrats_page_txt')
                        ? Color(int.parse(_settings['congrats_page_txt'].replaceAll("#", "0xFF")))
                        : Colors.white, // set the text color to white if no text color is specified in the settings
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
