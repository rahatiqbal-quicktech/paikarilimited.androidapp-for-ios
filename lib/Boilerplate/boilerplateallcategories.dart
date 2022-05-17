import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:androidapp/Controllers/allcategoriescontroller.dart';

final AllCategoriesController categoriesController =
    Get.put(AllCategoriesController());

class BoilerPlateAllCategoriesScreen extends StatefulWidget {
  const BoilerPlateAllCategoriesScreen({Key? key}) : super(key: key);

  @override
  _BoilerPlateAllCategoriesScreenState createState() =>
      _BoilerPlateAllCategoriesScreenState();
}

class _BoilerPlateAllCategoriesScreenState
    extends State<BoilerPlateAllCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BoilerPlate Categories"),
        ),
        body: Obx(() {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: categoriesController.categories_.length,
              itemBuilder: (context, i) {
                final temp = categoriesController.categories_[i];
                if (temp.id == 366) {
                  return Container();
                } else {
                  return ListTile(
                    title: Text(temp.name.toString()),
                    subtitle: Text("${temp.id}"),
                    leading: Text("${i + 1}"),
                  );
                }
              });
        }));
  }
}
