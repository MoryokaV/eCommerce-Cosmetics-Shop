import 'package:cosmetics_shop/constants.dart';
import 'package:flutter/material.dart';

class MainMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height * 0.06,
      width: screenSize.width * 0.65,
      margin: EdgeInsets.all(kDefaultPadding * 2),
      child: TextButton(
        child: Text(
          "‹ Main Menu",
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.w600,
            fontSize: screenSize.height * 0.03,
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
