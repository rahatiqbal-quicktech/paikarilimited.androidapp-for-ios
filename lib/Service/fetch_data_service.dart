import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:androidapp/widgets/loading_dialog.dart';
import 'package:androidapp/main.dart';
import 'package:androidapp/screens/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchDataService {
  final dio = Dio();
  String baseUrl = "https://paikarilimited.com//wp-json/wc/v3/customers/";
  var _auth = 'Basic ' +
      base64Encode(
        utf8.encode('$woocommerceusername:$woocommercepassword'),
      );

  fetchData({required String uid}) async {
    String fullUrl = baseUrl + uid;
    final spf = await SharedPreferences.getInstance();

    try {
      final response = await dio.get(fullUrl,
          options: Options(
            headers: <String, String>{'authorization': _auth},
          ));
      if (response.statusCode == 200) {
        spf.setInt(
          'userUid',
          response.data['id'],
        );
        spf.setString('userName', response.data['username']);
        spf.setString('email', response.data['email']);
        spf.setString('first_name', response.data['first_name']);
        spf.setString('phone', response.data['billing']['phone']);
        print(response.data);
        LoadingDialog().dismiss();
        Get.offAll(() => SplashScreen());
      }
    } catch (e) {
      print("fetchData - catch  :  $e");
    }
  }
}
