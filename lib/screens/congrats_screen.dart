import 'package:cosmetics_shop/models/constants.dart';
import 'package:cosmetics_shop/templateLayer.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CongratsScreen extends StatefulWidget {
  final int number;

  CongratsScreen({@required this.number});

  @override
  _CongratsScreenState createState() => _CongratsScreenState();
}

class _CongratsScreenState extends State<CongratsScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: buildAppBar(screenSize),
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
                    radius: screenSize.width * screenSize.height * 0.0005,
                    backgroundColor: Colors.grey[300],
                    child: Image.asset(
                      "assets/images/misc/package.png",
                      height: screenSize.width * screenSize.height * 0.00075,
                      width: screenSize.width * screenSize.height * 0.00075,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              Text(
                "Congrats!",
                style: TextStyle(
                  fontFamily: "Roboto-Bold",
                  fontSize: screenSize.width * 0.1,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(
                  defaultPadding,
                ),
                child: Text(
                  "Thank you for purchasing. Your order number is #" +
                      widget.number.toString() +
                      ", check email for latest status.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Roboto-Light",
                    fontSize: screenSize.width * 0.055,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //send message
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TemplateLayer(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: defaultPadding / 2,
                  ),
                  height: screenSize.height * 0.07,
                  width: screenSize.width * 0.7,
                  child: Center(
                    child: Text(
                      "Continue Shopping",
                      style: TextStyle(
                        fontFamily: "Roboto-Bold",
                        fontSize: screenSize.width * 0.055,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      defaultPadding * 2,
                    ),
                    color: accentColor,
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

  Widget buildAppBar(Size screenSize) {
    return AppBar(
      backgroundColor: accentColor,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 5,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            iconSize: screenSize.width * 0.06,
            color: primaryColor,
            onPressed: () => exit(0),
          ),
          Text(
            "Checkout",
            style: TextStyle(
              fontFamily: "Roboto-Medium",
              color: primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: screenSize.width * 0.055,
            ),
          ),
          IconButton(
            icon: Icon(Icons.home),
            iconSize: screenSize.width * 0.06,
            color: primaryColor,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TemplateLayer(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
