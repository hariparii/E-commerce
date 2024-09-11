import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myfirstapplication/spladh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signupvie extends StatefulWidget {
  const Signupvie({super.key});

  @override
  State<Signupvie> createState() => _SignupvieState();
}

class _SignupvieState extends State<Signupvie> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _signup() async {
    FocusScope.of(context).unfocus();
    print(_emailController.text);
    print(_passwordController.text);
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      print(userCredential.user);
      if (userCredential.user != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("Signup", true);

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('User registration successful!'),
            actions: [
              TextButton(
                  onPressed: () {
                    
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => SplashView()));
                  },
                  child: Text("Login"))
            ],
          ),
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to create account: ${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      // final SharedPreferences prefs =
      //     await SharedPreferences.getInstance();

      // prefs.setBool("Signup", true);
      // Navigator.pushAndRemoveUntil<void>
      //     // ignore: use_build_context_synchronously
      //     (
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) =>
      //           SplashView()), //
      //   (route) => true,
      //    );
    }
  }
  // Navigator.push(context,
  // MaterialPageRoute(builder: (context)))

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SignUp'),
          backgroundColor: Color.fromARGB(255, 248, 203, 70),
        ),
        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(8.0)),
                const Center(
                  child: Text(
                    'Create your New Account',
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                Center(
                  child: Text(
                    'Fill in your details in the space given below.',
                    style: TextStyle(
                      fontSize: 18.5,
                      color: Color.fromARGB(206, 14, 14, 14),
                    ),
                  ),
                ),
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
                  obscureText: true,
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                Center(
                  child: ElevatedButton(
                    onPressed: _signup,
                    child: Text(
                      'Submit',
                      selectionColor: Color.fromARGB(255, 248, 203, 70),
                    ),
                  ),
                ),
              ],
            ))));
  }
}
