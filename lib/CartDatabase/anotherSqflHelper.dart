import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartSqlHelper {
  String dbname = "cartdb";
  String tablename = "carttable";
  Database? myDatabase;

  Future<void> initialize() async {
    String DatabasePath = await getDatabasesPath();
    String CompletePath = join(DatabasePath, dbname);

    await openDatabase(CompletePath, version: 1,
        //
        onCreate: (db, version) async {
      String command =
          "CREATE TABLE $tablename (id TEXT PRIMARY KEY, productname TEXT, productprice REAL, quantity REAL)";
      await db.execute(command);
      myDatabase = db;
    },
        //
        onOpen: (db) {
      myDatabase = db;
    });
  }

  Future<int> addProduct(
      String id, String productname, double productprice, int quantity) async {
    Map<String, dynamic> dataMap = {
      "id": id,
      "productname": productname,
      "productprice": productprice,
      "quantity": quantity
    };
    try {
      return await myDatabase!.insert(tablename, dataMap);
    } catch (e) {
      print(e.toString());
      print("Already Exists ");
      return 3;
    }
  }

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    return await myDatabase!.query(tablename);
  }

  Future<int> deleteProduct(String id) async {
    print("Product deleted");
    return await myDatabase!.delete(tablename, where: "id=?", whereArgs: [id]);
  }

  // Future deleteTable() async {
  //   await myDatabase!.execute("DROP TABLE IF EXISTS $tablename");
  // }
}
