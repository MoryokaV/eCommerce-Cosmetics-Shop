import 'package:cosmetics_shop/screens/account_screen.dart';
import 'package:cosmetics_shop/models/constants.dart';
import 'package:cosmetics_shop/screens/favourites_screen.dart';
import 'package:cosmetics_shop/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TemplateLayer extends StatefulWidget {
  @override
  _TemplateLayer createState() => _TemplateLayer();
}

class _TemplateLayer extends State<TemplateLayer> {
  int _selectedPage = 0;

  static List<Widget> screens = <Widget>[
    HomeScreen(),
    FavouritesScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _selectedPage == 0 ? buildAppBar() : null,
      body: screens[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.compass),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favourites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Account",
          ),
        ],
        currentIndex: _selectedPage,
        selectedItemColor: accentColor,
        onTap: _onItemTapped,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: accentColor,
      elevation: 0,
      leading: Icon(
        FontAwesomeIcons.shopify,
        color: primaryColor,
        size: 30,
      ),
      title: Text(
        "Cosmetics Shop",
        style: TextStyle(
          color: primaryColor,
          fontFamily: "Arial",
          fontSize: 23,
        ),
      ),
    );
  }
}
