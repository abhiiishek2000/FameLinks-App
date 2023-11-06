import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/gradient_borders.dart';

import '../../../util/config/color.dart';
import '../provider/home_feed_provider.dart';

class BudWidget extends StatelessWidget {
  BudWidget(
      {Key? key,
      this.linkProfileImage,
      this.avtarImage,
      this.profileImage,
      required this.provider})
      : super(key: key);
  String? linkProfileImage;
  HomeFeedProvider provider;
  dynamic avtarImage;
  dynamic profileImage;

  @override
  Widget build(BuildContext context) {
    print("linkProfileImage $linkProfileImage");
    return Container(
        height: 95.h,
        width: 95.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: GradientBoxBorder(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF4944),
                Color(0xFF141070),
                Color(0xFF1C126E),
                Color(0xFFFF4944),
                Color(0xFF0060FF),
              ],
              stops: [
                0,
                0.260417,
                0.260517,
                0.619792,
                1,
              ],
              tileMode: TileMode.decal,
            ),
            width: 2,
          ),
        ),
        child: Padding(
            padding: EdgeInsets.all(4),
            child: linkProfileImage == null
                ? avtarImage != null
                    ? Container(
                        height: 90.h,
                        width: 90.w,
                        child: Center(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(avtarImage),
                            backgroundColor: Colors.transparent,
                            radius: 50,
                          ),
                        ),
                      )
                    : profileImage != null
                        ? Container(
                            height: 90.h,
                            width: 90.w,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(profileImage),
                              backgroundColor: Colors.transparent,
                              radius: 50,
                            ),
                          )
                        : Container(
                            height: 95.h,
                            width: 95.w,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [lightRedWhite, lightRed]),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                provider.selectedProfileType ==
                                        ProfileType.FAMELinks
                                    ? 'assets/icons/ic_fame.svg'
                                    : provider.selectedProfileType ==
                                            ProfileType.FUNLinks
                                        ? 'assets/icons/ic_funlinks.svg'
                                        : provider.selectedProfileType ==
                                                ProfileType.FOLLOWLinks
                                            ? 'assets/icons/ic_followlinks.svg'
                                            : provider.selectedProfileType ==
                                                    ProfileType.JOBLinks
                                                ? 'assets/icons/ic_joblinks.svg'
                                                : 'assets/icons/ic_fame.svg',
                                height: 25.h,
                              ),
                            ),
                          )
                : Container(
                    height: 90.h,
                    width: 90.w,
                    child: CircleAvatar(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        child: CachedNetworkImage(
                          imageUrl: linkProfileImage!,
                          imageBuilder: (context, imageProvider) => Container(
                            height: 90.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      //  backgroundImage: NetworkImage(linkProfileImage!),
                      backgroundColor: Colors.transparent,
                      radius: 50.r,
                    ),
                  )));
  }
}
