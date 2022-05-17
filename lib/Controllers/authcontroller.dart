import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:androidapp/screens/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Auth extends GetxController {
  final dio = Dio();
  final email = RxString("");
  final firstname = RxString("");
  final password = RxString("");

//Replaced with old fonction fromn old Paikari Files
  // signup() async {
  //   final sharedPreferences = await SharedPreferences.getInstance();
  //   //
  //   var auth = 'Basic ' +
  //       base64Encode(
  //         utf8.encode('$woocommerceusername:$woocommercepassword'),
  //       );
  //   print(email.value);
  //   print(password.value);
  //   print(firstname.value);
  //   try {
  //     final response = await dio.post(
  //       "https://paikarilimited.com//wp-json/wc/v3/customers",
  //       data: {
  //         "email": email.value,
  //         "password": password.value,
  //         "first_name": firstname.value
  //       },
  //       options: Options(
  //         headers: <String, String>{'authorization': auth},
  //       ),
  //     );
  //     if (response.statusCode == 201) {
  //       print(response.data['id']);
  //       sharedPreferences.setInt(
  //         'userUid',
  //         response.data['id'],
  //       );
  //       sharedPreferences.setString(
  //         'userName',
  //         response.data['username'],
  //       );
  //       Get.snackbar('Success', 'Registration Successfull');

  //       await Get.to(HomeScreen());

  //       return response.data;
  //     } else {
  //       print("signup authcontroller print ${response.data['message']}");
  //       Get.snackbar("Sign Up Failed",
  //           "Invalid credentials. Please check if you entered your email right.");
  //     }
  //   } catch (e) {
  //     Get.snackbar("from catched error = Sign Up Failed",
  //         "Invalid credentials. Please check if you entered your email right.");
  //     print(e);
  //   }
  // }

  signup() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    //
    var auth = 'Basic ' +
        base64Encode(
          utf8.encode('$woocommerceusername:$woocommercepassword'),
        );

    try {
      final response = await dio.post(
        "https://paikarilimited.com//wp-json/wc/v3/customers",
        data: {
          "email": email.value,
          "password": password.value,
          "first_name": firstname.value
        },
        options: Options(
          headers: <String, String>{'authorization': auth},
        ),
      );
      if (response.statusCode == 201) {
        print(response.data['id']);
        sharedPreferences.setInt(
          'userUid',
          response.data['id'],
        );
        sharedPreferences.setString(
          'userName',
          response.data['username'],
        );
        Get.snackbar('Success', 'Registration Successfull');

        Get.to(HomeScreen());

        return response.data;
      } else {
        print("from else = ");
      }
    } catch (e) {
      // print("this is from simple error print  -  $DioErrorType");
      print("cathc : $e");
      Get.snackbar("Sign Up Failed",
          "This e-mail address is either registered, or you might have entered it wrong. Please check again and sumbit.");
    }
  }
}
