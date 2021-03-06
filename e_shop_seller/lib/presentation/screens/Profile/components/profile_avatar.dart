import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/models/seller_model.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';
import '../../../../utils/utils.dart';
import '../cubit/profile_cubit.dart';

class ProfileAvatar extends StatefulWidget {
  final SellerModel seller;
  const ProfileAvatar({Key? key, required this.seller}) : super(key: key);

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState(seller: seller);
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  final ImagePicker _picker = ImagePicker();
  final SellerModel seller;

  _ProfileAvatarState({required this.seller});

  void takePhoto(BuildContext context, ImageSource source) async {
    final XFile? imageFile = await _picker.pickImage(source: source);
    if (imageFile != null) {
      var profileImageURL = await BlocProvider.of<ProfileCubit>(context)
          .uploadSellerAvatar(imageFile: imageFile);

      var updatedSeller = seller.cloneWith(
        avatar: profileImageURL,
      );

      await BlocProvider.of<ProfileCubit>(context).updateSeller(updatedSeller);

      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      UtilDialog.showInformation(
        context,
        content: "Image was not Picked.",
      );
    }
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
            backgroundColor: kPrimaryColor,
            backgroundImage: seller.avatar.isNotEmpty
                ? NetworkImage(seller.avatar)
                : AssetImage("assets/images/default_avatar.jpg")
                    as ImageProvider<Object>,
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
                    builder: (context) => bottomSheet(context),
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

  Widget bottomSheet(BuildContext context) {
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
                    takePhoto(context, ImageSource.camera);
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
                    takePhoto(context, ImageSource.gallery);
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
