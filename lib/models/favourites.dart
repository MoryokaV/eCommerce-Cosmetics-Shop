class Favourite {
  int productID;

  Favourite({
    required this.productID,
  });

  Map<String, dynamic> toMap() {
    return {
      'productID': productID,
    };
  }

  factory Favourite.fromMap(Map map) => Favourite(productID: map['productID']);
}