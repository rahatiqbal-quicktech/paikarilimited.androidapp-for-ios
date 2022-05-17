import 'package:get/get.dart';

class TestController extends GetxController {
  final otpCodeVisible = RxBool(false);

  setFalse() {
    otpCodeVisible.value = true;
  }
}
