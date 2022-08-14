// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/Dependencies/dependencies.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/screens/cartscreen.dart';
import 'package:androidapp/screens/homescreenlisttile.dart';
import 'package:androidapp/screens/loginscreen.dart';
import 'package:androidapp/widgets/anotherappbar.dart';
import 'package:androidapp/widgets/navbar_widget/navbarWidget.dart';
import 'package:provider/provider.dart';

import '../Controllers/provider/cartprovider.dart';

// final AllProductsController allproductscontroller =
//     Get.put(AllProductsController());

class HomeScreen extends StatefulWidget {
  final int? uid;
  HomeScreen({Key? key, this.uid}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List Categories = [
    "Pet Shop",
    "Toys and Games",
    "Food",
    "Home and Cleaning",
    "Vehicle Essentials",
    "Home Appliance",
    "Office Products"
  ];
  //
  @override
  void initState() {
    super.initState();
    // SqfliteDatabase().cartNotificationNumber();
    // Provider.of<CartProvider>(context).gettotalprice();
    // Provider.of<CartProvider>(context, listen: false).getallcart();

    // FOREROUND STATE
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {
      if (event.notification != null) {
        print(event.notification!.title);
        print(event.notification!.body);
      }
    });

    //background state
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if (event.notification != null) {
        print(event.notification!.title);
        print(event.notification!.body);
      }
    });

    //APP TERMINATED
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value!.notification != null) {
        print(value.notification!.title);
        print(value.notification!.body);
      }
    });
  }
  //

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size / 100;
    return Scaffold(
      appBar: AnotherAppBar("Paikari Limited", context),
      drawer: NavBarWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            SizedBox(
              height: size.height * 86,
              child: Obx(() {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: allproducts_c.allrpoductslist_.length,
                  itemBuilder: (context, index) {
                    final abc = allproducts_c.allrpoductslist_[index];

                    return allproducts_c.allrpoductslist_.isNotEmpty
                        ? HomeScreenListTile(
                            id: abc.id,
                            productname: abc.name,
                            price: abc.salePrice,
                            oldprice: abc.price,
                            imageurl: imagecheckfunction(index),
                            q: getQuantity(abc.id),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                );
              }),
            ),
            Provider.of<CartProvider>(context, listen: true).tprice != 0
                ? Positioned.fill(
                    child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      child: bottomContainer(size),
                      onTap: () {
                        Get.to(() => CartScreen());
                      },
                    ),
                  ))
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget bottomContainer(Size size) {
    return Container(
      height: size.height * 7,
      width: double.infinity,
      margin: EdgeInsets.only(left: 5, right: 5),
      padding: EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: redcolor,
      ),
      child: Row(
        children: [
          Icon(
            Ionicons.bag_handle,
            color: Colors.white,
          ),
          Spacer(),
          Text(
            "Review Order",
            style: GoogleFonts.openSans(color: Colors.white),
          ),
          Spacer(),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5),
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                "${Provider.of<CartProvider>(context, listen: true).tprice} tk",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget SearchDialogue(BuildContext context, Size size) {
    return Dialog(
      child: Container(
        color: Colors.red,
        width: 50,
        height: 50,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Search'),
            ),
            Text("data"),
          ],
        ),
      ),
    );
  }

  String? imagecheckfunction(int index) {
    if (allproducts_c.allrpoductslist_[index].images!.isEmpty) {
      return "https://i5.walmartimages.com/asr/2442ca60-a563-4bb1-bbab-d4449d546d04.b208061a114950a62193c904d00b72c3.gif";
    } else {
      // final item = allproducts_c.allrpoductslist_[index].images;
      return allproducts_c.allrpoductslist_[index].images!.first.src;
    }
  }

  getQuantity(int? id) {
    return Provider.of<CartProvider>(context, listen: false).abc(id!);
  }
}

// 
