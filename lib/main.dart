import 'package:cosmetics_shop/components/splash_screen.dart';
import 'package:cosmetics_shop/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

void main() {
  //add code here for testing the api

  test();

  runApp(MyApp());
}

void test() async{
  var url = "http://127.0.0.1:5000/";

  Response response = await get(Uri.parse(url + "find?productID=1"));
  print(response.body);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Cosmetics Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Roboto-Regular",
        primaryColor: primaryColor,
        accentColor: accentColor,
        scaffoldBackgroundColor: backgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
