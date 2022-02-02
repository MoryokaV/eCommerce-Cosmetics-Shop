import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmetics_shop/models/order.dart';
import 'package:cosmetics_shop/screens/cart/components/emptyCart.dart';
import 'package:cosmetics_shop/screens/cart/components/orderSummary.dart';
import 'package:cosmetics_shop/screens/product/product_screen.dart';
import 'package:cosmetics_shop/services/sqliteHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:cosmetics_shop/models/favourites.dart';
import 'package:cosmetics_shop/models/products.dart';
import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/models/cart.dart';
import 'package:flutter/material.dart';
import 'components/item.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final double containerAnimationHeight = 0.06;
  final double containerAnimationWidth = 0.155;

  List<bool> favIcon = [false, false, false, false, false, false];
  List<Cart> cart = [];
  List<Order> orders = [];

  bool isLoading = true;

  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() async {
    cart = await retrieveCart();
    orders = await retrieveOrders();

    setState(() => isLoading = false);
  }

  Widget buildCartList(BuildContext context) {
    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: cart.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => ProductScreen(
                productId: cart[index].productID,
              ),
            ),
          ),
          child: Item(
            productId: cart[index].productID,
            getProductsFunc: getProducts,
            quantity: cart[index].productQuantity,
            favIcon: favIcon[index],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : cart.length == 0
              ? EmptyCart()
              : ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    buildCartList(context),
                    OrderSummary(
                      cart: cart,
                      orders: orders.length,
                      width: containerAnimationWidth,
                      height: containerAnimationHeight,
                    ),
                  ],
                ),
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
