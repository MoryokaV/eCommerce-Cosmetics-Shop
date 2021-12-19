import 'package:cosmetics_shop/models/user.dart';
import 'package:cosmetics_shop/models/favourites.dart';
import 'package:cosmetics_shop/models/order.dart';
import 'package:cosmetics_shop/models/cart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

late Future<Database> database;

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
      db.execute(
        "CREATE TABLE orders (number INTEGER NOT NULL, value REAL NOT NULL, description TEXT, date TEXT)",
      );
      db.execute(
        "CREATE TABLE user (name TEXT NOT NULL, email TEXT NOT NULL, phone TEXT NOT NULL, address TEXT NOT NULL, zipcode TEXT NOT NULL)",
      );

      //default user
      insertUser(
        User(
          name: "",
          email: "",
          phone: "",
          address: "",
          zipcode: "",
        ),
      );
    },
    version: 1,
  );
}

Future<void> insertFavouriteItem(Favourite favourite) async {
  final db = await database;

  await db.insert(
    'favouriteItems',
    favourite.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> deleteFavouriteItem(int id) async {
  final db = await database;

  await db.delete(
    'favouriteItems',
    where: "productID = ?",
    whereArgs: [id],
  );
}

Future<List<Favourite>> retrieveFavourites() async {
  final db = await database;

  List<Map> maps = await db.query('favouriteItems');

  return maps.map((m) => Favourite.fromMap(m)).toList();
}

Future<void> deleteCartItem(int id) async {
  final db = await database;

  await db.delete(
    'cartItems',
    where: "productID = ?",
    whereArgs: [id],
  );
}

Future<void> insertCartItem(Cart cart) async {
  final db = await database;

  await db.insert(
    'cartItems',
    cart.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Cart>> retrieveCart() async {
  final db = await database;

  List<Map> maps = await db.query('cartItems');

  return maps.map((m) => Cart.fromMap(m)).toList();
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

Future<void> insertOrder(Order order) async {
  final db = await database;

  await db.insert(
    "orders",
    order.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Order>> retrieveOrders() async {
  final db = await database;

  List<Map> maps = await db.query('orders');

  return maps.map((m) => Order.fromMap(m)).toList();
}

Future<void> insertUser(User user) async {
  final db = await database;

  await db.insert(
    'user',
    user.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> updateUser(User newUser) async {
  final db = await database;
  final user = await retrieveUser();

  await db.update(
    'user',
    newUser.toMap(),
    where: "name = ?",
    whereArgs: [user.name],
  );
}

Future<User> retrieveUser() async {
  final db = await database;

  List<Map> maps = await db.query('user');

  return User.fromMap(maps[0]);
}
