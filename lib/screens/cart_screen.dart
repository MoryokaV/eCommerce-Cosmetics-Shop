import 'dart:async';
import 'package:cosmetics_shop/database/cart.dart';
import 'package:cosmetics_shop/database/productsList.dart';
import 'package:cosmetics_shop/database/constants.dart';
import 'package:cosmetics_shop/screens/order_screen.dart';
import 'package:cosmetics_shop/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cosmetics_shop/database/favouriteItems.dart';
import 'package:cosmetics_shop/templateLayer.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  //const values
  double deliveryCost = 15.5;

  //cart preview
  List<bool> fav = [];
  List<Product> cartProducts = [];
  List<int> quantities = [];

  //order summary
  IconData summaryListIcon = Icons.keyboard_arrow_up;
  bool summaryList = false;
  String summaryTitle = "See Order Summary";

  //animation
  AnimationController _arrowController;
  Animation<double> _arrowAnimation;
  double containerAnimationHeight = 0.06;
  double containerAnimationWidth = 0.155;
  double listHeight;

  void initState() {
    super.initState();

    productsGathering();
    favouritesGathering();

    //animation initializer
    _arrowController = AnimationController(
      duration: const Duration(
        seconds: 2,
      ),
      vsync: this,
    );
    _arrowAnimation = CurvedAnimation(
      parent: _arrowController,
      curve: Curves.elasticOut,
      reverseCurve: Curves.elasticIn,
    );
  }

  void dispose() {
    _arrowController.dispose();
    super.dispose();
  }

  void addFavourites(int id) {
    favourites.add(
      Favourite(
        productID: id,
      ),
    );
  }

  void removeFromCart(int id) {
    cartItems.removeWhere(
      (cartItem) => cartItem.productID == id,
    );
  }

  void favouritesGathering() {
    for (int i = 0; i < cartProducts.length; i++) {
      for (int j = 0; j < favourites.length; j++) {
        if (favourites[j].productID == cartProducts[i].id) {
          fav[i] = true;
          break;
        }
      }
    }
  }

  void removeFavourites(int id) {
    favourites.removeWhere(
      (favourite) => favourite.productID == id,
    );
  }

  void productsGathering() {
    cartProducts = [];
    quantities = [];
    fav = [];
    for (int i = 0; i < cartItems.length; i++) {
      cartProducts.add(products[cartItems[i].productID - 1]);
      quantities.add(cartItems[i].productQuantity);
      fav.add(false);
    }
  }

  Future<Null> refreshPage() async {
    setState(() {
      productsGathering();
      favouritesGathering();
      containerAnimationHeight = 0.06;
      containerAnimationWidth = 0.155;
    });
  }

  Widget buildCartList(BuildContext context, Size screenSize) {
    if (cartProducts.length != 0) {
      return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: cartProducts.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductScreen(
                  product: cartProducts[index],
                ),
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(
                top: defaultPadding / 2,
                bottom: defaultPadding / 2,
              ),
              height: screenSize.height * 0.25,
              width: screenSize.width,
              decoration: BoxDecoration(
                color: primaryColor,
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
                    width: screenSize.width * 0.35,
                    height: screenSize.height * 0.35,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 0.5,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    child: Image.asset(
                      cartProducts[index].imagePath,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: defaultPadding / 2,
                          top: 4,
                          bottom: 5,
                          right: defaultPadding / 4,
                        ),
                        width: screenSize.width * 0.65,
                        height: screenSize.height * 0.125,
                        child: Center(
                          child: RichText(
                            overflow: TextOverflow.fade,
                            text: TextSpan(
                              text: "\t\t" + cartProducts[index].name,
                              style: TextStyle(
                                fontFamily: "Century-Gothic",
                                fontWeight: FontWeight.w900,
                                fontSize: screenSize.width * 0.045,
                                color: accentColor,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: " - " +
                                      cartProducts[index].shortDescription,
                                  style: TextStyle(
                                    fontFamily: "Century-Gothic",
                                    fontSize: screenSize.width * 0.037,
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
                        width: screenSize.width * 0.65,
                        height: screenSize.height * 0.05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: fav[index] == true
                                      ? Icon(FontAwesomeIcons.solidHeart)
                                      : Icon(FontAwesomeIcons.heart),
                                  onPressed: () {
                                    setState(() {
                                      fav[index] = !fav[index];
                                      fav[index]
                                          ? addFavourites(
                                              cartProducts[index].id)
                                          : removeFavourites(
                                              cartProducts[index].id);
                                    });
                                  },
                                  color: Colors.red,
                                  iconSize: screenSize.width * 0.0575,
                                  padding: EdgeInsets.all(0),
                                ),
                                Text(
                                  "Favourites",
                                  style: TextStyle(
                                    fontFamily: "Arial",
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
                                      removeFromCart(cartProducts[index].id);
                                      productsGathering();
                                      favouritesGathering();
                                    });
                                  },
                                  color: Colors.grey,
                                  iconSize: screenSize.width * 0.0575,
                                  padding: EdgeInsets.all(0),
                                ),
                                Text(
                                  "Remove",
                                  style: TextStyle(
                                    fontFamily: "Arial",
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
                            width: screenSize.width * 0.325,
                            height: screenSize.height * 0.075,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  width: screenSize.height * 0.001,
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DropdownButton(
                                  value: quantities[index].toString(),
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: screenSize.width * 0.075,
                                  elevation: 16,
                                  underline: SizedBox(),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      quantities[index] = int.parse(newValue);
                                    });
                                  },
                                  items: <String>['1', '2', '3', '4', '5']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontFamily: "Arial",
                                          fontSize: screenSize.width * 0.045,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                //hint text for the drop down
                                Text(
                                  " buc.",
                                  style: TextStyle(
                                    fontFamily: "Arial",
                                    fontSize: screenSize.width * 0.045,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: screenSize.width * 0.325,
                            height: screenSize.height * 0.075,
                            child: Center(
                              child: Text(
                                (cartProducts[index].price * quantities[index])
                                        .toString() +
                                    " RON",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Roboto-Medium",
                                  fontSize: screenSize.width * 0.045,
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
            ),
          );
        },
      );
    } else {
      return Container(
        margin: EdgeInsets.all(
          defaultPadding / 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/misc/shopping_ic.png",
            ),
            SizedBox(
              height: screenSize.height * 0.025,
            ),
            Text(
              "Continue searching until you find the product that interests you!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Arial",
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget buildOrderDetails(BuildContext context, Size screenSize) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      margin: EdgeInsets.only(
        top: defaultPadding / 4,
      ),
      height: listHeight,
      width: screenSize.width,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(
          defaultPadding / 1.5,
        ),
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
                top: defaultPadding / 2,
                left: defaultPadding / 2,
                right: defaultPadding / 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      toggleSummary(
                        screenSize,
                      );
                    },
                    child: Row(
                      children: [
                        RotationTransition(
                          turns: _arrowAnimation,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: defaultPadding / 4,
                            ),
                            child: Icon(
                              summaryListIcon,
                              size: screenSize.height * 0.035,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                        Text(
                          summaryTitle,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: screenSize.width * 0.05,
                            fontFamily: "Arial",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    calcPrice().toString() + " RON",
                    style: TextStyle(
                      color: accentColor,
                      fontSize: screenSize.width * 0.045,
                      fontFamily: "Arial",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (summaryList) buildSummaryListDetails(context, screenSize),
            GestureDetector(
              onTap: () {
                setState(() {
                  containerAnimationHeight = 0.06;
                  containerAnimationWidth = 0.8;
                  Timer(Duration(seconds: 1), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrderScreen(),
                      ),
                    );
                  });
                });
              },
              child: Container(
                margin: EdgeInsets.all(
                  defaultPadding / 1.5,
                ),
                height: screenSize.height * 0.06,
                width: screenSize.width * 0.75,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(
                    defaultPadding / 2,
                  ),
                ),
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                          width: screenSize.width * containerAnimationWidth,
                          height: screenSize.height * containerAnimationHeight,
                          decoration: BoxDecoration(
                            color: backgroundAccent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(defaultPadding / 2),
                              bottomLeft: Radius.circular(defaultPadding / 2),
                              topRight: Radius.circular(defaultPadding / 2),
                              bottomRight:
                                  Radius.circular(defaultPadding * 1.5),
                            ),
                          ),
                        ),
                        Positioned(
                          left: defaultPadding / 1.5,
                          top: 2,
                          bottom: 2,
                          child: Icon(
                            FontAwesomeIcons.arrowRight,
                            color: primaryColor,
                            size: screenSize.width * 0.06,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Arial",
                          fontSize: screenSize.width * 0.05,
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

  double calcPrice() {
    double total = 0;

    for (int i = 0; i < cartProducts.length; i++)
      total += cartProducts[i].price * quantities[i];

    total += deliveryCost;

    return total;
  }

  void toggleSummary(Size screenSize) {
    setState(() {
      //toggle list state
      summaryList = !summaryList;
      if (summaryList) {
        listHeight = screenSize.height * 0.035 * (cartProducts.length + 1) +
            screenSize.height * 0.145;
        _arrowController.forward(); //animate arrow
        summaryListIcon = Icons.keyboard_arrow_down;
        summaryTitle = "Order Summary";
      } else {
        listHeight = screenSize.height * 0.145;
        _arrowController.reverse(); //animate arrow
        summaryListIcon = Icons.keyboard_arrow_up;
        summaryTitle = "See Order Summary";
      }
    });
  }

  Widget buildSummaryListDetails(BuildContext context, Size screenSize) {
    return Container(
      padding: EdgeInsets.only(
        top: defaultPadding / 2,
      ),
      height: screenSize.height * 0.035 * (cartProducts.length + 1),
      child: ListView(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: cartProducts.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: defaultPadding / 1.25,
                  top: 2,
                  right: defaultPadding / 1.5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      quantities[index].toString() +
                          " x " +
                          cartProducts[index].name,
                      style: TextStyle(
                        fontFamily: "Arial",
                        fontSize: screenSize.width * 0.04,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      (cartProducts[index].price * quantities[index])
                              .toString() +
                          " RON",
                      style: TextStyle(
                        fontFamily: "Arial",
                        fontSize: screenSize.width * 0.04,
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
              left: defaultPadding / 1.25,
              top: 4,
              right: defaultPadding / 1.5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delivery cost: ",
                  style: TextStyle(
                    fontFamily: "Arial",
                    fontSize: screenSize.width * 0.04,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  deliveryCost > 0 ? deliveryCost.toString() + " RON" : "FREE",
                  style: TextStyle(
                    fontFamily: "Arial",
                    fontSize: screenSize.width * 0.04,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    listHeight ??= screenSize.height * 0.145;

    return Scaffold(
      appBar: buildAppBar(screenSize),
      body: RefreshIndicator(
        onRefresh: refreshPage,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            buildCartList(context, screenSize),
            if (cartProducts.length != 0)
              buildOrderDetails(context, screenSize),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(Size screenSize) {
    return AppBar(
      backgroundColor: accentColor,
      automaticallyImplyLeading: false,
      elevation: 2,
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: primaryColor,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TemplateLayer(),
              ),
            ),
          ),
          SizedBox(
            width: screenSize.width * 0.02,
          ),
          Icon(
            Icons.shopping_cart,
            color: backgroundAccent,
          ),
          SizedBox(
            width: screenSize.width * 0.03,
          ),
          Text(
            "My Cart",
            style: TextStyle(
              color: primaryColor,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
