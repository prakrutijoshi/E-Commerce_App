import '../../detaile_order/detaile_order_screen.dart';

import '../../../../data/model/order_model.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/size_config.dart';
import '../../../../utils/utils.dart';
import 'package:flutter/material.dart';

class OrderModelCard extends StatelessWidget {
  final OrderModel order;

  const OrderModelCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetaileOrderScreen(order: order),
          ),
        );
      },
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        padding: EdgeInsets.all(getProportionateScreenWidth(12)),
        decoration: BoxDecoration(
          color: kSecondaryColor,
          shape: BoxShape.rectangle,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: order.isDelivering
                              ? ("Delivering")
                              : ("Delivered"),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        if (!order.isDelivering)
                          TextSpan(
                            text:
                                "(${UtilFormatter.formatTimeStamp(order.receivedDate)})",
                          ),
                      ],
                    ),
                  ),

                  // Price to be paid and payment method
                  textRow(
                      title: "Total",
                      content:
                          "₹${order.priceToBePaid} (${order.paymentMethod})"),

                  // Number of items
                  textRow(
                      title: "Quantity",
                      content: "${order.orderedItems.length} (${"Products"})"),

                  // Created at
                  textRow(
                      title: "Created At",
                      content: UtilFormatter.formatTimeStamp(order.createdAt)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }

  textRow({required String title, required String content}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            title,
          ),
        ),
        Expanded(
          child: Text(
            content,
          ),
        ),
      ],
    );
  }
}
