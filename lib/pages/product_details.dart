import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../controller/productController.dart';
import '../data/models/product_model.dart';

class ProductDetails extends GetView<ProductController> {
  final String productId;

  ProductDetails({required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: Center(child: Text('Name')),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.search), color: Colors.white),
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart), color: Colors.white),
        ],
      ),
      body: FutureBuilder<Product>(
        future:  fetchProductDetails(productId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final product = snapshot.data!;

            return ListView(
              children: [
                Container(
                  height: 285.0,
                  child: GridTile(
                    child: Container(
                      color: Colors.white,
                      child: Image.asset(product.image_produit),
                    ),
                    footer: Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: Text(
                          product.nom_produit,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                          textAlign: TextAlign.start,
                        ),
                        title: Text(
                          "${product.prix_avant_remise}\d",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),





                Row(
                  children:  [




                    //============size===========
                    Expanded(child: MaterialButton(
                      onPressed: () {
                        showDialog(context: context, builder: (context){
                          return new AlertDialog(
                            title: new Text("Size") ,
                            content: new Text("Choose the size"),
                            actions: [
                              new MaterialButton(onPressed: (){
                                Navigator.of(context).pop(context);
                              },
                                child: new Text("Close"),)
                            ],
                          );
                        }
                        );
                      },
                      color: Colors.white,
                      textColor: Colors.black,
                      child:
                      Row(
                        children: [
                          Expanded(child: new Text("Size")
                          ),
                          Expanded(child: new Icon((Icons.arrow_drop_down))
                          ),
                        ],
                      ),

                    )
                    ),

                    //========color=====================


                    Expanded(child: MaterialButton(
                      onPressed: () {
                        showDialog(context: context, builder: (context){
                          return new AlertDialog(
                            title: new Text("Colors") ,
                            content: new Text("Choose a color"),
                            actions: [
                              new MaterialButton(onPressed: (){
                                Navigator.of(context).pop(context);
                              },
                                child: new Text("Close"),)
                            ],
                          );
                        }
                        );
                      },
                      color: Colors.white,
                      textColor: Colors.black,
                      child:
                      Row(
                        children: [
                          Expanded(child: new Text("Color")
                          ),
                          Expanded(child: new Icon((Icons.arrow_drop_down))
                          ),
                        ],
                      ),

                    )
                    ) ,

//========================= Qty =======================
                    Expanded(child: MaterialButton( onPressed: () {
                      showDialog(context: context, builder: (context){
                        return new AlertDialog(
                          title: new Text("Quantity") ,
                          content: new Text("Choose  the Quantity"),
                          actions: [
                            new MaterialButton(onPressed: (){
                              Navigator.of(context).pop(context);
                            },
                              child: new Text("Close"),)
                          ],
                        );
                      }
                      );
                    },
                      color: Colors.white,
                      textColor: Colors.black,
                      child:
                      Row(
                        children: [
                          Expanded(child: new Text("Qty")
                          ),
                          Expanded(child: new Icon((Icons.arrow_drop_down))
                          ),
                        ],
                      ),

                    )
                    )
                  ],

                ),


                // ===================== second line ==============
                Row(
                  children:  [


                    //============size===========
                    Expanded(child: MaterialButton(onPressed: () {},
                        color: Colors.red,
                        textColor: Colors.white,
                        child:
                        new Text("Buy now")

                    )
                    ),

                    //========color=====================
                    new IconButton(onPressed:(){} , icon :Icon(Icons.add_shopping_cart,color: Colors.red,)),
                    new IconButton(onPressed:(){} , icon :Icon(Icons.favorite_border, color: Colors.red,))



                  ],

                ),

                Divider(color: Colors.red,) ,
                new ListTile(
                  title: new Text("Product Details",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                  subtitle: new Text( product.description_produit,),
                )




          // Rest of the code...
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }














  Future<Product> fetchProductDetails(String productId) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/products/$productId/');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return Product.fromJson(data);
      } else {
        throw Exception('Failed to fetch product details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}