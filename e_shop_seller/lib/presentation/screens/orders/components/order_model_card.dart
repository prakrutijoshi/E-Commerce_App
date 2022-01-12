import '../../../../data/models/order_model.dart';
import '../../detaile_order/detaile_order.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';
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
        margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.all(getProportionateScreenWidth(12)),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20)),
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
                      title: "Payment", content: "(${order.paymentMethod})"),

                  // Number of items
                  textRow(
                      title: "Products",
                      content: "${order.orderedItems.length} (${"Products"})"),

                  // Created at
                  textRow(
                      title: "Created At",
                      content: UtilFormatter.formatTimeStamp(order.createdAt)),

                  //Estimated Delivery
                  textRow(
                    title: "Estimated Delivery By",
                    content: UtilFormatter.formatTimeStamp(order.receivedDate),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }

  textRow({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              content,
            ),
          ),
        ],
      ),
    );
  }
}
