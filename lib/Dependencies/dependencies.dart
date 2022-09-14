import 'package:androidapp/Controllers/apple_signup/apple_signup_controller.dart';
import 'package:get/get.dart';
import 'package:androidapp/Controllers/allcategoriescontroller.dart';
import 'package:androidapp/Controllers/allproductscontroller.dart';

final AllCategoriesController categories_c = Get.put(AllCategoriesController());
final AllProductsController allproducts_c = Get.put(AllProductsController());
final appleSignUpController = Get.put(AppleSignupController());
