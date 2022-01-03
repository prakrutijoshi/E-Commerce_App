import '../../../../data/model/shipping_address_model.dart';
import '../../Cart/components/cart_card.dart';
import '../../Payment/payment_screen.dart';
import '../../shipping_address/components/shipping_address_card.dart';
import '../../shipping_address/shipping_address_screen.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/size_config.dart';
import '../../../../utils/default_button.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final ShippingAddressModel address;
  final bool showDefautTick;
  Body({Key? key, required this.address, this.showDefautTick = true})
      : super(key: key);

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
          // address.forEach((element) {
          //   element.isDefault && showDefautTick ?
          //  })
          address.isDefault && showDefautTick
              ? InkWell(
                  child: ShippingAddressCard(shippingAddress: address),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShippingAddressScreen()));
                  },
                )
              : Container(),
          Padding(
            padding: EdgeInsets.all(30.0),
            child: DefaultButton(
                text: "Proceed",
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PaymentScreen(totalPrice: totalPrice)));
                }),
          ),
        ],
      ),
    );
  }

  Widget _cartProductList() {
    return ListView.builder(
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.all(10.0),
        child: CartCard(),
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
        _rowdetails("Bag Total", bagtotal),
        _rowdetails("Discount", discount),
        _rowdetails("Shipping Charges", shippingCharges),
        Divider(),
        _rowdetails("Total", totalPrice),
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
