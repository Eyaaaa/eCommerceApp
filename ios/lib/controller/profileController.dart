import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_app1/config/app_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
class ProfileController extends GetxController{
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;
  final id = FirebaseAuth.instance.currentUser?.uid;
   final isLoading = false.obs;
  final _picker = ImagePicker();
  File? pickeImage;
  Future<void> pickImage() async {
    final pickedImage = await _picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      pickeImage = File(pickedImage.path);
    }
    update();
  }
  Future<void> getUserData() async {
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
            phoneController.text = data['numero_telephone'];
            nameController.text = data['nom'];
           imageController.text= data['image'];
        } else {
          print('Failed to fetch user data. Status code: ${response.statusCode}');
        isLoading.value = false;
        }
      } catch (e) {
        print('Error: $e');
        isLoading.value = false;
      }
    } else {
      print('Token is null');
    }
    update();
  }
  /*********update email, phone , password*************/
  Future<void> updatePrivateInfo() async {
    final firebaseUid = FirebaseAuth.instance.currentUser?.uid;
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    final url = Uri.parse('${ApiApp.userlUrl}$id/');
    if (token != null && firebaseUid != null) {
      final data = {
        "numero_telephone": phoneController.text,
        "email": emailController.text,
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
        } else {
          print('Failed to update user. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    } else {
      print('Token or Firebase UID is null');
    }
    update();
  }
  /********update data*************/
  Future<void> updateUser() async {
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
        final request = http.MultipartRequest('PUT', url)
          ..headers['Authorization'] = 'Bearer $token'
          ..fields.addAll(data);
        if (pickeImage != null) {
          request.files.add(
            await http.MultipartFile.fromPath('image', pickeImage!.path),
          );
        }

        final response = await request.send().timeout(Duration(seconds: 90));

        if (response.statusCode == 200) {

            print( 'Changes saved successfully');
            isLoading.value = false; // Hide loading indicator

          print('User updated successfully');
          print('---------------------------------$firebaseUid');
        } else {
         print('Failed to save changes. Please try again.');
            isLoading.value = false; // Hide loading indicator
          print('Failed to update user. Status code: ${response.statusCode}');
        }
      } catch (e) {
      print( 'An error occurred. Please try again.');
          isLoading.value = false; // Hide loading indicator
        print('Error: $e');
      }
    } else {
      print('Token or Firebase UID is null');
    }
    update();
  }

}