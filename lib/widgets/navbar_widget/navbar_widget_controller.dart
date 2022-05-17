import 'package:get/get.dart';

class NavbaWidgetController extends GetxController {
  var showContainer = false.obs;

  show() {
    showContainer.value = !showContainer.value;
  }
}
