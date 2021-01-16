import 'package:cosmetics_shop/database/constants.dart';
import 'package:flutter/material.dart';
import 'package:cosmetics_shop/templateLayer.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  FocusNode _focusNodeName = new FocusNode();
  FocusNode _focusNodeAddress = new FocusNode();
  FocusNode _focusNodeZip = new FocusNode();

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
                defaultPadding / 1.25,
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
            Container(
              height: screenSize.height * 0.1,
              width: screenSize.width * 0.9,
              child: TextField(
                focusNode: _focusNodeName,
                onSubmitted: (string) {
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                  labelText: "Full Name",
                  labelStyle: TextStyle(
                    fontFamily: "Arial",
                    color: _focusNodeName.hasFocus
                        ? Colors.black54
                        : Colors.black54,
                  ),
                ),
              ),
            ),
            Container(
              height: screenSize.height * 0.1,
              width: screenSize.width * 0.9,
              child: TextField(
                focusNode: _focusNodeAddress,
                onSubmitted: (string) {
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                  labelText: "Address",
                  labelStyle: TextStyle(
                    fontFamily: "Arial",
                    color: _focusNodeAddress.hasFocus
                        ? Colors.black54
                        : Colors.black54,
                  ),
                ),
              ),
            ),
            Container(
              height: screenSize.height * 0.1,
              width: screenSize.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: screenSize.width * 0.4,
                    child: DropdownButton(
                      items: null,
                      onChanged: null,
                    ),
                  ),
                  Container(
                    width: screenSize.width * 0.4,
                    child: TextField(
                      focusNode: _focusNodeZip,
                      onSubmitted: (string) {
                        FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                        labelText: "Zip Code",
                        labelStyle: TextStyle(
                          fontFamily: "Arial",
                          color: _focusNodeZip.hasFocus
                              ? Colors.black54
                              : Colors.black54,
                        ),
                      ),
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
