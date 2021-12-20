import 'package:flutter/material.dart';
import 'package:cosmetics_shop/screens/home/components/header.dart';
import 'package:cosmetics_shop/screens/home/components/recommendations.dart';
import 'package:cosmetics_shop/screens/home/components/categories_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchDialog(),
        RecomendedItems(),
        CategoriesList(),
      ],
    );
  }
}
