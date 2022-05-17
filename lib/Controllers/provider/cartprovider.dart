import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:androidapp/CartDatabase/sqflitedatabase.dart';
import 'package:androidapp/Models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  SqfliteDatabase database = SqfliteDatabase();

  CartProvider({required this.database}) {
    getallcart();
  }

  List<CartModel>? cartproducts = [];
  num? totalprice;
  int? tprice;
  int? cart_notification;

  Future<void> addtocart(CartModel cartModel) async {
    log("cartprovider addtocart  :  ${cartModel.quantity}");
    await database.addtocart(cartModel);
    gettotalprice();
    getallcart();
    cartNotification();
  }

  Future<void> deletecartproduct(int id) async {
    await database.delete(id);
    gettotalprice();
    getallcart();
    cartNotification();
  }

  Future<void> updatecart(CartModel cartModel) async {
    await database.update(cartModel);
    gettotalprice();
    getallcart();
    cartNotification();
  }

  Future<void> getallcart() async {
    cartproducts = await database.fetchall();
    cart_notification = await database.cartNotificationNumber();
    tprice = await database.totalprice();

    notifyListeners();
  }

  Future<void> gettotalprice() async {
    tprice = await database.totalprice();
    notifyListeners();
    // return totalprice.toString();
  }

  Future cartNotification() async {
    cart_notification = await database.cartNotificationNumber();
    notifyListeners();
  }

  int abc(int? id) {
    // getallcart();
    int returnValue = 0;
    for (var i in cartproducts!) {
      if (i.id == id) {
        returnValue = i.quantity ?? 0;
      }
    }

    return returnValue;
    // int i;
    // for (i = 0; i < cartproducts!.length; i++) {
    //   if (cartproducts![i].id == id) {
    //     print(
    //         "This product is available in cart from new loop   -  " + cartproducts![i].quantity.toString());
    //     return cartproducts![i].quantity;

    //   }else {
    //     print("Product not in cart");
    //     return 0;
    //   }
    // }

    // print("getallcart cartprovider  -  " + cartproducts!.first.id.toString());
  }

  Future clearCart() async {
    await database.clearCart();
    getallcart();
    gettotalprice();
    cartNotification();
    notifyListeners();
  }
}
