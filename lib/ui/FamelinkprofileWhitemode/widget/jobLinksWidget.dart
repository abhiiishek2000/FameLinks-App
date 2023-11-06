import 'package:famelink/common/common_image.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/providers/UserProfileProvider/userProfile_provider.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../Famelinkprofile/function/famelinkFun.dart';
import 'circleButtonImage.dart';

class jobLinksWidgetWhitemode extends StatelessWidget {
  const jobLinksWidgetWhitemode({Key? key}) : super(key: key);

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
                        text: "JOB",
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
                      (fameLinkFun!.isDarkMode == true)
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
                        circleButtonImageWhitemode(
                          imgUrl: (true)
                              ? CommonImage.dark_jobLink_icon
                              : (fameLinkFun!.isDarkMode == true)
                                  ? CommonImage.dark_jobLink_icon
                                  : "assets/icons/vector.png",
                          onTaps: () {
                            //setState(() {
                            fameLinkFun.selectPhase = 0;
                            // });
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

                  // Positioned(
                  //     top: 0.0,
                  //     left: 50.0,
                  //     right: 180.0,
                  //     bottom: 140.0,
                  //     child: InkWell(
                  //         onTap: () {
                  //           print('FameLinks');
                  //           setState(() {
                  //             isDrawerOpen =
                  //             !isDrawerOpen;
                  //           });
                  //         },
                  //         child: InkWell(
                  //           onTap: (){
                  //             gotoOtherProfileScreen(context,profileFameLinksList[0].masterUser.sId,0);
                  //           },
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               RotationTransition(
                  //                   turns: new AlwaysStoppedAnimation(320 / 360),
                  //                   child: Text("View Public\nProfile",textAlign: TextAlign.center,style: TextStyle(color: Colors.black),)),
                  //             ],
                  //           ),
                  //         ))),

                  // left
                  Positioned(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circleButtonImageWhitemode(
                          imgUrl: (fameLinkFun!.isDarkMode == true)
                              ? CommonImage.dark_videoLink_icon
                              : "assets/icons/funLinks.png",
                          onTaps: () {
                            // setState(() {
                            //   // getFunLinkProfile(widget.id ?? id);
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
                        circleButtonImageWhitemode(
                          imgUrl: (fameLinkFun!.isDarkMode == true)
                              ? CommonImage.dark_follower_icon
                              : "assets/icons/followLinks.png",
                          onTaps: () {
                            //  setState(() {
                            // getFollowLinkProfile(widget.id ?? id);
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
                        circleButtonImageWhitemode(
                          imgUrl: (fameLinkFun!.isDarkMode == true)
                              ? "assets/icons/darkFamelinkIcon.png"
                              : "assets/icons/logo.png",
                          onTaps: () {
                            // setState(() {
                            //   // getFameLinkProfile(widget.id ?? id);
                            // });
                          },
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
                          child: Image.asset((fameLinkFun!.isDarkMode == true)
                              ? CommonImage.dark_inner_circle_icon
                              : "assets/images/home_inner_circle.png")),
                      Container(
                        height: 100.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [lightRedWhite, lightRed]),
                          shape: BoxShape.circle,
                        ),
                      ),

                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Image.asset("assets/images/feather_upload.png"),
                      //     SizedBox(
                      //       height: 8,
                      //     ),
                      //     Text(
                      //       "Your Avatar",
                      //       style: TextStyle(
                      //         fontSize: 12,
                      //         color: Color(0xFF9B9B9B),
                      //       ),
                      //     )
                      //   ],
                      // )
                    ],
                  ),

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
                                  '"Hey buddy,\nI am on BudLinks App, where we can participate in Worldwide Beauty Contests, right from the comfort of our homes. I recommend you too to download and join me on FameLinks.\n${ApiProvider.shareUrl}profile/agency/${fameLinkFun!.id}',
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
