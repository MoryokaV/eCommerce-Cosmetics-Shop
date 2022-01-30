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
  List<Product> categoryProducts = [];
  List<bool> favIcon = [];
  bool isLoading = true;

  void favouritesGathering() async {
    List<Favourite> favourites = await retrieveFavourites();

    for (int i = 0; i < categoryProducts.length; i++) {
      for (int j = 0; j < favourites.length; j++) {
        if (favourites[j].productID == categoryProducts[i].id) {
          favIcon[i] = true;
          break;
        }
      }
    }

    setState(() => isLoading = false);
  }

  void productsGathering() {
    categoryProducts.clear();
    favIcon.clear();

    if (widget.category.name == "All products") {
      categoryProducts = products;
      for (int i = 0; i < products.length; i++) favIcon.add(false);
    } else {
      for (int i = 0; i < products.length; i++) {
        if (products[i].categoryID == widget.category.id) {
          categoryProducts.add(products[i]);
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
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: categoryProducts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) => ProductScreen(
                                    product: categoryProducts[index],
                                  ),
                                ),
                              );
                            },
                            child: ProductCard(
                              favIcon: favIcon[index],
                              product: categoryProducts[index],
                            ),
                          );
                        },
                      ),
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
