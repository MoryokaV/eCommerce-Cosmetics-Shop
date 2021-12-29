import 'package:cosmetics_shop/models/favourites.dart';
import 'package:cosmetics_shop/responsive.dart';
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

  Widget buildList() {
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
                    margin: EdgeInsets.all(
                      kDefaultPadding,
                    ),
                    height: Responsive.safeBlockVertical * 20,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: kDefaultPadding,
                          ),
                          height: Responsive.safeBlockVertical * 20,
                          width: Responsive.safeBlockHorizontal * 35,
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
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Image.asset(
                              favProducts[index].image,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: kDefaultPadding / 2,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  favProducts[index].name,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                    fontFamily: "Roboto-Bold",
                                    fontSize:
                                        Responsive.safeBlockHorizontal * 5.5,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Text(
                                    favProducts[index].price.toString() +
                                        " RON",
                                    style: TextStyle(
                                      fontFamily: "Roboto-Black",
                                      fontSize:
                                          Responsive.safeBlockHorizontal * 5,
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
                                    iconSize:
                                        Responsive.safeBlockHorizontal * 7,
                                  )
                                ],
                              ),
                            ],
                          ),
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

  Widget buildEmptyList() {
    return Expanded(
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/misc/sad_emoji.png",
                height: Responsive.safeBlockHorizontal * 30,
                width: Responsive.safeBlockHorizontal * 30,
              ),
              SizedBox(
                height: Responsive.safeBlockVertical * 4,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: Responsive.screenWidth * 0.8,
                ),
                child: Text(
                  "It seems like you don't have a favourite product yet!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Century-Gothic",
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.safeBlockHorizontal * 6,
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
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  favProducts.length != 0 ? buildList() : buildEmptyList(),
                ],
              ),
      ),
    );
  }
}
