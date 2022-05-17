import 'dart:convert';

import 'package:get/get.dart';
import 'package:androidapp/widgets/loading_dialog.dart';
import 'package:androidapp/main.dart';
import 'package:http/http.dart' as http;
import 'package:androidapp/screens/profilescreen.dart';

class ChangePasswordService {
  Future changePassword(int? userId, String? newPassword) async {
    Map<dynamic, dynamic> temp = {"password": "$newPassword"};
    var bodydata = jsonEncode(temp);
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('$woocommerceusername:$woocommercepassword'));

    try {
      final response = await http.put(
          Uri.parse(
              'https://paikarilimited.com/wp-json/wc/v3/customers/$userId'),
          body: bodydata,
          headers: <String, String>{
            'authorization': basicAuth,
            "Content-Type": "application/json"
          });

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        LoadingDialog().dismiss();
        print(data.toString());
        Get.to(() => ProfileScreen());
      } else {
        LoadingDialog().dismiss();

        Get.snackbar("Ooops", "Something went wrong.");
      }
    } catch (e) {
      LoadingDialog().dismiss();
      print(e);
      Get.snackbar("Ooops", "Something went wrong.");
    }
  }
}
