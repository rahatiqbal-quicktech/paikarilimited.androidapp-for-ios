// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:androidapp/Models/product_details_model.dart';
import 'package:androidapp/Service/productdetailsservice.dart';

class ProductDetailsController extends GetxController {
  var productdetails = ProductDetails().obs;

  @override
  void onInit() {
    fetchproductdetails();
    super.onInit();
  }

  void fetchproductdetails() async {
    var details = await ProductDetailsService.fetchdetails();

    productdetails.value = details;
    print(productdetails);
  }
}
