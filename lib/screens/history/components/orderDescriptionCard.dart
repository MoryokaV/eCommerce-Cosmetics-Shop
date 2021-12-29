import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/models/order.dart';
import 'package:flutter/material.dart';

import '../../../responsive.dart';

class OrderDescriptionCard extends StatelessWidget {
  final Order order;

  OrderDescriptionCard({
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fill,
      child: Container(
        width: Responsive.screenWidth,
        margin: EdgeInsets.only(top: kDefaultPadding),
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: kBgColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(1, 1),
              blurRadius: 7,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "#" + order.number.toString(),
                  style: TextStyle(
                    fontFamily: "Calibri",
                    fontSize: Responsive.safeBlockHorizontal * 5,
                  ),
                ),
                Spacer(),
                Text(
                  order.date,
                  style: TextStyle(
                    fontFamily: "Calibri",
                    fontSize: Responsive.safeBlockHorizontal * 5,
                  ),
                ),
                Spacer(),
                Text(
                  order.value.toString() + " RON",
                  style: TextStyle(
                    fontFamily: "Calibri",
                    fontSize: Responsive.safeBlockHorizontal * 5,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: kDefaultPadding / 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    order.description,
                    style: TextStyle(
                      fontFamily: "Roboto-Light",
                      fontSize: Responsive.safeBlockHorizontal * 4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
