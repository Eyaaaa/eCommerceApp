import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/productController.dart';
import '../data/models/product_model.dart';
import '../pages/product_details.dart';

class Products extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
          () => GridView.builder(
        itemCount: controller.products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          final Product product = controller.products[index];
          return SingleProd(
            prodId: product.id.toString(), // Convert id to String
            prodName: product.nom_produit,
            prodPicture: product.image_produit,
            prodPrice: product.prix_avant_remise,
          );
        },
      ),
    );
  }
}

class SingleProd extends StatelessWidget {
  final String prodId;
  final String prodName;
  final String prodPicture;
  final double prodPrice;

  SingleProd({
    required this.prodId,
    required this.prodName,
    required this.prodPicture,
    required this.prodPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: prodId,
        child: Material(
          child: InkWell(
            onTap: () {
              Get.to(() => ProductDetails(productId: prodId));
            },
            child: GridTile(
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    prodName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  title: Text(
                    "\$$prodPrice",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              child: Image.network(
                prodPicture,
                fit: BoxFit.cover,
                height: 150,
                width: 150,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
