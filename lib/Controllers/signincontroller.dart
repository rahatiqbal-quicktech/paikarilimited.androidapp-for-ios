import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:androidapp/screens/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SignIn extends GetxController {
  final dio = Dio();
  final email = RxString("");
  final password = RxString("");

  login() async {
    final spf = await SharedPreferences.getInstance();
    //
    var auth = 'Basic ' +
        base64Encode(
          utf8.encode('$woocommerceusername:$woocommercepassword'),
        );

    try {
      final response = await dio.post(
        "https://paikarilimited.com/wp-json/remote-login/login",
        data: {
          "username": email.value,
          "password": password.value,
        },
        options: Options(
          headers: <String, String>{'authorization': auth},
        ),
      );
      if (response.statusCode == 200) {
        print(response.data['user']['ID']);
        spf.setInt(
          'userUid',
          response.data['user']['ID'],
        );
        spf.setString(
            'userName', response.data['user']['data']['display_name']);
        Get.snackbar('Success', 'You are logged in.');

        await Get.offAll(HomeScreen());

        return response.data;
      }
    } catch (e) {
      print(e);
      Get.snackbar('Oops', 'Invalid Credentials.');
      print("Exception Catched");
    }
  }
}
