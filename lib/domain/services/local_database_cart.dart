import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../model/cart_model.dart';

class LocalDatabaseCart {
  LocalDatabaseCart._();

  static final LocalDatabaseCart db = LocalDatabaseCart._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'CartProducts.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE cartProducts (
        name TEXT NOT NULL,
        image TEXT NOT NULL,
        price TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        productId TEXT NOT NULL)
      ''');
    });

    return database;
  }

  Future<List<CartModel>> getAllProducts() async {
    Database db = await database;
    List<Map> maps = await db.query('cartProducts');

    List<CartModel> list = maps.isNotEmpty
        ? maps.map((cartProduct) => CartModel.fromJson(cartProduct)).toList()
        : [];
    return list;
  }

  insertProduct(CartModel cartModel) async {
    Database db = await database;
    await db.insert(
      'cartProducts',
      cartModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  deleteProduct(String productId) async {
    Database db = await database;
    await db.delete(
      'cartProducts',
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  deleteAllProducts() async {
    Database db = await database;
    await db.delete('cartProducts');
  }

  update(CartModel cartModel) async {
    Database db = await database;
    await db.update(
      'cartProducts',
      cartModel.toJson(),
      where: 'productId = ?',
      whereArgs: [cartModel.productId],
    );
  }
}
