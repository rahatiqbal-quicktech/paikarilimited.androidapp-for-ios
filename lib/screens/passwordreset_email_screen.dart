import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/widgets/loading_dialog.dart';
import 'package:androidapp/Service/digits_pr_service.dart';
import 'package:androidapp/Service/pr_services.dart';
import 'package:androidapp/screens/password_reset_widgets/password_reset_button.dart';
import 'package:androidapp/screens/password_reset_widgets/pr_appbar.dart';
import 'package:androidapp/screens/password_reset_widgets/pr_textformfield.dart';

class PasswordresetEmailScreen extends StatefulWidget {
  const PasswordresetEmailScreen({Key? key}) : super(key: key);

  @override
  State<PasswordresetEmailScreen> createState() =>
      _PasswordresetEmailScreenState();
}

class _PasswordresetEmailScreenState extends State<PasswordresetEmailScreen> {
  static final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PasswordResetService service = PasswordResetService();
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
                  "Enter your registered email address below. A code will be sent to that email address.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                whitespace(context, 5, 0),
                SizedBox(
                    // height: 40,
                    width: double.infinity,
                    child: PasswordResetTextFormField(
                      hint: "Enter Email Address",
                      contr: emailController,
                      validator: "Enter Email",
                    )),
                whitespace(context, 1.5, 0),
                SizedBox(
                  width: double.infinity,
                  child: PasswordResetButton(
                      formkey: _formKey,
                      route: () {
                        // Get.to(() => PasswordResetSreen());
                        // service.sendEmail(mail: emailController.text);
                        LoadingDialog().show(context);
                        DigitsPasswordResetService()
                            .resetPassword(email: emailController.text);
                      },
                      text: "Rescue Me"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
