import 'package:flutter/material.dart';

Widget changeAddressCustomTextfield(
    String label,
    String hint,
    TextEditingController controller_,
    TextInputType textInputType,
    bool validation) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
    child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText: "$hint",
          labelText: "$label",
        ),
        controller: controller_,
        keyboardType: textInputType,
        validator: (value) {
          if (validation) {
            if (value!.isEmpty) {
              return "Field Empty";
            }
          }
          return null;
        }),
  );
}
