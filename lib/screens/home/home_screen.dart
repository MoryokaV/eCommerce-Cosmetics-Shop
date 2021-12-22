import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/models/categories.dart';
import 'package:cosmetics_shop/screens/category/category_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cosmetics_shop/screens/home/components/header.dart';
import 'package:cosmetics_shop/screens/home/components/recommendations.dart';
import 'package:cosmetics_shop/screens/home/components/categories_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Header(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recomended",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 30,
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => CategoryScreen(
                                category: Category(
                                  icon: "",
                                  id: 0,
                                  name: "All products",
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "More",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: kPrimaryColor),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: kAccentColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black38,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Recommendations(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: kDefaultPadding),
                  child: Text(
                    "Categories",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            CategoriesList(),
          ],
        ),
      ),
    );
  }
}
