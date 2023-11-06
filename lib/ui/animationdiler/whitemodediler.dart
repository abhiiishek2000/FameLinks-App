import 'dart:math' as math;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../common/common_image.dart';
import '../../networking/config.dart';
import '../../providers/UserProfileProvider/userProfile_provider.dart';
import '../../share/firebasedynamiclink.dart';
import '../../util/config/color.dart';
import '../Famelinkprofile/function/famelinkFun.dart';
import '../Famelinkprofile/widget/ProfilePicView.dart';
import '../FamelinkprofileWhitemode/widget/circleButtonImage.dart';
import '../otherUserProfile/OthersProfile.dart';
import '../profile_UI/PhotoImageScreen.dart';
import 'animationprovider.dart';

class AnimationPageWhite extends StatefulWidget {
  _AnimationPageWhiteState createState() => _AnimationPageWhiteState();
}

class _AnimationPageWhiteState extends State<AnimationPageWhite>
    with TickerProviderStateMixin {
  Animaruinprovider? pro;

  @override
  void initState() {
    super.initState();

    pro = Provider.of<Animaruinprovider>(context, listen: false);

    animationtime();

    pro!.intslize();
  }

  animationtime() {
    pro!.animController = AnimationController(
      duration: Duration(milliseconds: pro!.antime),
      vsync: this,
    );
    pro!.animControllerbud0 = AnimationController(
      duration: Duration(milliseconds: pro!.antime),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height * 0.45.h,
      // width: MediaQuery.of(context).size.height,
      child: Center(
        child: Consumer3<FameLinkFun, UserProfileProvider, Animaruinprovider>(
          builder: (context, provider, userProfileData, animationpro, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                DottedBorder(
                  padding: EdgeInsets.all(0),
                  borderType: BorderType.Circle,
                  color: Colors.grey,
                  // strokeWidth: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
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
                    ),
                    height: 240.h,
                    width: 240.w,
                  ),
                ),
                Positioned(
                    top: 98.r,
                    left: 93.r,
                    right: 0.r,
                    bottom: 0.r,
                    child: Image.asset(
                      CommonImage.fouricon,
                      width: 100,
                      height: 100,
                    )),
                Positioned(
                    top: 120.r,
                    right: MediaQuery.of(context).size.width - 128.w,
                    // right: 200.r,
                    bottom: 2.r,
                    child: Container(
                      child: Column(
                        children: [
                          Spacer(),
                          SizedBox(
                            height: 40.h,
                            width: 40.w,
                            child: InkWell(
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
                          ),
                          Spacer(),
                        ],
                      ),
                    )),
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
                              print("share click");
                              String? name;
                              if (provider.selectPhase == 0) {
                                name = "otherprofilefame";
                              } else if (provider.selectPhase == 1) {
                                name = "otherprofilefun";
                              } else {
                                name = "otherprofilefollow";
                              }
                              Sharedynamic.shareprofile(
                                  provider.profileFameLinksModelResult
                                      .result![0].masterUser!.sId!,
                                  name,
                                  provider.profileFameLinksModelResult
                                      .result![0].name!
                                      .toString());
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
                Positioned(
                    top: 10.r,
                    left: 50.r,
                    right: 175.r,
                    bottom: 142.r,
                    child: Container(
                      // color: Colors.black,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RotationTransition(
                              turns: new AlwaysStoppedAnimation(320 / 371),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OtherProfile(
                                        id: ApiProvider.userType == 'brand'
                                            ? provider
                                                .myFameResult[0].user![0].sId!
                                            : provider
                                                .profileFameLinksModelResult
                                                .result![0]
                                                .masterUser!
                                                .sId!,
                                        selectPhase: provider.selectPhase,
                                        sayhi: "show",
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Compact View",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              )),
                        ],
                      ),
                    )),
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

                            if (provider.selectPhase == 0) {
                              if (ApiProvider.userType == 'brand') {
                                showDialog(
                                    context: context,
                                    barrierColor: Colors.black.withOpacity(0.5),
                                    // Background color
                                    // barrierDismissible: false,
                                    builder: (BuildContext buildContext) {
                                      return ProfilePicView(
                                        avatar:
                                            "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFameLinksModelResult.result![0].profileImage}",
                                        image:
                                            "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFameLinksModelResult.result![0].profileImage}",
                                        type: provider
                                            .profileFameLinksModelResult
                                            .result![0]
                                            .profileImageType
                                            .toString(),
                                        selectPhase: provider.selectPhase,
                                      );
                                    });
                              } else {
                                if (provider.profileFameLinksModelResult.result!
                                        .length !=
                                    0) {
                                  if (provider.profileFameLinksModelResult
                                          .result![0].profileImageType ==
                                      '') {
                                    if (provider.avtarImage == null &&
                                        provider.profileImage == null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PhotoImageScreen(
                                            getRunScreen: 'editProfileImage',
                                            runtypes:
                                                provider.selectPhase.toString(),
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
                                            return ProfilePicView(
                                              avatar:
                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFameLinksModelResult.result![0].profileImage}",
                                              image:
                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFameLinksModelResult.result![0].profileImage}",
                                              type: provider
                                                  .profileFameLinksModelResult
                                                  .result![0]
                                                  .profileImageType
                                                  .toString(),
                                              selectPhase: provider.selectPhase,
                                            );
                                          });
                                    }
                                  } else {
                                    if (provider.profileFameLinksModelResult
                                                .result![0].profileImageType ==
                                            'avatar' ||
                                        provider.profileFameLinksModelResult
                                                .result![0].profileImageType ==
                                            'image') {
                                      showDialog(
                                          context: context,
                                          barrierColor:
                                              Colors.black.withOpacity(0.5),
                                          // Background color
                                          // barrierDismissible: false,
                                          builder: (BuildContext buildContext) {
                                            return ProfilePicView(
                                              avatar:
                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFameLinksModelResult.result![0].profileImage}",
                                              image:
                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFameLinksModelResult.result![0].profileImage}",
                                              type: provider
                                                  .profileFameLinksModelResult
                                                  .result![0]
                                                  .profileImageType
                                                  .toString(),
                                              selectPhase: provider.selectPhase,
                                            );
                                          });
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PhotoImageScreen(
                                            getRunScreen: 'editProfileImage',
                                            runtypes:
                                                provider.selectPhase.toString(),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                }
                              }
                            } else if (provider.selectPhase == 1) {
                              if (provider.profileFunLinksList.length != 0) {
                                if (provider.profileFunLinksList[0]
                                        .profileImageType ==
                                    '') {
                                  if (provider.avtarImage == null &&
                                      provider.profileImage == null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PhotoImageScreen(
                                          getRunScreen: 'editProfileImage',
                                          runtypes:
                                              provider.selectPhase.toString(),
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
                                          return ProfilePicView(
                                            avatar:
                                                "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFunLinksList[0].profileImage}",
                                            image:
                                                "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFunLinksList[0].profileImage}",
                                            type: provider
                                                .profileFunLinksList[0]
                                                .profileImageType
                                                .toString(),
                                            selectPhase: provider.selectPhase,
                                          );
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
                                          return ProfilePicView(
                                            avatar:
                                                "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFunLinksList[0].profileImage}",
                                            image:
                                                "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFunLinksList[0].profileImage}",
                                            type: provider
                                                .profileFunLinksList[0]
                                                .profileImageType
                                                .toString(),
                                            selectPhase: provider.selectPhase,
                                          );
                                        });
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PhotoImageScreen(
                                          getRunScreen: 'editProfileImage',
                                          runtypes:
                                              provider.selectPhase.toString(),
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
                                        builder: (context) => PhotoImageScreen(
                                          getRunScreen: 'editProfileImage',
                                          runtypes:
                                              provider.selectPhase.toString(),
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
                                          return ProfilePicView(
                                            avatar:
                                                "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFollowLinksList[0].profileImage}",
                                            image:
                                                "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFollowLinksList[0].profileImage}",
                                            type: provider
                                                .profileFollowLinksList[0]
                                                .profileImageType
                                                .toString(),
                                            selectPhase: provider.selectPhase,
                                          );
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
                                          return ProfilePicView(
                                            avatar:
                                                "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFollowLinksList[0].profileImage}",
                                            image:
                                                "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFollowLinksList[0].profileImage}",
                                            type: provider
                                                .profileFollowLinksList[0]
                                                .profileImageType
                                                .toString(),
                                            selectPhase: provider.selectPhase,
                                          );
                                        });
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PhotoImageScreen(
                                          getRunScreen: 'editProfileImage',
                                          runtypes:
                                              provider.selectPhase.toString(),
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

                            //  });
                          },
                          child: provider.selectPhase == 0
                              ? ApiProvider.userType == 'brand'
                                  ? provider.myFameResult.length == 0
                                      ? Container()
                                      : provider.myFameResult[0].user![0]
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
                                                        Color(0xffface0c),
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
                                                  : provider.myFameResult[0]
                                                              .user![0].name ==
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
                                                              provider
                                                                  .myFameResult[
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
                                                                color: black,
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
                                              child: provider
                                                          .myFameResult[0]
                                                          .user![0]
                                                          .profileImageType ==
                                                      "avatar"
                                                  ? CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.myFameResult[0].user![0].profileImage}"),
                                                      backgroundColor:
                                                          Color(0xffface0c),
                                                      radius: 50.r,
                                                    )
                                                  : provider
                                                              .myFameResult[0]
                                                              .user![0]
                                                              .profileImageType ==
                                                          'image'
                                                      ? CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFameLinksModelResult.result![0].profileImage}"),
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          radius: 50.r,
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
                                                                  provider
                                                                      .myFameResult[
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
                                                                        black,
                                                                    fontSize: ScreenUtil()
                                                                        .setSp(
                                                                            30),
                                                                  ),
                                                                ),
                                                              ),
                                                            ))
                                  : provider.profileFameLinksModelResult.result!
                                              .length ==
                                          0
                                      ? Container()
                                      : provider
                                                  .profileFameLinksModelResult
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
                                                        Color(0xffface0c),
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
                                                  : provider.profileFameLinksModelResult
                                                              .result![0].name ==
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
                                                              provider
                                                                  .profileFameLinksModelResult
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
                                                                color: black,
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
                                                          Color(0xffface0c),
                                                      radius: 50.r,
                                                    )
                                                  : provider.profileFameLinksModelResult.result![0].profileImageType == 'image'
                                                      ? CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFameLinksModelResult.result![0].profileImage}"),
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
                                                                  provider
                                                                      .profileFameLinksModelResult
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
                                                                        black,
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
                                                        Color(0xffface0c),
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
                                                              provider
                                                                  .profileFunLinksList[
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
                                                                color: black,
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
                                                          Color(0xffface0c),
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
                                                                  provider
                                                                      .profileFunLinksList[
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
                                                                        black,
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
                                                            Color(0xffface0c),
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
                                                                  provider
                                                                      .profileFollowLinksList[
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
                                                                        black,
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
                                                              Color(0xffface0c),
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
                                                                      provider
                                                                          .profileFollowLinksList[
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
                                                                            black,
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
                Container(
                  margin: EdgeInsets.only(bottom: 300.h),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: animationpro.a == 0
                                ? ApiProvider.userType == "brand"
                                    ? "STORE"
                                    : ApiProvider.userType == "agency"
                                        ? "COLLAB"
                                        : "FAME" //before this only "FAME"
                                : animationpro.a == 1
                                    ? "FUN"
                                    : animationpro.a == 2
                                        ? "FOLLOW"
                                        : animationpro.a == 3
                                            ? "JOB"
                                            : "",
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w700,
                              color: HexColor("#FF5C28"),
                              shadows: <Shadow>[
                                Shadow(
                                  color: Color(0xFF000000).withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: "LINKS",
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              shadows: <Shadow>[
                                Shadow(
                                  color: Color(0xFF000000).withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: animationpro.showanimation ? false : true,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(30),
                    child: SizedBox(
                      height: 315,
                      width: 320,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              circleButtonImageWhitemode(
                                imgUrl: animationpro.budlist[animationpro.a],
                                onTaps: () {
                                  print("click1");
                                },
                                isButtonSelect: true,
                              ),
                              Container(
                                height: 23,
                                width: 1,
                                color: Colors.red,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  circleButtonImageWhitemode(
                                    imgUrl:
                                        animationpro.budlist[animationpro.b],
                                    onTaps: () async {
                                      print("click2");
                                      //  print("left before $a $b $c $d");
                                      await animationpro.click2();
                                      animationpro.animationshow(true);
                                      animationpro.animControllerbud0.forward();

                                      animationpro.animation = Tween<double>(
                                        begin: 0,
                                        end: .5 * math.pi,
                                      ).animate(animationpro.animController);

                                      animationpro.animController.forward();

                                      Future.delayed(
                                          Duration(
                                              milliseconds:
                                                  animationpro.antime), () {
                                        animationpro.animController.reset();
                                        animationpro.animControllerbud0.reset();

                                        if (animationpro.a == 0) {
                                          animationpro.a = 1;
                                          animationpro.b = 2;
                                          animationpro.c = 0;
                                          animationpro.d = 3;
                                        } else if (animationpro.a == 1) {
                                          animationpro.a = 2;
                                          animationpro.b = 3;
                                          animationpro.c = 1;
                                          animationpro.d = 0;
                                        } else if (animationpro.a == 2) {
                                          animationpro.a = 3;
                                          animationpro.b = 0;
                                          animationpro.c = 2;
                                          animationpro.d = 1;
                                        } else if (animationpro.a == 3) {
                                          animationpro.a = 0;
                                          animationpro.b = 1;
                                          animationpro.c = 3;
                                          animationpro.d = 2;
                                        }

                                        provider.selectphasefun(animationpro.a);

                                        animationpro.animationshow(false);
                                        // print("left after $a $b $c $d");
                                      });
                                    },
                                    isButtonSelect: false,
                                  ),
                                  Container(
                                    height: 1,
                                    width: 23,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 1,
                                    width: 23,
                                    color: Colors.black,
                                  ),
                                  circleButtonImageWhitemode(
                                    imgUrl:
                                        animationpro.budlist[animationpro.c],
                                    onTaps: () async {
                                      print("click3");
                                      //    print("before after $a $b $c $d");
                                      await animationpro.click3();

                                      animationpro.animationshow(true);
                                      print(
                                          "objectfristtop ${animationpro.showanimation}");

                                      animationpro.animation = Tween<double>(
                                        begin: 0,
                                        end: -.5 * math.pi,
                                      ).animate(animationpro.animController);

                                      animationpro.animController.forward();
                                      animationpro.animControllerbud0.forward();

                                      Future.delayed(
                                          Duration(
                                              milliseconds:
                                                  animationpro.antime), () {
                                        animationpro.animController.reset();
                                        animationpro.animControllerbud0.reset();

                                        if (animationpro.a == 0) {
                                          animationpro.a = 2;
                                          animationpro.b = 0;
                                          animationpro.c = 3;
                                          animationpro.d = 1;
                                        } else if (animationpro.a == 1) {
                                          animationpro.a = 0;
                                          animationpro.b = 1;
                                          animationpro.c = 2;
                                          animationpro.d = 3;
                                        } else if (animationpro.a == 2) {
                                          animationpro.a = 3;
                                          animationpro.b = 2;
                                          animationpro.c = 1;
                                          animationpro.d = 0;
                                        } else if (animationpro.a == 3) {
                                          animationpro.a = 1;
                                          animationpro.b = 3;
                                          animationpro.c = 0;
                                          animationpro.d = 2;
                                        }
                                        Future.delayed(Duration(seconds: 1),
                                            () {
                                          print(
                                              "objectfrist ${animationpro.a}");
                                        });
                                        provider.selectphasefun(animationpro.a);

                                        animationpro.animationshow(false);

                                        //     print("left after $a $b $c $d");
                                      });
                                    },
                                    isButtonSelect: false,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 23,
                                width: 1,
                                color: Colors.black,
                              ),
                              circleButtonImageWhitemode(
                                imgUrl: animationpro.budlist[animationpro.d],
                                onTaps: () async {
                                  print("click4");
                                  await animationpro.click4();
                                  animationpro.animationshow(true);
                                  animationpro.animation = Tween<double>(
                                    begin: 0,
                                    end: 1 * math.pi,
                                  ).animate(animationpro.animController);
                                  animationpro.animController.forward();
                                  animationpro.animControllerbud0.forward();
                                  Future.delayed(
                                      Duration(
                                          milliseconds: animationpro.antime),
                                      () {
                                    animationpro.animController.reset();
                                    animationpro.animControllerbud0.reset();
                                    if (animationpro.a == 0) {
                                      animationpro.a = 2;
                                      animationpro.b = 3;
                                      animationpro.c = 1;
                                      animationpro.d = 0;
                                    } else if (animationpro.a == 1) {
                                      animationpro.a = 3;
                                      animationpro.b = 0;
                                      animationpro.c = 2;
                                      animationpro.d = 1;
                                    } else if (animationpro.a == 2) {
                                      animationpro.a = 0;
                                      animationpro.b = 1;
                                      animationpro.c = 3;
                                      animationpro.d = 2;
                                    } else if (animationpro.a == 3) {
                                      animationpro.a = 1;
                                      animationpro.b = 2;
                                      animationpro.c = 0;
                                      animationpro.d = 3;
                                    }
                                    provider.selectphasefun(animationpro.a);

                                    animationpro.animationshow(false);
                                  });
                                },
                                isButtonSelect: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: animationpro.showanimation,
                  child: Transform.rotate(
                    angle: animationpro.animation.value,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(30),
                      child: SizedBox(
                        height: 315,
                        width: 320,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Transform.rotate(
                                  angle: animationpro.animationbud0.value,
                                  child: circleButtonImageWhitemode(
                                    imgUrl:
                                        animationpro.budlist[animationpro.a],
                                    onTaps: () {},
                                    isButtonSelect: false,
                                  ),
                                ),
                                Container(
                                  height: 23,
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Transform.rotate(
                                      angle: animationpro.animationbud0.value,
                                      child: circleButtonImageWhitemode(
                                        imgUrl: animationpro
                                            .budlist[animationpro.b],
                                        onTaps: () {},
                                        isButtonSelect: false,
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      width: 23,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 1,
                                      width: 23,
                                      color: Colors.black,
                                    ),
                                    Transform.rotate(
                                      angle: animationpro.animationbud0.value,
                                      child: circleButtonImageWhitemode(
                                        imgUrl: animationpro
                                            .budlist[animationpro.c],
                                        onTaps: () {},
                                        isButtonSelect: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 23,
                                  width: 1,
                                  color: Colors.black,
                                ),
                                Transform.rotate(
                                  angle: animationpro.animationbud0.value,
                                  child: circleButtonImageWhitemode(
                                    imgUrl:
                                        animationpro.budlist[animationpro.d],
                                    onTaps: () {},
                                    isButtonSelect: false,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    //   pro!.animController.dispose();
    super.dispose();
  }
}
