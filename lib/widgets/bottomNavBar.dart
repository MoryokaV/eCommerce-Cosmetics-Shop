import 'package:cosmetics_shop/screens/account/account_screen.dart';
import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/screens/favourites/favourites_screen.dart';
import 'package:cosmetics_shop/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBar createState() => _BottomNavBar();
}

class _BottomNavBar extends State<BottomNavBar> {
  int _currentPage = 0;

  List<Widget> screens = [
    HomeScreen(),
    FavouritesScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _currentPage = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _currentPage == 0 ? buildAppBar() : null,
      body: screens[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
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
        currentIndex: _currentPage,
        selectedItemColor: kAccentColor,
        onTap: _onItemTapped,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kAccentColor,
      elevation: 0,
      leading: Icon(
        Icons.shopping_bag_outlined,
        color: kPrimaryColor,
        size: 30,
      ),
      title: Text(
        "Cosmetics Shop",
        style: TextStyle(
          color: kPrimaryColor,
          fontSize: 20,
        ),
      ),
    );
  }
}
