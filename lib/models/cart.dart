import 'package:flutter/material.dart';
import '../services/sqliteHelper.dart' as sqlite;

class CartItem {
  int productId;
  int productQuantity;

  CartItem({
    required this.productId,
    required this.productQuantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productQuantity': productQuantity,
    };
  }

  factory CartItem.fromMap(Map map) {
    return CartItem(
      productId: map["productId"],
      productQuantity: map["productQuantity"],
    );
  }
}

class Cart extends ChangeNotifier {
  List<CartItem> items = [];

  Cart() {
    fetchData();
  }

  void fetchData() async {
    items = await sqlite.retrieveCart();

    notifyListeners();
  }

  Future<void> addToCart(int id, int quantity) async {
    for (int i = 0; i < items.length; i++) {
      if (items[i].productId == id) {
        return;
      }
    }

    items.add(
      CartItem(
        productId: id,
        productQuantity: quantity,
      ),
    );

    await sqlite.insertCartItem(
      CartItem(
        productId: id,
        productQuantity: quantity,
      ),
    );

    notifyListeners();
  }

  Future<void> updateItemQuantity(int id, int newQuantity) async {
    items.firstWhere((item) => item.productId == id).productQuantity =
        newQuantity;

    await sqlite.updateCartQuantity(
      CartItem(
        productId: id,
        productQuantity: newQuantity,
      ),
    );

    notifyListeners();
  }

  Future<void> deleteCartItem(int id) async {
    items.removeWhere((item) => item.productId == id);

    await sqlite.deleteCartItem(id);

    notifyListeners();
  }

  Future<void> clearCart() async {
    for(int i = 0; i < items.length; i++){
      await sqlite.deleteCartItem(items[i].productId);
    }

    items = [];

    notifyListeners();
  }
}
