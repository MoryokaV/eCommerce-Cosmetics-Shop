import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/models/cart.dart';
import 'package:cosmetics_shop/models/order.dart';
import 'package:cosmetics_shop/screens/order/checkout_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../responsive.dart';

class OrderSummary extends StatefulWidget {
  final Cart cart;
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final int numberOfOrders;

  OrderSummary({
    required this.cart,
    required this.snapshot,
    required this.numberOfOrders,
  });

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary>
    with SingleTickerProviderStateMixin {
  //animations
  double animatedBubbleWidth = 0.155;
  late AnimationController _arrowController;

  //summary list
  double summaryListHeight = Responsive.safeBlockVertical * 14.5;
  IconData summaryListIcon = Icons.keyboard_arrow_up;
  bool isSummaryListExpanded = false;
  String summaryListTitle = "See Order Summary";

  //order date
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

    for (int i = 0; i < widget.cart.items.length; i++)
      total += widget.snapshot.data!.docs[widget.cart.items[i].productId - 1]
              ['price'] *
          widget.cart.items[i].productQuantity;

    total += deliveryCost;

    return total;
  }

  String getOrderDescription() {
    String desc = "";

    for (int i = 0; i < widget.cart.items.length; i++)
      desc += widget.cart.items[i].productQuantity.toString() +
          " x " +
          widget.snapshot.data!.docs[widget.cart.items[i].productId - 1]
              ['name'] +
          "\n";

    return desc;
  }

  void toggleSummary() {
    setState(() {
      isSummaryListExpanded = !isSummaryListExpanded;
      if (isSummaryListExpanded) {
        summaryListHeight =
            Responsive.safeBlockVertical * 4 * (widget.cart.items.length + 1) +
                Responsive.safeBlockVertical * 14.5;
        _arrowController.forward(); //animate arrow
        summaryListIcon = Icons.keyboard_arrow_down;
        summaryListTitle = "Order Summary";
      } else {
        summaryListHeight = Responsive.safeBlockVertical * 14.5;
        _arrowController.reverse(); //animate arrow
        summaryListIcon = Icons.keyboard_arrow_up;
        summaryListTitle = "See Order Summary";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
      height: summaryListHeight,
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
                          summaryListTitle,
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
            if (isSummaryListExpanded) buildSummaryListDetails(),
            GestureDetector(
              onTap: () {
                setState(() {
                  animatedBubbleWidth = 0.8;
                  Timer(Duration(seconds: 1), () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => OrderScreen(
                          order: Order(
                            number: widget.numberOfOrders != 0
                                ? widget.numberOfOrders + 1
                                : 1,
                            value: calcPrice(),
                            description: getOrderDescription(),
                            date: dateTime,
                          ),
                        ),
                      ),
                    );
                    animatedBubbleWidth = 0.155;
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
                          height: Responsive.screenHeight * 0.06,
                          width: Responsive.screenWidth * animatedBubbleWidth,
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
      height: Responsive.safeBlockVertical * 4 * (widget.cart.items.length + 1),
      child: ListView(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.cart.items.length,
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
                      widget.cart.items[index].productQuantity.toString() +
                          " x " +
                          widget.snapshot.data!
                                  .docs[widget.cart.items[index].productId - 1]
                              ['name'],
                      style: TextStyle(
                        fontSize: Responsive.safeBlockHorizontal * 4,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      (widget.snapshot.data!.docs[
                                      widget.cart.items[index].productId -
                                          1]['price'] *
                                  widget.cart.items[index].productQuantity)
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
