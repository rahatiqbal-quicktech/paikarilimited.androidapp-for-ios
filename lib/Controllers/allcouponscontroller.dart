import 'package:get/get.dart';
import 'package:androidapp/Models/all_coupons_model.dart';
import 'package:androidapp/Service/remotecoupons.dart';

class AllCouponsController extends GetxController {
  var couponsList = <AllCouponsModel>[].obs;

  @override
  void onInit() {
    fetchAllCoupons();
    super.onInit();
  }

  void fetchAllCoupons() async {
    var coupons = await CouponRemoteService.fetchAllCoupons();
    couponsList.value = coupons;
    print("FETCH ALL COUPONS FROM CONTROLLER");
  }
}
