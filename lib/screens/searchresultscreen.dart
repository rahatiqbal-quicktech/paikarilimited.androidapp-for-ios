import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:androidapp/Models/search_model.dart';
import 'package:androidapp/screens/homescreenlisttile.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/main.dart';
import 'package:androidapp/screens/productdetailsscreen.dart';
import 'package:androidapp/widgets/anotherappbar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../Controllers/provider/cartprovider.dart';

// import 'package:flutter/src/widgets/image.dart' as imageimport;

class SearchResultScreen extends StatefulWidget {
  final String searchKey;
  SearchResultScreen({Key? key, required this.searchKey}) : super(key: key);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  void initState() {
    GetResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size / 100;
    return Scaffold(
      appBar: AnotherAppBar("Search", context),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            whitespace(context, 2, 0),
            RichText(
              text: TextSpan(
                style: GoogleFonts.openSans(color: Colors.black),
                children: [
                  TextSpan(
                    text: "Search result for ",
                    style: GoogleFonts.openSans(),
                  ),
                  TextSpan(
                    text: "${widget.searchKey}",
                    style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            whitespace(context, 3, 0),
            FutureBuilder<List<SearchModel>?>(
                future: GetResult(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length == 0)
                      return Center(
                        child: Text("Product Not Available",
                            style: GoogleFonts.openSans(
                              fontSize: 17,
                            )),
                      );
                    else
                      return SizedBox(
                        height: size.height * 80,
                        child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final temp = snapshot.data![index];
                              return GestureDetector(
                                  onTap: () {
                                    Get.to(() => ProductDetailsScreen(
                                        id: snapshot.data![index].id.toString(),
                                        name: snapshot.data![index].name
                                            .toString(),
                                        url: snapshot
                                            .data![index].images!.first.src
                                            .toString(),
                                        oldprice: snapshot
                                            .data![index].regularPrice
                                            .toString(),
                                        saleprice: snapshot
                                            .data![index].salePrice
                                            .toString(),
                                        q: 1));
                                  },
                                  child: HomeScreenListTile(
                                    id: temp.id,
                                    imageurl: temp.images!.first.src,
                                    oldprice: temp.salePrice,
                                    price: temp.price,
                                    productname: temp.name,
                                    q: getQuantity(temp.id),
                                  ));
                              //   ListTile(
                              //     leading: CircleAvatar(
                              //       backgroundImage: NetworkImage(
                              //         "${snapshot.data![index].images?.first.src}",
                              //       ),
                              //     ),
                              //     title: Text(
                              //       "${snapshot.data![index].name}",
                              //       style: GoogleFonts.openSans(),
                              //     ),
                              //   ),
                              // );
                            }),
                      );
                  } else {
                    return Container(
                      // height: double.infinity,
                      height: size.height * 80,
                      alignment: Alignment.center,
                      child: const CupertinoActivityIndicator(
                        radius: 20,
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Future<List<SearchModel>?> GetResult() async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('$woocommerceusername:$woocommercepassword'));
    final response = await http.get(
        Uri.parse(
            'https://paikarilimited.com/wp-json/wc/v2/products?search="${widget.searchKey}"'),
        headers: <String, String>{'authorization': basicAuth});

    var data = response.body;

    if (response.statusCode == 200) {
      return searchModelFromJson(data);
    } else {
      return [];
    }
  }

  getQuantity(int? id) {
    return Provider.of<CartProvider>(context, listen: false).abc(id!);
  }
}
