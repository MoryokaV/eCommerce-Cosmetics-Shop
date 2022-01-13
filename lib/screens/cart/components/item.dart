import 'dart:math';
import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/models/cart.dart';
import 'package:cosmetics_shop/models/favourites.dart';
import 'package:cosmetics_shop/models/products.dart';
import 'package:cosmetics_shop/services/databaseHandler.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../responsive.dart';

// ignore: must_be_immutable
class Item extends StatefulWidget {
  final Product product;
  final Function getProductsFunc;
  int quantity;
  bool favIcon;

  Item({
    required this.product,
    required this.getProductsFunc,
    required this.quantity,
    required this.favIcon,
  });

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  Future<void> addFavourites(int id) async {
    await insertFavouriteItem(Favourite(productID: id));

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

  void toggleFavourites() async {
    setState(() => widget.favIcon = !widget.favIcon);

    widget.favIcon
        ? await addFavourites(widget.product.id)
        : await deleteFavouriteItem(widget.product.id);

    widget.getProductsFunc();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: kDefaultPadding / 2,
      ),
      height: Responsive.safeBlockVertical * 25,
      width: Responsive.screenWidth,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0, 0),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: Responsive.safeBlockHorizontal * 35,
            height: Responsive.safeBlockVertical * 35,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 0.5,
                  color: Colors.black38,
                ),
              ),
            ),
            child: Image.asset(
              widget.product.image,
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 2,
                  vertical: kDefaultPadding / 5,
                ),
                width: Responsive.safeBlockHorizontal * 65,
                height: Responsive.safeBlockVertical * 12.5,
                child: Center(
                  child: RichText(
                    overflow: TextOverflow.fade,
                    text: TextSpan(
                      text: "\t\t" + widget.product.name,
                      style: TextStyle(
                        fontFamily: "Century-Gothic",
                        fontWeight: FontWeight.w900,
                        fontSize: Responsive.safeBlockHorizontal * 4.5,
                        color: kAccentColor,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: " - " + widget.product.shortDescription,
                          style: TextStyle(
                            fontFamily: "Century-Gothic",
                            fontSize: Responsive.safeBlockHorizontal * 4,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: Colors.black38,
                    ),
                  ),
                ),
              ),
              Container(
                width: Responsive.safeBlockHorizontal * 65,
                height: Responsive.safeBlockVertical * 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: widget.favIcon == true
                              ? Icon(Icons.favorite)
                              : Icon(Icons.favorite_border),
                          onPressed: () => toggleFavourites(),
                          color: Colors.red,
                          iconSize: Responsive.safeBlockHorizontal * 5,
                          padding: EdgeInsets.all(0),
                        ),
                        Text(
                          "Favourites",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              deleteCartItem(widget.product.id);
                              widget.getProductsFunc();
                            });
                          },
                          color: Colors.grey,
                          iconSize: Responsive.safeBlockHorizontal * 5,
                          padding: EdgeInsets.all(0),
                        ),
                        Text(
                          "Remove",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: Colors.black38,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: Responsive.safeBlockHorizontal * 32.5,
                    height: Responsive.safeBlockVertical * 7.5,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 0.5,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton(
                          value: widget.quantity.toString(),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            size: Responsive.safeBlockHorizontal * 7,
                          ),
                          elevation: 16,
                          underline: SizedBox(),
                          onChanged: (String? newValue) async {
                            if (newValue != null) {
                              setState(() {
                                widget.quantity = int.parse(newValue);
                              });
                            }
                            await updateCartQuantity(
                              Cart(
                                productID: widget.product.id,
                                productQuantity: widget.quantity,
                              ),
                            );
                            widget.getProductsFunc();
                          },
                          items: <String>['1', '2', '3', '4', '5']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: Responsive.safeBlockHorizontal * 5,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        //hint text for the drop down
                        Text(
                          " buc.",
                          style: TextStyle(
                            fontSize: Responsive.safeBlockHorizontal * 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Responsive.safeBlockHorizontal * 32.5,
                    height: Responsive.safeBlockVertical * 7.5,
                    child: Center(
                      child: Text(
                        (widget.product.price * widget.quantity).toString() +
                            " RON",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto-Medium",
                          fontSize: Responsive.safeBlockHorizontal * 4.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
