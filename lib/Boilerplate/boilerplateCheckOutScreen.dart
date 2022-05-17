// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/screens/homescreen.dart';

class BoilerplateChekOutScreen extends StatefulWidget {
  int? orderid;
  String? paymentMethod;
  BoilerplateChekOutScreen({Key? key, this.orderid, this.paymentMethod})
      : super(key: key);

  @override
  _BoilerplateChekOutScreenState createState() =>
      _BoilerplateChekOutScreenState();
}

class _BoilerplateChekOutScreenState extends State<BoilerplateChekOutScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size / 100;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: CommonAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: redcolor,
              ),
              child: Text(
                "Thank You. Your Order Has Been Received.",
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            whitespace(context, 2, 0),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 7, 5, 5),
              height: size.height * 28,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ORDER NUMBER: ${widget.orderid}",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.green.shade800),
                  ),
                  whitespace(context, 1.5, 0),
                  // Text(
                  //   "DATE: 31/01/2022",
                  //   style: GoogleFonts.openSans(),
                  // ),
                  // whitespace(context, 1.5, 0),
                  // Text(
                  //   "EMAIL: testmail@gmail.com",
                  //   style: GoogleFonts.openSans(),
                  // ),
                  // whitespace(context, 1.5, 0),
                  // Text(
                  //   "TOTAL:৳ 9,095",
                  //   style: GoogleFonts.openSans(fontWeight: FontWeight.w500),
                  // ),
                  // whitespace(context, 1.5, 0),
                  Text(
                    "PAYMENT METHOD: ${widget.paymentMethod}",
                    style: GoogleFonts.openSans(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            // whitespace(context, 3, 0),
            // Text(
            //   "Order Details",
            //   style: GoogleFonts.openSans(
            //     fontSize: 14,
            //   ),
            // ),
            // whitespace(context, 1.5, 0),
            // Container(
            //   padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(8),
            //     color: Colors.white,
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Fair and Lovely Cream x 50 pcs  - 8500 tk",
            //         style: GoogleFonts.openSans(
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //       whitespace(context, 2, 0),
            //       Text(
            //         "Shipping - 100 tk",
            //         style: GoogleFonts.openSans(
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //       whitespace(context, 1.5, 0),
            //       Text(
            //         "Total  - 8600 tk",
            //         style: GoogleFonts.openSans(
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //       whitespace(context, 1.5, 0),
            //       Text(
            //         "Payment Method - Cash On Delivery",
            //         style: GoogleFonts.openSans(
            //           fontWeight: FontWeight.w500,
            //           fontSize: 11,
            //         ),
            //       ),
            //       whitespace(context, 2, 0),
            //     ],
            //   ),
            // ),
            whitespace(context, 2, 0),
            Center(
              child: OutlinedButton.icon(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen())),
                  icon: Icon(
                    Ionicons.heart,
                    color: Colors.green.shade500,
                  ),
                  label: Text(
                    "Continue Shopping",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w500,
                      color: Colors.green.shade800,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
