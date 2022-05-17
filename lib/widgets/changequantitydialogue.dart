import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/Models/cart_model.dart';
import 'package:androidapp/Controllers/provider/cartprovider.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:provider/provider.dart';

TextEditingController addproductcontroller = TextEditingController();

class ChangeQuantityDialogue extends StatefulWidget {
  String name;
  int price;
  String image;
  String pid;
  ChangeQuantityDialogue(
      {Key? key,
      required this.name,
      required this.image,
      required this.price,
      required this.pid})
      : super(key: key);

  @override
  _ChangeQuantityDialogueState createState() => _ChangeQuantityDialogueState();
}

class _ChangeQuantityDialogueState extends State<ChangeQuantityDialogue> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      content: Container(
        // alignment: Alignment.center,
        height: (MediaQuery.of(context).size.height / 100) * 45,
        // width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Change Quantity of the Item',
              style: GoogleFonts.openSans(),
            ),
            Divider(
              thickness: 2,
            ),
            whitespace(context, 1.5, 0),
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.image),
              ),
              title: Text(
                widget.name,
                style: GoogleFonts.openSans(),
              ),
              subtitle: Text(
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
            whitespace(context, 2, 0),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                icon: Icon(Ionicons.add),
                onPressed: () {
                  addtocart(int.parse(widget.pid), widget.name, widget.price,
                      int.parse(addproductcontroller.text), widget.image);
                  Navigator.pop(context);
                },
                label: Text(
                  "Change",
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

  addtocart(
      int productid, String? name, int? productprice, int? amount, String url) {
    Provider.of<CartProvider>(context, listen: false).addtocart(CartModel(
        id: productid,
        name: name,
        price: productprice,
        imageurl: url,
        quantity: amount));
    print("Added this - $name ");
  }
}
