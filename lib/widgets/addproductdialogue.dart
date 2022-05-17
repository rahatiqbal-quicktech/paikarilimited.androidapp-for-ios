import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/Models/cart_model.dart';
import 'package:androidapp/Controllers/provider/cartprovider.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/main.dart';
import 'package:provider/provider.dart';

TextEditingController addproductcontroller = TextEditingController();
// int abc = 10;

class AddProductDialogue extends StatefulWidget {
  String name;
  int price;
  String image;
  String pid;

  AddProductDialogue(
      {Key? key,
      required this.name,
      required this.image,
      required this.price,
      required this.pid})
      : super(key: key);

  @override
  _AddProductDialogueState createState() => _AddProductDialogueState();
}

class _AddProductDialogueState extends State<AddProductDialogue> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      content: Container(
        // alignment: Alignment.center,
        // height: (MediaQuery.of(context).size.height / 100) * 45,
        // width: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Add Bulk Product On Your Cart',
              style: GoogleFonts.openSans(),
            ),
            Divider(
              thickness: 2,
            ),
            whitespace(context, 3, 0),
            ListTile(
              leading: CircleAvatar(
                // radius: 20,
                backgroundImage: NetworkImage(widget.image),
              ),
              title: Text(
                widget.name,
                style: GoogleFonts.openSans(),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              subtitle: widget.price == 0
                  ? Text("Price not available")
                  : Text(
                      "Price : " + widget.price.toString(),
                      style: GoogleFonts.openSans(),
                    ),
            ),
            TextField(
              controller: addproductcontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  label: Text(
                "Set Quantity Here",
                style: GoogleFonts.openSans(),
              )),
            ),
            // whitespace(context, 2, 0),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                icon: Icon(Ionicons.add),
                onPressed: () {
                  addtocart(int.parse(widget.pid), widget.name, widget.price,
                      int.parse(addproductcontroller.text), widget.image);
                  // addToCart_AnotherSql(
                  //     sentid: widget.pid,
                  //     sentproductname: widget.name,
                  //     sentproductprice: widget.price.toDouble(),
                  //     quantity: int.parse(addproductcontroller.text));
                  Navigator.pop(context);
                  addproductcontroller.clear();
                },
                label: Text(
                  "Add Product",
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                        // color: Colors.black,
                        ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: redcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addToCart_AnotherSql(
      {required String sentid,
      required String sentproductname,
      required double sentproductprice,
      required int quantity}) async {
    try {
      int a = await cartSql.addProduct(
          sentid, sentproductname, sentproductprice, quantity);

      if (a == 1) {
        print("Product Added To Cart ");
      } else if (a == 0) {
        print("Product Couldn't Be Added To Cart ");
      } else {
        print("SQL Issue for Cart");
      }
    } catch (e) {
      print(e);
    }
  }

  addtocart(
      int productid, String? name, int? productprice, int? amount, String url) {
    log("addtocart : $amount");
    Provider.of<CartProvider>(context, listen: false).addtocart(CartModel(
        id: productid,
        name: name,
        price: productprice,
        imageurl: url,
        quantity: amount));
    print("Added this - $name ");
  }
}
