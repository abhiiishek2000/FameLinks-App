import 'package:dotted_border/dotted_border.dart';
import 'package:famelink/ui/Famelinkprofile/AtomPaint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../common/common_image.dart';
import '../../../common/common_routing.dart';
import '../../../networking/config.dart';
import '../../../providers/UserProfileProvider/userProfile_provider.dart';
import '../../../util/config/color.dart';
import '../../../util/constants.dart';
import '../../Famelinkprofile/function/dilerPosition.dart';
import '../../Famelinkprofile/function/famelinkFun.dart';
import '../../Famelinkprofile/widget/profilepicview.dart';
import '../../profile_UI/PhotoImageScreen.dart';
import 'circleButtonImage.dart';


class SelfprofileDilerWhitemode extends StatelessWidget {
  SelfprofileDilerWhitemode({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return Consumer2<FameLinkFun, UserProfileProvider>(
      builder: (context, provider, userProfileData, child) {
        // print("provider.selectPhase $provider.selectPhase");
        // print("provider.selectPhase ${DilerPosition.pos[provider.selectPhase]['top']}");
        // print("provider.selectPhase ${DilerPosition.pos[provider.selectPhase]['bottom']}");
        // print("provider.selectPhase ${DilerPosition.pos[provider.selectPhase]['left']}");
        // print("provider.selectPhase ${DilerPosition.pos[provider.selectPhase]['right']}");
        return Container(
          height: MediaQuery.of(context).size.height * 0.42.h,
          width: MediaQuery.of(context).size.height,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    top: 102.r,
                    left: 98.r,
                    right: 0.r,
                    bottom: 0.r,
                    child: Image.asset(
                      CommonImage.fouricon,
                      width: 100,
                      height: 100,
                    )),
//              child: SvgPicture.asset(CommonImage.fouricon,width: 70,height: 70,color: Colors.red,)),

                AnimatedBuilder(
                    animation: provider.controller!,
                    builder: (context, snapshot) {
                      return Center(
                        child: userProfileData.getIsAnimating == false
                            ? Container()
                            : CustomPaint(
                                painter: AtomPaint(
                                  value: provider.controller!.value,
                                  image: provider.selectPhase == 0
                                      ? provider.fameItems
                                      : provider.selectPhase == 1
                                          ? provider.funItems
                                          : provider.selectPhase == 2
                                              ? provider.followItems
                                              : provider.jobItems,
                                  isAnimating: userProfileData.getIsAnimating,
                                  controller: provider.controller,
                                ),
                              ),
                      );
                    }),

                //blackcer
                // Container(
                //   height: 278.h,
                //   width: 278.w,
                //   child: Image.asset(
                //
                //
                //          "assets/images/home_outer_circle.png",
                //   //  color: Colors.grey,
                //   ),
                // ),
                // id != null
                //     ? Container()
                //     :

                DottedBorder(
                  borderType: BorderType.Circle,
                  color: Colors.grey,
                  strokeWidth: 1, child: Container(
                  decoration:BoxDecoration(
                    shape:BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                     // stops: [0.9, 0.5, 0.7, 0.9],
                      colors: [
                        Color(0xff9D63FC).withOpacity(0.20),
                        Color(0xff00F0FF).withOpacity(0.40),
                        Color(0xff6100FF).withOpacity(0.20),
                        Color(0xff9B9B9B).withOpacity(1),
                      ],
                    ),
                  ) ,
                  height: 240.h,
                  width: 240.w,
                ),
                ),
                
                
                Positioned(
                    top: 20.r,
                    left: 50.r,
                    right: 175.r,
                    bottom: 138.r,
                    child: InkWell(
                      onTap: () {
                        gotoOtherProfileScreen(
                            context,
                            Constants.userType == 'brand'
                                ? provider.myFameResult[0].user![0].sId!
                                : provider
                                    .profileFameLinksModelResult
                                    .result![0]
                                    .masterUser!
                                    .sId!,
                            provider.selectPhase);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RotationTransition(
                              turns:
                                  new AlwaysStoppedAnimation(320 / 371),
                              child: Text(
                                "View Public\nProfile",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              )),
                        ],
                      ),
                    )),

                // top
            userProfileData.getIsAnimating == true
                    ? Container()
                    : Container(
                        child: Positioned(
                          child: provider.selectPhase == 0 || provider.selectPhase == 3
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    provider.selectPhase == 0 || provider.selectPhase == 2
                                        ? Container()
                                        : Container(
                                            height: 17.h,
                                            width: 2.w,
                                            color: Color(0xFF9B9B9B),
                                          ),
                                    circleButtonImageWhitemode(
                                      imgUrl: Constants.userType == 'brand'
                                          ? "assets/icons/store.png"
                                          : (true)
                                              ? Constants.userType == 'agency'
                                                  ? "assets/icons/collaborate.png"
                                                  : "assets/icons/darkFamelinkIcon.png"
                                              : (provider.isDarkMode == true)
                                                  ? Constants.userType ==
                                                          'agency'
                                                      ? "assets/icons/collaborate.png"
                                                      : "assets/icons/darkFamelinkIcon.png"
                                                  : "assets/icons/svg/logo.png",
                                      onTaps: () {
                                        print("\//1");
                                        //    setState(() {
                                        Constants.isReversed =
                                            provider.selectPhase == 2 ? true : false;
                                        if (provider.selectPhase != 0) {
                                          provider.controller!.forward();
                                          userProfileData
                                              .changeIsAnimating(true);
                                          provider.controller!.reset();
                                          provider.controller!.repeat();
                                          Future.delayed(
                                              Duration(milliseconds: 400), () {
                                            Constants.isReversed = false;
                                            userProfileData
                                                .changeIsAnimating(false);
                                            provider.controller!.reset();
                                            provider.controller!.stop();
                                          });
                                        }
                                        provider.selectPhase = 0;

                                        // getFameLinkProfile(widget.id ?? id);
                                        // getFameLinkFeed(provider..profileFameLinksModelResult.result![0].sId, context);
                                      },
                                      isButtonSelect:
                                          provider.selectPhase == 0 ? true : false,
                                    ),
                                    provider.selectPhase == 1 || provider.selectPhase == 3
                                        ? Container()
                                        : Container(
                                            height: 17.h,
                                            width: 2.w,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  stops: [
                                                    0,
                                                    0.21
                                                  ],
                                                  colors: [
                                                    Color(0XffFFA88C),
                                                    Color(0XffFF5C28),
                                                  ]),
                                            ),
                                          ),
                                  ],
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    provider.selectPhase == 1 || provider.selectPhase == 3
                                        ? Container()
                                        : Container(
                                            height: 2.h,
                                            width: 25.w,
                                            color: Color(0xFF9B9B9B),
                                          ),
                                    circleButtonImageWhitemode(
                                      imgUrl: Constants.userType == 'brand'
                                          ? "assets/icons/store.png"
                                          : (true)
                                              ? "assets/icons/darkFamelinkIcon.png"
                                              : (provider.isDarkMode == true)
                                                  ? "assets/icons/darkFamelinkIcon.png"
                                                  : "assets/icons/logo.png",
                                      onTaps: () {
                                        print("\//2");
                                        //   setState(() {
                                        Constants.isReversed =
                                            provider.selectPhase == 2 ? true : false;
                                        if (provider.selectPhase != 0) {
                                          provider.controller!.forward();
                                          userProfileData
                                              .changeIsAnimating(true);
                                          provider.controller!.reset();
                                          provider.controller!.repeat();
                                          Future.delayed(
                                              Duration(milliseconds: 400), () {
                                            Constants.isReversed = false;
                                            userProfileData
                                                .changeIsAnimating(false);
                                            provider.controller!.reset();
                                            provider.controller!.stop();
                                          });
                                        }
                                        provider.selectPhase = 0;
                                        // getFameLinkProfile(widget.id ?? id);
                                        // getFameLinkFeed(provider..profileFameLinksModelResult.result![0].sId, context);
                                        // });
                                      },
                                      isButtonSelect:
                                          provider.selectPhase == 0 ? true : false,
                                    ),
                                    provider.selectPhase == 2 || provider.selectPhase == 0
                                        ? Container()
                                        : Container(
                                            height: 2.h,
                                            width: 25.w,
                                            color: Color(0xFF9B9B9B),
                                          ),
                                  ],
                                ),
                          top: provider.selectPhase == 3
                              ? DilerPosition.pos[provider.selectPhase]['top'].toDouble()
                              : 0.r,
                          left: provider.selectPhase == 2
                              ? DilerPosition.pos[provider.selectPhase]['left']
                                  .toDouble()
                              : 0.r,
                          right: provider.selectPhase == 1
                              ? DilerPosition.pos[provider.selectPhase]['right']
                                  .toDouble()
                              : 0.r,
                          bottom: provider.selectPhase == 0
                              ? DilerPosition.pos[provider.selectPhase]['bottom']
                                  .toDouble()
                              : 0.r,
                        ),
                      ),

                // left
            userProfileData.getIsAnimating == true
                    ? Container()
                    : Container(
                        // child: PositionedTransition(
                        //           rect: followtransition.animate(CurvedAnimation(
                        //               parent: provider.controller,
                        //               curve: Curves.easeInOut,
                        //             )),
                        // child: ConstrainedBox(
                        //   constraints: BoxConstraints(maxWidth: 100, maxHeight: 100),
                        child: Positioned(
                          child: provider.selectPhase == 0 || provider.selectPhase == 3
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    provider.selectPhase == 0 || provider.selectPhase == 2
                                        ? Container()
                                        : Container(
                                            width: 25.w,
                                            height: 2.h,
                                            color: Color(0xFF9B9B9B),
                                          ),
                                    circleButtonImageWhitemode(
                                      isButtonSelect:
                                          provider.selectPhase == 2 ? true : false,
                                      imgUrl: (provider.isDarkMode == true)
                                          ? CommonImage.dark_follower_icon
                                          : "assets/icons/followLinks.png",
                                      onTaps: () {
                                        print("\//3");
                                        //   setState(() {
                                        Constants.isReversed =
                                            provider.selectPhase == 3 ? true : false;
                                        if (provider.selectPhase != 2) {
                                          provider.controller!.forward();
                                          userProfileData
                                              .changeIsAnimating(true);
                                          provider.controller!.reset();
                                          provider.controller!.repeat();
                                          Future.delayed(
                                              Duration(milliseconds: 400), () {
                                            Constants.isReversed = false;
                                            userProfileData
                                                .changeIsAnimating(false);
                                            provider.controller!.reset();
                                            provider.controller!.stop();
                                          });
                                        }
                                        provider.selectPhase = 2;

                                        // getFollowLinkProfile(widget.id ?? id);
                                        // });
                                      },
                                    ),
                                    provider.selectPhase == 1 || provider.selectPhase == 3
                                        ? Container()
                                        : Container(
                                            width: 25.w,
                                            height: 2.h,
                                            color: Color(0xFF9B9B9B),
                                          ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    provider.selectPhase == 0 || provider.selectPhase == 2
                                        ? Container()
                                        : Container(
                                            width: 2.w,
                                            height: 17.h,
                                            color: Color(0xff9B9B9B),
                                          ),
                                    circleButtonImageWhitemode(
                                      isButtonSelect:
                                          provider.selectPhase == 2 ? true : false,
                                      imgUrl: (provider.isDarkMode == true)
                                          ? CommonImage.dark_follower_icon
                                          : "assets/icons/followLinks.png",
                                      onTaps: () {
                                        print("\//4");
                                        //  setState(() {
                                        Constants.isReversed =
                                            provider.selectPhase == 3 ? true : false;
                                        if (provider.selectPhase != 2) {
                                          provider.controller!.forward();
                                          userProfileData
                                              .changeIsAnimating(false);
                                          provider.controller!.reset();
                                          provider.controller!.repeat();
                                          Future.delayed(
                                              Duration(milliseconds: 400), () {
                                            Constants.isReversed = false;
                                            userProfileData
                                                .changeIsAnimating(true);
                                            provider.controller!.reset();
                                            provider.controller!.stop();
                                          });
                                        }
                                        provider.selectPhase = 2;

                                        // getFollowLinkProfile(widget.id ?? id);
                                        //   });
                                      },
                                    ),
                                    provider.selectPhase == 1 || provider.selectPhase == 3
                                        ? Container()
                                        : Container(
                                            width: 2.w,
                                            height: 17.h,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  stops: [
                                                    0,
                                                    0.21
                                                  ],
                                                  colors: [
                                                    Color(0XffFFA88C),
                                                    Color(0XffFF5C28),
                                                  ]),
                                            ),
                                          ),
                                  ],
                                ),
                          top: provider.selectPhase == 1
                              ? DilerPosition.pos[provider.selectPhase]['top'].toDouble()
                              : 0.r,
                          left: provider.selectPhase == 3
                              ? DilerPosition.pos[provider.selectPhase]['left']
                                  .toDouble()
                              : 0.r,
                          right: provider.selectPhase == 0
                              ? DilerPosition.pos[provider.selectPhase]['right']
                                  .toDouble()
                              : 0.r,
                          bottom: provider.selectPhase == 2
                              ? DilerPosition.pos[provider.selectPhase]['bottom']
                                  .toDouble()
                              : 0.r,
                        ),
                      ),

                // right
            userProfileData.getIsAnimating == true
                    ? Container()
                    : Container(
                        child: Positioned(
                          child: provider.selectPhase == 0 || provider.selectPhase == 3
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    provider.selectPhase == 1 || provider.selectPhase == 3
                                        ? Container()
                                        : Container(
                                            width: 25.w,
                                            height: 2.h,
                                            color: Color(0xFF9B9B9B),
                                          ),
                                    circleButtonImageWhitemode(
                                      isButtonSelect:
                                          provider.selectPhase == 1 ? true : false,
                                      imgUrl: (provider.isDarkMode == true)
                                          ? CommonImage.dark_videoLink_icon
                                          : "assets/icons/funLinks.png",
                                      onTaps: () {
                                        print("\//5");
                                        //   setState(() {
                                        Constants.isReversed =
                                            provider.selectPhase == 0 ? true : false;

                                        if (provider.selectPhase != 1) {
                                          provider.controller!.forward();
                                          userProfileData
                                              .changeIsAnimating(true);
                                          provider.controller!.reset();
                                          provider.controller!.repeat();
                                          Future.delayed(
                                              Duration(milliseconds: 400), () {
                                            Constants.isReversed = false;
                                            userProfileData
                                                .changeIsAnimating(false);
                                            provider.controller!.reset();
                                            provider.controller!.stop();
                                          });
                                        }
                                        provider.selectPhase = 1;
                                        // getFunLinkProfile(widget.id ?? id);
                                        // getFunLinkFeed(provider.profileFunLinksList[0].sId);
                                        // });
                                      },
                                    ),
                                    provider.selectPhase == 0 || provider.selectPhase == 2
                                        ? Container()
                                        : Container(
                                            width: 25.w,
                                            height: 2.h,
                                            color: Color(0xFF9B9B9B),
                                          ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    provider.selectPhase == 1 || provider.selectPhase == 3
                                        ? Container()
                                        : Container(
                                            width: 2.w,
                                            height: 17.h,
                                            color: Color(0xFF9B9B9B),
                                          ),
                                    circleButtonImageWhitemode(
                                      isButtonSelect:
                                          provider.selectPhase == 1 ? true : false,
                                      imgUrl: (provider.isDarkMode == true)
                                          ? CommonImage.dark_videoLink_icon
                                          : "assets/icons/funLinks.png",
                                      onTaps: () {
                                            print("\//6");
                                        // setState(() {
                                        Constants.isReversed =
                                            provider.selectPhase == 0 ? true : false;
                                        if (provider.selectPhase != 1) {
                                          provider.controller!.forward();
                                          userProfileData
                                              .changeIsAnimating(true);
                                          provider.controller!.reset();
                                          provider.controller!.repeat();
                                          Future.delayed(
                                              Duration(milliseconds: 400), () {
                                            Constants.isReversed = false;
                                            userProfileData
                                                .changeIsAnimating(false);
                                            provider.controller!.reset();
                                            provider.controller!.stop();
                                          });
                                        }
                                        provider.selectPhase = 1;
                                        // getFunLinkProfile(widget.id ?? id);
                                        // getFunLinkFeed(provider.profileFunLinksList[0].sId);
                                        // });
                                      },
                                    ),
                                    provider.selectPhase == 0 || provider.selectPhase == 2
                                        ? Container()
                                        : Container(
                                            width: 2.w,
                                            height: 17.h,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  stops: [
                                                    0,
                                                    0.21
                                                  ],
                                                  colors: [
                                                    Color(0XffFFA88C),
                                                    Color(0XffFF5C28),
                                                  ]),
                                            ),
                                          ),
                                  ],
                                ),
                          top: provider.selectPhase == 2
                              ? DilerPosition.pos[provider.selectPhase]['top'].toDouble()
                              : 0.r,
                          left: provider.selectPhase == 0
                              ? DilerPosition.pos[provider.selectPhase]['left']
                                  .toDouble()
                              : 0.r,
                          right: provider.selectPhase == 3
                              ? DilerPosition.pos[provider.selectPhase]['right']
                                  .toDouble()
                              : 0.r,
                          bottom: provider.selectPhase == 1
                              ? DilerPosition.pos[provider.selectPhase]['bottom']
                                  .toDouble()
                              : 0.r,
                        ),
                      ),

                // bottom
            userProfileData.getIsAnimating == true
                    ? Container()
                    : Container(
                        child: Positioned(
                          child: provider.selectPhase == 0 || provider.selectPhase == 3
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    provider.selectPhase == 1 || provider.selectPhase == 3
                                        ? Container()
                                        : Container(
                                            height: 17.h,
                                            width: 2.w,
                                            color: Color(0xFF9B9B9B),
                                          ),
                                    circleButtonImageWhitemode(
                                      isButtonSelect:
                                          provider.selectPhase == 3 ? true : false,
                                      onTaps: () {
                                        print("\//7");
                                        //    setState(() {
                                        Constants.isReversed =
                                            provider.selectPhase == 1 ? true : false;
                                        if (provider.selectPhase != 3) {
                                          provider.controller!.forward();
                                          userProfileData
                                              .changeIsAnimating(true);
                                          provider.controller!.reset();
                                          provider.controller!.repeat();
                                          Future.delayed(
                                              Duration(milliseconds: 400), () {
                                            Constants.isReversed = false;
                                            userProfileData
                                                .changeIsAnimating(false);
                                            provider.controller!.reset();
                                            provider.controller!.stop();
                                          });
                                        }
                                        provider.selectPhase = 3;
                                        // });
                                      },
                                      imgUrl: (provider.isDarkMode == true)
                                          ? CommonImage.dark_jobLink_icon
                                          : "assets/icons/vector.png",
                                    ),
                                    provider.selectPhase == 0 || provider.selectPhase == 2
                                        ? Container()
                                        : Container(
                                            height: 17.h,
                                            width: 2.w,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  stops: [
                                                    0,
                                                    0.21
                                                  ],
                                                  colors: [
                                                    Color(0XffFFA88C),
                                                    Color(0XffFF5C28),
                                                  ]),
                                            ),
                                          ),
                                  ],
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    provider.selectPhase == 0 || provider.selectPhase == 2
                                        ? Container()
                                        : Container(
                                            height: 2.h,
                                            width: 25.w,
                                            color: Color(0xFF9B9B9B),
                                          ),
                                    circleButtonImageWhitemode(
                                      isButtonSelect:
                                          provider.selectPhase == 3 ? true : false,
                                      onTaps: () {
                                        print("\//8");
                                        //  setState(() {
                                        Constants.isReversed =
                                            provider.selectPhase == 1 ? true : false;
                                        if (provider.selectPhase != 3) {
                                          provider.controller!.forward();
                                          userProfileData
                                              .changeIsAnimating(true);
                                          provider.controller!.reset();
                                          provider.controller!.repeat();
                                          Future.delayed(
                                              Duration(milliseconds: 400), () {
                                            Constants.isReversed = false;
                                            userProfileData
                                                .changeIsAnimating(false);
                                            provider.controller!.reset();
                                            provider.controller!.stop();
                                          });
                                        }
                                        provider.selectPhase = 3;
                                        //  });
                                      },
                                      imgUrl: (provider.isDarkMode == true)
                                          ? CommonImage.dark_jobLink_icon
                                          : "assets/icons/vector.png",
                                    ),
                                    provider.selectPhase == 1 || provider.selectPhase == 3
                                        ? Container()
                                        : Container(
                                            height: 2.h,
                                            width: 25.w,
                                            color: Color(0xFF9B9B9B),
                                          ),
                                  ],
                                ),
                          top: provider.selectPhase == 0
                              ? DilerPosition.pos[provider.selectPhase]['top'].toDouble()
                              : 0.r,
                          left: provider.selectPhase == 1
                              ? DilerPosition.pos[provider.selectPhase]['left']
                                  .toDouble()
                              : 0.r,
                          right: provider.selectPhase == 2
                              ? DilerPosition.pos[provider.selectPhase]['right']
                                  .toDouble()
                              : 0.r,
                          bottom: provider.selectPhase == 3
                              ? DilerPosition.pos[provider.selectPhase]['bottom']
                                  .toDouble()
                              : 0.r,
                          // right: MediaQuery.of(context).size.width/2,
                        ),
                      ),
                Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Stack(
                    // overflow: Overflow.visible,
                    fit: StackFit.loose,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 140.h,
                        width: 140.w,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: Image.asset((provider.isDarkMode == true)
                            ? CommonImage.dark_inner_circle_icon
                            : "assets/images/home_inner_circle.png"),
                      ),
                      InkWell(
                          onTap: () {
                            print("profile click");
                            // setState(() {
                            if (id == null) {
                            } else {
                              if (provider.selectPhase == 0) {
                                if (Constants.userType == 'brand') {
                                  showDialog(
                                      context: context,
                                      barrierColor:
                                      Colors.black.withOpacity(0.5),
                                      // Background color
                                      // barrierDismissible: false,
                                      builder:
                                          (BuildContext buildContext) {
                                        return ProfilepicView(avatar: "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider..profileFameLinksModelResult.result![0].profileImage}", image:  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider..profileFameLinksModelResult.result![0].profileImage}", type: provider
                                            .profileFameLinksModelResult
                                            .result![0]
                                            .profileImageType.toString(), selectPhase: provider.selectPhase,);
                                      });
                                } else {
                                  if (provider
                                      .profileFameLinksModelResult
                                      .result!
                                      .length !=
                                      0) {
                                    if (provider
                                        .profileFameLinksModelResult
                                        .result![0]
                                        .profileImageType ==
                                        '') {
                                      if (provider.avtarImage == null &&
                                          provider.profileImage == null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PhotoImageScreen(
                                                  getRunScreen: 'editProfileImage',
                                                  runtypes: provider.selectPhase.toString(),
                                                ),
                                          ),
                                        );
                                      } else {
                                        showDialog(
                                            context: context,
                                            barrierColor:
                                            Colors.black.withOpacity(0.5),
                                            // Background color
                                            // barrierDismissible: false,
                                            builder:
                                                (BuildContext buildContext) {
                                              return ProfilepicView(avatar: "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider..profileFameLinksModelResult.result![0].profileImage}", image:  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider..profileFameLinksModelResult.result![0].profileImage}", type: provider.
                                                  profileFameLinksModelResult
                                                  .result![0]
                                                  .profileImageType.toString(), selectPhase: provider.selectPhase,);
                                            });
                                      }
                                    } else {
                                      if (provider.
                                          profileFameLinksModelResult
                                          .result![0]
                                          .profileImageType ==
                                          'avatar' ||
                                          provider.
                                              profileFameLinksModelResult
                                              .result![0]
                                              .profileImageType ==
                                              'image') {
                                        showDialog(
                                            context: context,
                                            barrierColor:
                                            Colors.black.withOpacity(0.5),
                                            // Background color
                                            // barrierDismissible: false,
                                            builder:
                                                (BuildContext buildContext) {
                                              return ProfilepicView(avatar: "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider..profileFameLinksModelResult.result![0].profileImage}", image:  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider..profileFameLinksModelResult.result![0].profileImage}", type: provider.
                                                 profileFameLinksModelResult
                                                  .result![0]
                                                  .profileImageType.toString(), selectPhase: provider.selectPhase,);
                                            });
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PhotoImageScreen(
                                                  getRunScreen: 'editProfileImage',
                                                  runtypes: provider.selectPhase.toString(),
                                                ),
                                          ),
                                        );
                                      }
                                    }
                                  }
                                }
                              } else if (provider.selectPhase == 1) {
                                if (provider.profileFunLinksList.length != 0) {
                                  if (provider.profileFunLinksList[0].profileImageType ==
                                      '') {
                                    if (provider.avtarImage == null &&
                                        provider.profileImage == null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PhotoImageScreen(
                                                getRunScreen: 'editProfileImage',
                                                runtypes: provider.selectPhase.toString(),
                                              ),
                                        ),
                                      );
                                    } else {
                                      showDialog(
                                          context: context,
                                          barrierColor:
                                          Colors.black.withOpacity(0.5),
                                          // Background color
                                          // barrierDismissible: false,
                                          builder: (BuildContext buildContext) {
                                            return ProfilepicView(avatar: "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFunLinksList[0].profileImage}", image:  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFunLinksList[0].profileImage}", type: provider.profileFunLinksList[0].profileImageType.toString(), selectPhase: provider.selectPhase,);
                                          });
                                    }
                                  } else {
                                    if (provider.profileFunLinksList[0]
                                        .profileImageType ==
                                        'avatar' ||
                                        provider.profileFunLinksList[0]
                                            .profileImageType ==
                                            'image') {
                                      showDialog(
                                          context: context,
                                          barrierColor:
                                          Colors.black.withOpacity(0.5),
                                          // Background color
                                          // barrierDismissible: false,
                                          builder: (BuildContext buildContext) {
                                            return  ProfilepicView(avatar: "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFunLinksList[0].profileImage}", image:  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFunLinksList[0].profileImage}", type: provider.profileFunLinksList[0].profileImageType.toString(), selectPhase: provider.selectPhase,); });
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PhotoImageScreen(
                                                getRunScreen: 'editProfileImage',
                                                runtypes: provider.selectPhase.toString(),
                                              ),
                                        ),
                                      );
                                    }
                                  }
                                }
                              } else if (provider.selectPhase == 2) {
                                if (provider.profileFollowLinksList.length != 0) {
                                  if (provider.profileFollowLinksList[0]
                                      .profileImageType ==
                                      '') {
                                    if (provider.avtarImage == null &&
                                        provider.profileImage == null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PhotoImageScreen(
                                                getRunScreen: 'editProfileImage',
                                                runtypes: provider.selectPhase.toString(),
                                              ),
                                        ),
                                      );
                                    } else {
                                      showDialog(
                                          context: context,
                                          barrierColor:
                                          Colors.black.withOpacity(0.5),
                                          // Background color
                                          // barrierDismissible: false,
                                          builder: (BuildContext buildContext) {
                                            return ProfilepicView(avatar: "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFollowLinksList[0].profileImage}", image:  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFollowLinksList[0].profileImage}", type: provider.profileFollowLinksList[0].profileImageType.toString(), selectPhase: provider.selectPhase,);
                                          });
                                    }
                                  } else {
                                    if (provider.profileFollowLinksList[0]
                                        .profileImageType ==
                                        'avatar' ||
                                        provider.profileFollowLinksList[0]
                                            .profileImageType ==
                                            'image') {
                                      showDialog(
                                          context: context,
                                          barrierColor:
                                          Colors.black.withOpacity(0.5),
                                          // Background color
                                          // barrierDismissible: false,
                                          builder: (BuildContext buildContext) {
                                            return ProfilepicView(avatar: "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFollowLinksList[0].profileImage}", image:  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFollowLinksList[0].profileImage}", type: provider.profileFollowLinksList[0].profileImageType.toString(), selectPhase: provider.selectPhase,); });
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PhotoImageScreen(
                                                getRunScreen: 'editProfileImage',
                                                runtypes: provider.selectPhase.toString(),
                                              ),
                                        ),
                                      );
                                    }
                                  }
                                }
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PhotoImageScreen(
                                      getRunScreen: 'editProfileImage',
                                      runtypes: provider.selectPhase.toString(),
                                    ),
                                  ),
                                );
                              }
                            }
                            //  });
                          },
                          child: provider.selectPhase == 0
                              ? Constants.userType == 'brand'
                              ? provider.myFameResult.length == 0
                              ? Container()
                              : provider.myFameResult[0].user![0].profileImageType ==
                              ""
                              ? provider.avtarImage != null
                              ? Container(
                            height: 135.h,
                            width: 135.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle),
                            child: CircleAvatar(
                              backgroundImage:
                              NetworkImage(provider
                                  .avtarImage),
                              backgroundColor:
                              Colors.transparent,
                              radius: 50.r,
                            ),
                          )
                              : provider.profileImage != null
                              ? Container(
                            height: 135.h,
                            width: 135.w,
                            decoration: BoxDecoration(
                                shape:
                                BoxShape.circle),
                            child: CircleAvatar(
                              backgroundImage:
                              NetworkImage(provider
                                  .profileImage),
                              backgroundColor:
                              Colors.transparent,
                              radius: 50.r,
                            ),
                          )
                              : provider.myFameResult[0].user![0].name ==
                              null
                              ? Container(
                            height: 135.h,
                            width: 135.w,
                            decoration:
                            BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment
                                      .topCenter,
                                  end: Alignment
                                      .bottomCenter,
                                  colors: [
                                    lightRedWhite,
                                    lightRed
                                  ]),
                              shape:
                              BoxShape.circle,
                            ),
                          )
                              : Container(
                            height: 135.h,
                            width: 135.w,
                            decoration:
                            BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment
                                      .topCenter,
                                  end: Alignment
                                      .bottomCenter,
                                  colors: [
                                    lightRedWhite,
                                    lightRed
                                  ]),
                              shape:
                              BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                provider.myFameResult[0]
                                    .user![0]
                                    .name![0]
                                    .toString()
                                    .toUpperCase(),
                                textAlign:
                                TextAlign
                                    .center,
                                style: GoogleFonts
                                    .nunitoSans(
                                  fontWeight:
                                  FontWeight
                                      .w700,
                                  color: white,
                                  fontSize:
                                  ScreenUtil()
                                      .setSp(
                                      30),
                                ),
                              ),
                            ),
                          )
                              : Container(
                              height: 135.h,
                              width: 135.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle),
                              child: provider.myFameResult[0]
                                  .user![0]
                                  .profileImageType ==
                                  "avatar"
                                  ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.myFameResult[0].user![0].profileImage}"),
                                backgroundColor:
                                Colors.transparent,
                                radius: 50.r,
                              )
                                  : provider.myFameResult[0]
                                  .user![0]
                                  .profileImageType ==
                                  'image'
                                  ? CircleAvatar(
                                backgroundImage:
                                NetworkImage(
                                    "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.
                                        profileFameLinksModelResult
                                        .result![0]
                                        .profileImage}"),
                                backgroundColor:
                                Colors
                                    .transparent,
                                radius: 50.r,
                              )
                                  : provider.myFameResult[0]
                                  .user![0]
                                  .name ==
                                  null
                                  ? Container(
                                height: 135.h,
                                width: 135.w,
                                decoration:
                                BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment
                                          .topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        lightRedWhite,
                                        lightRed
                                      ]),
                                  shape: BoxShape
                                      .circle,
                                ),
                              )
                                  : Container(
                                height: 135.h,
                                width: 135.w,
                                decoration:
                                BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment
                                          .topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        lightRedWhite,
                                        lightRed
                                      ]),
                                  shape: BoxShape
                                      .circle,
                                ),
                                child: Center(
                                  child: Text(
                                    provider.myFameResult[
                                    0]
                                        .user![0]
                                        .name![0]
                                        .toString()
                                        .toUpperCase(),
                                    textAlign:
                                    TextAlign
                                        .center,
                                    style: GoogleFonts
                                        .nunitoSans(
                                      fontWeight:
                                      FontWeight
                                          .w700,
                                      color:
                                      white,
                                      fontSize: ScreenUtil()
                                          .setSp(
                                          30),
                                    ),
                                  ),
                                ),
                              ))
                              : provider.profileFameLinksModelResult
                              .result!.length ==
                              0
                              ? Container()
                              : provider.
                              profileFameLinksModelResult
                              .result![0]
                              .profileImageType ==
                              ""
                              ? provider.avtarImage != null
                              ? Container(
                            height: 135.h,
                            width: 135.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle),
                            child: CircleAvatar(
                              backgroundImage:
                              NetworkImage(provider
                                  .avtarImage),
                              backgroundColor:
                              Colors.transparent,
                              radius: 50.r,
                            ),
                          )
                              : provider.profileImage != null
                              ? Container(
                            height: 135.h,
                            width: 135.w,
                            decoration: BoxDecoration(
                                shape:
                                BoxShape.circle),
                            child: CircleAvatar(
                              backgroundImage:
                              NetworkImage(provider
                                  .profileImage),
                              backgroundColor:
                              Colors.transparent,
                              radius: 50.r,
                            ),
                          )
                              : provider.
                              profileFameLinksModelResult
                              .result![0]
                              .name ==
                              null
                              ? Container(
                            height: 135.h,
                            width: 135.w,
                            decoration:
                            BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment
                                      .topCenter,
                                  end: Alignment
                                      .bottomCenter,
                                  colors: [
                                    lightRedWhite,
                                    lightRed
                                  ]),
                              shape:
                              BoxShape.circle,
                            ),
                          )
                              : Container(
                            height: 135.h,
                            width: 135.w,
                            decoration:
                            BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment
                                      .topCenter,
                                  end: Alignment
                                      .bottomCenter,
                                  colors: [
                                    lightRedWhite,
                                    lightRed
                                  ]),
                              shape:
                              BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                provider.
                                    profileFameLinksModelResult
                                    .result![0]
                                    .name![0]
                                    .toString()
                                    .toUpperCase(),
                                textAlign:
                                TextAlign
                                    .center,
                                style: GoogleFonts
                                    .nunitoSans(
                                  fontWeight:
                                  FontWeight
                                      .w700,
                                  color: white,
                                  fontSize:
                                  ScreenUtil()
                                      .setSp(
                                      30),
                                ),
                              ),
                            ),
                          )
                              : Container(
                              height: 135.h,
                              width: 135.w,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: provider.profileFameLinksModelResult.result![0].profileImageType == "avatar"
                                  ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFameLinksModelResult.result![0].profileImage}"),
                                backgroundColor:
                                Colors.transparent,
                                radius: 50.r,
                              )
                                  : provider.profileFameLinksModelResult.result![0].profileImageType == 'image'
                                  ? CircleAvatar(
                                backgroundImage:
                                NetworkImage(
                                    "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider..profileFameLinksModelResult.result![0].profileImage}"),
                                backgroundColor:
                                Colors
                                    .transparent,
                                radius: 50.r,
                              )
                                  : provider.profileFameLinksModelResult.result![0].name == null
                                  ? Container(
                                height: 135.h,
                                width: 135.w,
                                decoration:
                                BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment
                                          .topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        lightRedWhite,
                                        lightRed
                                      ]),
                                  shape: BoxShape
                                      .circle,
                                ),
                              )
                                  : Container(
                                height: 135.h,
                                width: 135.w,
                                decoration:
                                BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment
                                          .topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        lightRedWhite,
                                        lightRed
                                      ]),
                                  shape: BoxShape
                                      .circle,
                                ),
                                child: Center(
                                  child: Text(
                                    provider.profileFameLinksModelResult
                                        .result![
                                    0]
                                        .name![0]
                                        .toString()
                                        .toUpperCase(),
                                    textAlign:
                                    TextAlign
                                        .center,
                                    style: GoogleFonts
                                        .nunitoSans(
                                      fontWeight:
                                      FontWeight
                                          .w700,
                                      color:
                                      white,
                                      fontSize: ScreenUtil()
                                          .setSp(
                                          30),
                                    ),
                                  ),
                                ),
                              ))
                              : provider.selectPhase == 1
                              ? provider.profileFunLinksList.length == 0
                              ? Container()
                              : provider.profileFunLinksList[0].profileImageType == ""
                              ? provider.avtarImage != null
                              ? Container(
                            height: 135.h,
                            width: 135.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle),
                            child: CircleAvatar(
                              backgroundImage:
                              NetworkImage(provider
                                  .avtarImage),
                              backgroundColor:
                              Colors.transparent,
                              radius: 50.r,
                            ),
                          )
                              : provider.profileImage != null
                              ? Container(
                            height: 135.h,
                            width: 135.w,
                            decoration: BoxDecoration(
                                shape:
                                BoxShape.circle),
                            child: CircleAvatar(
                              backgroundImage:
                              NetworkImage(provider
                                  .profileImage),
                              backgroundColor:
                              Colors.transparent,
                              radius: 50.r,
                            ),
                          )
                              : provider.profileFunLinksList[0].name == null
                              ? Container(
                            height: 135.h,
                            width: 135.w,
                            decoration:
                            BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment
                                      .topCenter,
                                  end: Alignment
                                      .bottomCenter,
                                  colors: [
                                    lightRedWhite,
                                    lightRed
                                  ]),
                              shape:
                              BoxShape.circle,
                            ),
                          )
                              : Container(
                            height: 135.h,
                            width: 135.w,
                            decoration:
                            BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment
                                      .topCenter,
                                  end: Alignment
                                      .bottomCenter,
                                  colors: [
                                    lightRedWhite,
                                    lightRed
                                  ]),
                              shape:
                              BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                provider.profileFunLinksList[
                                0]
                                    .name![0]
                                    .toString()
                                    .toUpperCase(),
                                textAlign:
                                TextAlign
                                    .center,
                                style: GoogleFonts
                                    .nunitoSans(
                                  fontWeight:
                                  FontWeight
                                      .w700,
                                  color: white,
                                  fontSize:
                                  ScreenUtil()
                                      .setSp(
                                      30),
                                ),
                              ),
                            ),
                          )
                              : Container(
                              height: 135.h,
                              width: 135.w,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: provider.profileFunLinksList[0].profileImageType == "avatar"
                                  ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFunLinksList[0].profileImage}"),
                                backgroundColor:
                                Colors.transparent,
                                radius: 50.r,
                              )
                                  : provider.profileFunLinksList[0].profileImageType == 'image'
                                  ? CircleAvatar(
                                backgroundImage:
                                NetworkImage(
                                    "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFunLinksList[0].profileImage}"),
                                backgroundColor:
                                Colors
                                    .transparent,
                                radius: 50.r,
                              )
                                  : provider.profileFunLinksList[0].name == null
                                  ? Container(
                                height: 135.h,
                                width: 135.w,
                                decoration:
                                BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment
                                          .topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        lightRedWhite,
                                        lightRed
                                      ]),
                                  shape: BoxShape
                                      .circle,
                                ),
                              )
                                  : Container(
                                height: 135.h,
                                width: 135.w,
                                decoration:
                                BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment
                                          .topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        lightRedWhite,
                                        lightRed
                                      ]),
                                  shape: BoxShape
                                      .circle,
                                ),
                                child: Center(
                                  child: Text(
                                    provider.profileFunLinksList[
                                    0]
                                        .name![0]
                                        .toString()
                                        .toUpperCase(),
                                    textAlign:
                                    TextAlign
                                        .center,
                                    style: GoogleFonts
                                        .nunitoSans(
                                      fontWeight:
                                      FontWeight
                                          .w700,
                                      color:
                                      white,
                                      fontSize: ScreenUtil()
                                          .setSp(
                                          30),
                                    ),
                                  ),
                                ),
                              ))
                              : provider.selectPhase == 2
                              ? provider.profileFollowLinksList.length == 0
                              ? Container()
                              : provider.profileFollowLinksList[0].profileImageType == ""
                              ? provider.avtarImage != null
                              ? Container(
                            height: 135.h,
                            width: 135.w,
                            decoration: BoxDecoration(
                                shape:
                                BoxShape.circle),
                            child: CircleAvatar(
                              backgroundImage:
                              NetworkImage(provider
                                  .avtarImage),
                              backgroundColor:
                              Colors.transparent,
                              radius: 50.r,
                            ),
                          )
                              : provider.profileImage != null
                              ? Container(
                            height: 135.h,
                            width: 135.w,
                            decoration:
                            BoxDecoration(
                                shape: BoxShape
                                    .circle),
                            child: CircleAvatar(
                              backgroundImage:
                              NetworkImage(
                                  provider
                                      .profileImage),
                              backgroundColor:
                              Colors
                                  .transparent,
                              radius: 50.r,
                            ),
                          )
                              : provider.profileFollowLinksList[0].name == null
                              ? Container(
                            height: 135.h,
                            width: 135.w,
                            decoration:
                            BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment
                                      .topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    lightRedWhite,
                                    lightRed
                                  ]),
                              shape: BoxShape
                                  .circle,
                            ),
                          )
                              : Container(
                            height: 135.h,
                            width: 135.w,
                            decoration:
                            BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment
                                      .topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    lightRedWhite,
                                    lightRed
                                  ]),
                              shape: BoxShape
                                  .circle,
                            ),
                            child: Center(
                              child: Text(
                                provider.profileFollowLinksList[
                                0]
                                    .name![0]
                                    .toString()
                                    .toUpperCase(),
                                textAlign:
                                TextAlign
                                    .center,
                                style: GoogleFonts
                                    .nunitoSans(
                                  fontWeight:
                                  FontWeight
                                      .w700,
                                  color:
                                  white,
                                  fontSize: ScreenUtil()
                                      .setSp(
                                      30),
                                ),
                              ),
                            ),
                          )
                              : Container(
                              height: 135.h,
                              width: 135.w,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: provider.profileFollowLinksList[0].profileImageType == "avatar"
                                  ? CircleAvatar(
                                backgroundImage:
                                NetworkImage(
                                    "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFollowLinksList[0].profileImage}"),
                                backgroundColor:
                                Colors
                                    .transparent,
                                radius: 50.r,
                              )
                                  : provider.profileFollowLinksList[0].profileImageType == 'image'
                                  ? CircleAvatar(
                                backgroundImage:
                                NetworkImage(
                                    "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFollowLinksList[0].profileImage}"),
                                backgroundColor:
                                Colors
                                    .transparent,
                                radius: 50.r,
                              )
                                  : provider.profileFollowLinksList[0].name == null
                                  ? Container(
                                height: 135.h,
                                width: 135.w,
                                decoration:
                                BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment
                                          .topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        lightRedWhite,
                                        lightRed
                                      ]),
                                  shape: BoxShape
                                      .circle,
                                ),
                              )
                                  : Container(
                                height: 135.h,
                                width: 135.w,
                                decoration:
                                BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment
                                          .topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        lightRedWhite,
                                        lightRed
                                      ]),
                                  shape: BoxShape
                                      .circle,
                                ),
                                child: Center(
                                  child: Text(
                                    provider.profileFollowLinksList[
                                    0]
                                        .name![
                                    0]
                                        .toString()
                                        .toUpperCase(),
                                    textAlign:
                                    TextAlign
                                        .center,
                                    style: GoogleFonts
                                        .nunitoSans(
                                      fontWeight:
                                      FontWeight.w700,
                                      color:
                                      white,
                                      fontSize:
                                      ScreenUtil().setSp(30),
                                    ),
                                  ),
                                ),
                              ))
                              : Container(
                            height: 135.h,
                            width: 135.w,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    lightRedWhite,
                                    lightRed
                                  ]),
                              shape: BoxShape.circle,
                            ),
                          )),
                    ],
                  ),
                ),

                Positioned(
                    top: 20.r,
                    left: MediaQuery.of(context).size.width - 128.w,
                    // right: MediaQuery.of(context).size.width - 295.w,
                    bottom: 153.r,
                    child: Container(
                      child: Column(
                        children: [
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Share.share(
                                '"Hey buddy,\nI am on BudLinks App, where we can participate in Worldwide Beauty Contests, right from the comfort of our homes. I recommend you too to download and join me on FameLinks.\n${ApiProvider.shareUrl}profile/agency/${id}',
                              );
                            },
                            child: Image.asset(
                              'assets/icons/share.png',
                              color: Colors.black,
                              height: 22.h,
                              width: 22.w,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    )),
                // id != null
                //     ? Container()
                //     :
                Positioned(
                    top: 120.r,
                    right: MediaQuery.of(context).size.width - 128.w,
                    // right: 200.r,
                    bottom: 2.r,
                    child: Container(
                      child: Column(
                        children: [
                          Spacer(),
                          InkWell(
                            onTap: () {
                              print('FameLinks');
                              userProfileData.changeIsDrawerOpen(
                                  !Provider.of<UserProfileProvider>(context,
                                          listen: false)
                                      .getIsDrawerOpen);
                              if (Provider.of<UserProfileProvider>(context,
                                          listen: false)
                                      .isDrawerOpen ==
                                  true) {
                                print(true);
                                provider.animacon.forward();
                              } else {
                                print(false);
                                provider.animacon.reverse();
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                  'assets/icons/svg/settings.svg',
                                  fit: BoxFit.fill,
                                  height: 22.h,
                                  width: 22.w,
                                  color: Colors.black),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
