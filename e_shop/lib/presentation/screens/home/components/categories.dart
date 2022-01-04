import 'package:e_shop/presentation/screens/categoryscreen/components/body.dart';

import '../../../widgets/constants.dart';
import '../../../widgets/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Flash Icon.svg", "text": "electronics"},
      {"icon": "assets/icons/Bill Icon.svg", "text": "fashion"},
      {"icon": "assets/icons/Game Icon.svg", "text": "grocery"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "home & kitchen"},
      {"icon": "assets/icons/Discover.svg", "text": "medicines"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "veg & fruits"},
      {"icon": "assets/icons/Discover.svg", "text": "others"},
    ];
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            categories.length,
            (index) => Padding(
              padding: EdgeInsets.only(right: getProportionateScreenWidth(10)),
              child: CategoryCard(
                icon: categories[index]["icon"],
                text: categories[index]["text"],
                press: () => {
                  if (categories[index]["text"].toString().isNotEmpty)
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryScreen(
                            categoryname:
                                categories[index]["text"].toString().trim(),
                          ),
                        ),
                      ),
                    }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Colors.deepPurple[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                icon!,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
