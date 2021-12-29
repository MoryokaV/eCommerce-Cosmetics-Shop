import 'package:cosmetics_shop/models/cart.dart';
import 'package:cosmetics_shop/models/user.dart';
import 'package:cosmetics_shop/screens/order/congrats_screen.dart';
import 'package:cosmetics_shop/services/databaseHandler.dart';
import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/widgets/bottomNavBar.dart';
import 'package:cosmetics_shop/models/order.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../responsive.dart';

class OrderScreen extends StatefulWidget {
  final Order order;

  OrderScreen({
    required this.order,
  });

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  FocusNode _focusNodeName = new FocusNode();
  FocusNode _focusNodeAddress = new FocusNode();
  FocusNode _focusNodeZip = new FocusNode();
  FocusNode _focusNodeEmail = new FocusNode();
  FocusNode _focusNodePhone = new FocusNode();
  FocusNode _focusNodeDetails = new FocusNode();

  String fullName = "";
  String email = "";
  String phoneNumber = "";
  String address = "";
  String notes = "";
  String zip = "";

  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerAddress = new TextEditingController();
  TextEditingController _controllerZip = new TextEditingController();
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPhone = new TextEditingController();
  TextEditingController _controllerDetails = new TextEditingController();

  String destinationCity = destinationCities[0];
  String destinationCountry = destinationCountries[0];
  String shippingMethod = deliveryOptions[0];

  bool saveDetails = false;

  List<bool> validFields = [
    true,
    true,
    true,
  ];

  final validName = RegExp(r'^[a-zA-Z][a-zA-Z\s]+$');
  final validNumbers = RegExp(r'^-?[0-9]+$');
  final validEmail = RegExp(
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");

  bool isLoading = true;

  void initState() {
    super.initState();
    loadAccountDetails();
  }

  Future<void> loadAccountDetails() async {
    User user = await retrieveUser();

    _controllerName.text = fullName = user.name;
    _controllerEmail.text = email = user.email;
    _controllerPhone.text = phoneNumber = user.phone;
    _controllerAddress.text = address = user.address;
    _controllerZip.text = zip = user.zipcode;

    setState(() => isLoading = false);
  }

  void displayMessage(String fieldName) {
    Fluttertoast.showToast(
      msg: "Invalid " + fieldName,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16,
    );
  }

  void extractControllers() {
    fullName = _controllerName.text;
    email = _controllerEmail.text;
    phoneNumber = _controllerPhone.text;
    address = _controllerAddress.text;
    notes = _controllerDetails.text;
    zip = _controllerZip.text;
  }

  bool checkForCorrectDetails() {
    if (!validName.hasMatch(fullName)) {
      displayMessage("name");
      setState(() {
        validFields[0] = false;
        _focusNodeName.requestFocus();
      });
      return false;
    } else {
      validFields[0] = true;
    }

    if (!validEmail.hasMatch(email)) {
      displayMessage("email address");
      setState(() {
        validFields[1] = false;
        _focusNodeEmail.requestFocus();
      });
      return false;
    } else {
      validFields[1] = true;
    }

    if (!validNumbers.hasMatch(phoneNumber.toString())) {
      displayMessage("phone number");
      setState(() {
        validFields[2] = false;
        _focusNodePhone.requestFocus();
      });
      return false;
    } else {
      validFields[2] = true;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: GestureDetector(
        onTap: () {
          _focusNodeName.unfocus();
          _focusNodeAddress.unfocus();
          _focusNodeZip.unfocus();
          _focusNodeEmail.unfocus();
          _focusNodePhone.unfocus();
          _focusNodeDetails.unfocus();
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: Row(
                  children: [
                    Text(
                      "Shipping",
                      style: TextStyle(
                        fontSize: Responsive.safeBlockHorizontal * 8,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: Responsive.safeBlockVertical * 8,
                width: Responsive.safeBlockHorizontal * 90,
                margin: EdgeInsets.only(top: kDefaultPadding / 2),
                padding: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding / 4,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: validFields[0] ? Colors.black54 : Colors.red,
                      blurRadius: 6,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Center(
                  child: TextField(
                    focusNode: _focusNodeName,
                    onSubmitted: (newValue) {
                      fullName = newValue;
                      FocusScope.of(context).unfocus();
                    },
                    controller: _controllerName,
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      labelStyle: TextStyle(
                        fontFamily: "Arial",
                        fontSize: Responsive.safeBlockHorizontal * 3,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: Responsive.safeBlockVertical * 8,
                width: Responsive.safeBlockHorizontal * 90,
                margin: EdgeInsets.only(top: kDefaultPadding / 2),
                padding: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding / 4,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: validFields[1] ? Colors.black54 : Colors.red,
                      blurRadius: 6,
                      offset: Offset(-1, 1),
                    ),
                  ],
                ),
                child: Center(
                  child: TextField(
                    focusNode: _focusNodeEmail,
                    onSubmitted: (newValue) {
                      email = newValue;
                      FocusScope.of(context).unfocus();
                    },
                    controller: _controllerEmail,
                    decoration: InputDecoration(
                      labelText: "Email address",
                      labelStyle: TextStyle(
                        fontFamily: "Arial",
                        fontSize: Responsive.safeBlockHorizontal * 3,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: Responsive.safeBlockVertical * 8,
                width: Responsive.safeBlockHorizontal * 90,
                margin: EdgeInsets.only(top: kDefaultPadding / 2),
                padding: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding / 4,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: validFields[2] ? Colors.black54 : Colors.red,
                      blurRadius: 6,
                      offset: Offset(-1, 1),
                    ),
                  ],
                ),
                child: Center(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    focusNode: _focusNodePhone,
                    onSubmitted: (String newValue) {
                      phoneNumber = newValue;
                      FocusScope.of(context).unfocus();
                    },
                    controller: _controllerPhone,
                    decoration: InputDecoration(
                      labelText: "Phone Number (+40)",
                      labelStyle: TextStyle(
                        fontFamily: "Arial",
                        fontSize: Responsive.safeBlockHorizontal * 3,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: Responsive.safeBlockVertical * 8,
                width: Responsive.safeBlockHorizontal * 90,
                margin: EdgeInsets.only(top: kDefaultPadding / 2),
                padding: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding / 4,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 6,
                      offset: Offset(-1, 1),
                    ),
                  ],
                ),
                child: Center(
                  child: TextField(
                    focusNode: _focusNodeAddress,
                    onSubmitted: (newValue) {
                      address = newValue;
                      FocusScope.of(context).unfocus();
                    },
                    controller: _controllerAddress,
                    decoration: InputDecoration(
                      labelText: "Address",
                      labelStyle: TextStyle(
                        fontFamily: "Arial",
                        fontSize: Responsive.safeBlockHorizontal * 3,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: Responsive.safeBlockVertical * 11.5,
                width: Responsive.safeBlockHorizontal * 90,
                margin: EdgeInsets.only(
                  top: kDefaultPadding / 1.5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Responsive.safeBlockHorizontal * 42.5,
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding / 1.5,
                      ),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 6,
                            offset: Offset(-1, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: kDefaultPadding / 4,
                              bottom: 0,
                            ),
                            child: Text(
                              "City",
                              style: TextStyle(
                                fontFamily: "Arial",
                                fontSize: Responsive.safeBlockHorizontal * 3,
                              ),
                            ),
                          ),
                          DropdownButton(
                            elevation: 16,
                            isExpanded: true,
                            underline: SizedBox(),
                            value: destinationCity,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              size: 24,
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                if (value != null) destinationCity = value;
                              });
                            },
                            items: destinationCities
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontFamily: "Arial",
                                    fontSize:
                                        Responsive.safeBlockHorizontal * 4,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: Responsive.safeBlockVertical * 11.5,
                        margin: EdgeInsets.only(left: kDefaultPadding),
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6,
                              offset: Offset(-1, 1),
                            ),
                          ],
                        ),
                        child: Center(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            focusNode: _focusNodeZip,
                            onSubmitted: (String newValue) {
                              zip = newValue;
                              FocusScope.of(context).unfocus();
                            },
                            controller: _controllerZip,
                            decoration: InputDecoration(
                              labelText: "* Zip Code",
                              labelStyle: TextStyle(
                                fontFamily: "Arial",
                                fontSize: Responsive.safeBlockHorizontal * 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: Responsive.safeBlockVertical * 11.5,
                width: Responsive.safeBlockHorizontal * 90,
                margin: EdgeInsets.only(
                  top: kDefaultPadding / 1.5,
                ),
                padding: EdgeInsets.only(
                  left: kDefaultPadding / 1.5,
                  right: kDefaultPadding / 1.5,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 6,
                      offset: Offset(-1, 1),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: kDefaultPadding / 4,
                        bottom: 0,
                      ),
                      child: Text(
                        "Country",
                        style: TextStyle(
                          fontFamily: "Arial",
                          fontSize: Responsive.safeBlockHorizontal * 3,
                        ),
                      ),
                    ),
                    DropdownButton(
                      elevation: 16,
                      underline: SizedBox(),
                      isExpanded: true,
                      value: destinationCountry,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 24,
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          if (value != null) destinationCountry = value;
                        });
                      },
                      items: destinationCountries
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontFamily: "Arial",
                              fontSize: Responsive.safeBlockHorizontal * 4,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Container(
                height: Responsive.safeBlockVertical * 11.5,
                width: Responsive.safeBlockHorizontal * 90,
                margin: EdgeInsets.only(
                  top: kDefaultPadding / 1.5,
                ),
                padding: EdgeInsets.only(
                  left: kDefaultPadding / 1.5,
                  right: kDefaultPadding / 1.5,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 6,
                      offset: Offset(-1, 1),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: kDefaultPadding / 4,
                        bottom: 0,
                      ),
                      child: Text(
                        "Shipping Method",
                        style: TextStyle(
                          fontFamily: "Arial",
                          fontSize: Responsive.safeBlockHorizontal * 3,
                        ),
                      ),
                    ),
                    DropdownButton(
                      elevation: 16,
                      underline: SizedBox(),
                      isExpanded: true,
                      value: shippingMethod,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 24,
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          if (value != null) shippingMethod = value;
                        });
                      },
                      items: deliveryOptions
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontFamily: "Arial",
                              fontSize: Responsive.safeBlockHorizontal * 4,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Container(
                height: Responsive.safeBlockVertical * 10,
                width: Responsive.safeBlockHorizontal * 90,
                margin: EdgeInsets.only(top: kDefaultPadding / 2),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                child: Center(
                  child: TextField(
                    focusNode: _focusNodeDetails,
                    onSubmitted: (newNotes) {
                      notes = newNotes;
                      FocusScope.of(context).unfocus();
                    },
                    controller: _controllerDetails,
                    style: TextStyle(
                      fontSize: Responsive.safeBlockHorizontal * 4,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      labelText: "* Personal Notes",
                      labelStyle: TextStyle(
                        fontFamily: "Arial",
                        fontSize: Responsive.safeBlockHorizontal * 4,
                        color: _focusNodeAddress.hasFocus
                            ? Colors.black54
                            : Colors.black54,
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 6,
                      offset: Offset(-1, 1),
                    ),
                  ],
                ),
              ),
              CheckboxListTile(
                title: Text(
                  "Save these details for faster checkout?",
                  style: TextStyle(
                    fontFamily: "Arial",
                    color: Colors.black54,
                    fontSize: Responsive.safeBlockHorizontal * 4,
                  ),
                ),
                value: saveDetails,
                onChanged: (bool? newValue) {
                  setState(() {
                    if (newValue != null) saveDetails = newValue;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              GestureDetector(
                onTap: () async {
                  //send message
                  setState(() {
                    _focusNodeName.unfocus();
                    _focusNodeEmail.unfocus();
                    _focusNodePhone.unfocus();
                    _focusNodeAddress.unfocus();
                  });
                  extractControllers();
                  if (checkForCorrectDetails()) {
                    if (shippingMethod == deliveryOptions[0]) {
                      widget.order.value += deliveryCost;
                      widget.order.description += "Standard Delivery";
                    }

                    if (saveDetails) {
                      await updateUser(
                        User(
                          name: fullName,
                          email: email,
                          phone: phoneNumber,
                          address: address,
                          zipcode: zip,
                        ),
                      );
                    }

                    await insertOrder(widget.order);

                    List<Cart> cart = await retrieveCart();

                    for (int i = 0; i < cart.length; i++)
                      await deleteCartItem(cart[i].productID);

                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => CongratsScreen(
                          number: widget.order.number,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: kDefaultPadding / 2,
                    bottom: kDefaultPadding,
                  ),
                  height: Responsive.safeBlockVertical * 7,
                  width: Responsive.safeBlockHorizontal * 70,
                  child: Center(
                    child: Text(
                      "Buy",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Responsive.safeBlockHorizontal * 6,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      kDefaultPadding * 2,
                    ),
                    color: kAccentColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 2.5,
                        offset: Offset(-1, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: kAccentColor,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 5,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 20,
            color: kPrimaryColor,
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            "Checkout",
            style: TextStyle(
              fontFamily: "Roboto-Medium",
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          IconButton(
            icon: Icon(Icons.home),
            iconSize: 20,
            color: kPrimaryColor,
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => BottomNavBar(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
