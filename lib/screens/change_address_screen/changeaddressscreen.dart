import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/Fixed%20Variables/districts_list.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/functions/change_address_functions.dart';
import 'package:androidapp/screens/cartscreen.dart';
import 'package:androidapp/screens/change_address_screen/change_address_widgets.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/widgets/anotherappbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeAddressScreen extends StatefulWidget {
  final String? house;
  String? road;
  String? area;
  String? city;
  String? postCode;
  String? userName;
  String? billingMobileNo;
  String? confirmOrderEmailAddress;
  final String? companyName;

  ChangeAddressScreen(
      {this.house,
      this.road,
      this.area,
      this.city,
      this.postCode,
      this.userName,
      this.companyName,
      this.billingMobileNo,
      this.confirmOrderEmailAddress,
      Key? key})
      : super(key: key);

  @override
  _ChangeAddressScreenState createState() => _ChangeAddressScreenState();
}

class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
  final String staticPostCode = "1207";
  final apartmentController = TextEditingController();
  final cityController = TextEditingController();
  final houseStreetController = TextEditingController();
  final fullAddressController = TextEditingController();
  final postCodeController = TextEditingController();
  final billingMobileController = TextEditingController();
  final companyNameController = TextEditingController();
  final notesController = TextEditingController();
  final emailAddressController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _dropDownValue = "Dhaka";
  var road;
  var area;
  var city;
  var postCode;
  var userName;
  var fullAddress;
  var billingMobileNo;
  var confirmOrderEmailAddress;

  @override
  void initState() {
    super.initState();
    setNameAddress();

    apartmentController.text = widget.house ?? '';
    cityController.text = widget.area ?? '';
    houseStreetController.text = widget.road ?? '';
    postCodeController.text = widget.postCode ?? '';
    billingMobileController.text = widget.billingMobileNo ?? '';
    companyNameController.text = widget.companyName ?? '';
    emailAddressController.text = widget.confirmOrderEmailAddress ?? '';
    _dropDownValue = widget.city ?? '';
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size / 100;
    return Scaffold(
      appBar: AnotherAppBar("Change Address", context),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                whitespace(context, 2, 0),
                Text("Country / Region *Bangladesh",
                    style: GoogleFonts.openSans()),
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        whitespace(context, 2, 0),
                        changeAddressCustomTextfield(
                            "Apartment/unit, etc (optional) ",
                            "Apartment/unit, etc (optional) ",
                            apartmentController,
                            TextInputType.streetAddress,
                            false),
                        changeAddressCustomTextfield(
                            "House number & street name*",
                            "House number & street name*",
                            houseStreetController,
                            TextInputType.streetAddress,
                            true),
                        changeAddressCustomTextfield("Town/City*", "Town/City*",
                            cityController, TextInputType.streetAddress, true),
                        // Dropdown here
                        // selcectDistrictDropdown(),
                        alternateDropdown(),
                        whitespace(context, 1.5, 0),
                        Divider(),
                        changeAddressCustomTextfield(
                            "Company Name (optional)",
                            "Company Name (optional)",
                            companyNameController,
                            TextInputType.text,
                            false),
                        changeAddressCustomTextfield(
                            "Billing Mobile No*",
                            "Billig Mobile No*",
                            billingMobileController,
                            TextInputType.number,
                            true),
                        changeAddressCustomTextfield(
                            "Email Address* (required for payment confirmation)",
                            "abcde@email.com",
                            emailAddressController,
                            TextInputType.emailAddress,
                            true),
                        Align(
                          alignment: Alignment.centerRight,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ChangeAdressFunctions().setAddress(
                                    apartment: apartmentController.text,
                                    houseStreetName: houseStreetController.text,
                                    townCity: cityController.text,
                                    district: _dropDownValue,
                                    postCode: staticPostCode);
                                ChangeAdressFunctions().setFullAddress(
                                    fullAddress:
                                        "${apartmentController.text}, ${houseStreetController.text}, ${cityController.text}. $_dropDownValue");
                                ChangeAdressFunctions().setOtherDetails(
                                    companyName: companyNameController.text,
                                    billingMobileNo:
                                        billingMobileController.text,
                                    confirmOrderEmailAddress:
                                        emailAddressController.text);
                                Get.snackbar("Success", "Address Updated");
                                Get.to(() => CartScreen());
                              } else {
                                Get.snackbar("Field Empty",
                                    "Field names ending with a '*' are required.");
                              }
                            },
                            icon: Icon(
                              Ionicons.checkmark_circle_outline,
                              color: redcolor,
                            ),
                            label: Text(
                              "Set Address",
                              style: GoogleFonts.openSans(color: redcolor),
                            ),
                            style: OutlinedButton.styleFrom(
                              side:
                                  BorderSide(color: redcolor.withOpacity(0.5)),
                            ),
                          ),
                        ),
                        whitespace(context, 10, 0),
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container selcectDistrictDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
            color: Colors.grey, style: BorderStyle.solid, width: 0.80),
      ),
      child: DropdownButtonFormField(
        // underline: SizedBox(),
        value: _dropDownValue,
        hint: Text(
          _dropDownValue!,
          style: GoogleFonts.openSans(),
        ),

        isExpanded: true,
        icon: Icon(Ionicons.arrow_down),
        iconSize: 15.0,
        style: GoogleFonts.openSans(color: Colors.black),
        // borderRadius: BorderRadius.circular(5),
        items: districtsList.map(
          (val) {
            return DropdownMenuItem<String>(
              value: val,
              child:
                  Text(val, style: GoogleFonts.openSans(color: Colors.black)),
            );
          },
        ).toList(),
        onChanged: (String? val) {
          setState(
            () {
              _dropDownValue = val!;
            },
          );
        },
        validator: (value) {
          if (value == null) {
            return "Field Empty";
          }
          return null;
        },
      ),
    );
  }

  alternateDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
            color: Colors.grey, style: BorderStyle.solid, width: 0.80),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: _dropDownValue == null
              ? Text('Dropdown')
              : Text(
                  _dropDownValue!,
                  style: TextStyle(color: Colors.black),
                ),
          isExpanded: true,
          iconSize: 30.0,
          style: TextStyle(color: Colors.black),
          items: districtsList.map(
            (val) {
              return DropdownMenuItem<String>(
                value: val,
                child: Text(val),
              );
            },
          ).toList(),
          onChanged: (String? val) {
            setState(
              () {
                _dropDownValue = val;
              },
            );
          },
        ),
      ),
    );
  }

  setNameAddress() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      // house = pref.getString('houseaddress');
      // road = pref.getString('roadaddress');
      // area = pref.getString('areaaddress');
      city = pref.getString('city');
      postCode = pref.getString('postCode');
      fullAddress = pref.getString('fullAddress');
      userName = pref.getString('userName');
      billingMobileNo = pref.getString('billingMobileNo');
      confirmOrderEmailAddress = pref.getString('confirmOrderEmailAddress');
    });
  }
}
