import 'dart:async';
import 'package:cosmetics_shop/models/favourites.dart';
import 'package:cosmetics_shop/models/products.dart';
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

/* Future<void> insertFavourites(Favourite favourite) async {
  final Database db = await database;

  await db.insert(
    'favouriteItems',
    favourite.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}*/
