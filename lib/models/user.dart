class User {
  String name;
  String email;
  String phone;
  String address;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }

  factory User.fromMap(Map map) {
    return User(
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
    );
  }
}
