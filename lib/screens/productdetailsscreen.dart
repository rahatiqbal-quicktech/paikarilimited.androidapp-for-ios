import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/CartDatabase/sqflitedatabase.dart';
import 'package:androidapp/Controllers/productdetailscontroller.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/Models/cart_model.dart';
import 'package:androidapp/Models/product_details_model.dart';
import 'package:androidapp/Controllers/provider/cartprovider.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:http/http.dart' as http;
import 'package:androidapp/main.dart';
import 'package:androidapp/variable.dart';
import 'package:androidapp/widgets/addproductdialogue.dart';
import 'package:androidapp/widgets/anotherappbar.dart';
import 'package:androidapp/widgets/navbar_widget/navbarWidget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/image.dart' as imageimport;

class ProductDetailsScreen extends StatefulWidget {
  //
  // AllProductsModel? tempmodel;
  String id;
  String url;
  String name;
  String oldprice;
  String saleprice;
  int q = 1;
  // const ProductDetailsScreen({required this.id, Key? key}) : super(key: key);
  ProductDetailsScreen(
      {required this.id,
      required this.name,
      required this.url,
      required this.oldprice,
      required this.saleprice,
      required this.q});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  SqfliteDatabase database_ = SqfliteDatabase();
  @override
  void initState() {
    // getQuantity();
    super.initState();
    checkIfAvailable();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size / 100;

    final ProductDetailsController productdetailscontroller =
        Get.put(ProductDetailsController());

    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AnotherAppBar("Details", context),
      drawer: NavBarWidget(
        userName: token_,
      ),
      body: SingleChildScrollView(
          child: FutureBuilder<ProductDetails>(
              future: GetDetails(widget.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: double.infinity,
                          height: size.height * 40,
                          child: GestureDetector(
                            child: imageimport.Image(
                              image: NetworkImage(
                                widget.url,
                                // widget.url,
                                // snapshot.data!.images![0].toString(),
                                // "https://teamphotousa.com/assets/images/teamphoto-loading.gif",
                              ),
                              fit: BoxFit.cover,
                            ),
                            onTap: () {
                              Get.defaultDialog(
                                  title: "",
                                  // radius: 20,
                                  content: Container(
                                      // height: 50,
                                      child: Image(
                                          image: NetworkImage(widget.url))));
                            },
                          )),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width * 70,
                                  child: Text(widget.name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: GoogleFonts.openSans(
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                ),
                                whitespace(context, 2, 0),
                                Text(
                                  "old Price  " + widget.oldprice,
                                  // snapshot.data!.regularPrice.toString(),
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    // fontSize: 18,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                Text(
                                  "Price  " + widget.saleprice,
                                  // snapshot.data!.price.toString(),
                                  style: GoogleFonts.openSans(
                                    color: redcolor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          // ignore: prefer_const_constructors
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AddProductDialogue(
                                          name: widget.name,
                                          image: widget.url,
                                          price: int.parse(widget.saleprice),
                                          pid: widget.id);
                                    });

                                // showsnackbar();
                                // addtocart(int.parse(widget.id), widget.name,
                                //     int.parse(widget.saleprice), 1);
                              },
                              child: const Icon(
                                Ionicons.add_circle_outline,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          )
                        ],
                      ),
                      whitespace(context, 2, 0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Html(
                          data: snapshot.data!.shortDescription.toString(),
                          style: {
                            "body": Style(
                              color: Colors.white,
                            )
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Divider(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Html(
                          data: snapshot.data!.description.toString(),
                          style: {
                            "body": Style(
                              color: Colors.white,
                            )
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    // height: double.infinity,
                    height: size.height * 80,
                    alignment: Alignment.center,
                    child: const CupertinoActivityIndicator(
                      radius: 20,
                    ),
                  );
                }
              })),
    );
  }

  Future<ProductDetails> GetDetails(String id) async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('$woocommerceusername:$woocommercepassword'));
    final response = await http.get(
        Uri.parse('https://paikarilimited.com/wp-json/wc/v3/products/' + id),
        headers: <String, String>{'authorization': basicAuth});

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return ProductDetails.fromJson(data);
    } else {
      return ProductDetails.fromJson(data);
    }
  }

  var quantityString;
  checkIfAvailable() {
    int tempId = int.parse(widget.id);
    print(
        "This is product id from widget = ${widget.id}  and this is product id after parsing ${tempId} - checkIfAvailable");
    for (var i = 0; i < 5; i++) {
      print(i);
    }
    for (var i = 0; i < global_CartList.length; i++) {
      if (tempId == global_CartList[i]['id']) {
        print(global_CartList[i]['id']);
        setState(() {
          quantityString = global_CartList[i]['quantity'];
        });
      } else {
        print("object");
        print(global_CartList[i]['id']);
        print(widget.id);
        setState(() {
          quantityString = 55;
        });
      }
    }
  }

  int? quantity;
  getQuantity() async {
    quantity = await Provider.of<CartProvider>(context, listen: false)
        .abc(int.parse(widget.id));
    // setState(() {});
    print(quantity);
  }

  addtocart(int productid, String? name, int? productprice, int? amount) {
    Provider.of<CartProvider>(context, listen: false).addtocart(CartModel(
        id: productid,
        name: name,
        price: productprice,
        imageurl: widget.url,
        quantity: amount));
    print("Added this - $name ");
  }

  testupdate(int a) {
    Provider.of<CartProvider>(context, listen: false).updatecart(CartModel(
        id: a,
        imageurl:
            "https://upload.wikimedia.org/wikipedia/commons/9/9a/Gull_portrait_ca_usa.jpg",
        name: "Test",
        price: 100,
        quantity: 5));
  }

  Widget quantityhelperfunction() {
    return Row(
      children: [
        widget.q != 0
            ? new IconButton(
                onPressed: () => setState(() {
                      // quantity = (quantity! - 1);
                      widget.q--;
                    }),
                icon: new Icon(Ionicons.remove_circle_outline))
            : new Container(),
        whitespace(context, 0, 1),
        widget.q != 0 ? Text(widget.q.toString()) : Container(),
        IconButton(
            onPressed: () => setState(() {
                  // quantity = (quantity! + 1);
                  widget.q++;
                }),
            icon: new Icon(
              Ionicons.add_circle_outline,
              color: Colors.blue,
            ))
      ],
    );
  }

  showsnackbar() {
    return Get.snackbar(
        "Product Added", "Product has been successfully added to the cart");
  }
}
