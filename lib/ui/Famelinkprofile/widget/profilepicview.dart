import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../util/config/color.dart';
import '../../profile_UI/PhotoImageScreen.dart';

class ProfilepicView extends StatelessWidget {
  const ProfilepicView(
      {Key? key,
      required this.selectPhase,
      required this.type,
      required this.image,
      required this.avatar})
      : super(key: key);
  final int selectPhase;
  final String type;
  final String image;
  final String avatar;
  @override
  Widget build(BuildContext context) {
    return Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: Center(
      child: Stack(
        children: [
          Container(
            height: 296.h,
            width: 296.w,
            margin: EdgeInsets.only(top: 29.h, right: 10.w, left: 10.w),
            decoration: BoxDecoration(
                color: type == "avatar" ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(12.r)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: type == "avatar"
                  ? Image.network(fit: BoxFit.cover, avatar)
                  : type == "image"
                      ? Image.network(image, fit: BoxFit.cover)
                      : Container(),
            ),
          ),
          Positioned(
            left: 287.r,
            top: 15.h,
            child: GestureDetector(
              onTap: () {
                //  setState(() {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoImageScreen(
                      getRunScreen: 'editProfileImage',
                      runtypes: selectPhase.toString(),
                    ),
                  ),
                );
                //  });
              },
              child: Container(
                height: 30.h,
                width: 30.w,
                child: CircleAvatar(
                    radius: 50.r,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: black,
                      size: 20.r,
                    )),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
