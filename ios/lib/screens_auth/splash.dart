import 'package:flutter/material.dart';

import 'package:ecommerce_app1/main.dart';
import'package:ecommerce_app1/config/settings.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
Map<String, dynamic> _settings = {};

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // Wait for 3 seconds before navigating to the home page
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    });

    loadSettings().then((settings) {
      setState(() {
        _settings = settings;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color
      backgroundColor: _settings.containsKey('backgroundColor')
          ? Color(int.parse(_settings['backgroundColor'].replaceAll("#", "0xFF")))
          : Colors.white,

      body: Container(
        width: double.infinity,

        // Logo and progress indicator

        child: Column(
          children: [
            Column(
              children: [
                SizedBox(height:180.0 ),

                if (_settings.containsKey('logo'))
                  Image.asset(
                    _settings['logo'],
                    width: 150,
                    height: 150,
                  ),

                SizedBox(height:200.0 ),
              ],
            ),
            // Circular progress indicator
            CircularProgressIndicator(
              valueColor:  AlwaysStoppedAnimation<Color>(_settings.containsKey('CircularProgressIndicator')
                  ? Color(int.parse(_settings['CircularProgressIndicator'].replaceAll("#", "0xFF")))
                  : Colors.white,),
            ),
          ],
        ),
      ),
    );
  }
}
