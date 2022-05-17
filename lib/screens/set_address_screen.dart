import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/screens/homescreen.dart';
import 'package:androidapp/functions/functions.dart';
import 'package:androidapp/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetAddressScreen extends StatefulWidget {
  const SetAddressScreen({Key? key}) : super(key: key);

  @override
  State<SetAddressScreen> createState() => _SetAddressScreenState();
}

class _SetAddressScreenState extends State<SetAddressScreen> {
  final houseController = TextEditingController();
  final areaController = TextEditingController();
  final roadController = TextEditingController();
  static final _formKey = GlobalKey<FormState>();

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
              whitespace(context, 10, 0),
              Text("Almost there.",
                  style: GoogleFonts.openSans(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )),
              whitespace(context, 1, 0),
              Text("Set up your address -"),
              whitespace(context, 5, 0),
              Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      customtextfield(
                          "Flat, Floor and House No. ",
                          "Flat, Floor and House No.",
                          houseController,
                          TextInputType.streetAddress),
                      customtextfield(
                          "Road, Block or Avenue",
                          "Road, Block or Avenue",
                          roadController,
                          TextInputType.streetAddress),
                      customtextfield("Area Details", "Area Details",
                          areaController, TextInputType.streetAddress),
                      whitespace(context, 1.5, 0),
                    ],
                  )),
              whitespace(context, 1, 0),
              SizedBox(
                  width: double.infinity,
                  child: OtpButton(
                      formkey: _formKey,
                      route: () {
                        OtpFunctions().otpSetAddress(houseController.text,
                            roadController.text, areaController.text);
                      },
                      text: "Done")),
            ],
          ),
        ),
      )),
    );
  }

  Widget customtextfield(String label, String hint,
      TextEditingController controller_, TextInputType textInputType) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: TextFormField(
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: hint,
              labelText: label),
          controller: controller_,
          keyboardType: textInputType,
          validator: (value) {
            if (value!.isEmpty) {
              return "Field Empty";
            }
            return null;
          }),
    );
  }

  String? fulladdress;
  setaddress(String house, String road, String area) async {
    final spref = await SharedPreferences.getInstance();
    spref.setString('houseaddress', house);
    spref.setString('roadaddress', road);
    spref.setString('areaaddress', area);
    fulladdress = spref.getString('houseaddress').toString() +
        " " +
        spref.getString('areaaddress').toString();
    print("This is from sharedpreference = " + fulladdress.toString());
    Get.offAll(() => HomeScreen());
  }
}
