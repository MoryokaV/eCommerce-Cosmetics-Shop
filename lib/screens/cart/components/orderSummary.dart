import 'dart:async';
import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/models/cart.dart';
import 'package:cosmetics_shop/models/order.dart';
import 'package:cosmetics_shop/models/products.dart';
import 'package:cosmetics_shop/screens/order/checkout_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../responsive.dart';

// ignore: must_be_immutable
class OrderSummary extends StatefulWidget {
  final List<Product> cartProducts;
  final List<Cart> cart;
  final int orders;
  double height;
  double width;

  OrderSummary({
    required this.cartProducts,
    required this.cart,
    required this.orders,
    required this.height,
    required this.width,
  });

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary>
    with TickerProviderStateMixin {
  late AnimationController _arrowController;
  double listHeight = Responsive.safeBlockVertical * 14.5;

  IconData summaryListIcon = Icons.keyboard_arrow_up;
  bool summaryList = false;
  String summaryTitle = "See Order Summary";

  final String dateTime = DateFormat("dd-MM-yyyy").format(DateTime.now());

  void initState() {
    super.initState();

    _arrowController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  void dispose() {
    _arrowController.dispose();
    super.dispose();
  }

  double calcPrice() {
    double total = 0;

    for (int i = 0; i < widget.cartProducts.length; i++)
      total += widget.cartProducts[i].price * widget.cart[i].productQuantity;

    total += deliveryCost;

    return total;
  }

  String getOrderDescription() {
    String desc = "";

    for (int i = 0; i < widget.cartProducts.length; i++)
      desc += widget.cart[i].productQuantity.toString() +
          " x " +
          widget.cartProducts[i].name +
          "\n";

    return desc;
  }

  void toggleSummary() {
    setState(() {
      summaryList = !summaryList;
      if (summaryList) {
        listHeight = Responsive.safeBlockVertical *
                4 *
                (widget.cartProducts.length + 1) +
            Responsive.safeBlockVertical * 14.5;
        _arrowController.forward(); //animate arrow
        summaryListIcon = Icons.keyboard_arrow_down;
        summaryTitle = "Order Summary";
      } else {
        listHeight = Responsive.safeBlockVertical * 14.5;
        _arrowController.reverse(); //animate arrow
        summaryListIcon = Icons.keyboard_arrow_up;
        summaryTitle = "See Order Summary";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
      height: listHeight,
      width: Responsive.screenWidth,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0, 0),
            blurRadius: 5,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: kDefaultPadding / 2,
                left: kDefaultPadding / 2,
                right: kDefaultPadding / 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => toggleSummary(),
                    child: Row(
                      children: [
                        RotationTransition(
                          turns: CurvedAnimation(
                            parent: _arrowController,
                            curve: Curves.elasticOut,
                            reverseCurve: Curves.elasticIn,
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.only(right: kDefaultPadding / 6),
                            child: Icon(
                              summaryListIcon,
                              size: Responsive.safeBlockHorizontal * 6,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                        Text(
                          summaryTitle,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Responsive.safeBlockHorizontal * 4.5,
                            fontFamily: "Arial",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    calcPrice().toString() + " RON",
                    style: TextStyle(
                      color: kAccentColor,
                      fontSize: Responsive.safeBlockHorizontal * 4.5,
                      fontFamily: "Arial",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (summaryList) buildSummaryListDetails(),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.height = 0.06;
                  widget.width = 0.8;
                  Timer(Duration(seconds: 1), () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => OrderScreen(
                          order: Order(
                            number: widget.orders != 0 ? widget.orders + 1 : 1,
                            value: calcPrice(),
                            description: getOrderDescription(),
                            date: dateTime,
                          ),
                        ),
                      ),
                    );
                    widget.height = 0.06;
                    widget.width = 0.155;
                  });
                });
              },
              child: Container(
                margin: EdgeInsets.all(kDefaultPadding / 1.5),
                height: Responsive.safeBlockVertical * 6,
                width: Responsive.safeBlockHorizontal * 75,
                decoration: BoxDecoration(
                  color: kAccentColor,
                  borderRadius: BorderRadius.circular(kDefaultPadding / 2),
                ),
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                          height: Responsive.screenHeight * widget.height,
                          width: Responsive.screenWidth * widget.width,
                          decoration: BoxDecoration(
                            color: kBgAccent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                        ),
                        Positioned(
                          left: kDefaultPadding / 1.5,
                          top: 2,
                          bottom: 2,
                          child: Icon(
                            Icons.subdirectory_arrow_right_rounded,
                            color: kPrimaryColor,
                            size: Responsive.safeBlockHorizontal * 6,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.safeBlockHorizontal * 5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSummaryListDetails() {
    return Container(
      padding: EdgeInsets.only(top: kDefaultPadding / 2),
      height:
          Responsive.safeBlockVertical * 4 * (widget.cartProducts.length + 1),
      child: ListView(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.cartProducts.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: kDefaultPadding,
                  top: kDefaultPadding / 6,
                  right: kDefaultPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.cart[index].productQuantity.toString() +
                          " x " +
                          widget.cartProducts[index].name,
                      style: TextStyle(
                        fontSize: Responsive.safeBlockHorizontal * 4,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      (widget.cartProducts[index].price *
                                  widget.cart[index].productQuantity)
                              .toString() +
                          " RON",
                      style: TextStyle(
                        fontSize: Responsive.safeBlockHorizontal * 4,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              top: kDefaultPadding / 4,
              right: kDefaultPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delivery cost: ",
                  style: TextStyle(
                    fontSize: Responsive.safeBlockHorizontal * 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  deliveryCost > 0 ? deliveryCost.toString() + " RON" : "Free",
                  style: TextStyle(
                    fontSize: Responsive.safeBlockHorizontal * 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
