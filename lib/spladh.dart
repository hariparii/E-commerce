// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myfirstapplication/Signup.dart';
import 'package:myfirstapplication/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
  // final TextEditingController _emailController = TextEditingController();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Application'),
        actions: [
          TextButton(
              child: Text('Sign Up'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Signupvie()));
              })
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Center(child: Image.asset('assets/download.jpeg')),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
                Center(
                  child: Text(
                    'Log into your account',
                    style: TextStyle(
                        fontSize: 38.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(padding: const EdgeInsets.all(8.0)),
                Center(
                  child: Text(
                    'Fill in your details in the space given below.',
                    style: TextStyle(
                        fontSize: 18.5, color: Color.fromARGB(206, 14, 14, 14)),
                  ),
                ),
                // Container(height: 50.0, width:250.0 ,color: Color.fromARGB(255, 188, 188, 185),child: Text('Email'),)
                const Padding(padding: EdgeInsets.all(8.0)),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),

                const Padding(padding: EdgeInsets.all(8.0)),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(20.0)),
                Center(
                    child: ElevatedButton(
                  onPressed: () async {
                    final FirebaseAuth _auth = FirebaseAuth.instance;

                    try {
                      UserCredential userCredential =
                          await _auth.signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      if (userCredential.user != null) {
                        print(userCredential.user!.email.toString());
                        prefs.setBool("login", true);
                        prefs.setString(
                            "email", userCredential.user!.email.toString());
                        Navigator.pushAndRemoveUntil<void>
                            // ignore: use_build_context_synchronously
                            (
                          context,
                          MaterialPageRoute(
                              builder: (context) => Homepage()), //
                          (route) => false,
                          // Navigator.push(context,
                          // MaterialPageRoute(builder: (context)))
                        );
                      } else {
                        Fluttertoast.showToast(msg: "User not found");
                      }
                    } catch (e) {
                      print("user not found");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(169, 8, 115, 157)),
                  child: Text('Submit',
                      style: TextStyle(
                          color: Color.fromARGB(255, 249, 247, 247),
                          fontWeight: FontWeight.bold)),
                )),
              ]))

          // showDialog(context: context, builder:(context)=>AlertDialog(content: Text("Submitted!"),) );

          ),
    );
  }
}
