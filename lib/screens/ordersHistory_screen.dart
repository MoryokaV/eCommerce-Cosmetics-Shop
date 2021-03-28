import 'package:cosmetics_shop/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:cosmetics_shop/models/order.dart';

class OrdersHistoryScreen extends StatefulWidget {
  @override
  _OrdersHistoryScreenState createState() => _OrdersHistoryScreenState();
}

class _OrdersHistoryScreenState extends State<OrdersHistoryScreen> {
  Widget buildOrdersList(Size screenSize) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: orders.length,
      itemBuilder: (BuildContext context, int index) {
        Order order = orders[index];
        return FittedBox(
          fit: BoxFit.fill,
          child: Container(
            width: screenSize.width,
            margin: EdgeInsets.only(
              top: defaultPadding,
              bottom: defaultPadding / 1.75,
            ),
            padding: EdgeInsets.only(
              left: defaultPadding,
              right: defaultPadding,
              top: defaultPadding / 2,
              bottom: defaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
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
                      order.dateTime,
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
                  padding: EdgeInsets.only(
                    top: defaultPadding / 4,
                  ),
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
      },
    );
  }

  Widget buildPopUpMessage(Size screenSize) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(
          "assets/images/misc/order-history2.png",
          height: screenSize.height * 0.55,
        ),
        SizedBox(
          height: screenSize.height * 0.2,
        ),
        Container(
          height: screenSize.height * 0.0625,
          width: screenSize.width * 0.75,
          child: TextButton(
            child: Text(
              "‹ Main Menu",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: screenSize.height * 0.035,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(36),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 5,
                offset: Offset(0, 1),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(context, screenSize),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          orders.length != 0
              ? buildOrdersList(screenSize)
              : buildPopUpMessage(screenSize),
          if (orders.length != 0)
            Container(
              height: screenSize.height * 0.065,
              margin: EdgeInsets.all(
                defaultPadding,
              ),
              child: TextButton(
                child: Text(
                  "‹ Main Menu",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: screenSize.height * 0.035,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(36),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context, Size screenSize) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: accentColor,
      elevation: 10,
      title: Center(
        child: Text(
          "Orders History",
          style: TextStyle(
            color: primaryColor,
            fontFamily: "Arial",
            fontWeight: FontWeight.bold,
            fontSize: screenSize.height * 0.03,
          ),
        ),
      ),
    );
  }
}
