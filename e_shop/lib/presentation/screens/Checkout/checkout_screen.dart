import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/constants.dart';
import '../shipping_address/cubit/address_cubit.dart';
import 'components/body.dart';

class CheckoutScreen extends StatelessWidget {
  final num priceOfGoods;

  const CheckoutScreen({Key? key, required this.priceOfGoods})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        title: Text("Checkout"),
        centerTitle: true,
      ),
      body: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          if (state is AddressInitial || state is AddressUpdated) {
            BlocProvider.of<AddressCubit>(context).getAddresses();
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AddressLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AddressLoaded) {
            var addresses = state.addresses;

            return Body(addresses: addresses);
          } else {
            return Center(
              child: Text("Couldn't load data"),
            );
          }
        },
      ),
    );
  }
}
