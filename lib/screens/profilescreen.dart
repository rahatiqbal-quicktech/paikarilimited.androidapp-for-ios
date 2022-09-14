import 'dart:developer';

import 'package:androidapp/Service/delete_account_service.dart';
import 'package:androidapp/Service/get_spf_values.dart';
import 'package:androidapp/screens/delete_account_confirmation_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/widgets/loading_dialog.dart';
import 'package:androidapp/screens/change_password_screen.dart';
import 'package:androidapp/screens/loginscreen.dart';
import 'package:androidapp/screens/manageaddressscreen.dart';
import 'package:androidapp/screens/orderhistoryscreen.dart';
import 'package:androidapp/screens/personalinformationscreen.dart';
import 'package:androidapp/screens/profile_listtile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  String? name;
  ProfileScreen({Key? key, this.name}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int? userid;

  @override
  void initState() {
    super.initState();
    getProfileInformation();
    setuserid();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size / 100;
    return Scaffold(
      appBar: CommonAppBar(context),
      body: Column(
        children: [
          Container(
            height: size.height * 27,
            width: double.infinity,
            // color: Colors.grey.shade100,
            child: Column(
              children: [
                whitespace(context, 5, 0),
                CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(imageUrl ??
                        'https://www.pngitem.com/pimgs/m/24-248631_blue-profile-logo-png-transparent-png.png')),
                whitespace(context, 1.5, 0),
                Text(
                  "$userName",
                  style: GoogleFonts.openSans(),
                )
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Ionicons.person_circle_outline,
              color: redcolor,
            ),
            title: Text(
              "Personal Information",
              style: GoogleFonts.openSans(),
            ),
            trailing: Icon(
              Ionicons.chevron_forward,
              color: Colors.black,
            ),
            onTap: () {
              Get.to(PersonalInformationScreen(
                name: firstName,
                email: email,
                phone: phone,
              ));
            },
          ),
          ProfileListTile(
            leadingIcon: Ionicons.finger_print_outline,
            title: "Change Password",
            function: () {
              Get.to(() => ChangePasswordScreen());
            },
          ),
          ListTile(
            leading: Icon(
              Ionicons.home_outline,
              color: redcolor,
            ),
            title: Text(
              "Manage Address",
              style: GoogleFonts.openSans(),
            ),
            trailing: Icon(
              Ionicons.chevron_forward,
              color: Colors.black,
            ),
            onTap: () {
              Get.to(ManagAddressScreen());
            },
          ),
          ListTile(
            leading: Icon(
              Ionicons.receipt_outline,
              color: redcolor,
            ),
            title: Text(
              "Order History",
              style: GoogleFonts.openSans(),
            ),
            trailing: Icon(
              Ionicons.chevron_forward,
              color: Colors.black,
            ),
            onTap: () {
              Get.to(OrderHistoryScreen(
                id: userid.toString(),
              ));
            },
          ),
          ListTile(
            leading: Icon(
              Ionicons.trash,
              color: redcolor,
            ),
            title: Text(
              "Delete My Account",
              style: GoogleFonts.openSans(),
            ),
            trailing: Icon(
              Ionicons.chevron_forward,
              color: Colors.black,
            ),
            onTap: () async {
              // DeleteAccountService().deleteMyAccount();
              // log(GetSpfValues().getUserId().toString());
              Get.to(() => DeleteAccountConfirmationScreen());
            },
          ),
          Spacer(),
          ListTile(
            leading: Icon(
              Ionicons.log_out_outline,
              color: redcolor,
            ),
            title: Text(
              "Logout",
              style: GoogleFonts.openSans(),
            ),
            onTap: () {
              userSignOut();
            },
          ),
        ],
      ),
    );
  }

  var imageUrl;
  var userName;
  String? firstName;
  String? email;
  String? phone;
  getProfileInformation() async {
    final sharedPF = await SharedPreferences.getInstance();
    setState(() {
      imageUrl = sharedPF.getString('photoUrl');
      userName = sharedPF.getString('userName');
      firstName = sharedPF.getString('first_name');
      email = sharedPF.getString('email');
      phone = sharedPF.getString('phone');
    });
  }

  userSignOut() async {
    LoadingDialog().show(context);
    final sharedPreferences = await SharedPreferences.getInstance();

    final dio = Dio();

    String? accessToken;
    accessToken = sharedPreferences.getString('otpAccessToken') ?? null;

    // dio.options.headers["Authorization"] = "Bearer ${accessToken}";
    String url = "https://paikarilimited.com/wp-json/digits/v1/logout";

    try {
      final response = await dio.post(url,
          options:
              Options(headers: {"Authorization": "Bearer ${accessToken}"}));
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        LoadingDialog().dismiss();
        if (response.data['success'] == true) {
          sharedPreferences.remove('userUid');
          sharedPreferences.remove('userName');
          sharedPreferences.remove('photoUrl');
          sharedPreferences.remove('houseaddress');
          sharedPreferences.remove('roadaddress');
          sharedPreferences.remove('areaaddress');
          print('userSignout function');
          Get.offAll(LoginScreen());
        } else if (response.data['success'] == false) {
          Get.snackbar("Unable to log you out",
              "Something went wrong. Please try again later.");
        }
      }
    } catch (e) {
      LoadingDialog().dismiss();
      print(e);
    }
  }

  setuserid() async {
    final preference = await SharedPreferences.getInstance();
    setState(() {
      userid = preference.getInt('userUid');
    });
    print(userid);
  }
}
