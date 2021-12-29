import 'package:flutter/material.dart';

//Theme
const kPrimaryColor = Color.fromRGBO(255, 255, 255, 1.0);
const kAccentColor = Color.fromRGBO(222, 108, 100, 1.0);
const kBgAccent = Color.fromRGBO(255, 203, 161, 1.0);
const kBgColor = Color.fromRGBO(250, 225, 202, 1.0);

final textFieldBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.black26,
  ),
);

//UI scale factor
const double kDefaultPadding = 20.0;

//Customizable variables
const double deliveryCost = 15;

const List<String> toastMsg = [
  "Good choice!",
  "This is an amazing product!",
  "Let's get to cart and buy it!",
  "Don't forget about it!",
];

const List<String> deliveryOptions = [
  "Standard delivery (+15.00 RON)",
  "No delivery (+0.00 RON)",
];

const List<String> destinationCities = [
  "Brăila",
  "Galați",
  "Cluj",
  "Iași",
];

enum UserFieldType {
  name,
  email,
  phone,
  address,
  zip,
}
