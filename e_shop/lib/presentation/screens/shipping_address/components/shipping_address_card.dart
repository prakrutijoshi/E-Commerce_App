import 'package:e_shop/data/model/shipping_address_model.dart';
import 'package:flutter/material.dart';

class ShippingAddressCard extends StatelessWidget {
  final ShippingAddressModel deliveryAddress;
  final Function()? onPressed;
  final bool showDefautTick;

  const ShippingAddressCard({
    Key? key,
    required this.deliveryAddress,
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
                    "delivery_address",
                  ),
                  Spacer(),
                  _buildDefaultText(context),
                ],
              ),
              textRow(
                title: "Name",
                content: deliveryAddress.fullName,
              ),
              textRow(
                title: "Phone number",
                content: deliveryAddress.phoneNumber,
              ),
              textRow(
                title: "Detail address",
                content: deliveryAddress.deatiledAddress,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildDefaultText(BuildContext context) {
    return deliveryAddress.isDefault && showDefautTick
        ? Text(
            "[default]",
          )
        : Container();
  }

  textRow({required String title, required String content}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Text(
            title,
          ),
        ),
        Expanded(
          child: Text(
            content,
          ),
        )
      ],
    );
  }
}
