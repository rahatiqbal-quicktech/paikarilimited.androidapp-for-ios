import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

import 'package:androidapp/CartDatabase/sqflitedatabase.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/Models/cart_model.dart';
import 'package:androidapp/Controllers/provider/cartprovider.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/screens/confirm_order_screen/confirmorderscreen.dart';
import 'package:androidapp/screens/loginscreen.dart';
import 'package:androidapp/main.dart';
import 'package:androidapp/widgets/anotherappbar.dart';
import 'package:androidapp/widgets/changequantitydialogue.dart';
import 'package:androidapp/widgets/navbar_widget/navbarWidget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int a = 0;
  int? totalprice;
  // @override
  // void initState() {
  //   getprice();

  //   super.initState();
  // }
  List<Map<String, dynamic>> CartList = [];

  fetchwishlist() async {
    List<Map<String, dynamic>> list = await cartSql.fetchProducts();
    setState(() {
      CartList = list;
    });
    // print(CartList.first["productimage"]);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      totalprice = Provider.of<CartProvider>(context).tprice;
    });
    Size size = MediaQuery.of(context).size / 100;
    return Scaffold(
      appBar: AnotherAppBar("Cart", context),
      drawer: NavBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // TextButton(
            //     onPressed: () {
            //       Provider.of<CartProvider>(context, listen: false).clearCart();
            //     },
            //     child: Text("Clear Cart")),
            // Container(
            //   width: double.infinity,
            //   height: size.height * 5,
            //   color: Colors.green.shade400,
            //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: const [
            //       Icon(
            //         Ionicons.car_sport,
            //         color: Colors.white,
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         "Dhaka",
            //         style: TextStyle(color: Colors.white),
            //       ),
            //       // Spacer(),
            //       // Text(
            //       //   "5:30 PM - 6:00 PM",
            //       //   style: TextStyle(color: Colors.white),
            //       // )
            //     ],
            //   ),
            // ),
            // whitespace(context, 5, 0),
            // TextButton(
            //     onPressed: () {
            //       getprice();
            //     },
            //     child: Text(
            //       "Get Price",
            //       style: GoogleFonts.openSans(color: Colors.black),
            //     )),
            Consumer<CartProvider>(builder: (_, cartprovider, child) {
              return SizedBox(
                height: size.height * 65,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: cartprovider.cartproducts?.length,
                  itemBuilder: (context, index) {
                    a = (a + cartprovider.cartproducts![index].price!.toInt());
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(cartprovider
                                    .cartproducts![index].imageurl
                                    .toString()),
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
                                    width: size.width * 40,
                                    child: Text(
                                        "${cartprovider.cartproducts![index].name}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.openSans()),
                                  ),
                                  whitespace(context, 2, 0),
                                  Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    'tk ${cartprovider.cartproducts![index].price}',
                                                style: GoogleFonts.openSans(
                                                    textStyle: TextStyle(
                                                        color: redcolor))),
                                          ],
                                        ),
                                      ),
                                      whitespace(context, 0, 10),
                                      Text(
                                        "Quantity : ${cartprovider.cartproducts![index].quantity}",
                                        style: GoogleFonts.openSans(
                                          fontSize: 11.8,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              // whitespace(context, 0, 2),

                              const Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  whitespace(context, 2, 0),
                                  GestureDetector(
                                    onTap: () => delete(
                                        cartprovider.cartproducts![index].id),
                                    child: Icon(
                                      Ionicons.trash_bin_outline,
                                      color: redcolor,
                                    ),
                                  ),
                                  // whitespace(context, 2, 0),
                                  TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ChangeQuantityDialogue(
                                                  name: cartprovider
                                                      .cartproducts![index].name
                                                      .toString(),
                                                  image: cartprovider
                                                      .cartproducts![index]
                                                      .imageurl
                                                      .toString(),
                                                  price: int.parse(cartprovider
                                                      .cartproducts![index]
                                                      .price
                                                      .toString()),
                                                  pid: cartprovider
                                                      .cartproducts![index].id
                                                      .toString());
                                            });
                                      },
                                      child: Text(
                                        "Change\nQuantity",
                                        style: GoogleFonts.openSans(
                                          fontSize: 11,
                                        ),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                      ],
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar:
          Consumer<CartProvider>(builder: (_, cartprovider, child) {
        return SizedBox(
          height: 75,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                color: Colors.grey.shade300,
                height: 35,
                width: double.infinity,
                child: Row(
                  children: [
                    Text(
                      "Subtotal",
                      style: GoogleFonts.openSans(),
                    ),
                    const Spacer(),
                    Text(
                      // a.toString() + " tk",
                      "${Provider.of<CartProvider>(context, listen: true).tprice}",
                      // b.toString(),
                      style: GoogleFonts.openSans(),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // print(int.parse(
                  //     Provider.of<CartProvider>(context, listen: false)
                  //         .tprice
                  //         .toString()));
                  // Get.to(() => BoilerPlateTestScreen(listabc: cartlist));
                  checkTotal(
                      price: Provider.of<CartProvider>(context, listen: false)
                          .tprice,
                      parameterList: cartlist);
                  // Get.to(ConfirmOrderScreen(
                  //   totalprice:
                  //       Provider.of<CartProvider>(context, listen: false)
                  //           .tprice
                  //           .toString(),
                  //   list: cartlist,
                  // ));
                  // CreateOrderController().createorder();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  // const BoilerplateChekOutScreen()));
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  height: 40,
                  color: redcolor,
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Text(
                        "Place Order",
                        style: TextStyle(
                          fontSize: 15.5,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Container(
                        alignment: Alignment.center,
                        height: double.infinity,
                        color: Colors.red.shade800,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Text(
                          " ${Provider.of<CartProvider>(context, listen: true).tprice} tk",
                          style: const TextStyle(
                            fontSize: 15.5,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  delete(int? productid) {
    Provider.of<CartProvider>(context, listen: false)
        .deletecartproduct(productid!);
  }

  List<CartModel>? cartlist;
  getlist() async {
    Provider.of<CartProvider>(context, listen: false).getallcart();
    List<CartModel>? temp =
        await Provider.of<CartProvider>(context, listen: false).cartproducts;
    setState(() {
      cartlist = temp;
    });
  }

  int? b = 0;
  Future getprice() async {
    var instance = SqfliteDatabase();
    b = await instance.totalprice();

    print(b);
  }

  var token_;

  setvalue() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.get('userUid');
    setState(() {
      token_ = token;
    });
    print("Navbar token = ");
    print(token_);
  }

  checkTotal({int? price, List<CartModel>? parameterList}) async {
    await setvalue();
    if (token_ == null) {
      Get.snackbar("You are not logged in",
          "You will have to Log In to your account first.");
      Get.to(() => LoginScreen());
    } else {
      print("Check Total Function");
      if (price! < 5000) {
        Get.snackbar("Order Price Too Low",
            "Your minimum order has to be at least 5000 taka. Please add more products to continue");
      } else {
        Get.to(() => ConfirmOrderScreen(
              totalprice: price.toString(),
              list: cartlist,
            ));
      }
    }
  }
}
