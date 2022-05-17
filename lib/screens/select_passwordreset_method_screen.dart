import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/screens/passwordreset_phone_screen.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/screens/passwordreset_email_screen.dart';


class SelectPasswordResetMethodScreen extends StatelessWidget {
  const SelectPasswordResetMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                whitespace(context, 10, 0),
                Text(
                  "Forgot Password? No Worries",
                  style: GoogleFonts.openSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                whitespace(context, 2, 0),
                Text(
                  "How would you love to reset your password?",
                  style: GoogleFonts.openSans(
                    fontSize: 15,
                  ),
                ),
                whitespace(context, 5, 0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: redcolor,
                        textStyle: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Get.to(() => PasswordresetEmailScreen());
                    },
                    child: Text("Via Email/Username"),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: redcolor,
                        textStyle: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Get.to(() => PasswordResetPhoneScreen());
                    },
                    child: Text("Via Phone No"),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
