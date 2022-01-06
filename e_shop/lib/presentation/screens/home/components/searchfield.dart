import 'package:flutter/material.dart';

import '../../../widgets/constants.dart';
import '../../../widgets/size_config.dart';
import '../../searchedscreen/components/body.dart';

class SearchField extends StatefulWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController searchNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.9,
      height: SizeConfig.screenWidth * 0.125,
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: searchNameController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(20),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: "Search any Product",
          hintStyle: TextStyle(fontSize: 15),
          prefixIcon: Icon(
            Icons.search,
            color: kPrimaryColor,
          ),
        ),
        onEditingComplete: () => {
          if (searchNameController.text.isNotEmpty)
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchedScreen(
                    product: searchNameController.text.trim(),
                  ),
                ),
              ),
            },
        },
      ),
    );
  }
}
