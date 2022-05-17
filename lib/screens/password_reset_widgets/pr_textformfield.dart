import 'package:flutter/material.dart';

class PasswordResetTextFormField extends StatelessWidget {
  final TextEditingController contr;
  final String? validator;
  final String? hint;
  PasswordResetTextFormField(
      {required this.contr, this.validator, this.hint, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: contr,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "${validator}";
        }
        return null;
      },
    );
  }
}
