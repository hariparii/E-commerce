import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myfirstapplication/ItemList.dart';
import 'package:myfirstapplication/homepage.dart';
import 'package:myfirstapplication/1sqldbTran.dart';

class AllTransactions extends StatefulWidget {
  const AllTransactions({super.key});

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  final dbHelperTrax = FirstProjectDBTrax.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Transactions",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 248, 203, 70),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Homepage()));
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/gradient.png'), fit: BoxFit.cover)),
        child: FutureBuilder(
          future: dbHelperTrax.queryAllRows(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
              return Center(child: Text("No Transactions Found"));
            } else {
              List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(
                  snapshot.data as List<Map<String, dynamic>>);
              data.sort((a, b) => DateTime.parse(b['_orderDate'])
                  .compareTo(DateTime.parse(a['_orderDate'])));

              return Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 18),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 216, 213, 213),
                          border: Border(
                              bottom: BorderSide(color: Colors.grey))),
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Serial No.",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Payment ID",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Order Date & Time",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Items",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: data.map((e) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailedTrax(item: e),
      ),
    );
                              // Handle tap, e.g., show details
                              print(e["_itemsList"]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              padding: EdgeInsets.fromLTRB(8, 18, 8, 8),
                              child: Row(
                                children: [
                                  Expanded(child: Text(e['_id'].toString())),
                                  Expanded(child: Text(e['_paymentId'].toString())),
                                  Expanded(flex: 2, child: Text(e['_orderDate'])),
                                  Expanded(child: Text(e['_itemsList'].toString().length.toString())),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
