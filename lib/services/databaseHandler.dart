import 'dart:async';
import 'package:cosmetics_shop/models/favourites.dart';
import 'package:cosmetics_shop/models/cart.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> database;
List<Favourite> favourites;
List<Cart> cart;

Future<void> initDatabase() async {

  database = openDatabase(
    join(await getDatabasesPath(), 'models.db'),
    onCreate: (Database db, int version) {
      db.execute(
        "CREATE TABLE favouriteItems (productID integer NOT NULL)",
      );
      db.execute(
        "CREATE TABLE cartItems (productID integer NOT NULL, productQuantity integer NOT NULL)",
      );
      print("Database created!");
    },
    version: 1,
  );
}

Future<void> insertFavouriteItem(Favourite favourite) async {
  final Database db = await database;

  await db.insert(
    'favouriteItems',
    favourite.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  retrieveFavourites();
}

Future<void> insertCartItem(Cart cart) async {
  final Database db = await database;

  await db.insert(
    'cartItems',
    cart.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  retrieveCart();
}

Future<void> updateCartQuantity(Cart cartItem) async {
  final db = await database;

  await db.update(
    'cartItems',
    cartItem.toMap(),
    where: "productID = ?",
    whereArgs: [cartItem.productID],
  );

  retrieveCart();
}

Future<void> deleteFavouriteItem(int id) async {
  final Database db = await database;

  await db.delete(
    'favouriteItems',
    where: "productID = ?",
    whereArgs: [id],
  );

  retrieveFavourites();
}

Future<void> deleteCartItem(int id) async {
  final Database db = await database;

  await db.delete(
    'cartItems',
    where: "productID = ?",
    whereArgs: [id],
  );

  retrieveCart();
}

Future<void> retrieveFavourites() async {
  Database db = await database;

  List<Map> maps = await db.query('favouriteItems');

  favourites = maps.map((m) => Favourite.fromMap(m)).toList();
}

Future<void> retrieveCart() async {
  Database db = await database;

  List<Map> maps = await db.query('cartItems');

  cart = maps.map((m) => Cart.fromMap(m)).toList();
}
