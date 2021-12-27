import 'package:e_shop_seller/utils/constants.dart';
import 'package:e_shop_seller/utils/default_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late String _email;
  final auth = FirebaseAuth.instance;

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
            "Enter the Email to send a request link\n           to reset the password!",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 20),
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
                auth.sendPasswordResetEmail(email: _email);
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
