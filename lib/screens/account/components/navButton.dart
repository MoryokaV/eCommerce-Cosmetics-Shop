import 'package:flutter/cupertino.dart';
import 'package:cosmetics_shop/constants.dart';
import 'package:flutter/material.dart';

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
    Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => nextScreen,
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(top: defaultPadding / 1.5),
        height: screenSize.height * 0.155,
        width: screenSize.width * 0.9,
        decoration: BoxDecoration(
          color: backgroundAccent,
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
              margin: EdgeInsets.only(
                bottom: defaultPadding,
                top: defaultPadding,
                left: defaultPadding / 2,
                right: defaultPadding / 2,
              ),
              height: screenSize.height * 0.12,
              width: screenSize.width * 0.22,
              child: Image.asset(image),
            ),
            Text(
              title,
              style: TextStyle(
                fontFamily: "Century-Gothic",
                color: Colors.white,
                fontSize: screenSize.width * 0.065,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
