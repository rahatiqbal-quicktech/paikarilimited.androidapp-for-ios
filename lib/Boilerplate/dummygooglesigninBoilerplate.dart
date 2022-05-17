// ignore_for_file: file_names

import 'package:flutter/material.dart';

class GoogleSignInBOilerplate extends StatefulWidget {
  const GoogleSignInBOilerplate({Key? key}) : super(key: key);

  @override
  _GoogleSignInBOilerplateState createState() =>
      _GoogleSignInBOilerplateState();
}

class _GoogleSignInBOilerplateState extends State<GoogleSignInBOilerplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          CircleAvatar(
            backgroundImage: Image.network("src").image,
            radius: 100,
          ),
          Text("Name")
        ],
      )),
    );
  }
}
