import 'package:flutter/material.dart';

class HorizontalListPage extends StatelessWidget {
  @override



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'assets/images/dress.png',
            image_caption: 'dress',
          ),

          Category(
            image_location: 'assets/images/dress.png',
            image_caption: 'dress',
          ),

          Category(
            image_location: 'assets/images/dress.png',
            image_caption: 'dress',
          ),

          Category(
            image_location: 'assets/images/dress.png',
            image_caption: 'dress',
          ),

          Category(
            image_location: 'assets/images/dress.png',
            image_caption: 'dress',
          ),
        ],
      ),
    );
  }
}
//------class categories ----------
class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({required this.image_location,
    required this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 100.0,
          child: ListTile(
              title: Image.asset(
                image_location,
                width: 90.0,
                height: 55.0,
              ),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(image_caption, style: new TextStyle(fontSize: 17.0),),
              )
          ),
        ),
      ),
    );
  }
}