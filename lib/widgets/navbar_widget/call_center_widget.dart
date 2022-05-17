import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:url_launcher/url_launcher.dart';

class CallCenterWidget extends StatelessWidget {
  final Size? size;

  CallCenterWidget({this.size, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: redcolor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
            onPressed: () {
              _callNumber();
            },
            icon: Icon(
              Ionicons.call_outline,
              color: Colors.white,
            ),
            label: customTextWidget("Call", 15),
          ),
          TextButton.icon(
              onPressed: () {
                _launchUrl();
              },
              icon: Icon(
                Ionicons.mail_open,
                color: Colors.white,
              ),
              label: customTextWidget("Contact Us", 15)),
        ],
      ),
    );
  }

  final Uri _url = Uri.parse('https://paikarilimited.com/contact-us/');
  void _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }
}

Text customTextWidget(String text, double fontSize) {
  return Text(
    text,
    style: GoogleFonts.openSans(fontSize: fontSize, color: Colors.white),
  );
}

_callNumber() async {
  // const number = '+8801324437989'; //set the number here
  // bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  // print(res);
  launch("tel://01324437989");
}

// _launchURL() async {
//   const url = 'https://paikarilimited.com/';
//   try {
//     if (!await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   } catch (e) {
//     print(e);
//   }
// }

