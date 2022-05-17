import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/Models/order_details_model.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/main.dart';
import 'package:androidapp/widgets/anotherappbar.dart';
import 'package:http/http.dart' as http;

class OrderDetailsScreen extends StatefulWidget {
  String orderId;
  OrderDetailsScreen({required this.orderId, Key? key}) : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    getOrderDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size / 100;
    return Scaffold(
      appBar: AnotherAppBar("Order Details", context),
      body: SingleChildScrollView(
        child: FutureBuilder<OrderDetailsModel>(
            future: getOrderDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var temp = snapshot.data;
                List<LineItem>? lineItems = temp!.lineItems;

                //  String date =
                //   DateFormat('yyyy-MM-dd – kk:mm').format(temp!.dateCreated);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    whitespace(context, 5, 0),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.cart,
                          size: 55,
                          color: Colors.grey,
                        ),
                        whitespace(context, 0, 4),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "Order ",
                                  style: GoogleFonts.openSans(
                                      fontSize: 17, color: Colors.black)),
                              TextSpan(
                                  text: temp.status,
                                  style: GoogleFonts.openSans(
                                      fontSize: 17,
                                      color: Colors.green.shade400,
                                      fontWeight: FontWeight.bold))
                            ])),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "Order ID ",
                                  style: GoogleFonts.openSans(
                                      fontSize: 17, color: Colors.black)),
                              TextSpan(
                                  text: "${temp.id}",
                                  style: GoogleFonts.openSans(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ])),
                          ],
                        ),
                      ],
                    ),
                    whitespace(context, 4, 0),

                    // delivery address and details
                    Container(
                      height: size.height * 10,
                      color: redcolor.withOpacity(0.3),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          textWidget(
                            text: "${temp.id}",
                            size: 15,
                            weight: FontWeight.bold,
                            fontColor: redcolor,
                          ),
                          Spacer(),
                          textWidget(text: "${temp.dateCreated}")
                        ],
                      ),
                    ),
                    whitespace(context, 3, 0),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Items",
                        style:
                            GoogleFonts.openSans(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: lineItems!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              "${lineItems[index].name}",
                              style: GoogleFonts.openSans(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "X ${lineItems[index].quantity}",
                                  style: GoogleFonts.openSans(fontSize: 11),
                                ),
                                whitespace(context, 1, 0),
                                Text(
                                  "${lineItems[index].total} ৳",
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          );
                        }),
                    Divider(),
                    whitespace(context, 3, 0),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: textWidget(
                        text: "Delivery Details",
                        weight: FontWeight.bold,
                      ),
                    ),
                    ListTile(
                      minLeadingWidth: 3,
                      leading: Icon(Ionicons.home_outline),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "${temp.shipping!.address1}",
                          style: GoogleFonts.openSans(),
                        ),
                      ),
                      subtitle: textWidget(
                          text:
                              "${temp.billing!.firstName}  |  ${temp.billing!.phone}"),
                    ),
                    whitespace(context, 2, 0),

                    Divider(
                      color: Colors.grey,
                    ),
                    whitespace(context, 5, 0),

                    // total amount of order
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "Total : ",
                            style: GoogleFonts.openSans(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                        TextSpan(
                            text: "৳ ${temp.total}",
                            style: GoogleFonts.openSans(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ))
                      ])),
                    )

                    // ordered items listview - canceled because of unavailable data
                    // ListView.builder(
                    //     shrinkWrap: true,
                    //     itemCount: 3,
                    //     itemBuilder: (context, index) {
                    //       return ListTile(
                    //         title: textWidget(text: "Item Name 123"),
                    //       );
                    //     })
                  ],
                );
              } else {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              }
            }),
      ),
    );
  }

  Future<OrderDetailsModel> getOrderDetails() async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('$woocommerceusername:$woocommercepassword'));
    final response = await http.get(
        Uri.parse('https://paikarilimited.com/wp-json/wc/v3/orders/' +
            widget.orderId),
        headers: <String, String>{'authorization': basicAuth});

    // var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return orderDetailsModelFromJson(response.body.toString());
    } else {
      return OrderDetailsModel();
    }
  }
}

class textWidget extends StatelessWidget {
  final String text;
  final Color? fontColor;
  final double? size;
  final FontWeight? weight;
  final TextAlign? align;
  textWidget(
      {required this.text, this.fontColor, this.size, this.weight, this.align});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align == null ? TextAlign.start : align,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.openSans(
        color: fontColor == null ? Colors.black : fontColor,
        fontSize: size == null ? 14 : size,
        fontWeight: weight == null ? FontWeight.normal : weight,
      ),
    );
  }
}
