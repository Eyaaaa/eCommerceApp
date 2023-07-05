import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../controller/profileController.dart';
import 'edit_private_info.dart';
import 'edit_profile.dart';

class ProfilePage extends GetView<ProfileController> {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

   controller.onReady();
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.nameController.text,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        controller.emailController.text,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        controller.phoneController.text,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),





                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    width: 100, // Adjust the width to your desired size
                    height: 100, // Adjust the height to your desired size
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent, // Set the background color to transparent
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: controller.profileImage,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover, // Scale and crop the image to fit within the circle
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),





          Expanded(
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    InkWell(
                      onTap: () {
                        // Handle onTap event
                      },
                      child: ListTile(
                        title: Text(
                          'My orders',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: Icon(Icons.shopping_basket),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Handle onTap event
                      },
                      child: ListTile(
                        title: Text(
                          'Pending notes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: Icon(Icons.note_alt_rounded),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Handle onTap event
                      },
                      child: ListTile(
                        title: Text(
                          'Recently viewed',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: Icon(Icons.watch_later_outlined),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Handle onTap event
                      },
                      child: ListTile(
                        title: Text(
                          'Recently searched',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: Icon(Icons.youtube_searched_for_outlined),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Divider(color: Colors.black26),
                    SizedBox(height: 20.0),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditProfileScreen()),
                        );
                      },
                      child: ListTile(
                        title: Text(
                          'Modifier le profil',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: Icon(Icons.edit),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditPrivateInfo()),
                        );
                      },
                      child: ListTile(
                        title: Text(
                          'Edit Private Information',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: Icon(Icons.place),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          onPressed: () async {
                            controller.logout();
                            // Handle logout button press
                          },
                          icon: Icon(Icons.logout, color: Colors.red),
                          label: Text(
                            'Log out',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            // Handle delete account button press
                          },
                          icon: Icon(Icons.delete_forever, color: Colors.blue),
                          label: Text(
                            'Delete Account',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
