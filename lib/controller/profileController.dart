

import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_app1/config/app_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';



class ProfileController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  final user = FirebaseAuth.instance.currentUser;
  final id = FirebaseAuth.instance.currentUser?.uid;
  final isLoading = false.obs;
  File? image;


  String profileImage = ''; // Declare the profile image variable

  @override
  void onReady() {
    super.onReady();
    getUserData();
  }
  Future<void> getUserData() async {
    print('/*********************get user ***************/');
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    final url = Uri.parse('${ApiApp.userlUrl}$id/');

    if (token != null) {
      try {
        final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $token',
          },
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          emailController.text = data['email'];
          phoneController.text = data['numero_telephone'].toString();
          nameController.text = data['nom'];
          adresseController.text = data['adresse'];
          passwordController.text = data['password'];

          // Retrieve the image URL or image data from the API response
          final imageUrl = data['image']; // Replace 'image' with the actual field name

          if (imageUrl != null) {
            // Set the image URL or image data to the profileImage variable
            profileImage = imageUrl;
          }

          print('password-------------> ${passwordController.text}');
          print('email-------------> ${emailController.text}');
          update(); // Notify the UI that the data has changed
        } else {
          print('Failed to fetch user data. Status code: ${response.statusCode}');
          isLoading.value = false;
        }
      } catch (e) {
        print('Error: $e');
        isLoading.value = false;
      }

      // Fetch the image separately using the token in the headers
      try {
        final imageResponse = await http.get(
          Uri.parse(profileImage),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );
        if (imageResponse.statusCode == 200) {
          // Handle the image response here (e.g., caching, displaying, etc.)
          print('Image fetched successfully');
          print(profileImage);
        } else {
          print('Failed to fetch image. Status code: ${imageResponse.statusCode}');
        }
      } catch (e) {
        print('Error while fetching image: $e');
      }
    } else {
      print('Token is null');
    }
  }

  Future<bool> updatePrivateInfo() async {
    final firebaseUid = FirebaseAuth.instance.currentUser?.uid;
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    final url = Uri.parse('${ApiApp.userlUrl}$id/');
    if (token != null && firebaseUid != null) {
      final data = {
        // "numero_telephone": int.parse(phoneController.text),
        "email": emailController.text,
        "password": passwordController.text,
        "confirm_password": confirmPasswordController.text,
        "numero_telephone": phoneController.text,
        "firebase_uid": firebaseUid,
      };

      try {
        final response = await http.put(
          url,
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ).timeout(Duration(seconds: 90));

        if (response.statusCode == 200) {
          print('User updated successfully');
          print('---------------------------------$firebaseUid');
          return true; // Indicate success
        } else {
          print('Failed to update user. Status code: ${response.statusCode}');
          return false; // Indicate failure
        }
      } catch (e) {
        print('Error: $e');
        return false; // Indicate failure
      }
    }
    return false; // Indicate failure
  }

  Future<bool> updateUser() async {
    final firebaseUid = FirebaseAuth.instance.currentUser?.uid;
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    final url = Uri.parse('${ApiApp.userlUrl}$id/');
    if (token != null && firebaseUid != null) {
      final data = {
        "firebase_uid": firebaseUid,
        "nom": nameController.text,
        "adresse": adresseController.text,
      };

      isLoading.value = true; // Show loading indicator

      try {
        final request = http.MultipartRequest('PUT', url);
        request.headers['Content-Type'] = 'application/json';
        request.headers['Authorization'] = 'Bearer $token';

        if (image != null) {
          final file = await http.MultipartFile.fromPath('image', image!.path);
          request.files.add(file);
        }

        request.fields.addAll(data);

        final response = await request.send();

        if (response.statusCode == 200) {
          print('Changes saved successfully');
          isLoading.value = false; // Hide loading indicator
          update();
          return true; // Indicate success
        } else {
          print('Failed to save changes. Please try again.');
          isLoading.value = false; // Hide loading indicator
          print('Failed to update user. Status code: ${response.statusCode}');
          return false; // Indicate failure
        }
      } catch (e) {
        print('An error occurred. Please try again.');
        isLoading.value = false; // Hide loading indicator
        print('Error: $e');
        return false; // Indicate failure
      }
    } else {
      print('Token or Firebase UID is null');
      return false; // Indicate failure
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      print('Image path: ${image!.path}'); // Check the image file path
      update(); // Notify the UI that the image has changed
    } else {
      print('No image picked');
    }
  }


  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Redirect the user to the login screen or any other desired screen
      // You can use Get.offAllNamed('/login') to navigate to the login screen
    } catch (e) {
      print('Error occurred during logout: $e');
      // Handle any errors that occur during logout
    }
  }

  void showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
