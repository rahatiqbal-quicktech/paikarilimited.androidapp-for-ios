import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/screens/cartscreen.dart';
import 'package:androidapp/screens/searchresultscreen.dart';
import 'package:androidapp/widgets/addproductdialogue.dart';

Widget whitespace(BuildContext context, var thisheight, var thiswidth) {
  Size size = MediaQuery.of(context).size / 100;
  return SizedBox(
    height: size.height * thisheight,
    width: size.width * thiswidth,
  );
}

// ignore: non_constant_identifier_names
AppBar CommonAppBar(BuildContext context) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.white),
    title: Text(
      "Paikari",
      style: GoogleFonts.openSans(
          textStyle: const TextStyle(
        color: Colors.white,
      )),
    ),
    backgroundColor: redcolor,
    // leading: const Icon(Icons.menu),
    actions: <Widget>[
      IconButton(
          icon: const Icon(Icons.search),
          color: Colors.white,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddProductDialogue(
                    name: "abcde",
                    price: 500,
                    image:
                        "https://media.istockphoto.com/photos/picturesque-morning-in-plitvice-national-park-colorful-spring-scene-picture-id1093110112?k=20&m=1093110112&s=612x612&w=0&h=3OhKOpvzOSJgwThQmGhshfOnZTvMExZX2R91jNNStBY=",
                    pid: "12345",
                  );
                });
          }),
      IconButton(
          icon: const Icon(Icons.shopping_cart),
          color: Colors.white,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CartScreen()));
          }),
    ],
  );
}

TextEditingController searchcontroller = TextEditingController();

// ignore: non_constant_identifier_names
Widget SearchDialogue(BuildContext context) {
  return AlertDialog(
    content: Container(
      alignment: Alignment.center,
      height: 150,
      // width: 200,
      child: Column(
        children: [
          TextFormField(
            controller: searchcontroller,
            decoration:
                const InputDecoration(label: Text("Search for products here")),
            validator: (value) {
              if (value!.isEmpty) {
                return "Field Empty";
              }
              return null;
            },
          ),
          whitespace(context, 2, 0),
          SizedBox(
            width: 100,
            child: OutlinedButton(
              onPressed: () {
                // Get.to(() => SearchResultScreen(
                //       searchKey: searchcontroller.text,
                //     ));

                if (searchcontroller.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchResultScreen(
                            searchKey: searchcontroller.text)),
                  );
                } else {
                  // Get.snackbar("No search keyword",
                  //     "You have to enter a search keyword. Please enter a keyword like 'Soap'");
                  Fluttertoast.showToast(msg: "No search keyword");
                  Navigator.pop(context);
                }
              },
              // searchcontroller.clear();

              child: Text(
                "Search",
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              style: const ButtonStyle(),
            ),
          ),
        ],
      ),
    ),
  );
}
