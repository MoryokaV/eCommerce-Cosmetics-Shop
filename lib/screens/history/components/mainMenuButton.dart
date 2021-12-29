import 'package:cosmetics_shop/constants.dart';
import 'package:flutter/material.dart';

import '../../../responsive.dart';

class MainMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.safeBlockVertical * 6,
      width: Responsive.safeBlockHorizontal * 65,
      margin: EdgeInsets.all(kDefaultPadding * 2),
      child: TextButton(
        child: Text(
          "‹ Main Menu",
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.w600,
            fontSize: Responsive.safeBlockHorizontal * 5,
          ),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      decoration: BoxDecoration(
        color: kAccentColor,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
    );
  }
}
