import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:androidapp/main.dart';
import 'package:androidapp/screens/password_reset_widgets/password_reset_button.dart';
import 'package:androidapp/screens/password_reset_widgets/pr_appbar.dart';
import 'package:androidapp/screens/passwordreset_new_password_screen.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/widgets/loading_dialog.dart';
import 'package:get/get.dart' as getPrefix;

class PasswordResetPhoneScreen extends StatefulWidget {
  const PasswordResetPhoneScreen({Key? key}) : super(key: key);

  @override
  State<PasswordResetPhoneScreen> createState() =>
      _PasswordResetPhoneScreenState();
}

class _PasswordResetPhoneScreenState extends State<PasswordResetPhoneScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  static final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  bool otpCodeVisible = false;
  bool timedButtonActtive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: passwordResetAppbar(titleText: "Reset Password"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                whitespace(context, 8, 0),
                Text(
                  "Forgot Your Password?",
                  style: GoogleFonts.openSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                whitespace(context, 4, 0),
                Text(
                  "Enter your registered phone number below. An OTP code will be sent to you.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                whitespace(context, 5, 0),
                TextFormField(
                  controller: phoneNoController,
                  decoration: InputDecoration(
                    hintText: "Enter Phone Number",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text("+88"),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Phone Number";
                    }
                    return null;
                  },
                ),
                whitespace(context, 1.5, 0),
                TextFormField(
                  controller: codeController,
                  decoration: InputDecoration(
                    hintText: "Enter Code ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return "Enter  code";
                  //   }
                  //   return null;
                  // },
                ),
                whitespace(context, 1.5, 0),
                SizedBox(
                  width: double.infinity,
                  child: PasswordResetButton(
                      formkey: _formKey,
                      route: () {
                        // Get.to(() => PasswordResetSreen());
                        // service.sendEmail(mail: emailController.text);
                        LoadingDialog().show(context);
                        sendOtp(phoneNoController.text, context);
                      },
                      text: "Rescue Me"),
                ),
                whitespace(context, 1.5, 0),
                SizedBox(
                  width: double.infinity,
                  child: PasswordResetButton(
                      formkey: _formKey,
                      route: () {
                        // Get.to(() => PasswordResetSreen());
                        // service.sendEmail(mail: emailController.text);
                        LoadingDialog().show(context);
                        verifyCode(context);
                      },
                      text: "Verify code"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //////////////////////////////////////
  ///
  final dio = Dio();
  String baseUrl = "https://paikarilimited.com/wp-json/digits/v1/";
  var _auth = 'Basic ' +
      base64Encode(
        utf8.encode('$woocommerceusername:$woocommercepassword'),
      );
  sendOtp(String mobileNumber, BuildContext context) async {
    LoadingDialog().show(context);
    Map<String, dynamic> data = {
      "countrycode": "+880",
      "mobileNo": mobileNumber,
      "type": "resetpass ",
    };
    var formData = FormData.fromMap(data);

    String endPoint = "send_otp";
    String fullUrl = baseUrl + endPoint;

    try {
      final response = await dio.post(fullUrl,
          data: formData,
          options: Options(
            headers: <String, String>{'authorization': _auth},
          ));

      if (response.statusCode == 200) {
        LoadingDialog().dismiss();
        if (response.data['code'] != 1) {
          getPrefix.Get.snackbar(
              "Error while sending otp", "${response.data['message']}");
        } else if (response.data['code'] == 1) {
          verifyNumber();
        }
        print(response.data);
      }
    } catch (e) {
      print(e);
    }
  }

  resendOtp(String mobileNumber, BuildContext context) async {
    LoadingDialog().show(context);
    Map<String, dynamic> data = {
      "countrycode": "+880",
      "mobileNo": mobileNumber,
      "type": "login",
    };
    var formData = FormData.fromMap(data);

    String endPoint = "resend_otp";
    String fullUrl = baseUrl + endPoint;

    try {
      final response = await dio.post(fullUrl,
          data: formData,
          options: Options(
            headers: <String, String>{'authorization': _auth},
          ));

      if (response.statusCode == 200) {
        LoadingDialog().dismiss();
        verifyNumber();
        print(response.data);
      }
    } catch (e) {
      print(e);
    }
  }

  String verficationIdRecieved = "";
  int? _resendToken;
  void verifyNumber() {
    auth.verifyPhoneNumber(
      phoneNumber: "+880" + phoneNoController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) async {
          print("verficationCompleted  :  Logged in");
          // Get.offAll(() => OtpVerifyCodeScreen);
        });
      },
      verificationFailed: (FirebaseAuthException exception) {
        print(exception.message);
        getPrefix.Get.snackbar("Error verifyNumber", "${exception.message}");
      },
      codeSent: (String verficationId, int? resendToken) async {
        verficationIdRecieved = verficationId;
        _resendToken = resendToken;
        otpCodeVisible = true;
        setState(() {
          timedButtonActtive = true;
        });
        LoadingDialog().dismiss();
      },
      timeout: Duration(seconds: 30),
      forceResendingToken: _resendToken,
      codeAutoRetrievalTimeout: (String verificationId) {
        // ADDED LATER https://stackoverflow.com/questions/61132218/resend-otp-code-firebase-phone-authentication-in-flutter
        // REMOVE IF ERROR
        verficationIdRecieved = verificationId;
      },
    );
  }

  var firebaseToken;
  void verifyCode(BuildContext context) async {
    LoadingDialog().show(context);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verficationIdRecieved, smsCode: codeController.text);
    try {
      await auth.signInWithCredential(credential).then((value) {
        print("\n\n User UID should be   ${value.user!.uid}");
        print("verifyCode  :  Login successfull");
        value.user!.getIdToken().then((value) => {
              firebaseToken = value,
              print("This is the firebase token  ==  $firebaseToken"),
              verifyOtp(
                  mobileNo: phoneNoController.text,
                  otp: codeController.text,
                  ftoken: firebaseToken)
            });
        final snackBar = SnackBar(content: Text("Login Successful"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // getPrefix.Get.offAll(() => SetUsernameScreen());
      });
    } catch (e) {
      final snackBar = SnackBar(
          content: Text(
              "The sms code has expired or you entered a wrong code. Please re-send the code to try again."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  verifyOtp(
      {required String mobileNo,
      required String otp,
      required String ftoken}) async {
    Map<String, dynamic> data = {
      "countrycode": "+880",
      "mobileNo": mobileNo,
      "type": "resetpass",
      "otp": otp,
      "ftoken": ftoken
    };
    var formData = FormData.fromMap(data);

    String endPoint = "verify_otp";
    String fullUrl = baseUrl + endPoint;

    try {
      final response = await dio.post(fullUrl,
          data: formData,
          options: Options(
            headers: <String, String>{'authorization': _auth},
          ));

      if (response.statusCode == 200) {
        if (response.data['code'] != 1) {
          getPrefix.Get.snackbar(
              "Error while verifying the otp", "${response.data['message']}");
          print(" verifyOtp function  ==  ${response.data}");
        } else if (response.data['code'] == 1) {
          print(" verifyOtp function  ==  ${response.data}");
          LoadingDialog().dismiss();
          getPrefix.Get.off(() => PasswordResetNewPasswordScreen(
              mobileNo: mobileNo,
              otpCode: otp,
              firebaseToken: firebaseToken,
              verificationCode: 1));

          /// TO DO
          // loginWithOtp(mobileNo: mobileNo, otp: otp, ftoken: ftoken);
          // LoadingDialog().dismiss();
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
