import 'package:flutter/cupertino.dart';
import '../services/sqliteHelper.dart' as sqlite;

class Favourite extends ChangeNotifier {
  int productId;

  Favourite({
    required this.productId,
  });

  Map<String, dynamic> toMap() {
    return {
      'productID': productId,
    };
  }

  factory Favourite.fromMap(Map map) {
    return Favourite(
      productId: map['productID'],
    );
  }

  Future<void> addToFavourites(int id) async {
    favourites.add(
      Favourite(
        productId: id,
      ),
    );

    await sqlite.insertFavouriteItem(
      Favourite(
        productId: id,
      ),
    );

    notifyListeners();
  }

  Future<void> removeFromFavourites(int id) async {
    favourites.removeWhere(
      (Favourite fav) => fav.productId == id,
    );

    await sqlite.deleteFavouriteItem(id);

    notifyListeners();
  }
}

List<Favourite> favourites = [];
