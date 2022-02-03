import 'package:cosmetics_shop/models/cart.dart';
import 'package:cosmetics_shop/models/user.dart';
import 'package:cosmetics_shop/screens/order/components/textFieldName.dart';
import 'package:cosmetics_shop/screens/order/congrats_screen.dart';
import 'package:cosmetics_shop/services/sqliteHelper.dart';
import 'package:cosmetics_shop/constants.dart';
import 'package:cosmetics_shop/widgets/bottomNavBar.dart';
import 'package:cosmetics_shop/models/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
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
  final _formKey = GlobalKey<FormState>();

  late User user;
  String _name = "";
  String _email = "";
  String _phone = "";
  String _address = "";

  bool saveDetails = false;

  String destinationCity = destinationCities[0];
  String shippingMethod = deliveryOptions[0];

  bool isLoading = true;

  void initState() {
    super.initState();
    loadAccountDetails();
  }

  Future<void> loadAccountDetails() async {
    user = await retrieveUser();

    _name = user.name;
    _email = user.email;
    _phone = user.phone;
    _address = user.address;

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(),
      body: isLoading
          ? LoadingIndicator
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
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
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldName(text: "Full name"),
                          TextFormField(
                            initialValue: user.name,
                            decoration: InputDecoration(hintText: "John Bob"),
                            validator: RequiredValidator(
                                errorText: "Name is required"),
                            onSaved: (value) => _name = value!,
                          ),
                          SizedBox(height: kDefaultPadding),
                          TextFieldName(text: "Email"),
                          TextFormField(
                            initialValue: user.email,
                            decoration:
                                InputDecoration(hintText: "test@example.com"),
                            validator:
                                EmailValidator(errorText: "Use a valid email"),
                            onSaved: (value) => _email = value!,
                          ),
                          SizedBox(height: kDefaultPadding),
                          TextFieldName(text: "Phone number"),
                          TextFormField(
                            initialValue: user.phone,
                            keyboardType: TextInputType.phone,
                            decoration:
                                InputDecoration(hintText: "+40123456789"),
                            validator: RequiredValidator(
                                errorText: "Use a valid phone number"),
                            onSaved: (value) => _phone = value!,
                          ),
                          SizedBox(height: kDefaultPadding),
                          TextFieldName(text: "Address"),
                          TextFormField(
                            initialValue: user.address,
                            decoration: InputDecoration(
                                hintText: "213 Derrick Street Boston, USA"),
                            validator: RequiredValidator(
                                errorText: "Address is required"),
                            onSaved: (value) => _address = value!,
                          ),
                          SizedBox(height: kDefaultPadding),
                          TextFieldName(text: "City"),
                          DropdownButtonFormField(
                            elevation: 16,
                            isExpanded: true,
                            value: destinationCity,
                            onChanged: (String? newValue) {
                              setState(() => destinationCity = newValue!);
                            },
                            items: destinationCities
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: kDefaultPadding),
                          TextFieldName(text: "Shipping method"),
                          DropdownButtonFormField(
                            elevation: 16,
                            isExpanded: true,
                            value: shippingMethod,
                            onChanged: (String? newValue) {
                              setState(() => shippingMethod = newValue!);
                            },
                            items: deliveryOptions
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        "Save these details for faster checkout?",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: Responsive.safeBlockHorizontal * 4,
                        ),
                      ),
                      value: saveDetails,
                      activeColor: kAccentColor,
                      onChanged: (newValue) {
                        setState(() => saveDetails = newValue!);
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          if (shippingMethod == deliveryOptions[0]) {
                            widget.order.value += deliveryCost;
                            widget.order.description += "Standard Delivery";

                            if (saveDetails) {
                              await updateUser(
                                User(
                                  name: _name,
                                  email: _email,
                                  phone: _phone,
                                  address: _address,
                                ),
                              );
                            }

                            await insertOrder(widget.order);

                            List<Cart> cart = await retrieveCart();
                            for (int i = 0; i < cart.length; i++)
                              await deleteCartItem(cart[i].productId);

                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => CongratsScreen(
                                  number: widget.order.number,
                                ),
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          top: kDefaultPadding / 2,
                          bottom: kDefaultPadding * 2,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: kDefaultPadding / 2,
                        ),
                        width: Responsive.screenWidth,
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
                          borderRadius: BorderRadius.circular(36),
                          color: kAccentColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 3,
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
