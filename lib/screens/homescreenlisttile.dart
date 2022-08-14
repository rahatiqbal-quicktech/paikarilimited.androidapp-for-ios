import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/Models/cart_model.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/screens/product_details/productdetailsscreen.dart';
import 'package:androidapp/widgets/addproductdialogue.dart';
import 'package:provider/provider.dart';

import '../Fixed Variables/fixedvariables.dart';
import '../Controllers/provider/cartprovider.dart';

class HomeScreenListTile extends StatefulWidget {
  String? productname;
  dynamic price;
  dynamic oldprice;
  String? imageurl;
  int? id;
  int _itemcount = 0;
  int? q;
  HomeScreenListTile(
      {this.productname,
      this.price,
      this.oldprice,
      this.imageurl,
      this.id,
      this.q});
  // const HomeScreenListTile({Key? key}) : super(key: key);

  @override
  _HomeScreenListTileState createState() => _HomeScreenListTileState();
}

class _HomeScreenListTileState extends State<HomeScreenListTile> {
  int? quantity;
  getQuantity(int? id) async {
    print(id);
    quantity =
        await Provider.of<CartProvider>(context, listen: false).abc(widget.id);
    // setState(() {});
    print(quantity);
  }

  @override
  void initState() {
    super.initState();
  }

  // int _itemcount = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size / 100;
    return new Column(
      children: [
        // Text(abc.price.toString()),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.imageurl.toString()),
                  radius: 26,
                ),
                SizedBox(
                  width: size.width * 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 47,
                      child: Text(widget.productname.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.openSans(fontSize: 11)),
                    ),
                    // whitespace(context, 2, 0),
                    SizedBox(
                      width: size.width * 70,
                      child: Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'tk ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.oldprice.toString(),
                                  style: TextStyle(
                                    color: widget.price != ""
                                        ? Colors.grey
                                        : redcolor,
                                    decoration: widget.price != ""
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                                TextSpan(
                                    text: '    ' +
                                        "${widget.price ?? "Price not available"}",
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(color: redcolor))),
                              ],
                            ),
                          ),
                          Spacer(),
                          // quantityhelperfunction(),
                          widget.q != 0
                              ? Container(
                                  height: 20,
                                  width: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: redcolor,
                                  ),
                                  child: Text(widget.q.toString(),
                                      style: GoogleFonts.openSans(
                                          color: Colors.white)))
                              : Container(),
                          IconButton(
                              onPressed: () {
                                print(
                                    "This is product prices ${widget.oldprice}and${widget.price}");
                                int temp = 0;
                                if (widget.price == "") {
                                  if (widget.oldprice == "") {
                                    temp = 0;
                                  } else {
                                    temp = int.parse(widget.oldprice);
                                  }
                                } else {
                                  temp = int.parse(widget.price);
                                }
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AddProductDialogue(
                                          name: widget.productname.toString(),
                                          image: widget.imageurl.toString(),
                                          price: temp,
                                          // widget.price != ""
                                          //     ? int.parse(
                                          //         widget.price.toString())
                                          //     : int.parse(
                                          //         widget.oldprice.toString()),
                                          pid: widget.id.toString());
                                    });
                              },
                              icon: Icon(
                                Ionicons.add_circle_outline,
                                color: redcolor,
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            String? link = widget.imageurl;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(
                          id: widget.id.toString(),
                          url: link.toString(),
                          name: widget.productname.toString(),
                          oldprice: widget.oldprice.toString(),
                          saleprice: widget.price.toString(),
                          q: widget._itemcount,
                        )));
          },
          onLongPress: () {
            AddProductDialogue(
                name: widget.productname.toString(),
                image: widget.imageurl.toString(),
                price: int.parse(widget.price.toString()),
                pid: widget.id.toString());
          },
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget quantityhelperfunction() {
    return Row(
      children: [
        widget._itemcount != 0
            ? new IconButton(
                onPressed: () => setState(() {
                      // quantity = (quantity! - 1);
                      widget._itemcount--;
                    }),
                icon: new Icon(Ionicons.remove_circle_outline))
            : new Container(),
        whitespace(context, 0, 1),
        widget._itemcount != 0
            ? GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddProductDialogue(
                            name: widget.productname.toString(),
                            image: widget.imageurl.toString(),
                            price: int.parse(widget.price.toString()),
                            pid: widget.id.toString());
                      });
                },
                child: Container(child: Text(widget._itemcount.toString())))
            : Container(),
        IconButton(
            onPressed: () {
              setState(() {
                // quantity = (quantity! + 1);
                widget._itemcount++;
              });
              addtocart(
                  widget.id!.toInt(),
                  widget.productname,
                  int.parse(widget.price.toString()),
                  1,
                  widget.imageurl.toString());
            },
            icon: new Icon(
              Ionicons.add_circle_outline,
              color: Colors.blue,
            ))
      ],
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
