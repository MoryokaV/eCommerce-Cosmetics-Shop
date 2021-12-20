import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double panelWidth = 0;
  double panelHeight = 0;

  void initState() {
    super.initState();
    
    Timer(Duration(milliseconds: 10), () {
      setState(() {
        panelHeight = MediaQuery.of(context).size.height;
        panelWidth = MediaQuery.of(context).size.width;
      });
    });

    Timer(Duration(milliseconds: 2150), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BottomNavBar(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: AnimatedContainer(
                height: panelHeight,
                width: panelWidth,
                duration: Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.25, 1],
                    colors: [
                      backgroundAccent,
                      primaryColor,
                    ],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Cosmetics Shop",
                  style: TextStyle(
                    fontSize: screenSize.width * 0.1,
                    color: accentColor,
                    fontFamily: "Arial",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/launcher_ic.png",
                      height: screenSize.height * 0.4,
                      width: screenSize.width * 0.4,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: defaultPadding * 2,
                  ),
                  child: Text(
                    "Designed for you",
                    style: TextStyle(
                      fontSize: screenSize.width * 0.05,
                      color: accentColor,
                      fontFamily: "Roboto-Light",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
