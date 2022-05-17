// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/Dependencies/dependencies.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/screens/cartscreen.dart';
import 'package:androidapp/screens/homescreenlisttile.dart';
import 'package:androidapp/screens/loginscreen.dart';
import 'package:androidapp/widgets/anotherappbar.dart';
import 'package:androidapp/widgets/navbar_widget/navbarWidget.dart';
import 'package:provider/provider.dart';

import '../Controllers/provider/cartprovider.dart';

// final AllProductsController allproductscontroller =
//     Get.put(AllProductsController());

class HomeScreen extends StatefulWidget {
  final int? uid;
  HomeScreen({Key? key, this.uid}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List Categories = [
    "Pet Shop",
    "Toys and Games",
    "Food",
    "Home and Cleaning",
    "Vehicle Essentials",
    "Home Appliance",
    "Office Products"
  ];
  //
  @override
  void initState() {
    super.initState();
    // SqfliteDatabase().cartNotificationNumber();
    // Provider.of<CartProvider>(context).gettotalprice();
    // Provider.of<CartProvider>(context, listen: false).getallcart();

    // FOREROUND STATE
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {
      if (event.notification != null) {
        print(event.notification!.title);
        print(event.notification!.body);
      }
    });

    //background state
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if (event.notification != null) {
        print(event.notification!.title);
        print(event.notification!.body);
      }
    });

    //APP TERMINATED
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value!.notification != null) {
        print(value.notification!.title);
        print(value.notification!.body);
      }
    });
  }
  //

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size / 100;
    return Scaffold(
      appBar: AnotherAppBar("Paikari Limited", context),
      drawer: NavBarWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            SizedBox(
              height: size.height * 86,
              child: Obx(() {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: allproducts_c.allrpoductslist_.length,
                  itemBuilder: (context, index) {
                    final abc = allproducts_c.allrpoductslist_[index];

                    return allproducts_c.allrpoductslist_.isNotEmpty
                        ? HomeScreenListTile(
                            id: abc.id,
                            productname: abc.name,
                            price: abc.salePrice,
                            oldprice: abc.price,
                            imageurl: imagecheckfunction(index),
                            q: getQuantity(abc.id),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                );
              }),
            ),
            Provider.of<CartProvider>(context, listen: true).tprice != 0
                ? Positioned.fill(
                    child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      child: bottomContainer(size),
                      onTap: () {
                        Get.to(() => CartScreen());
                      },
                    ),
                  ))
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget bottomContainer(Size size) {
    return Container(
      height: size.height * 7,
      width: double.infinity,
      margin: EdgeInsets.only(left: 5, right: 5),
      padding: EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: redcolor,
      ),
      child: Row(
        children: [
          Icon(
            Ionicons.bag_handle,
            color: Colors.white,
          ),
          Spacer(),
          Text(
            "Review Order",
            style: GoogleFonts.openSans(color: Colors.white),
          ),
          Spacer(),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5),
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                "${Provider.of<CartProvider>(context, listen: true).tprice} tk",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget SearchDialogue(BuildContext context, Size size) {
    return Dialog(
      child: Container(
        color: Colors.red,
        width: 50,
        height: 50,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Search'),
            ),
            Text("data"),
          ],
        ),
      ),
    );
  }

  String? imagecheckfunction(int index) {
    if (allproducts_c.allrpoductslist_[index].images!.isEmpty) {
      return "https://i5.walmartimages.com/asr/2442ca60-a563-4bb1-bbab-d4449d546d04.b208061a114950a62193c904d00b72c3.gif";
    } else {
      // final item = allproducts_c.allrpoductslist_[index].images;
      return allproducts_c.allrpoductslist_[index].images!.first.src;
    }
  }

  getQuantity(int? id) {
    return Provider.of<CartProvider>(context, listen: false).abc(id!);
  }
}

class Sidenav extends StatelessWidget {
  // const Sidenav({ Key? key }) : super(key: key);
  const Sidenav(Size size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size / 100;
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: updatednavitems(context),
        ),
      ),
    );
  }
}

Column updatednavitems(BuildContext context) {
  return Column(
    // shrinkWrap: true,
    // padding: const EdgeInsets.fromLTRB(20, 10, 0,0),
    children: [
      // whitespace(context, 3.7,0),
      ListTile(
        leading: Icon(
          Ionicons.person_circle_outline,
          color: Colors.black,
        ),
        title: Text(
          "Login",
          style: GoogleFonts.openSans(
              textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          )),
        ),
        trailing: Icon(Ionicons.headset_outline),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
      ),
      Divider(
        color: Colors.grey,
      ),
      ListTile(
        leading: Icon(
          Ionicons.flame,
          color: Colors.amber,
        ),
        title: Text("Deal Of The Day"),
      ),
      ListTile(
        leading: Image.asset(
          "assets/categoryicons/airfreshner.png",
          height: 26,
        ),
        // Icon(
        //   Ionicons.bonfire,
        //   color: redcolor,
        // ),
        title: Text("Air Freshner"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
      ),

      ListTile(
        dense: true,
        leading: Image.asset(
          "assets/categoryicons/babyitems.png",
          height: 26,
        ),
        title: Text("Baby Items"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ),
      ListTile(
        dense: true,
        leading: Image.asset(
          "assets/categoryicons/bodyspray.png",
          height: 26,
        ),
        title: Text("Body Spray"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ),
      ListTile(
        dense: true,
        leading: Image.asset(
          "assets/categoryicons/bodywash.png",
          height: 26,
        ),
        title: Text("Body Wash"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ),
      ListTile(
        dense: true,
        leading: Image.asset(
          "assets/categoryicons/cream.png",
          height: 26,
        ),
        title: Text("Cream/Fairness Cream"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ),
      ListTile(
        dense: true,
        leading: Image.asset(
          "assets/categoryicons/diaper.png",
          height: 26,
        ),
        title: Text("Diaper"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ),
      ListTile(
        dense: true,
        leading: Image.asset(
          "assets/categoryicons/facewash.png",
          height: 26,
        ),
        title: Text("Face Wash"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ),
      ListTile(
        dense: true,
        leading: Image.asset(
          "assets/categoryicons/foundation.png",
          height: 26,
        ),
        title: Text("Foundations"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ),

      ListTile(
        dense: true,
        leading: Image.asset(
          "assets/categoryicons/hairitems.png",
          height: 26,
        ),
        title: Text("Hair Items"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ),
      ListTile(
        dense: true,
        leading: Image.asset(
          "assets/categoryicons/babyitems.png",
          height: 26,
        ),
        title: Text("Kajal"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ),
      ListTile(
        dense: true,
        leading: Image.asset(
          "assets/categoryicons/lotion.png",
          height: 26,
        ),
        title: Text("Lotion"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ),
      ListTile(
        dense: true,
        leading: Image.asset(
          "assets/categoryicons/babyitems.png",
          height: 26,
        ),
        title: Text("Oil"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ),
      ListTile(
        dense: true,
        leading: Image.asset(
          "assets/categoryicons/pastebrush.png",
          height: 26,
        ),
        title: Text("Paste/Brush"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ),
      ListTile(
        dense: true,
        leading: Image.asset(
          "assets/categoryicons/perfume.png",
          height: 26,
        ),
        title: Text("Perfume"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ),
      ListTile(
        dense: true,
        leading: Image.asset(
          "assets/categoryicons/powder.png",
          height: 26,
        ),
        title: Text("Powder"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ),
      ListTile(
        dense: true,
        leading: Image.asset(
          "assets/categoryicons/rollon.png",
          height: 26,
        ),
        title: Text("Rollon"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ),
      ListTile(
        dense: true,
        leading: Image.asset(
          "assets/categoryicons/babyitems.png",
          height: 26,
        ),
        title: Text("Scent"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ),
      ListTile(
        dense: true,
        leading: Image.asset(
          "assets/categoryicons/shampoo_conditioner.png",
          height: 26,
        ),
        title: Text("Shampoo/Conditioner"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ),
      ListTile(
        dense: true,
        leading: Image.asset(
          "assets/categoryicons/shaving.png",
          height: 26,
        ),
        title: Text("Shaving"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ),
      ListTile(
        dense: true,
        leading: Image.asset(
          "assets/categoryicons/soap.png",
          height: 26,
        ),
        title: Text("Soap"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ),
      ListTile(
        dense: true,
        leading: Image.asset(
          "assets/categoryicons/babyitems.png",
          height: 26,
        ),
        title: Text("Others"),
        trailing: Icon(
          Ionicons.chevron_forward_sharp,
          size: 15.5,
          color: ashcolor,
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ),
      // ListView.builder(
      //   shrinkWrap: true,
      //   itemCount: 8,
      //   itemBuilder: (context, index) {
      //     return GestureDetector(
      //       onTap: () {
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => SubCategoryScreen()));
      //       },
      //       child: ListTile(
      //         leading: Icon(Ionicons.add),
      //         title: Text("Category $index"),
      //         trailing: Icon(Ionicons.chevron_forward),
      //       ),
      //     );
      //   },
      // ),
    ],
  );
}
