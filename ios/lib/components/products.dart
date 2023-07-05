import 'package:flutter/material.dart';

import '../pages/product_details.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    {
      "name": "Name",
      "picture": "assets/images/hand.jpg",

      "price": 85 ,
    },
    {
      "name": "Name",
      "picture": "assets/images/hand.jpg",

      "price": 85,
    },
    {
      "name": "Name",
      "picture": "assets/images/hand.jpg",

      "price": 85,
    },
    {
      "name": "Name",
      "picture": "assets/images/hand.jpg",

      "price": 85,
    },
    {
      "name": "Name",
      "picture": "assets/images/hand.jpg",

      "price": 85,
    },
    {
      "name": "Name",
      "picture": "assets/images/hand.jpg",

      "price": 50,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Single_prod(
            prod_name: product_list[index]['name'],
            prod_pricture: product_list[index]['picture'],
            prod_price: product_list[index]['price'],
          );
        });
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_pricture;

  final prod_price;

  Single_prod({
    this.prod_name,
    this.prod_pricture,

    this.prod_price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: prod_name,
          child: Material(
            child: InkWell(

              //appel de product details
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                // passing the values of the product of the product details
                  builder: (context)=> new ProductDetails(
                    product_detail_name: prod_name,
                    product_detail_price: prod_price,
                    product_detail_picture: prod_pricture,
                  ))),



              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(
                        prod_name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                    //    "\$$prod_price",
                         "$prod_price\d",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w800),
                      ),

                    ),
                  ),
                  child: Image.asset(
                    prod_pricture,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}