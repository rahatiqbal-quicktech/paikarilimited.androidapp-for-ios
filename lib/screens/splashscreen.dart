import 'dart:async';

import 'package:flutter/material.dart';
import 'package:androidapp/screens/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // categories_c.FetchAllCategories();
    // allproducts_c.FetchAllProducts();
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(
            "assets/logos/paikari.jpg",
          ),
          height: 150,
        ),
      ),
    );
  }
}
