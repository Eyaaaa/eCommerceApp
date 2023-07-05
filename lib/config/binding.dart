import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../controller/productController.dart';
import '../controller/profileController.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() async {

    Get.put<ProfileController>(ProfileController());
    Get.put<ProductController>(ProductController());

  }
}