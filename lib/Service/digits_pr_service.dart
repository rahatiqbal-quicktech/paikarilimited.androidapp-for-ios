import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/widgets/loading_dialog.dart';
import 'package:androidapp/main.dart';

class DigitsPasswordResetService {
  final dio = Dio();

  String basicAuth = 'Basic ' +
      base64Encode(utf8.encode('$woocommerceusername:$woocommercepassword'));
  resetPassword({required String email}) async {
    var formData = FormData.fromMap({
      'user': email,
    });

    try {
      var dioResponse = await dio.post(
          "https://paikarilimited.com/wp-json/digits/v1/recovery",
          data: formData,
          options: Options(
            headers: <String, String>{'authorization': basicAuth},
          ));
      if (dioResponse.statusCode == 200) {
        LoadingDialog().dismiss();

        if (dioResponse.data['success'] == true) {
          Fluttertoast.showToast(
              msg: dioResponse.data['data']['msg'],
              backgroundColor: redcolor,
              fontSize: 15,
              textColor: Colors.white);
        } else
          Fluttertoast.showToast(
              msg: dioResponse.data['data']['msg'],
              backgroundColor: redcolor,
              fontSize: 15,
              textColor: Colors.white);
      }
    } catch (e) {
      LoadingDialog().dismiss();
      print(e);
      Get.snackbar("Wrong Email",
          "The email you entered is wrong or is not registered. Please check and try again");
    }
  }

  resetPasswordMobile(
      {required String mobileNo,
      required String otpCode,
      required String firebaseToken,
      required int verificationCode,
      required String pass}) async {
    var formData = FormData.fromMap({
      'user': mobileNo,
      'countrycode': "+88",
      'otp': otpCode,
      'ftoken': firebaseToken,
      'code': verificationCode,
      'password': pass
    });

    try {
      var dioResponse = await dio.post(
          "https://paikarilimited.com/wp-json/digits/v1/recovery",
          data: formData,
          options: Options(
            headers: <String, String>{'authorization': basicAuth},
          ));
      if (dioResponse.statusCode == 200) {
        LoadingDialog().dismiss();

        if (dioResponse.data['success'] == true) {
          Fluttertoast.showToast(
              msg: dioResponse.data['data']['msg'],
              backgroundColor: redcolor,
              fontSize: 15,
              textColor: Colors.white);
        } else
          Fluttertoast.showToast(
              msg: dioResponse.data['data']['msg'],
              backgroundColor: redcolor,
              fontSize: 15,
              textColor: Colors.white);
      }
    } catch (e) {
      LoadingDialog().dismiss();
      print(e);
      Get.snackbar("Wrong Credentials",
          "Something went wrong. Please check and try again");
    }
  }
}
