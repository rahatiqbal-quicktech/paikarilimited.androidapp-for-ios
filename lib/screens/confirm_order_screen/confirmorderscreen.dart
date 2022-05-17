import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/Controllers/createordercontroller.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/Models/cart_model.dart';
import 'package:androidapp/Models/create_order_model.dart';
import 'package:androidapp/widgets/loading_dialog.dart';
import 'package:androidapp/screens/change_address_screen/changeaddressscreen.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/screens/confirm_order_screen/apply_coupon_widget.dart';
import 'package:androidapp/widgets/anotherappbar.dart';
import 'package:androidapp/widgets/commonsnackbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controllers/provider/cartprovider.dart';

// GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class ConfirmOrderScreen extends StatefulWidget {
  final String totalprice;
  final List<CartModel>? list;
  ConfirmOrderScreen({required this.totalprice, required this.list, Key? key})
      : super(key: key);

  @override
  _ConfirmOrderScreenState createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  String? paymentMethod;

  //
  @override
  void initState() {
    setNameAddress();
    super.initState();
  }

  bool sslcommerzPayment = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size / 100;
    String method = "";
    return Scaffold(
      appBar: AnotherAppBar("Confirm Order", context),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              applyCouponWidget(size, context),
              whitespace(context, 2, 0),
              fullAddress == null
                  ? TextButton.icon(
                      onPressed: () {
                        Get.to(() => ChangeAddressScreen());
                      },
                      icon: Icon(Ionicons.location_outline),
                      label: Text("Set Address"))
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                      child: Row(
                        children: [
                          Icon(
                            Ionicons.location_outline,
                            color: redcolor,
                          ),
                          whitespace(context, 0, 2),
                          SizedBox(
                            width: size.width * 60,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  // Text(
                                  //   "$fullAddress",
                                  //   maxLines: 3,
                                  //   overflow: TextOverflow.ellipsis,
                                  //   style: GoogleFonts.openSans(),
                                  // ),
                                  TextSpan(text: "$fullAddress"),
                                  // TextSpan(
                                  //     text: "\nPost Code : $postCode",
                                  //     style: GoogleFonts.openSans(
                                  //         fontStyle: FontStyle.italic,
                                  //         color: Colors.grey))
                                ],
                              ),
                              maxLines: 3,
                              style: GoogleFonts.openSans(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Spacer(),
                          TextButton(
                              onPressed: () {
                                Get.to(() => ChangeAddressScreen(
                                      house: apartment,
                                      road: houseStreetName,
                                      city: district,
                                      area: townCity,
                                      billingMobileNo: billingMobileNo,
                                      confirmOrderEmailAddress:
                                          confirmOrderEmailAddress,
                                      postCode: postCode,
                                      userName: userName,
                                      companyName: companyName,
                                    ));
                              },
                              child: Text(
                                "Change",
                                style: GoogleFonts.openSans(
                                    color: Colors.grey.shade700),
                              )),
                        ],
                      ),
                    ),
              whitespace(context, 5, 0),
              whitespace(context, 2, 0),
              Container(
                // height: size.height * 30,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 15),
                color: Colors.grey.shade200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select A Payment Method",
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    whitespace(context, 2, 0),
                    GestureDetector(
                      child: PaymentSelectContainer(
                          text: "Cash On Delivery",
                          iconData: Ionicons.cash_outline,
                          index: 0),
                      //
                      onTap: () {
                        setState(() {
                          method = "Payment Set As Cash On Delivery";
                          paymentMethod = "Cash On Delivery";
                          selection[0] = true;
                          selection[1] = false;
                          selection[2] = false;
                          sslcommerzPayment = false;
                          print(paymentMethod);
                        });
                        commonsnackbar(method, 1, context);
                      },
                    ),
                    whitespace(context, 1, 0),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          method = "Payment Set As Direct Bank Transfer";
                          paymentMethod = "Direct Bank Transfer";
                          selection[1] = true;
                          selection[0] = false;
                          selection[2] = false;
                          sslcommerzPayment = false;
                          print(paymentMethod);
                          commonsnackbar(method, 1, context);
                        });
                      },
                      child: PaymentSelectContainer(
                          text: "Direct Bank Transfer",
                          iconData: Ionicons.card_outline,
                          index: 1),
                    ),
                    whitespace(context, 1, 0),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          method = "Payment Set As SSL Commerz";
                          paymentMethod = "SSL Commerz";
                          sslcommerzPayment = true;
                          selection[2] = true;
                          selection[0] = false;
                          selection[1] = false;
                          print(paymentMethod);
                          commonsnackbar(method, 1, context);
                        });
                      },
                      child: PaymentSelectContainer(
                          text: "Online Payment",
                          iconData: Ionicons.wallet_outline,
                          index: 2),
                    ),
                  ],
                ),
              ),
              whitespace(context, 5, 0),
            ],
          ),
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          // CreateOrderController()
          //     .createorder(paymentmethod: method, tempLineItems: []);

          if (paymentMethod == null) {
            Get.snackbar("Select Payment Method",
                "Please select a payment method before proceeding");
          } else if (fullAddress == null) {
            Get.snackbar("Where should we deliver?",
                "Looks like you are yet to set up your delivery address. Tap the Set Address button on top and set up your address.");
          } else
            sendToDatabase(context,
                totalAmount: double.parse(widget.totalprice),
                phoneNumber: billingMobileNo,
                name: userName,
                shipAddress: fullAddress,
                city: district,
                postCode: postCode,
                emailAddress: confirmOrderEmailAddress);
        },
        child: SizedBox(
          width: double.infinity,
          height: 45,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                height: 40,
                color: redcolor,
                width: double.infinity,
                child: Row(
                  children: [
                    const Text(
                      "Confirm Order",
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
                        " ${widget.totalprice} tk",
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
            ],
          ),
        ),
      ),
    );
  }

  var apartment;
  var houseStreetName;
  var townCity;
  var district;
  var postCode;
  var userName;
  var companyName;
  var fullAddress;
  var billingMobileNo;
  var confirmOrderEmailAddress;
  setNameAddress() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      apartment = pref.getString('houseaddress');
      houseStreetName = pref.getString('roadaddress');
      townCity = pref.getString('areaaddress');
      district = pref.getString('city');
      postCode = pref.getString('postCode');
      fullAddress = pref.getString('fullAddress');
      userName = pref.getString('userName');
      companyName = pref.getString('companyName');
      billingMobileNo = pref.getString('billingMobileNo');
      confirmOrderEmailAddress = pref.getString('confirmOrderEmailAddress');
    });
  }

  Color selectedcolor = Colors.grey.shade300;
  Color unselectedcolor = Colors.red;
  bool selected = false;
  List<bool> selection = [false, false, false];
  Widget PaymentSelectContainer(
      {required String text, required IconData iconData, required int index}) {
    return Container(
        height: 45,
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: selection[index] ? redcolor : Colors.grey.shade300,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: selection[index] ? Colors.white : Colors.black54,
            ),
            whitespace(context, 0, 5),
            Text(
              "$text",
              style: GoogleFonts.openSans(
                  color: selection[index] ? Colors.white : Colors.black54),
            ),
          ],
        ));
  }

  var list = [];
  final createOrderModelList = <CreateOrderModel>[];
  List<CartModel>? model;

  sendToDatabase(
    BuildContext context, {
    required double totalAmount,
    required String phoneNumber,
    required String name,
    required String shipAddress,
    required String city,
    required String postCode,
    required String emailAddress,
  }) {
    LoadingDialog().show(context);
    //
    list.clear();
    createOrderModelList.clear();
    Provider.of<CartProvider>(context, listen: false).getallcart();
    model = Provider.of<CartProvider>(context, listen: false).cartproducts;

    for (var i = 0; i < model!.length; i++) {
      // var x = modelCreateOrder(product_id: model![i].id, quantity: 5);
      var x = CreateOrderModel(
          product_id: model![i].id, quantity: model![i].quantity);
      // list.add(x);
      createOrderModelList.add(x);
    }
    // log(createOrderModelList.toString());
    if (sslcommerzPayment) {
      CreateOrderController().createOrderSslcommerz(
          tempLineItems: createOrderModelList,
          context: context,
          totalAmount: double.parse(widget.totalprice),
          phoneNumber: phoneNumber,
          name: name,
          shipAddress: shipAddress,
          city: city,
          emailAddress: emailAddress);
    } else
      CreateOrderController().createorder(
          paymentmethod: paymentMethod,
          tempLineItems: createOrderModelList,
          context: context);
  }
}

setShippingAddress() async {
  final spref = await SharedPreferences.getInstance();

  // fullShippingAddress = spref.getString('houseaddress').toString() +
  //     " " +
  //     spref.getString('roadaddress').toString() +
  //     " " +
  //     spref.getString('areaaddress').toString();

  String fullShippingAddress = "${spref.getString('fullAddress')}";
  print(" $fullShippingAddress ");
}
