import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:androidapp/Boilerplate/boilerplateCheckOutScreen.dart';
import 'package:androidapp/CartDatabase/sqflitedatabase.dart';
import 'package:androidapp/Models/cart_model.dart';
import 'package:androidapp/Models/create_order_model.dart';
import 'package:androidapp/widgets/loading_dialog.dart';
import 'package:androidapp/ssl_commerz/sslcommerz_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'provider/cartprovider.dart';
import '../main.dart';

class CreateOrderController {
  // var lineItems = [];
  // CreateOrderController({required this.lineItems});
  final dio = Dio();

  getcart() async {
    List<CartModel>? tempcart = await SqfliteDatabase().fetchall();
    return tempcart;
  }

  SqfliteDatabase database = SqfliteDatabase();

  createorder(
      {String? paymentmethod,
      required List<CreateOrderModel> tempLineItems,
      String? orderNote,
      String? couponCode,
      required BuildContext context}) async {
    // print("Create Order Function - ${tempLineItems}");
    log("Create Order Function - ${tempLineItems[0].quantity}");

    await setIdentity();
    await setShippingAddress();
    // print(tempLineItems);
    // List<CartModel>? temp = await database.fetchall();
    // print(temp);
    Map<String, dynamic> cartdata = {
      "payment_method_title": paymentmethod,
      "customer_id": userId,
      "billing": {
        "first_name": "$name",
        "company": companyName,
        "address_1": fullShippingAddress,
        "email": email,
        "phone": phone
      },
      "shipping": {
        "first_name": "$name",
        "company": companyName,
        "address_1": fullShippingAddress
      },
      "line_items": tempLineItems,
      "shipping_lines": [
        {"method_id": "flat_rate", "method_title": "Flat Rate", "total": "100"}
      ]
    };
    print(cartdata.toString());

    String url = "https://paikarilimited.com/wp-json/wc/v3/orders";
    var auth = 'Basic ' +
        base64Encode(
          utf8.encode('$woocommerceusername:$woocommercepassword'),
        );
    try {
      final response = await dio.post(url,
          data: cartdata,
          options: Options(
            headers: <String, String>{'authorization': auth},
          ));
      print(response.data);

      if (response.statusCode == 201) {
        LoadingDialog().dismiss();
        Provider.of<CartProvider>(context, listen: false).clearCart();
        Get.off(() => BoilerplateChekOutScreen(
              orderid: response.data['id'],
              paymentMethod: response.data['payment_method_title'],
            ));
      } else {
        LoadingDialog().dismiss();
        print("Not Working");
      }
    } catch (e) {
      LoadingDialog().dismiss();
      print("Failed try");
      print(e);
    }
  }

  createOrderSslcommerz({
    String? paymentmethod,
    required List<CreateOrderModel> tempLineItems,
    required BuildContext context,
    required double totalAmount,
    required String phoneNumber,
    required String name,
    required String shipAddress,
    required String city,
    required String emailAddress,
  }) async {
    await setIdentity();
    await setShippingAddress();

    Map<String, dynamic> cartdata = {
      "payment_method_title": paymentmethod,
      "customer_id": userId,
      "billing": {
        "first_name": "$name",
        "company": companyName,
        "address_1": fullShippingAddress,
        "email": email,
        "phone": phone
      },
      "shipping": {
        "first_name": "$name",
        "company": companyName,
        "address_1": fullShippingAddress
      },
      "line_items": tempLineItems,
      "shipping_lines": [
        {"method_id": "flat_rate", "method_title": "Flat Rate", "total": "100"}
      ]
    };
    String url = "https://paikarilimited.com/wp-json/wc/v3/orders";
    var auth = 'Basic ' +
        base64Encode(
          utf8.encode('$woocommerceusername:$woocommercepassword'),
        );

    try {
      final response = await dio.post(url,
          data: cartdata,
          options: Options(
            headers: <String, String>{'authorization': auth},
          ));

      if (response.statusCode == 201) {
        LoadingDialog().dismiss();
        sslCommerzService(
            totalAmount: totalAmount,
            phoneNumber: phoneNumber,
            name: name,
            shipAddress: shipAddress,
            city: city,
            emailAddress: emailAddress,
            orderId: response.data['id'],
            context: context);
        // sslCommerzGeneralCall();
      } else {
        LoadingDialog().dismiss();
        print("Not Working");
      }
    } catch (e) {
      LoadingDialog().dismiss();
      print("Exception from createOrderSslcommerz  " + e.toString());
      log("Exception from createOrderSslcommerz  " + e.toString());
      print("createOrderSslcommerz - Failed try");
    }
  }

  String fullShippingAddress = " ";
  String email = "";
  String phone = "";
  String companyName = "";
  setShippingAddress() async {
    final spref = await SharedPreferences.getInstance();

    // fullShippingAddress = spref.getString('houseaddress').toString() +
    //     " " +
    //     spref.getString('roadaddress').toString() +
    //     " " +
    //     spref.getString('areaaddress').toString();
    fullShippingAddress = "${spref.getString('fullAddress')}";
    email = "${spref.getString('confirmOrderEmailAddress')}";
    phone = "${spref.getString('billingMobileNo')}";
    companyName = "${spref.getString('companyName')}";
  }

  String? name;
  int? userId;
  setIdentity() async {
    final idPref = await SharedPreferences.getInstance();
    name = idPref.getString('userName');
    userId = idPref.getInt('userUid');
  }
}
