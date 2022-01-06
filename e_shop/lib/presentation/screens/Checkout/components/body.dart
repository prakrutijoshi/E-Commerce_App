import 'package:flutter/material.dart';

import '../../../../data/model/shipping_address_model.dart';
import '../../../../utils/default_button.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/size_config.dart';
import '../../Payment/payment_screen.dart';
import '../../shipping_address/components/shipping_address_card.dart';
import '../../shipping_address/shipping_address_screen.dart';

class Body extends StatelessWidget {
  final List<ShippingAddressModel> addresses;
  Body({
    Key? key,
    required this.addresses,
  }) : super(key: key);

  int get shippingCharges => 20;
  int get discount => 200;
  int get bagtotal => 2200;
  int get totalPrice => bagtotal + shippingCharges - discount;

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PaymentScreen(totalPrice: totalPrice),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  // Widget _cartProductList() {
  //   return ListView.builder(
  //     itemBuilder: (context, index) => Padding(
  //       padding: EdgeInsets.all(10.0),
  //       child: CartCard(),
  //     ),
  //   );
  // }

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
        _rowdetails("Bag Total", bagtotal),
        _rowdetails("Discount", discount),
        _rowdetails("Shipping Charges", shippingCharges),
        Divider(),
        _rowdetails("Total", totalPrice),
      ],
    );
  }

  Widget _buildAddress(BuildContext context) {
    if (addresses.isNotEmpty) {
      late ShippingAddressModel address;

      addresses.forEach((singleAddress) {
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

  Widget _rowdetails(String text, int price) {
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
