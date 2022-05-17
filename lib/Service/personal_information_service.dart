import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:androidapp/Models/customer_model.dart';
import 'package:androidapp/widgets/loading_dialog.dart';
import 'package:androidapp/main.dart';
import 'package:http/http.dart' as http;
import 'package:androidapp/Service/fetch_data_service.dart';

class PersonalInformationService {
  updateCustomer(
      {int? userId,
      String? newname,
      String? newemail,
      String? newphone}) async {
    Map<dynamic, dynamic> temp = {
      "first_name": newname,
      "email": newemail,
      "billing": {
        "first_name": newname,
        "phone": newphone,
      },
      "shipping": {"first_name": newname, "email": newemail, "phone": newphone}
    };
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
        FetchDataService().fetchData(uid: "$userId");
        return customerModelFromJson(response.body);
      } else {
        LoadingDialog().dismiss();
        return CustomerModel();
      }
    } on Exception catch (e) {
      LoadingDialog().dismiss();
      print(e);
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  _asyncFileUpload(String text, File file) async {
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", Uri.parse("<url>"));
    //add text fields
    request.fields["text_field"] = text;
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("file_field", file.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    if (response.statusCode == 200) {
      print("async file upload worked");
      print("from async file upload function");
    } else {}
  }

  // for profile picture upload, later stopped working due to api issues
  // final dio = Dio();
  // uplaodProfilPicture(File file) async{
  //   String fileName = file.path.split('/').last;
  //   FormData formData
  // }
}
