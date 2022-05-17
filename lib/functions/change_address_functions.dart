import 'package:shared_preferences/shared_preferences.dart';

class ChangeAdressFunctions {
  String? fulladdress;
  setAddress({
    String? apartment,
    String? houseStreetName,
    String? townCity,
    String? district,
    String? postCode,
  }) async {
    final spref = await SharedPreferences.getInstance();
    spref.setString('houseaddress', apartment!);
    spref.setString('roadaddress', houseStreetName!);
    spref.setString('areaaddress', townCity!);
    spref.setString('city', district!);
    spref.setString('postCode', postCode!);
    fulladdress = spref.getString('houseaddress').toString() +
        " " +
        spref.getString('areaaddress').toString();
    print("This is from sharedpreference = " + fulladdress.toString());
  }

  setFullAddress({required String fullAddress}) async {
    final spref = await SharedPreferences.getInstance();
    spref.setString('fullAddress', fullAddress);
  }

  setOtherDetails(
      {String? companyName,
      String? billingMobileNo,
      String? confirmOrderEmailAddress}) async {
    final spref = await SharedPreferences.getInstance();
    spref.setString('companyName', companyName!);
    spref.setString('billingMobileNo', billingMobileNo!);
    spref.setString('confirmOrderEmailAddress', confirmOrderEmailAddress!);
  }
}
