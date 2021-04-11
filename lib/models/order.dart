class Order {
  int number;
  double value;
  String description;
  String dateTime;

  Order({this.number, this.value, this.description, this.dateTime});

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'value': value,
      'description': description,
      'dateTime': dateTime,
    };
  }

  Order.fromMap(Map map) {
    number = map['number'];
    value = map['value'];
    description = map['description'];
    dateTime = map['dateTime'];
  }
}