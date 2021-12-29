import 'package:cosmetics_shop/responsive.dart';
import 'package:cosmetics_shop/screens/splash/splash_screen.dart';
import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/services/databaseHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Responsive().init();

    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
          .copyWith(textScaleFactor: 1.0),
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
    );
  }
}
