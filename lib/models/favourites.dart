class Favourite {
  int productID;

  Favourite({
    this.productID,
  });

  Map<String, dynamic> toMap() {
    return {
      'productID': productID,
    };
  }

  Favourite.fromMap(Map map){
    productID = map["productID"];
  }
}