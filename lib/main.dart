import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:androidapp/CartDatabase/anotherSqflHelper.dart';
import 'package:androidapp/CartDatabase/sqflitedatabase.dart';
import 'package:androidapp/Models/cart_model.dart';
import 'package:androidapp/myApp.dart';

import 'package:provider/provider.dart';
import 'Controllers/provider/cartprovider.dart';
import 'di_container.dart' as di;
import 'package:geolocator/geolocator.dart';

SqfliteDatabase databaseinit = SqfliteDatabase();
List<CartModel>? globalCartList = [];
List<Map<String, dynamic>> global_CartList = [];

CartSqlHelper cartSql = CartSqlHelper();

Future<void> backgroundNotificationHandler(RemoteMessage message) async {
  print(message.notification!.title);
  print(message.notification!.body);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  getfinalpos();
  await di.init();
  await databaseinit.init();
  await cartSql.initialize();

  //Push Notification While App Is Closed
  FirebaseMessaging.onBackgroundMessage(backgroundNotificationHandler);

  // runApp(const MyApp());
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<CartProvider>()),
    ],
    child: MyApp(),
  ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: ProfileScreen());
//   }
// }

String woocommerceusername = 'ck_2ac27102d6ac7a3a83c8ef047aff774bb3a8edae';
String woocommercepassword = 'cs_8b5cff09fd4580bcfc0616dcc42678c10839f972';

Position? currentpos;
String? currentaddress;

// Future<Position> getpos() async {
//   // LocationPermission permission;
//   // permission = await Geolocator.checkPermission();

//   // if (permission == LocationPermission.denied) {
//   //   permission = await Geolocator.requestPermission();
//   // } else {
//   //   print("LOCATION NOT AVAILABLE");
//   // }

//   return await Geolocator.getCurrentPosition();
// }

void getaddress(latitude, longitude) async {
  try {
    List<Placemark> placemark = await GeocodingPlatform.instance
        .placemarkFromCoordinates(latitude, longitude);

    Placemark place = placemark[0];
    currentaddress = "${place.locality}, ${place.street}, ";
    print(currentaddress);
    print(currentaddress);
  } catch (e) {
    print(e);
  }
}

getfinalpos() async {
  try {
    currentpos = await Geolocator.getCurrentPosition();
    print("THIS IS ADDRESS" + currentpos.toString());
  } catch (e) {
    print(e);
  }

  getaddress(currentpos?.latitude, currentpos?.longitude);
  print("THIS IS ADDRESS" + currentaddress.toString());
}
