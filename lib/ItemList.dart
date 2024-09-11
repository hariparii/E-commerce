import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myfirstapplication/AllTrax.dart';
import 'package:myfirstapplication/1sqldbTran.dart';
import 'package:myfirstapplication/api.dart';

class DetailedTrax extends StatefulWidget {
  final Map<String, dynamic> item;

  const DetailedTrax({Key? key, required this.item}) : super(key: key);

  @override
  State<DetailedTrax> createState() => _DetailedTraxState();
}

class _DetailedTraxState extends State<DetailedTrax> {
  get dta => null;

  // final dbHelper = FirstProjectDBTrax.instance;
  // late Future<List<ProductItem>> futureItems;

  // @override
  // void initState() {
  //   super.initState();
  //   futureItems = fetchItems();
  // }

  // Future<List<ProductItem>> fetchItems() async {

  //   final response = await dbHelper.queryAllRows();
  //   return List<ProductItem>.from(
  //       response.map((item) => ProductItem.fromJson(item)));
  // }

  @override
  Widget build(BuildContext context) {
    double total = 0.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transaction Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 248, 203, 70),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AllTransactions()),
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/gradient.png'), fit: BoxFit.cover)),
        child: FutureBuilder(
          future: fetchUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            List purchaseItems = widget.item['_itemsList']
                .toString()
                .split(",")
                .toSet()
                .toList();
            print(purchaseItems);
            List data = snapshot.data as List;
            List list = data
                .where(
                  (element) => purchaseItems.contains(element['id'].toString()),
                )
                .toSet()
                .toList();

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text("Image",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20))),
                      Expanded(
                          flex: 1,
                          child: Text("Item",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20))),
                      Expanded(
                          child: Text("Price",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20))),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final item = list[index];

                        // total = total+( ((double.tryParse(item['price'].toString()) ??
                        //         0.0) *
                        //     (double.tryParse(item['quantity'].toString()) ??
                        //         0.0)));
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        item['image'].toString(),
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(item['title'].toString()),
                                )),
                                Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          "\Rs.${item['price'].toString()}",textAlign: TextAlign.right,),
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Total Items: ${widget.item['_itemsList'].length}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            // Text(
            //   "Total Price: \Rs. ${total.toStringAsFixed(2)}",
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            // )
          ],
        ),
      ),
    );
  }
}

class ProductItem {
  final String id;
  final String name;
  final double price;

  ProductItem({required this.id, required this.name, required this.price});

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
        id: json['id'].toString(),
        name: json['name'],
        price: json['price'] != null
            ? double.tryParse(json['price'].toString()) ?? 0.0
            : 0.0);
  }
}
