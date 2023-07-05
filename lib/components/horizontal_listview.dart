import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/productController.dart';

class HorizontalListPage extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: Obx(
        // Obx widget updates the UI whenever the observable value changes
            () => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            // Building each category item based on the category list
            return Category(
              imageCategorie: controller.categories[index].image_categorie,
              nomCategorie: controller.categories[index].nom_categorie,
            );
          },
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String  imageCategorie;
  final String nomCategorie;

  const Category({
    required this. imageCategorie,
    required this.nomCategorie,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          // Callback function for handling category item tap
          // Implement your logic here
        },
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.network(
              imageCategorie,
              width: 90.0,
              height: 55.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(
                nomCategorie,
                style: TextStyle(fontSize: 17.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
