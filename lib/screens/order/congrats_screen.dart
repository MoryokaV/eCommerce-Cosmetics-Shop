import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/widgets/bottomNavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../../responsive.dart';

class CongratsScreen extends StatefulWidget {
  final int number;

  CongratsScreen({
    required this.number,
  });

  @override
  _CongratsScreenState createState() => _CongratsScreenState();
}

class _CongratsScreenState extends State<CongratsScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kPrimaryColor,
        appBar: buildAppBar(),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 7.5,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: Responsive.safeBlockHorizontal * 40,
                    backgroundColor: Colors.grey[300],
                    child: Image.asset(
                      "assets/images/misc/package.png",
                      height: Responsive.safeBlockHorizontal * 60,
                      width: Responsive.safeBlockHorizontal * 60,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Congrats!",
                style: TextStyle(
                  fontFamily: "Roboto-Bold",
                  fontSize: Responsive.safeBlockHorizontal * 10,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(
                  kDefaultPadding,
                ),
                child: Text(
                  "Thank you for purchasing. Your order number is #" +
                      widget.number.toString() +
                      ", check email for latest status.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Roboto-Light",
                    fontSize: Responsive.safeBlockHorizontal * 5.5,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //send message
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => BottomNavBar(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: kDefaultPadding / 2,
                  ),
                  height: Responsive.safeBlockVertical * 7,
                  width: Responsive.safeBlockHorizontal * 70,
                  child: Center(
                    child: Text(
                      "Continue Shopping",
                      style: TextStyle(
                        fontFamily: "Roboto-Bold",
                        fontSize: Responsive.safeBlockHorizontal * 5.5,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      kDefaultPadding * 2,
                    ),
                    color: kAccentColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 2.5,
                        offset: Offset(-1, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: kAccentColor,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 5,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            iconSize: 22,
            color: kPrimaryColor,
            onPressed: () => exit(0),
          ),
          Text(
            "Checkout",
            style: TextStyle(
              fontFamily: "Roboto-Medium",
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          IconButton(
            icon: Icon(Icons.home),
            iconSize: 22,
            color: kPrimaryColor,
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => BottomNavBar(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
