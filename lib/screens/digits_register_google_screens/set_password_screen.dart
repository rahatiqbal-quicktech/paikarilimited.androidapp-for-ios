import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/screens/digits_register_google_screens/functions/set_sharedpreference_google_function.dart';
import 'package:androidapp/screens/digits_register_google_screens/set_number_screen.dart';
import 'package:androidapp/screens/digits_register_google_screens/widgets/texformfield_helper_function.dart';
import 'package:androidapp/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StePasswordGoogleScreen extends StatefulWidget {
  const StePasswordGoogleScreen({Key? key}) : super(key: key);

  @override
  State<StePasswordGoogleScreen> createState() =>
      _StePasswordGoogleScreenState();
}

class _StePasswordGoogleScreenState extends State<StePasswordGoogleScreen> {
  String? displayName;
  String? email;
  String? imageUrl;
  String alternateImageUrl =
      "https://icon-library.com/images/placeholder-image-icon/placeholder-image-icon-12.jpg";

  @override
  void initState() {
    super.initState();
    getGoogleInfos();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              whitespace(context, 15, 0),
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                    imageUrl ?? alternateImageUrl,
                    scale: 8,
                  ),
                ),
              ),
              whitespace(context, 1, 0),
              Center(
                child: Text(
                  "${displayName}",
                  style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                ),
              ),
              whitespace(context, 5, 0),
              Text(
                "Set a secure password",
                style: GoogleFonts.openSans(),
              ),
              whitespace(context, 2, 0),
              Form(
                key: _formKey,
                child: customTextformfield(
                    thisController: passwordController,
                    hint: "Password*",
                    validatorText: "You have to set a password."),
              ),
              whitespace(context, 2, 0),
              SizedBox(
                width: double.infinity,
                child: OtpButton(
                    formkey: _formKey,
                    route: () {
                      setSharedPreferenceGoogle(
                          spfKey: "passwordGoogle",
                          texts: passwordController.text,
                          function: () {
                            Get.to(() => SetNumberGoogleScreen());
                          });
                    },
                    text: "Next"),
              ),
            ],
          ),
        ),
      ),
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
