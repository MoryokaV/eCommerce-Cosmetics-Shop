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
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: kDefaultPadding / 2,
        horizontal: kDefaultPadding,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kBgAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 6,
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: kDefaultPadding,
                horizontal: kDefaultPadding / 2,
              ),
              height: Responsive.safeBlockVertical * 10,
              width: Responsive.safeBlockHorizontal * 20,
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
        onPressed: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => nextScreen,
          ),
        ),
      ),
    );
  }
}
