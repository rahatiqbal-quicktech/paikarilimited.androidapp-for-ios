import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:androidapp/screens/loginscreen.dart';
import 'package:androidapp/main.dart';
import 'package:androidapp/screens/new_password_screen.dart';
import 'package:androidapp/screens/password_reset_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordResetService {
  static var client = http.Client();
  final dio = Dio();

  String basicAuth = 'Basic ' +
      base64Encode(utf8.encode('$woocommerceusername:$woocommercepassword'));

  sendEmail({required String mail}) async {
    print("sendEmail $mail");

    final pref = await SharedPreferences.getInstance();
    pref.setString('resetPasswordEmail', mail);

    Map<String, dynamic> emailData = {"email": mail};

    try {
      var dioResponse = await dio.post(
          "https://paikarilimited.com/wp-json/bdpwr/v1/reset-password",
          data: emailData,
          options: Options(
            headers: <String, String>{'authorization': basicAuth},
          ));
      if (dioResponse.statusCode == 200) {
        print(dioResponse);
        Get.to(() => PasswordResetSreen());
      }
    } catch (e) {
      print(e);
      Get.snackbar("Wrong Email",
          "The email you entered is wrong or is not registered. Please check and try again");
    }
  }

  sendCode({required String code}) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('resetPasswordCode', code);
    String? email;
    email = pref.getString('resetPasswordEmail');
    print("send code function = $email");
    Map<String, dynamic> codeData = {"email": email, "code": code};
    try {
      var dioResponse = await dio.post(
          "https://paikarilimited.com/wp-json/bdpwr/v1/validate-code",
          data: codeData,
          options: Options(
            headers: <String, String>{'authorization': basicAuth},
          ));
      if (dioResponse.statusCode == 200) {
        print(dioResponse);
        Get.to(() => NewPasswordScreen());
      }
    } catch (e) {
      print(e);
      Get.snackbar("Invalid Info", "Wrong Email/Code.");
    }
  }

  setPassword({required String pass}) async {
    final pref = await SharedPreferences.getInstance();
    String? email;
    String? code;
    email = pref.getString('resetPasswordEmail');
    code = pref.getString('resetPasswordCode');
    print("set password function $email code = $code ");

    Map<String, dynamic> passwordData = {
      "email": email,
      "code": code,
      "password": pass
    };
    try {
      var dioResponse = await dio.post(
          "https://paikarilimited.com/wp-json/bdpwr/v1/set-password",
          data: passwordData,
          options: Options(
            headers: <String, String>{'authorization': basicAuth},
          ));
      if (dioResponse.statusCode == 200) {
        print(dioResponse);
        Get.to(() => LoginScreen());
      }
    } catch (e) {
      print(e);
      Get.snackbar("Invalid Info", "Wrong Email/Code.");
    }
  }
}
