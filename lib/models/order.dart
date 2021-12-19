class Order {
  int number;
  double value;
  String description;
  String date;

  Order({
    required this.number,
    required this.value,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'value': value,
      'description': description,
      'date': date,
    };
  }

  factory Order.fromMap(Map map) {
    return Order(
      number: map['number'],
      value: map['value'],
      description: map['description'],
      date: map['date'],
    );
  }
}
