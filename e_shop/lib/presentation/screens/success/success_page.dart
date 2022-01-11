import '../../widgets/constants.dart';
import '../../../utils/default_button.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Column(
        children: [
          Container(
            child: Image(
              image: AssetImage("assets/images/success.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: Text(
              "Your order has successfully been placed!",
              style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  color: kPrimaryColor),
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: DefaultButton(
                text: "Go back to Home",
                press: () {
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName("/"),
                  );
                }),
          )
        ],
      ),
    );
  }
}
