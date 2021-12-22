import 'package:cosmetics_shop/constants.dart';
import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(
        kDefaultPadding / 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/misc/shopping_ic.png",
          ),
          SizedBox(
            height: screenSize.height * 0.025,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenSize.width * 0.8,
            ),
            child: Text(
              "Continue searching until you find the product that interests you!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Arial",
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: kAccentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
