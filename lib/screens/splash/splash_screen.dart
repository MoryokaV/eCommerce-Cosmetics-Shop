import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../../responsive.dart';

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
        panelHeight = Responsive.screenHeight;
        panelWidth = Responsive.screenWidth;
      });
    });

    Timer(Duration(seconds: 2), () {
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
                      kBgAccent,
                      kPrimaryColor,
                    ],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Responsive.screenWidth * 0.75,
                  ),
                  child: Text(
                    "Cosmetics Shop",
                    style: TextStyle(
                      fontSize: Responsive.safeBlockHorizontal * 8,
                      color: kAccentColor,
                      fontFamily: "Roboto-Medium",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
                  child: Image.asset(
                    "assets/images/launcher_ic.png",
                    height: Responsive.safeBlockHorizontal * 35,
                    width: Responsive.safeBlockHorizontal * 35,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: kDefaultPadding * 2),
                  child: Text(
                    "Designed for you",
                    style: TextStyle(
                      fontSize: Responsive.safeBlockHorizontal * 5,
                      color: kAccentColor,
                      fontWeight: FontWeight.w300,
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
