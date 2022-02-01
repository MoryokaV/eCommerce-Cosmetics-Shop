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
  List<Product> cartProducts = [];
  List<Order> orders = [];

  bool isLoading = true;

  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() async {
    List<Favourite> favourites = await retrieveFavourites();
    cart = await retrieveCart();
    orders = await retrieveOrders();

    cartProducts.clear();
    favIcon.clear();

    await FirebaseFirestore.instance
        .collection('products')
        .orderBy('id')
        .get()
        .then((value) {
      for (int i = 0; i < cart.length; i++) {
        for (int j = 0; j < value.docs.length; j++) {
          if (cart[i].productID == value.docs[j]['id']) {
            cartProducts.add(Product.fromSnapshot(value.docs[j]));

            favIcon.add(false);
            for (int k = 0; k < favourites.length; k++) {
              if (favourites[k].productID == value.docs[j]['id']) {
                favIcon.last = true;
                break;
              }
            }

            break;
          }
        }
      }
    });

    setState(() => isLoading = false);
  }

  Widget buildCartList(BuildContext context) {
    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: cartProducts.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => ProductScreen(
                product: cartProducts[index],
              ),
            ),
          ),
          child: Item(
            product: cartProducts[index],
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
          : cartProducts.length == 0
              ? EmptyCart()
              : ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    buildCartList(context),
                    OrderSummary(
                      cartProducts: cartProducts,
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
