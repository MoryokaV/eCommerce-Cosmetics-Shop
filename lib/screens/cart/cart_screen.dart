import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmetics_shop/models/order.dart';
import 'package:cosmetics_shop/screens/cart/components/emptyCart.dart';
import 'package:cosmetics_shop/screens/cart/components/orderSummary.dart';
import 'package:cosmetics_shop/screens/product/product_screen.dart';
import 'package:cosmetics_shop/services/firestoreService.dart';
import 'package:cosmetics_shop/services/sqliteHelper.dart';
import 'package:flutter/cupertino.dart';
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
  List<Cart> cart = [];
  List<Product> cartProducts = [];
  List<Order> orders = [];

  bool isLoading = true;

  void initState() {
    super.initState();
    refreshCart();
  }

  void refreshCart() async {
    setState(() => isLoading = true);

    cart = await retrieveCart();
    
    setState(() => isLoading = false);
  }

  void getOrdersNumber() async => orders = await retrieveOrders();

  void fetchCartProducts(AsyncSnapshot<QuerySnapshot> snapshot) {
    for (int i = 0; i < cart.length; i++) {
      for (int j = 0; j < snapshot.data!.docs.length; j++) {
        if (snapshot.data!.docs[j]['id'] == cart[i].productId) {
          cartProducts.add(Product.fromSnapshot(snapshot.data!.docs[j]));
          break;
        }
      }
    }
  }

  Widget buildCartList(List<Product> cartProducts) {
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
                productId: cart[index].productId,
              ),
            ),
          ),
          child: Item(
            product: cartProducts[index],
            refreshCartFunc: refreshCart,
            quantity: cart[index].productQuantity,
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
          ? LoadingIndicator
          : cart.length == 0
              ? EmptyCart()
              : StreamBuilder<QuerySnapshot>(
                  stream: FirestoreService.getProducts(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return LoadingIndicator;
                    } else {
                      fetchCartProducts(snapshot);
                      getOrdersNumber();
                      return ListView(
                        children: [
                          buildCartList(cartProducts),
                          OrderSummary(
                            cart: cart,
                            cartProducts: cartProducts,
                            numberOfOrders: orders.length,
                          ),
                        ],
                      );
                    }
                  },
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
