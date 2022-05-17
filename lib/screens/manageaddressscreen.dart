import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/screens/change_address_screen/changeaddressscreen.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/widgets/anotherappbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagAddressScreen extends StatefulWidget {
  const ManagAddressScreen({Key? key}) : super(key: key);

  @override
  _ManagAddressScreenState createState() => _ManagAddressScreenState();
}

class _ManagAddressScreenState extends State<ManagAddressScreen> {
  @override
  void initState() {
    setaddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size / 100;

    return Scaffold(
      appBar: AnotherAppBar("Set Address", context),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            house == null
                ? TextButton.icon(
                    onPressed: () {
                      Get.to(() => ChangeAddressScreen());
                    },
                    icon: Icon(Ionicons.add),
                    label: Text("Add Address"))
                : TextButton.icon(
                    onPressed: () {
                      Get.to(() => ChangeAddressScreen());
                    },
                    icon: Icon(Ionicons.add, color: redcolor),
                    label: Text('Change address',
                        style: GoogleFonts.openSans(
                          color: redcolor,
                        ))),
            whitespace(context, 2, 0),
            house == null
                ? Container(
                    margin: EdgeInsets.all(15),
                    child: Text(
                      "Set up your address. Tap the Add Address button above to add an address.",
                      style: GoogleFonts.openSans(
                        fontSize: 11,
                      ),
                    ),
                  )
                : Expanded(
                    child: Container(
                      height: size.height * 15.8,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$house, $road",
                              style: GoogleFonts.openSans(),
                            ),
                            whitespace(context, 1, 0),
                            Text(
                              "$area",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w700),
                            ),
                            // whitespace(context, 2, 0),
                            TextButton.icon(
                                onPressed: () {
                                  snackbar("Address Removed");
                                  removeaddress();
                                },
                                icon: Icon(
                                  Ionicons.trash,
                                  size: 15,
                                ),
                                label: Text(
                                  "Remove Address",
                                  style: GoogleFonts.openSans(fontSize: 11.5),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  var house;
  var road;
  var area;
  setaddress() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      house = pref.getString('houseaddress');
      road = pref.getString('roadaddress');
      area = pref.getString('areaaddress');
    });
  }

  removeaddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('houseaddress');
    await preferences.remove('roadaddress');
    await preferences.remove('areaaddress');
    setState(() {
      house = null;
      area = null;
      road = null;
    });
  }

  snackbar(String message) {
    final snackBar = SnackBar(content: Text("$message"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
