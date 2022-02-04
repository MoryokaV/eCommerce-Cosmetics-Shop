import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
final CollectionReference productsCollection = _db.collection('products');
final CollectionReference categoriesCollection = _db.collection('categories');

class FirestoreService {
  static Stream<QuerySnapshot> getProducts() {
    return productsCollection.orderBy('id').snapshots();
  }

  static Stream<QuerySnapshot> getProductById(int id) {
    return productsCollection.where('id', isEqualTo: id).limit(1).snapshots();
  }

  static Stream<QuerySnapshot> getProductsByCategory(int categoryId) {
    return categoryId == -1
        ? getProducts()
        : productsCollection
            .where('categoryID', isEqualTo: categoryId)
            .orderBy('id')
            .snapshots();
  }

  static Stream<QuerySnapshot> getCategories(){
    return categoriesCollection.orderBy('id').snapshots();
  }
}
