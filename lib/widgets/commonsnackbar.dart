import 'package:flutter/material.dart';

commonsnackbar(String message, int duration, BuildContext context) {
  final snackBar = SnackBar(
      duration: Duration(seconds: duration), content: Text("$message"));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
