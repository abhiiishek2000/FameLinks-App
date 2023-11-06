import 'package:dio/dio.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/ui/followlinkexplore/followlinkExplore.dart';
import 'package:famelink/ui/home_feed/provider/home_feed_provider.dart';
import 'package:famelink/ui/joblinks/ambassadors.dart';
import 'package:famelink/util/constants.dart';
import 'package:famelink/util/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../util/config/color.dart';
import '../../contestants/FunLinksContestantScreen.dart';

class ExploreIconWidget extends StatefulWidget {
  const ExploreIconWidget({Key? key}) : super(key: key);

  @override
  State<ExploreIconWidget> createState() => _ExploreIconWidgetState();
}

class _ExploreIconWidgetState extends State<ExploreIconWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeFeedProvider>(builder: (context, provider, child) {
      return InkWell(
        onTap: () async {
          if (provider.selectedProfileType ==
              ProfileType.FAMELinks) {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Ambassadors(i: 0)),
            );
            if (result != null) {
              Map map = result;
              FormData formData = FormData.fromMap({
                "challengeId": map['challengeId'],
                "description": map['description'],
                "closeUp": map['closeUp'],
                "medium": map['medium'],
                "long": map['long'],
                "pose1": map['pose1'],
                "pose2": map['pose2'],
                "additional": map['additional'],
                "video": map['video'],
              });
              Api.uploadPost.call(context,
                  method: "media/contest",
                  param: formData, onResponseSuccess: (Map object) {
                var snackBar = SnackBar(
                  content: Text('Uploaded'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            }
          }  else if (provider.selectedProfileType ==
              ProfileType.FUNLinks) {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FunLinksContestantScreen()),
            );
          }
          else if (provider.selectedProfileType ==
              ProfileType.FOLLOWLinks) {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FollowlinkExplore()),
            );
            if (result != null) {
              Map map = result;
              FormData formData = FormData.fromMap({
                "challengeId": map['challengeId'],
                "description": map['description'],
                "closeUp": map['closeUp'],
                "medium": map['medium'],
                "long": map['long'],
                "pose1": map['pose1'],
                "pose2": map['pose2'],
                "additional": map['additional'],
                "video": map['video'],
                "musicName": map['musicName'],
              });
              Api.uploadPost.call(context,
                  method: "media/contest",
                  param: formData, onResponseSuccess: (Map object) {
                var snackBar = SnackBar(
                  content: Text('Uploaded'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            }
          } else {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Ambassadors(i: 0)),
            );
            if (result != null) {
              Map map = result;
              FormData formData = FormData.fromMap({
                "challengeId": map['challengeId'],
                "description": map['description'],
                "closeUp": map['closeUp'],
                "medium": map['medium'],
                "long": map['long'],
                "pose1": map['pose1'],
                "pose2": map['pose2'],
                "additional": map['additional'],
                "video": map['video'],
              });
              Api.uploadPost.call(context,
                  method: "media/contest",
                  param: formData, onResponseSuccess: (Map object) {
                showSnackBar(
                    context: context, message: "Uploaded", isError: false);
              });
            }
          }
        },
        child: Container(
          margin: EdgeInsets.only(
            bottom: ScreenUtil().setHeight(8),
          ),
          decoration: BoxDecoration(
              gradient: Constants.glassGradient,
              boxShadow: [
                BoxShadow(
                  blurRadius: 7.0,
                  color: black.withOpacity(0.2),
                  offset: Offset(2.0, 2.0),
                ),
              ],
              border: Border.all(
                color: white.withOpacity(0.50),
                width: 1,
              ),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(5))),
          child: Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(8),
                right: ScreenUtil().setWidth(8),
                bottom: ScreenUtil().setHeight(8),
                top: ScreenUtil().setHeight(8)),
            child: SvgPicture.asset(
              "assets/icons/svg/search.svg",
              color: white,
            ),
          ),
        ),
      );
    });
  }
}
