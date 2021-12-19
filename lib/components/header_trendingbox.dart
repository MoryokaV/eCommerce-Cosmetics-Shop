import 'package:flutter/material.dart';
import 'package:cosmetics_shop/models/constants.dart';
import 'package:cosmetics_shop/models/products.dart';
import 'dart:async';
import 'dart:math';

class SearchDialog extends StatefulWidget {
  @override
  _SearchDialogState createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  bool showNamePrice = true;
  String name = "";
  String price = "";
  List list = [];

  List getProduct() {
    int index = Random().nextInt(products.length);
    return [
      products[index].name,
      "Only " + products[index].price.toString() + " RON"
    ];
  }

  void toggleAntimations() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          showNamePrice = !showNamePrice;
          if (showNamePrice) retrieveValues();
        });
      }
    });
  }

  void retrieveValues() {
    list = getProduct();

    name = list[0];
    price = list[1];
  }

  void initState() {
    super.initState();
    retrieveValues();
    toggleAntimations();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: defaultPadding / 1.5,
          ),
          height: screenSize.height * 0.175,
          child: Stack(
            children: <Widget>[
              Container(
                height: screenSize.height * 0.15,
                width: screenSize.width,
                padding: EdgeInsets.only(
                  top: defaultPadding / 4,
                  left: defaultPadding / 1.5,
                ),
                child: SingleChildScrollView(
                  child: Text(
                    "\t Hi, what do you buy today?",
                    style: TextStyle(
                      fontSize: screenSize.width * 0.0625,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36.0),
                    bottomRight: Radius.circular(36.0),
                  ),
                ),
              ),
              Positioned(
                bottom: defaultPadding / 4,
                right: 0,
                left: 0,
                child: Container(
                    alignment: Alignment.center,
                    margin:
                        EdgeInsets.symmetric(horizontal: defaultPadding - 5),
                    padding:
                        EdgeInsets.symmetric(horizontal: defaultPadding - 5),
                    height: screenSize.height * 0.055,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0, 10),
                          blurRadius: 25,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedCrossFade(
                          firstChild: Text(
                            name,
                            style: TextStyle(
                              fontFamily: "Arial",
                              fontWeight: FontWeight.w600,
                              fontSize: screenSize.height * 0.03,
                              color: accentColor,
                            ),
                          ),
                          secondChild: Text(
                            price,
                            style: TextStyle(
                              fontFamily: "Arial",
                              fontWeight: FontWeight.w500,
                              fontSize: screenSize.height * 0.025,
                              color: Colors.green[600],
                            ),
                          ),
                          crossFadeState: showNamePrice
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          firstCurve: Curves.easeOut,
                          secondCurve: Curves.easeIn,
                          sizeCurve: Curves.bounceOut,
                          duration: Duration(seconds: 1),
                        ),
                        Icon(
                          Icons.trending_up_rounded,
                          color: accentColor,
                          size: screenSize.height * 0.035,
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ],
    );
  }
}
