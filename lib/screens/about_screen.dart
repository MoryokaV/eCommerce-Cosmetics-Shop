import 'package:cosmetics_shop/database/constants.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
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
                "Authors: - - - - -",
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
          ],
        ),
      ),
    );
  }
}
