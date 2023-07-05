import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../data/models/category_model.dart';
import '../data/models/product_model.dart';

class ProductController extends GetxController {
  final List<Category> categories = <Category>[].obs;
  final List<Product> products = <Product>[].obs;

  final TextEditingController searchController = TextEditingController();
  final RxList<Product> searchResults = RxList<Product>();
  final RxBool showSearchBar = false.obs;



  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchProducts();
  }

  Future<void> fetchCategories() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/categorie-list/');

    try {
      // Sending an asynchronous HTTP GET request
      final response = await http.get(url);

      // Checking if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Decoding the response body from JSON to a List<dynamic>
        final data = jsonDecode(response.body) as List<dynamic>;

        // Mapping the category data to Category objects using a factory method
        final List<Category> fetchedCategories = data
            .map((categoryData) => Category.fromJson(categoryData))
            .toList();

        // Assigning the fetched categories to the 'categories' list
        categories.assignAll(fetchedCategories);
      } else {
        // Printing an error message if the request was unsuccessful
        print('Failed to fetch categories. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handling any exceptions that might occur during the execution
      print('Error: $e');
    }

  }

  Future<void> fetchProducts() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/products/');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        final List<Product> fetchedProducts = data
            .map((productData) => Product.fromJson(productData))
            .toList();
        products.assignAll(fetchedProducts);
      } else {
        print('Failed to fetch products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> searchProducts(String query) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/products/search/?query=$query');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        final List<Product> searchResultsData = data
            .map((productData) => Product.fromJson(productData))
            .toList();
        searchResults.assignAll(searchResultsData);
      } else {
        print('Failed to search products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
