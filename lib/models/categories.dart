import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  int id;
  String name;
  String icon;

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Category.fromSnapshot(DocumentSnapshot snapshot) {
    return Category(
      id: snapshot['id'],
      name: snapshot['name'],
      icon: snapshot['icon'],
    );
  }
}