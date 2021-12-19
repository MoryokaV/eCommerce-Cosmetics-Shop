class Cart {
  int productID;
  int productQuantity;

  Cart({
    required this.productID,
    required this.productQuantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'productID': productID,
      'productQuantity': productQuantity,
    };
  }

  factory Cart.fromMap(Map map) {
    return Cart(
      productID: map["productID"],
      productQuantity: map["productQuantity"],
    );
  }
}
