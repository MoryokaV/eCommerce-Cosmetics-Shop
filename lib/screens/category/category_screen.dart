import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmetics_shop/screens/product/product_screen.dart';
import 'package:cosmetics_shop/services/firestoreService.dart';
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
  List<bool> favIcon = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirestoreService.getProductsByCategory(widget.category.id),
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
                        Product product =
                            Product.fromSnapshot(snapshot.data!.docs[index]);
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => ProductScreen(
                                  productId: product.id,
                                ),
                              ),
                            );
                          },
                          child: ProductCard(
                            favIcon: favIcon[index],
                            product: product,
                          ),
                        );
                      },
                    );
                },
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
