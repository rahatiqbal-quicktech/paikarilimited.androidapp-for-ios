import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/widgets/button.dart';
import 'package:androidapp/functions/functions.dart';


class SetUsernameScreen extends StatefulWidget {
  const SetUsernameScreen({Key? key}) : super(key: key);

  @override
  State<SetUsernameScreen> createState() => _SetUsernameScreenState();
}

class _SetUsernameScreenState extends State<SetUsernameScreen> {
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  OtpFunctions _otpFunctions = OtpFunctions();

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size / 100;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              whitespace(context, 8, 0),
              Text("Setting things up\nfor you.",
                  style: GoogleFonts.openSans(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )),
              whitespace(context, 5, 0),
              Text("Tell us your name -"),
              // whitespace(context, 1, 0),
              Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "What should we call you?",
                        ),
                      )
                    ],
                  )),
              whitespace(context, 3, 0),

              SizedBox(
                  width: double.infinity,
                  child: OtpButton(
                      formkey: _formKey,
                      route: () {
                        OtpFunctions().otpSetUsername(nameController.text);
                      },
                      text: "Next")),
            ],
          ),
        ),
      )),
    );
  }
}
