class User {
  String name;
  String email;
  String phone;
  String address;
  String zipcode;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.zipcode,
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

  factory User.fromMap(Map map) {
    return User(
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      zipcode: map['zipcode'],
    );
  }
}
