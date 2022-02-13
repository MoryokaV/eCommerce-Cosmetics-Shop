import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmetics_shop/services/firestoreService.dart';
import 'package:flutter/material.dart';
import 'package:cosmetics_shop/constants.dart';
import 'dart:async';
import 'dart:math';

import '../../../responsive.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool showName = true;
  String name = "";
  String price = "";

  void getInformation(List<QueryDocumentSnapshot> docs) {
    int index = Random().nextInt(docs.length);

    name = docs[index]['name'];
    price = "Only " + docs[index]['price'].toString() + " RON";
  }

  void toggleAnimation() async {
    List<QueryDocumentSnapshot> docs =
        (await productsCollection.orderBy('id').get()).docs;

    setState(() => getInformation(docs));

    Timer.periodic(Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() => showName = !showName);
        if (showName) getInformation(docs);
      }
    });
  }

  void initState() {
    toggleAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding),
      height: Responsive.safeBlockVertical * 17,
      child: Stack(
        children: [
          Container(
            height: Responsive.safeBlockVertical * 15,
            width: Responsive.screenWidth,
            padding: EdgeInsets.only(
              top: kDefaultPadding / 2,
              left: kDefaultPadding,
            ),
            child: Text(
              "Hi, what do you buy today?",
              style: TextStyle(
                fontSize: Responsive.safeBlockHorizontal * 6,
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
            bottom: 2,
            right: 0,
            left: 0,
            child: Container(
              alignment: Alignment.center,
              height: Responsive.safeBlockVertical * 5,
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
                      style: TextStyle(
                        fontSize: Responsive.safeBlockHorizontal * 5,
                        fontWeight: FontWeight.w500,
                        color: kAccentColor,
                      ),
                    ),
                    secondChild: Text(
                      price,
                      style: TextStyle(
                        fontSize: Responsive.safeBlockHorizontal * 5,
                        fontWeight: FontWeight.w500,
                        color: Colors.green[600],
                      ),
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
                    size: Responsive.safeBlockHorizontal * 7,
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
