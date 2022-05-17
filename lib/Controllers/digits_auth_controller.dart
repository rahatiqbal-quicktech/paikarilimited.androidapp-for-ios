import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getPrefix;
import 'package:androidapp/widgets/loading_dialog.dart';
import 'package:androidapp/main.dart';
import 'package:androidapp/Service/fetch_data_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DigitsAuthController extends getPrefix.GetxController {
  final dio = Dio();
  final user = getPrefix.RxString("");
  final password = getPrefix.RxString("");

  var _auth = 'Basic ' +
      base64Encode(
        utf8.encode('$woocommerceusername:$woocommercepassword'),
      );

  signIn() async {
    final spf = await SharedPreferences.getInstance();
    Map<String, dynamic> data = {
      "user": user.value,
      "countrycode": "+880",
      "password": password.value
    };
    var formData = FormData.fromMap(data);
    String fullUrl = "https://paikarilimited.com/wp-json/digits/v1/login_user";

    try {
      final response = await dio.post(fullUrl,
          data: formData,
          options: Options(headers: <String, String>{'authorization': _auth}));

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          LoadingDialog().dismiss();
          spf.setString('userUid', response.data['data']['user_id']);
          spf.setString(
              'otpAccessToken', response.data['data']['access_token']);
          FetchDataService().fetchData(uid: response.data['data']['user_id']);
        } else if (response.data['success'] == false) {
          LoadingDialog().dismiss();
          getPrefix.Get.snackbar(
              "Something went wrong.", "${response.data['data']['message']}");
        }
      }
    } catch (e) {
      print("Digits Auth Controller sigIn()  :  $e");
    }
  }
}
