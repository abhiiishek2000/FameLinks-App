import 'package:famelink/ui/funlinks/provider/FunLinksFeedProvider.dart';
import 'package:famelink/util/ReadMoreText.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/common_image.dart';
import '../../../networking/config.dart';
import '../../../share/firebasedynamiclink.dart';
import '../../../util/widgets/FeedVideoPlayer.dart';
import '../../ChattingScreen.dart';
import '../../Famelinkprofile/function/famelinkFun.dart';
import '../../latest_profile/SayHiFirstVideo.dart';
import '../component/OtherprofileContainer.dart';
import '../provder/OtherPofileprovider.dart';
import '../ui/GetParticularFunLinksProfile.dart';
import 'circleButtonImageStack.dart';
import 'darkcircleButtonImageStack.dart';
import 'showReferralCodeDialog.dart';

class Phashetow extends StatelessWidget {
  Phashetow({Key? key, this.id, this.isshow}) : super(key: key);
  String? id;
  String? isshow;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Consumer2<OtherPofileprovider, FunLinksFeedProvider>(
      builder: (context, otherPofileprovider, funLinksProvider, child) {
        // print(
        //     "Jay mata di fun ${otherPofileprovider.otherUserProfileFunLinksModel[0].posts!.length}");

        return Column(
          children: <Widget>[
            Visibility(
                visible: true,
                child: //otherPofileprovider!.otherUserProfileFunLinksModel.length != 0
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
                          Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                otherPofileprovider!
                                        .otherUserProfileFunLinksModel
                                        .isNotEmpty
                                    ? otherPofileprovider!
                                        .otherUserProfileFunLinksModel[0]
                                        .totalLikes
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
                              Image.asset(
                                CommonImage.funLinksHeart,
                                height: 30,
                                width: 30,
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
                                        .otherUserProfileFunLinksModel
                                        .isNotEmpty
                                    ? otherPofileprovider!
                                        .otherUserProfileFunLinksModel[0]
                                        .totalViews
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
                              Row(
                                children: [
                                  Text(
                                    "Views",
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Image.asset(
                                    CommonImage.funLinksViews,
                                    height: 14,
                                    width: 12,
                                  )
                                ],
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
                                        .otherUserProfileFunLinksModel
                                        .isNotEmpty
                                    ? otherPofileprovider!
                                        .otherUserProfileFunLinksModel[0]
                                        .savedMusic!
                                        .length
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
                              Row(
                                children: [
                                  Text(
                                    "Music",
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(width: 5.0),
                                  Image.asset(
                                    CommonImage.funLinksViews,
                                    height: 14,
                                    width: 12,
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  // setState(() {
                                  otherPofileprovider!.yourMusicClicked =
                                      !otherPofileprovider!.yourMusicClicked;
                                  otherPofileprovider!.trendsSetClicked = false;
                                  otherPofileprovider!.titleWonClicked = false;
                                  otherPofileprovider!.yourVideoClicked = false;
                                  otherPofileprovider!.requestClicked = false;
                                  // });
                                },
                                child: otherPofileprovider!.yourMusicClicked ==
                                        true
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
                              Row(
                                children: [
                                  Text(
                                    otherPofileprovider!
                                            .otherUserProfileFunLinksModel
                                            .isNotEmpty
                                        ? otherPofileprovider!
                                            .otherUserProfileFunLinksModel[0]
                                            .posts!
                                            .length
                                            .toString()
                                        : "",
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(width: 5.0),
                                  Image.asset(
                                    CommonImage.funLinksVideo,
                                    height: 14,
                                    width: 14,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "Videos",
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                              InkWell(
                                onTap: () {
                                  // setState(() {
                                  otherPofileprovider!.yourVideoClicked =
                                      !otherPofileprovider!.yourVideoClicked;
                                  print("clicked========================");
                                  otherPofileprovider!.trendsSetClicked = false;
                                  otherPofileprovider!.titleWonClicked = false;
                                  otherPofileprovider!.yourMusicClicked = false;
                                  otherPofileprovider!.requestClicked = false;
                                  // });
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white.withOpacity(0.25),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                // : Center(
                //     child: CircularProgressIndicator())
                ),
            if (otherPofileprovider!.otherUserProfileFunLinksModel.length !=
                    0 &&
                otherPofileprovider!.yourMusicClicked == true)
              ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: otherPofileprovider!
                    .otherUserProfileFunLinksModel[0].savedMusic!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          child: FeedVideoPlayer(
                              videoUrl:
                                  "${ApiProvider.s3UrlPath}/${ApiProvider.funlinksMusic}/${otherPofileprovider!.otherUserProfileFunLinksModel[0].savedMusic![index].music}"),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${otherPofileprovider!.otherUserProfileFunLinksModel[0].savedMusic![index].name}",
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${otherPofileprovider!.otherUserProfileFunLinksModel[0].savedMusic![index].duration}sec",
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              )
            else
              Container(),
            SizedBox(
              height: (ScreenUtil().screenHeight * 0.02).ceilToDouble(),
            ),
            // otherPofileprovider!.otherUserProfileFunLinksModel.length != 0
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // otherPofileprovider!.otherUserProfileFunLinksModel !=
                      //             null &&
                      //         otherPofileprovider!.otherUserProfileFunLinksModel[
                      //                     0]
                      //                 .profession !=
                      //             null
                      IntrinsicWidth(
                        child: Column(
                          children: [
                            Text(
                                otherPofileprovider!
                                            .otherUserProfileFunLinksModel
                                            .isNotEmpty &&
                                        otherPofileprovider!
                                                .otherUserProfileFunLinksModel[
                                                    0]
                                                .profession !=
                                            null &&
                                        otherPofileprovider!
                                            .otherUserProfileFunLinksModel[0]
                                            .profession!
                                            .isNotEmpty
                                    ? "${otherPofileprovider!.otherUserProfileFunLinksModel[0].profession![0].toUpperCase() + otherPofileprovider!.otherUserProfileFunLinksModel[0].profession!.substring(1)}: "
                                    : "",
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                  color: Colors.white,
                                )),
                            SizedBox(height: 2.h),
                            Container(
                              height: 1.h,
                              color: Color(0xffFF5C28),
                            )
                          ],
                        ),
                      )
                      // : Container()
                      ,
                      SizedBox(
                        width: 5.w,
                      ),
                      // otherPofileprovider!.otherUserProfileFunLinksModel[0]
                      //             .ambassador
                      //             .length !=
                      //         0
                      IntrinsicWidth(
                        child: Column(
                          children: [
                            Visibility(
                                child: Container(
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(2)),
                              child: Text(
                                  otherPofileprovider!
                                              .otherUserProfileFunLinksModel
                                              .isNotEmpty &&
                                          otherPofileprovider!
                                              .otherUserProfileFunLinksModel[0]
                                              .ambassador!
                                              .isNotEmpty
                                      ? "${otherPofileprovider!.otherUserProfileFunLinksModel[0].ambassador![0].title}"
                                      : "",
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Colors.white,
                                  )),
                            )),
                            SizedBox(height: 3.h),
                            Container(
                              height: 1.h,
                              color: Color(0xff0060FF),
                            )
                          ],
                        ),
                      )
                      // : Container(),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  otherPofileprovider.profileFameLinksList.isNotEmpty &&
                          otherPofileprovider!
                                  .otherUserProfileFunLinksModel[0].bio ==
                              null
                      ? Container()
                      : Container(
                          child: ReadMoreText(
                            otherPofileprovider.profileFameLinksList.isNotEmpty
                                ? otherPofileprovider
                                    .profileFameLinksList[0].bio!
                                : "",
                            trimLines: 3,
                            trimMode: TrimMode.Line,
                            colorClickableText: lightGray,
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w400,
                                color: white),
                          ),
                        ),
                ],
              ),
            )
            // : Container()
            ,
            otherPofileprovider!.otherUserProfileFunLinksModel.length != 0
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
                                    // overflow: Overflow.visible,
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
                                                                .otherUserProfileFunLinksModel[
                                                                    0]
                                                                .profileImageType ==
                                                            "image"
                                                        ? CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${otherPofileprovider!.otherUserProfileFunLinksModel[0].profileImage}"),
                                                            radius: 15,
                                                          )
                                                        : CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${otherPofileprovider!.otherUserProfileFunLinksModel[0].profileImage}"),
                                                            radius: 15,
                                                          ),
                                                    SizedBox(
                                                      width: 8.0,
                                                    ),
                                                    Text(
                                                      otherPofileprovider!
                                                                  .otherUserProfileFunLinksModel[
                                                                      0]
                                                                  .name !=
                                                              null
                                                          ? otherPofileprovider!
                                                              .otherUserProfileFunLinksModel[
                                                                  0]
                                                              .name!
                                                          : otherPofileprovider!
                                                              .otherUserProfileFunLinksModel[
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
                                                  otherPofileprovider!
                                                              .otherUserProfileFunLinksModel[
                                                                  0]
                                                              .followStatus ==
                                                          "Following"
                                                      ? InkWell(
                                                          onTap: () {
                                                            otherPofileprovider
                                                                .getUnFollowFunStatus(
                                                                    id!)
                                                                .then((value) =>
                                                                    funLinksProvider
                                                                        .getUnFollowStatus(
                                                                            id!));
                                                          },
                                                          child: Container(
                                                              height:
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          23),
                                                              width:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          81),
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
                                                                border:
                                                                    GradientBoxBorder(
                                                                        gradient:
                                                                            LinearGradient(colors: [
                                                                  HexColor(
                                                                      '#FFA88C'),
                                                                  HexColor(
                                                                      '#FF5C28'),
                                                                ])),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                                color: Colors
                                                                    .transparent,
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                'Following',
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
                                                                .getFollowFunStatus(
                                                                    id!)
                                                                .then((value) =>
                                                                    funLinksProvider
                                                                        .getFollowStatus(
                                                                            id!));
                                                          },
                                                          child: Container(
                                                              height:
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          23),
                                                              width:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          81),
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
                                                                color: Colors
                                                                    .transparent,
                                                                border:
                                                                    GradientBoxBorder(
                                                                        gradient:
                                                                            LinearGradient(colors: [
                                                                  HexColor(
                                                                      '#FFA88C'),
                                                                  HexColor(
                                                                      '#FF5C28'),
                                                                ])),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                'Follow',
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
                                                          "${otherPofileprovider.otherUserProfileFunLinksModel[0].masterUser!.district},${otherPofileprovider!.otherUserProfileFunLinksModel[0].masterUser!.state},${otherPofileprovider!.otherUserProfileFunLinksModel[0].masterUser!.country}",
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
                                                      /*                                                                        Text(
                                                                          '0',
                                                                          style:
                                                                              GoogleFonts.nunitoSans(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              5.0,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              15.68,
                                                                          width:
                                                                              21.33,
                                                                          child:
                                                                              Image.asset(
                                                                            CommonImage.funLinksStoreHosportIcon,
                                                                            height:
                                                                                15.68,
                                                                            width:
                                                                                21.33,
                                                                            fit:
                                                                                BoxFit.fill,
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
                                                                .otherUserProfileFunLinksModel
                                                                .isNotEmpty
                                                            ? otherPofileprovider!
                                                                .otherUserProfileFunLinksModel[
                                                                    0]
                                                                .masterUser!
                                                                .fameCoins
                                                                .toString()
                                                            : "",
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
                                                      "otherprofilefun";

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

                                                      if (otherPofileprovider
                                                              .selectPhase ==
                                                          0) {
                                                        valu = "contest";
                                                      }
                                                      if (otherPofileprovider
                                                              .selectPhase ==
                                                          1) {
                                                        valu = "funlinks";
                                                      } else if (otherPofileprovider
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
                                                .otherUserProfileFunLinksModel[
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
                                                                      .otherUserProfileFunLinksModel
                                                                      .isNotEmpty &&
                                                                  otherPofileprovider!
                                                                          .otherUserProfileFunLinksModel[
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
                                                                      .otherUserProfileFunLinksModel[
                                                                          0]
                                                                      .profileImageType !=
                                                                  "image"
                                                              ? Image.network(
                                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${otherPofileprovider!.otherUserProfileFunLinksModel.isNotEmpty ? otherPofileprovider!.otherUserProfileFunLinksModel[0].profileImage : ""}",
                                                                  fit: BoxFit
                                                                      .cover)
                                                              : Image.network(
                                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${otherPofileprovider!.otherUserProfileFunLinksModel.isNotEmpty ? otherPofileprovider!.otherUserProfileFunLinksModel[0].profileImage : ""}",
                                                                  fit: BoxFit
                                                                      .cover)),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                            });
                                  },
                                  // TODO: FunLinks Dialer
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Visibility(
                                        visible: true,
                                        child: Container(
                                          height: h * 0.2,
                                          width: w * 0.52,
                                          child: Stack(
                                            // overflow: Overflow
                                            //     .visible,
                                            fit: StackFit.loose,
                                            alignment: Alignment.centerRight,
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
                                              // TODO: CIRCLE AVATAR
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
                                                              .otherUserProfileFunLinksModel
                                                              .length ==
                                                          0
                                                      ? Container()
                                                      : otherPofileprovider!
                                                                  .otherUserProfileFunLinksModel[
                                                                      0]
                                                                  .profileImageType !=
                                                              null
                                                          ? Container(
                                                              margin: EdgeInsets
                                                                  .all(4),
                                                              height: h * 0.5,
                                                              width: w * 0.5,
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundImage: otherPofileprovider!
                                                                            .otherUserProfileFunLinksModel[
                                                                                0]
                                                                            .profileImageType ==
                                                                        "image"
                                                                    ? NetworkImage(
                                                                        "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${otherPofileprovider!.otherUserProfileFunLinksModel.isNotEmpty ? otherPofileprovider!.otherUserProfileFunLinksModel[0].profileImage : ""}")
                                                                    : NetworkImage(
                                                                        "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${otherPofileprovider!.otherUserProfileFunLinksModel.isNotEmpty ? otherPofileprovider!.otherUserProfileFunLinksModel[0].profileImage : ""}"),
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                radius: 50,
                                                              ),
                                                            )
                                                          : Container(
                                                              height: h * 0.5,
                                                              width: w * 0.5,
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
                                                                          .otherUserProfileFunLinksModel
                                                                          .isNotEmpty
                                                                      ? otherPofileprovider!
                                                                          .otherUserProfileFunLinksModel[
                                                                              0]
                                                                          .name![
                                                                              0]
                                                                          .toString()
                                                                          .toUpperCase()
                                                                      : "",
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
                                                          "******************* Fame Links Work");
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
                                                      //FameLinksFeedState.selectRunType = "famelinks";
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
                                                right: w * 0.225, //90
                                                bottom: h * 0.085,
                                                child: SizedBox(
                                                  height: 30,
                                                  // width: 95,//91
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
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 6.0,
                                                                  right: 4.0,
                                                                  top: 2.0,
                                                                  bottom: 2.0),
                                                          child: Text(
                                                            "FUN",
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14.0,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 7, //5
                                                        ),
                                                        darkcircleButtonImageStack(
                                                            imgUrl:
                                                                'assets/icons/FunLinks2.svg')
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // right: MediaQuery.of(context).size.width/2,
                                              ),
                                              // // right FollowLinks
                                              Positioned(
                                                right: w * 0.13,
                                                //left: 20.0,
                                                bottom: h * 0.01,
                                                child: SizedBox(
                                                  height: 30,
                                                  width: 50,
                                                  child: InkWell(
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
                                                        circleButtonImageStack(
                                                            imgUrl:
                                                                'assets/icons/FollowLinks2.svg')
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
                                        .otherUserProfileFunLinksModel.length !=
                                    0
                                ? Visibility(
                                    visible: true,
                                    child: SizedBox(
                                        width: ScreenUtil().screenWidth,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 2, right: 10, top: 10),
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
                                                .otherUserProfileFunLinksModel[
                                                    0]
                                                .posts!
                                                .length,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder:
                                                (BuildContext ctx, index) {
                                              return InkWell(
                                                  onTap: () {
                                                    print(
                                                        '101-10101101-111010-');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            GetParticularFunLinksProfile(
                                                                id: otherPofileprovider!
                                                                    .otherUserProfileFunLinksModel[
                                                                        0]
                                                                    .sId,
                                                                index: index),
                                                      ),
                                                    );
                                                  },
                                                  // child:
                                                  //     Container(
                                                  //   child: Image
                                                  //       .network(
                                                  //     "${ApiProvider.funPostImageBaseUrl}/${otherPofileprovider!.otherUserProfileFunLinksModel[0].posts[index].video}",
                                                  //     fit: BoxFit
                                                  //         .cover,
                                                  //   ),
                                                  // ),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Container(
                                                        width: 240,
                                                        height: 110,
                                                        child: Image.network(
                                                          "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${otherPofileprovider!.otherUserProfileFunLinksModel[0].posts![index].video}",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: otherPofileprovider!
                                                                    .otherUserProfileFunLinksModel[
                                                                        0]
                                                                    .posts![
                                                                        index]
                                                                    .video !=
                                                                null &&
                                                            otherPofileprovider!
                                                                .otherUserProfileFunLinksModel[
                                                                    0]
                                                                .posts![index]
                                                                .video!
                                                                .isNotEmpty,
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
                                                  ));
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
            otherPofileprovider!.otherUserProfileFunLinksModel.length != 0 &&
                    otherPofileprovider!.yourVideoClicked == true
                ? SizedBox(
                    width: ScreenUtil().screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
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
                        itemCount: otherPofileprovider!.userPostsfun!.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext ctx, index) {
                          return Container(
                              // height: double.infinity,
                              //                 alignment: Alignment.center,
                              child: InkWell(
                            onTap: () {
                              // Navigator
                              //     .push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         GetParticularUserProfile(
                              //             id: otherPofileprovider!.otherUserProfileFunLinksModel[
                              //             0]
                              //                 .posts[
                              //             index]
                              //                 .sId),
                              //   ),
                              // );
                            },
                            child: Stack(
                              children: [
                                Image.network(
                                  "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${otherPofileprovider!.userPostsfun![index].video}",
                                  fit: BoxFit.cover,
                                  // height: 150.h,
                                  // width: 100.w,
                                ),
                                Visibility(
                                  visible: otherPofileprovider!
                                          .userPostsfun![index].video !=
                                      null,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: SvgPicture.asset(
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
                          ));
                        },
                      ),
                    ),
                  )
                : Container(),
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
