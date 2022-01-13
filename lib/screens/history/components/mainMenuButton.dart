import 'package:cosmetics_shop/constants.dart';
import 'package:flutter/material.dart';

import '../../../responsive.dart';

class MainMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        "‹ Main Menu",
        style: TextStyle(
          color: kPrimaryColor,
          fontWeight: FontWeight.w600,
          fontSize: Responsive.safeBlockHorizontal * 5,
        ),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 4,
        primary: kAccentColor,
        padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2, horizontal: kDefaultPadding * 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      onPressed: () => Navigator.pop(context),
    );
  }
}
