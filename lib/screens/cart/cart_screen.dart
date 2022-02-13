import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmetics_shop/models/order.dart';
import 'package:cosmetics_shop/screens/cart/components/emptyCart.dart';
import 'package:cosmetics_shop/screens/cart/components/orderSummary.dart';
import 'package:cosmetics_shop/screens/product/product_screen.dart';
import 'package:cosmetics_shop/services/firestoreService.dart';
import 'package:cosmetics_shop/services/sqliteHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/item.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Order> orders = [];

  void getOrdersNumber() async => orders = await retrieveOrders();

  Widget buildCartList(Cart cart) {
    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: cart.items.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => ProductScreen(
                productId: cart.items[index].productId,
              ),
            ),
          ),
          child: Item(
            cartItem: cart.items[index],
            quantity: cart.items[index].productQuantity,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: buildAppBar(),
          body: cart.items.length == 0
              ? EmptyCart()
              : ListView(
                  children: [
                    buildCartList(cart),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirestoreService.getProducts(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return LoadingIndicator;
                        } else {
                          getOrdersNumber();
                          return OrderSummary(
                            cart: cart,
                            snapshot: snapshot,
                            numberOfOrders: orders.length,
                          );
                        }
                      },
                    )
                  ],
                ),
        );
      },
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: kAccentColor,
      automaticallyImplyLeading: false,
      elevation: 4,
      titleSpacing: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: kPrimaryColor,
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart,
            color: kBgAccent,
          ),
          SizedBox(width: 8),
          Text(
            "My Cart",
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
