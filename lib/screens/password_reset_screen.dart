import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/screens/password_reset_widgets/password_reset_button.dart';
import 'package:androidapp/screens/password_reset_widgets/pr_textformfield.dart';

import '../Service/pr_services.dart';

class PasswordResetSreen extends StatelessWidget {
  PasswordResetSreen({Key? key}) : super(key: key);
  static final _formKey = GlobalKey<FormState>();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size / 100;

    // final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reset Password",
          style: GoogleFonts.openSans(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
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
                  "Enter Your Code",
                  style: GoogleFonts.openSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                whitespace(context, 4, 0),
                Text(
                  "A password reset code has been sent to your email address. Enter the code below to reset your password.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                whitespace(context, 5, 0),
                // SizedBox(
                //     width: double.infinity,
                //     child: PasswordResetTextFormField(
                //       hint: "Email Address",
                //       contr: emailController,
                //       validator: "Enter Email",
                //     )),
                // whitespace(context, 1.5, 0),
                SizedBox(
                    width: double.infinity,
                    child: PasswordResetTextFormField(
                      hint: "Code",
                      contr: codeController,
                      validator: "Enter Code",
                    )),
                whitespace(context, 1.5, 0),
                SizedBox(
                  width: double.infinity,
                  child: PasswordResetButton(
                      formkey: _formKey,
                      route: () {
                        // Get.to(NewPasswordScreen());
                        PasswordResetService()
                            .sendCode(code: codeController.text);
                      },
                      text: "Submit"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
