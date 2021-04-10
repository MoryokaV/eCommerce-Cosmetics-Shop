import 'dart:async';
import 'package:cosmetics_shop/models/favourites.dart';
import 'package:cosmetics_shop/models/cart.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

Future<Database> database;

void initDatabase() async {
  //precache sqflite dependencies
  WidgetsFlutterBinding.ensureInitialized();

  database = openDatabase(
    join(await getDatabasesPath(), 'models.db'),
    onCreate: (Database db, int version) {
      db.execute(
        "CREATE TABLE favouriteItems (productID integer NOT NULL)",
      );
      db.execute(
        "CREATE TABLE cartItems (productID integer NOT NULL, productQuantity integer NOT NULL)",
      );
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
}

Future<void> insertCartItem(Cart cart) async {
  final Database db = await database;

  await db.insert(
    'cartItems',
    cart.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> updateCartQuantity(Cart cartItem) async {
  final db = await database;

  await db.update(
    'cartItems',
    cartItem.toMap(),
    where: "productID = ?",
    whereArgs: [cartItem.productID],
  );
}

Future<void> deleteFavouriteItem(int id) async {
  final Database db = await database;

  await db.delete(
    'favouriteItems',
    where: "productID = ?",
    whereArgs: [id],
  );
}

Future<void> deleteCartItem(int id) async {
  final Database db = await database;

  await db.delete(
    'cartItems',
    where: "productID = ?",
    whereArgs: [id],
  );
}

Future<List<Favourite>> retrieveFavourites() async {
  final Database db = await database;

  final List<Map<String, dynamic>> maps = await db.query('favouriteItems');

  return List.generate(maps.length, (index) {
    return Favourite(
      productID: maps[index]['productID'],
    );
  });
}

Future<List<Cart>> retrieveCart() async {
  final Database db = await database;

  final List<Map<String, dynamic>> maps = await db.query('cartItems');

  return List.generate(maps.length, (index) {
    return Cart(
      productID: maps[index]['productID'],
      productQuantity: maps[index]['productQuantity'],
    );
  });
}
