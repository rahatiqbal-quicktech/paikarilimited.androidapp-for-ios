import 'package:get_it/get_it.dart';

import 'CartDatabase/sqflitedatabase.dart';
import 'Controllers/provider/cartprovider.dart';
import 'package:androidapp/CartDatabase/sqflitedatabase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => CartProvider(database: sl()));

  //database
  SqfliteDatabase sqfliteDatabase = SqfliteDatabase();
  sqfliteDatabase.init();

  sl.registerLazySingleton(() => sqfliteDatabase);
}
