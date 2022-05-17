import 'package:flutter/material.dart';

import 'package:androidapp/Models/cart_model.dart';
import 'package:androidapp/Controllers/provider/cartprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoilerPlateTestScreen extends StatefulWidget {
  final List<CartModel>? listabc;

  const BoilerPlateTestScreen({Key? key, required this.listabc})
      : super(key: key);

  @override
  _BoilerPlateTestScreenState createState() => _BoilerPlateTestScreenState();
}

class _BoilerPlateTestScreenState extends State<BoilerPlateTestScreen> {
  // final box = GetStorage();
  // GetStorage abc = GetStorage();
  // Obtain shared preferences.
  final prefs = SharedPreferences.getInstance();
  // var x =  SharedPreferences.get
  @override
  void initState() {
    setvalue();
    setaddress();
    setabc();
    super.initState();
  }

  var categoryid;

  setvalue() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      categoryid = sharedPreferences.getInt('categoryid');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    print(categoryid);
                  },
                  child: Text("Test Categoryid")),
              ElevatedButton(
                  onPressed: () {
                    setabc();
                  },
                  child: Text("Test Address SharedPreference")),
              abc == null ? Text("There is no data") : Text("$abc"),
              ElevatedButton(
                  onPressed: () {
                    sendToDatabase(context);
                  },
                  child: Text("Send to database")),
              ElevatedButton(
                  onPressed: () {
                    print(widget.listabc);
                  },
                  child: Text("Test List Passing")),
              ElevatedButton(
                  onPressed: () async {
                    print(checkcartnotification().toString());
                  },
                  child: Text("Cart Notification Item Count Check")),
            ],
          ),
        ),
      ),
    );
  }

  String? fulladdress;
  var abc;
  setaddress() async {
    final spref = await SharedPreferences.getInstance();
    fulladdress = spref.getString('houseaddress').toString() +
        " " +
        spref.getString('areaaddress').toString();
  }

  setabc() async {
    final abc_pref = await SharedPreferences.getInstance();
    setState(() {
      abc = null;
    });
    // print("This is abc = ");
    // print(abc);
  }

  Map<String, dynamic>? temp;
  var list = [];

  List<CartModel>? model;
  fetchallcheck() async {
    list.clear();
    // SqfliteDatabase database = SqfliteDatabase();
    // model = await database.fetchall();
    Provider.of<CartProvider>(context, listen: false).getallcart();
    model = Provider.of<CartProvider>(context, listen: false).cartproducts;
    // print(model!.first.name);
    for (var i = 0; i < model!.length; i++) {
      tempcartmodel x = tempcartmodel(id: model![i].id, price: model![i].price);
      list.add(x.toJson());
    }
    // print(list.length);
    // for (var i = 0; i < list.length; i++) {
    //   print(list[i]);
    // }
    check(list);
  }

  sendToDatabase(BuildContext context) {
    //
    list.clear();
    Provider.of<CartProvider>(context, listen: false).getallcart();
    model = Provider.of<CartProvider>(context, listen: false).cartproducts;

    for (var i = 0; i < model!.length; i++) {
      var x = modelCreateOrder(product_id: model![i].id, quantity: 5);
      list.add(x);
    }
    print("This is one is from sendToDatabase  =  ");
    for (var i = 0; i < list.length; i++) {
      print(list[i]);
    }
    // CreateOrderController().createorder(
    //     paymentmethod: "Cash On Delivery",
    //     tempLineItems: list,
    //     context: context);
  }

  //this function is for checking if I can send new cart model to another screen, or function
  check(var abc) {
    for (var i = 0; i < abc.length; i++) {
      print("This is one is from abc  =  ");
      print(abc[i]);
    }
  }

  List<Map<String, dynamic>>? values;
  getvalues() {
    fetchallcheck();
    for (var i in model!) {
      values?.add(SendCartModel(id: i.id, price: i.price).getmap());
    }
    print(values);
  }

  checkcartnotification() {
    Provider.of<CartProvider>(context, listen: false).getallcart();
    model = Provider.of<CartProvider>(context, listen: false).cartproducts;
    print(model?.length);
    int a = model!.length;
    return a;
  }
}

class SendCartModel {
  dynamic id;
  dynamic price;
  SendCartModel({required this.id, required this.price});
  Map<String, dynamic> getmap() {
    Map<String, dynamic> temp = {"productid": id, "productprice": price};
    print(temp);
    return temp;
  }
}

class tempcartmodel {
  int? id;
  int? price;
  tempcartmodel({this.id, this.price});
  Map<String, dynamic> toJson() {
    return {"id": id, "price": price};
  }
}

class modelCreateOrder {
  int? product_id;
  int? quantity;
  modelCreateOrder({this.product_id, this.quantity});
  Map<String, dynamic> toJson() {
    return {"product_id": product_id, "quantity": quantity};
  }
}
