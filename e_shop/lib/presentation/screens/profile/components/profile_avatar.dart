import 'package:e_shop/data/model/user_model.dart';
import 'package:e_shop/presentation/widgets/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/constants.dart';

class ProfileAvatar extends StatefulWidget {
  final UserModel user;

  ProfileAvatar({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState(user: user);
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  final ImagePicker _picker = ImagePicker();
  final UserModel user;

  _ProfileAvatarState({required this.user});

  void takePhoto(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: 130,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.avatar),
          ),
          Positioned(
            right: -12,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: kPrimaryColor),
                  ),
                  primary: kPrimaryColor,
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet()),
                  );
                },
                child: SvgPicture.asset(
                  "assets/icons/Camera Icon.svg",
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera),
                  label: Text("Camera"),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(kPrimaryColor)),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: ElevatedButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label: Text("Gallery"),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(kPrimaryColor)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
