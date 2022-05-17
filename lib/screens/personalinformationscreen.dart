import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/Models/personal_information_model.dart';
import 'package:androidapp/Service/personal_information_service.dart';
import 'package:androidapp/main.dart';

import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/widgets/loading_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PersonalInformationScreen extends StatefulWidget {
  final String? name;
  final String? phone;
  final String? email;
  PersonalInformationScreen({this.name, this.email, this.phone, Key? key})
      : super(key: key);

  @override
  _PersonalInformationScreenState createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    setuserid();
    nameController.text = widget.name ?? '';
    phoneController.text = widget.phone ?? '';
    emailController.text = widget.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size / 100;

    return Scaffold(
      appBar: CommonAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              whitespace(context, 3, 0),
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://www.pngitem.com/pimgs/m/24-248631_blue-profile-logo-png-transparent-png.png'),
                  radius: 40,
                ),
              ),
              // whitespace(context, 2, 0),
              // TextButton.icon(
              //   onPressed: () {
              //     pickImage();
              //   },
              //   label: Text(
              //     "Change Profile Picture",
              //     style: GoogleFonts.openSans(color: Colors.black),
              //   ),
              //   icon: Icon(
              //     Ionicons.add_circle,
              //     color: redcolor,
              //   ),
              // ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      whitespace(context, 1.5, 0),
                      customtextfield("Name", "What do people call you?",
                          nameController, TextInputType.name),
                      customtextfield("Phone", "Your Contact Number.",
                          phoneController, TextInputType.number),
                      customtextfield("E-mail", "Set your e-mail.",
                          emailController, TextInputType.emailAddress),
                      whitespace(context, 2, 0),
                    ],
                  )),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      LoadingDialog().show(context);
                      PersonalInformationService().updateCustomer(
                          userId: userid,
                          newname: nameController.text,
                          newemail: emailController.text,
                          newphone: phoneController.text);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Data Saved')),
                      );
                    }
                  },
                  child: Text("Save"),
                  style: ElevatedButton.styleFrom(
                    primary: redcolor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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

  int? userid;

  setuserid() async {
    final preference = await SharedPreferences.getInstance();
    setState(() {
      userid = preference.getInt('userUid');
    });
    print(userid);
  }

  final dio = new Dio();
  Future<PersonalInformationModel?> getPersonalInformation() async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('$woocommerceusername:$woocommercepassword'));

    String? url = "https://paikarilimited.com/wp-json/wc/v3/customers/346";

    try {
      final response = await http.get(Uri.parse(url),
          headers: <String, String>{'authorization': basicAuth});

      if (response.statusCode == 200) {
        return personalInformationModelFromJson(response.body);
      } else {
        return personalInformationModelFromJson(response.body);
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on Exception catch (e) {
      print(e);
    }
  }
}
