import 'package:cosmetics_shop/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
            Image.asset(
              "assets/images/launcher_ic.png",
              width: screenSize.width * 0.25,
              height: screenSize.width * 0.25,
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Text(
                "Your company title here",
                style: TextStyle(
                  fontSize: screenSize.width * 0.05,
                  fontFamily: "Arial",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Text(
                "Description here",
                softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: screenSize.width * 0.04,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "App version v1.0.0",
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: screenSize.width * 0.05,
                      fontFamily: "Arial",
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Container(
                    height: screenSize.width * 0.085,
                    width: screenSize.width * 0.18,
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(1, 1),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext dialogContext) =>
                              CupertinoAlertDialog(
                            title: Text("FAQ"),
                            content: Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam felis est, placerat eget erat fringilla, vestibulum ullamcorper sapien. Nam nec volutpat lorem."),
                            actions: [
                              CupertinoDialogAction(
                                isDefaultAction: true,
                                child: Text("Close"),
                                onPressed: () => Navigator.of(dialogContext,
                                        rootNavigator: true)
                                    .pop(),
                              )
                            ],
                          ),
                        );
                      },
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          "FAQ",
                          style: TextStyle(
                            fontSize: screenSize.width * 0.04,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: defaultPadding,
                left: defaultPadding / 4,
                right: defaultPadding / 4,
              ),
              child: Column(
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Container(
                      margin: EdgeInsets.all(
                        defaultPadding / 5,
                      ),
                      width: screenSize.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Author: Vlaviano Mario-Alexandru",
                            style: TextStyle(
                              fontFamily: "Roboto-BoldItalic",
                              fontSize: screenSize.width * 0.05,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: defaultPadding / 1.5,
                        left: defaultPadding / 5,
                        right: defaultPadding / 5,
                      ),
                      width: screenSize.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Contact: +4 0736 743 002,",
                            style: TextStyle(
                              fontFamily: "Roboto-LightItalic",
                              fontSize: screenSize.width * 0.05,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: defaultPadding / 10,
                        left: defaultPadding / 5,
                        right: defaultPadding / 5,
                      ),
                      width: screenSize.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "mariovlaviano2005@yahoo.com",
                            style: TextStyle(
                              fontFamily: "Roboto-LightItalic",
                              fontSize: screenSize.width * 0.05,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Image.asset(
                    "assets/images/misc/signature.png",
                    width: screenSize.width * 0.33,
                    height: screenSize.width * 0.33,
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
