class Cart {
  int productID;
  int productQuantity;

  Cart({
    this.productID,
    this.productQuantity,
  });

  Map<String, dynamic> toMap(){
    return{
      'productID' : productID,
      'productQuantity' : productQuantity,
    };
  }

  Cart.fromMap(Map map){
    productID = map["productID"];
    productQuantity = map["productQuantity"];
  }
}