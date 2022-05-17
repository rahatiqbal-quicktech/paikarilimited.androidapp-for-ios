import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar passwordResetAppbar({required String titleText}) {
  return AppBar(
    title: Text(
      titleText,
      style: GoogleFonts.openSans(color: Colors.black),
    ),
    backgroundColor: Colors.white,
    elevation: 1,
  );
}
