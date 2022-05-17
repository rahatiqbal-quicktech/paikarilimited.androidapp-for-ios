import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/screens/password_reset_widgets/pr_appbar.dart';

import '../Service/pr_services.dart';
import 'password_reset_widgets/password_reset_button.dart';
import 'password_reset_widgets/pr_textformfield.dart';

class NewPasswordScreen extends StatelessWidget {
  NewPasswordScreen({Key? key}) : super(key: key);
  static final _formKey = GlobalKey<FormState>();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                  "Set New Password",
                  style: GoogleFonts.openSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                whitespace(context, 4, 0),
                Text(
                  "Set a new password. Enter the email address and the code you recieved.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                whitespace(context, 5, 0),
                // SizedBox(
                //     // height: 40,
                //     width: double.infinity,
                //     child: PasswordResetTextFormField(
                //       hint: "Email Address",
                //       contr: emailController,
                //       validator: "Enter Email",
                //     )),
                // whitespace(context, 1.5, 0),
                // SizedBox(
                //     // height: 40,
                //     width: double.infinity,
                //     child: PasswordResetTextFormField(
                //       hint: "Code",
                //       contr: codeController,
                //       validator: "Enter Code",
                //     )),
                // whitespace(context, 1.5, 0),
                SizedBox(
                    // height: 50,
                    width: double.infinity,
                    child: PasswordResetTextFormField(
                      hint: "New Password",
                      contr: passwordController,
                      validator: "Set a new password",
                    )),
                whitespace(context, 1.5, 0),
                SizedBox(
                  width: double.infinity,
                  child: PasswordResetButton(
                      formkey: _formKey,
                      route: () {
                        PasswordResetService()
                            .setPassword(pass: passwordController.text);
                      },
                      text: "Set My Password"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
