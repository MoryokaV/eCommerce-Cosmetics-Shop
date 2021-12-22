import 'package:cosmetics_shop/screens/history/components/orderDescriptionCard.dart';
import 'package:cosmetics_shop/services/databaseHandler.dart';
import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/models/order.dart';
import 'package:flutter/material.dart';
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

  Widget buildOrdersList(Size screenSize) {
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

  Widget buildEmptyList(Size screenSize) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(
          "assets/images/misc/order-history2.png",
          height: screenSize.height * 0.55,
        ),
        SizedBox(
          height: screenSize.height * 0.15,
        ),
        MainMenuButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(context, screenSize),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : orders.length == 0
              ? buildEmptyList(screenSize)
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    buildOrdersList(screenSize),
                    MainMenuButton(),
                  ],
                ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context, Size screenSize) {
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
            fontSize: screenSize.height * 0.03,
          ),
        ),
      ),
    );
  }
}
