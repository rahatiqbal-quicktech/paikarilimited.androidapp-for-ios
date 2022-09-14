import 'package:get/get.dart';

class AppleSignupController extends GetxController {
  var appleEmail = "".obs;
  var applePassword = "".obs;
  var appleDisplayName = "".obs;
  var appleUserName = "".obs;

  getAppleEmail(String email) async {
    appleEmail.value = email;
  }

  getApplePassword(String password) async {
    applePassword.value = password;
  }

  getDisplayName(String displayName) {
    appleDisplayName.value = displayName;
  }

  getAppleUserName(String _appleUserName) {
    appleUserName.value = _appleUserName;
  }
}
