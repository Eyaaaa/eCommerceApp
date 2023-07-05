
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ecommerce_app1/screens_auth/signin.dart';
import '../config/settings.dart';


class SelectionPage extends StatefulWidget {
  @override
  _SelectionPageState createState() => _SelectionPageState();
}


class _SelectionPageState extends State<SelectionPage> {

  // A map to store app settings
  Map<String, dynamic> _settings = {};

  // A lifecycle method called when the widget is first inserted into the widget tree
  @override
  void initState() {
    super.initState();

    // Load the app settings from a file
    loadSettings().then((settings) {
      setState(() {
        _settings = settings; // Update the settings map
      });
    });
  }

  // A method to build the widget tree for the selection page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // Check if a background image is specified in the settings
          image: _settings.containsKey('role_background_img')
              ? DecorationImage(
            // Load the image from the asset folder
            image: AssetImage(_settings['role_background_img']),
            fit: BoxFit.cover,
          )
              : null,
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                const EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 8.0),
                child: Material(
                    borderRadius: BorderRadius.circular(13.0),
                    // Check if a button color is specified in the settings
                    color : _settings.containsKey('buttonColor')
                    // Convert the color code to a color object
                        ? Color(int.parse(_settings['buttonColor'].replaceAll("#", "0xFF")))
                        : Colors.white, // Use a default color
                    elevation: 0.0,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              // Navigate to the login page when the button is pressed
                                builder: (context) => LoginPage()
                            )
                        );
                      },
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text(
                        "Shop now",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    )
                ),
              ),

              SizedBox(height: 20),

              Padding(
                padding:
                const EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 8.0),
                child: Material(
                    borderRadius: BorderRadius.circular(13.0),
                    // Check if a button color is specified in the settings
                    color : _settings.containsKey('buttonColor')
                    // Convert the color code to a color object
                        ? Color(int.parse(_settings['buttonColor'].replaceAll("#", "0xFF")))
                        : Colors.white, // Use a default color
                    elevation: 0.0,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              // Navigate to the login page when the button is pressed
                                builder: (context) => LoginPage()
                            )
                        );
                      },
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text(
                        "Join as a vendor",
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
