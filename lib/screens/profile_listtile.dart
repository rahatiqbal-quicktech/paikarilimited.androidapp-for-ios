import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';

class ProfileListTile extends StatelessWidget {
  IconData? leadingIcon;
  IconData? trailingIcon;
  String? title;
  Function? function;
  ProfileListTile({this.leadingIcon, this.title, this.function, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: redcolor,
      ),
      title: Text(
        "$title",
        style: GoogleFonts.openSans(),
      ),
      trailing: Icon(
        Ionicons.chevron_forward,
        color: Colors.black,
      ),
      onTap: () {
        function!();
      },
    );
  }
}
