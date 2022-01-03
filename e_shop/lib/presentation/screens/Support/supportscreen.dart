import 'package:flutter/material.dart';

import '../../../utils/default_button.dart';
import '../../widgets/constants.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final TextEditingController queryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        title: Text("Welcome to Customer Service!"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Text(
              "Need Any help?",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: queryController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(
                    Icons.search,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
            Text(
              "Didn't find what you were looking for?",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: DefaultButton(text: "Chat with Us", press: () {}),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 1,
                    child: DefaultButton(
                      text: "Talk to Us",
                      press: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
