import 'package:cosmetics_shop/models/constants.dart';
import 'package:cosmetics_shop/screens/about_screen.dart';
import 'package:cosmetics_shop/screens/cart_screen.dart';
import 'package:cosmetics_shop/screens/ordersHistory_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: screenSize.height * 0.15,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: screenSize.height * 0.14,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: defaultPadding,
                          ),
                          child: Icon(
                            Icons.account_circle,
                            color: Colors.white70,
                            size: screenSize.width * 0.2,
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width * 0.05,
                        ),
                        Text(
                          "My Profile",
                          style: TextStyle(
                            fontFamily: "Calibri",
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36.0),
                        bottomRight: Radius.circular(36.0),
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultPadding),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: defaultPadding,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => CartScreen(),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(
                  top: defaultPadding / 1.5,
                ),
                height: screenSize.height * 0.155,
                width: screenSize.width * 0.9,
                decoration: BoxDecoration(
                  color: backgroundAccent,
                  borderRadius: BorderRadius.circular(
                    defaultPadding,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 10,
                      offset: Offset(2, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: defaultPadding,
                        top: defaultPadding,
                        left: defaultPadding / 2,
                        right: defaultPadding / 2,
                      ),
                      height: screenSize.height * 0.12,
                      width: screenSize.width * 0.22,
                      child: Image.asset(
                        "assets/images/misc/cart_ic.png",
                      ),
                    ),
                    Text(
                      "Shopping Cart",
                      style: TextStyle(
                        fontFamily: "Century-Gothic",
                        color: Colors.white,
                        fontSize: screenSize.width * 0.065,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => OrdersHistoryScreen(),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(
                  top: defaultPadding,
                ),
                height: screenSize.height * 0.155,
                width: screenSize.width * 0.9,
                decoration: BoxDecoration(
                  color: backgroundAccent,
                  borderRadius: BorderRadius.circular(
                    defaultPadding,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 10,
                      offset: Offset(2, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: defaultPadding,
                        top: defaultPadding,
                        left: defaultPadding / 2,
                        right: defaultPadding / 2,
                      ),
                      height: screenSize.height * 0.12,
                      width: screenSize.width * 0.22,
                      child: Image.asset(
                        "assets/images/misc/order-history.png",
                      ),
                    ),
                    Text(
                      "Orders History",
                      style: TextStyle(
                        fontFamily: "Century-Gothic",
                        color: Colors.white,
                        fontSize: screenSize.width * 0.065,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => AboutScreen(),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(
                  top: defaultPadding,
                ),
                height: screenSize.height * 0.155,
                width: screenSize.width * 0.9,
                decoration: BoxDecoration(
                  color: backgroundAccent,
                  borderRadius: BorderRadius.circular(
                    defaultPadding,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 10,
                      offset: Offset(2, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: defaultPadding,
                        top: defaultPadding,
                        left: defaultPadding / 2,
                        right: defaultPadding / 2,
                      ),
                      height: screenSize.height * 0.12,
                      width: screenSize.width * 0.22,
                      child: Image.asset(
                        "assets/images/misc/info_ic.png",
                      ),
                    ),
                    Text(
                      "About Us",
                      style: TextStyle(
                        fontFamily: "Century-Gothic",
                        color: Colors.white,
                        fontSize: screenSize.width * 0.065,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: accentColor,
      automaticallyImplyLeading: false,
      elevation: 0,
      titleSpacing: 0,
    );
  }
}
