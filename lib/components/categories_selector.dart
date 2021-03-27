import 'package:cosmetics_shop/screens/category_screen.dart';
import 'package:cosmetics_shop/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:cosmetics_shop/models/categoriesList.dart';

class CategoriesList extends StatefulWidget {
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: defaultPadding / 1.5,
              ),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: screenSize.width * 0.0675,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontFamily: "Roboto-Medium",
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(
            left: 4,
            right: 4,
          ),
          height: screenSize.height * 0.17,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                Category category = categories[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryScreen(
                        category: category,
                      ),
                    ),
                  ),
                  child: Container(
                    width: screenSize.width * 0.3,
                    margin: EdgeInsets.only(
                      top: screenSize.height * 0.0125,
                      left: screenSize.width * 0.015,
                      right: screenSize.width * 0.015,
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: CircleAvatar(
                            radius:
                                screenSize.width * screenSize.height * 0.000155,
                            backgroundColor: primaryColor,
                            child: Image.asset(
                              category.iconPath,
                              width: screenSize.width * 0.19,
                              height: screenSize.height * 0.08,
                            ),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black45,
                                blurRadius: 7.5,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Text(
                          category.name,
                          style: TextStyle(
                            fontFamily: "Roboto-Regular",
                            fontWeight: FontWeight.w800,
                            color: Colors.black54,
                            fontSize: screenSize.width * 0.0425,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
