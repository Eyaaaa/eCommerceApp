import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../controller/profileController.dart';

class EditProfileScreen extends GetView<ProfileController> {
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
          'Edit Profile',
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
              GestureDetector(
                onTap: () {
                  controller.pickImage();
                },
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: controller.image != null
                        ? Image.file(
                      controller.image!,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                        : Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 80,
                    ),
                  ),
                ),
              ),


              SizedBox(height: 20),
              TextField(
                controller: controller.nameController,
                onChanged: (value) async {
                  // Add your logic here for updating the name
                  print('****************************************update');
                  await controller.user?.updateDisplayName(controller.nameController.text);
                },
                decoration: InputDecoration(
                  // hintText: nameController.text,
                  prefixIcon: Icon(Icons.person, color: Colors.grey),
                ),
              ),
              TextField(
                controller: controller.adresseController,
                onChanged: (value) async {
                  // Add your logic here for updating the address
                  print('update adress');
                  await controller.user?.updateEmail(controller.adresseController.text);
                },
                decoration: InputDecoration(
                  // hintText: nameController.text,
                  prefixIcon: Icon(Icons.location_on, color: Colors.grey),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(13.0),
                  color: Colors.red,
                  elevation: 0.0,
                  child: MaterialButton(
                    onPressed: () {
                      controller.updateUser().then((success) {
                        if (success) {
                          Fluttertoast.showToast(
                            msg: 'Changes saved successfully!',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: 'Failed to save changes. Please try again.',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        }
                      });
                    },
                    minWidth: MediaQuery.of(context).size.width,
                    child: controller.isLoading.value
                        ? CircularProgressIndicator()
                        : Text(
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
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
