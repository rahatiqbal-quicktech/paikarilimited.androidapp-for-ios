import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/Controllers/provider/cartprovider.dart';
import 'package:androidapp/screens/cartscreen.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:provider/provider.dart';

AppBar AnotherAppBar(String title, BuildContext context) {
  int cartProductNumber;
  final providerData = Provider.of<CartProvider>(context);
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.white),
    title: Text(
      "$title",
      style: GoogleFonts.openSans(
          textStyle: const TextStyle(
        color: Colors.white,
      )),
    ),
    backgroundColor: redcolor,
    actions: <Widget>[
      IconButton(
          icon: const Icon(Icons.search),
          color: Colors.white,
          onPressed: () {
            searchcontroller.clear();
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SearchDialogue(context);
                });
          }),
      Stack(
        children: [
          IconButton(
              icon: const Icon(Icons.shopping_cart),
              color: Colors.white,
              onPressed: () {
                Get.to(() => CartScreen());
              }),
          Provider.of<CartProvider>(context, listen: true).cart_notification ==
                  0
              ? Container()
              : Positioned.fill(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 15.4,
                      width: 19,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "${Provider.of<CartProvider>(context, listen: true).cart_notification}",
                        style: GoogleFonts.openSans(
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    ],
  );
}
