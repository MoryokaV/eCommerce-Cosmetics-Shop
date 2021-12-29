import 'package:cosmetics_shop/constants.dart';
import 'package:flutter/material.dart';

import '../../../responsive.dart';

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            height: Responsive.safeBlockVertical * 2.5,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Responsive.screenWidth * 0.9,
            ),
            child: Text(
              "Continue searching until you find the product that interests you!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Responsive.safeBlockHorizontal * 5,
                fontWeight: FontWeight.w500,
                color: kAccentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
