import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/screens/product/product_screen.dart';
import 'package:cosmetics_shop/services/firestoreService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cosmetics_shop/models/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../responsive.dart';

class Recommendations extends StatelessWidget {
  Widget buildProductCard(BuildContext context, DocumentSnapshot snap) {
    Product product = Product.fromSnapshot(snap);
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => ProductScreen(
            documentId: snap.id,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
            height: Responsive.safeBlockVertical * 18,
            width: Responsive.safeBlockHorizontal * 35,
            child: Hero(
              tag: product.image,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.network(product.image),
              ),
            ),
            decoration: BoxDecoration(
              color: kBgAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
          Container(
            height: Responsive.safeBlockVertical * 8,
            width: Responsive.safeBlockHorizontal * 35,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.name,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Roboto-Medium",
                      fontSize: Responsive.safeBlockHorizontal * 4,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "- " + product.price.toString() + " RON -",
                    style: TextStyle(
                      color: kAccentColor,
                      fontFamily: "Roboto-Black",
                      fontSize: Responsive.safeBlockHorizontal * 3,
                    ),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: kAccentColor.withOpacity(0.4),
                  blurRadius: 8,
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
    return Container(
      height: Responsive.safeBlockVertical * 28,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirestoreService.getProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          else
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return buildProductCard(context, snapshot.data!.docs[index]);
              },
            );
        },
      ),
    );
  }
}
