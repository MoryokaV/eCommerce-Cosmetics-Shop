class AccountDetails {
  String name;
  String email;
  String phone;
  String address;
  String zipcode;

  AccountDetails({
    this.name,
    this.email,
    this.phone,
    this.address,
    this.zipcode,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'zipcode': zipcode,
    };
  }

  AccountDetails.fromMap(Map map) {
    name = map['name'];
    email = map['email'];
    phone = map['phone'];
    address = map['address'];
    zipcode = map['zipcode'];
  }
}
