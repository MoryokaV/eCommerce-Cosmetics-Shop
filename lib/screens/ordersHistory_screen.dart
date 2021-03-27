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
      itemCount: orders.length,
      itemBuilder: (BuildContext context, int index) {
        return Container();
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
          height: screenSize.height * 0.075,
          width: screenSize.width * 0.80,
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
      body: SafeArea(
        child: ListView(
          children: [
            orders.length != 0
                ? buildOrdersList(screenSize)
                : buildPopUpMessage(screenSize),
          ],
        ),
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
