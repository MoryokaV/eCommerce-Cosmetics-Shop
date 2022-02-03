class Cart {
  int productId;
  int productQuantity;

  Cart({
    required this.productId,
    required this.productQuantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'productID': productId,
      'productQuantity': productQuantity,
    };
  }

  factory Cart.fromMap(Map map) {
    return Cart(
      productId: map["productID"],
      productQuantity: map["productQuantity"],
    );
  }
}
