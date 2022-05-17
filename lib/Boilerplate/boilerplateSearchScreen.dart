// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:androidapp/Dependencies/dependencies.dart';
import 'package:androidapp/widgets/commonwidgets.dart';

class BoilerPlateSearchScreen extends StatefulWidget {
  final String searchword;
  const BoilerPlateSearchScreen({Key? key, required this.searchword})
      : super(key: key);

  @override
  _BoilerPlateSearchScreenState createState() =>
      _BoilerPlateSearchScreenState();
}

class _BoilerPlateSearchScreenState extends State<BoilerPlateSearchScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size / 100;
    return Scaffold(
      appBar: CommonAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            whitespace(context, 2, 0),
            Text(
              "Your Search Result for : " + widget.searchword,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 11,
              ),
            ),
            // whitespace(context, 2, 0),
            // Obx(() {
            //   return SizedBox(
            //     height: size.height * 30,
            //     child: ListView.builder(
            //       scrollDirection: Axis.vertical,
            //       shrinkWrap: true,
            //       itemCount: 2,
            //       itemBuilder: (context, index) {
            //         return Column(
            //           children: [
            //             GestureDetector(
            //               child: Container(
            //                 padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            //                 child: Row(
            //                   children: [
            //                     CircleAvatar(
            //                       backgroundImage: NetworkImage(
            //                           imagecheckfunction(index).toString()),
            //                       radius: 26,
            //                     ),
            //                     SizedBox(
            //                       width: size.width * 5,
            //                     ),
            //                     Column(
            //                       mainAxisAlignment: MainAxisAlignment.start,
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         SizedBox(
            //                           width: size.width * 60,
            //                           child: Text(
            //                               allproductscontroller
            //                                   .allrpoductslist_[index].name
            //                                   .toString(),
            //                               overflow: TextOverflow.ellipsis,
            //                               style: GoogleFonts.openSans()),
            //                         ),
            //                         whitespace(context, 2, 0),
            //                         RichText(
            //                           text: TextSpan(
            //                             children: <TextSpan>[
            //                               const TextSpan(
            //                                 text: 'tk ',
            //                                 style: TextStyle(
            //                                   color: Colors.grey,
            //                                 ),
            //                               ),
            //                               TextSpan(
            //                                 text: allproductscontroller
            //                                     .allrpoductslist_[index]
            //                                     .regularPrice
            //                                     .toString(),
            //                                 style: const TextStyle(
            //                                   color: Colors.grey,
            //                                   decoration:
            //                                       TextDecoration.lineThrough,
            //                                 ),
            //                               ),
            //                               TextSpan(
            //                                   text: '    ' +
            //                                       allproductscontroller
            //                                           .allrpoductslist_[index]
            //                                           .salePrice
            //                                           .toString(),
            //                                   style: GoogleFonts.openSans(
            //                                       textStyle: TextStyle(
            //                                           color: redcolor))),
            //                             ],
            //                           ),
            //                         )
            //                       ],
            //                     ),
            //                     const Spacer(),
            //                     Column(
            //                       children: [
            //                         // Text(
            //                         //   "12 pcs",
            //                         //   style: GoogleFonts.openSans(
            //                         //       textStyle: TextStyle(
            //                         //     fontSize: 11,
            //                         //   )),
            //                         // ),
            //                         // whitespace(context, 2, 0),
            //                         Icon(
            //                           Ionicons.add_circle_outline,
            //                           color: redcolor,
            //                         ),
            //                       ],
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               onTap: () {
            //                 String? link = imagecheckfunction(index);
            //                 Navigator.push(
            //                     context,
            //                     MaterialPageRoute(
            //                         builder: (context) => ProductDetailsScreen(
            //                               id: allproductscontroller
            //                                   .allrpoductslist_[index].id
            //                                   .toString(),
            //                               url: link.toString(),
            //                             )));
            //               },
            //             ),
            //             const Divider(
            //               color: Colors.grey,
            //             ),
            //           ],
            //         );
            //       },
            //     ),
            //   );
            // }),
          ],
        ),
      ),
    );
  }
}

String? imagecheckfunction(int index) {
  if (allproducts_c.allrpoductslist_[index].images!.isEmpty) {
    return "https://i5.walmartimages.com/asr/2442ca60-a563-4bb1-bbab-d4449d546d04.b208061a114950a62193c904d00b72c3.gif";
  } else {
    return allproducts_c.allrpoductslist_[index].images!.first.src;
  }
}
