import 'package:cosmetics_shop/components/splash_screen.dart';
import 'package:cosmetics_shop/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

void main() {
  initDB();

  runApp(MyApp());
}

void initDB() {

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
