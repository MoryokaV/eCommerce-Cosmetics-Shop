import 'package:cosmetics_shop/services/databaseHandler.dart';
import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/models/order.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreen createState() => _HistoryScreen();
}

class _HistoryScreen extends State<HistoryScreen> {
  late List<Order> orders;
  bool isLoading = false;

  void initState() {
    super.initState();
    getOrders();
  }

  void getOrders() async {
    setState(() => isLoading = true);

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
        return FittedBox(
          fit: BoxFit.fill,
          child: Container(
            width: screenSize.width,
            margin: EdgeInsets.only(
              top: defaultPadding,
              bottom: defaultPadding / 1.75,
            ),
            padding: EdgeInsets.only(
              left: defaultPadding,
              right: defaultPadding,
              top: defaultPadding / 2,
              bottom: defaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(1, 1),
                  blurRadius: 7.5,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "#" + order.number.toString(),
                      style: TextStyle(
                        fontFamily: "Calibri",
                        fontSize: screenSize.width * 0.055,
                      ),
                    ),
                    Spacer(),
                    Text(
                      order.date,
                      style: TextStyle(
                        fontFamily: "Calibri",
                        fontSize: screenSize.width * 0.055,
                      ),
                    ),
                    Spacer(),
                    Text(
                      order.value.toString() + " RON",
                      style: TextStyle(
                        fontFamily: "Calibri",
                        fontSize: screenSize.width * 0.055,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: defaultPadding / 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        order.description,
                        style: TextStyle(
                          fontFamily: "Roboto-Light",
                          fontSize: screenSize.width * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPopUpMessage(Size screenSize) {
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
        backButton(screenSize, 0),
      ],
    );
  }

  Widget backButton(Size screenSize, double pad) {
    return Container(
      height: screenSize.height * 0.06,
      width: screenSize.width * 0.65,
      margin: EdgeInsets.all(pad),
      child: TextButton(
        child: Text(
          "‹ Main Menu",
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: screenSize.height * 0.03,
          ),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      decoration: BoxDecoration(
        color: accentColor,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
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
              ? buildPopUpMessage(screenSize)
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    buildOrdersList(screenSize),
                    backButton(screenSize, defaultPadding * 2),
                    /*Container(
                      height: screenSize.height * 0.065,
                      margin: EdgeInsets.all(
                        defaultPadding,
                      ),
                      child: TextButton(
                        child: Text(
                          "‹ Main Menu",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: screenSize.height * 0.035,
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(36),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 5,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                    ),*/
                  ],
                ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context, Size screenSize) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: accentColor,
      elevation: 10,
      title: Center(
        child: Text(
          "Orders History",
          style: TextStyle(
            color: primaryColor,
            fontFamily: "Arial",
            fontWeight: FontWeight.bold,
            fontSize: screenSize.height * 0.03,
          ),
        ),
      ),
    );
  }
}
