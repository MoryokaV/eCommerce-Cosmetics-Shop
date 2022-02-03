import 'dart:math';
import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/models/cart.dart';
import 'package:cosmetics_shop/models/favourites.dart';
import 'package:cosmetics_shop/models/products.dart';
import 'package:cosmetics_shop/screens/cart/cart_screen.dart';
import 'package:cosmetics_shop/services/sqliteHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../responsive.dart';

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  bool favIcon;
  final Product product;

  ProductCard({
    required this.favIcon,
    required this.product,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Future<void> addToCart(int id) async {
    List<Cart> cart = await retrieveCart();

    for (int i = 0; i < cart.length; i++) {
      if (cart[i].productId == id) {
        return;
      }
    }

    await insertCartItem(
      Cart(
        productId: id,
        productQuantity: 1,
      ),
    );
  }

  Future<void> addFavourites(int id) async {
    await insertFavouriteItem(Favourite(productId: id));

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

  void toggleFavourites(int id) async {
    setState(() => widget.favIcon = !widget.favIcon);

    widget.favIcon ? await addFavourites(id) : await deleteFavouriteItem(id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      height: Responsive.safeBlockVertical * 20,
      width: Responsive.screenWidth,
      child: Row(
        children: [
          Container(
            height: Responsive.safeBlockVertical * 20,
            width: Responsive.safeBlockHorizontal * 35,
            child: Image.network(
              widget.product.image,
              fit: BoxFit.contain,
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
                      top: kDefaultPadding / 2,
                      left: kDefaultPadding / 2,
                    ),
                    height: Responsive.safeBlockVertical * 7.5,
                    width: Responsive.safeBlockHorizontal * 55,
                    child: RichText(
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                      softWrap: true,
                      text: TextSpan(
                        text: widget.product.name,
                        style: TextStyle(
                          color: Colors.black87,
                          fontFamily: "Calibri",
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.safeBlockHorizontal * 5,
                        ),
                        children: [
                          TextSpan(
                            text: " - " + widget.product.shortDescription,
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: "Calibri",
                              fontWeight: FontWeight.w300,
                              fontSize: Responsive.safeBlockHorizontal * 4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: Responsive.safeBlockHorizontal * 4,
                    backgroundColor: Colors.grey[200],
                    child: IconButton(
                      icon: Icon(Icons.favorite),
                      color: widget.favIcon ? Colors.red : Colors.grey[600],
                      onPressed: () => toggleFavourites(widget.product.id),
                      iconSize: Responsive.safeBlockHorizontal * 4,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: kDefaultPadding / 2,
                      left: kDefaultPadding / 2,
                    ),
                    child: Text(
                      widget.product.price.toString() + " RON",
                      style: TextStyle(
                        fontFamily: "Roboto-Medium",
                        color: kAccentColor,
                        fontSize: Responsive.safeBlockHorizontal * 4.5,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: kDefaultPadding / 2,
                  left: kDefaultPadding / 2,
                ),
                child: SizedBox(
                  width: Responsive.safeBlockHorizontal * 53,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: kAccentColor,
                      onPrimary: kPrimaryColor,
                      elevation: 6,
                      padding: EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    label: Text(
                      "Add to cart",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: "Roboto-Thin",
                        fontSize: Responsive.safeBlockHorizontal * 4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    icon: Icon(Icons.shopping_cart),
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
                              fontSize: Responsive.safeBlockHorizontal * 5,
                            ),
                          ),
                          content: Text(
                            "Successfully added to your bag!",
                            style: TextStyle(
                              fontFamily: "Arial",
                              fontSize: Responsive.safeBlockHorizontal * 4,
                            ),
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text("No"),
                              onPressed: () async {
                                await addToCart(widget.product.id);
                                Navigator.of(dialogContext, rootNavigator: true)
                                    .pop();
                              },
                            ),
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
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(1, 1),
            blurRadius: 5,
          ),
        ],
      ),
    );
  }
}
