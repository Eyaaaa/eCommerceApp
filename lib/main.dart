import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:ecommerce_app1/pages/searchproducts.dart';
import 'package:ecommerce_app1/profile/profile_page.dart';
import 'package:ecommerce_app1/screens_auth/signin.dart';
import 'package:ecommerce_app1/screens_auth/signup_selection_page.dart';
import 'package:ecommerce_app1/screens_auth/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app1/components/horizontal_listview.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'components/products.dart';
import 'config/binding.dart';
import 'controller/productController.dart';
import 'data/models/product_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialBinding: AllBindings(),
    home: SplashScreen(),
    getPages: [
      GetPage(name: '/main', page: () => HomePage(), binding: AllBindings()),
      GetPage(name: '/login', page: () => LoginPage()),
    ],
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



// Carousel
  Widget image_carousel = Container(
    height: 200.0,
    child: Carousel(
      boxFit: BoxFit.cover,
      images: [
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







  bool _showSearchBar = false;
  final TextEditingController _searchController = TextEditingController();
  List<Product> filteredProducts = [];

  ProductController productController = Get.put(ProductController()); // Create an instance of ProductController

  @override
  void initState() {
    super.initState();
    filteredProducts = productController.products; // Use the products list from the ProductController
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredProducts = productController.products;
      });
    } else {
      setState(() {
        productController.searchProducts(query);
        filteredProducts = productController.searchResults;
        Get.to(ProductListPage(products: filteredProducts));
      });
    }
  }

  void confirmSearch() {
    String query = _searchController.text.trim();
    if (query.isNotEmpty) {
      searchProducts(query);
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: _showSearchBar
            ? TextField(
          controller: _searchController,
          onChanged: (query) {
            // Update the search query in real-time
            setState(() {});
          },
          onSubmitted: (query) {
            // Confirm the search when the user submits the query
            confirmSearch();
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        )
            : Center(child: Text('Name')),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                _showSearchBar = !_showSearchBar;
                if (!_showSearchBar) {
                  _searchController.clear();
                  searchProducts(''); // Reset the search results
                }
              });
            },
            icon: _showSearchBar ? Icon(Icons.close) : Icon(Icons.search),
            color: Colors.white,
          ),
          IconButton(
            onPressed: confirmSearch,
            icon: Icon(Icons.shopping_cart),
            color: Colors.white,
          ),
        ],
      ),



      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Eya Yousfi'),
              accountEmail: Text('eya.yousfi@esprit.tn'),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            SizedBox(height: 20.0),
            InkWell(
              onTap: () {
                // Handle onTap event
              },
              child: ListTile(
                title: Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Icon(Icons.menu_open),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            SizedBox(height: 20.0),
            Divider(
              color: Colors.black87,
            ),
            SizedBox(height: 20.0),
            InkWell(
              onTap: () {
                // Handle onTap event
              },
              child: ListTile(
                title: Text(
                  'Languages',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Icon(Icons.public),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            InkWell(
              onTap: () {
                // Handle onTap event
              },
              child: ListTile(
                title: Text(
                  'Settings',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Icon(Icons.settings),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            InkWell(
              onTap: () {
                // Handle onTap event
              },
              child: ListTile(
                title: Text(
                  'About',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Icon(Icons.help, color: Colors.blue),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            SizedBox(height: 20.0),
            Divider(
              color: Colors.black26,
            ),
            SizedBox(height: 20.0),
            InkWell(
              onTap: () {
                // Handle onTap event
              },
              child: ListTile(
                title: Text(
                  'Terms and conditions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Icon(Icons.assignment),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            InkWell(
              onTap: () {
                // Handle onTap event
              },
              child: ListTile(
                title: Text(
                  'Privacy policy',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Icon(Icons.privacy_tip),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),


      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            image_carousel,
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            HorizontalListPage(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Recent products',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Container(
              height: 320.0,
              child: Products(),
            ),
          ],
        ),
      ),






      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.home_outlined,
                  color: Colors.red,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  color: Colors.red,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.person_2_outlined,
                  color: Colors.red,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectionPage(),
                    ),
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
