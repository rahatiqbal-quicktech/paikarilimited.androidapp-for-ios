import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getPrefix;
import 'package:google_fonts/google_fonts.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/widgets/loading_dialog.dart';
import 'package:androidapp/Service/fetch_data_service.dart';
import 'package:androidapp/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_button/timer_button.dart';

import '../main.dart';

class OtpLoginScreen extends StatefulWidget {
  const OtpLoginScreen({Key? key}) : super(key: key);

  @override
  State<OtpLoginScreen> createState() => _OtpLoginScreenState();
}

class _OtpLoginScreenState extends State<OtpLoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  static final _formKey = GlobalKey<FormState>();

  TextEditingController phoneNoController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  bool otpCodeVisible = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size / 100;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              whitespace(context, 15, 0),
              Text(
                "Sign In with OTP",
                style: GoogleFonts.openSans(fontSize: 20),
              ),
              whitespace(context, 1.5, 0),
              Text(
                "Enter your mobile number below -",
                style: GoogleFonts.openSans(fontSize: 15),
              ),
              whitespace(context, 3, 0),
              Text(
                "Make sure that you enter the mobile number currectly and with country code '+880'. For example +88017xxxxxxx",
                style: GoogleFonts.openSans(
                  fontSize: 11.5,
                  color: Colors.grey,
                ),
              ),
              whitespace(context, 1, 0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Container(
                    //   alignment: Alignment.bottomLeft,
                    //   height: 35,
                    //   color: Colors.red,
                    //   child: Text("+88"),
                    // ),
                    SizedBox(
                      // width: size.width * 70,
                      child: TextFormField(
                        controller: phoneNoController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text("+880"),
                          ),
                        ),
                      ),
                    ),

                    whitespace(context, 1, 0),
                    Visibility(
                      visible: otpCodeVisible,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: codeController,
                        decoration: InputDecoration(
                            hintText: "123456", labelText: "Code"),
                      ),
                    ),
                    whitespace(context, 2, 0),
                    otpCodeVisible
                        ? SizedBox(
                            width: double.infinity,
                            child: OtpButton(
                                formkey: _formKey,
                                route: () {
                                  verifyCode(context);
                                },
                                text: "Verify Code"),
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: OtpButton(
                                formkey: _formKey,
                                route: () {
                                  sendOtp(phoneNoController.text, context);
                                },
                                text: "Send Code"),
                          ),
                    timedButtonActtive
                        ? SizedBox(
                            width: double.infinity,
                            child: TimerButton(
                                label: "Send OTP Again",
                                timeOutInSeconds: 60,
                                onPressed: () {
                                  print("timedButton worked");
                                  resendOtp(phoneNoController.text, context);
                                },
                                disabledColor: Colors.grey,
                                color: redcolor,
                                disabledTextStyle: GoogleFonts.openSans(),
                                activeTextStyle:
                                    GoogleFonts.openSans(color: Colors.white)),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool timedButtonActtive = false;

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
      "type": "login",
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
        LoadingDialog().dismiss();
        print(exception.message);
        getPrefix.Get.snackbar("Error verifyNumber",
            "Please check if your phone number is right. ${exception.message}");
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
        // print("\n\n User UID should be   ${value.user!.uid}");
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
      "type": "login",
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
          loginWithOtp(mobileNo: mobileNo, otp: otp, ftoken: ftoken);
          // LoadingDialog().dismiss();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  loginWithOtp({
    required String mobileNo,
    required String otp,
    required String ftoken,
  }) async {
    final spf = await SharedPreferences.getInstance();

    Map<String, dynamic> data = {
      "user": mobileNo,
      "countrycode": "+880",
      "otp": otp,
      "ftoken": ftoken
    };
    var formData = FormData.fromMap(data);
    String endPoint = "login_user";
    String fullUrl = baseUrl + endPoint;

    try {
      final response = await dio.post(fullUrl,
          data: formData,
          options: Options(
            headers: <String, String>{'authorization': _auth},
          ));

      if (response.statusCode == 200) {
        if (response.data['success'] != true) {
          LoadingDialog().dismiss();
          print("loginWithOtp function  ==  ${response.data}");
          getPrefix.Get.snackbar(
            "Error while logging in with otp",
            "${response.data['message']}",
          );
        } else if (response.data['success'] == true) {
          print("loginWithOtp function  ==  ${response.data}");
          spf.setString(
              'otpAccessToken', response.data['data']['access_token']);

          FetchDataService().fetchData(uid: response.data['data']['user_id']);
        }
        // print(response.data);
      }
    } catch (e) {
      print(e);
    }
  }
}
