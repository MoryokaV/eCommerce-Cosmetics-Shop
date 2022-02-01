import 'package:flutter/cupertino.dart';
import '../services/sqliteHelper.dart' as sqlite;

class Favourite extends ChangeNotifier {
  int productID;

  Favourite({
    required this.productID,
  });

  Map<String, dynamic> toMap() {
    return {
      'productID': productID,
    };
  }

  factory Favourite.fromMap(Map map) {
    return Favourite(
      productID: map['productID'],
    );
  }

  Future<void> addToFavourites(int id) async {
    favourites.add(
      Favourite(
        productID: id,
      ),
    );

    await sqlite.insertFavouriteItem(
      Favourite(
        productID: id,
      ),
    );

    notifyListeners();
  }

  Future<void> removeFromFavourites(int id) async {
    favourites.removeWhere(
      (Favourite fav) => fav.productID == id,
    );

    await sqlite.deleteFavouriteItem(id);

    notifyListeners();
  }
}

List<Favourite> favourites = [];
