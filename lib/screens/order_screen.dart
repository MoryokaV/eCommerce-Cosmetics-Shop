import 'package:cosmetics_shop/database/constants.dart';
import 'package:cosmetics_shop/templateLayer.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(screenSize),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(
                defaultPadding,
              ),
              child: Row(
                children: [
                  Text(
                    "Shipping",
                    style: TextStyle(
                      fontSize: screenSize.width * 0.085,
                      color: Colors.black87,
                      fontFamily: "Robot-Black",
                      fontWeight: FontWeight.bold,
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

  Widget buildAppBar(Size screenSize) {
    return AppBar(
      backgroundColor: accentColor,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 5,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: screenSize.width * 0.06,
            color: primaryColor,
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            "Checkout",
            style: TextStyle(
              fontFamily: "Roboto-Medium",
              color: primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: screenSize.width * 0.055,
            ),
          ),
          IconButton(
            icon: Icon(Icons.home),
            iconSize: screenSize.width * 0.06,
            color: primaryColor,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TemplateLayer(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
