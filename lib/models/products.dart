import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  int id;
  String name;
  int categoryID;
  num price;
  String image;
  String shortDescription;
  String longDescription;

  Product({
    required this.id,
    required this.name,
    required this.categoryID,
    required this.price,
    required this.image,
    required this.shortDescription,
    required this.longDescription,
  });

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    return Product(
      id: snapshot["id"],
      name: snapshot["name"],
      categoryID: snapshot["categoryID"],
      price: snapshot["price"],
      image: snapshot["image"],
      shortDescription: snapshot["shortDescription"],
      longDescription: snapshot["longDescription"],
    );
  }
}