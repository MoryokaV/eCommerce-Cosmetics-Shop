import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/screens/product/product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cosmetics_shop/models/products.dart';

class Recommendations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * 0.28,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          Product product = products[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => ProductScreen(
                  product: product,
                ),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                  height: screenSize.height * 0.18,
                  width: screenSize.width * 0.35,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.asset(product.image),
                  ),
                  decoration: BoxDecoration(
                    color: kBgAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                ),
                Container(
                  height: screenSize.height * 0.08,
                  width: screenSize.width * 0.35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.name,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Roboto-Medium",
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "- " + product.price.toString() + " RON -",
                        style: TextStyle(
                          color: kAccentColor,
                          fontFamily: "Roboto-BlackItalic",
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: kAccentColor.withOpacity(0.4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
