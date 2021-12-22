import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/models/order.dart';
import 'package:flutter/material.dart';

class OrderDescriptionCard extends StatelessWidget {
  final Order order;

  OrderDescriptionCard({
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return FittedBox(
      fit: BoxFit.fill,
      child: Container(
        width: screenSize.width,
        margin: EdgeInsets.only(
          top: kDefaultPadding,
          bottom: kDefaultPadding / 1.75,
        ),
        padding: EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: kBgColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(1, 1),
              blurRadius: 7.5,
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
                    fontSize: screenSize.width * 0.055,
                  ),
                ),
                Spacer(),
                Text(
                  order.date,
                  style: TextStyle(
                    fontFamily: "Calibri",
                    fontSize: screenSize.width * 0.055,
                  ),
                ),
                Spacer(),
                Text(
                  order.value.toString() + " RON",
                  style: TextStyle(
                    fontFamily: "Calibri",
                    fontSize: screenSize.width * 0.055,
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
                      fontSize: screenSize.width * 0.04,
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
