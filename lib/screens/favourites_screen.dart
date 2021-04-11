import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cosmetics_shop/services/databaseHandler.dart';
import 'package:cosmetics_shop/screens/product_screen.dart';
import 'package:cosmetics_shop/models/constants.dart';
import 'package:cosmetics_shop/models/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class FavouritesScreen extends StatefulWidget {
  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen>
    with TickerProviderStateMixin {
  AnimationController controller;

  List<Product> favProducts = [];
  List<bool> favIco = [];
  bool containerVisibility = true;

  void initState() {
    super.initState();
    productGathering();
  }

  void productGathering() async {
    favIco.clear();
    favProducts.clear();

    for (int i = 0; i < favourites.length; i++) {
      favIco.add(true);
      favProducts.add(products[favourites[i].productID - 1]);
    }
  }

  void removeFavourite(int index) async {
    setState(() {
      favIco[index] = false;
      containerVisibility = !containerVisibility;
    });

    await deleteFavouriteItem(favProducts[index].id);

    Timer(
      Duration(milliseconds: 750),
      () {
        setState(
          () => containerVisibility = !containerVisibility,
        );

        productGathering();
      },
    );
  }

  Future<Null> refreshPage() async {
    setState(() {
      productGathering();
    });
  }

  Widget buildList(BuildContext context, Size screenSize) {
    if (favProducts.length != 0) {
      return Expanded(
        child: RefreshIndicator(
          onRefresh: refreshPage,
          child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: favProducts.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => ProductScreen(
                        product: favProducts[index],
                      ),
                    ),
                  ),
                  child: AnimatedOpacity(
                    opacity: containerVisibility ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: Container(
                      margin: EdgeInsets.only(
                        left: defaultPadding,
                        right: defaultPadding,
                        top: defaultPadding / 1.5,
                        bottom: defaultPadding / 1.5,
                      ),
                      height: screenSize.height * 0.2,
                      child: Row(
                        children: [
                          Container(
                            height: screenSize.height * 0.2,
                            width: screenSize.width * 0.35,
                            decoration: BoxDecoration(
                              color: backgroundAccent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(defaultPadding),
                                bottomLeft: Radius.circular(defaultPadding),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 10,
                                  offset: Offset(7, 0),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              favProducts[index].imagePath,
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                height: screenSize.height * 0.08,
                                width: screenSize.width * 0.45,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: defaultPadding / 2,
                                  ),
                                  child: Center(
                                    child: Text(
                                      favProducts[index].name,
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                        fontFamily: "Roboto-Bold",
                                        fontSize: screenSize.width * 0.055,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: defaultPadding * 1.75,
                                  right: defaultPadding,
                                  bottom: defaultPadding / 1.5,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      favProducts[index].price.toString() +
                                          " RON",
                                      style: TextStyle(
                                        fontFamily: "Roboto-Black",
                                        fontSize: screenSize.width * 0.05,
                                        fontWeight: FontWeight.bold,
                                        color: accentColor,
                                      ),
                                    ),
                                    IconButton(
                                      icon: favIco[index]
                                          ? Icon(FontAwesomeIcons.solidHeart)
                                          : Icon(FontAwesomeIcons.heart),
                                      onPressed: () => removeFavourite(index),
                                      color: Colors.red,
                                      iconSize: screenSize.width * 0.075,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(defaultPadding),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 10,
                            offset: Offset(3, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      );
    } else {
      return Expanded(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/misc/sad_emoji.png",
                height: screenSize.width * 0.3,
                width: screenSize.width * 0.3,
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              Text(
                "It seems like you don't have a favourite product yet!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Century-Gothic",
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: accentColor,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            buildList(context, screenSize),
          ],
        ),
      ),
    );
  }
}
