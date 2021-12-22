import 'package:cosmetics_shop/models/favourites.dart';
import 'package:cosmetics_shop/screens/product/product_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cosmetics_shop/services/databaseHandler.dart';
import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/models/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class FavouritesScreen extends StatefulWidget {
  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<Product> favProducts = [];
  List<bool> favIcon = [];
  bool isLoading = true;
  bool containerVisibility = true;

  void initState() {
    super.initState();
    productGathering();
  }

  Future<void> productGathering() async {
    List<Favourite> favourites = await retrieveFavourites();

    favIcon.clear();
    favProducts.clear();

    for (int i = 0; i < favourites.length; i++) {
      favIcon.add(true);
      favProducts.add(products[favourites[i].productID - 1]);
    }

    setState(() => isLoading = false);
  }

  Future<void> removeFavourite(int index) async {
    await deleteFavouriteItem(favProducts[index].id);

    setState(() {
      favIcon[index] = false;
      containerVisibility = false;
    });

    Timer(Duration(milliseconds: 750), () {
      setState(() {
        favProducts.remove(favProducts[index]);
        favIcon[index] = true;
        containerVisibility = true;
      });
    });
  }

  Future<Null> refreshPage() async {
    productGathering();
  }

  Widget buildList(Size screenSize) {
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
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      top: kDefaultPadding / 1.5,
                      bottom: kDefaultPadding / 1.5,
                    ),
                    height: screenSize.height * 0.2,
                    child: Row(
                      children: [
                        Container(
                          height: screenSize.height * 0.2,
                          width: screenSize.width * 0.35,
                          decoration: BoxDecoration(
                            color: kBgAccent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
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
                            favProducts[index].image,
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              height: screenSize.height * 0.08,
                              width: screenSize.width * 0.45,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: kDefaultPadding / 2,
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
                                left: kDefaultPadding * 1.75,
                                right: kDefaultPadding,
                                bottom: kDefaultPadding / 1.5,
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
                                      color: kAccentColor,
                                    ),
                                  ),
                                  IconButton(
                                    icon: favIcon[index]
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
                      borderRadius: BorderRadius.circular(20),
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
  }

  Widget buildEmptyList(Size screenSize) {
    return Expanded(
      child: Container(
        child: Center(
          child: Column(
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
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenSize.width * 0.8,
                ),
                child: Text(
                  "It seems like you don't have a favourite product yet!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Century-Gothic",
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: kAccentColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  favProducts.length != 0
                      ? buildList(screenSize)
                      : buildEmptyList(screenSize),
                ],
              ),
      ),
    );
  }
}
