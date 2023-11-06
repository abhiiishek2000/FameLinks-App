import 'package:famelink/common/common_image.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/ChattingScreen.dart';
import 'package:famelink/ui/followLinks/provider/FollowLinksFeedProvider.dart';
import 'package:famelink/util/ReadMoreText.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../share/firebasedynamiclink.dart';
import '../../Famelinkprofile/function/famelinkFun.dart';
import '../../followers/follower_info_screen.dart';
import '../../latest_profile/SayHiFirstVideo.dart';
import '../component/OtherprofileContainer.dart';
import '../provder/OtherPofileprovider.dart';
import '../ui/GetPerticularFollowLinksProfile.dart';
import 'circleButtonImageStack.dart';
import 'darkcircleButtonImageStack.dart';
import 'showReferralCodeDialog.dart';

class Phashethree extends StatelessWidget {
  Phashethree({Key? key, this.id, this.isshow}) : super(key: key);

  String? id;
  String? isshow;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Consumer3<OtherPofileprovider, FollowLinksFeedProvider, FameLinkFun>(
      builder: (context, otherPofileprovider, followLinksFeedProvider,
          fameLinkFun, child) {
        return Column(
          children: <Widget>[
            Visibility(
                visible: true,
                child: /*otherPofileprovider!.otherUserProfileFollowLinksModelResult
                                              .length !=
                                          0
                                      ?*/
                    Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 16),
                  child: MyContainer(
                    height: h * 0.105,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                      ),
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FollowerInfoScreen(
                                          isFollowing: false,
                                          id: otherPofileprovider!
                                              .otherUserProfileFollowLinksModelResult[
                                                  0]
                                              .masterUser!
                                              .id)));
                            },
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  otherPofileprovider!
                                              .otherUserProfileFollowLinksModelResult
                                              .length !=
                                          0
                                      ? otherPofileprovider!
                                          .otherUserProfileFollowLinksModelResult[
                                              0]
                                          .followers
                                          .toString()
                                      : "",
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Followers",
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Center(
                              child: Container(
                                  width: 1,
                                  height: 32,
                                  color: Colors.white.withOpacity(0.25))),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FollowerInfoScreen(
                                          isFollowing: true,
                                          id: otherPofileprovider!
                                              .otherUserProfileFollowLinksModelResult[
                                                  0]
                                              .masterUser!
                                              .id)));
                            },
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  otherPofileprovider!
                                              .otherUserProfileFollowLinksModelResult
                                              .length !=
                                          0
                                      ? otherPofileprovider!
                                          .otherUserProfileFollowLinksModelResult[
                                              0]
                                          .following
                                          .toString()
                                      : "",
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Following",
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Center(
                              child: Container(
                                  width: 1,
                                  height: 32,
                                  color: Colors.white.withOpacity(0.25))),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                otherPofileprovider!
                                            .otherUserProfileFollowLinksModelResult
                                            .length !=
                                        0
                                    ? otherPofileprovider!
                                        .otherUserProfileFollowLinksModelResult[
                                            0]
                                        .requests!
                                        .length
                                        .toString()
                                    : "",
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Requests",
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 12, color: Colors.white),
                              ),
                              InkWell(
                                onTap: () {
                                  // setState(() {
                                  fameLinkFun.yourMusicClicked =
                                      !fameLinkFun.yourMusicClicked;
                                  fameLinkFun.requestClicked =
                                      !fameLinkFun.requestClicked;
                                  fameLinkFun.trendsSetClicked = false;
                                  fameLinkFun.titleWonClicked = false;
                                  fameLinkFun.yourVideoClicked = false;
                                  // });
                                },
                                child: fameLinkFun.yourMusicClicked == true
                                    ? Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.white.withOpacity(0.25),
                                      )
                                    : Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white.withOpacity(0.25),
                                      ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Center(
                              child: Container(
                                  width: 1,
                                  height: 32,
                                  color: Colors.white.withOpacity(0.25))),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                otherPofileprovider!
                                            .otherUserProfileFollowLinksModelResult
                                            .length !=
                                        0
                                    ? otherPofileprovider!
                                        .otherUserProfileFollowLinksModelResult[
                                            0]
                                        .club
                                        .toString()
                                    : "",
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Clud",
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 12, color: Colors.white),
                              ),
                              fameLinkFun.yourMusicClicked == true
                                  ? Icon(
                                      Icons.keyboard_arrow_up,
                                      color: Colors.white.withOpacity(0.25),
                                    )
                                  : Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white.withOpacity(0.25),
                                    ),
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                /*: Center(
                                          child:
                                              CircularProgressIndicator())*/
                ),
            SizedBox(
              height: (ScreenUtil().screenHeight * 0.02).ceilToDouble(),
            ),
            // otherPofileprovider!.otherUserProfileFollowLinksModelResult.length !=
            //         0
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IntrinsicWidth(
                        child: Column(
                          children: [
                            // Text(
                            //     otherPofileprovider!
                            //                 .otherUserProfileFollowLinksModelResult
                            //                 .isNotEmpty &&
                            //             otherPofileprovider!
                            //                     .otherUserProfileFollowLinksModelResult[
                            //                         0]
                            //                     .profession !=
                            //                 null
                            //         ? "${otherPofileprovider!.otherUserProfileFollowLinksModelResult[0].profession![0].toUpperCase() + otherPofileprovider!.otherUserProfileFollowLinksModelResult[0].profession!.substring(1)}: "
                            //         : "",
                            //     style: GoogleFonts.nunitoSans(
                            //       fontWeight: FontWeight.w900,
                            //       fontSize: 14,
                            //       color: Colors.white,
                            //     )),
                            SizedBox(height: 2.h),
                            Container(
                              height: 1.h,
                              color: Color(0xffFF5C28),
                            )
                          ],
                        ),
                      )
                      //: Container()
                      ,
                      // SizedBox(
                      //   width: 5.w,
                      // ),
                      // otherPofileprovider!.otherUserProfileFollowLinksModelResult[0]
                      //                 .ambassador !=
                      //             null &&
                      //         otherPofileprovider!.otherUserProfileFollowLinksModelResult[0]
                      //                 .ambassador[0]
                      //                 .title !=
                      //             null
                      //     ? IntrinsicWidth(
                      //         child: Column(
                      //           children: [
                      //             Visibility(
                      //                 child: Container(
                      //               margin: EdgeInsets.only(
                      //                   top: ScreenUtil()
                      //                       .setHeight(
                      //                           2)),
                      //               child: Text(
                      //                   "${otherPofileprovider!.otherUserProfileFollowLinksModelResult[0].ambassador[0].title}",
                      //                   style: GoogleFonts
                      //                       .nunitoSans(
                      //                     fontWeight:
                      //                         FontWeight
                      //                             .w400,
                      //                     fontSize: 12,
                      //                     color: Colors
                      //                         .white,
                      //                   )),
                      //             )),
                      //             SizedBox(height: 3.h),
                      //             Container(
                      //               height: 1.h,
                      //               color: Color(
                      //                   0xff0060FF),
                      //             )
                      //           ],
                      //         ),
                      //       )
                      // : Container(),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  otherPofileprovider!.otherUserProfileFollowLinksModelResult
                              .isNotEmpty &&
                          otherPofileprovider!
                                  .otherUserProfileFollowLinksModelResult[0]
                                  .bio !=
                              null
                      ? Container(
                          child: ReadMoreText(
                            otherPofileprovider
                                    .otherUserProfileFollowLinksModelResult
                                    .isNotEmpty
                                ? otherPofileprovider
                                    .otherUserProfileFollowLinksModelResult[0]
                                    .bio!
                                : "",
                            trimLines: 3,
                            trimMode: TrimMode.Line,
                            colorClickableText: lightGray,
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w400,
                                color: white),
                          ),
                        )
                      : Container(),
                ],
              ),
            )
            // : Container()
            ,
            otherPofileprovider!
                        .otherUserProfileFollowLinksModelResult.length !=
                    0
                ? Container(
                    color: Colors.transparent,
                    height: 110,
                    child: Column(
                      children: <Widget>[
                        // Name Field
                        Padding(
                          padding: EdgeInsets.only(left: 12.0, right: 12.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      MyContainer(
                                        width: ScreenUtil().screenWidth,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 5.0,
                                              left: 3.0,
                                              right: 8.0,
                                              bottom: 0.0),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Row(children: [
                                                    SizedBox(
                                                      width: 8.0,
                                                    ),
                                                    otherPofileprovider!
                                                                .otherUserProfileFollowLinksModelResult[
                                                                    0]
                                                                .profileImageType ==
                                                            "image"
                                                        ? CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${otherPofileprovider!.otherUserProfileFollowLinksModelResult[0].profileImage}"),
                                                            radius: 15,
                                                          )
                                                        : CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${otherPofileprovider!.otherUserProfileFollowLinksModelResult[0].profileImage}"),
                                                            radius: 15,
                                                          ),
                                                    SizedBox(
                                                      width: 8.0,
                                                    ),
                                                    Text(
                                                      otherPofileprovider!
                                                              .otherUserProfileFollowLinksModelResult[
                                                                  0]
                                                              .name ??
                                                          otherPofileprovider!
                                                              .otherUserProfileFollowLinksModelResult[
                                                                  0]
                                                              .masterUser!
                                                              .username!,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ]),
                                                  otherPofileprovider
                                                              .otherUserProfileFollowLinksModelResult[
                                                                  0]
                                                              .followStatus ==
                                                          "Following"
                                                      ? InkWell(
                                                          onTap: () {
                                                            otherPofileprovider
                                                                .getUnFollowFollowStatus(
                                                                    id!)
                                                                .then((value) =>
                                                                    followLinksFeedProvider
                                                                        .getUnFollowStatus(
                                                                            id!));
                                                          },
                                                          child: Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 6.0,
                                                                      right:
                                                                          6.0,
                                                                      top: 2.0,
                                                                      bottom:
                                                                          2.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image: AssetImage(
                                                                      CommonImage
                                                                          .followbackground),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                "Following",
                                                                //Following
                                                                style: GoogleFonts
                                                                    .nunitoSans(
                                                                  fontSize: 14,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )),
                                                        )
                                                      : InkWell(
                                                          onTap: () {
                                                            otherPofileprovider
                                                                .getFollowFollowStatus(
                                                                    id!)
                                                                .then((value) =>
                                                                    followLinksFeedProvider
                                                                        .getFollowStatus(
                                                                            id!));
                                                          },
                                                          child: Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 6.0,
                                                                      right:
                                                                          6.0,
                                                                      top: 2.0,
                                                                      bottom:
                                                                          2.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image: AssetImage(
                                                                      CommonImage
                                                                          .followbackground),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                "Follow",
                                                                style: GoogleFonts
                                                                    .nunitoSans(
                                                                  fontSize: 14,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )),
                                                        )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 4.0,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 9.0),
                                                child: Divider(
                                                  height: 1,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 7.0,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 9.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Row(children: [
                                                      SizedBox(
                                                        width: ScreenUtil()
                                                                .screenWidth *
                                                            0.50,
                                                        child: Text(
                                                          "${otherPofileprovider!.otherUserProfileFollowLinksModelResult[0].masterUser!.district},${otherPofileprovider!.otherUserProfileFollowLinksModelResult[0].masterUser!.state},${otherPofileprovider!.otherUserProfileFollowLinksModelResult[0].masterUser!.country}",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                      /*                                                                            Text(
                                                                              '0',
                                                                              style: GoogleFonts.nunitoSans(
                                                                                fontSize: 14,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 5.0,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 15.68,
                                                                              width: 21.33,
                                                                              child: Image.asset(
                                                                                CommonImage.funLinksStoreHosportIcon,
                                                                                height: 15.68,
                                                                                width: 21.33,
                                                                                fit: BoxFit.fill,
                                                                              ),
                                                                            ),*/
                                                    ]),
                                                    Row(children: [
                                                      SizedBox(
                                                        height: 16.0,
                                                        width: 16.0,
                                                        child: Image.asset(
                                                          CommonImage
                                                              .funLinksStoreCoinsIcon,
                                                          height: 15.68,
                                                          width: 21.33,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      Text(
                                                        otherPofileprovider!
                                                            .otherUserProfileFollowLinksModelResult[
                                                                0]
                                                            .masterUser!
                                                            .fameCoins
                                                            .toString(),
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ]),

                                                    //
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 7.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            Container(
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  // Name Field
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                isshow != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, left: 62),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: InkWell(
                                                onTap: () async {
                                                  print("Open drower");
                                                  final fameLinkFun =
                                                      Provider.of<FameLinkFun>(
                                                          context,
                                                          listen: false);
                                                  fameLinkFun.therprofiledrower(
                                                      fameLinkFun.isdrower);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/svg/settings.svg",
                                                      width: 27.78,
                                                      height: 25,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(width: 6),
                                                    Text('Settings',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            SizedBox(height: 20),

                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: InkWell(
                                                onTap: () {
                                                  String? name =
                                                      "otherprofilefollow";

                                                  Sharedynamic.shareprofile(
                                                      otherPofileprovider
                                                          .profileFameLinksList[
                                                              0]
                                                          .masterUser!
                                                          .sId!,
                                                      name,
                                                      otherPofileprovider
                                                          .profileFameLinksList[
                                                              0]
                                                          .name!
                                                          .toString());
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/svg/share.svg",
                                                      width: 23.78,
                                                      height: 23,
                                                    ),
                                                    SizedBox(width: 6),
                                                    Text('Share',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            //SizedBox(height: 20),

                                            SizedBox(height: 20),

                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      var valu;

                                                      if (fameLinkFun
                                                              .selectPhase ==
                                                          0) {
                                                        valu = "contest";
                                                      }
                                                      if (fameLinkFun
                                                              .selectPhase ==
                                                          1) {
                                                        valu = "funlinks";
                                                      } else if (fameLinkFun
                                                              .selectPhase ==
                                                          2) {
                                                        valu = "followlinks";
                                                      }
                                                      print(
                                                          "say hi video  $valu");
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              SayHiFirstVideo(
                                                            links: valu,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          CommonImage.scan,
                                                          fit: BoxFit.fill,
                                                        ),
                                                        SizedBox(width: 6),
                                                        Text(
                                                          "Say Hi...  ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, left: 62),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: InkWell(
                                                onTap: () {
                                                  showReferralCodeDialogs(
                                                      otherPofileprovider
                                                          .profileFameLinksList[
                                                              0]
                                                          .masterUser!
                                                          .fameCoins!,
                                                      context);
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/svg/gift1.svg",
                                                      width: 25,
                                                      height: 25,
                                                    ),
                                                    SizedBox(height: 6),
                                                    Text('Send Gift',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // SizedBox(height: 20),

                                            SizedBox(height: 20),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: InkWell(
                                                onTap: () async {
                                                  // sdadsad
                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  String? id =
                                                      prefs.getString("id");
                                                  // print(otherPofileprovider.profileFameLinksList[0]
                                                  //     .masterUser!
                                                  //     .sId);
                                                  //if(otherPofileprovider.profileFameLinksList[0].profileImage == "image"){
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => ChattingScreen(
                                                              otherPofileprovider
                                                                  .profileFameLinksList[
                                                                      0]
                                                                  .name!,
                                                              "${otherPofileprovider.profileFameLinksList[0].profileImage}",
                                                              otherPofileprovider
                                                                  .profileFameLinksList[
                                                                      0]
                                                                  .masterUser!
                                                                  .sId!,
                                                              "individual",
                                                              otherPofileprovider
                                                                      .profileFameLinksList[
                                                                          0]
                                                                      .sId ??
                                                                  "",
                                                              false)));
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/svg/Send1.svg",
                                                      width: 27.78,
                                                      height: 25,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(height: 6),
                                                    Text('Message',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                InkWell(
                                  onTap: () async {
                                    otherPofileprovider!
                                                .otherUserProfileFollowLinksModelResult[
                                                    0]
                                                .profileImage ==
                                            null
                                        ? Container()
                                        : showDialog(
                                            context: context,
                                            barrierColor:
                                                Colors.black.withOpacity(0.5),
                                            // Background color
                                            builder:
                                                (BuildContext buildContext) {
                                              return Container(
                                                  child: Center(
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      height: 296.h,
                                                      width: 296.w,
                                                      margin: EdgeInsets.only(
                                                          top: 29.h,
                                                          right: 10.w,
                                                          left: 10.w),
                                                      decoration: BoxDecoration(
                                                          color: otherPofileprovider!
                                                                      .otherUserProfileFollowLinksModelResult[
                                                                          0]
                                                                      .profileImageType !=
                                                                  "image"
                                                              ? Colors.white
                                                              : Colors
                                                                  .transparent,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.r)),
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.r),
                                                          child: otherPofileprovider!
                                                                      .otherUserProfileFollowLinksModelResult[
                                                                          0]
                                                                      .profileImageType !=
                                                                  "image"
                                                              ? Image.network(
                                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${otherPofileprovider!.otherUserProfileFollowLinksModelResult[0].profileImage}",
                                                                  fit: BoxFit
                                                                      .cover)
                                                              : Image.network(
                                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${otherPofileprovider!.otherUserProfileFollowLinksModelResult[0].profileImage}",
                                                                  fit: BoxFit
                                                                      .cover)),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                            });
                                  },
                                  // TODO: FollowLinks Dialer
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Visibility(
                                        visible: true,
                                        child: Container(
                                          height: h * 0.2,
                                          width: w * 0.52,
                                          child: Stack(
                                            // overflow:
                                            // Overflow
                                            //     .visible,
                                            fit: StackFit.loose,
                                            alignment: Alignment.center,
                                            children: <Widget>[
                                              Positioned(
                                                right: -w * 0.09,
                                                child: SizedBox(
                                                  height: h * 0.2,
                                                  width: w * 0.44,
                                                  child: SvgPicture.asset(
                                                    "assets/icons/svg/Outer Circle.svg",
                                                  ),
                                                ),
                                              ),
                                              // top Fame Links

                                              Positioned(
                                                right: -w * 0.05,
                                                top: h * 0.025,
                                                child: Container(
                                                  height: h * 0.15,
                                                  width: w * 0.25,
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
                                                        tileMode:
                                                            TileMode.decal,
                                                      ),
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: otherPofileprovider!
                                                              .otherUserProfileFollowLinksModelResult
                                                              .length ==
                                                          0
                                                      ? Container()
                                                      : otherPofileprovider!
                                                              .otherUserProfileFollowLinksModelResult[
                                                                  0]
                                                              .profileImageType!
                                                              .isNotEmpty
                                                          ? Container(
                                                              margin: EdgeInsets
                                                                  .all(4),
                                                              height: h * 0.5,
                                                              width: w * 0.5,
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundImage: otherPofileprovider!
                                                                            .otherUserProfileFollowLinksModelResult[
                                                                                0]
                                                                            .profileImageType ==
                                                                        "image"
                                                                    ? NetworkImage(
                                                                        "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${otherPofileprovider!.otherUserProfileFollowLinksModelResult[0].profileImage}")
                                                                    : NetworkImage(
                                                                        "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${otherPofileprovider!.otherUserProfileFollowLinksModelResult[0].profileImage}"),
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                radius: 50,
                                                              ),
                                                            )

                                                          // Container(
                                                          //           height: 101.h,
                                                          //           width: 101.w,
                                                          //           decoration: BoxDecoration(
                                                          //             shape: BoxShape.circle,
                                                          //             image: DecorationImage(
                                                          //               image: otherPofileprovider!.otherUserProfileFollowLinksModelResult[0].profileImageType == "image" ? NetworkImage("${ApiProvider.s3UrlPath}${ApiProvider.profile}/${otherPofileprovider!.otherUserProfileFollowLinksModelResult[0].profileImage}") : NetworkImage("${ApiProvider.s3UrlPath}${ApiProvider.avatar}/${otherPofileprovider!.otherUserProfileFollowLinksModelResult[0].profileImage}"),
                                                          //             ),
                                                          //           ),
                                                          //         )
                                                          : otherPofileprovider!
                                                                      .otherUserProfileFollowLinksModelResult[
                                                                          0]
                                                                      .name ==
                                                                  null
                                                              ? Container(
                                                                  height:
                                                                      h * 0.5,
                                                                  width:
                                                                      w * 0.5,
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
                                                                  height:
                                                                      h * 0.5,
                                                                  width:
                                                                      w * 0.5,
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
                                                                      otherPofileprovider!
                                                                          .otherUserProfileFollowLinksModelResult[
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
                                                                ),
                                                ),
                                              ),

                                              Positioned(
                                                // top: -160.0,
                                                // left: -109.0,
                                                right: w * 0.13,
                                                top: 0,
                                                child: SizedBox(
                                                  height: 30,
                                                  width: w * 0.13,
                                                  child: InkWell(
                                                    onTap: () {
                                                      otherPofileprovider!
                                                          .alldataclear();
                                                      debugPrint(
                                                          "${Constants.userType}******************* Fame Links Work");
                                                      // setState(() async {
                                                      otherPofileprovider
                                                          .selectPhase = 0;
                                                      if (Constants.userType !=
                                                          'brand') {
                                                        otherPofileprovider!
                                                            .getOtherUserProfile(
                                                                id.toString(),
                                                                1);
                                                      } else {
                                                        otherPofileprovider!
                                                            .myFamelinks(
                                                                id.toString());
                                                      }
                                                      //   //FameLinksFeedState.selectRunType = "famelinks";
                                                      // });
                                                      // Navigator.pop(context);
                                                    },
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 5, //3
                                                        ),
                                                        circleButtonImageStack(
                                                          imgUrl: Constants
                                                                      .userType ==
                                                                  'brand'
                                                              ? "assets/icons/store.svg"
                                                              : "assets/icons/Logo.svg",
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              // left FunLinks
                                              Positioned(
                                                right: w * 0.22, //90
                                                bottom: h * 0.085,
                                                child: SizedBox(
                                                  height: 30,
                                                  width: 40,
                                                  child: InkWell(
                                                    onTap: () {
                                                      otherPofileprovider!
                                                          .alldataclear();
                                                      // setState(() {
                                                      debugPrint(
                                                          "*************** FunLinks");
                                                      otherPofileprovider
                                                          .selectPhase = 1;
                                                      otherPofileprovider!
                                                          .getOtherUserProfileFunLinks(
                                                              id.toString(), 1);
                                                      // });
                                                    },
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 7, //5
                                                        ),
                                                        circleButtonImageStack(
                                                          imgUrl:
                                                              "assets/icons/FunLinks2.svg",
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // right: MediaQuery.of(context).size.width/2,
                                              ),
                                              // // right FollowLinks
                                              Positioned(
                                                right: w * 0.158,
                                                bottom: h * 0.01,
                                                //-8.r
                                                child: SizedBox(
                                                  height: 30,
                                                  child: InkWell(
                                                    onTap: () {
                                                      // setState(() {
                                                      otherPofileprovider
                                                          .selectPhase = 2;
                                                      // });
                                                    },
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 6.0,
                                                                    right: 6.0,
                                                                    top: 2.0,
                                                                    bottom:
                                                                        2.0),
                                                            child: Text(
                                                              "FOLLOW",
                                                              style: GoogleFonts
                                                                  .nunitoSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 5.w),
                                                        //5
                                                        InkWell(
                                                          onTap: () {
                                                            otherPofileprovider!
                                                                .alldataclear();
                                                            // setState(() {
                                                            debugPrint(
                                                                "*************** FollowLink3-3-3-3-3");
                                                            otherPofileprovider
                                                                .selectPhase = 2;
                                                            otherPofileprovider!
                                                                .getOtherUserProfileFollowLinks(
                                                                    id.toString(),
                                                                    1);
                                                            // });
                                                          },
                                                          child:
                                                              darkcircleButtonImageStack(
                                                            imgUrl:
                                                                "assets/icons/FollowLinks2.svg",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // top: 40.0,

                                                // right: MediaQuery.of(context).size.width/2,
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            otherPofileprovider!
                                        .otherUserProfileFollowLinksModelResult
                                        .length !=
                                    0
                                ? Visibility(
                                    visible: true,
                                    child: SizedBox(
                                        width: ScreenUtil().screenWidth,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 2, right: 10, top: 20),
                                          child: GridView.builder(
                                            padding: EdgeInsets.all(0.0),
                                            primary: false,
                                            scrollDirection: Axis.vertical,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 8,
                                              mainAxisSpacing: 8,
                                            ),
                                            itemCount: otherPofileprovider!
                                                .userPostsfollow!.length,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder:
                                                (BuildContext ctx, index) {
                                              return InkWell(
                                                onTap: () {
                                                  print('1-1-1-1-1-1-11-1-1');
                                                  print(otherPofileprovider!
                                                      .otherUserProfileFollowLinksModelResult[
                                                          0]
                                                      .posts![index]
                                                      .sId);
                                                  print(index);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          GetParticularFollowLinksProfile(
                                                              id: otherPofileprovider!
                                                                  .otherUserProfileFollowLinksModelResult[
                                                                      0]
                                                                  .sId,
                                                              index: index),
                                                    ),
                                                  );
                                                },
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      width: 240,
                                                      height: 110,
                                                      child: Image.network(
                                                        "${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${otherPofileprovider!.userPostsfollow![index].media![0].media}",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: otherPofileprovider!
                                                              .userPostsfollow![
                                                                  index]
                                                              .media![0]
                                                              .type ==
                                                          'video',
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Container(
                                                          child: Stack(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  'assets/icons/svg/other_profile_video_play.svg',
                                                                  height: 40,
                                                                  width: 40,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        )),
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void showReferralCodeDialogs(int famecoins, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return showReferralCodeDialog(
            id: id.toString(),
          );
        });
  }
}
