import 'package:flutter/material.dart';

import '../../../utils/default_button.dart';
import '../../success/success_page.dart';
import '../../widgets/constants.dart';

class PaymentScreen extends StatefulWidget {
  final int totalPrice;
  const PaymentScreen({Key? key, required this.totalPrice}) : super(key: key);

  @override
  State<PaymentScreen> createState() =>
      _PaymentScreenState(totalPrice: totalPrice);
}

enum paymentMethods { UPI, cards, netBanking, mobileWallets, COD }

class _PaymentScreenState extends State<PaymentScreen> {
  paymentMethods? _method = paymentMethods.UPI;
  final int totalPrice;

  _PaymentScreenState({required this.totalPrice});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Payment Method"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: const Text('UPI'),
            leading: Radio<paymentMethods>(
              fillColor: MaterialStateProperty.all(kPrimaryColor),
              value: paymentMethods.UPI,
              groupValue: _method,
              onChanged: (paymentMethods? value) {
                setState(() {
                  _method = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Credit/Debit Card'),
            leading: Radio<paymentMethods>(
              fillColor: MaterialStateProperty.all(kPrimaryColor),
              value: paymentMethods.cards,
              groupValue: _method,
              onChanged: (paymentMethods? value) {
                setState(() {
                  _method = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Net Banking'),
            leading: Radio<paymentMethods>(
              fillColor: MaterialStateProperty.all(kPrimaryColor),
              value: paymentMethods.netBanking,
              groupValue: _method,
              onChanged: (paymentMethods? value) {
                setState(() {
                  _method = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Mobile Wallets'),
            leading: Radio<paymentMethods>(
              fillColor: MaterialStateProperty.all(kPrimaryColor),
              value: paymentMethods.mobileWallets,
              groupValue: _method,
              onChanged: (paymentMethods? value) {
                setState(() {
                  _method = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Cash On Delivery'),
            leading: Radio<paymentMethods>(
              fillColor: MaterialStateProperty.all(kPrimaryColor),
              value: paymentMethods.COD,
              groupValue: _method,
              onChanged: (paymentMethods? value) {
                setState(() {
                  _method = value;
                });
              },
            ),
          ),
          SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              color: kSecondaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                " You Pay : ₹$totalPrice ",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: DefaultButton(
                text: "Confirm Order",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SuccessScreen()),
                  );
                }),
          )
        ],
      ),
    );
  }
}
