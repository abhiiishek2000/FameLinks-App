import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:famelink/common/common_image.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/ChattingScreen.dart';
import 'package:famelink/ui/otherUserProfile/component/drawerText.dart';
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
import '../../Famelinkprofile/widget/followLinksNameField.dart';
import '../../Famelinkprofile/widget/followLinksWidgetTop.dart';
import '../../followers/follower_info_screen.dart';

import '../../joblinks/application/brandDetailApplication.dart';
import '../../joblinks/createjob/createJob.dart';
import '../../latest_profile/SayHiFirstVideo.dart';
import '../component/OtherprofileContainer.dart';
import '../provder/OtherPofileprovider.dart';
import '../ui/GetPerticularFollowLinksProfile.dart';
import 'circleButtonImageStack.dart';
import 'darkcircleButtonImageStack.dart';
import 'showReferralCodeDialog.dart';

class Phashefour extends StatelessWidget {
  Phashefour({Key? key, this.id, this.isshow}) : super(key: key);

  String? id;
  String? isshow;

  TextEditingController descController = TextEditingController();
  final _scroll = ScrollController();

  List<String> piclist = [
    "assets/icons/svg/photoshoot.svg",
    "assets/icons/svg/videoshot.svg",
    "assets/icons/svg/jobactivity.svg",
    "assets/icons/svg/filmshot.svg"
  ];

  List<String> gridtext = ["Print", "Video", "Activity", "Film"];

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Consumer2<OtherPofileprovider, FameLinkFun>(
      builder: (context, otherPofileprovider, fameLinkFun, child) {
        return otherPofileprovider!.otherprofilejob.length != 0
            ? Column(
                children: <Widget>[
                  Visibility(
                      visible: true,
                      child: isshow == null
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 11),
                              child: MyContainer(
                                height: 74.h,
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 8.h, left: 16.w, right: 24.w),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FollowerInfoScreen(
                                                          isFollowing: false,
                                                          id: otherPofileprovider!
                                                              .otherprofilejob[
                                                                  0]
                                                              .hired
                                                              .toString())));
                                        },
                                        child: Column(
                                          //mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ShadowText(
                                                txt: otherPofileprovider!
                                                    .otherprofilejob[0].hired
                                                    .toString(),
                                                size: ScreenUtil().setSp(14),
                                                fontColor: Colors.black,
                                                weight: FontWeight.bold),
                                            SizedBox(
                                              height: 12.h,
                                            ),
                                            ShadowText(
                                              txt: "Hire",
                                              size: ScreenUtil().setSp(12),
                                              fontColor: white,
                                            ),
                                          ],
                                        ),
                                      ),

                                      Container(
                                          width: 1,
                                          height: 32.h,
                                          color:
                                              Colors.white.withOpacity(0.25)),

                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FollowerInfoScreen(
                                                          isFollowing: true,
                                                          id: otherPofileprovider
                                                              .otherprofilejob[
                                                                  0]
                                                              .masterUser!
                                                              .id)));
                                        },
                                        child: Column(
                                          //mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ShadowText(
                                                txt: otherPofileprovider!
                                                    .otherprofilejob[0].collabs
                                                    .toString(),
                                                size: ScreenUtil().setSp(14),
                                                fontColor: Colors.black,
                                                weight: FontWeight.bold),
                                            SizedBox(
                                              height: 12.h,
                                            ),
                                            ShadowText(
                                              txt: "Collabs",
                                              size: ScreenUtil().setSp(12),
                                              fontColor: white,
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Center(
                                      //     child: Container(
                                      //         width: 1,
                                      //         height: 32,
                                      //         color: Colors.white.withOpacity(0.25))),
                                      //
                                      // Column(
                                      //   //mainAxisAlignment: MainAxisAlignment.center,
                                      //   children: [
                                      //     Text(
                                      //       otherPofileprovider!
                                      //                   .otherprofilejob
                                      //                   .length !=
                                      //               0
                                      //           ? otherPofileprovider!
                                      //               .otherprofilejob[
                                      //                   0]
                                      //               .requests!
                                      //               .length
                                      //               .toString()
                                      //           : "",
                                      //       style: GoogleFonts.nunitoSans(
                                      //           fontWeight: FontWeight.bold,
                                      //           fontSize: 14,
                                      //           color: Colors.black),
                                      //     ),
                                      //     SizedBox(
                                      //       height: 8,
                                      //     ),
                                      //     Text(
                                      //       "Requests",
                                      //       style: GoogleFonts.nunitoSans(
                                      //           fontSize: 12, color: Colors.white),
                                      //     ),
                                      //     InkWell(
                                      //       onTap: () {
                                      //         // setState(() {
                                      //         fameLinkFun.yourMusicClicked =
                                      //             !fameLinkFun.yourMusicClicked;
                                      //         fameLinkFun.requestClicked =
                                      //             !fameLinkFun.requestClicked;
                                      //         fameLinkFun.trendsSetClicked = false;
                                      //         fameLinkFun.titleWonClicked = false;
                                      //         fameLinkFun.yourVideoClicked = false;
                                      //         // });
                                      //       },
                                      //       child:
                                      //           fameLinkFun.yourMusicClicked == true
                                      //               ? Icon(
                                      //                   Icons.keyboard_arrow_up,
                                      //                   color: Colors.white
                                      //                       .withOpacity(0.25),
                                      //                 )
                                      //               : Icon(
                                      //                   Icons.keyboard_arrow_down,
                                      //                   color: Colors.white
                                      //                       .withOpacity(0.25),
                                      //                 ),
                                      //     )
                                      //   ],
                                      // ),

                                      Container(
                                          width: 1,
                                          height: 32.h,
                                          color:
                                              Colors.white.withOpacity(0.25)),

                                      Column(
                                        //mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ShadowText(
                                              txt: otherPofileprovider!
                                                  .otherprofilejob[0].totalJobs
                                                  .toString(),
                                              size: ScreenUtil().setSp(14),
                                              fontColor: Colors.black,
                                              weight: FontWeight.bold),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          Column(children: [
                                            ShadowText(
                                              txt: "Total job",
                                              size: ScreenUtil().setSp(12),
                                              fontColor: white,
                                            ),
                                            fameLinkFun.yourMusicClicked == true
                                                ? Icon(
                                                    Icons.keyboard_arrow_up,
                                                    color: Colors.white
                                                        .withOpacity(0.25),
                                                  )
                                                : Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Colors.white
                                                        .withOpacity(0.25),
                                                  ),
                                          ]),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : followLinksWidgetTop(
                              id: id!,
                            )
                      /*: Center(
                                          child:
                                              CircularProgressIndicator())*/
                      ),
                  SizedBox(
                    height: (ScreenUtil().screenHeight * 0.02).ceilToDouble(),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IntrinsicWidth(
                              child: Column(
                                children: [
                                  SizedBox(height: 2.h),
                                  Container(
                                    height: 1.h,
                                    color: Color(0xffFF5C28),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        otherPofileprovider.otherprofilejob.isNotEmpty &&
                                otherPofileprovider.otherprofilejob[0].bio !=
                                    null
                            ? Container(
                                child: ReadMoreText(
                                    otherPofileprovider
                                            .otherprofilejob.isNotEmpty
                                        ? otherPofileprovider
                                            .otherprofilejob[0].bio!
                                        : "",
                                    trimLines: 3,
                                    trimMode: TrimMode.Line,
                                    colorClickableText: lightGray,
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(14),
                                      color: white,
                                      fontWeight: FontWeight.w400,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(0, 2),
                                          blurRadius: 2,
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                        ),
                                      ],
                                    )),
                              )
                            : Container(),
                      ],
                    ),
                  )
                  // : Container()
                  ,
                  otherPofileprovider.otherprofilejob.length != 0
                      ? Column(
                          children: <Widget>[
                            // Name Field
                            isshow == null
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 12.0, right: 12.0),
                                    child: MyContainer(
                                      height: 74.h,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Row(children: [
                                                  if (otherPofileprovider
                                                          .otherprofilejob
                                                          .isNotEmpty &&
                                                      otherPofileprovider
                                                              .otherprofilejob[
                                                                  0]
                                                              .profileImageType !=
                                                          '')
                                                    otherPofileprovider
                                                                .otherprofilejob[
                                                                    0]
                                                                .profileImageType ==
                                                            "image"
                                                        ? CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${otherPofileprovider.otherprofilejob[0].profileImage}"),
                                                            radius: 15,
                                                          )
                                                        : CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    "${ApiProvider.s3UrlPath}${ApiProvider.avatar}/${otherPofileprovider.otherprofilejob[0].profileImage}"),
                                                            radius: 15,
                                                          )
                                                  else if (otherPofileprovider
                                                      .otherprofilejob
                                                      .isNotEmpty)
                                                    otherPofileprovider
                                                                .otherprofilejob[
                                                                    0]
                                                                .masterUser!
                                                                .profileImageType ==
                                                            "image"
                                                        ? CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${otherPofileprovider.otherprofilejob[0].masterUser!.profileImage}"),
                                                            radius: 15,
                                                          )
                                                        : CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    "${ApiProvider.s3UrlPath}${ApiProvider.avatar}/${otherPofileprovider.otherprofilejob[0].masterUser!.profileImage}"),
                                                            radius: 15,
                                                          ),
                                                  SizedBox(
                                                    width: 8.w,
                                                  ),
                                                  ShadowText(
                                                      txt: otherPofileprovider
                                                              .otherprofilejob[
                                                                  0]
                                                              .name ??
                                                          otherPofileprovider
                                                              .otherprofilejob[
                                                                  0]
                                                              .masterUser!
                                                              .username ??
                                                          '',
                                                      size: ScreenUtil()
                                                          .setSp(18),
                                                      fontColor: white,
                                                      weight: FontWeight.bold),
                                                ]),
                                                otherPofileprovider
                                                            .otherprofilejob[0]
                                                            .followStatus ==
                                                        "Following"
                                                    ? InkWell(
                                                        onTap: () {
                                                          // otherPofileprovider
                                                          //     .getUnFollowFollowStatus(
                                                          //         id!)
                                                          //     .then((value) =>
                                                          //         followLinksFeedProvider
                                                          //             .getUnFollowStatus(
                                                          //                 id!));
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 6.0,
                                                                  right: 6.0,
                                                                  top: 2.0,
                                                                  bottom: 2.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                  CommonImage
                                                                      .followbackground),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: ShadowText(
                                                              txt: 'Invited',
                                                              size: ScreenUtil()
                                                                  .setSp(14),
                                                              fontColor: white,
                                                              weight: FontWeight
                                                                  .bold),
                                                        ),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          // otherPofileprovider
                                                          //     .getFollowFollowStatus(
                                                          //         id!)
                                                          //     .then((value) =>
                                                          //     otherPofileprovider
                                                          //             .getFollowStatus(
                                                          //                 id!));
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 6.0,
                                                                  right: 6.0,
                                                                  top: 2.0,
                                                                  bottom: 2.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                  CommonImage
                                                                      .followbackground),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: ShadowText(
                                                              txt: 'Invite',
                                                              size: ScreenUtil()
                                                                  .setSp(14),
                                                              fontColor: white,
                                                              weight: FontWeight
                                                                  .bold),
                                                        ),
                                                      )
                                              ],
                                            ),
                                            Container(
                                              height: 1.h,
                                              decoration: BoxDecoration(
                                                color: white.withOpacity(0.50),
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: Offset(0, 2),
                                                    blurRadius: 3,
                                                    color: Colors.black
                                                        .withOpacity(0.25),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Row(children: [
                                                  SizedBox(
                                                      width: ScreenUtil()
                                                              .screenWidth /
                                                          1.6,
                                                      child: ShadowText(
                                                          txt: otherPofileprovider
                                                                  .otherprofilejob
                                                                  .isNotEmpty
                                                              ? "${otherPofileprovider.otherprofilejob[0].masterUser!.district},"
                                                                  "${otherPofileprovider.otherprofilejob[0].masterUser!.state},"
                                                                  "${otherPofileprovider.otherprofilejob[0].masterUser!.country}"
                                                              : "",
                                                          size: ScreenUtil()
                                                              .setSp(12),
                                                          fontColor: white,
                                                          weight: FontWeight
                                                              .normal)),
                                                ]),
                                                // Row(children: [
                                                //   SizedBox(
                                                //     height: 16.0,
                                                //     width: 16.0,
                                                //     child:
                                                //     Image.asset(
                                                //       CommonImage
                                                //           .funLinksStoreCoinsIcon,
                                                //       height: 15.68,
                                                //       width: 21.33,
                                                //       fit:
                                                //       BoxFit.fill,
                                                //     ),
                                                //   ),
                                                //   SizedBox(
                                                //     width: 5.w,
                                                //   ),
                                                //   ShadowText(
                                                //       txt: otherPofileprovider!
                                                //           .otherprofilejob[
                                                //       0]
                                                //           .masterUser!
                                                //           .fameCoins
                                                //           .toString(),
                                                //       size:
                                                //       ScreenUtil()
                                                //           .setSp(
                                                //           14),
                                                //       fontColor:
                                                //       white,
                                                //       weight:
                                                //       FontWeight
                                                //           .bold),
                                                // ]),

                                                //
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : followLinksNameField(),
                          ],
                        )
                      : Container(),
                  Container(
                    color: Colors.transparent,
                    child: Column(
                      children: <Widget>[
                        // Name Field
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, top: 32.h),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      isshow != null
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 62),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: InkWell(
                                                      onTap: () async {
                                                        print("Open drower");
                                                        final fameLinkFun =
                                                            Provider.of<
                                                                    FameLinkFun>(
                                                                context,
                                                                listen: false);
                                                        fameLinkFun
                                                            .therprofiledrower(
                                                                fameLinkFun
                                                                    .isdrower);
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
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
                                                                  color: Colors
                                                                      .white)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(height: 32.h),

                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: InkWell(
                                                      onTap: () {
                                                        String? name =
                                                            "otherprofilefollow";

                                                        Sharedynamic.shareprofile(
                                                            otherPofileprovider
                                                                .otherprofilejob[
                                                                    0]
                                                                .masterUser!
                                                                .id!,
                                                            name,
                                                            otherPofileprovider
                                                                .otherprofilejob[
                                                                    0]
                                                                .name!
                                                                .toString());
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SvgPicture.asset(
                                                            "assets/icons/svg/share.svg",
                                                            width: 23.78,
                                                            height: 23,
                                                          ),
                                                          SizedBox(width: 6),
                                                          Text('Share',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  //SizedBox(height: 20),

                                                  SizedBox(height: 20),

                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
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
                                                              valu =
                                                                  "followlinks";
                                                            }
                                                            print(
                                                                "say hi video  $valu");
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        SayHiFirstVideo(
                                                                  links: valu,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                CommonImage
                                                                    .scan,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                              SizedBox(
                                                                  width: 6),
                                                              Text(
                                                                "Say Hi...  ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
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
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: InkWell(
                                                      onTap: () {
                                                        // showReferralCodeDialogs(
                                                        //     otherPofileprovider
                                                        //         .otherprofilejob[
                                                        //             0]
                                                        //         .masterUser!
                                                        //         .fameCoins!.toString(),
                                                        //     context);
                                                      },
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SvgPicture.asset(
                                                            "assets/icons/svg/gift1.svg",
                                                            width: 25,
                                                            height: 25,
                                                          ),
                                                          SizedBox(height: 6),
                                                          ShadowText(
                                                            txt: 'Send Gift',
                                                            size: ScreenUtil()
                                                                .setSp(14),
                                                            fontColor: white,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(height: 20),

                                                  SizedBox(height: 20),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: InkWell(
                                                      onTap: () async {
                                                        // sdadsad
                                                        SharedPreferences
                                                            prefs =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        String? id = prefs
                                                            .getString("id");
                                                        // print(otherPofileprovider.otherprofilejob[0]
                                                        //     .masterUser!
                                                        //     .sId);
                                                        //if(otherPofileprovider.otherprofilejob[0].profileImage == "image"){
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => ChattingScreen(
                                                                    otherPofileprovider
                                                                        .otherprofilejob[
                                                                            0]
                                                                        .name!,
                                                                    "${otherPofileprovider.otherprofilejob[0].profileImage}",
                                                                    otherPofileprovider
                                                                        .otherprofilejob[
                                                                            0]
                                                                        .masterUser!
                                                                        .id!,
                                                                    "joblinks",
                                                                    otherPofileprovider
                                                                            .otherprofilejob[0]
                                                                            .id ??
                                                                        "",
                                                                    false)));
                                                      },
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SvgPicture.asset(
                                                            "assets/icons/svg/Send1.svg",
                                                            width: 27.78,
                                                            height: 25,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(height: 6.h),
                                                          ShadowText(
                                                            txt: 'Message',
                                                            size: ScreenUtil()
                                                                .setSp(14),
                                                            fontColor: white,
                                                          ),
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
                                          if (otherPofileprovider
                                                      .otherprofilejob[0]
                                                      .profileImage ==
                                                  null &&
                                              otherPofileprovider
                                                      .otherprofilejob[0]
                                                      .masterUser!
                                                      .profileImage ==
                                                  null) {
                                          } else if (otherPofileprovider
                                                  .otherprofilejob[0]
                                                  .profileImage !=
                                              null) {
                                            return showDialog(
                                                context: context,
                                                barrierColor: Colors.black
                                                    .withOpacity(0.5),
                                                // Background color
                                                builder: (BuildContext
                                                    buildContext) {
                                                  return Container(
                                                      child: Center(
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          height: 296.h,
                                                          width: 296.w,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 29.h,
                                                                  right: 10.w,
                                                                  left: 10.w),
                                                          decoration: BoxDecoration(
                                                              color: otherPofileprovider
                                                                          .otherprofilejob
                                                                          .isNotEmpty &&
                                                                      otherPofileprovider
                                                                              .otherprofilejob[
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
                                                                          .otherprofilejob[
                                                                              0]
                                                                          .profileImageType !=
                                                                      "image"
                                                                  ? CachedNetworkImage(
                                                                      imageUrl:
                                                                          "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${otherPofileprovider.otherprofilejob[0].profileImage!.replaceAll('-xs', '')}",
                                                                      fit: BoxFit
                                                                          .cover)
                                                                  : CachedNetworkImage(
                                                                      imageUrl:
                                                                          "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${otherPofileprovider.otherprofilejob[0].profileImage!.replaceAll('-xs', '')}",
                                                                      fit: BoxFit
                                                                          .cover)),
                                                        ),
                                                      ],
                                                    ),
                                                  ));
                                                });
                                          } else {
                                            return showDialog(
                                                context: context,
                                                barrierColor: Colors.black
                                                    .withOpacity(0.5),
                                                // Background color
                                                builder: (BuildContext
                                                    buildContext) {
                                                  return Container(
                                                      child: Center(
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          height: 296.h,
                                                          width: 296.w,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 29.h,
                                                                  right: 10.w,
                                                                  left: 10.w),
                                                          decoration: BoxDecoration(
                                                              color: otherPofileprovider
                                                                          .otherprofilejob
                                                                          .isNotEmpty &&
                                                                      otherPofileprovider
                                                                              .otherprofilejob[
                                                                                  0]
                                                                              .masterUser!
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
                                                                      .circular(12
                                                                          .r),
                                                              child: otherPofileprovider
                                                                          .otherprofilejob[
                                                                              0]
                                                                          .masterUser!
                                                                          .profileImageType !=
                                                                      "image"
                                                                  ? CachedNetworkImage(
                                                                      imageUrl:
                                                                          "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${otherPofileprovider.otherprofilejob[0].masterUser!.profileImage!.replaceAll('-xs', '')}",
                                                                      fit: BoxFit
                                                                          .cover)
                                                                  : CachedNetworkImage(
                                                                      imageUrl:
                                                                          "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${otherPofileprovider.otherprofilejob[0].masterUser!.profileImage!.replaceAll('-xs', '')}",
                                                                      fit: BoxFit
                                                                          .cover)),
                                                        ),
                                                      ],
                                                    ),
                                                  ));
                                                });
                                          }
                                        },
                                        // TODO: FollowLinks Dialer
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Visibility(
                                              visible: true,
                                              child: Container(
                                                height: 150.h,
                                                width: 200.w,
                                                child: Stack(
                                                  // overflow:
                                                  // Overflow.visible,
                                                  fit: StackFit.loose,
                                                  alignment: Alignment.center,

                                                  children: <Widget>[
                                                    Positioned(
                                                      right: -40.w,
                                                      child: DottedBorder(
                                                        borderType:
                                                            BorderType.Circle,
                                                        color:
                                                            Color(0xFF9B9B9B),
                                                        strokeWidth: 1.5,
                                                        child: Container(
                                                          height: 135.h,
                                                          width: 135.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                  height: 85.h,
                                                                  width: 85.w,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border:
                                                                        GradientBoxBorder(
                                                                      gradient:
                                                                          LinearGradient(
                                                                        colors: [
                                                                          Color(
                                                                              0xFFFF4944),
                                                                          Color(
                                                                              0xFF141070),
                                                                          Color(
                                                                              0xFF1C126E),
                                                                          Color(
                                                                              0xFFFF4944),
                                                                          Color(
                                                                              0xFF0060FF),
                                                                        ],
                                                                        stops: [
                                                                          0,
                                                                          0.260417,
                                                                          0.260517,
                                                                          0.619792,
                                                                          1,
                                                                        ],
                                                                        tileMode:
                                                                            TileMode.decal,
                                                                      ),
                                                                      width: 2,
                                                                    ),
                                                                  ),
                                                                  child: otherPofileprovider!
                                                                              .otherprofilejob
                                                                              .length ==
                                                                          0
                                                                      ? Container()
                                                                      : otherPofileprovider!.otherprofilejob[0].profileImageType !=
                                                                              ""
                                                                          ? Container(
                                                                              height: 95.h,
                                                                              width: 95.w,
                                                                              child: CircleAvatar(
                                                                                backgroundImage: otherPofileprovider!.otherprofilejob[0].profileImageType == "image" ? NetworkImage("${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${otherPofileprovider.otherprofilejob[0].profileImage}") : NetworkImage("${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${otherPofileprovider.otherprofilejob[0].profileImage}"),
                                                                                backgroundColor: Color(0xFFCFB7E9),
                                                                                radius: 50,
                                                                              ),
                                                                            )
                                                                          : otherPofileprovider!.otherprofilejob[0].masterUser!.profileImageType != ""
                                                                              ? Container(
                                                                                  height: 95.h,
                                                                                  width: 95.w,
                                                                                  child: CircleAvatar(
                                                                                    backgroundImage: otherPofileprovider.otherprofilejob[0].masterUser!.profileImageType == "image" ? NetworkImage("${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${otherPofileprovider.otherprofilejob[0].masterUser!.profileImage}") : NetworkImage("${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${otherPofileprovider.otherprofilejob[0].masterUser!.profileImage}"),
                                                                                    backgroundColor: Color(0xFFCFB7E9),
                                                                                    radius: 50,
                                                                                  ),
                                                                                )
                                                                              : Container(
                                                                                  height: 95.h,
                                                                                  width: 95.w,
                                                                                  decoration: BoxDecoration(
                                                                                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                                      lightRedWhite,
                                                                                      lightRed
                                                                                    ]),
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      otherPofileprovider.otherprofilejob.isNotEmpty ? otherPofileprovider!.otherprofilejob[0].name.toString().toUpperCase() : "",
                                                                                      textAlign: TextAlign.center,
                                                                                      style: GoogleFonts.nunitoSans(
                                                                                        fontWeight: FontWeight.w700,
                                                                                        color: white,
                                                                                        fontSize: ScreenUtil().setSp(30),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ))
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // top Fame Links

                                                    // Positioned(
                                                    //     top: w * 0.13,
                                                    //     left: w * 0.26,
                                                    //     bottom: w * 0.010,
                                                    //     right: w * 0.010,
                                                    //     child: Image.asset(
                                                    //       CommonImage.fourother,
                                                    //       width: 100,
                                                    //       height: 100,
                                                    //     )),
                                                    Positioned(
                                                      right: 50.w,
                                                      top: 5.h,
                                                      child: InkWell(
                                                        onTap: () {
                                                          otherPofileprovider!
                                                              .alldataclear();
                                                          debugPrint(
                                                              "${Constants.userType}******************* Fame Links Work");
                                                          // setState(() async {
                                                          otherPofileprovider
                                                              .selectPhase = 0;

                                                            otherPofileprovider!
                                                                .getProfileDetails(
                                                                    id.toString());

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
                                                      // right: MediaQuery.of(context).size.width/2,
                                                    ),

                                                    // left FunLinks
                                                    Positioned(
                                                      right: 80.w,
                                                      top: 44.h,
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
                                                                  id.toString(),
                                                                  1);
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
                                                      // right: MediaQuery.of(context).size.width/2,
                                                    ),
                                                    Positioned(
                                                      right: 75.w,
                                                      bottom: 35.h,
                                                      child: InkWell(
                                                        onTap: () {
                                                          otherPofileprovider!
                                                              .alldataclear();
                                                          // setState(() {
                                                          debugPrint(
                                                              "*************** FunLinks");
                                                          otherPofileprovider
                                                              .selectPhase = 2;
                                                          otherPofileprovider!
                                                              .getOtherUserProfileFollowLinks(
                                                                  id.toString(),
                                                                  1);
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
                                                                  "assets/icons/FollowLinks2.svg",
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      // right: MediaQuery.of(context).size.width/2,
                                                    ),
                                                    // // right FollowLinks
                                                    Positioned(
                                                      right: 40.w,
                                                      bottom: 5.h,
                                                      child: InkWell(
                                                        onTap: () {
                                                          otherPofileprovider
                                                              .selectPhase = 2;
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
                                                                        left:
                                                                            6.0,
                                                                        right:
                                                                            6.0,
                                                                        top:
                                                                            2.0,
                                                                        bottom:
                                                                            2.0),
                                                                child: ShadowText(
                                                                    txt:
                                                                        "Store",
                                                                    size: ScreenUtil()
                                                                        .setSp(
                                                                            14),
                                                                    fontColor:
                                                                        Colors
                                                                            .white,
                                                                    weight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 5.w),
                                                            //5
                                                            InkWell(
                                                              onTap: () {
                                                                otherPofileprovider!
                                                                    .alldataclear();
                                                                // setState(() {
                                                                debugPrint(
                                                                    "*************** FollowLink3-3-3-3-3");
                                                                otherPofileprovider
                                                                    .selectPhase = 3;
                                                                otherPofileprovider
                                                                    .getOtherProfileJoblink(
                                                                        id.toString(),
                                                                        1);
                                                                // });
                                                              },
                                                              child:
                                                                  darkcircleButtonImageStack(
                                                                imgUrl:
                                                                    "assets/icons/store.svg",
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
// store link
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  otherPofileprovider.index == 4 ||
                                          otherPofileprovider.index == 5
                                      ? Container()
                                      : SizedBox(height: 16.h),
                                  otherPofileprovider.index == 3 ||
                                          otherPofileprovider.index == 4 ||
                                          otherPofileprovider.index == 5
                                      ? Container()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Stack(
                                                children: [
                                                  Image.asset(
                                                    "assets/icons/rect.png",
                                                    height: 125.h,
                                                    width: 115.w,
                                                  ),
                                                  Positioned(
                                                    top: 2.h,
                                                    left: 3.w,
                                                    child: Image.asset(
                                                      "assets/icons/girl.png",
                                                      height: 120.h,
                                                      width: 105.w,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 50,
                                                    left: 40,
                                                    child: Center(
                                                      child: Container(
                                                        height: 40.h,
                                                        width: 40.w,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color: white
                                                                    .withOpacity(
                                                                        0.5),
                                                                width: 2.w)),
                                                        child: Icon(
                                                            Icons.play_arrow,
                                                            color: white
                                                                .withOpacity(
                                                                    0.5)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 16.w),
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 15.h),
                                                    height: 91.h,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            155.w,
                                                    child: Text(
                                                        otherPofileprovider!
                                                            .otherprofilejob[0]
                                                            .greetText
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.nunitoSans(
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            12),
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: white)),
                                                  ),
                                                ]),
                                          ],
                                        ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    // crossAxisAlignment: CrossAxisAlignment.s,
                                    children: [
                                      Container(
                                          width: 168.w,
                                          height: 23.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Color(0xffFF5C28))),
                                          child: Center(
                                            child: Text("Hiring Profiles",
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize:
                                                        ScreenUtil().setSp(15),
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                    color: white)),
                                          )),
                                      Container(
                                          width: 168.w,
                                          height: 23.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Color(0xffFFFFFF))),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0,
                                                      horizontal: 14),
                                              child: Text("Open jobs",
                                                  style: GoogleFonts.nunitoSans(
                                                      fontSize: ScreenUtil()
                                                          .setSp(15),
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          Color(0xffFFFFFF))),
                                            ),
                                          )),
                                    ],
                                  ),
                                  otherPofileprovider.index == 3 ||
                                          otherPofileprovider.index == 4 ||
                                          otherPofileprovider.index == 5
                                      ? Container()
                                      : SizedBox(height: 20.h),
                                  otherPofileprovider.index == 3
                                      ? Row(
                                          children: [
                                            Text(
                                              'Job Created: ',
                                              style: GoogleFonts.nunitoSans(
                                                fontSize: 12.sp,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                                color: white,
                                              ),
                                            ),
                                            Spacer(),
                                            InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  height: 28.h,
                                                  width: 28.w,
                                                  decoration: BoxDecoration(
                                                      color: white,
                                                      border: Border.all(
                                                          color: lightGray),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.r)),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: ScreenUtil()
                                                            .setHeight(4),
                                                        left: ScreenUtil()
                                                            .setWidth(5)),
                                                    child: SvgPicture.asset(
                                                      "assets/icons/svg/jobedit.svg",
                                                      height: ScreenUtil()
                                                          .setHeight(16),
                                                      width: ScreenUtil()
                                                          .setWidth(16),
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            otherPofileprovider.index == 2
                                                ? Container()
                                                : InkWell(
                                                    onTap: () {
                                                      //  setState(() {
                                                      otherPofileprovider
                                                          .jobindexchange(0);

                                                      //  });
                                                    },
                                                    child: IntrinsicWidth(
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            'Front Faces',
                                                            style: GoogleFonts.nunitoSans(
                                                                fontSize: 12.sp,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontWeight: otherPofileprovider
                                                                            .index ==
                                                                        0
                                                                    ? FontWeight
                                                                        .w700
                                                                    : FontWeight
                                                                        .w400,
                                                                color: otherPofileprovider
                                                                            .index ==
                                                                        0
                                                                    ? white
                                                                    : white
                                                                        .withOpacity(
                                                                            0.6)),
                                                          ),
                                                          SizedBox(height: 2.h),
                                                          Container(
                                                              height: 1,
                                                              color: otherPofileprovider
                                                                          .index ==
                                                                      0
                                                                  ? orange
                                                                  : Colors
                                                                      .transparent)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                            otherPofileprovider.index == 2
                                                ? Container()
                                                : SizedBox(width: 24.w),
                                            InkWell(
                                              onTap: () {
                                                otherPofileprovider
                                                    .jobindexchange(1);
                                              },
                                              child: IntrinsicWidth(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Behind the Scenes',
                                                      style: GoogleFonts.nunitoSans(
                                                          fontSize: 12.sp,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontWeight:
                                                              otherPofileprovider
                                                                          .index ==
                                                                      1
                                                                  ? FontWeight
                                                                      .w700
                                                                  : FontWeight
                                                                      .w400,
                                                          color: otherPofileprovider
                                                                      .index ==
                                                                  1
                                                              ? white
                                                              : white
                                                                  .withOpacity(
                                                                      0.6)),
                                                    ),
                                                    SizedBox(height: 2.h),
                                                    Container(
                                                        height: 1,
                                                        color: otherPofileprovider
                                                                    .index ==
                                                                1
                                                            ? orange
                                                            : Colors
                                                                .transparent)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                  SizedBox(height: 12.h),
                                  otherPofileprovider.index == 3
                                      ? Expanded(
                                          child: Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(20),
                                              left: ScreenUtil().setWidth(12),
                                              right: ScreenUtil().setWidth(12)),
                                          child: jobs(),
                                        ))
                                      : otherPofileprovider.index == 5
                                          ? otherPofileprovider.index == 0
                                              ? jobs()
                                              : jobs()
                                          : otherPofileprovider.index == 0
                                              ? Column(children: [
                                                  Row(children: [
                                                    Text(
                                                      'Available for:',
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                              fontSize: 12.sp,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: white),
                                                    ),
                                                    SizedBox(width: 12.w),
                                                    Container(
                                                      height: 50.h,
                                                      width: 160.w,
                                                      child: ListView.builder(
                                                          itemCount:
                                                              piclist.length,
                                                          shrinkWrap: true,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          primary: false,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int i) {
                                                            return Padding(
                                                              padding: EdgeInsets.only(
                                                                  right: ScreenUtil()
                                                                      .setWidth(
                                                                          12),
                                                                  top: ScreenUtil()
                                                                      .setWidth(
                                                                          10)),
                                                              child: Column(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    piclist[i],
                                                                    height: ScreenUtil()
                                                                        .setHeight(
                                                                            16),
                                                                    width: ScreenUtil()
                                                                        .setWidth(
                                                                            16),
                                                                    color:
                                                                        orange,
                                                                  ),
                                                                  SizedBox(
                                                                    height: ScreenUtil()
                                                                        .setHeight(
                                                                            10),
                                                                  ),
                                                                  Text(
                                                                      gridtext[
                                                                          i],
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts
                                                                          .nunitoSans(
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color:
                                                                            white,
                                                                        fontSize:
                                                                            ScreenUtil().setSp(12),
                                                                        height:
                                                                            0.16,
                                                                      )),
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                    ),
                                                  ]),
                                                  SizedBox(height: 16.h),
                                                  Row(
                                                    children: [
                                                      Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(children: [
                                                              Text(
                                                                'Height: ',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts
                                                                    .nunitoSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: white,
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              12),
                                                                  height: 0.22,
                                                                ),
                                                              ),
                                                              Text(
                                                                '${otherPofileprovider!.otherprofilejob[0].profileFaces![0].height!.foot}’ ${otherPofileprovider!.otherprofilejob[0].profileFaces![0].height!.inch}”',
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
                                                                              12),
                                                                  height: 0.22,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 12.w),
                                                              Text(
                                                                'Weight: ',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts
                                                                    .nunitoSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: white,
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              12),
                                                                  height: 0.22,
                                                                ),
                                                              ),
                                                              Text(
                                                                '${otherPofileprovider!.otherprofilejob[0].profileFaces![0].weight}kg',
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
                                                                              12),
                                                                  height: 0.22,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 12.w),
                                                              Text(
                                                                'Vitals: ',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts
                                                                    .nunitoSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: white,
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              12),
                                                                  height: 0.22,
                                                                ),
                                                              ),
                                                              Text(
                                                                'B ${otherPofileprovider!.otherprofilejob[0].profileFaces![0].bust}, W ${otherPofileprovider!.otherprofilejob[0].profileFaces![0].waist}, H ${otherPofileprovider!.otherprofilejob[0].profileFaces![0].hip}',
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
                                                                              12),
                                                                  height: 0.22,
                                                                ),
                                                              ),
                                                            ]),
                                                            SizedBox(
                                                                height: 20.h),
                                                            Row(children: [
                                                              Text(
                                                                'Eye Color: ',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts
                                                                    .nunitoSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: white,
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              12),
                                                                  height: 0.22,
                                                                ),
                                                              ),
                                                              Text(
                                                                '${otherPofileprovider!.otherprofilejob[0].profileFaces![0].eyeColor}',
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
                                                                              12),
                                                                  height: 0.22,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 12.w),
                                                              Text(
                                                                'Complexion: ',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts
                                                                    .nunitoSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: white,
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              12),
                                                                  height: 0.22,
                                                                ),
                                                              ),
                                                              Text(
                                                                '${otherPofileprovider!.otherprofilejob[0].profileFaces![0].complexion}',
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
                                                                              12),
                                                                  height: 0.22,
                                                                ),
                                                              ),
                                                            ]),
                                                            SizedBox(
                                                                height: 13.h),
                                                          ]),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Interested Locations:',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: white,
                                                          fontSize: ScreenUtil()
                                                              .setSp(14),
                                                        ),
                                                      ),
                                                      SizedBox(width: 8.w),
                                                      Container(
                                                        height: 70.h,
                                                        width: 130.w,
                                                        child: Wrap(
                                                          children: [
                                                            ListView.builder(
                                                                shrinkWrap:
                                                                    true,
                                                                primary: false,
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                itemCount: otherPofileprovider!
                                                                    .otherprofilejob[
                                                                        0]
                                                                    .profileFaces![
                                                                        0]
                                                                    .interestedLoc!
                                                                    .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        i) {
                                                                  return Padding(
                                                                    padding: EdgeInsets.only(
                                                                        bottom:
                                                                            8.h),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              5.h,
                                                                          width:
                                                                              5.w,
                                                                          decoration: BoxDecoration(
                                                                              color: white,
                                                                              shape: BoxShape.circle),
                                                                        ),
                                                                        SizedBox(
                                                                            width:
                                                                                5.w),
                                                                        Text(
                                                                          '${otherPofileprovider!.otherprofilejob[0].profileFaces![0].interestedLoc![i].district}',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              GoogleFonts.nunitoSans(
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color:
                                                                                white,
                                                                            fontSize:
                                                                                ScreenUtil().setSp(12),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  //   SizedBox(height: 5.h),
                                                  Container(
                                                      height: 110.h,
                                                      child: ListView.builder(
                                                          primary: false,
                                                          shrinkWrap: true,
                                                          itemCount:
                                                              otherPofileprovider!
                                                                  .otherprofilejobpost
                                                                  .length,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          physics:
                                                              ClampingScrollPhysics(),
                                                          itemBuilder:
                                                              (context, i) {
                                                            return InkWell(
                                                              onTap: () {
                                                                //  setState(() {
                                                                show(context);
                                                                //  });
                                                              },
                                                              child: Stack(
                                                                children: [
                                                                  Container(
                                                                    height: ScreenUtil()
                                                                        .setHeight(
                                                                            116),
                                                                    width: ScreenUtil()
                                                                        .setWidth(
                                                                            116),
                                                                    child: Image
                                                                        .network(
                                                                      "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${otherPofileprovider!.otherprofilejobpost![i].video}-xs",
                                                                      height:
                                                                          116.h,
                                                                      width:
                                                                          116.h,
                                                                    ),
                                                                  ),
                                                                  if (i ==
                                                                      0) ...[
                                                                    Center(
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/icons/rect.png",
                                                                        height:
                                                                            125.h,
                                                                        width:
                                                                            115.w,
                                                                      ),
                                                                    ),
                                                                  ]
                                                                ],
                                                              ),
                                                            );
                                                          })),
                                                  SizedBox(height: 16.h),
                                                ])
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                      Row(children: [
                                                        Text(
                                                          'Available for:',
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: white),
                                                        ),
                                                        SizedBox(width: 12.w),
                                                        Container(
                                                          height: 50.h,
                                                          width: 160.w,
                                                          child: Row(
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    piclist[1],
                                                                    height: ScreenUtil()
                                                                        .setHeight(
                                                                            16),
                                                                    width: ScreenUtil()
                                                                        .setWidth(
                                                                            16),
                                                                    color:
                                                                        orange,
                                                                  ),
                                                                  SizedBox(
                                                                    height: ScreenUtil()
                                                                        .setHeight(
                                                                            10),
                                                                  ),
                                                                  Text('Video',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts
                                                                          .nunitoSans(
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color:
                                                                            white,
                                                                        fontSize:
                                                                            ScreenUtil().setSp(12),
                                                                        height:
                                                                            0.16,
                                                                      )),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Column(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    piclist[3],
                                                                    height: ScreenUtil()
                                                                        .setHeight(
                                                                            16),
                                                                    width: ScreenUtil()
                                                                        .setWidth(
                                                                            16),
                                                                    color:
                                                                        orange,
                                                                  ),
                                                                  SizedBox(
                                                                    height: ScreenUtil()
                                                                        .setHeight(
                                                                            10),
                                                                  ),
                                                                  Text('Film',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts
                                                                          .nunitoSans(
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color:
                                                                            white,
                                                                        fontSize:
                                                                            ScreenUtil().setSp(12),
                                                                        height:
                                                                            0.16,
                                                                      )),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ]),
                                                      SizedBox(height: 16.h),
                                                      Text(
                                                        'Awards Won: ',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: white,
                                                          fontSize: ScreenUtil()
                                                              .setSp(14),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5.w),
                                                        child: Text(
                                                          "${otherPofileprovider!.otherprofilejob[0].profileCrew![0].achievements}",
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: white,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(12),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 8.h),
                                                      Text(
                                                        'Work Experience: ',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: white,
                                                          fontSize: ScreenUtil()
                                                              .setSp(14),
                                                        ),
                                                      ),
                                                      Text(
                                                        "${otherPofileprovider!.otherprofilejob[0].profileCrew![0].experienceLevel}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: white,
                                                          fontSize: ScreenUtil()
                                                              .setSp(12),
                                                        ),
                                                      ),
                                                      SizedBox(height: 16.h),
                                                      Text(
                                                        'Interested Locations:',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: white,
                                                          fontSize: ScreenUtil()
                                                              .setSp(14),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5.w,
                                                                top: 5.h),
                                                        child: Container(
                                                          height: 70.h,
                                                          width: 130.w,
                                                          child: Wrap(
                                                            children: [
                                                              ListView.builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  primary:
                                                                      false,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  itemCount: otherPofileprovider!
                                                                      .otherprofilejob[
                                                                          0]
                                                                      .profileCrew![
                                                                          0]
                                                                      .interestedLoc!
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          i) {
                                                                    return Padding(
                                                                      padding: EdgeInsets.only(
                                                                          bottom:
                                                                              5.h),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                5.h,
                                                                            width:
                                                                                5.w,
                                                                            decoration:
                                                                                BoxDecoration(color: white, shape: BoxShape.circle),
                                                                          ),
                                                                          SizedBox(
                                                                              width: 5.w),
                                                                          Text(
                                                                            "${otherPofileprovider!.otherprofilejob[0].profileCrew![0].interestedLoc![i].district}",
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style:
                                                                                GoogleFonts.nunitoSans(
                                                                              fontWeight: FontWeight.w400,
                                                                              color: white,
                                                                              fontSize: ScreenUtil().setSp(12),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      //  SizedBox(height: 10.h),
                                                      Container(
                                                          height: 110.h,
                                                          child:
                                                              ListView.builder(
                                                                  primary:
                                                                      false,
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount:
                                                                      otherPofileprovider!
                                                                          .otherprofilejobpost
                                                                          .length,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  physics:
                                                                      ClampingScrollPhysics(),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  itemBuilder:
                                                                      (context,
                                                                          i) {
                                                                    return InkWell(
                                                                      onTap:
                                                                          () {
                                                                        // setState(() {
                                                                        show(
                                                                            context);
                                                                        // });
                                                                      },
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                ScreenUtil().setHeight(116),
                                                                            width:
                                                                                ScreenUtil().setWidth(116),
                                                                            child:
                                                                                Image.network(
                                                                              "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${otherPofileprovider!.otherprofilejobpost![i].video}-xs",
                                                                              height: 116.h,
                                                                              width: 116.h,
                                                                            ),
                                                                          ),
                                                                          if (i ==
                                                                              0) ...[
                                                                            Center(
                                                                              child: Image.asset(
                                                                                "assets/icons/rect.png",
                                                                                height: 125.h,
                                                                                width: 115.w,
                                                                              ),
                                                                            ),
                                                                          ]
                                                                        ],
                                                                      ),
                                                                    );
                                                                  })),
                                                      SizedBox(height: 16.h),
                                                    ]),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Container();
      },
    );
  }

  Container jobs() {
    return Container(
      child: ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        primary: false,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(16)),
            child: Container(
              decoration: BoxDecoration(
                  color: white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.2))),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(10),
                        left: ScreenUtil().setWidth(24)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IntrinsicWidth(
                              child: Column(children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 14.5.h, right: 10.w),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(15)),
                                        child: Text(
                                          'Female, 18-28 yrs',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w700,
                                            color: white,
                                            fontSize: ScreenUtil().setSp(16),
                                            height: 0.22,
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 2.0),
                                                blurRadius: 2.0,
                                                color: Color(0xff000000)
                                                    .withOpacity(0.25),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(12),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(15)),
                                        child: Text('5’ 6”',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize: ScreenUtil().setSp(16),
                                              height: 0.22,
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(0.0, 2.0),
                                                  blurRadius: 2.0,
                                                  color: Color(0xff000000)
                                                      .withOpacity(0.25),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 13.h),
                                  child: Container(
                                    height: 1,
                                    decoration:
                                        BoxDecoration(color: white, boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 2),
                                        color: white,
                                        blurRadius: 2.0,
                                      ),
                                    ]),
                                  ),
                                ),
                              ]),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: Container(
                                height: 50.h,
                                width: 105.w,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: ListView.builder(
                                      itemCount: 1,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              right: ScreenUtil().setWidth(12),
                                              top: ScreenUtil().setWidth(10)),
                                          child: Column(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/svg/photoshoot.svg",
                                                height:
                                                    ScreenUtil().setHeight(25),
                                                width:
                                                    ScreenUtil().setWidth(25),
                                                color: orange,
                                              ),
                                              SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(10),
                                              ),
                                              Text('Print',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    color: white,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    height: 0.16,
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                        offset:
                                                            Offset(0.0, 2.0),
                                                        blurRadius: 2.0,
                                                        color: Color(0xff000000)
                                                            .withOpacity(0.25),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(20),
                                right: ScreenUtil().setWidth(12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Mumbai',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      color: white,
                                      fontSize: ScreenUtil().setSp(14),
                                      height: 0.19,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 2.0,
                                          color: Color(0xff000000)
                                              .withOpacity(0.25),
                                        ),
                                      ],
                                    )),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(24),
                              right: ScreenUtil().setWidth(6)),
                          child: Container(
                            height: 100.h,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: 2,
                                scrollDirection: Axis.horizontal,
                                controller: _scroll,
                                itemBuilder: (context, i1) {
                                  return i1 == 0
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    child: Text(
                                                      'Models required for Ethenic Wear shoot',
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: white,
                                                        fontSize: ScreenUtil()
                                                            .setSp(22),
                                                        height: 1.2,
                                                        shadows: <Shadow>[
                                                          Shadow(
                                                            offset: Offset(
                                                                0.0, 2.0),
                                                            blurRadius: 2.0,
                                                            color: Color(
                                                                    0xff000000)
                                                                .withOpacity(
                                                                    0.25),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  // Spacer(),
                                                  InkWell(
                                                      onTap: () {
                                                        //    setState(() {
                                                        // scr(1);
                                                        //   });
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        color: white
                                                            .withOpacity(0.8),
                                                        size: ScreenUtil()
                                                            .radius(15),
                                                      ))
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(20),
                                              ),
                                              Text(
                                                'From 15-Sep-21 till 20-Sep-21',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w600,
                                                  color: black,
                                                  fontSize:
                                                      ScreenUtil().setSp(12),
                                                  height: 0.16,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 2.0),
                                                      blurRadius: 2.0,
                                                      color: Color(0xff000000)
                                                          .withOpacity(0.25),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    // setState(() {
                                                    // scr(0);
                                                    //  });
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: ScreenUtil()
                                                            .setHeight(15)),
                                                    child: Icon(
                                                        Icons
                                                            .arrow_back_ios_rounded,
                                                        color: white
                                                            .withOpacity(0.8),
                                                        size: 15),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      ScreenUtil().setWidth(10),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      88,
                                                  child: Text(
                                                    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                                    // trimLines: 4,
                                                    // trimMode: TrimMode.Line,
                                                    // colorClickableText: white,
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: white,
                                                      fontSize: ScreenUtil()
                                                          .setSp(14),
                                                      height: 1.2,
                                                      shadows: <Shadow>[
                                                        Shadow(
                                                          offset:
                                                              Offset(0.0, 2.0),
                                                          blurRadius: 2.0,
                                                          color:
                                                              Color(0xff000000)
                                                                  .withOpacity(
                                                                      0.25),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(20)),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: ScreenUtil()
                                                      .setWidth(24)),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Deadline: 13-Sep-21',
                                                    textAlign: TextAlign.left,
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: white,
                                                      fontSize: ScreenUtil()
                                                          .setSp(14),
                                                      height: 0.16,
                                                      shadows: <Shadow>[
                                                        Shadow(
                                                          offset:
                                                              Offset(0.0, 2.0),
                                                          blurRadius: 2.0,
                                                          color:
                                                              Color(0xff000000)
                                                                  .withOpacity(
                                                                      0.25),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 30.0),
                                                    child: Text(
                                                      'Close',
                                                      textAlign: TextAlign.left,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: white,
                                                        fontSize: ScreenUtil()
                                                            .setSp(14),
                                                        height: 0.16,
                                                        shadows: <Shadow>[
                                                          Shadow(
                                                            offset: Offset(
                                                                0.0, 2.0),
                                                            blurRadius: 2.0,
                                                            color: Color(
                                                                    0xff000000)
                                                                .withOpacity(
                                                                    0.25),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                }),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: ScreenUtil().setHeight(31)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  'Faces',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: white,
                                    fontSize: ScreenUtil().setSp(14),
                                    height: 0.16,
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 2.0),
                                        blurRadius: 2.0,
                                        color:
                                            Color(0xff000000).withOpacity(0.25),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              SvgPicture.asset("assets/icons/svg/share.svg",
                                  color: white),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreateJob()),
                                  );
                                },
                                child: Container(
                                  height: 30.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                    color: white.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: orange),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Edit Job',
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w600,
                                        color: white,
                                        fontSize: ScreenUtil().setSp(12),
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 2.0),
                                            blurRadius: 2.0,
                                            color: Color(0xff000000)
                                                .withOpacity(0.25),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(12)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(3)),
                                  child: Text(
                                    '3 days ago',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      color: white,
                                      fontSize: ScreenUtil().setSp(10),
                                      height: 0.13,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 2.0,
                                          color: Color(0xff000000)
                                              .withOpacity(0.25),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(8)),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0.0, 8.0),
                            blurRadius: 30.0,
                            color: Color(0xff000000).withOpacity(0.40),
                          )
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(16),
                          right: ScreenUtil().setWidth(15),
                          top: ScreenUtil().setHeight(13),
                          bottom: ScreenUtil().setHeight(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BrandDetailApplication()),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Applications',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                    fontSize: ScreenUtil().setSp(12),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 60.h,
                                      width: MediaQuery.of(context).size.width -
                                          120.w,
                                      child: ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: 4,
                                          scrollDirection: Axis.horizontal,
                                          controller: _scroll,
                                          itemBuilder: (context, i2) {
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(right: 15.w),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: Offset(0, 2),
                                                          color: black,
                                                          blurRadius: 2.r,
                                                        ),
                                                      ]),
                                                  child: Image.asset(
                                                    "assets/icons/two.png",
                                                    height: 50.h,
                                                    width: 50.h,
                                                  )),
                                            );
                                          }),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.w),
                                      child: Text(
                                        '20 more',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w400,
                                          color: white,
                                          fontSize: ScreenUtil().setSp(12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.all(1.r),
              child: Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Container(
                    height: 300.h,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: EdgeInsets.only(right: 15.w),
                            child: Container(
                              height: 300.h,
                              width: MediaQuery.of(context).size.width - 100.w,
                              child: SvgPicture.asset(
                                "assets/icons/svg/icon.svg",
                              ),
                            ),
                          );
                        })),
              ));
        });
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
