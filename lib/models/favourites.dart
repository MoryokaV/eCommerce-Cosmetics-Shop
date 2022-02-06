import 'dart:math';

import 'package:flutter/material.dart';
import '../services/sqliteHelper.dart' as sqlite;
import '../constants.dart';

class Favourite extends ChangeNotifier {
  List<int> items = [];

  Favourite() {
    fetchData();
  }

  void fetchData() async {
    items = await sqlite.retrieveFavourites();

    notifyListeners();
  }

  void toggleFavourites(BuildContext context, int id) {
    items.contains(id)
        ? removeFromFavourites(id)
        : addToFavourites(context, id);
  }

  Future<void> addToFavourites(BuildContext context, int id) async {
    items.add(id);

    await sqlite.insertFavouriteItem(id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        content: Text(
          toastMsg[Random().nextInt(toastMsg.length)],
        ),
      ),
    );

    notifyListeners();
  }

  Future<void> removeFromFavourites(int id) async {
    items.remove(id);

    await sqlite.deleteFavouriteItem(id);

    notifyListeners();
  }
}
