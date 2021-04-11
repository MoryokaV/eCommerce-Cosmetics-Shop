import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cosmetics_shop/models/favourites.dart';
import 'package:cosmetics_shop/models/products.dart';
import 'package:cosmetics_shop/screens/cart_screen.dart';
import 'package:cosmetics_shop/models/constants.dart';
import 'package:cosmetics_shop/models/cart.dart';
import 'package:cosmetics_shop/services/databaseHandler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ProductScreen extends StatefulWidget {
  final Product product;

  ProductScreen({this.product});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool fav = false;
  int quantity = 1;

  void addToCart(int id) async {
    for (int i = 0; i < cart.length; i++) {
      if (cart[i].productID == id) {
        await updateCartQuantity(
          Cart(
            productID: id,
            productQuantity: cart[i].productQuantity + 1,
          ),
        );
        return;
      }
    }

    await insertCartItem(
      Cart(
        productID: id,
        productQuantity: quantity,
      ),
    );
  }

  void addQuantity() {
    setState(() {
      if (quantity < 5) quantity++;
    });
  }

  void removeQuantity() {
    setState(() {
      if (quantity > 1) quantity--;
    });
  }

  void initState() {
    super.initState();
    checkFavourite();
  }

  void checkFavourite() async {
    for (int i = 0; i < favourites.length; i++) {
      if (favourites[i].productID == widget.product.id) {
        setState(
          () => fav = true,
        );
      }
    }
  }

  void addFavourites(Size screenSize) async {
    await insertFavouriteItem(
      Favourite(
        productID: widget.product.id,
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

  void toggleFavourite(Size screenSize) async {
    setState(
      () => fav = !fav,
    );

    fav
        ? addFavourites(screenSize)
        : await deleteFavouriteItem(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: screenSize.height * 0.6,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      left: defaultPadding * 3.5,
                      bottom: defaultPadding,
                    ),
                    height: screenSize.height * 0.475,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(36)),
                      color: accentColor,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black38,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding / 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          color: accentColor,
                          iconSize: 25,
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          icon: Icon(Icons.shopping_cart),
                          color: backgroundColor,
                          iconSize: 25,
                          onPressed: () => {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => CartScreen(),
                              ),
                            )
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: defaultPadding * 2,
                      bottom: defaultPadding,
                      top: defaultPadding * 5.25,
                    ),
                    padding: EdgeInsets.all(0),
                    height: screenSize.height * 0.2075,
                    width: screenSize.width * 0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(FontAwesomeIcons.plus),
                          onPressed: () => addQuantity(),
                          iconSize: screenSize.height * 0.025,
                          color: Colors.black54,
                          padding: EdgeInsets.only(
                            top: 0,
                            bottom: 0,
                            left: 1,
                            right: 1,
                          ),
                        ),
                        Spacer(),
                        Text(
                          quantity.toString(),
                          style: TextStyle(
                            fontFamily: "Calibri",
                            fontSize:
                                screenSize.width * screenSize.height * 0.0001,
                            color: Colors.black54,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.minus),
                          onPressed: () => removeQuantity(),
                          iconSize: screenSize.height * 0.025,
                          color: Colors.black54,
                          padding: EdgeInsets.only(
                            top: 0,
                            bottom: 0,
                            left: 1,
                            right: 1,
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17.5),
                      color: primaryColor,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black26,
                          blurRadius: 7.5,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: defaultPadding * 1.25,
                    left: 4,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      width: screenSize.width * 0.165,
                      height: screenSize.height * 0.085,
                      child: Center(
                        child: IconButton(
                          icon: fav
                              ? Icon(FontAwesomeIcons.solidHeart)
                              : Icon(FontAwesomeIcons.heart),
                          iconSize:
                              screenSize.width * screenSize.height * 0.0001,
                          color: Colors.red,
                          onPressed: () => toggleFavourite(screenSize),
                        ),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black26,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: defaultPadding / 2,
                    child: Image.asset(
                      widget.product.imagePath,
                      height: screenSize.height * 0.40,
                      width: screenSize.width * 0.70,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: defaultPadding * 1.5,
                    right: defaultPadding * 1.5,
                  ),
                  child: Text(
                    widget.product.name,
                    style: TextStyle(
                      fontFamily: "Calibri",
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: accentColor,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: defaultPadding * 1.5,
                      right: defaultPadding * 1.5,
                      top: defaultPadding / 4,
                      bottom: defaultPadding / 4,
                    ),
                    child: Container(
                      height: screenSize.height * 0.15,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          "·" + widget.product.longDescription,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Arial",
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: defaultPadding * 1.5,
                    right: defaultPadding * 1.5,
                    top: defaultPadding / 4,
                  ),
                  child: Text(
                    " - " + widget.product.price.toString() + " RON - ",
                    style: TextStyle(
                      fontFamily: "Calibri",
                      fontWeight: FontWeight.bold,
                      fontSize: 19.5,
                      color: accentColor,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: screenSize.height * 0.05,
              margin: EdgeInsets.only(
                left: defaultPadding,
                right: defaultPadding,
                top: defaultPadding / 2,
                bottom: defaultPadding / 2,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: accentColor,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0.5),
                    color: Colors.black26,
                    blurRadius: 7.5,
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
                            onPressed: () {
                              addToCart(widget.product.id);
                              Navigator.of(dialogContext, rootNavigator: true)
                                  .pop();
                            }),
                        CupertinoDialogAction(
                          child: const Text("Yes"),
                          onPressed: () {
                            addToCart(widget.product.id);
                            Navigator.of(dialogContext, rootNavigator: true)
                                .pop();
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => CartScreen(),
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}
