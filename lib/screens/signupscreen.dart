import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getPrefix;
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/Controllers/authcontroller.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/widgets/loading_dialog.dart';
import 'package:androidapp/main.dart';
import 'package:androidapp/Service/fetch_data_service.dart';
import 'package:androidapp/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_button/timer_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpCodeVisible = false;

  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size / 100;
    final authController = getPrefix.Get.put(Auth(), permanent: true);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              whitespace(context, 7, 0),
              GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back)),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/logos/paikari.jpg',
                  height: size.height * 15,
                ),
              ),
              // whitespace(context, 3.3, 0),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    whitespace(context, 10, 0),
                    TextFormField(
                      // onChanged: authController.firstname,
                      controller: nameController,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                        // labelText: 'Email/Mobile Number',
                        hintText: 'Your Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your name';
                        }
                        return null;
                      },
                    ),
                    whitespace(context, 1.1, 0),
                    TextFormField(
                      // onChanged: authController.email,
                      controller: userNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username is required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                        // labelText: 'Password',
                        hintText: 'Username*',
                      ),
                    ),
                    whitespace(context, 1.1, 0),
                    TextFormField(
                      // onChanged: authController.email,
                      controller: phoneNoController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mobile no is required';
                        }
                        return null;
                      },

                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text("+880"),
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
                    whitespace(context, 1.1, 0),
                    TextFormField(
                      onChanged: authController.email,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                        // labelText: 'Password',
                        hintText: 'Email (optional)',
                      ),
                    ),
                    whitespace(context, 1.1, 0),
                    TextFormField(
                      // onChanged: authController.password,
                      controller: passwordController,
                      obscureText: !_passwordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'You need to set up a password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            icon: Icon(_passwordVisible
                                ? Ionicons.eye
                                : Ionicons.eye_off)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                        // labelText: 'Password',
                        hintText: 'Password',
                      ),
                    ),
                    whitespace(context, 1.1, 0),
                    Visibility(
                      visible: otpCodeVisible,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: codeController,
                        decoration: InputDecoration(
                            hintText: "123456", labelText: "Code"),
                      ),
                    ),
                    whitespace(context, 3, 0),
                    // SizedBox(
                    //     width: double.infinity,
                    //     child: DarkButtton(
                    //         title: "Create Account",
                    //         onPressed: () {
                    //           if (_formKey.currentState!.validate()) {
                    //             _onLoading();
                    //             authController.signup();
                    //           }
                    //         })),
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
                                text: "Sign Up"),
                          ),
                    whitespace(context, 2, 0),
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

  bool buttonActive = true;

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

  bool timedButtonActtive = false;

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
        print("\n\n User UID should be   ${value.user!.uid}");
        print("verifyCode  :  Verify Code (Sign Up) successfull");
        value.user!.getIdToken().then((value) => {
              firebaseToken = value,
              print("This is the firebase token  ==  $firebaseToken"),
              verifyOtp(
                  mobileNo: phoneNoController.text,
                  otp: codeController.text,
                  ftoken: firebaseToken)
            });
        final snackBar = SnackBar(content: Text("Verify Code Successful"));
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
      "digits_reg_name": nameController.text,
      "digits_reg_countrycode": "+880",
      "digits_reg_mobile": phoneNoController.text,
      "digits_reg_password": passwordController.text,
      "digits_reg_username": userNameController.text,
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
