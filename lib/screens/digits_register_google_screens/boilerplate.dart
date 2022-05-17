import 'package:flutter/material.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Boilerplate extends StatefulWidget {
  const Boilerplate({Key? key}) : super(key: key);

  @override
  State<Boilerplate> createState() => BoilerplateState();
}

class BoilerplateState extends State<Boilerplate> {
  String? displayName;
  String? email;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    getGoogleInfos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          whitespace(context, 5, 0),
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl ??
                "https://icon-library.com/images/placeholder-image-icon/placeholder-image-icon-12.jpg"),
          ),
          Text("$displayName"),
          Text("$email"),
        ],
      )),
    );
  }

  getGoogleInfos() async {
    final spf = await SharedPreferences.getInstance();
    setState(() {
      displayName = spf.getString('displayName');
      email = spf.getString('googleEmailAddress');
      imageUrl = spf.getString('photoUrl');
    });
  }
}
