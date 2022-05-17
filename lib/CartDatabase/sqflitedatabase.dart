import 'package:androidapp/Models/cart_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDatabase {
  String tablename = "Cart";
  Database? database;
  num a = 0;

  Future<void> init() async {
    String tempo = await getDatabasesPath();
    // String databasepath = tempo + "/" + "cart_db";
    String databasepath = join(tempo, 'cart.db');
    print("Init Worked ");

    await openDatabase(
      databasepath,
      version: 14,
      onCreate: (db, version) async {
        print("ONCREATE WORKED");
        String command =
            "CREATE TABLE $tablename (id INTEGER PRIMARY KEY, name TEXT, price INTEGER, imageurl TEXT, quantity INTEGER)";
        await db.execute(command);
        database = db;
      },
      //
      onOpen: (db) {
        database = db;
      },
      //
      onUpgrade: (db, oldVersion, newVewrsion) {
        database = db;
      },
    );
  }

  Future<void> addtocart(CartModel cart) async {
    try {
      int? added = await database?.insert(tablename, cart.toJson());
      print(added);
    } catch (e) {
      update(cart);
      print(e);
      // Get.snackbar("Product Already Added",
      //     "This product has already been added to the cart. Since this app is still in development stage, only unique products can be added to the cart for now and with a quantity value 1. Fullu functioned Cart system are expected to be done in a very short time.");
      // commonsnackbar("Product is already added to the cart.", 2, )
    }
  }

  Future<List<CartModel>>? fetchall() async {
    List<Map<String, Object?>>? map = await database?.query(tablename);
    List<CartModel> cartproducts = [];
    CartModel singleproduct = CartModel();

    if (map != null) {
      for (Map<String, Object?> i in map) {
        cartproducts.add(CartModel.fromJson(i));
        singleproduct = CartModel.fromJson(i);
        a = a + singleproduct.price!.toInt();
      }
    }
    print(cartproducts);

    return cartproducts;
  }

  Future<void> delete(int id) async {
    await database?.delete(tablename, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> update(CartModel cart) async {
    await database?.update(tablename, cart.toJson(),
        where: 'id = ?', whereArgs: [cart.id]);
    print("Product Updated");
  }

  Future<int> totalprice() async {
    int totalprice = 0;
    List<CartModel>? products = await fetchall();
    if (products != null) {
      for (var i in products) {
        totalprice = (totalprice + i.price!.toInt() * i.quantity!.toInt());
      }
    }
    return totalprice;
  }

  Future<int> cartNotificationNumber() async {
    List<CartModel>? products = await fetchall();
    return products!.length;
  }

  num? returntotalprice() {
    return a;
  }

  checkQuantity(int id) async {
    SqfliteDatabase db = SqfliteDatabase();
    // List<CartModel>? temp = await SqfliteDatabase().fetchall();
    await db.fetchall();
    // fetchall();
    // print(cartNotificationNumber());
    // int i;
    // for (i = 0; i < temp!.length; i++) {
    //   if (temp[i].id == id) {
    //     print(
    //         "(checkQuantity function)  This product is added to the cart - ${temp[i].quantity}");
    //   }
    // }
  }

  Future<void> clearCart() async {
    // await database?.delete(tablename, where: 'id = ?', whereArgs: [id]);
    await database!.execute("DELETE FROM $tablename");
  }
}
