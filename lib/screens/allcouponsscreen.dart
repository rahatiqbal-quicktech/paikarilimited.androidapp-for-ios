import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/Controllers/allcouponscontroller.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/widgets/anotherappbar.dart';

final AllCouponsController allCouponsController =
    Get.put(AllCouponsController());

class AllCouponsScreen extends StatefulWidget {
  const AllCouponsScreen({Key? key}) : super(key: key);

  @override
  _AllCouponsScreenState createState() => _AllCouponsScreenState();
}

class _AllCouponsScreenState extends State<AllCouponsScreen> {
  @override
  void initState() {
    allCouponsController.fetchAllCoupons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AnotherAppBar("Coupons", context),
      body: ListView(
        children: [
          whitespace(context, 2, 0),
          Obx(() {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: allCouponsController.couponsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: redcolor.withOpacity(0.6),
                    leading: Icon(
                      Ionicons.gift,
                      color: Colors.white,
                    ),
                    title: Text(
                      "${allCouponsController.couponsList[index].code}",
                      style: GoogleFonts.openSans(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),

                    //asd
                    //asdasd
                    subtitle: Text(
                        "Expires at - ${allCouponsController.couponsList[index].dateExpires}"),
                  );
                });
          })
        ],
      ),
    );
  }
}
