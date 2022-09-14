import 'dart:convert';
import 'dart:developer';

import 'package:androidapp/main.dart';
import 'package:androidapp/screens/loginscreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAccountService {
  deleteMyAccount() async {
    try {
      final spf = await SharedPreferences.getInstance();
      var temp = spf.getInt('userUid');
      // var id = GetSpfValues().getUserId();
      String basicAuth = 'Basic ' +
          base64Encode(
              utf8.encode('$woocommerceusername:$woocommercepassword'));

      final http.Response response = await http.delete(
        Uri.parse(
            "https://paikarilimited.com/wp-json/wc/v3/customers/$temp?force=true"),
        headers: <String, String>{'authorization': basicAuth},
      );
      log(response.body.toString());
      if (response.statusCode == 200) {
        final sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.remove('userUid');
        sharedPreferences.remove('userName');
        sharedPreferences.remove('photoUrl');
        sharedPreferences.remove('houseaddress');
        sharedPreferences.remove('roadaddress');
        sharedPreferences.remove('areaaddress');

        Get.offAll(() => LoginScreen());
      } else {
        Fluttertoast.showToast(msg: "Error");
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
