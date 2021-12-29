import 'package:cosmetics_shop/constants.dart';
import 'package:flutter/material.dart';

class TextFieldName extends StatelessWidget {
  final String text;

  TextFieldName({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: kDefaultPadding / 3),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
      ),
    );
  }
}
