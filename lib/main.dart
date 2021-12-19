import 'package:cosmetics_shop/screens/splash_screen.dart';
import 'package:cosmetics_shop/models/constants.dart';
import 'package:cosmetics_shop/services/databaseHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cosmetics_shop/models/user.dart';

void main() async {
  //precache sqflite dependencies
  WidgetsFlutterBinding.ensureInitialized();

  await initDatabase();

  runApp(MyApp());
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
