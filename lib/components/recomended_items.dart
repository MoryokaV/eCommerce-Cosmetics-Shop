import 'package:cosmetics_shop/screens/viewAll_screen.dart';
import 'package:cosmetics_shop/models/constants.dart';
import 'package:cosmetics_shop/screens/product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cosmetics_shop/models/products.dart';

class RecomendedItems extends StatefulWidget {
  @override
  _RecomendedItemsState createState() => _RecomendedItemsState();
}

class _RecomendedItemsState extends State<RecomendedItems> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: defaultPadding / 1.5,
            right: defaultPadding / 1.5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 2,
                ),
                child: Text(
                  "Recomended",
                  style: TextStyle(
                    fontSize: screenSize.width * 0.0675,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontFamily: "Roboto-Medium",
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.fill,
                child: Container(
                  height: screenSize.height * 0.04,
                  margin: EdgeInsets.only(
                    left: defaultPadding,
                    top: 2,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => ViewAllScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "More",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto-Thin",
                        fontSize: screenSize.height * 0.02,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black38,
                        blurRadius: 2.5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 1,
            right: 1,
          ),
          padding: EdgeInsets.only(
            left: defaultPadding / 2,
            right: defaultPadding / 2,
            top: defaultPadding / 3,
          ),
          height: screenSize.height * 0.28,
          //color: Colors.white,
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
                      margin: EdgeInsets.only(left: 7.5, right: 7.5),
                      height: screenSize.height / 5.95,
                      width: screenSize.width / 2.8,
                      child: Image.asset(
                        product.image,
                      ),
                      decoration: BoxDecoration(
                        color: backgroundAccent,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      height: screenSize.height / 12,
                      width: screenSize.width / 2.8,
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
                              color: accentColor,
                              fontFamily: "Roboto-BlackItalic",
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: accentColor.withOpacity(0.4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
