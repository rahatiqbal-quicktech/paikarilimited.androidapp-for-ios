import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart' as getPrefix;
import 'package:google_fonts/google_fonts.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/widgets/loading_dialog.dart';
import 'package:androidapp/main.dart';
import 'package:androidapp/Service/fetch_data_service.dart';
import 'package:androidapp/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetNumberGoogleScreen extends StatefulWidget {
  const SetNumberGoogleScreen({Key? key}) : super(key: key);

  @override
  State<SetNumberGoogleScreen> createState() => _SetNumberGoogleScreenState();
}

class _SetNumberGoogleScreenState extends State<SetNumberGoogleScreen> {
  String? displayName;
  String? email;
  String? imageUrl;
  String alternateImageUrl =
      "https://icon-library.com/images/placeholder-image-icon/placeholder-image-icon-12.jpg";

  @override
  void initState() {
    super.initState();
    getGoogleInfos();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpCodeVisible = false;
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              whitespace(context, 15, 0),
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                    imageUrl ?? alternateImageUrl,
                    scale: 8,
                  ),
                ),
              ),
              whitespace(context, 1, 0),
              Center(
                child: Text(
                  "${displayName}",
                  style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                ),
              ),
              whitespace(context, 2, 0),
              Text(
                "One last thing. \n Write down your mobile number below. A OTP will be sent to you to. ",
                style: GoogleFonts.openSans(
                  fontSize: 15,
                ),
              ),
              whitespace(context, 2, 0),
              Form(
                key: _formKey,
                child: TextFormField(
                  // onChanged: authController.email,
                  controller: mobileController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mobile no is required';
                    }
                    return null;
                  },

                  decoration: const InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text("+88"),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                    // labelText: 'Password',
                    hintText: 'Mobile Number',
                  ),
                ),
              ),
              whitespace(context, 2, 0),
              whitespace(context, 1.1, 0),
              Visibility(
                visible: otpCodeVisible,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: codeController,
                  decoration:
                      InputDecoration(hintText: "123456", labelText: "Code"),
                ),
              ),
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
                            sendOtp(mobileController.text, context);
                          },
                          text: "Send OTP"),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  String? usernameGoogle;
  String? passwordGoogle;

  getGoogleInfos() async {
    final spf = await SharedPreferences.getInstance();
    setState(() {
      displayName = spf.getString('displayName');
      email = spf.getString('googleEmailAddress');
      imageUrl = spf.getString('photoUrl');
      usernameGoogle = spf.getString('usernameGoogle');
      passwordGoogle = spf.getString('passwordGoogle');
    });
  }

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
      "type": "register",
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
        // LoadingDialog().dismiss();
        if (response.data['code'] != 1) {
          LoadingDialog().dismiss();
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

  String verficationIdRecieved = "";
  void verifyNumber() {
    auth.verifyPhoneNumber(
        phoneNumber: "+88" + mobileController.text,
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
          otpCodeVisible = true;
          setState(() {});
          LoadingDialog().dismiss();
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: Duration(seconds: 30));
  }

  var firebaseToken;
  void verifyCode(BuildContext context) async {
    LoadingDialog().show(context);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verficationIdRecieved, smsCode: codeController.text);
    try {
      await auth.signInWithCredential(credential).then((value) {
        print("\n\n User UID should be   ${value.user!.uid}");
        print("verifyCode  :  Verify Code (Sign Up) successfull");
        value.user!.getIdToken().then((value) => {
              firebaseToken = value,
              print("This is the firebase token  ==  $firebaseToken"),
              verifyOtp(
                  mobileNo: mobileController.text,
                  otp: codeController.text,
                  ftoken: firebaseToken)
            });
        final snackBar = SnackBar(content: Text("Verify Code Successful"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // getPrefix.Get.offAll(() => SetUsernameScreen());
      });
    } catch (e) {
      print(e);
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
      "type": "register",
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
          LoadingDialog().dismiss();
          getPrefix.Get.snackbar(
              "Error while verifying the otp", "${response.data['message']}");
          print(" verifyOtp function  ==  ${response.data}");
        } else if (response.data['code'] == 1) {
          print(" verifyOtp function  ==  ${response.data}");
          // loginWithOtp(mobileNo: mobileNo, otp: otp, ftoken: ftoken);
          // LoadingDialog().dismiss();
          signUpWithOtp(mobileNo: mobileNo, otp: otp, ftoken: ftoken);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  signUpWithOtp({
    required String mobileNo,
    required String otp,
    required String ftoken,
  }) async {
    final spf = await SharedPreferences.getInstance();

    Map<String, dynamic> data = {
      "digits_reg_name": displayName,
      "digits_reg_countrycode": "+880",
      "digits_reg_mobile": mobileController.text,
      "digits_reg_password": passwordGoogle,
      "digits_reg_username": usernameGoogle,
      "digits_reg_email": email,
      "otp": otp,
      "ftoken": ftoken
    };
    var formData = FormData.fromMap(data);
    String endPoint = "create_user";
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
            "${response.data['data']['msg']}",
          );
        } else if (response.data['success'] == true) {
          print("signUpWithOtp function  ==  ${response.data}");
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
