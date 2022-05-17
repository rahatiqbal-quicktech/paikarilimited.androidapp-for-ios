// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:androidapp/Boilerplate/dummyscreenBoilerplate.dart';
import 'package:androidapp/Controllers/allproductscontroller.dart';
import 'package:androidapp/widgets/commonwidgets.dart';

class BoilerAllProducts extends StatefulWidget {
  const BoilerAllProducts({Key? key}) : super(key: key);

  @override
  _BoilerAllProductsState createState() => _BoilerAllProductsState();
}

class _BoilerAllProductsState extends State<BoilerAllProducts> {
  final AllProductsController allproductscontroller_ =
      Get.put(AllProductsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("Here goes the list of all products"),
              SizedBox(
                height: 500,
                child: Obx(() {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: allproductscontroller_.allrpoductslist_.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            // "abcde",
                            allproductscontroller_.allrpoductslist_[index].name
                                .toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              // fontSize: 20,
                            ),
                          ),
                          subtitle: Text(allproductscontroller_
                              .allrpoductslist_[index].id
                              .toString()),
                          leading: Image(
                            image: NetworkImage(
                                imagecheckfunction(index).toString()),
                          ),
                        );
                      });
                }),
              ),
              whitespace(context, 5, 0),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const DummyScreenBoilerplate()));
                  },
                  child: const Text("Dummy Button"))
            ],
          ),
        ),
      ),
    );
  }

  String? imagecheckfunction(int index) {
    if (allproductscontroller_.allrpoductslist_[index].images!.isEmpty) {
      return "https://i5.walmartimages.com/asr/2442ca60-a563-4bb1-bbab-d4449d546d04.b208061a114950a62193c904d00b72c3.gif";
    } else {
      return allproductscontroller_.allrpoductslist_[index].images!.first.src;
    }
  }
}
