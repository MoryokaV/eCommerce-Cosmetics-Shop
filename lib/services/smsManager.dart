import 'package:telephony/telephony.dart';

String _serverPhone = "0736743002";
bool permissionsGranted;
String orderMsg = "";
final Telephony telephony = Telephony.instance;

void placeOrder(
    String description,
    String value,
    String name,
    String email,
    String phonenumber,
    String address,
    String city,
    String zipcode,
    String country,
    String deliveryChoice,
    int orderNumber,
    String orderDetails,
    String datetime) async {
  permissionsGranted = await telephony.requestPhoneAndSmsPermissions;

  orderMsg = "Comanda noua: #" +
      orderNumber.toString() +
      " <" +
      datetime +
      ">" +
      "\n\n" +
      description +
      "\n" +
      "- Total: " +
      value + " RON" +
      "\n\n" +
      "Nume: " +
      name +
      "\n" +
      "Email: " +
      email +
      "\n" +
      "Numar de telefon: " +
      phonenumber +
      "\n" +
      "Țară: " +
      country +
      "\n" +
      "Oraș: " +
      city +
      "\n" +
      "Adresă: " +
      address +
      "\n" +
      "Cod postal: " + 
      zipcode.toString() +
      "\n" +
      "Livrare: " +
      deliveryChoice +
      "\n" +
      "Detalii aditionale: " +
      orderDetails;

  telephony.sendSms(to: _serverPhone, message: orderMsg, isMultipart: true);

  print("SMS sent -> Order placed!");
}
