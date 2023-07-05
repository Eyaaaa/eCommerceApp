
import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:ecommerce_app1/profile/profile_page.dart';

import 'package:ecommerce_app1/screens_auth/signup_selection_page.dart';
import 'package:ecommerce_app1/screens_auth/splash.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app1/components/horizontal_listview.dart';
import 'components/products.dart';




Future<void> main() async {

  //initialize WidgetsFlutterBinding
  WidgetsFlutterBinding.ensureInitialized();

  //initialize firebase
  await Firebase.initializeApp() ;
  runApp(

  MaterialApp(

    //disable the debug banner
    debugShowCheckedModeBanner: false ,
    //splashscreen
    home:SplashScreen(),

    routes: {
      '/main': (context) => HomePage(),
    },
  ));
}


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    //carousel
    Widget image_carousel=  Container(
      height: 200.0,
      child: Carousel(
        boxFit:BoxFit.cover,
        images:[
          AssetImage('assets/images/hand.jpg'),
          AssetImage('assets/images/hand.jpg'),
          AssetImage('assets/images/hand.jpg'),
          AssetImage('assets/images/hand.jpg'),
          AssetImage('assets/images/hand.jpg'),
          AssetImage('assets/images/hand.jpg'),

        ],
        autoplay: false,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 8.0,
      ),
    );

    return Scaffold(
      //appBar
      appBar: new AppBar(
        elevation: 0.1,
       backgroundColor: Colors.red,

        //title

        title: Center(child: Text('Name')),
        actions: <Widget>[
          new IconButton(onPressed: (){}, icon: Icon(Icons.search),color: Colors.white,),
          new IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart),color: Colors.white,)

        ],
           ),

      //drawer

      drawer: new Drawer(
        child: new ListView(
          children:<Widget> [

            new UserAccountsDrawerHeader(accountName: Text('Eya Yousfi'),
                accountEmail:Text('eya.yousfi@esprit.tn'),
               currentAccountPicture: GestureDetector(
               child: new CircleAvatar(
               backgroundColor: Colors.grey,
               child: Icon(Icons.person,color: Colors.white,),
              ),
            ),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
//     ---------------  body  ---------------------------------------------
            SizedBox(height:20.0 ),


            InkWell(
              onTap: (){
                // Handle onTap event
              },
              child : ListTile(
                title: Text('Categories',
                    style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Icon(Icons.menu_open),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),

            SizedBox(height:20.0 ),
//languages
            Divider(color: Colors.black87,),
            SizedBox(height:20.0 ),
            InkWell(
              onTap: (){
                // Handle onTap event
              },
              child : ListTile(
                title: Text('Languages',
                  style: TextStyle(fontWeight: FontWeight.bold),),
                leading: Icon(Icons.public),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
//settings
            InkWell(
              onTap: (){
                // Handle onTap event
              },
              child : ListTile(
                title: Text('Settings',
                  style: TextStyle(fontWeight: FontWeight.bold),),
                leading: Icon(Icons.settings),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
//about
            InkWell(
              onTap: (){
                // Handle onTap event
              },
              child : ListTile(
                title: Text('About',
                  style: TextStyle(fontWeight: FontWeight.bold),),
                leading: Icon(Icons.help, color: Colors.blue),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),


            SizedBox(height:20.0 ),
            Divider(color: Colors.black26,),
            SizedBox(height:20.0 ),
            InkWell(
              onTap: (){
                // Handle onTap event
              },
              child : ListTile(
                title: Text('Terms and conditions',
                  style: TextStyle(fontWeight: FontWeight.bold),),
                leading: Icon(Icons.assignment),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
//settings
            InkWell(
              onTap: (){
                // Handle onTap event
              },
              child : ListTile(
                title: Text('Privacy policy',
                  style: TextStyle(fontWeight: FontWeight.bold),),
                leading: Icon(Icons.privacy_tip),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),


          ],
        ),

      ),



      body: ListView(
  children:<Widget>[


    image_carousel,


    new Padding(
      padding:const EdgeInsets.all(10.0),
      child:new Text(
        'Categories',
        style: new TextStyle(
            fontSize: 20.0
        ),
      ),
    ),


    // ---------------- horizontal list of categories
  HorizontalListPage(),

    //---padding widget to add extra space arround the text

    new Padding(padding: const EdgeInsets.all(10.0),
      child: new Text('Recent products',style: new TextStyle(
          fontSize: 20.0
      ),),),





    //grid view
    Container(
      height: 320.0,
      child: Products(),
    )

  ],
),


      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home_outlined,color: Colors.red,),
                onPressed: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      )
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.favorite_border,color: Colors.red,),
                onPressed: () {


                },
              ),
              IconButton(
                icon: Icon(Icons.notifications_none ,color: Colors.red,),
                onPressed: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>   ProfilePage()
                      )
                  );
                  //
                },
              ),
              IconButton(
                icon: Icon(Icons.person_2_outlined ,color: Colors.red,),
                onPressed: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectionPage()
                      )
                  );

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

