// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:androidapp/Models/cart_model.dart';
// import 'package:androidapp/Provider/cartprovider.dart';
// import 'package:androidapp/main.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;

// class CreateOrderHttpController extends StatefulWidget {
//   const CreateOrderHttpController({Key? key}) : super(key: key);

//   @override
//   _CreateOrderHttpControllerState createState() =>
//       _CreateOrderHttpControllerState();
// }

// class _CreateOrderHttpControllerState extends State<CreateOrderHttpController> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }

//   List list = [];
//   List<CartModel>? model;

//   sendToDatabase() {
//     //
//     list.clear();
//     Provider.of<CartProvider>(context, listen: false).getallcart();
//     model = Provider.of<CartProvider>(context, listen: false).cartproducts;

//     for (var i = 0; i < model!.length; i++) {
//       var x = modelCreateOrder(product_id: model![i].id, quantity: 5);
//       list.add(x.toJson());
//     }
//     print("This is one is from sendToDatabase  =  ");
//     for (var i = 0; i < list.length; i++) {
//       print(list[i]);
//     }
//     CreateOrderController()
//         .createorder(paymentmethod: "Cash On Delivery", tempLineItems: list);
//   }

//   Future gethistory(String id) async {
//     id = "";
//     String basicAuth = 'Basic ' +
//         base64Encode(utf8.encode('$woocommerceusername:$woocommercepassword'));
//     final response = await http.get(
//         Uri.parse('https://paikarilimited.com/wp-json/wc/v3/orders?customer='),
//         headers: <String, String>{'authorization': basicAuth});

//     var data = jsonDecode(response.body.toString());

//     if (response.statusCode == 200) {
//       return ordersFromJson(response.body.toString());
//     } else {
//       return ordersFromJson(response.body.toString());
//     }
//   }
// }

// class modelCreateOrder {
//   int? product_id;
//   int? quantity;
//   modelCreateOrder({this.product_id, this.quantity});
//   Map<String, dynamic> toJson() {
//     return {"product_id": product_id, "quantity": quantity};
//   }
// }
