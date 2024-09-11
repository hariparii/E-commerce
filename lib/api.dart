  import 'dart:convert';

import 'package:http/http.dart' as http;
  
  Future<List> fetchUser() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    var data = json.decode(response.body);

    // print(data[0]['id']);
    return data;

    // if (response.statusCode == 200) {
    //   // If the server returns a 200 OK response, parse the JSON.
    //   print('User data: ${response.body}');
    // } else {
    //   // If the server does not return a 200 OK response, throw an exception.
    //   throw Exception('Failed to load user');
    // }
  }

  Future<List> fetchUserelectronics() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products/category/electronics'));
    var data = json.decode(response.body);
    return data;

   
  }
   Future<List> fetchUserjewelery() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products/category/jewelery'));
    var data = json.decode(response.body);
    return data;
  }
  Future<List> fetchUsermensclothing() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products/category/men\'s clothing'));
    var data = json.decode(response.body);
    return data;
  }
  Future<List> fetchUserwomensclothing() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products/category/women\'s clothing'));
    var data = json.decode(response.body);
    return data;
  }
  