import 'package:e_shop_seller/utils/default_button.dart';

import '../../../data/models/order_model.dart';
import '../../../data/models/shipping_address_model.dart';
import '../../widgets/shipping_address_card.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import '../../../utils/utils.dart';
import 'package:flutter/material.dart';

class DetaileOrderScreen extends StatelessWidget {
  final OrderModel order;

  const DetaileOrderScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: AppBar(
          title: Text("Order Details"),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.only(bottom: 10),
          children: [
            header("Products"),
            _buildListOrderModelItems(),
            header("Price Details"),
            _priceDetails(),
            _buildPaymentMethod(context),
            ShippingAddressCard(
              shippingAddress: order.shippingAddress as ShippingAddressModel,
              showDefautTick: false,
            ),
            _buildDelivering(context),
            _buildShippingButton(context),
          ],
        ),
      ),
    );
  }

  _buildListOrderModelItems() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kPrimaryColor.withOpacity(0.3)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 1,
              color: kSecondaryColor.withOpacity(0.2),
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: List.generate(
            order.orderedItems.length,
            (index) {
              return Container(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  right: 7,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Image.network(
                        order.orderedItems[index].productImage,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.orderedItems[index].productName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              "x ${order.orderedItems[index].orderedQuantity}",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        "₹${order.orderedItems[index].productPrice}",
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _priceDetails() {
    num bagTotal = 0;
    num discount = 0;
    num payablePrice = 0;

    num priceOfAllGoods = num.parse(order.priceOfGoods);

    order.orderedItems.forEach((orderedItem) {
      bagTotal += (num.parse(orderedItem.productPrice) *
          num.parse(orderedItem.orderedQuantity));
    });

    if (priceOfAllGoods >= 20000) {
      discount = priceOfAllGoods * 0.20;
    } else if (priceOfAllGoods >= 10000) {
      discount = priceOfAllGoods * 0.15;
    } else if (priceOfAllGoods >= 5000) {
      discount = priceOfAllGoods * 0.10;
    }

    payablePrice = bagTotal - discount;

    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(15),
        ),
        _rowdetails("Bag Total", bagTotal.toString()),
        _rowdetails("Discount", discount.toString()),
        Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        _rowdetails("Total", payablePrice.toString()),
      ],
    );
  }

  Widget header(String title) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orange[700],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Padding(
          padding:
              EdgeInsets.only(top: 7.0, bottom: 7.0, left: 20.0, right: 20.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _rowdetails(String text, String price) {
    return Table(
      children: <TableRow>[
        TableRow(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 100.0),
              child: Text(
                "₹ $price",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buildPaymentMethod(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Payment Method",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text(
            order.paymentMethod,
          ),
        ],
      ),
    );
  }

  _buildDelivering(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          order.isDelivering
              ? Row(
                  children: [
                    Text(
                      "Delivering By: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(UtilFormatter.formatTimeStamp(order.receivedDate)),
                  ],
                )
              : Text(
                  "Delivered",
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Text(
                  "Created At: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              Expanded(
                child: Text(
                  UtilFormatter.formatTimeStamp(order.createdAt),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _buildShippingButton(BuildContext context) {
    if (order.isDelivering) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: DefaultButton(
          press: () {},
          text: "Confirm Shipment",
        ),
      );
    }
  }
}
