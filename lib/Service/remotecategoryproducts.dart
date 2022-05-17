import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:androidapp/Models/all_products_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryProductsRemoteService {
  static var client = http.Client();
  int? categoryid;

  static Future<List<AllProductsModel>> fetchallproducts(
      // {int? categoryid}
      ) async {
    String username = 'ck_2ac27102d6ac7a3a83c8ef047aff774bb3a8edae';
    String password = 'cs_8b5cff09fd4580bcfc0616dcc42678c10839f972';
    final sharedPreferences = await SharedPreferences.getInstance();
    var cateogy_id;
    cateogy_id = sharedPreferences.getInt('categoryid');

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var response = await client.get(
        Uri.parse(
            "https://paikarilimited.com/wp-json/wc/v3/products?category=" +
                "${cateogy_id}"
                    "&per_page=100"),
        headers: <String, String>{'authorization': basicAuth});

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return allProductsModelFromJson(jsonString);
    } else {
      return [];
    }
  }
}
