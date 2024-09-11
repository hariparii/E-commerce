import 'package:flutter/material.dart';
import 'package:myfirstapplication/homepage.dart';

class Productdetailpage extends StatefulWidget {
  Map data;
  Productdetailpage({super.key, required this.data});

  @override
  State<Productdetailpage> createState() => _ProductdetailpageState();
}

class _ProductdetailpageState extends State<Productdetailpage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  
                  PopScope(canPop: false,
                    child: GestureDetector(
                        onTap: () {
                          // Handle close button tap here, e.g., navigate back or dismiss a dialog/sheet
                            
                          Navigator.of(context).pop();
                          // Example: Close the current screen
                        },
                        
                        child: Image.asset('assets/close.png', // Replace with your actual asset path
                          width: 30,
                          height:30,
                        )),
                  )
                ],
              ),
              Text(
                widget.data['title'].toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: Image.network(widget.data['image']),
                    ),
                  ),
                
              
              Text('Rs ${widget.data['price'].toString()}',style: TextStyle(fontSize: 20,)),
              Text(widget.data['description'].toString(), style: TextStyle(fontSize: 19),),
              Column(
                children: [
                  Text('Rate: ${widget.data['rating']['rate'].toString()}',style: TextStyle(fontSize: 19, color:Color.fromARGB(255, 84, 80, 71))),
                  
                  Text('Count: ${widget.data['rating']['count'].toString()}',style: TextStyle(fontSize: 19, color:Color.fromARGB(255, 84, 80, 71)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
