import 'package:flutter/material.dart';
import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/models/products.dart';
import 'dart:async';
import 'dart:math';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool showName = true;
  String name = "";
  String price = "";

  void getProduct() {
    int index = Random().nextInt(products.length);

    name = products[index].name;
    price = "Only " + products[index].price.toString() + " RON";
  }

  void toggleAntimations() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          showName = !showName;
          if (showName) getProduct();
        });
      }
    });
  }

  void initState() {
    super.initState();
    getProduct();
    toggleAntimations();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding / 2),
      height: screenSize.height * 0.175,
      child: Stack(
        children: [
          Container(
            height: screenSize.height * 0.15,
            width: screenSize.width,
            padding: EdgeInsets.only(
              top: kDefaultPadding / 2,
              left: kDefaultPadding,
            ),
            child: Text(
              "Hi, what do you buy today?",
              style: TextStyle(
                fontSize: screenSize.width * 0.0625,
                fontWeight: FontWeight.w300,
                color: kPrimaryColor,
              ),
            ),
            decoration: BoxDecoration(
              color: kAccentColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 0,
            left: 0,
            child: Container(
              alignment: Alignment.center,
              height: screenSize.height * 0.055,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(0, 4),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedCrossFade(
                    firstChild: Text(
                      name,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: kAccentColor),
                    ),
                    secondChild: Text(
                      price,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.green[600]),
                    ),
                    crossFadeState: showName
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstCurve: Curves.easeOut,
                    secondCurve: Curves.easeIn,
                    sizeCurve: Curves.decelerate,
                    duration: Duration(seconds: 1),
                  ),
                  Icon(
                    Icons.trending_up_rounded,
                    color: kAccentColor,
                    size: 30,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
