import 'dart:convert';

import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/main.dart';
import 'package:androidapp/screens/product_details/product_stock_model.dart';
import 'package:androidapp/widgets/addproductdialogue.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AddToCartButton extends StatefulWidget {
  AddToCartButton({
    Key? key,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.pid,
  }) : super(key: key);

  String name;
  String price;
  String imageUrl;
  String pid;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductStockModel?>(
        future: ProductStockService().fetchProductStock(widget.pid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.stockStatus != 'outofstock') {
              print(snapshot.data?.stockStatus);
              return GestureDetector(
                onTap: () {
                  int temp = 0;
                  if (widget.price == "" || widget.price == "null") {
                    temp = 0;
                  } else {
                    temp = int.parse(widget.price);
                  }
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddProductDialogue(
                            name: widget.name,
                            image: widget.imageUrl,
                            price: temp,
                            pid: widget.pid);
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
              );
            } else {
              return Text(
                "Out of stock",
                style: TextStyle(color: redcolor),
              );
            }
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

class ProductStockService {
  //
  final dio = Dio();

  var _auth = 'Basic ' +
      base64Encode(
        utf8.encode('$woocommerceusername:$woocommercepassword'),
      );

  Future<ProductStockModel?> fetchProductStock(String id) async {
    String url = "https://paikarilimited.com/wp-json/wc/v3/products/$id";
    try {
      final response = await dio.get(url,
          options: Options(
            headers: <String, String>{'authorization': _auth},
          ));
      if (response.statusCode == 200) {
        // return productStockModelFromJson(response.data);
        return ProductStockModel.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
