import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/screens/set_username_screen.dart';
import 'package:androidapp/widgets/button.dart';

class OtpVerifyCodeScreen extends StatefulWidget {
  const OtpVerifyCodeScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerifyCodeScreen> createState() => _OtpVerifyCodeScreenState();
}

class _OtpVerifyCodeScreenState extends State<OtpVerifyCodeScreen> {
  static final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                style: GoogleFonts.openSans(fontSize: 17),
              ),
              whitespace(context, 1, 0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: codeController,
                      decoration: InputDecoration(
                          hintText: "Mobile Number",
                          labelText: "Mobile Number"),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OtpButton(
                          formkey: _formKey,
                          route: () {
                            verifyCode();
                          },
                          text: "Send Code"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String verficationIdRecieved = "";
  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verficationIdRecieved, smsCode: codeController.text);
    try {
      await auth.signInWithCredential(credential).then((value) {
        print("\n\n User UID should be${value.user!.uid}");
        print("verifyCode  :  Login successfull");
        final snackBar = SnackBar(content: Text("Login Successful"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Get.offAll(() => SetUsernameScreen());
      });
    } catch (e) {
      final snackBar = SnackBar(
          content: Text(
              "The sms code has expired. Please re-send the code to try again."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
