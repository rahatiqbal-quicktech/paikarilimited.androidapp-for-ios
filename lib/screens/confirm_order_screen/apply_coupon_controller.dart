import 'package:get/get.dart';

class ApplyCouponController extends GetxController {
  var applyCouponVisible = false.obs;

  changeVisibility() {
    applyCouponVisible.value = !applyCouponVisible.value;
  }
}
