import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../common/common_image.dart';
import '../../dio/api/api.dart';
import '../../networking/config.dart';
import '../../providers/UserProfileProvider/userProfile_provider.dart';
import '../../util/config/color.dart';
import '../../util/constants.dart';
import '../../util/widgets/FeedVideoPlayer.dart';
import '../Famelinkprofile/function/famelinkFun.dart';
import '../latest_profile/SayHiFirstVideo.dart';
import '../otherUserProfile/ui/GetParticularFunLinksProfile.dart';
import '../otherUserProfile/ui/GetParticularUserProfile.dart';
import '../otherUserProfile/ui/GetPerticularFollowLinksProfile.dart';
import '../profile/brand_details_screen.dart';
import '../profile_UI/PhotoImageScreen.dart';
import 'widget/FamelinkwidgetTop.dart';
import 'widget/SelfProfileDiler.dart';
import 'widget/famelinknameField.dart';
import 'widget/followLinksNameField.dart';
import 'widget/followLinksWidgetTop.dart';
import 'widget/funLinksNameField.dart';
import 'widget/funlinkswidgettop.dart';
import 'widget/jobLinksWidgetTop.dart';
import 'widget/storeLinksNameField.dart';

class SelfprofileUiWhitemode extends StatelessWidget {
  SelfprofileUiWhitemode(
      {Key? key,
      required this.itemHeight,
      required this.itemWidth,
      required this.id,
      required this.status})
      : super(key: key);

  final double itemHeight, itemWidth;
  final String id, status;
  @override
  Widget build(BuildContext context) {
    return Consumer2<FameLinkFun, UserProfileProvider>(
      builder: (context, provider, userProfileData, child) {
        //userProfileData.getProfileFameLinkslocal();
        // print(
        //     "amar12345 ${provider.profileFameLinksModelResult!.result.toString()}");
        return SingleChildScrollView(
          controller: provider.scrollControllerpage,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Visibility(
                      visible: (provider.selectPhase == 0),
                      child:
                          //Constants.userType == 'agency' is newly added
                          Constants.userType == 'brand' ||
                                  Constants.userType == 'agency' &&
                                      provider.myFameResult.length != 0 ||
                                  Constants.userType != 'brand' ||
                                  Constants.userType != 'agency'
                              ? FamelinkwidgetTopWhitemode()
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 11),
                                  child: Container(
                                    height: 80,
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                )),

                  (provider.selectPhase == 1)
                      ? funLinksWidgetTopWhitemode()
                      : (provider.selectPhase == 2)
                          ? followLinksWidgetTopWhitemode(id: id)
                          : (provider.selectPhase == 3)
                              ? jobLinksWidgetTopWhitemode()
                              : Container(),

                  SizedBox(
                    height: 10,
                  ),

                  provider.profileFameLinksModelResult.result!.length != 0 &&
                          userProfileData.getTitleWonClicked == true
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: provider.profileFameLinksModelResult
                              .result![0].titlesWon!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${provider.profileFameLinksModelResult.result![0].titlesWon![index].title} -",
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${provider.profileFameLinksModelResult.result![0].titlesWon![index].season} -",
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${provider.profileFameLinksModelResult.result![0].titlesWon![index].year} -",
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "[${provider.profileFameLinksModelResult.result![0].titlesWon![index].title}]",
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Container(),

                  provider.profileFameLinksModelResult.result!.length != 0 &&
                          userProfileData.getTrendsSetClicked == true
                      ? ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey,
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: provider.profileFameLinksModelResult
                              .result![0].trendsWon!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      height: 66,
                                      width: 66,
                                      child: Image.network(
                                        "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.profileFameLinksModelResult.result![0].trendsWon![index].media![0].closeUp}",
                                        fit: BoxFit.fill,
                                      )),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${provider.profileFameLinksModelResult.result![0].trendsWon![index].hashTag}",
                                        style: GoogleFonts.nunitoSans(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        height: 28,
                                        // width: 100,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: HexColor("#FF5C28"))),
                                        padding: EdgeInsets.only(
                                            left: 6,
                                            right: 6,
                                            top: 2,
                                            bottom: 2),
                                        child: Text(
                                          "${provider.profileFameLinksModelResult.result![0].trendsWon![index].position},${provider.profileFameLinksModelResult.result![0].trendsWon![index].totalHearts}",
                                          style: GoogleFonts.nunitoSans(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "Participated by${provider.profileFameLinksModelResult.result![0].trendsWon![index].totalParticipants}, ${provider.profileFameLinksModelResult.result![0].trendsWon![index].totalPost} posts",
                                        style: GoogleFonts.nunitoSans(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "${provider.profileFameLinksModelResult.result![0].trendsWon![index].reward![0].giftName}",
                                        style: GoogleFonts.nunitoSans(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      : Container(),

                  provider.profileFunLinksList.length != 0 &&
                          userProfileData.getYourMusicClicked == true
                      ? ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey,
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: provider
                              .profileFunLinksList[0].savedMusic!.length,
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
                                          "${ApiProvider.s3UrlPath}/${ApiProvider.funlinksMusic}/${provider.profileFunLinksList[0].savedMusic![index].music}",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${provider.profileFunLinksList[0].savedMusic![index].name}",
                                        style: GoogleFonts.nunitoSans(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${provider.profileFunLinksList[0].savedMusic![index].duration}sec",
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
                      : Container(),

                  provider.profileFollowLinksList.length != 0 &&
                          provider.requestClicked == true
                      ? ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey,
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: provider
                              .profileFollowLinksList[0].requests!.length,
                          itemBuilder: (BuildContext context, int index) {
                            String date = DateFormat("yyyy-MM-dd hh:mm:ss")
                                .format(DateTime.now());
                            DateTime tempDate =
                                new DateFormat("yyyy-MM-dd hh:mm:ss")
                                    .parse(date);
                            DateTime createdAt = DateTime.parse(provider
                                .profileFollowLinksList[0]
                                .requests![index]
                                .createdAt!);
                            print(createdAt);
                            DateTime dt2 = createdAt;
                            final difference = dt2.difference(tempDate).inDays;
                            return SizedBox(
                              //height: 150,
                              width: ScreenUtil().screenWidth,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 16.0),
                                child: ListTile(
                                  dense: false,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 0.0),
                                  visualDensity: VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  leading: SizedBox(
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                          "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
                                    ),
                                  ),
                                  title: SizedBox(
                                    width: ScreenUtil().screenWidth - 350,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          "${provider.profileFollowLinksList[0].requests![index].name}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.nunitoSans(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: SizedBox(
                                    width: 120,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                provider.getRequest(
                                                    provider
                                                        .profileFollowLinksList[
                                                            0]
                                                        .requests![index]
                                                        .sId!,
                                                    id);
                                              },
                                              child: Text(
                                                "Accept",
                                                style: GoogleFonts.nunitoSans(
                                                    color: HexColor("#FF5C28"),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Spacer(),
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  "Reject",
                                                  style: GoogleFonts.nunitoSans(
                                                      color:
                                                          HexColor("#0060FF"),
                                                      fontSize: 12,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "$difference d ago",
                                          style: GoogleFonts.nunitoSans(
                                            color: HexColor("#9B9B9B"),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: SizedBox(
                                    width: ScreenUtil().screenWidth,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "@${provider.profileFollowLinksList[0].requests![index].username}",
                                          style: GoogleFonts.nunitoSans(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        Icon(
                                          Icons.circle,
                                          size: 5,
                                        ),
                                        Text(
                                          "${provider.profileFollowLinksList[0].requests![index].state}, ${provider.profileFollowLinksList[0].requests![index].country}",
                                          style: GoogleFonts.nunitoSans(
                                              color: HexColor("9B9B9B"),
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Container(),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Visibility(
                        visible: userProfileData.getTrendsSetClicked,
                        child: Padding(
                          padding: EdgeInsets.only(top: 5.0, left: 10),
                          child: Text(
                            'Trendz Sponsored: 5',
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    Constants.userType == 'brand' ? 12 : 14,
                                color: Colors.white),
                          ),
                        ),
                      )),

                  // SizedBox(height: 5,),

                  Visibility(
                    visible: userProfileData.getTrendsSetClicked,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Scrollbar(
                        trackVisibility: true,
                        isAlwaysShown: true,
                        controller: provider.scrollController,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2.5,
                          child: ListView.builder(
                              itemCount: 5,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 62,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '#Beautiful Smile -> Male/Female/Kids',
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        Constants.userType ==
                                                                'brand'
                                                            ? 12
                                                            : 14,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                'Participations',
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        Constants.userType ==
                                                                'brand'
                                                            ? 12
                                                            : 14,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 5.0, right: 5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                // height: ScreenUtil().setSp(16),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                height: 15,
                                                child: ClipRRect(
                                                  // borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(3))),
                                                  child: LinearPercentIndicator(
                                                    percent: 0.9,
                                                    center: Text('90%',
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white)),
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    barRadius:
                                                        Radius.circular(4),
                                                    progressColor:
                                                        Colors.orange,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    lineHeight: 13,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Started 3d ago',
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        Constants.userType ==
                                                                'brand'
                                                            ? 12
                                                            : 14,
                                                    color: Colors.white),
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4))),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.0,
                                                        right: 4,
                                                        top: 2,
                                                        bottom: 2),
                                                    child: Text(
                                                      '2.01 B',
                                                      style: GoogleFonts.nunitoSans(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: Constants
                                                                      .userType ==
                                                                  'brand'
                                                              ? 12
                                                              : 14,
                                                          color: Colors.white),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height:
                        Provider.of<UserProfileProvider>(context, listen: false)
                                .getReadMoreText
                            ? 10.h
                            : 20.h, //64.h
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: provider.selectPhase == 0
                                ? Constants.userType == "brand"
                                    ? "STORE"
                                    : Constants.userType == "agency"
                                        ? "COLLAB"
                                        : "FAME" //before this only "FAME"
                                : provider.selectPhase == 1
                                    ? "FUN"
                                    : provider.selectPhase == 2
                                        ? "FOLLOW"
                                        : provider.selectPhase == 3
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
                  SizedBox(
                    height: 0.h, //4
                  ),
                  // Phase - 1 Circle
                  SelfprofileDilerWhitemode(id: id),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: InkWell(
                          onTap: () {
                            var valu;

                            if (provider.selectPhase == 0) {
                              valu = "contest";
                            }
                            if (provider.selectPhase == 1) {
                              valu = "funlinks";
                            } else {
                              valu = "Followlinks";
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SayHiFirstVideo(
                                  links: valu,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                "Say Hi...  ",
                                style: TextStyle(color: Colors.black),
                              ),
                              SvgPicture.asset(
                                CommonImage.scan,
                                color: Colors.black,
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Visibility(
                      visible: provider.selectPhase == 0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          bottom: 8.0,
                        ),
                        child: Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  print("object");
                                  Provider.of<UserProfileProvider>(context,
                                          listen: false)
                                      .changeBoolReadMore(
                                          !Provider.of<UserProfileProvider>(
                                                  context,
                                                  listen: false)
                                              .getBoolReadMore);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Provider.of<UserProfileProvider>(context,
                                                    listen: false)
                                                .getBoolReadMore ==
                                            true
                                        ? Row(
                                            children: [
                                              Text(
                                                "About Me",
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                              SizedBox(width: 5),
                                              SizedBox(
                                                height: 15.0,
                                                width: 15.0,
                                                child: Image.asset(
                                                  "assets/images/aboutMeDown.png",
                                                  fit: BoxFit.fill,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(
                                            height: 15.0,
                                            width: 15.0,
                                            child: Image.asset(
                                              "assets/images/aboutMeDown.png",
                                              fit: BoxFit.fill,
                                              color: Colors.black,
                                            ),
                                          ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Visibility(
                      visible: provider.selectPhase == 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          bottom: 8.0,
                        ),
                        child: InkWell(
                          onTap: () {
                            Provider.of<UserProfileProvider>(context,
                                    listen: false)
                                .changeBoolReadMore(
                                    !Provider.of<UserProfileProvider>(context,
                                            listen: false)
                                        .getBoolReadMore);
                          },
                          child: Provider.of<UserProfileProvider>(context,
                                          listen: false)
                                      .getBoolReadMore ==
                                  true
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "About Me",
                                          style: GoogleFonts.nunitoSans(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        SizedBox(width: 5),
                                        SizedBox(
                                          height: 15.0,
                                          width: 15.0,
                                          child: Image.asset(
                                            CommonImage.funLinksStoreAboutMe,
                                            fit: BoxFit.fill,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : SizedBox(
                                  height: 15.0,
                                  width: 15.0,
                                  child: Image.asset(
                                    "assets/images/aboutMeDown.png",
                                    fit: BoxFit.fill,
                                    color: Colors.black,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Visibility(
                      visible: provider.selectPhase == 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          bottom: 8.0,
                        ),
                        child: InkWell(
                          onTap: () {
                            Provider.of<UserProfileProvider>(context,
                                    listen: false)
                                .changeBoolReadMore(
                                    !Provider.of<UserProfileProvider>(context,
                                            listen: false)
                                        .getBoolReadMore);
                          },
                          child: Provider.of<UserProfileProvider>(context,
                                          listen: false)
                                      .getBoolReadMore ==
                                  true
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "About Me",
                                          style: GoogleFonts.nunitoSans(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        SizedBox(width: 5),
                                        SizedBox(
                                          height: 15.0,
                                          width: 15.0,
                                          child: Image.asset(
                                            CommonImage.funLinksStoreAboutMe,
                                            fit: BoxFit.fill,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : SizedBox(
                                  height: 15.0,
                                  width: 15.0,
                                  child: Image.asset(
                                    "assets/images/aboutMeDown.png",
                                    fit: BoxFit.fill,
                                    color: Colors.black,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),

                  // Phase - 1 Writer Director
                  Padding(
                    padding:
                        EdgeInsets.only(left: 21.w, right: 21.w, bottom: 8.h),
                    child: Visibility(
                      visible: (provider.selectPhase == 0),
                      child: Constants.userType == 'brand' ||
                              Constants.userType == 'agency'
                          ? Container(
                              child: ReadMoreText(
                                '${provider.upperProfileData != null ? provider.upperProfileData!.bio : ""}',
                                trimLines: 3,
                                trimMode: TrimMode.Line,
                                colorClickableText: lightGray,
                                callback: (value) {
                                  Provider.of<UserProfileProvider>(context,
                                          listen: false)
                                      .changeReadMoreText(
                                          !Provider.of<UserProfileProvider>(
                                                  context,
                                                  listen: false)
                                              .getReadMoreText);
                                },
                                style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(14),
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            )
                          : provider.profileFameLinksModelResult.result!
                                      .length !=
                                  0
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, bottom: 15),
                                  child: provider.profileFameLinksModelResult
                                                  .result![0].bio ==
                                              null ||
                                          provider.profileFameLinksModelResult
                                                  .result![0].bio ==
                                              ""
                                      ? Container()
                                      : Provider.of<UserProfileProvider>(
                                                      context,
                                                      listen: false)
                                                  .getBoolReadMore ==
                                              true
                                          ? Container()
                                          : Align(
                                              alignment: Alignment.topLeft,
                                              child: ReadMoreText(
                                                provider
                                                                .profileFameLinksModelResult
                                                                .result![0]
                                                                .profession !=
                                                            null &&
                                                        provider
                                                                .profileFameLinksModelResult
                                                                .result![0]
                                                                .profession !=
                                                            ""
                                                    ? '${provider.profileFameLinksModelResult.result![0].profession} : ${provider.profileFameLinksModelResult.result![0].bio}'
                                                    : '${provider.profileFameLinksModelResult.result![0].bio}',
                                                style: TextStyle(
                                                    color: Colors.black),
                                                trimLines: 2,
                                                colorClickableText: Colors.grey,
                                                callback: (value) {
                                                  Provider.of<UserProfileProvider>(
                                                          context,
                                                          listen: false)
                                                      .changeReadMoreText(!Provider
                                                              .of<UserProfileProvider>(
                                                                  context,
                                                                  listen: false)
                                                          .getReadMoreText);
                                                },
                                                trimMode: TrimMode.Line,
                                                trimCollapsedText: 'more',
                                                trimExpandedText: 'Show less',
                                                moreStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey),
                                              ) //amarjeet
                                              ),
                                )
                              : Container(),
                    ),
                  ),
                  Visibility(
                    visible: (provider.selectPhase == 1),
                    child: provider.profileFunLinksList.length != 0
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            child: provider.profileFunLinksList[0].bio ==
                                        null ||
                                    provider.profileFunLinksList[0].bio == ""
                                ? Container()
                                : Provider.of<UserProfileProvider>(context,
                                                listen: false)
                                            .getBoolReadMore ==
                                        true
                                    ? Container()
                                    : Align(
                                        alignment: Alignment.topLeft,
                                        child: ReadMoreText(
                                          provider.profileFunLinksList[0]
                                                          .profession !=
                                                      null &&
                                                  provider
                                                          .profileFunLinksList[
                                                              0]
                                                          .profession !=
                                                      ""
                                              ? '${provider.profileFunLinksList[0].profession} : ${provider.profileFunLinksList[0].bio}'
                                              : '${provider.profileFunLinksList[0].bio}',
                                          style: TextStyle(color: Colors.black),
                                          trimLines: 2,
                                          colorClickableText: Colors.grey,
                                          callback: (value) {
                                            Provider.of<UserProfileProvider>(
                                                    context,
                                                    listen: false)
                                                .changeReadMoreText(!Provider
                                                        .of<UserProfileProvider>(
                                                            context,
                                                            listen: false)
                                                    .getReadMoreText);
                                          },
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: 'more',
                                          trimExpandedText: 'Show less',
                                          moreStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )))
                        : Container(),
                  ),
                  Visibility(
                    visible: (provider.selectPhase == 2),
                    child: provider.profileFollowLinksList.length != 0
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            child: provider.profileFollowLinksList[0].bio ==
                                        null ||
                                    provider.profileFollowLinksList[0].bio == ""
                                ? Container()
                                : Provider.of<UserProfileProvider>(context,
                                                listen: false)
                                            .getBoolReadMore ==
                                        true
                                    ? Container()
                                    : Align(
                                        alignment: Alignment.topLeft,
                                        child: ReadMoreText(
                                          provider.profileFollowLinksList[0]
                                                          .profession !=
                                                      null &&
                                                  provider
                                                          .profileFollowLinksList[
                                                              0]
                                                          .profession !=
                                                      ""
                                              ? '${provider.profileFollowLinksList[0].profession} : ${provider.profileFollowLinksList[0].bio}'
                                              : '${provider.profileFollowLinksList[0].bio}',
                                          style: TextStyle(color: Colors.black),
                                          trimLines: 2,
                                          colorClickableText: Colors.grey,
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: 'more',
                                          trimExpandedText: 'Show less',
                                          callback: (value) {
                                            Provider.of<UserProfileProvider>(
                                                    context,
                                                    listen: false)
                                                .changeReadMoreText(!Provider
                                                        .of<UserProfileProvider>(
                                                            context,
                                                            listen: false)
                                                    .getReadMoreText);
                                          },
                                          moreStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )),
                          )
                        : Container(),
                  ),

                  Visibility(
                    visible:
                        provider.selectPhase == 1 && provider.selectPhase == 2,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        bottom: 8.0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "About Me",
                            style: GoogleFonts.nunitoSans(
                                fontSize: 12, color: Colors.black),
                          ),
                          const SizedBox(width: 7.0),
                          SizedBox(
                            height: 12.0,
                            width: 13.0,
                            child: Image.asset(
                              CommonImage.funLinksStoreAboutMe,
                              fit: BoxFit.fill,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  (provider.selectPhase == 0)
                      ? Constants.userType == 'brand'
                          ? storeLinksNameFieldWhitemode()
                          : fameLinksNameFieldWhitemode(
                              provider: userProfileData,
                              id: id,
                              status: status,
                              // callback: provider.profile(context),
                              selectPhase: provider.selectPhase,
                              avtarImage: provider.avtarImage,
                              profileImage: provider.profileImage)
                      : (provider.selectPhase == 1)
                          ? funLinksNameFieldWhitemode()
                          : (provider.selectPhase == 2)
                              ? followLinksNameFieldWhitemode()
                              // : (provider.selectPhase == 3)
                              //     ? JobLinkNameField()
                              : Container(),

                  // TODO: FAMELINKS GRID POSTS

                  Visibility(
                    visible: (provider.selectPhase == 0),
                    child: Constants.userType == 'brand'
                        ? Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PhotoImageScreen(
                                          getRunScreen: 'banner',
                                        ),
                                      ),
                                    ).then(
                                        (value) => provider.profiles(context));
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(width: 15),
                                      Container(
                                        height: ScreenUtil().setHeight(30),
                                        width: ScreenUtil().setWidth(30),
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            border: Border.all(
                                              width: ScreenUtil().setSp(1),
                                              color: lightGray,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    ScreenUtil().radius(8)))),
                                        child: Icon(
                                          Icons.add,
                                          color: lightRed,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('Upload Banners',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: ScreenUtil().setSp(14),
                                              color: white,
                                              fontStyle: FontStyle.italic)),
                                      Text(' (2:1 Ratio)',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w300,
                                              fontSize: ScreenUtil().setSp(12),
                                              fontStyle: FontStyle.italic,
                                              color: white))
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                                provider.myFameResult.isNotEmpty
                                    ? GridView.count(
                                        crossAxisCount: 3,
                                        shrinkWrap: true,
                                        childAspectRatio:
                                            (itemWidth / itemHeight),
                                        padding: EdgeInsets.only(
                                            top: ScreenUtil().setSp(5),
                                            left: ScreenUtil().setSp(2.5),
                                            right: ScreenUtil().setSp(2.5)),
                                        children: List.generate(
                                            provider.myFameResult.length,
                                            (index) {
                                          // if(provider.myFameResult[index].images[0].type == "video"){
                                          //   print("VIDEO:::${provider.myFameResult[index].images[0].type}");
                                          //   downloadFile(provider.myFameResult[index].images[0].path);
                                          // }
                                          return InkWell(
                                            onTap: () async {
                                              final result =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (ontext) =>
                                                        BrandDetailsScreen(
                                                            provider
                                                                .myFameResult
                                                                .elementAt(
                                                                    index),
                                                            index,
                                                            1,
                                                            "",
                                                            "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}",
                                                            false)),
                                              );
                                              if (result != null) {
                                                Map map = result;
                                                Map<String, dynamic> formData =
                                                    {
                                                  "name": map['name'],
                                                  "price": map['price'],
                                                  "description":
                                                      map['description'],
                                                  "purchaseUrl":
                                                      map['purchaseUrl'],
                                                  "buttonName":
                                                      map['buttonName'],
                                                  "tags": map['tags'],
                                                };
                                                Api.put.call(context,
                                                    method:
                                                        "users/edit/${provider.myFameResult.elementAt(index).sId}/brandUpload",
                                                    param: formData,
                                                    onResponseSuccess:
                                                        (Map object) {
                                                  Constants.todayPosts = 1;
                                                  var snackBar = SnackBar(
                                                    content: Text('Updated'),
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                  1;
                                                  provider.myFameResult.clear();
                                                  provider.getStoreLinkProfile(
                                                      context);
                                                });
                                              }
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  bottom: ScreenUtil().setSp(5),
                                                  left: ScreenUtil().setSp(2.5),
                                                  right:
                                                      ScreenUtil().setSp(2.5)),
                                              child: Stack(
                                                children: [
                                                  SizedBox(
                                                    child: provider
                                                                    .myFameResult[
                                                                        index]
                                                                    .images !=
                                                                null &&
                                                            provider
                                                                    .myFameResult[
                                                                        index]
                                                                    .images!
                                                                    .length >
                                                                0
                                                        ? provider
                                                                    .myFameResult[
                                                                        index]
                                                                    .images![0]
                                                                    .type ==
                                                                "video"
                                                            ? Stack(
                                                                children: [
                                                                  Container(
                                                                      color:
                                                                          lightGray,
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        imageUrl:
                                                                            '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.myFameResult[index].images![0].path}-sm',
                                                                        errorWidget: (context, url, error) => Icon(
                                                                            Icons
                                                                                .error,
                                                                            color:
                                                                                white),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        width:
                                                                            itemWidth,
                                                                        height:
                                                                            itemHeight,
                                                                      )),
                                                                  Center(
                                                                    child:
                                                                        Container(
                                                                      height: ScreenUtil()
                                                                          .setHeight(
                                                                              32.94),
                                                                      width: ScreenUtil()
                                                                          .setWidth(
                                                                              40),
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.white.withOpacity(
                                                                              0.5),
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(ScreenUtil().radius(5)))),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .play_arrow,
                                                                        color:
                                                                            black,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            : Container(
                                                                color:
                                                                    lightGray,
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl:
                                                                      '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.myFameResult[index].images![0].path}-sm',
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Icon(
                                                                          Icons
                                                                              .error,
                                                                          color:
                                                                              white),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  width:
                                                                      itemWidth,
                                                                  height:
                                                                      itemHeight,
                                                                ),
                                                              )
                                                        : Container(
                                                            color: lightGray,
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/sm',
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Icon(
                                                                      Icons
                                                                          .error,
                                                                      color:
                                                                          white),
                                                              fit: BoxFit.cover,
                                                              width: itemWidth,
                                                              height:
                                                                  itemHeight,
                                                            ),
                                                          ),
                                                  ),
                                                  Padding(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                              provider
                                                                  .myFameResult[
                                                                      index]
                                                                  .images!
                                                                  .length
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      11)),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Image.asset(
                                                              "assets/images/multiple_img.png",
                                                              color:
                                                                  Colors.white),
                                                        ],
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.only(
                                                        right: 7, bottom: 3),
                                                  )
                                                ],
                                              ),
                                              color: Colors.blue,
                                            ),
                                          );
                                        }),
                                      )
                                    : Container(),

                                ///fun and follow links for collab
                                provider.followLinkData.isNotEmpty
                                    ? GridView.count(
                                        crossAxisCount: 3,
                                        shrinkWrap: true,
                                        childAspectRatio:
                                            (itemWidth / itemHeight),
                                        padding: EdgeInsets.only(
                                            top: ScreenUtil().setSp(5),
                                            left: ScreenUtil().setSp(2.5),
                                            right: ScreenUtil().setSp(2.5)),
                                        children: List.generate(
                                            provider.followLinkData.length,
                                            (index) {
                                          // if(provider.myFameResult[index].images[0].type == "video"){
                                          //   print("VIDEO:::${provider.myFameResult[index].images[0].type}");
                                          //   downloadFile(provider.myFameResult[index].images[0].path);
                                          // }
                                          return InkWell(
                                            onTap: () async {
                                              final result =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (ontext) =>
                                                        BrandDetailsScreen(
                                                            provider
                                                                .myFameResult
                                                                .elementAt(
                                                                    index),
                                                            index,
                                                            1,
                                                            "",
                                                            "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}",
                                                            false)),
                                              );
                                              if (result != null) {
                                                Map map = result;
                                                Map<String, dynamic> formData =
                                                    {
                                                  "name": map['name'],
                                                  "price": map['price'],
                                                  "description":
                                                      map['description'],
                                                  "purchaseUrl":
                                                      map['purchaseUrl'],
                                                  "buttonName":
                                                      map['buttonName'],
                                                  "tags": map['tags'],
                                                };
                                                Api.put.call(context,
                                                    method:
                                                        "users/edit/${provider.myFameResult.elementAt(index).sId}/brandUpload",
                                                    param: formData,
                                                    onResponseSuccess:
                                                        (Map object) {
                                                  Constants.todayPosts = 1;
                                                  var snackBar = SnackBar(
                                                    content: Text('Updated'),
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                  1;
                                                  provider.myFameResult.clear();
                                                  provider.getStoreLinkProfile(
                                                      context);
                                                });
                                              }
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  bottom: ScreenUtil().setSp(5),
                                                  left: ScreenUtil().setSp(2.5),
                                                  right:
                                                      ScreenUtil().setSp(2.5)),
                                              child: Stack(
                                                children: [
                                                  SizedBox(
                                                    child: provider
                                                                    .followLinkData[
                                                                        index]
                                                                    .media !=
                                                                null &&
                                                            provider
                                                                    .followLinkData[
                                                                        index]
                                                                    .media!
                                                                    .length >
                                                                0
                                                        ? Container(
                                                            color: lightGray,
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  '${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/+"${provider.followLinkData[index].media}"',
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Icon(
                                                                      Icons
                                                                          .error,
                                                                      color:
                                                                          white),
                                                              fit: BoxFit.cover,
                                                              width: itemWidth,
                                                              height:
                                                                  itemHeight,
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                  ),
                                                  Padding(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                              provider
                                                                  .myFameResult[
                                                                      index]
                                                                  .images!
                                                                  .length
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      11)),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Image.asset(
                                                              "assets/images/multiple_img.png",
                                                              color:
                                                                  Colors.white),
                                                        ],
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.only(
                                                        right: 7, bottom: 3),
                                                  )
                                                ],
                                              ),
                                              color: Colors.blue,
                                            ),
                                          );
                                        }),
                                      )
                                    : Container()
                              ],
                            ),
                          )
                        : provider.profileFameLinksModelResult.result!.length !=
                                0
                            ? SizedBox(
                                width: ScreenUtil().screenWidth,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
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
                                    itemCount: provider.famevideo!.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return InkWell(
                                        onTap: () async {
                                          // Map<String, dynamic>
                                          //     json = {
                                          //   "_id":
                                          //       provider.upperProfileData.id,
                                          //   "name": provider.upperProfileData
                                          //       .name,
                                          // };
                                          //var model = FameUser.fromJson(json);
                                          //provider.profileFameLinksModelResult.result![index].masterUser = model;
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  GetParticularUserProfile(
                                                      id: provider
                                                          .profileFameLinksModelResult
                                                          .result![0]
                                                          .sId,
                                                      index: index),
                                            ),
                                          ).then((value) async {
                                            print("print $value");
                                            if (value != null) {
                                              print("print $value");
                                              // getParticularUserProfileModel =
                                              //     null;
                                              // getParticularUserProfileModelResultList
                                              //     .clear();
                                              // videofameController.clear();
                                              // await getFameLinkProfile(
                                              //     id ?? id, context);
                                              // getFameLinksFeed(
                                              //     userProfileData
                                              //         .profileFameLinksModelResult
                                              //         .result![0]
                                              //         .sId!,
                                              //     context,
                                              //     isPaginate: false);
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 108,
                                          width: 108,
                                          child: (provider.famevideo![index]
                                                      .isWelcomeVideo ==
                                                  '1')
                                              ? Stack(
                                                  children: [
                                                    Container(
                                                      height: double.infinity,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.r),
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Image.network(
                                                        "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.famevideo![index].video!}",
                                                        fit: BoxFit.cover,
                                                        height: 150.h,
                                                        width: 100.w,
                                                      ),
                                                    ),
                                                    Image.asset(
                                                        'assets/icons/gridViewBorder.png'),
                                                    Center(
                                                        child: Image.asset(
                                                            'assets/icons/Ellipse 217.png')),
                                                    Center(
                                                        child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5.w),
                                                      child: Image.asset(
                                                          'assets/icons/play.png'),
                                                    )),
                                                  ],
                                                )
                                              : Container(
                                                  // height: double
                                                  //     .infinity,
                                                  // alignment:
                                                  //     Alignment
                                                  //         .center,
                                                  child: provider
                                                              .famevideo![index]
                                                              .video !=
                                                          null
                                                      ? Stack(children: [
                                                          Container(
                                                            width: 240,
                                                            height: 110,
                                                            child:
                                                                Image.network(
                                                              "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.famevideo![index].video!}",
                                                              fit: BoxFit.cover,
                                                              // height: 150.h,
                                                              // width: 100.w,
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Container(
                                                              child: Align(
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
                                                            ),
                                                          )
                                                        ])
                                                      : provider
                                                                  .profileFameLinksModelResult
                                                                  .result![0]
                                                                  .posts![index]
                                                                  .closeUp ==
                                                              null
                                                          ? Image.network(
                                                              provider
                                                                          .profileFameLinksModelResult
                                                                          .result![
                                                                              0]
                                                                          .posts![
                                                                              index]
                                                                          .additional !=
                                                                      null
                                                                  ? "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.profileFameLinksModelResult.result![0].posts![index].additional!}"
                                                                  : provider
                                                                              .profileFameLinksModelResult
                                                                              .result![0]
                                                                              .posts![index]
                                                                              .long !=
                                                                          null
                                                                      ? "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.profileFameLinksModelResult.result![0].posts![index].long!}"
                                                                      : provider.profileFameLinksModelResult.result![0].posts![index].medium != null
                                                                          ? "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.profileFameLinksModelResult.result![0].posts![index].medium!}"
                                                                          : provider.profileFameLinksModelResult.result![0].posts![index].pose1 != null
                                                                              ? "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.profileFameLinksModelResult.result![0].posts![index].pose1!}"
                                                                              : provider.profileFameLinksModelResult.result![0].posts![index].pose2 != null
                                                                                  ? "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.profileFameLinksModelResult.result![0].posts![index].pose2!}"
                                                                                  : provider.profileFameLinksModelResult.result![0].posts![index].video != null
                                                                                      ? "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.profileFameLinksModelResult.result![0].posts![index].video!}"
                                                                                      : "https://imgix.bustle.com/uploads/image/2020/8/5/23905b9c-6b8c-47fa-bc0f-434de1d7e9bf-avengers-5.jpg",
                                                              fit: BoxFit.cover,
                                                              // height:
                                                              //     150.h,
                                                              // width:
                                                              //     100.w,
                                                            )
                                                          : Image.network(
                                                              "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.profileFameLinksModelResult.result![0].posts![index].closeUp!}",
                                                              fit: BoxFit.cover,
                                                              // height:
                                                              //     150.h,
                                                              // width:
                                                              //     100.w,
                                                            ),
                                                ),
                                        ),
                                      );
                                    },
                                  ),
                                ))
                            : Container(),
                  ),

                  // TODO: FUNLINKS GRID POSTS

                  Visibility(
                    visible: (provider.selectPhase == 1),
                    child: provider.profileFunLinksList.length != 0
                        // &&
                        //         yourVideoClicked == true
                        ? SizedBox(
                            width: ScreenUtil().screenWidth,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
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
                                itemCount: provider.postsListOfFunLink.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext ctx, index) {
                                  return InkWell(
                                    onTap: () {
                                      print('101-10101101-111010-');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              GetParticularFunLinksProfile(
                                                  id: provider
                                                      .profileFunLinksList[0]
                                                      .sId,
                                                  index: index),
                                        ),
                                      );
                                    },
                                    child: Container(
                                        // height: double.infinity,
                                        // alignment:
                                        //     Alignment.center,
                                        child: provider.profileFunLinksList[0]
                                                    .posts![index].video ==
                                                null
                                            ? Image.network(
                                                "https://imgix.bustle.com/uploads/image/2020/8/5/23905b9c-6b8c-47fa-bc0f-434de1d7e9bf-avengers-5.jpg",
                                                fit: BoxFit.cover,
                                                // height: 150.h,
                                                // width: 100.w,
                                              )
                                            : Stack(
                                                children: [
                                                  Container(
                                                    width: 240,
                                                    height: 110,
                                                    child: Image.network(
                                                      "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.profileFunLinksList[0].posts![index].video}",
                                                      fit: BoxFit.cover,
                                                      // height: 150.h,
                                                      // width: 100.w,
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Container(
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: SvgPicture.asset(
                                                          'assets/icons/svg/other_profile_video_play.svg',
                                                          height: 40,
                                                          width: 40,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )

                                        // Image.network(
                                        //           "${ApiProvider.funPostImageBaseUrl}/${provider.profileFunLinksList[0].posts[index].video}",
                                        //           fit: BoxFit
                                        //               .cover,
                                        //           // height: 150.h,
                                        //           // width: 100.w,
                                        //         )
                                        ),
                                  );
                                },
                              ),
                            ),
                          )
                        : Container(),
                  ),

                  // TODO: FOLLOWLINKS GRID POSTS

                  Visibility(
                    visible: (provider.selectPhase == 2),
                    child: provider.profileFollowLinksList.length != 0
                        ? SizedBox(
                            width: ScreenUtil().screenWidth,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
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
                                itemCount:
                                    provider.postsListOfFollowLink!.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext ctx, index) {
                                  return InkWell(
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                GetParticularFollowLinksProfile(
                                                    id: provider
                                                        .profileFollowLinksList[
                                                            0]
                                                        .sId,
                                                    index: index),
                                          ),
                                        ).then((value) async {});
                                      },
                                      child: Container(
                                        // height: double.infinity,
                                        // alignment:
                                        //     Alignment.center,
                                        child: Image.network(
                                          "${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${provider.postsListOfFollowLink![index].media![0].media}",
                                          fit: BoxFit.cover,
                                        ),
                                      ));
                                },
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
