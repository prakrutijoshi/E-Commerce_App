import 'package:e_shop/data/model/shipping_address_model.dart';
import 'package:e_shop/presentation/screens/Checkout/components/body.dart';
import 'package:e_shop/presentation/screens/shipping_address/cubit/address_cubit.dart';
import 'package:e_shop/presentation/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class checkoutScreen extends StatelessWidget {
  const checkoutScreen({Key? key}) : super(key: key);

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
            var address = state.addresses[0];
            return Body(address: address);
          } else {
            print(state.toString());
            return Center(
              child: Text("Couldn't load data"),
            );
          }
        },
      ),
    );
  }
}
