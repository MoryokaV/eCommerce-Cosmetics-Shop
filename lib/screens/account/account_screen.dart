import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/screens/about/about_screen.dart';
import 'package:cosmetics_shop/screens/account/components/navButton.dart';
import 'package:cosmetics_shop/screens/cart/cart_screen.dart';
import 'package:cosmetics_shop/screens/history/history_screen.dart';
import 'package:flutter/material.dart';

import '../../responsive.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAccentColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: Responsive.safeBlockVertical * 14,
                  margin: EdgeInsets.only(bottom: kDefaultPadding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: kDefaultPadding,
                        ),
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.white70,
                          size: Responsive.safeBlockHorizontal * 18,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "My Profile",
                        style: TextStyle(
                          fontFamily: "Calibri",
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.safeBlockHorizontal * 7,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: kAccentColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: kDefaultPadding,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ],
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
