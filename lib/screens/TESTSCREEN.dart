import 'package:flutter/material.dart';
import 'package:androidapp/Models/cart_model.dart';
import 'package:androidapp/Controllers/provider/cartprovider.dart';
import 'package:androidapp/main.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  // SqfliteDatabase db = SqfliteDatabase();
  @override
  void initState() {
    super.initState();
    getCart();
    fetchwishlist();
  }

  getCart() async {
    await Provider.of<CartProvider>(context, listen: true).getallcart();
    setState(() {
      globalCartList =
          Provider.of<CartProvider>(context, listen: false).cartproducts;
    });
  }

  List<CartModel>? temp = [];
  abc() async {
    temp = await databaseinit.fetchall();
    print(temp);
  }

  List<Map<String, dynamic>> CartList = [];
  fetchwishlist() async {
    List<Map<String, dynamic>> list = await cartSql.fetchProducts();
    setState(() {
      global_CartList = list;
    });
    // print(CartList.first["productimage"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sqflite Test Screen"),
      ),
      body: Column(
        children: [
          Center(
              child: TextButton(
                  onPressed: () async {
                    print(global_CartList);
                    // abc();
                  },
                  child: Text("Sqflite Global Variable Check"))),
          ListView.builder(
              shrinkWrap: true,
              itemCount: global_CartList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(global_CartList[index]['productname']),
                  subtitle: Text(global_CartList[index]['quantity'].toString()),
                );
              })
        ],
      ),
    );
  }
}
