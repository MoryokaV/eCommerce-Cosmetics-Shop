import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmetics_shop/models/favourites.dart';
import 'package:cosmetics_shop/models/products.dart';
import 'package:cosmetics_shop/screens/cart/cart_screen.dart';
import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/models/cart.dart';
import 'package:cosmetics_shop/services/sqliteHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../../responsive.dart';
import '../../services/firestoreService.dart';

class ProductScreen extends StatefulWidget {
  final Product? product;
  final String? documentId;

  ProductScreen({
    this.product,
    this.documentId,
  });

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool fav = false;
  int quantity = 1;

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

  @override
  build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirestoreService.getProductById(widget.documentId!),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              Product product = Product.fromSnapshot(snapshot.data!);
              return Column(
                children: [
                  Container(
                    height: Responsive.safeBlockVertical * 57.5,
                    margin: EdgeInsets.only(bottom: kDefaultPadding / 2),
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: kDefaultPadding * 3.5),
                          height: Responsive.safeBlockVertical * 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(36)),
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
                                iconSize: Responsive.safeBlockHorizontal * 5,
                                onPressed: () => Navigator.pop(context),
                              ),
                              IconButton(
                                icon: Icon(Icons.shopping_cart),
                                color: kBgColor,
                                iconSize: Responsive.safeBlockHorizontal * 5,
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
                        Positioned(
                          top: kDefaultPadding * 5,
                          left: kDefaultPadding * 2,
                          child: Container(
                            height: Responsive.safeBlockVertical * 21,
                            width: Responsive.safeBlockHorizontal * 15,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () => addQuantity(),
                                    iconSize:
                                        Responsive.safeBlockHorizontal * 5,
                                    color: Colors.black54,
                                    padding: const EdgeInsets.all(0),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      quantity.toString(),
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize:
                                            Responsive.safeBlockHorizontal * 7,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () => removeQuantity(),
                                    iconSize:
                                        Responsive.safeBlockHorizontal * 5,
                                    color: Colors.black54,
                                    padding: const EdgeInsets.all(0),
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
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
                        ),
                        Positioned(
                          bottom: 20,
                          child: Container(
                            margin: EdgeInsets.only(left: kDefaultPadding),
                            height: Responsive.safeBlockHorizontal * 14,
                            width: Responsive.safeBlockHorizontal * 14,
                            child: Center(
                              child: IconButton(
                                icon: fav
                                    ? Icon(Icons.favorite)
                                    : Icon(Icons.favorite_border),
                                iconSize: Responsive.safeBlockHorizontal * 8,
                                color: Colors.red,
                                onPressed: () => null,
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
                          child: Hero(
                            tag: product.image,
                            child: Image.network(
                              product.image,
                              height: Responsive.safeBlockVertical * 37,
                              width: Responsive.safeBlockHorizontal * 70,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: kDefaultPadding),
                        child: Text(
                          product.name,
                          style: TextStyle(
                            fontFamily: "Calibri",
                            fontWeight: FontWeight.bold,
                            fontSize: Responsive.safeBlockHorizontal * 7,
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
                          padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding,
                            vertical: kDefaultPadding / 2,
                          ),
                          child: Container(
                            height: Responsive.safeBlockVertical * 12,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                "\t" + product.longDescription,
                                style: TextStyle(
                                  fontSize: Responsive.safeBlockHorizontal * 4,
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
                        padding: EdgeInsets.only(left: kDefaultPadding),
                        child: Text(
                          " - " + product.price.toString() + " RON - ",
                          style: TextStyle(
                            fontFamily: "Calibri",
                            fontWeight: FontWeight.bold,
                            fontSize: Responsive.safeBlockHorizontal * 5,
                            color: kAccentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      top: kDefaultPadding,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: kAccentColor,
                          onPrimary: kPrimaryColor,
                          elevation: 6,
                          padding: EdgeInsets.symmetric(
                              vertical: kDefaultPadding / 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        label: Text(
                          "Add to cart",
                          style: TextStyle(
                            fontSize: Responsive.safeBlockHorizontal * 5,
                            fontWeight: FontWeight.w400,
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
                                  fontSize: Responsive.safeBlockHorizontal * 5,
                                ),
                              ),
                              content: Text(
                                "Successfully added to your bag!",
                                style: TextStyle(
                                  fontSize: Responsive.safeBlockHorizontal * 4,
                                ),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                    child: const Text("No"),
                                    onPressed: () async {
                                      await addToCart(product.id);
                                      Navigator.of(dialogContext,
                                              rootNavigator: true)
                                          .pop();
                                    }),
                                CupertinoDialogAction(
                                  child: const Text("Yes"),
                                  onPressed: () async {
                                    await addToCart(product.id);
                                    Navigator.of(dialogContext,
                                            rootNavigator: true)
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
              );
            }
          },
        ),
      ),
    );
  }
}
