import 'package:cosmetics_shop/database/constants.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                        ),
                        color: accentColor,
                        onPressed: () => Navigator.pop(
                          context,
                        ),
                      ),
                      Text(
                        "About Us",
                        style: TextStyle(
                          fontFamily: "Arial",
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            FlutterLogo(),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Text(
                "Your company title here",
              ),
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Text(
                "Description here",
                softWrap: false,
                overflow: TextOverflow.fade,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Text(
                "App version vX.Y.Z",
                softWrap: false,
                overflow: TextOverflow.fade,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  Text(
                    "Author: Vlaviano Mario-Alexandru",
                    style: TextStyle(
                      fontFamily: "Roboto-BoldItalic",
                      fontSize: screenSize.width * 0.0525,
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.025,
                  ),
                  Text(
                    "Contact: +4 0736 743 002, \n \t \t \t \t \t mariovlaviano2005@yahoo.com",
                    style: TextStyle(
                      fontFamily: "Roboto-LightItalic",
                      fontSize: screenSize.width * 0.045,
                    ),
                  ),
                  Image.asset(
                    "assets/images/misc/signature.png",
                    width: screenSize.width * 0.33,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
