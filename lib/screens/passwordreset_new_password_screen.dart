import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/Service/digits_pr_service.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/widgets/loading_dialog.dart';

class PasswordResetNewPasswordScreen extends StatefulWidget {
  final String mobileNo;
  final String otpCode;
  final String firebaseToken;
  final int verificationCode;
  PasswordResetNewPasswordScreen(
      {required this.mobileNo,
      required this.otpCode,
      required this.firebaseToken,
      required this.verificationCode,
      Key? key})
      : super(key: key);

  @override
  State<PasswordResetNewPasswordScreen> createState() =>
      _PasswordResetNewPasswordScreenState();
}

class _PasswordResetNewPasswordScreenState
    extends State<PasswordResetNewPasswordScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              whitespace(context, 8, 0),
              Text(
                "Set New Password",
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              whitespace(context, 5, 0),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "New Password",
                              labelText: "New Password"),
                          controller: passwordController,
                          validator: (val) {
                            if (val!.isEmpty) return 'Enter a new password';
                            return null;
                          }),
                      whitespace(context, 2, 0),
                      TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Confirm Password",
                              labelText: "Confirm Password"),
                          controller: confirmPasswordController,
                          validator: (val) {
                            if (val!.isEmpty) return 'Field Empty';
                            if (val != passwordController.text)
                              return 'Password Doesn\'t match';
                            return null;
                          }),
                      whitespace(context, 2, 0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: redcolor),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                LoadingDialog().show(context);
                                //TO DO
                                DigitsPasswordResetService()
                                    .resetPasswordMobile(
                                        mobileNo: widget.mobileNo,
                                        otpCode: widget.otpCode,
                                        firebaseToken: widget.firebaseToken,
                                        verificationCode:
                                            widget.verificationCode,
                                        pass: confirmPasswordController.text);
                              }
                            },
                            child: Text("Change Password")),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
