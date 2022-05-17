import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/screens/confirm_order_screen/apply_coupon_controller.dart';

ApplyCouponController _controller = Get.put(ApplyCouponController());

Widget applyCouponWidget(Size size, BuildContext context) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          _controller.changeVisibility();
        },
        child: Container(
            width: double.infinity,
            height: size.height * 6,
            color: Colors.grey.shade300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Ionicons.arrow_down_circle_outline),
                whitespace(context, 0, 5),
                Text(
                  "Apply a coupon",
                  style: GoogleFonts.openSans(),
                )
              ],
            )),
      ),
      Obx(() {
        return _controller.applyCouponVisible.value == true
            ? EnterCouponWidget()
            : Container();
      }),
    ],
  );
}

class EnterCouponWidget extends StatelessWidget {
  const EnterCouponWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      // height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: SizedBox(
                width: 200,
                // height: 40,
                child: TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7)),
                    hintText: "Write coupon here",
                  ),
                )),
          ),
          whitespace(context, 0, 5),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: redcolor),
              onPressed: () {},
              child: Text("Apply"))
        ],
      ),
    );
  }
}
