import 'package:flutter/material.dart';

Widget confirmOrderTextFormField(
    {TextEditingController? thisController,
    String? hint,
    String? label,
    TextInputType? textInputType,
    bool? validationActive,
    String? validatorText,
    int? maxLine}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
    child: TextFormField(
        maxLines: maxLine,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
            hintText: hint,
            labelText: label),
        controller: thisController,
        keyboardType: textInputType,
        validator: (value) {
          if (value!.isEmpty) {
            return "Field Empty";
          }

          return "";
        }),
  );
}
