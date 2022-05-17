import 'package:get/get.dart';
import 'package:androidapp/screens/homescreen.dart';
import 'package:androidapp/screens/set_address_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpFunctions {
  String? fulladdress;
  otpSetUsername(String name) async {
    final spref = await SharedPreferences.getInstance();
    spref.setString('userName', name);
    print(spref.getString('userName'));
    await Get.to(() => SetAddressScreen());
  }

  otpSetAddress(String house, String road, String area) async {
    final spref = await SharedPreferences.getInstance();
    spref.setString('houseaddress', house);
    spref.setString('roadaddress', road);
    spref.setString('areaaddress', area);
    fulladdress = spref.getString('houseaddress').toString() +
        " " +
        spref.getString('areaaddress').toString();
    Get.to(() => HomeScreen());
  }
}
