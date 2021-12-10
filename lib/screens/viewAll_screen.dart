import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cosmetics_shop/services/databaseHandler.dart';
import 'package:cosmetics_shop/screens/product_screen.dart';
import 'package:cosmetics_shop/screens/cart_screen.dart';
import 'package:cosmetics_shop/models/favourites.dart';
import 'package:cosmetics_shop/models/constants.dart';
import 'package:cosmetics_shop/models/products.dart';
import 'package:cosmetics_shop/models/cart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ViewAllScreen extends StatefulWidget {
  @override
  _ViewAllScreenState createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  List<bool> favIco = [];
  List<Cart> cartItems = [];

  void initState() {
    super.initState();

    favouritesGathering();
    //cartGathering();
  }

  //void cartGathering() async => cartItems = await retrieveCart();

  Future<void> addToCart(int id) async {
    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i].productID == id) {
        await updateCartQuantity(
          Cart(
            productID: id,
            productQuantity: cartItems[i].productQuantity + 1,
          ),
        );
        return;
      }
    }

    await insertCartItem(
      Cart(
        productID: id,
        productQuantity: 1,
      ),
    );
  }

  void addFavourites(Size screenSize, int id) async {
    await insertFavouriteItem(
      Favourite(
        productID: id,
      ),
    );

    Fluttertoast.showToast(
      msg: addFavDialogTexts[Random().nextInt(addFavDialogTexts.length)],
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: screenSize.width * 0.04,
    );
  }

  void toggleFavourites(Size screenSize, int index, int id) async {
    setState(
      () => favIco[index] = !favIco[index],
    );

    favIco[index]
        ? addFavourites(screenSize, id)
        : await deleteFavouriteItem(id);
  }

  void favouritesGathering() async {
    //List<Favourite> favourites = await retrieveFavourites();
    favIco.clear();

    setState(() {
      for (int i = 0; i < products.length; i++) {
        favIco.add(false);
        for (int j = 0; j < favourites.length; j++) {
          if (favourites[j].productID == products[i].id) {
            favIco[i] = true;
            break;
          }
        }
      }
    });
  }

  Future<Null> _onRefresh() async {
    favouritesGathering();
    //cartGathering();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(context, screenSize),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => ProductScreen(
                              product: products[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          top: defaultPadding,
                          bottom: defaultPadding / 1.5,
                        ),
                        height: screenSize.height * 0.2,
                        width: screenSize.width,
                        child: Row(
                          children: [
                            Container(
                              height: screenSize.height * 0.2,
                              width: screenSize.width * 0.35,
                              child: Image.asset(
                                products[index].imagePath,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: defaultPadding / 2,
                                        left: defaultPadding / 2.5,
                                        right: 4,
                                      ),
                                      height: screenSize.height * 0.075,
                                      width: screenSize.width * 0.525,
                                      child: RichText(
                                        overflow: TextOverflow.fade,
                                        maxLines: 2,
                                        softWrap: true,
                                        text: TextSpan(
                                          text: products[index].name,
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: "Calibri",
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenSize.height * 0.025,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: " - " +
                                                  products[index]
                                                      .shortDescription,
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: "Calibri",
                                                fontWeight: FontWeight.w300,
                                                fontSize:
                                                    screenSize.height * 0.0225,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: screenSize.height * 0.025,
                                      backgroundColor: Colors.grey[200],
                                      child: IconButton(
                                        icon: Icon(FontAwesomeIcons.solidHeart),
                                        color: favIco[index]
                                            ? Colors.red
                                            : Colors.grey[600],
                                        onPressed: () => toggleFavourites(
                                            screenSize,
                                            index,
                                            products[index].id),
                                        iconSize: screenSize.height *
                                            screenSize.width *
                                            0.0000575,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: defaultPadding / 2,
                                        left: defaultPadding / 2,
                                      ),
                                      child: Text(
                                        products[index].price.toString() +
                                            " RON",
                                        style: TextStyle(
                                          fontFamily: "Roboto-Medium",
                                          color: accentColor,
                                          fontSize: screenSize.width * 0.045,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.015,
                                ),
                                Container(
                                  height: screenSize.height * 0.045,
                                  width: screenSize.width * 0.55,
                                  margin: EdgeInsets.only(
                                    left: defaultPadding / 2,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: accentColor,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 0.5),
                                        color: Colors.black26,
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext dialogContext) =>
                                            CupertinoAlertDialog(
                                          title: Text(
                                            "View cart details?",
                                            style: TextStyle(
                                              fontFamily: "Arial",
                                              fontSize: screenSize.width * 0.05,
                                            ),
                                          ),
                                          content: Text(
                                            "Successfully added to your bag!",
                                            style: TextStyle(
                                              fontFamily: "Arial",
                                              fontSize: screenSize.width * 0.04,
                                            ),
                                          ),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: const Text("No"),
                                              onPressed: () async {
                                                await addToCart(
                                                    products[index].id);
                                                Navigator.of(dialogContext,
                                                        rootNavigator: true)
                                                    .pop();
                                              },
                                            ),
                                            CupertinoDialogAction(
                                              child: const Text("Yes"),
                                              onPressed: () async {
                                                await addToCart(
                                                    products[index].id);
                                                Navigator.of(dialogContext,
                                                        rootNavigator: true)
                                                    .pop();
                                                Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (_) =>
                                                        CartScreen(),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Add to cart",
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontFamily: "Roboto-Thin",
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenSize.width * 0.05,
                                          ),
                                          Icon(
                                            FontAwesomeIcons.shoppingCart,
                                            color: primaryColor,
                                            size: screenSize.width * 0.05,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(1, 1),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context, Size screenSize) {
    return AppBar(
      elevation: 5,
      backgroundColor: accentColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: Colors.white,
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        "All Products",
        style: TextStyle(
          color: primaryColor,
          fontSize: screenSize.width * 0.06,
          fontFamily: "Arial",
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
