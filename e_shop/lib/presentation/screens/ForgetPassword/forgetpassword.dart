import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/default_button.dart';
import '../../common_cubits/cubit/cubit/authentication_cubit.dart';
import '../../widgets/constants.dart';
import '../../widgets/size_config.dart';
import '../register/register_screen.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          Text(
            "Please enter your email and we will send you a link to return to your account",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: 'Enter your Email',
                labelStyle: TextStyle(color: kPrimaryColor),
                suffixIcon: Icon(Icons.email_outlined, color: kPrimaryColor),
              ),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: DefaultButton(
              text: "Send Request",
              press: () {
                BlocProvider.of<AuthenticationCubit>(context)
                    .resetPassword(email: _email);
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildNoAccountText(context),
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
            "Don't Have a seller Account? ",
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
