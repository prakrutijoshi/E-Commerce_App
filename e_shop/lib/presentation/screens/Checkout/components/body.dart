import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/order_model.dart';
import '../../../../data/model/shipping_address_model.dart';
import '../../../../utils/default_button.dart';
import '../../../../utils/dialog.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/size_config.dart';
import '../../Cart/cubit/cart_cubit.dart';
import '../../Payment/payment_screen.dart';
import '../../shipping_address/components/shipping_address_card.dart';
import '../../shipping_address/shipping_address_screen.dart';

class Body extends StatefulWidget {
  final List<ShippingAddressModel> addresses;
  Body({
    Key? key,
    required this.addresses,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late ShippingAddressModel address;
  List<OrderModelItem> listOrderModelItem = [];
  num priceOfGoods = 0;
  num shippingCharges = 0;
  num discount = 0;
  num priceToBePaid = 0;

  @override
  void initState() {
    CartState cartState = BlocProvider.of<CartCubit>(context).state;

    if (cartState is CartLoaded) {
      listOrderModelItem = cartState.cartList
          .map((cartItem) => OrderModelItem.fromCartItemModel(cartItem))
          .toList();
      priceOfGoods = cartState.priceOfGoods;
      shippingCharges = 20;

      if (priceOfGoods >= 20000) {
        discount = priceOfGoods * 0.20;
      } else if (priceOfGoods >= 10000) {
        discount = priceOfGoods * 0.15;
      } else if (priceOfGoods >= 5000) {
        discount = priceOfGoods * 0.10;
      }

      priceToBePaid = priceOfGoods + shippingCharges - discount;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          //_CartProductList(),
          SizedBox(height: 10),
          _priceDetails(),
          SizedBox(height: 15),
          _buildAddress(context),
          Padding(
            padding: EdgeInsets.all(30.0),
            child: DefaultButton(
              text: "Proceed",
              press: () {
                if (widget.addresses.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                        priceToBePaid: priceToBePaid,
                        priceOfGoods: priceOfGoods,
                        shippingCharges: shippingCharges,
                        discount: discount,
                        listOrderModelItem: listOrderModelItem,
                        shippingAddress: address,
                      ),
                    ),
                  );
                } else {
                  UtilDialog.showInformation(
                    context,
                    title: "Select Address",
                    content: "Select an Address before proceeding",
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceDetails() {
    return Column(
      children: [
        Center(
          child: Text(
            "Price Details",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: kPrimaryColor,
            ),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(15),
        ),
        _rowdetails("Bag Total", priceOfGoods),
        _rowdetails("Discount", discount),
        _rowdetails("Shipping Charges", shippingCharges),
        Divider(),
        _rowdetails("Total", priceToBePaid),
      ],
    );
  }

  Widget _buildAddress(BuildContext context) {
    if (widget.addresses.isNotEmpty) {
      widget.addresses.forEach((singleAddress) {
        if (singleAddress.isDefault) {
          address = singleAddress;
        }
      });

      return Column(
        children: [
          ShippingAddressCard(
            shippingAddress: address,
            showDefautTick: true,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "To select another address, set that to default, or add new address",
            ),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShippingAddressScreen(),
              ),
            ),
            child: Text(
              "For Address",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: kSecondaryColor,
              ),
            ),
            style: TextButton.styleFrom(
              elevation: 5,
              backgroundColor: kPrimaryColor.withOpacity(0.7),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Center(child: Text("No Address")),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShippingAddressScreen(),
              ),
            ),
            child: Text(
              "Add New Address",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: kSecondaryColor,
              ),
            ),
            style: TextButton.styleFrom(
              elevation: 5,
              backgroundColor: kPrimaryColor.withOpacity(0.7),
            ),
          ),
        ],
      );
    }
  }

  Widget _rowdetails(String text, num price) {
    return Table(
      children: <TableRow>[
        TableRow(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 100.0),
              child: Text(
                "₹ $price",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
