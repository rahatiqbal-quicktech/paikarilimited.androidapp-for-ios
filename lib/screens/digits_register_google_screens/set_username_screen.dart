import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/screens/digits_register_google_screens/functions/set_sharedpreference_google_function.dart';
import 'package:androidapp/screens/digits_register_google_screens/set_password_screen.dart';
import 'package:androidapp/screens/digits_register_google_screens/widgets/texformfield_helper_function.dart';
import 'package:androidapp/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetUsernameGoogleScreen extends StatefulWidget {
  const SetUsernameGoogleScreen({Key? key}) : super(key: key);

  @override
  State<SetUsernameGoogleScreen> createState() =>
      _SetUsernameGoogleScreenState();
}

class _SetUsernameGoogleScreenState extends State<SetUsernameGoogleScreen> {
  String? displayName;
  String? email;
  String? imageUrl;
  String alternateImageUrl =
      "https://icon-library.com/images/placeholder-image-icon/placeholder-image-icon-12.jpg";

  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getGoogleInfos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              whitespace(context, 5, 0),
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(imageUrl ?? alternateImageUrl),
                ),
              ),
              whitespace(context, 3, 0),
              Text(
                "Howdy $displayName, let's get your account ready for Paikari Limited.",
                style: GoogleFonts.openSans(
                    fontSize: 18,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w600),
              ),
              whitespace(context, 2, 0),
              Text(
                "Give yourself a username.",
                style: GoogleFonts.openSans(),
              ),
              whitespace(context, 2, 0),
              Form(
                key: _formKey,
                child: customTextformfield(thisController: userNameController),
              ),
              whitespace(context, 2, 0),
              SizedBox(
                width: double.infinity,
                child: OtpButton(
                    formkey: _formKey,
                    route: () {
                      setSharedPreferenceGoogle(
                          spfKey: "usernameGoogle",
                          texts: userNameController.text,
                          function: () {
                            Get.to(() => StePasswordGoogleScreen());
                          });
                    },
                    text: "Next"),
              ),
            ],
          ),
        ),
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

  setSharedPreference() async {
    final spf = await SharedPreferences.getInstance();
    spf.setString('username_google', userNameController.text);
    print("setSharedPreference print :  ${spf.getString('username_google')}");
  }
}
