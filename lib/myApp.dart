// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:androidapp/Dependencies/dependencies.dart';

// import 'package:androidapp/Controllers/searchController.dart';
import 'package:androidapp/screens/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  int? id;
  String? userName;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   getValidationData().whenComplete(() async {
  //     Timer(
  //       Duration(seconds: 0),
  //       () => Get.to(HomeScreen(
  //         uid: widget.id,
  //       )
  //           // widget.id == null
  //           //     ? LoginScreen()
  //           //     : HomeScreen(
  //           //         userName: widget.userName,
  //           //       ),
  //           ),
  //     );
  //   });
  //   super.initState();
  // }

  Future getValidationData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var obtainedToken = sharedPreferences.getInt('userUid');
    var username = sharedPreferences.getString('userName');

    setState(() {
      widget.id = obtainedToken;
      widget.userName = username;

      print('User UUid: ${widget.id}');
      print('User Name: ${widget.userName}');
    });
  }

  @override
  Widget build(BuildContext context) {
    // final _ = Get.put(SearchController());

    // _.getSearchResult(searchFieldText: '');
    allproducts_c.FetchAllProducts();
    categories_c.FetchAllCategories();
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen());
  }
}
