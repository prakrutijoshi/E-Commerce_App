import 'package:e_shop_seller/presentation/screens/register/components/body.dart';
import 'package:e_shop_seller/utils/constants.dart';

import 'components/register_form.dart';
import 'cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart' as di;

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<RegisterCubit>(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("SIGN UP"),
            centerTitle: true,
            backgroundColor: kPrimaryColor,
          ),
          body: Body(),
          bottomNavigationBar: _buildHaveAccountText(context),
        ),
      ),
    );
  }

  _buildHaveAccountText(context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have a seller account?',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text(
              'Login',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
