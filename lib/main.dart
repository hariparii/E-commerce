import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapplication/homepage.dart';
import 'package:myfirstapplication/spladh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions( apiKey: "AIzaSyCynXq1SOk44IAzL3pwtYwTjsvbTCoktec",
  authDomain: "fir-auth-8e9f4.firebaseapp.com",
  projectId: "fir-auth-8e9f4",
  storageBucket: "fir-auth-8e9f4.appspot.com",
  messagingSenderId: "565928278238",
  appId: "1:565928278238:web:642ac1d9ccee34cec62a4f",
  measurementId: "G-PPV3JMGP3M")
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyFirstApp',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CheckPage()
    
    );
  }
}

class CheckPage extends StatefulWidget {
  const CheckPage({super.key});

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  void check() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.getBool("login")??false){
Navigator.push((context), MaterialPageRoute(builder: (context)=>Homepage()));
  }
  else{
    Navigator.pushAndRemoveUntil<void>
                          // ignore: use_build_context_synchronously
                          (
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SplashView()), // Replace NewScreen() with your actual screen widget
                        (route) => false,
                      );
  }
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
Timer(Duration(milliseconds: 800), (){
check();
});
    
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xFFf03f3f),
      body: Center(child: Image.asset("assets/splash.avif"),),
    );
  }
}