class Cart {
  int productId;
  int productQuantity;

  Cart({
    required this.productId,
    required this.productQuantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productQuantity': productQuantity,
    };
  }

  factory Cart.fromMap(Map map) {
    return Cart(
      productId: map["productId"],
      productQuantity: map["productQuantity"],
    );
  }
}
