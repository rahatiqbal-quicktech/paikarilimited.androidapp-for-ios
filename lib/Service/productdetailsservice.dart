import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:androidapp/Models/product_details_model.dart';
import 'package:androidapp/main.dart';

class ProductDetailsService {
  static var client = http.Client();

  static Future<ProductDetails> fetchdetails() async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('$woocommerceusername:$woocommercepassword'));
    var response = await client.get(
        Uri.parse("https://paikarilimited.com/wp-json/wc/v3/products/6238"),
        headers: <String, String>{'authorization': basicAuth});

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productDetailsFromJson(jsonString);
    } else {
      return ProductDetails();
      //git test
    }
  }
}
