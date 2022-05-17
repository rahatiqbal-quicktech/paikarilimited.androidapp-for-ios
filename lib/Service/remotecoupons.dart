import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:androidapp/Models/all_coupons_model.dart';

class CouponRemoteService {
  static var client = http.Client();

  static Future<List<AllCouponsModel>> fetchAllCoupons() async {
    String username = 'ck_2ac27102d6ac7a3a83c8ef047aff774bb3a8edae';
    String password = 'cs_8b5cff09fd4580bcfc0616dcc42678c10839f972';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var response = await client.get(
        Uri.parse("https://paikarilimited.com/wp-json/wc/v2/coupons"),
        headers: <String, String>{'authorization': basicAuth});

    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(response.body);
      return allCouponsModelFromJson(jsonString);
    } else {
      return [];
    }
  }
}
