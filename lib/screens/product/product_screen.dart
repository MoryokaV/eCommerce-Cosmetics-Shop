import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cosmetics_shop/models/favourites.dart';
import 'package:cosmetics_shop/models/products.dart';
import 'package:cosmetics_shop/screens/cart/cart_screen.dart';
import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/models/cart.dart';
import 'package:cosmetics_shop/services/databaseHandler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ProductScreen extends StatefulWidget {
  final Product product;

  ProductScreen({
    required this.product,
  });

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool fav = false;
  int quantity = 1;

  void initState() {
    super.initState();
    checkFavourite();
  }

  Future<void> addToCart(int id) async {
    List<Cart> cart = await retrieveCart();

    for (int i = 0; i < cart.length; i++) {
      if (cart[i].productID == id) {
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
    if (quantity < 5) setState(() => quantity++);
  }

  void removeQuantity() {
    if (quantity > 1) setState(() => quantity--);
  }

  Future<void> checkFavourite() async {
    List<Favourite> favourites = await retrieveFavourites();

    for (int i = 0; i < favourites.length; i++) {
      if (favourites[i].productID == widget.product.id) {
        setState(() => fav = true);
        break;
      }
    }
  }

  Future<void> addFavourites() async {
    await insertFavouriteItem(Favourite(productID: widget.product.id));

    Fluttertoast.showToast(
      msg: toastMsg[Random().nextInt(toastMsg.length)],
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16,
    );
  }

  void toggleFavourite() async {
    setState(() => fav = !fav);

    fav ? await addFavourites() : await deleteFavouriteItem(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: screenSize.height * 0.575,
              margin: EdgeInsets.only(bottom: kDefaultPadding / 2),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: kDefaultPadding * 3.5),
                    height: screenSize.height * 0.45,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(36)),
                      color: kAccentColor,
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
                    padding: EdgeInsets.all(kDefaultPadding / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          color: kAccentColor,
                          iconSize: 25,
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          icon: Icon(Icons.shopping_cart),
                          color: kBgColor,
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
                      left: kDefaultPadding * 2,
                      top: kDefaultPadding * 5,
                    ),
                    height: screenSize.height * 0.21,
                    width: screenSize.width * 0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(FontAwesomeIcons.plus),
                          onPressed: () => addQuantity(),
                          iconSize: screenSize.height * 0.025,
                          color: Colors.black54,
                          padding: EdgeInsets.all(0),
                        ),
                        Spacer(),
                        Text(
                          quantity.toString(),
                          style: TextStyle(
                            fontSize: screenSize.height * 0.04,
                            color: Colors.black54,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.minus),
                          onPressed: () => removeQuantity(),
                          iconSize: screenSize.height * 0.025,
                          color: Colors.black54,
                          padding: EdgeInsets.all(0),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: kPrimaryColor,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black26,
                          blurRadius: 7,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    child: Container(
                      margin: EdgeInsets.only(left: kDefaultPadding / 2),
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
                          onPressed: () => toggleFavourite(),
                        ),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimaryColor,
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
                    right: 10,
                    child: Image.asset(
                      widget.product.image,
                      height: screenSize.height * 0.375,
                      width: screenSize.width * 0.7,
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
                    left: kDefaultPadding * 1.5,
                    right: kDefaultPadding * 1.5,
                  ),
                  child: Text(
                    widget.product.name,
                    style: TextStyle(
                      fontFamily: "Calibri",
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: kAccentColor,
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
                      left: kDefaultPadding * 1.5,
                      right: kDefaultPadding * 1.5,
                      top: kDefaultPadding / 4,
                      bottom: kDefaultPadding / 2,
                    ),
                    child: Container(
                      height: screenSize.height * 0.125,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          "·" + widget.product.longDescription,
                          style: TextStyle(
                            fontSize: 16,
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
                  padding: EdgeInsets.only(left: kDefaultPadding * 1.5),
                  child: Text(
                    " - " + widget.product.price.toString() + " RON - ",
                    style: TextStyle(
                      fontFamily: "Calibri",
                      fontWeight: FontWeight.bold,
                      fontSize: 19.5,
                      color: kAccentColor,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: screenSize.height * 0.055,
              margin: EdgeInsets.only(
                left: kDefaultPadding * 1.5,
                right: kDefaultPadding * 1.5,
                top: kDefaultPadding / 2,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: kAccentColor,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black26,
                    blurRadius: 7,
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
                          fontSize: screenSize.width * 0.05,
                        ),
                      ),
                      content: Text(
                        "Successfully added to your bag!",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.04,
                        ),
                      ),
                      actions: [
                        CupertinoDialogAction(
                            child: const Text("No"),
                            onPressed: () async {
                              await addToCart(widget.product.id);
                              Navigator.of(dialogContext, rootNavigator: true)
                                  .pop();
                            }),
                        CupertinoDialogAction(
                          child: const Text("Yes"),
                          onPressed: () async {
                            await addToCart(widget.product.id);
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
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add to cart",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: screenSize.height * 0.025,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          FontAwesomeIcons.shoppingCart,
                          color: kPrimaryColor,
                          size: screenSize.width * 0.05,
                        ),
                      ],
                    ),
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
