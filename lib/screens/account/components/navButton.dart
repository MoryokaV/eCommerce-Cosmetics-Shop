import 'package:flutter/cupertino.dart';
import 'package:cosmetics_shop/constants.dart';
import 'package:flutter/material.dart';

import '../../../responsive.dart';

class NavButton extends StatelessWidget {
  final String image;
  final String title;
  final Widget nextScreen;

  const NavButton({
    required this.image,
    required this.title,
    required this.nextScreen,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => nextScreen,
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(top: kDefaultPadding),
        height: Responsive.safeBlockVertical * 15,
        width: Responsive.safeBlockHorizontal * 90,
        decoration: BoxDecoration(
          color: kBgAccent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 10,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: kDefaultPadding,
                horizontal: kDefaultPadding / 2,
              ),
              height: Responsive.safeBlockVertical * 12,
              width: Responsive.safeBlockHorizontal * 22,
              child: Image.asset(image),
            ),
            Text(
              title,
              style: TextStyle(
                fontFamily: "Century-Gothic",
                color: Colors.white,
                fontSize: Responsive.safeBlockHorizontal * 6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
