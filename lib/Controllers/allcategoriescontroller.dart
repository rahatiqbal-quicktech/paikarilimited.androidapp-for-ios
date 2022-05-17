import 'package:get/get.dart';
import 'package:androidapp/Models/all_categories_model.dart';
import 'package:androidapp/Service/remoteallcategories.dart';

class AllCategoriesController extends GetxController {
  var categories_ = <AllCategoriesModel>[].obs;
  @override
  void onInit() {
    FetchAllCategories();
    super.onInit();
  }

  void FetchAllCategories() async {
    var categories = await AllCategoriesRemoteService.fetchallcategories();
    categories_.value = categories;
  }
}
