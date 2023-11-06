import 'dart:async';

import 'package:famelink/ui/Famelinkprofile/function/famelinkFun.dart';
import 'package:famelink/ui/otherUserProfile/component/drawerText.dart';
import 'package:famelink/ui/otherUserProfile/provder/OtherPofileprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../common/common_image.dart';
import '../../../../share/firebasedynamiclink.dart';
import '../../../latest_profile/SayHiFirstVideo.dart';

class CompactViewItems extends StatelessWidget {
  const CompactViewItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<FameLinkFun, OtherPofileprovider>(
        builder: (context, provider, otherPofileprovider, child) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          items(
              onTap: () async {
                provider.therprofiledrower(provider.isdrower);
              },
              iconUrl: 'assets/icons/svg/settings.svg',
              title: 'Settings'),

          SizedBox(height: 20),
          items(
              onTap: () {
                String? name = "otherprofilefame";
                if (otherPofileprovider.selectPhase == 0) {
                  Sharedynamic.shareprofile(
                      otherPofileprovider
                          .profileFameLinksList[0].masterUser!.sId!,
                      name,
                      otherPofileprovider.profileFameLinksList[0].name!
                          .toString());
                } else if (otherPofileprovider.selectPhase == 1) {
                  Sharedynamic.shareprofile(
                      otherPofileprovider
                          .otherUserProfileFunLinksModel[0].masterUser!.sId!,
                      name,
                      otherPofileprovider.otherUserProfileFunLinksModel[0].name!
                          .toString());
                } else if (otherPofileprovider.selectPhase == 2) {
                  Sharedynamic.shareprofile(
                      otherPofileprovider
                          .otherUserProfileFollowLinksModelResult[0]
                          .masterUser!
                          .sId!,
                      name,
                      otherPofileprovider
                          .otherUserProfileFollowLinksModelResult[0].name!
                          .toString());
                }
              },
              iconUrl: 'assets/icons/svg/share.svg',
              title: 'Share'),

          //SizedBox(height: 20),
          SizedBox(height: 20.h),
          items(
              onTap: () {
                var valu;

                if (otherPofileprovider.selectPhase == 0) {
                  valu = "contest";
                }
                if (otherPofileprovider.selectPhase == 1) {
                  valu = "funlinks";
                } else if (otherPofileprovider.selectPhase == 2) {
                  valu = "followlinks";
                }
                print("say hi video  $valu");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SayHiFirstVideo(
                      links: valu,
                    ),
                  ),
                );
              },
              iconUrl: CommonImage.scan,
              title: 'Say Hi...'),
        ],
      );
    });
  }

  GestureDetector items(
          {required VoidCallback onTap,
          required String iconUrl,
          required String title}) =>
      GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconUrl,
              color: Colors.white,
            ),
            SizedBox(width: 8.w),
            ShadowText(
              txt: title,
              size: ScreenUtil().setSp(14),
              fontColor: Colors.white,
            ),
          ],
        ),
      );
}
