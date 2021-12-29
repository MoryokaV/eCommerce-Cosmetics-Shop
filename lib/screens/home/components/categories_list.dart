import 'package:cosmetics_shop/screens/category/category_screen.dart';
import 'package:cosmetics_shop/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cosmetics_shop/models/categories.dart';

import '../../../responsive.dart';

class CategoriesList extends StatefulWidget {
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.safeBlockVertical * 20,
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            Category category = categories[index];
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => CategoryScreen(
                    category: category,
                  ),
                ),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                child: Column(
                  children: [
                    Container(
                      height: Responsive.safeBlockHorizontal * 20,
                      width: Responsive.safeBlockHorizontal * 20,
                      margin:
                          EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Image.asset(
                          category.icon,
                          height: Responsive.safeBlockHorizontal * 13,
                          width: Responsive.safeBlockHorizontal * 13,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black45,
                            blurRadius: 7,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      category.name,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontSize: Responsive.safeBlockHorizontal * 4,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
