import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/Models/order_history_model.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/screens/orderdetailsscreen.dart';
import 'package:androidapp/widgets/anotherappbar.dart';
import 'package:androidapp/widgets/navbar_widget/navbarWidget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class OrderHistoryScreen extends StatefulWidget {
  final String id;
  OrderHistoryScreen({required this.id, Key? key}) : super(key: key);

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  Orders model = Orders();
  int? userid;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size / 100;
    return Scaffold(
      appBar: AnotherAppBar("Orders", context),
      drawer: NavBarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            whitespace(context, 2, 0),
            SizedBox(
              height: size.height * 80,
              child: FutureBuilder<List<Orders>>(
                  future: gethistory(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return noOrder();
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            model = snapshot.data![index];
                            return orderhistorytile(model.id, model.total, size,
                                model.dateCreated.toString(), model.status);
                          });
                    } else {
                      return Center(child: CupertinoActivityIndicator());
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget orderhistorytile(int? orderid, String? price, Size size,
      String dateCreated, String? status) {
    return Container(
      // height: size.height * 21.9,
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Order Id " + orderid.toString(),
              style: GoogleFonts.openSans(
                fontSize: 18,
              ),
            ),
            whitespace(context, 1, 0),
            Text(
              "$dateCreated",
              style: GoogleFonts.openSans(
                fontSize: 11,
              ),
            ),
            whitespace(context, 2, 0),
            Row(
              children: [
                Text(
                  " $price tk",
                  style: GoogleFonts.openSans(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                TextButton.icon(
                    onPressed: () {
                      Get.to(() =>
                          OrderDetailsScreen(orderId: orderid.toString()));
                    },
                    icon: Icon(
                      Ionicons.analytics_outline,
                      color: redcolor,
                    ),
                    label: Text(
                      "Details",
                      style: TextStyle(
                        color: redcolor,
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget noOrder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Ionicons.clipboard_outline,
          size: 40,
        ),
        whitespace(context, 2, 0),
        Text(
          "No order available.",
          style: GoogleFonts.openSans(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        whitespace(context, 1, 0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "You are yet to make your first order. Place an order or two, all the order history can be found here.",
            style: GoogleFonts.openSans(),
          ),
        ),
      ],
    );
  }

  setuserid() async {
    final preference = await SharedPreferences.getInstance();
    setState(() {
      userid = preference.getInt('userUid');
    });
    print("setuserid function  :  $userid");
  }

  Future<List<Orders>> gethistory() async {
    // setuserid();
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('$woocommerceusername:$woocommercepassword'));
    final response = await http.get(
        Uri.parse(
            'https://paikarilimited.com/wp-json/wc/v3/orders?customer=${widget.id}'),
        headers: <String, String>{'authorization': basicAuth});

    print(response.body);

    // var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return ordersFromJson(response.body.toString());
    } else {
      return ordersFromJson(response.body.toString());
    }
  }
}
