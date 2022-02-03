import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmetics_shop/models/favourites.dart';
import 'package:cosmetics_shop/responsive.dart';
import 'package:cosmetics_shop/screens/product/product_screen.dart';
import 'package:cosmetics_shop/services/firestoreService.dart';
import 'package:cosmetics_shop/services/sqliteHelper.dart';
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
  List<bool> favIcon = [];
  List<Favourite> favourites = [];
  bool isLoading = true;
  bool containerVisibility = true;

  void initState() {
    super.initState();
    productGathering();
  }

  Future<void> productGathering() async {
    favourites = await retrieveFavourites();

    favIcon.clear();

    for (int i = 0; i < favourites.length; i++) {
      favIcon.add(true);
    }

    setState(() => isLoading = false);
  }

  Future<void> removeFavourite(int index) async {
    await deleteFavouriteItem(favourites[index].productId);

    setState(() {
      favIcon[index] = false;
      containerVisibility = false;
    });

    Timer(Duration(milliseconds: 750), () {
      setState(() {
        favourites.remove(favourites[index]);
        favIcon[index] = true;
        containerVisibility = true;
      });
    });
  }

  Widget buildList() {
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: favourites.length,
        itemBuilder: (BuildContext context, int index) {
          return StreamBuilder<QuerySnapshot>(
            stream:
                FirestoreService.getProductById(favourites[index].productId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return LoadingIndicator;
              } else {
                Product product = Product.fromSnapshot(snapshot.data!.docs[0]);
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => ProductScreen(
                        productId: product.id,
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
                            margin: EdgeInsets.only(right: kDefaultPadding),
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
                                  blurRadius: 8,
                                  offset: Offset(2, 0),
                                ),
                              ],
                            ),
                            child: Image.network(
                              product.image,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: kDefaultPadding / 2,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                    fontFamily: "Roboto-Bold",
                                    fontSize:
                                        Responsive.safeBlockHorizontal * 5.5,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      product.price.toString() + " RON",
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
                                          ? Icon(Icons.favorite)
                                          : Icon(Icons.favorite_outline),
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
                            blurRadius: 8,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          );
        },
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
            ? LoadingIndicator
            : Column(
                children: [
                  favourites.length != 0 ? buildList() : buildEmptyList(),
                ],
              ),
      ),
    );
  }
}
