import 'package:cosmetics_shop/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../responsive.dart';

class AboutScreen extends StatelessWidget {
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
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: kAccentColor,
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        "About Us",
                        style: TextStyle(
                          fontFamily: "Arial",
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: kAccentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Image.asset(
              "assets/images/launcher_ic.png",
              width: Responsive.safeBlockHorizontal * 25,
              height: Responsive.safeBlockHorizontal * 25,
            ),
            Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Text(
                "Your company title here",
                style: TextStyle(
                  fontSize: Responsive.safeBlockHorizontal * 5,
                  fontFamily: "Arial",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Text(
                "Description here",
                softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: Responsive.safeBlockHorizontal * 4,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "App version v1.0.0",
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: Responsive.safeBlockHorizontal * 5,
                      fontFamily: "Arial",
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
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
                    child: Container(
                      height: Responsive.safeBlockVertical * 5,
                      width: Responsive.safeBlockHorizontal * 18,
                      decoration: BoxDecoration(
                        color: kAccentColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            offset: Offset(1, 1),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "FAQ",
                          style: TextStyle(
                            fontSize: Responsive.safeBlockHorizontal * 4,
                            color: kPrimaryColor,
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
                top: kDefaultPadding,
                left: kDefaultPadding / 4,
                right: kDefaultPadding / 4,
              ),
              child: Column(
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Container(
                      margin: EdgeInsets.all(
                        kDefaultPadding / 5,
                      ),
                      width: Responsive.screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Author: Vlaviano Mario-Alexandru",
                            style: TextStyle(
                              fontFamily: "Roboto-BoldItalic",
                              fontSize: Responsive.safeBlockHorizontal * 5,
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
                        top: kDefaultPadding / 2,
                        left: kDefaultPadding / 4,
                        right: kDefaultPadding / 4,
                      ),
                      width: Responsive.screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Contact: +4 0736 743 002,",
                            style: TextStyle(
                              fontFamily: "Roboto-LightItalic",
                              fontSize: Responsive.safeBlockHorizontal * 5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding / 4,
                      ),
                      width: Responsive.screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "mariovlaviano2005@yahoo.com",
                            style: TextStyle(
                              fontFamily: "Roboto-LightItalic",
                              fontSize: Responsive.safeBlockHorizontal * 5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Image.asset(
                    "assets/images/misc/signature.png",
                    width: Responsive.safeBlockHorizontal * 33,
                    height: Responsive.safeBlockHorizontal * 33,
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
