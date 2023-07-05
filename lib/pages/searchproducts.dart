// Import necessary packages and files

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/product_model.dart';


class ProductListPage extends StatelessWidget {
  final List<Product> products;

  ProductListPage({required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          Product product = products[index];
          return ListTile(
            title: Text(product.nom_produit),
            subtitle: Text(product.description_produit),
            // Add any other product details you want to display
          );
        },
      ),
    );
  }
}
