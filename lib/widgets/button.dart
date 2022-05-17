import 'package:flutter/material.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';

class OtpButton extends StatelessWidget {
  final text;
  final GlobalKey<FormState> formkey;
  final void Function()? route;
  OtpButton(
      {required this.formkey,
      required this.route,
      required this.text,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: redcolor, textStyle: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: () {
        // Validate returns true if the form is valid, or false otherwise.

        if (formkey.currentState!.validate()) {
          route!();
        }
      },
      child: Text(text),
    );
  }
}
