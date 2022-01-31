import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmetics_shop/screens/product/product_screen.dart';
import 'package:cosmetics_shop/services/sqliteHelper.dart';
import 'package:cosmetics_shop/models/categories.dart';
import 'package:cosmetics_shop/models/favourites.dart';
import 'package:cosmetics_shop/models/products.dart';
import 'package:cosmetics_shop/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../responsive.dart';
import 'components/productCard.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;

  CategoryScreen({
    required this.category,
  });
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<bool> favIcon = [];
  bool isLoading = true;

  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');
  late final Query cartProducts;

  void favouritesGathering() async {
    /*
    List<Favourite> favourites = await retrieveFavourites();

    for (int i = 0; i < categoryProducts.length; i++) {
      for (int j = 0; j < favourites.length; j++) {
        if (favourites[j].productID == categoryProducts[i].id) {
          favIcon[i] = true;
          break;
        }
      }
    } */

    setState(() => isLoading = false);
  }

  void productsGathering() {
    favIcon.clear();

    cartProducts = widget.category.name == "All products"
        ? productsCollection.orderBy('id')
        : productsCollection
            .where('categoryID', isEqualTo: widget.category.id)
            .orderBy('id'); 

    if (widget.category.name == "All products") {
      for (int i = 0; i < products.length; i++) favIcon.add(false);
    } else {
      for (int i = 0; i < products.length; i++) {
        if (products[i].categoryID == widget.category.id) {
          favIcon.add(false);
        }
      }
    }
  }

  void initState() {
    super.initState();

    productsGathering();
    favouritesGathering();
  }

  Future<Null> _onRefresh() async {
    productsGathering();
    favouritesGathering();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : StreamBuilder<QuerySnapshot>(
                        stream: cartProducts.snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: CircularProgressIndicator());
                          else
                            return ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (_) => ProductScreen(
                                          product: Product.fromSnapshot(
                                            snapshot.data!.docs[index],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: ProductCard(
                                    favIcon: favIcon[index],
                                    product: Product.fromSnapshot(
                                      snapshot.data!.docs[index],
                                    ),
                                  ),
                                );
                              },
                            );
                        }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      elevation: 5,
      automaticallyImplyLeading: false,
      backgroundColor: kAccentColor,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
        ),
        onPressed: () => Navigator.pop(context),
        color: kPrimaryColor,
      ),
      centerTitle: true,
      title: Text(
        widget.category.name,
        style: TextStyle(
          color: kPrimaryColor,
          fontSize: Responsive.safeBlockHorizontal * 6,
          fontFamily: "Arial",
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
