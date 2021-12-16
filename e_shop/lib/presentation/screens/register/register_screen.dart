import 'package:e_shop/presentation/screens/register/components/body.dart';
import 'package:e_shop/presentation/screens/register/components/register_form.dart';
import 'package:e_shop/presentation/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart' as di;
import 'cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<RegisterCubit>(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text("Sign Up"),
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
            'Already have an account?',
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
