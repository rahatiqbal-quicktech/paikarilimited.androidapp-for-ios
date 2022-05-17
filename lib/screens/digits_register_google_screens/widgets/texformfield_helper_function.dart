import 'package:flutter/material.dart';

Widget customTextformfield({
  TextEditingController? thisController,
  String? validatorText,
  String? hint,
}) {
  return TextFormField(
    // onChanged: authController.email,
    controller: thisController,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return validatorText;
      }
      return null;
    },
    decoration: InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      border: UnderlineInputBorder(
          borderSide: BorderSide(
        color: Colors.black,
      )),
      // labelText: 'Password',
      hintText: hint,
    ),
  );
}
