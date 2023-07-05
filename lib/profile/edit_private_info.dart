
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controller/profileController.dart';

class EditPrivateInfo extends GetView<ProfileController> {
  RxBool showConfirmPassword = false.obs;
  RxBool showPassword = false.obs;

  @override
  Widget build(BuildContext context) {
    controller.getUserData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Edit Private Information',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              TextField(
                controller: controller.emailController,
                onChanged: (value) async {
                  print('****************************************update');
                  // await user?.updateDisplayName(emailController.text);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: Colors.grey),
                ),
              ),
              SizedBox(height: 17),
              TextField(
                controller: controller.phoneController,
                onChanged: (value) async {
                  print('****************************************update');
                  //await user?.updateDisplayName(phoneController.text);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone, color: Colors.grey),
                ),
              ),


              SizedBox(height: 17),
              Obx(
                    () => TextField(
                  controller: controller.passwordController,
                  onChanged: (value) async {
                    await controller.user?.updatePassword(controller.passwordController.text);
                    showConfirmPassword.value = true;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.password, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword.value ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        showPassword.value = !showPassword.value;
                      },
                    ),
                  ),
                  obscureText: !showPassword.value, // Toggle obscureText based on showPassword value
                ),
              ),
              Obx(() {
                if (showConfirmPassword.value) {
                  return TextField(
                    controller: controller.confirmPasswordController,
                    onChanged: (value) async {

                    },
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.password, color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: Icon(
                          showPassword.value ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          showPassword.value = !showPassword.value;
                        },
                      ),
                    ),
                    obscureText: !showPassword.value, // Toggle obscureText based on showPassword value
                  );
                } else {
                  return SizedBox();
                }
              }),
              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 50.0, 5.0, 8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(13.0),
                  color: Colors.red,
                  elevation: 0.0,
                  child: MaterialButton(
                    onPressed: () {
                      if (validatePasswords()) {
                        controller.updatePrivateInfo();
                        showToast('Update successful', Colors.green);
                        print('save-------------------->');
                      } else {
                        showToast('Password and Confirm Password do not match', Colors.red);
                        print('Password and Confirm Password do not match');
                      }
                    },
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text(
                      "Save",
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
            ],
          ),
        ),
      ),
    );
  }

  bool validatePasswords() {
    final password = controller.passwordController.text;
    final confirmPassword = controller.confirmPasswordController.text;
    return password == confirmPassword;
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
