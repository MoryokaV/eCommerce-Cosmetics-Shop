import 'package:cosmetics_shop/database/constants.dart';
import 'package:flutter/material.dart';

class SearchDialog extends StatefulWidget {
  @override
  _SearchDialogState createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: screenSize.height * 0.2,
          child: Stack(
            children: <Widget>[
              Container(
                height: screenSize.height * 0.185,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36.0),
                    bottomRight: Radius.circular(36.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: defaultPadding * 4.5,
                  left: defaultPadding / 2,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hi, what do you buy today?",
                      style: TextStyle(
                        fontSize: screenSize.width * 0.0675,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: defaultPadding / 4,
                right: 0,
                left: 0,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: defaultPadding - 5),
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding - 5),
                  height: 54,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, 10),
                        blurRadius: 25,
                      ),
                    ],
                  ),
                  child: TextField(
                    onSubmitted: (string) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      hintText: "Search",
                      fillColor: primaryColor,
                      hintStyle: TextStyle(
                        color: accentColor.withOpacity(0.75),
                        fontWeight: FontWeight.w700,
                        fontFamily: "Roboto-Light",
                        fontSize: 22,
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.search,
                        color: accentColor,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
