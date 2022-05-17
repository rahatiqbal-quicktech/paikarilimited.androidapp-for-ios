// ignore_for_file: non_constant_identifier_names

import 'package:get/state_manager.dart';
import 'package:androidapp/Models/all_products_model.dart';
import 'package:androidapp/Service/remoteallproducts.dart';

class AllProductsController extends GetxController {
  var allrpoductslist_ = <AllProductsModel>[].obs;

  @override
  void onInit() {
    FetchAllProducts();
    super.onInit();
  }

  void FetchAllProducts() async {
    var products = await AllProductsRemoteService.fetchallproducts();
    allrpoductslist_.value = products;
  }
}
