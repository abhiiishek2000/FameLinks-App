import 'package:famelink/common/common_image.dart';
import 'package:famelink/common/common_routing.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/providers/UserProfileProvider/userProfile_provider.dart';
import 'package:famelink/ui/profile_UI/PhotoImageScreen.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../function/famelinkFun.dart';
import 'circleButtonImage.dart';

class funLinksWidget extends StatelessWidget {
  funLinksWidget({Key? key, required this.userProfileData}) : super(key: key);
  UserProfileProvider userProfileData;
  @override
  Widget build(BuildContext context) {
    return Consumer<FameLinkFun>(
      builder: (context, fameLinkFun, child) {
        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "FUN",
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
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 27.0, right: 27.0),
              height: ScreenUtil().screenHeight * 0.47,
              width: ScreenUtil().screenWidth,
              child: Stack(
                //overflow: Overflow.visible,
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: ScreenUtil().screenHeight,
                    width: ScreenUtil().screenWidth,
                    child: Image.asset(
                      (fameLinkFun.isDarkMode == true)
                          ? CommonImage.profile_links_outer
                          : "assets/images/home_outer_circle.png",
                    ),
                  ),
                  // top
                  Positioned(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circleButtonImage(
                          imgUrl: (true)
                              ? CommonImage.dark_videoLink_icon
                              : (fameLinkFun.isDarkMode == true)
                                  ? CommonImage.dark_videoLink_icon
                                  : "assets/icons/funLinks.png",
                          onTaps: () {
                            // setState(() {
                            fameLinkFun.selectPhase = 0;
                            //  });
                          },
                          isButtonSelect: true,
                        ),
                        Container(
                          height: 20.0,
                          width: 2.0,
                          color: HexColor("#FFA88C"),
                        ),
                      ],
                    ),
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    bottom: 220.0,
                  ),
                  // left
                  Positioned(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circleButtonImage(
                          imgUrl: (fameLinkFun.isDarkMode == true)
                              ? "assets/icons/darkFamelinkIcon.png"
                              : "assets/icons/logo.png",
                          onTaps: () {
                            // setState(() {
                            //   // getFameLinkProfile(widget.id ?? id);
                            // });
                          },
                        ),
                        Container(
                          width: 22.0,
                          height: 2.0,
                          color: Color(0xFF9B9B9B),
                        )
                      ],
                    ),
                    top: 0.0,
                    right: 220.0,
                    left: 0.0,
                    bottom: 0.0,
                    // right: MediaQuery.of(context).size.width/2,
                  ),
                  // right
                  Positioned(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 22.0,
                          height: 2.0,
                          color: Color(0xFF9B9B9B),
                        ),
                        circleButtonImage(
                          imgUrl: (fameLinkFun.isDarkMode == true)
                              ? CommonImage.dark_jobLink_icon
                              : "assets/icons/vector.png",
                          // imgUrl: (fameLinkFun.isDarkMode == true)
                          //     ? CommonImage.dark_videoLink_icon
                          //     : "assets/icons/funLinks.png",
                          onTaps: () {
                            // setState(() {
                            fameLinkFun.selectPhase = 3;
                            //getFunLinkProfile();
                            // });
                          },
                        ),
                      ],
                    ),
                    top: 0.0,
                    right: 0.0,
                    left: 220.0,
                    bottom: 0.0,
                  ),
                  // bottom
                  Positioned(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 20.0,
                          width: 2.0,
                          color: Color(0xFF9B9B9B),
                        ),
                        circleButtonImage(
                          onTaps: () {
                            // setState(() {
                            // getFollowLinkProfile(widget.id ?? id);
                            //fameLinkFun.selectPhase = 3;
                            //  });
                          },
                          imgUrl: (fameLinkFun.isDarkMode == true)
                              ? CommonImage.dark_follower_icon
                              : "assets/icons/followLinks.png",
                        ),
                      ],
                    ),
                    top: 220.0,
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    // right: MediaQuery.of(context).size.width/2,
                  ),

                  Stack(
                    //overflow: Overflow.visible,
                    fit: StackFit.loose,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 144,
                        width: 144,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: Image.asset((fameLinkFun.isDarkMode == true)
                            ? CommonImage.dark_inner_circle_icon
                            : "assets/images/home_inner_circle.png"),
                      ),
                      InkWell(
                        onTap: () {
                          //  setState(() {
                          if (fameLinkFun.profileFunLinksList.length != 0) {
                            if (fameLinkFun
                                    .profileFunLinksList[0].profileImageType ==
                                '') {
                              if (fameLinkFun.avtarImage == null &&
                                  fameLinkFun.profileImage == null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PhotoImageScreen(
                                      getRunScreen: 'editProfileImage',
                                      runtypes:
                                          fameLinkFun.selectPhase.toString(),
                                    ),
                                  ),
                                );
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 150.h,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5.w,
                                                margin: EdgeInsets.all(70.r),
                                                decoration: BoxDecoration(
                                                    color: fameLinkFun
                                                                .avtarImage !=
                                                            null
                                                        ? Colors.white
                                                        : Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.r)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r),
                                                  child: fameLinkFun
                                                              .avtarImage !=
                                                          null
                                                      ? Image.network(
                                                          fameLinkFun
                                                              .avtarImage,
                                                          fit: BoxFit.cover)
                                                      : fameLinkFun
                                                                  .profileImage !=
                                                              null
                                                          ? Image.network(
                                                              fameLinkFun
                                                                  .profileImage,
                                                              fit: BoxFit.cover)
                                                          : Container(),
                                                ),
                                              ),
                                              Positioned(
                                                left: 210.r,
                                                top: 62.r,
                                                child: InkWell(
                                                  onTap: () {
                                                    // setState(() {
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            PhotoImageScreen(
                                                          getRunScreen:
                                                              'editProfileImage',
                                                          runtypes: fameLinkFun
                                                              .selectPhase
                                                              .toString(),
                                                        ),
                                                      ),
                                                    );
                                                    // });
                                                  },
                                                  child: Container(
                                                    height: 30.h,
                                                    width: 30.w,
                                                    child: CircleAvatar(
                                                        radius: 50.r,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          color: black,
                                                          size: 20.r,
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ));
                                    });
                              }
                            } else {
                              if (fameLinkFun.profileFunLinksList[0]
                                          .profileImageType ==
                                      'avatar' ||
                                  fameLinkFun.profileFunLinksList[0]
                                          .profileImageType ==
                                      'image') {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 150.h,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5.w,
                                                margin: EdgeInsets.all(70.r),
                                                decoration: BoxDecoration(
                                                    color: fameLinkFun
                                                                .profileFunLinksList[
                                                                    0]
                                                                .profileImageType ==
                                                            "avatar"
                                                        ? Colors.white
                                                        : Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.r)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r),
                                                  child: fameLinkFun
                                                              .profileImage !=
                                                          null
                                                      ? Image.network(
                                                          fameLinkFun
                                                              .profileImage,
                                                          fit: BoxFit.cover)
                                                      : fameLinkFun
                                                                  .profileFunLinksList[
                                                                      0]
                                                                  .profileImageType ==
                                                              "avatar"
                                                          ? Image.network(
                                                              "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${fameLinkFun.profileFunLinksList[0].profileImage}",
                                                              fit: BoxFit.cover)
                                                          : fameLinkFun
                                                                      .profileFunLinksList[
                                                                          0]
                                                                      .profileImageType ==
                                                                  "image"
                                                              ? Image.network(
                                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${fameLinkFun.profileFunLinksList[0].profileImage}",
                                                                  fit: BoxFit
                                                                      .cover)
                                                              : Container(),
                                                ),
                                              ),
                                              Positioned(
                                                left: 210.r,
                                                top: 62.r,
                                                child: InkWell(
                                                  onTap: () {
                                                    //  setState(() {
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            PhotoImageScreen(
                                                          getRunScreen:
                                                              'editProfileImage',
                                                          runtypes: fameLinkFun
                                                              .selectPhase
                                                              .toString(),
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
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          color: black,
                                                          size: 20.r,
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ));
                                    });
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PhotoImageScreen(
                                      getRunScreen: 'editProfileImage',
                                      runtypes:
                                          fameLinkFun.selectPhase.toString(),
                                    ),
                                  ),
                                );
                              }
                            }
                          }
                          //  });
                        },
                        child: fameLinkFun.profileFunLinksList.length != 0
                            ? fameLinkFun.profileFunLinksList[0]
                                        .profileImageType ==
                                    ""
                                ? fameLinkFun.avtarImage != null
                                    ? Container(
                                        height: 140,
                                        width: 140,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              fameLinkFun.avtarImage),
                                          backgroundColor: Colors.transparent,
                                          radius: 50,
                                        ),
                                      )
                                    : fameLinkFun.profileImage != null
                                        ? Container(
                                            height: 110,
                                            width: 110,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle),
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  fameLinkFun.profileImage),
                                              backgroundColor:
                                                  Colors.transparent,
                                              radius: 50,
                                            ),
                                          )
                                        : fameLinkFun.profileFunLinksList[0]
                                                    .name ==
                                                null
                                            ? Container(
                                                height: 100.h,
                                                width: 100.w,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        lightRedWhite,
                                                        lightRed
                                                      ]),
                                                  shape: BoxShape.circle,
                                                ),
                                              )
                                            : Container(
                                                height: 100.h,
                                                width: 100.w,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        lightRedWhite,
                                                        lightRed
                                                      ]),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    fameLinkFun
                                                        .profileFunLinksList[0]
                                                        .name![0]
                                                        .toString()
                                                        .toUpperCase(),
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: white,
                                                      fontSize: ScreenUtil()
                                                          .setSp(30),
                                                    ),
                                                  ),
                                                ),
                                              )
                                // : Column(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.center,
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.center,
                                //     children: [
                                //       Image.asset(
                                //           "assets/images/feather_upload.png"),
                                //       SizedBox(
                                //         height: 8,
                                //       ),
                                //       Text(
                                //         "Your Avatar",
                                //         style: TextStyle(
                                //           fontSize: 12,
                                //           color: Color(0xFF9B9B9B),
                                //         ),
                                //       )
                                //     ],
                                //   )
                                : Container(
                                    height: 140,
                                    width: 140,
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    child: fameLinkFun.profileFunLinksList[0]
                                                .profileImageType ==
                                            "avatar"
                                        ? CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${fameLinkFun.profileFunLinksList[0].profileImage}"),
                                            backgroundColor: Colors.transparent,
                                            radius: 50,
                                          )
                                        : fameLinkFun.profileFunLinksList[0]
                                                    .profileImageType ==
                                                'image'
                                            ? CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${fameLinkFun.profileFunLinksList[0].profileImage}"),
                                                backgroundColor:
                                                    Colors.transparent,
                                                radius: 50,
                                              )
                                            : fameLinkFun.profileFunLinksList[0]
                                                        .name ==
                                                    null
                                                ? Container(
                                                    height: 100.h,
                                                    width: 100.w,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            lightRedWhite,
                                                            lightRed
                                                          ]),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  )
                                                : Container(
                                                    height: 100.h,
                                                    width: 100.w,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            lightRedWhite,
                                                            lightRed
                                                          ]),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        fameLinkFun
                                                            .profileFunLinksList[
                                                                0]
                                                            .name![0]
                                                            .toString()
                                                            .toUpperCase(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: white,
                                                          fontSize: ScreenUtil()
                                                              .setSp(30),
                                                        ),
                                                      ),
                                                    ),
                                                  ))
                            : Container(),
                      ),
                    ],
                  ),
                  Positioned(
                      top: 0.0,
                      left: 50.0,
                      right: 180.0,
                      bottom: 140.0,
                      child: InkWell(
                          onTap: () {
                            print('FameLinks');
                            Provider.of<UserProfileProvider>(context,
                                    listen: false)
                                .changeIsDrawerOpen(
                                    !Provider.of<UserProfileProvider>(context,
                                            listen: false)
                                        .getIsDrawerOpen);
                          },
                          child: InkWell(
                            onTap: () {
                              gotoOtherProfileScreen(
                                  context,
                                  Constants.userType == 'brand' ||
                                          Constants.userType == 'agency'
                                      ? fameLinkFun
                                          .myFameResult[0].user![0].sId!
                                      : fameLinkFun.profileFameLinksModelResult
                                          .result![0].masterUser!.sId!,
                                  0);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RotationTransition(
                                    turns:
                                        new AlwaysStoppedAnimation(320 / 360),
                                    child: Text(
                                      "View Public\nProfile",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    )),
                              ],
                            ),
                          ))),

                  Positioned(
                      top: 0.r,
                      left: MediaQuery.of(context).size.width - 160.w,
                      // right: MediaQuery.of(context).size.width - 295.w,
                      bottom: 153.r,
                      child: Container(
                        child: Column(
                          children: [
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Share.share(
                                  '"Hey buddy,\nI am on BudLinks App, where we can participate in Worldwide Beauty Contests, right from the comfort of our homes. I recommend you too to download and join me on FameLinks.\n${ApiProvider.shareUrl}profile/agency/${fameLinkFun.id}',
                                );
                              },
                              child: Image.asset(
                                'assets/icons/share.png',
                                color: Colors.white,
                                height: 22.h,
                                width: 22.w,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      )),

                  Positioned(
                      top: 145.r,
                      right: MediaQuery.of(context).size.width - 165.w,
                      // right: 200.r,
                      bottom: 2.r,
                      child: Container(
                        child: Column(
                          children: [
                            Spacer(),
                            InkWell(
                              onTap: () {
                                print('FameLinks');
                                Provider.of<UserProfileProvider>(context,
                                        listen: false)
                                    .changeIsDrawerOpen(
                                        Provider.of<UserProfileProvider>(
                                                context,
                                                listen: false)
                                            .getIsDrawerOpen);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                    'assets/icons/svg/settings.svg',
                                    fit: BoxFit.fill,
                                    height: 22.h,
                                    width: 22.w,
                                    color: Colors.white),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
