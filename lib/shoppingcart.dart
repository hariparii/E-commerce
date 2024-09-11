import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myfirstapplication/1sqldb.dart';
import 'package:myfirstapplication/1sqldbTran.dart';
import 'package:myfirstapplication/homepage.dart';
import 'package:sqflite/sqflite.dart';
import 'product_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Shoppingcart extends StatefulWidget {
  const Shoppingcart({super.key});

  @override
  State<Shoppingcart> createState() => _ShoppingcartState();
}

class _ShoppingcartState extends State<Shoppingcart> {
  final dbHelper = FirstProjectDB.instance;
  final dbHelperTrax = FirstProjectDBTrax.instance;

  final _razorpay = Razorpay();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your cart",
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
      body: FutureBuilder(
        future: dbHelper.queryAllRows(),
        builder: (context, snapshot) {
          List data = snapshot.data as List;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading..."),
            );
          } else if (snapshot.hasError) {
            return Text("Error");
          } else {
            double total = 0;
            //forming the table
            return Container(decoration: BoxDecoration(
                        image: DecorationImage(
              image: AssetImage('assets/gradient.png'), fit: BoxFit.cover)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              "Item",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )),
                        Expanded(
                            child: Text("Qty",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20))),
                        Expanded(
                            child: Text("Amt",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20))),
                        Expanded(
                            child: Text("Delete",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 19,
                                    color: Colors.red))),
                        Expanded(
                            child: Text("Update",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 19,
                                    color: Color.fromARGB(255, 28, 47, 192)))),
                      ],
                    ),
                    //table contents
                    Expanded(
                      child: ListView(
                        children: data.map((e) {
                          print(e.toString());
                          total = total +
                              (double.parse(e['_amt'].toString()) *
                                  double.parse(e['_qty'].toString()));
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: Text(e['_itemname'].toString())),
                                        Expanded(child: Text(e['_qty'].toString())),
                                        Expanded(child: Text(e['_amt'].toString())),
                                        ElevatedButton(
                                          onPressed: () async {
                                            Fluttertoast.showToast(
                                                msg: e['_id'].toString());
                                            await dbHelper
                                                .delete(e['_id'].toString());
                                            setState(() {});
                                          },
                                          child: Icon(Icons.delete),
                                          style: ElevatedButton.styleFrom(
                                            padding:
                                                EdgeInsets.only(left: 2, right: 2),
                                            minimumSize: Size(50, 50),
                                          ),
                                        ),
                                        //adding or removing products
                                        ElevatedButton(
                                          onPressed: () async {
                                            Map<String, dynamic> row = {
                                              FirstProjectDB.columnId:
                                                  e['_id'].toString(),
                                              FirstProjectDB.columnItemname:
                                                  e['_itemname'].toString(),
                                              FirstProjectDB.columnQty:
                                                  (int.parse(e['_qty'].toString()) +
                                                          1)
                                                      .toString(),
                                              FirstProjectDB.columnAmt:
                                                  e['_amt'].toString().toString()
                                            };
                                            print(row.toString());
                                          
                                            await dbHelper.update(row);
                                            Fluttertoast.showToast(
                                                msg: e['_id'].toString());
                                            setState(() {});
                                          },
                                          style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(8),
                                              minimumSize: Size(30, 30)),
                                          child: Text("+"),
                                        ),
                                        ElevatedButton(
                                            onPressed: () async {
                                              int currentQty =
                                                  int.parse(e['_qty'].toString());
                                              if (currentQty > 0) {
                                                Map<String, dynamic> row = {
                                                  FirstProjectDB.columnId:
                                                      e['_id'].toString(),
                                                  FirstProjectDB.columnItemname:
                                                      e['_itemname'].toString(),
                                                  FirstProjectDB
                                                      .columnQty: (int.parse(
                                                              e['_qty'].toString()) -
                                                          1)
                                                      .toString(),
                                                  FirstProjectDB.columnAmt:
                                                      e['_amt'].toString().toString()
                                                };
                                                print(row.toString());
                                          //error message that quantity cannot be less than 0
                                                await dbHelper.update(row);
                                                Fluttertoast.showToast(
                                                    msg: e['_id'].toString());
                                                setState(() {});
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Quantity cannot be less than zero");
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.all(8),
                                                minimumSize: Size(30, 30)),
                                            child: Text("-"))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    //Razor pay 
                    Row(
                      children: [
                        Text(
                          'Total: ${total.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(150, 8, 8, 8),
                          child: ElevatedButton(
                            onPressed: () {
                              _razorpay.open({
                                'key': 'rzp_test_rmwv0ZpcpVrzrz',
                                'amount': 23000,
                                'name': 'Acme Corp.',
                                'description': 'Fine T-Shirt',
                                'prefill': {
                                  'contact': '8888888888',
                                  'email': 'test@razorpay.com'
                                }
                              });
                            },
                            child: Text(
                              "Pay",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Payment Successful!"),
          content: Text(
              "Payment ID: ${response.paymentId}\nTransaction was successful!"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    // Do something when payment succeeds
    
    List itemsList =[];
    await dbHelper.queryAllRows().then((e){
      e.forEach((e1){
itemsList.add(e1['_pid'].toString());
      });
    });


    Map<String, dynamic> paymentData = {
      FirstProjectDBTrax.columnPaymentId: response.paymentId,
      FirstProjectDBTrax.columnOrderDate: DateTime.now().toIso8601String(),
      FirstProjectDBTrax.columnItemsList:
          itemsList.join(",").toString()
    };
    // print(jsonEncode( paymentData));
    await dbHelperTrax.insert(paymentData).then((e) async {
      await dbHelper.deleteAll();
      setState(() {});
    });
   
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Payment Unsuccessful!"),
          content: Text("Transaction was NOT successful!"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
}
