import 'package:flutter/material.dart';
import 'package:cosmetics_shop/components/header_searchbox.dart';
import 'package:cosmetics_shop/components/recomended_items.dart';
import 'package:cosmetics_shop/components/categories_selector.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchDialog(),
        RecomendedItems(),
        CategoriesList(),
      ],
    );
  }
}
