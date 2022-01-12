import 'package:flutter/material.dart';

import '../../data/models/shipping_address_model.dart';
import '../../utils/constants.dart';

class ShippingAddressCard extends StatelessWidget {
  final ShippingAddressModel shippingAddress;
  final Function()? onPressed;
  final bool showDefautTick;

  const ShippingAddressCard({
    Key? key,
    required this.shippingAddress,
    this.onPressed,
    this.showDefautTick = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                spreadRadius: 1,
                color: Colors.grey.withOpacity(0.2),
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Delivery Address",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  _buildDefaultText(context),
                ],
              ),
              textRow(
                title: "Name",
                content: shippingAddress.fullName,
              ),
              textRow(
                title: "Phone number",
                content: shippingAddress.phoneNumber,
              ),
              textRow(
                title: "Address",
                content: shippingAddress.detailedAddress,
              ),
              textRow(
                title: "City",
                content: shippingAddress.city,
              ),
              textRow(
                title: "State ",
                content: shippingAddress.state,
              ),
              textRow(
                title: "Postal Code",
                content: shippingAddress.postal,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildDefaultText(BuildContext context) {
    return shippingAddress.isDefault && showDefautTick
        ? Text(
            "[default]",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          )
        : Container();
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
