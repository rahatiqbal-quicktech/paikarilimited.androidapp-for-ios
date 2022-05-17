// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart' as getPrefix;

// import 'package:androidapp/loading_dialog.dart';
// import 'package:androidapp/main.dart';
// import 'package:androidapp/otp_login/test.dart';

// class DigitsApiServices {
//   final dio = Dio();
//   String baseUrl = "https://paikarilimited.com/wp-json/digits/v1/";
//   var _auth = 'Basic ' +
//       base64Encode(
//         utf8.encode('$woocommerceusername:$woocommercepassword'),
//       );

//   sendOtp(String mobileNumber, BuildContext context) async {
//     LoadingDialog().show(context);
//     Map<String, dynamic> data = {
//       "countrycode": "+880",
//       "mobileNo": mobileNumber,
//       "type": "login",
//     };
//     var formData = FormData.fromMap(data);

//     String endPoint = "send_otp";
//     String fullUrl = baseUrl + endPoint;

//     try {
//       final response = await dio.post(fullUrl,
//           data: formData,
//           options: Options(
//             headers: <String, String>{'authorization': _auth},
//           ));

//       if (response.statusCode == 200) {
//         LoadingDialog().dismiss();
//         if (response.data['code'] != 1) {
//           // getPrefix.Get.snackbar("Error", "${response.data['message']}");
//           return 0;
//         } else if (response.data['code'] == 1) {
//           return 1;
//         }
//         print(response.data);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   FirebaseAuth auth = FirebaseAuth.instance;
//   bool otpCodeVisible = false;

//   String verficationIdRecieved = "";
//   void verifyNumber({required String phone}) {
//     auth.verifyPhoneNumber(
//         phoneNumber: "+88" + phone,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await auth.signInWithCredential(credential).then((value) async {
//             print("verficationCompleted  :  Logged in");
//             // Get.offAll(() => OtpVerifyCodeScreen);
//           });
//         },
//         verificationFailed: (FirebaseAuthException exception) {
//           print(exception.message);
//           getPrefix.Get.snackbar("Error", "${exception.message}");
//         },
//         codeSent: (String verficationId, int? resendToken) async {
//           verficationIdRecieved = verficationId;
//           // Test().setFalse();
//           // setState(() {});
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {},
//         timeout: Duration(seconds: 30));
//   }
// }
