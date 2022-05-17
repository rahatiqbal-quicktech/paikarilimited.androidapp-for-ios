import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:androidapp/Models/all_categories_model.dart';
import 'package:androidapp/main.dart';

class AllCategoriesRemoteService {
  static var client = http.Client();

  static Future<List<AllCategoriesModel>> fetchallcategories() async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('$woocommerceusername:$woocommercepassword'));

    var response = await client.get(
        Uri.parse(
          "https://paikarilimited.com/wp-json/wc/v3/products/categories?per_page=100",
        ),
        headers: <String, String>{'authorization': basicAuth});

    if (response.statusCode == 200) {
      var jsonstring = response.body;
      return allCategoriesModelFromJson(jsonstring);
    } else {
      return [];
    }
  }
}
