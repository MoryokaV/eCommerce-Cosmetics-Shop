import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/screens/about/about_screen.dart';
import 'package:cosmetics_shop/screens/account/components/navButton.dart';
import 'package:cosmetics_shop/screens/cart/cart_screen.dart';
import 'package:cosmetics_shop/screens/history/history_screen.dart';
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
      appBar: AppBar(
        backgroundColor: accentColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: screenSize.height * 0.15,
              child: Stack(
                children: [
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
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: defaultPadding,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
            NavButton(
              image: "assets/images/misc/cart_ic.png",
              title: "Shopping Cart",
              nextScreen: CartScreen(),
            ),
            NavButton(
              image: "assets/images/misc/order-history.png",
              title: "Orders History",
              nextScreen: HistoryScreen(),
            ),
            NavButton(
              image: "assets/images/misc/info_ic.png",
              title: "About Us",
              nextScreen: AboutScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
