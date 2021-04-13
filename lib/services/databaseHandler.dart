import 'package:cosmetics_shop/models/accountDetails.dart';
import 'package:cosmetics_shop/models/favourites.dart';
import 'package:cosmetics_shop/models/order.dart';
import 'package:cosmetics_shop/models/cart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

Future<Database> database;

List<Favourite> favourites;
List<Cart> cart;

List<Order> orders;

AccountDetails user;

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
        "CREATE TABLE orders (number INTEGER NOT NULL, value REAL NOT NULL, description TEXT, dateTime TEXT)",
      );
      db.execute(
        "CREATE TABLE user (name TEXT NOT NULL, email TEXT NOT NULL, phone TEXT NOT NULL, address TEXT NOT NULL, zipcode TEXT NOT NULL)",
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

  await retrieveFavourites();
}

Future<void> insertCartItem(Cart cart) async {
  final Database db = await database;

  await db.insert(
    'cartItems',
    cart.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  await retrieveCart();
}

Future<void> updateCartQuantity(Cart cartItem) async {
  final Database db = await database;

  await db.update(
    'cartItems',
    cartItem.toMap(),
    where: "productID = ?",
    whereArgs: [cartItem.productID],
  );

  await retrieveCart();
}

Future<void> deleteFavouriteItem(int id) async {
  final Database db = await database;

  await db.delete(
    'favouriteItems',
    where: "productID = ?",
    whereArgs: [id],
  );

  await retrieveFavourites();
}

Future<void> deleteCartItem(int id) async {
  final Database db = await database;

  await db.delete(
    'cartItems',
    where: "productID = ?",
    whereArgs: [id],
  );

  await retrieveCart();
}

Future<void> retrieveFavourites() async {
  final Database db = await database;

  List<Map> maps = await db.query('favouriteItems');

  favourites = maps.map((m) => Favourite.fromMap(m)).toList();
}

Future<void> retrieveCart() async {
  final Database db = await database;

  List<Map> maps = await db.query('cartItems');

  cart = maps.map((m) => Cart.fromMap(m)).toList();
}

Future<void> insertOrder(Order order) async {
  final Database db = await database;

  await db.insert(
    "orders",
    order.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  await retrieveOrders();
}

Future<void> retrieveOrders() async {
  final Database db = await database;

  List<Map> maps = await db.query('orders');

  orders = maps.map((m) => Order.fromMap(m)).toList();
}

Future<void> initUserDetails() async {
  final Database db = await database;

  await db.insert(
    'user',
    AccountDetails(
      name: "",
      email: "",
      phone: "",
      address: "",
      zipcode: "",
    ).toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  await retrieveUser();
}

Future<void> updateUserDetails(AccountDetails details) async {
  final Database db = await database;

  await db.update(
    'user',
    details.toMap(),
    where: "name = ?",
    whereArgs: [user.name],
  );

  await retrieveUser();
}

Future<void> retrieveUser() async {
  final Database db = await database;

  List<Map> maps = await db.query('user');

  user = AccountDetails.fromMap(maps[0]);
}
