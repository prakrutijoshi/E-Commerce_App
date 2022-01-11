import '../success/success_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../data/model/order_model.dart';
import '../../../data/model/shipping_address_model.dart';
import '../../../utils/default_button.dart';
import '../../../utils/dialog.dart';
import '../../../utils/toast.dart';
import '../../common_cubits/cubit/cubit/authentication_cubit.dart';
import '../../widgets/constants.dart';
import '../Cart/cubit/cart_cubit.dart';
import '../my_orders/cubit/my_order_cubit.dart';

class PaymentScreen extends StatefulWidget {
  final num priceToBePaid;
  final num priceOfGoods;
  final num shippingCharges;
  final num discount;
  final List<OrderModelItem> listOrderModelItem;
  final ShippingAddressModel shippingAddress;

  const PaymentScreen({
    Key? key,
    required this.priceToBePaid,
    required this.listOrderModelItem,
    required this.shippingAddress,
    required this.priceOfGoods,
    required this.shippingCharges,
    required this.discount,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

enum PaymentMethods { UPI, cards, netBanking, mobileWallets, COD }

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethods _method = PaymentMethods.COD;
  num get priceToBePaid => widget.priceToBePaid;
  num get priceOfGoods => widget.priceOfGoods;
  num get shippingCharges => widget.shippingCharges;
  num get discount => widget.discount;
  List<OrderModelItem> get listOrderModelItem => widget.listOrderModelItem;
  ShippingAddressModel get shippingAddress => widget.shippingAddress;

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
            leading: Radio<PaymentMethods>(
              fillColor: MaterialStateProperty.all(kPrimaryColor),
              value: PaymentMethods.UPI,
              groupValue: _method,
              onChanged: (PaymentMethods? value) {
                setState(() {
                  _method = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Credit/Debit Card'),
            leading: Radio<PaymentMethods>(
              fillColor: MaterialStateProperty.all(kPrimaryColor),
              value: PaymentMethods.cards,
              groupValue: _method,
              onChanged: (PaymentMethods? value) {
                setState(() {
                  _method = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Net Banking'),
            leading: Radio<PaymentMethods>(
              fillColor: MaterialStateProperty.all(kPrimaryColor),
              value: PaymentMethods.netBanking,
              groupValue: _method,
              onChanged: (PaymentMethods? value) {
                setState(() {
                  _method = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Mobile Wallets'),
            leading: Radio<PaymentMethods>(
              fillColor: MaterialStateProperty.all(kPrimaryColor),
              value: PaymentMethods.mobileWallets,
              groupValue: _method,
              onChanged: (PaymentMethods? value) {
                setState(() {
                  _method = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Cash On Delivery'),
            leading: Radio<PaymentMethods>(
              fillColor: MaterialStateProperty.all(kPrimaryColor),
              value: PaymentMethods.COD,
              groupValue: _method,
              onChanged: (PaymentMethods? value) {
                setState(() {
                  _method = value!;
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
                " You Pay : ₹$priceToBePaid ",
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
                  if (_method == PaymentMethods.COD) {
                    _addNewOrder(paymentMethod: _method.toString());
                  } else {
                    UtilDialog.showInformation(
                      context,
                      title: "Select COD",
                      content:
                          "Please select Cash on Delivery, Other payment methods are currntly not working, Sorry for Inconvenience",
                    );
                  }
                }),
          )
        ],
      ),
    );
  }

  Future<void> _addNewOrder({required String paymentMethod}) async {
    AuthenticationState authState =
        BlocProvider.of<AuthenticationCubit>(context).state;

    if (authState is Authenticated) {
      UtilDialog.showWaiting(context);

      // Create new order
      var newOrder = OrderModel(
        oid: Uuid().v1(),
        uid: authState.loggedFirebaseUser.uid,
        orderedItems: listOrderModelItem,
        paymentMethod: paymentMethod,
        shippingAddress: shippingAddress,
        priceToBePaid: priceToBePaid.toString(),
        priceOfGoods: priceOfGoods.toString(),
        shippingCharges: shippingCharges.toString(),
        discount: discount.toString(),
        createdAt: Timestamp.now(),
      );

      // Add Order
      await BlocProvider.of<MyOrderCubit>(context)
          .addOrderItem(newOrder: newOrder);

      // Clear Cart
      await BlocProvider.of<CartCubit>(context).clearCart();

      UtilDialog.hideWaiting(context);

      UtilToast.showMessageForUser(context, "Order Succesfull");

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SuccessScreen()),
      );
    }
  }
}
