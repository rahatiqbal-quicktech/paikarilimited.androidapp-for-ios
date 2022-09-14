import 'package:androidapp/Dependencies/dependencies.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/screens/apple_signup/apple_signup_password_screen.dart';
import 'package:androidapp/screens/digits_register_google_screens/widgets/texformfield_helper_function.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppleSignupUsernameScreen extends StatelessWidget {
  AppleSignupUsernameScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController appleUsernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  whitespace(context, 5, 0),
                  Icon(
                    Icons.apple,
                    size: 35,
                  ),
                  whitespace(context, 2, 0),
                  Text("Signing up with apple"),
                  whitespace(context, 5, 0),
                  // Text(
                  //   "Let's get your account ready for Paikari Limited.",
                  //   style: GoogleFonts.openSans(
                  //       fontSize: 18,
                  //       color: Colors.grey.shade800,
                  //       fontWeight: FontWeight.w600),
                  // ),
                  whitespace(context, 2.3, 0),
                  Align(alignment: Alignment.topLeft, child: Text("Your name")),
                  customTextformfield(
                    thisController: nameController,
                    hint: "Name",
                  ),
                  whitespace(context, 2.3, 0),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text("Select a unique username")),
                  customTextformfield(
                    thisController: appleUsernameController,
                    hint: "User name",
                  ),
                  whitespace(context, 2.3, 0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: redcolor,
                          textStyle: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          appleSignUpController
                              .getAppleUserName(appleUsernameController.text);
                          appleSignUpController
                              .getDisplayName(nameController.text);
                          Get.to(() => AppleSignUpPasswordScreen());
                        }
                      },
                      child: Text("Next"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
