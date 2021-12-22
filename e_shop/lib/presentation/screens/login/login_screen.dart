import 'package:e_shop/presentation/screens/login/components/body.dart';
import 'package:e_shop/presentation/widgets/constants.dart';
import 'package:e_shop/presentation/widgets/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart' as di;
import '../register/register_screen.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<LoginCubit>(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text("SIGN IN"),
            centerTitle: true,
          ),
          body: Body(),
          bottomNavigationBar: _buildNoAccountText(context),
        ),
      ),
    );
  }

  _buildNoAccountText(context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Don't Have an Account? ",
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()))
            },
            child: Text(
              'Register',
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
