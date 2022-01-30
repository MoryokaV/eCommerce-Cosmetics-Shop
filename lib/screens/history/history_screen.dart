import 'package:cosmetics_shop/screens/history/components/orderDescriptionCard.dart';
import 'package:cosmetics_shop/services/sqliteHelper.dart';
import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/models/order.dart';
import 'package:flutter/material.dart';
import '../../responsive.dart';
import 'components/mainMenuButton.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreen createState() => _HistoryScreen();
}

class _HistoryScreen extends State<HistoryScreen> {
  late List<Order> orders;
  bool isLoading = true;

  void initState() {
    super.initState();
    getOrders();
  }

  void getOrders() async {
    orders = await retrieveOrders();

    setState(() => isLoading = false);
  }

  Widget buildOrdersList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: orders.length,
      itemBuilder: (BuildContext context, int index) {
        Order order = orders[index];
        return OrderDescriptionCard(order: order);
      },
    );
  }

  Widget buildEmptyList() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(
          "assets/images/misc/order-history2.png",
          height: Responsive.safeBlockVertical * 55,
        ),
        SizedBox(
          height: Responsive.safeBlockVertical * 15,
        ),
        MainMenuButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : orders.length == 0
              ? buildEmptyList()
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    buildOrdersList(),
                    MainMenuButton(),
                  ],
                ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kAccentColor,
      elevation: 10,
      title: Center(
        child: Text(
          "Orders History",
          style: TextStyle(
            color: kPrimaryColor,
            fontFamily: "Arial",
            fontWeight: FontWeight.bold,
            fontSize: Responsive.safeBlockHorizontal * 6,
          ),
        ),
      ),
    );
  }
}
