import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myfirstapplication/1sqldb.dart';
import 'package:myfirstapplication/api.dart';
import 'package:myfirstapplication/productdetailpage.dart';
import 'package:myfirstapplication/shoppingcart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myfirstapplication/spladh.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:marqueer/marqueer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'AllTrax.dart';

class Product {
  final String name;
  final String imageUrl;
  final String productUrl;
  final String price;

  Product({
    required this.name,
    required this.imageUrl,
    required this.productUrl,
    required this.price,
  });
}

class LocationHandler {
  static Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;


    }
  }
}

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String _currentAddress = "Getting current location...";
  String? _email;
  final List<String> _carausalImages = [
    "assets/backpack.jpg",
    "assets/cotton-t-shirts.jpg",
    "assets/rings.jpg",
    "assets/televisions-1563961481-5013673.jpeg",
  ];
  // Position? _currentPosition;
  late VideoPlayerController _controller;


  }

  Future<void> _loadEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  
    }

      }
    });
  }

  final dbHelper = FirstProjectDB.instance;

  final controller = MarqueerController();
  // final List<Product> _products = [
  //   Product(
  //     name: 'Lays Magic Masala',
  //     price: 'Rs. 30',
  //     imageUrl: 'assets/backpack.jpg',
  //     productUrl:
  //         'https://blinkit.com/prn/lays-indias-magic-masala-potato-chips/prid/240092',
  //   ),
  //   Product(
  //     name: 'Dairy Milk Silk',
  //     price: 'Rs. 50',
  //     imageUrl: 'assets/cotton-t-shirts.jpg',
  //     productUrl:
  //         'https://blinkit.com/prn/cadbury-dairy-milk-silk-roast-almond-chocolate-bar-58-g/prid/403491',
  //   ),
  //   Product(
  //     name: 'Pomegranate',
  //     price: 'Rs. 25',
  //     imageUrl: 'assets/rings.jpg',
  //     productUrl: 'https://blinkit.com/prn/pomegranate/prid/321169',
  //   ),
  //   Product(
  //     name: 'Cucumber',
  //     price: 'Rs. 25',
  //     imageUrl: 'assets/televisions-1563961481-5013673.jpeg',
  //     productUrl: 'https://blinkit.com/prn/green-cucumber-kheera/prid/351666',
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    var response;

    return Scaffold(
      appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: (Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, user!",
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                  selectionColor: Colors.black,
                ),
                Text(
                  _currentAddress,
                  style: const TextStyle(
                      fontSize: 19.5, fontWeight: FontWeight.w100),
                  selectionColor: Color.fromARGB(255, 44, 43, 43),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            )),
          ),
          backgroundColor: Color.fromARGB(255, 248, 203, 70),
          toolbarHeight: 120,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  size: 25,
                )),
            IconButton(
              icon: const Icon(
                Icons.logout,
                size: 25,
              ),
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                prefs.setBool("login", false);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SplashView()));
              },
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Shoppingcart()));
                },
                icon: Icon(Icons.shopping_cart_outlined))
          ]),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical space to fit everything.
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Explore',
                style: TextStyle(fontSize: 30),
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 248, 203, 70),
              ),
            ),
            ListTile(
              title: Text('Profile', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.pop(context);
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return DraggableScrollableSheet(
                          expand: false,
                          builder: (context, ScrollController) {
                            return Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Text(
                                      'Profile',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    _email != null
                                        ? Text(
                                            'Email Id: $_email',
                                            style: TextStyle(fontSize: 18),
                                          )
                                        : CircularProgressIndicator(),
                                  ],
                                ));
                          });
                    });
              },
            ),
            //creating another title in drawer
            ListTile(
                title: Text("All Transactions", style: TextStyle(fontSize: 20)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllTransactions()));
                }),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/gradient.png'), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 230,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 247, 200, 61),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 180),
                child: Container(
                  color: Color.fromARGB(255, 252, 250, 250),
                  height: MediaQuery.of(context).size.height,
                  child: Marqueer(
                    child: Text(
                      'UPCOMING SALE!  ',
                      style: TextStyle(
                        color: Color.fromARGB(255, 228, 3, 3),
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlay: true,
                onPageChanged: (index, reason) {},
              ),
              items: _carausalImages.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                      ),
                      child: Image.asset(
                        item,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "All Items-",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    height: 250,
                    child: FutureBuilder(
                        future: fetchUser(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: Text("Loading..."));
                          }
                          List dta = snapshot.data as List;

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: dta.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: GestureDetector(
                                        onTap: () async {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  Productdetailpage(
                                                      data: dta[index]));
                                        },
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: 170,
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  border: Border.all()),
                                              child: SingleChildScrollView(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors
                                                                  .grey))),
                                                  padding: EdgeInsets.fromLTRB(
                                                      8, 8, 8, 8),
                                                  child: Column(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.network(
                                                          dta[index]['image']
                                                              .toString(),
                                                          height: 85,
                                                          width: 100,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        dta[index]['title']
                                                            .toString(),
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                            'Rs ${dta[index]['price'].toString()}',
                                                            maxLines: 1,
                                                          )),
                                                          Expanded(
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child:
                                                                    ElevatedButton(
                                                                        onPressed:
                                                                            () async {
                                                                          await dbHelper
                                                                              .insert({
                                                                            FirstProjectDB.columnItemname:
                                                                                dta[index]['title'].toString(),
                                                                            FirstProjectDB.columnQty:
                                                                                "1",
                                                                            FirstProjectDB.columnAmt:
                                                                                dta[index]['price'].toString(),
                                                                            FirstProjectDB.columnProdId:
                                                                                dta[index]['id'].toString()
                                                                          });
                                                                          Fluttertoast.showToast(
                                                                              msg: "${dta[index]['title']} added to cart!",
                                                                              toastLength: Toast.LENGTH_SHORT,
                                                                              gravity: ToastGravity.BOTTOM,
                                                                              backgroundColor: Colors.green,
                                                                              textColor: Colors.white);

                                                                          print(
                                                                              await dbHelper.queryAllRows());
                                                                        },
                                                                        child: Icon(Icons
                                                                            .add_shopping_cart),
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              Colors.green[400],
                                                                          iconColor:
                                                                              Colors.white,
                                                                        ))),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                  Icons.satellite_alt_outlined),
                                            )
                                          ],
                                        )));
                              });
                        })),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 150,
                width: 400,
                child: Image(image: AssetImage("assets/sale.gif")),
              ),
            ),
// for electronics
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Electronics-",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    height: 250,
                    child: FutureBuilder(
                        future: fetchUserelectronics(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: Text("Loading..."));
                          }
                          List dta = snapshot.data as List;

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: dta.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: GestureDetector(
                                        onTap: () async {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  Productdetailpage(
                                                      data: dta[index]));
                                        },
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: 170,
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  border: Border.all()),
                                              child: SingleChildScrollView(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors
                                                                  .grey))),
                                                  padding: EdgeInsets.fromLTRB(
                                                      8, 8, 8, 8),
                                                  child: Column(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.network(
                                                          dta[index]['image']
                                                              .toString(),
                                                          height: 85,
                                                          width: 100,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        dta[index]['title']
                                                            .toString(),
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                            'Rs ${dta[index]['price'].toString()}',
                                                            maxLines: 1,
                                                          )),
                                                          Expanded(
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child:
                                                                    ElevatedButton(
                                                                        onPressed:
                                                                            () async {
                                                                          await dbHelper
                                                                              .insert({
                                                                            FirstProjectDB.columnItemname:
                                                                                dta[index]['title'].toString(),
                                                                            FirstProjectDB.columnQty:
                                                                                "1",
                                                                            FirstProjectDB.columnAmt:
                                                                                dta[index]['price'].toString(),
                                                                            FirstProjectDB.columnProdId:
                                                                                dta[index]['id'].toString()
                                                                          });
                                                                          Fluttertoast.showToast(
                                                                              msg: "${dta[index]['title']} added to cart!",
                                                                              toastLength: Toast.LENGTH_SHORT,
                                                                              gravity: ToastGravity.BOTTOM,
                                                                              backgroundColor: Colors.green,
                                                                              textColor: Colors.white);

                                                                          print(
                                                                              await dbHelper.queryAllRows());
                                                                        },
                                                                        child: Icon(Icons
                                                                            .add_shopping_cart),
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              Colors.green[400],
                                                                          iconColor:
                                                                              Colors.white,
                                                                        ))),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                  Icons.satellite_alt_outlined),
                                            )
                                          ],
                                        )));
                              });
                        })),
              ],
            ),
            //for jewelery
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Jewelery-",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    height: 250,
                    child: FutureBuilder(
                        future: fetchUserjewelery(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: Text("Loading..."));
                          }
                          List dta = snapshot.data as List;

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: dta.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: GestureDetector(
                                        onTap: () async {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  Productdetailpage(
                                                      data: dta[index]));
                                        },
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: 170,
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  border: Border.all()),
                                              child: SingleChildScrollView(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors
                                                                  .grey))),
                                                  padding: EdgeInsets.fromLTRB(
                                                      8, 8, 8, 8),
                                                  child: Column(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.network(
                                                          dta[index]['image']
                                                              .toString(),
                                                          height: 85,
                                                          width: 100,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        dta[index]['title']
                                                            .toString(),
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                            'Rs ${dta[index]['price'].toString()}',
                                                            maxLines: 1,
                                                          )),
                                                          Expanded(
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child:
                                                                    ElevatedButton(
                                                                        onPressed:
                                                                            () async {
                                                                          await dbHelper
                                                                              .insert({
                                                                            FirstProjectDB.columnItemname:
                                                                                dta[index]['title'].toString(),
                                                                            FirstProjectDB.columnQty:
                                                                                "1",
                                                                            FirstProjectDB.columnAmt:
                                                                                dta[index]['price'].toString(),
                                                                            FirstProjectDB.columnProdId:
                                                                                dta[index]['id'].toString()
                                                                          });
                                                                          Fluttertoast.showToast(
                                                                              msg: "${dta[index]['title']} added to cart!",
                                                                              toastLength: Toast.LENGTH_SHORT,
                                                                              gravity: ToastGravity.BOTTOM,
                                                                              backgroundColor: Colors.green,
                                                                              textColor: Colors.white);

                                                                          print(
                                                                              await dbHelper.queryAllRows());
                                                                        },
                                                                        child: Icon(Icons
                                                                            .add_shopping_cart),
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              Colors.green[400],
                                                                          iconColor:
                                                                              Colors.white,
                                                                        ))),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                  Icons.satellite_alt_outlined),
                                            )
                                          ],
                                        )));
                              });
                        })),
              ],
            ),
//for mens clothing
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Men's Clothing-",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    height: 250,
                    child: FutureBuilder(
                        future: fetchUsermensclothing(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: Text("Loading..."));
                          }
                          List dta = snapshot.data as List;

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: dta.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: GestureDetector(
                                        onTap: () async {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  Productdetailpage(
                                                      data: dta[index]));
                                        },
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: 170,
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  border: Border.all()),
                                              child: SingleChildScrollView(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors
                                                                  .grey))),
                                                  padding: EdgeInsets.fromLTRB(
                                                      8, 8, 8, 8),
                                                  child: Column(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.network(
                                                          dta[index]['image']
                                                              .toString(),
                                                          height: 85,
                                                          width: 100,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        dta[index]['title']
                                                            .toString(),
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                            'Rs ${dta[index]['price'].toString()}',
                                                            maxLines: 1,
                                                          )),
                                                          Expanded(
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child:
                                                                    ElevatedButton(
                                                                        onPressed:
                                                                            () async {
                                                                          await dbHelper
                                                                              .insert({
                                                                            FirstProjectDB.columnItemname:
                                                                                dta[index]['title'].toString(),
                                                                            FirstProjectDB.columnQty:
                                                                                "1",
                                                                            FirstProjectDB.columnAmt:
                                                                                dta[index]['price'].toString(),
                                                                            FirstProjectDB.columnProdId:
                                                                                dta[index]['id'].toString()
                                                                          });
                                                                          Fluttertoast.showToast(
                                                                              msg: "${dta[index]['title']} added to cart!",
                                                                              toastLength: Toast.LENGTH_SHORT,
                                                                              gravity: ToastGravity.BOTTOM,
                                                                              backgroundColor: Colors.green,
                                                                              textColor: Colors.white);

                                                                          print(
                                                                              await dbHelper.queryAllRows());
                                                                        },
                                                                        child: Icon(Icons
                                                                            .add_shopping_cart),
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              Colors.green[400],
                                                                          iconColor:
                                                                              Colors.white,
                                                                        ))),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                  Icons.satellite_alt_outlined),
                                            )
                                          ],
                                        )));
                              });
                        })),
              ],
            ),
            // for womens clothing
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Women's Clothing-",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    height: 250,
                    child: FutureBuilder(
                        future: fetchUserwomensclothing(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: Text("Loading..."));
                          }
                          List dta = snapshot.data as List;

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: dta.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: GestureDetector(
                                        onTap: () async {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  Productdetailpage(
                                                      data: dta[index]));
                                        },
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: 170,
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  border: Border.all()),
                                              child: SingleChildScrollView(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors
                                                                  .grey))),
                                                  padding: EdgeInsets.fromLTRB(
                                                      8, 8, 8, 8),
                                                  child: Column(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.network(
                                                          dta[index]['image']
                                                              .toString(),
                                                          height: 85,
                                                          width: 100,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        dta[index]['title']
                                                            .toString(),
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                            'Rs ${dta[index]['price'].toString()}',
                                                            maxLines: 1,
                                                          )),
                                                          Expanded(
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child:
                                                                    ElevatedButton(
                                                                        onPressed:
                                                                            () async {
                                                                          await dbHelper
                                                                              .insert({
                                                                            FirstProjectDB.columnItemname:
                                                                                dta[index]['title'].toString(),
                                                                            FirstProjectDB.columnQty:
                                                                                "1",
                                                                            FirstProjectDB.columnAmt:
                                                                                dta[index]['price'].toString(),
                                                                            FirstProjectDB.columnProdId:
                                                                                dta[index]['id'].toString()
                                                                          });
                                                                          Fluttertoast.showToast(
                                                                              msg: "${dta[index]['title']} added to cart!",
                                                                              toastLength: Toast.LENGTH_SHORT,
                                                                              gravity: ToastGravity.BOTTOM,
                                                                              backgroundColor: Colors.green,
                                                                              textColor: Colors.white);

                                                                          print(
                                                                              await dbHelper.queryAllRows());
                                                                        },
                                                                        child: Icon(Icons
                                                                            .add_shopping_cart),
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              Colors.green[400],
                                                                          iconColor:
                                                                              Colors.white,
                                                                        ))),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                  Icons.satellite_alt_outlined),
                                            )
                                          ],
                                        )));
                              });
                        })),
              ],
            ),
            //add any more category here if required
          ]),
        ),
      ),
    );
  }
}
