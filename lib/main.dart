import 'package:cosmetics_shop/models/cart.dart';
import 'package:cosmetics_shop/models/favourites.dart';
import 'package:cosmetics_shop/responsive.dart';
import 'package:cosmetics_shop/screens/splash/splash_screen.dart';
import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/services/sqliteHelper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  //init the widget tree
  WidgetsFlutterBinding.ensureInitialized();

  //Firesbase & sqlite databases
  await Firebase.initializeApp();
  await initDatabase();

  //UI orientation and scale
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Responsive().init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
          .copyWith(textScaleFactor: 1.0),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<Favourite>(create: (_) => Favourite()),
          ChangeNotifierProvider<Cart>(create: (_) => Cart()),
        ],
        child: MaterialApp(
          useInheritedMediaQuery: true,
          title: 'Cosmetics Shop',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: kBgColor,
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: kAccentColor),
            inputDecorationTheme: InputDecorationTheme(
              border: textFieldBorder,
              enabledBorder: textFieldBorder,
              focusedBorder: textFieldBorder,
            ),
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
