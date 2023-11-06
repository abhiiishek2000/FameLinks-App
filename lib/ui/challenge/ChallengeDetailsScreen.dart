import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:famelink/databse/AppDatabase.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/OpenChallengesResponse.dart';
import 'package:famelink/models/upcoming_challenges_model.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/challenge/ChallengeFameLinkFullPostScreen.dart';
import 'package:famelink/ui/challenge/widgets/rating_dialog.dart';
import 'package:famelink/ui/funlinks/FameLinksChallengeScreen.dart';
import 'package:famelink/ui/funlinks/FunLinksChallengeScreen.dart';
import 'package:famelink/ui/profile/agency_other_profile_screen.dart';
import 'package:famelink/ui/profile/agency_profile_screen.dart';
import 'package:famelink/ui/profile/brand_other_profile_screen.dart';
import 'package:famelink/ui/profile/brand_profile_screen.dart';
import 'package:famelink/ui/profile/other_profile_screen.dart';
import 'package:famelink/ui/profile/profile_screen.dart';
import 'package:famelink/ui/settings/profile_verification_screen.dart';
import 'package:famelink/ui/upload/funlink_upload_one.dart';
import 'package:famelink/ui/upload/upload_screen_one.dart';
import 'package:famelink/util/ReadMoreText.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:video_compress/video_compress.dart';
import '../../providers/ChallengeProvider/famelinkChallengeProvider.dart';
import '../notification/service/notification_service.dart';


class ChallengeDetailsScreen extends StatefulWidget {
  UpcomingChallengesResult? upcomingChallengesResult;
  OpenChallengesResult? openChallengesResult;
  int index;

  ChallengeDetailsScreen(
      this.upcomingChallengesResult, this.openChallengesResult, this.index);

  @override
  _ChallengeDetailsScreenState createState() => _ChallengeDetailsScreenState();
}

void printHello() {
  FlutterLocalNotificationsPlugin().show(
      456,
      "Challenge Started",
      "",
      NotificationDetails(
        android: AndroidNotificationDetails("4563", "channelName",
            playSound: true,
            enableVibration: true,
            importance: Importance.max,
            priority: Priority.high
            // other properties...
            ),
      ));
}

class _ChallengeDetailsScreenState extends State<ChallengeDetailsScreen> {
  final GlobalKey<FormState> _profileKey = GlobalKey<FormState>();

  void _openChallenges(BuildContext context) async {
    Api.get.call(context, method: "challenges/${Constants.profileUserId}",
        onResponseSuccess: (Map object) {
      var result = OpenChallengesResponse.fromJson(object);
      if (result.result!.length > 0) {
        widget.openChallengesResult = result.result![0];
        setState(() {});
        print('RESPONSE ${result.result.toString()}');
      }
    }, param: {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // log('UserId1'+ApiProvider.profileUserId);

    _openChallenges(context);
    if (widget.openChallengesResult != null) {
      // if (widget.openChallengesResult.mediaPreference.length > 1) {
      //   type = "Image & Videos";
      // } else if (widget.openChallengesResult.mediaPreference[0] == "photo") {
      //   type = "Image Only";
      // } else if (widget.openChallengesResult.mediaPreference[0] == "video") {
      //   type = "Videos Only";
      // }
      // _openChallengesSlider();

    } else if (widget.upcomingChallengesResult != null) {
      Provider.of<ChallengeScreenProvider>(context).endTime =
          DateTime.parse(widget.upcomingChallengesResult!.startDate!)
              .millisecondsSinceEpoch;
      // _upcomingChallengesSlider();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    final double itemHeight = itemWidth + 30;
    return Consumer<ChallengeScreenProvider>(
        builder: (context, challengeDetailScreen, child) {
      return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: black),
            toolbarHeight: ScreenUtil().setHeight(61),
            backgroundColor: appBackgroundColor,
            elevation: 0,
            centerTitle: true,
            title: Text.rich(TextSpan(children: <TextSpan>[
              TextSpan(
                  text:
                      "${widget.upcomingChallengesResult != null ? widget.upcomingChallengesResult!.hashTag : widget.openChallengesResult!.hashTag} ",
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w700,
                      color: lightRed,
                      fontSize: ScreenUtil().setSp(18))),
              TextSpan(
                  text: "Trendz",
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(18),
                      color: black)),
            ])),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  onTap: () => showRateDialog(
                      context,
                      widget.openChallengesResult!,
                      widget.index,
                      '${widget.openChallengesResult!.sId}',
                    initialValue: widget.openChallengesResult!.rating != null
                        ? widget.openChallengesResult!.rating!.rating
                        : null),
                  child: widget.openChallengesResult!.rating != null
                      ? Row(
                          children: [
                            Text(
                              "Rated",
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w600,
                                  fontSize: ScreenUtil().setSp(12),
                                  color: lightGray),
                            ),
                            SizedBox(width: 4),
                            Container(
                              height: 18,
                              width: 18,
                              child: Stack(
                                children: [
                                  SvgPicture.asset('assets/icons/ic_liked.svg'),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      widget
                                          .openChallengesResult!.rating!.rating
                                          .toString(),
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w600,
                                          fontSize: ScreenUtil().setSp(10),
                                          color: white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Text(
                              "Rate",
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w600,
                                  fontSize: ScreenUtil().setSp(12),
                                  color: orange),
                            ),
                            SizedBox(width: 4),
                            SvgPicture.asset('assets/icons/svg/ic_like.svg'),
                          ],
                        ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: ScreenUtil().screenWidth,
                  height: ScreenUtil().setHeight(214),
                  child: Stack(
                    children: [
                      widget.openChallengesResult != null
                          ? CarouselSlider(
                              items: widget.openChallengesResult!.bannerImage!
                                  .map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: appBackgroundColor),
                                        child: Image.network(
                                          "${ApiProvider.challenges}/${i}",
                                          fit: BoxFit.cover,
                                        ));
                                  },
                                );
                              }).toList(),
                              options: CarouselOptions(
                                height: ScreenUtil().setHeight(284),
                                aspectRatio: 16 / 9,
                                viewportFraction: 1,
                                initialPage: 0,
                                enableInfiniteScroll: false,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) {
                                  challengeDetailScreen
                                      .changePageDetailController(
                                          PageController(
                                              keepPage: true,
                                              initialPage: index));
                                  // if (!openChallengesBanner
                                  //     .elementAt(index)
                                  //     .isImpression) {
                                  //   _addChallengeImpression(
                                  //       openChallengesBanner.elementAt(index).id,
                                  //       index);
                                  // }
                                },
                                scrollDirection: Axis.horizontal,
                              ))
                          : CarouselSlider(
                              items: widget.upcomingChallengesResult!.images!
                                  .map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: appBackgroundColor),
                                        child: Image.network(
                                          "${ApiProvider.challenges}/${i}",
                                          fit: BoxFit.cover,
                                        ));
                                  },
                                );
                              }).toList(),
                              options: CarouselOptions(
                                height: ScreenUtil().setHeight(284),
                                aspectRatio: 16 / 9,
                                viewportFraction: 1,
                                initialPage: 0,
                                enableInfiniteScroll: false,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) {
                                  challengeDetailScreen
                                      .changePageDetailController(
                                          PageController(
                                              keepPage: true,
                                              initialPage: index));
                                  // if (!widget.upcomingChallengesResult.images
                                  //     .elementAt(index)
                                  //     .isImpression) {
                                  //   _addUpcomingChallengeImpression(
                                  //       widget.upcomingChallengesResult.images.elementAt(index).id,
                                  //       index);
                                  // }
                                },
                                scrollDirection: Axis.horizontal,
                              )),

                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: Padding(
                      //     padding:
                      //         EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
                      //     child: SmoothPageIndicator(
                      //       controller: pageController,
                      //       count: widget.upcomingChallengesResult != null ? widget.upcomingChallengesResult!.images!.length:widget.openChallengesResult!.posts!.length,
                      //       axisDirection: Axis.horizontal,
                      //       effect: SlideEffect(
                      //           spacing: 10.0,
                      //           radius: 3.0,
                      //           dotWidth: 6.0,
                      //           dotHeight: 6.0,
                      //           paintStyle: PaintingStyle.stroke,
                      //           strokeWidth: 1.5,
                      //           dotColor: Colors.white,
                      //           activeDotColor: lightRed),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setSp(23),
                      right: ScreenUtil().setSp(23)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                            "${widget.upcomingChallengesResult != null ? widget.upcomingChallengesResult!.hashTag : widget.openChallengesResult!.hashTag} Trendz Sponsored by-",
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(18),
                                fontWeight: FontWeight.w400,
                                color: black)),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.upcomingChallengesResult != null
                                ? widget.upcomingChallengesResult!.sponsor![0]
                                            .profileImageType ==
                                        "image"
                                    ? //openChallengesResult
                                    Container(
                                        height: 40, width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              "${ApiProvider.s3UrlPath}${ApiProvider.profile}/${widget.upcomingChallengesResult!.sponsor![0].profileImage}",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ), //openChallengesResult
                                      )
                                    : Container(
                                        height: 40, width: 40,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "${ApiProvider.s3UrlPath}${ApiProvider.avatar}/${widget.upcomingChallengesResult!.sponsor![0].profileImage}"),
                                            fit: BoxFit.cover,
                                          ),
                                        ), //openChallengesResult
                                      )
                                : widget.openChallengesResult!.sponsor!
                                                .length !=
                                            0 &&
                                        widget.openChallengesResult!.sponsor![0]
                                                .profileImageType ==
                                            "image"
                                    ? //openChallengesResult
                                    Container(
                                        height: 40, width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              "${ApiProvider.s3UrlPath}${ApiProvider.profile}/${widget.openChallengesResult!.sponsor![0].profileImage}",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ), //openChallengesResult
                                      )
                                    : Container(
                                        height: 40, width: 40,
                                        decoration:
                                            BoxDecoration(), //openChallengesResult
                                      ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                if (widget.upcomingChallengesResult != null
                                    ? widget.upcomingChallengesResult!.users!
                                            .length >
                                        0
                                    : widget.openChallengesResult!.users!
                                            .length >
                                        0) {
                                  Constants.profileUserId =
                                      widget.upcomingChallengesResult != null
                                          ? widget
                                              .upcomingChallengesResult!.users
                                          : widget.openChallengesResult!.users!
                                              .elementAt(0)
                                              .sId;
                                  if (Constants.userId ==
                                      Constants.profileUserId) {
                                    if (widget.openChallengesResult!.users!
                                            .elementAt(0)
                                            .type ==
                                        "individual") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfileScreen()));
                                    } else if (widget
                                            .openChallengesResult!.users!
                                            .elementAt(0)
                                            .type ==
                                        "agency") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AgencyProfileScreen()));
                                    } else if (widget
                                            .openChallengesResult!.users!
                                            .elementAt(0)
                                            .type ==
                                        "brand") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BrandProfileScreen()));
                                    }
                                  } else {
                                    if (widget.openChallengesResult!.users!
                                            .elementAt(0)
                                            .type ==
                                        "individual") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OtherProfileScreen()));
                                    } else if (widget
                                            .openChallengesResult!.users!
                                            .elementAt(0)
                                            .type ==
                                        "agency") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AgencyOtherProfileScreen()));
                                    } else if (widget
                                            .openChallengesResult!.users!
                                            .elementAt(0)
                                            .type ==
                                        "brand") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BrandOtherProfileScreen()));
                                    }
                                  }
                                }
                              },
                              child: Text(
                                  "${widget.upcomingChallengesResult != null ? widget.upcomingChallengesResult!.sponsor![0].name : ""}",
                                  //widget.upcomingChallengesResult.hashTag:widget.openChallengesResult.sponsor[0].name
                                  // style: GoogleFonts.nunitoSans(
                                  //     fontSize: ScreenUtil().setSp(14),
                                  //     fontWeight: FontWeight.w400,
                                  //     color: black)
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(18),
                                      fontWeight: FontWeight.w700,
                                      color: buttonBlue)),
                            ),
                          ],
                        ),
                      ),

                      /*Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: (){
                        if(widget.upcomingChallengesResult != null ? widget.upcomingChallengesResult.users.length > 0: widget.openChallengesResult.users.length > 0) {
                          ApiProvider.profileUserId =
                          widget.upcomingChallengesResult != null ? widget.upcomingChallengesResult.users: widget.openChallengesResult.users
                                  .elementAt(0)
                                  .sId;
                          if (ApiProvider.userId == ApiProvider.profileUserId) {
                            if (widget.upcomingChallengesResult != null ? widget.upcomingChallengesResult.users: widget.openChallengesResult.users
                                .elementAt(0)
                                .type == "individual") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileScreen()));
                            } else if (widget.upcomingChallengesResult != null ? widget.upcomingChallengesResult.users: widget.openChallengesResult.users
                                .elementAt(0)
                                .type == "agency") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AgencyProfileScreen()));
                            } else if (widget.upcomingChallengesResult != null ? widget.upcomingChallengesResult.users: widget.openChallengesResult.users
                                .elementAt(0)
                                .type == "brand") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BrandProfileScreen()));
                            }
                          } else {
                            if (widget.upcomingChallengesResult != null ? widget.upcomingChallengesResult.users: widget.openChallengesResult.users
                                .elementAt(0)
                                .type == "individual") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OtherProfileScreen()));
                            } else if (widget.upcomingChallengesResult != null ? widget.upcomingChallengesResult.users: widget.openChallengesResult.users
                                .elementAt(0)
                                .type == "agency") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AgencyOtherProfileScreen()));
                            } else if (widget.upcomingChallengesResult != null ? widget.upcomingChallengesResult.users: widget.openChallengesResult.users
                                .elementAt(0)
                                .type == "brand") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BrandOtherProfileScreen()));
                            }
                          }
                        }
                      },
                      child: Text(
                          "${widget.upcomingChallengesResult != null ?
                          widget.upcomingChallengesResult.sponsor.length > 0?widget.upcomingChallengesResult.sponsor[0].name:"" :""}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(18),
                              fontWeight: FontWeight.w700,
                              color: buttonBlue)),
                    ),
                  ),*/
                      // SizedBox(
                      //   height: ScreenUtil().setHeight(10),
                      // ),
                      ReadMoreText(
                        '${widget.upcomingChallengesResult != null ? widget.upcomingChallengesResult!.description : widget.openChallengesResult!.description}',
                        trimLines: 4,
                        trimMode: TrimMode.Line,
                        style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.w300,
                            color: black),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(5),
                      ),
                      // widget.openChallengesResult?.rewardWinner!=null?//widget.openChallengesResult?.rewardWinner!=null
                      Text.rich(TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Reward: ",
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w600,
                                color: orange,
                                fontSize: ScreenUtil().setSp(15))),
                        TextSpan(

                            // text:
                            //     "\n${widget.upcomingChallengesResult != null ? widget.upcomingChallengesResult.reward : "First Winner Get:"
                            //         " ${widget.openChallengesResult.rewardWinner[0].giftName}${widget.openChallengesResult.rewardWinner[0].giftValue}\n "
                            //         "Second Runner Up Gets: ${widget.openChallengesResult.rewardRunnerUp[0].giftName}${widget.openChallengesResult.rewardRunnerUp[0]
                            //         .giftValue}"}",

                            text: widget.openChallengesResult != null &&
                                    widget.openChallengesResult!.rewardWinner!
                                        .isNotEmpty
                                ? widget.openChallengesResult!.rewardWinner![0]
                                    .giftName
                                : "",
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w300,
                                fontSize: ScreenUtil().setSp(15),
                                color: black)),
                        // TextSpan(
                        //     text:
                        //         "${widget.upcomingChallengesResult != null ? widget.upcomingChallengesResult.reward : widget.openChallengesResult.reward}",
                        //     style: GoogleFonts.nunitoSans(
                        //         fontWeight: FontWeight.w300,
                        //         fontSize: ScreenUtil().setSp(12),
                        //         color: black)),
                      ])),
                      // :Container(),
                      Row(
                        children: [
                          widget.upcomingChallengesResult != null
                              ? CountdownTimer(
                                  endTime: challengeDetailScreen.getEndTime,
                                  widgetBuilder:
                                      (_, CurrentRemainingTime? time) {
                                    if (time == null) {
                                      return Text('Start');
                                    }
                                    return Text(
                                        'Starts in ${time.days != null ? time.days : 0}d:${time.hours}:${time.min}:${time.sec}',
                                        style: GoogleFonts.nunitoSans(
                                            color: lightGray,
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(12)));
                                  },
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        widget.openChallengesResult!
                                                        .startDate ==
                                                    null ||
                                                widget.openChallengesResult!
                                                        .startDate ==
                                                    ''
                                            ? ''
                                            : 'Started ${convertToAgo(DateTime.parse(widget.openChallengesResult!.startDate!))}',
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(10),
                                            color: black)),
                                    Container(
                                      width:
                                          (ScreenUtil().screenWidth / 2) - 50,
                                      height: ScreenUtil().setSp(16),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: lightGray,
                                            width: ScreenUtil().setSp(1)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil().setSp(4))),
                                      ),
                                      child: Stack(
                                        children: [
                                          widget.openChallengesResult!
                                                          .percentCompleted ==
                                                      null ||
                                                  widget.openChallengesResult!
                                                          .percentCompleted ==
                                                      ''
                                              ? Container()
                                              : Container(
                                                  height:
                                                      ScreenUtil().setSp(16),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                ScreenUtil()
                                                                    .setSp(3))),
                                                    child:
                                                        LinearProgressIndicator(
                                                      value: (widget
                                                              .openChallengesResult!
                                                              .percentCompleted /
                                                          100),
                                                      valueColor: AlwaysStoppedAnimation(
                                                          widget.openChallengesResult!
                                                                      .percentCompleted >=
                                                                  80
                                                              ? lightRed
                                                              : Colors.green),
                                                      backgroundColor:
                                                          Colors.white,
                                                    ),
                                                  ),
                                                ),
                                          widget.openChallengesResult!
                                                          .percentCompleted ==
                                                      null ||
                                                  widget.openChallengesResult!
                                                          .percentCompleted ==
                                                      ''
                                              ? Container()
                                              : Align(
                                                  child: Text(
                                                      "${widget.openChallengesResult!.percentCompleted}%",
                                                      style: GoogleFonts.nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: ScreenUtil()
                                                              .setSp(8),
                                                          color: widget
                                                                      .openChallengesResult!
                                                                      .percentCompleted >
                                                                  50
                                                              ? white
                                                              : black)),
                                                  alignment: Alignment.center,
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            width: ScreenUtil().setHeight(21),
                          ),
                          Expanded(
                            child: widget.upcomingChallengesResult != null
                                ? InkWell(
                                    onTap: () async {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Reminder set successfully")));
                                      var androidPlatformChannelSpecifics =
                                          AndroidNotificationDetails(
                                        'alarm_notif',
                                        'alarm_notif',
                                        icon: 'app_icon',
                                        largeIcon:
                                            DrawableResourceAndroidBitmap(
                                                'app_icon'),
                                      );

                                      var iOSPlatformChannelSpecifics =
                                          IOSNotificationDetails(
                                              sound: 'a_long_cold_sting.wav',
                                              presentAlert: true,
                                              presentBadge: true,
                                              presentSound: true);
                                      var platformChannelSpecifics =
                                          NotificationDetails(
                                              android:
                                                  androidPlatformChannelSpecifics,
                                              iOS: iOSPlatformChannelSpecifics);
                                      await AppNotificationService
                                          .appNotificationService
                                          .flutterLocalNotificationsPlugin
                                          .zonedSchedule(
                                              0,
                                              "${widget.upcomingChallengesResult != null ? widget.upcomingChallengesResult!.hashTag : widget.openChallengesResult!.hashTag} Challenge Started",
                                              "${widget.upcomingChallengesResult != null ? widget.upcomingChallengesResult!.sponsor : widget.openChallengesResult!.sponsor}",
                                              tz.TZDateTime.parse(
                                                  tz.local,
                                                  widget.upcomingChallengesResult !=
                                                          null
                                                      ? widget
                                                          .upcomingChallengesResult!
                                                          .startDate!
                                                      : widget
                                                          .openChallengesResult!
                                                          .startDate!),
                                              platformChannelSpecifics,
                                              androidAllowWhileIdle: true,
                                              uiLocalNotificationDateInterpretation:
                                                  UILocalNotificationDateInterpretation
                                                      .absoluteTime);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: ScreenUtil().setSp(16),
                                          bottom: ScreenUtil().setSp(12)),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/svg/reminder.svg"),
                                          SizedBox(
                                            width: ScreenUtil().setHeight(9),
                                          ),
                                          Expanded(
                                              child: Text('Set Reminder',
                                                  style: GoogleFonts.nunitoSans(
                                                      color: lightGray,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: ScreenUtil()
                                                          .setSp(12))))
                                        ],
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () async {
                                      print(
                                          widget.openChallengesResult!.hashTag);
                                      ChallengesModelData challengesModelData =
                                          ChallengesModelData(
                                              id: "",
                                              challengeId: widget
                                                  .openChallengesResult!.sId!,
                                              challengeName: widget
                                                  .openChallengesResult!
                                                  .hashTag!,
                                              postId: "");
                                      if (widget.openChallengesResult!.type ==
                                          "famelinks") {
                                        if ((Constants.verificationStatus ==
                                                    "Submitted" ||
                                            Constants.verificationStatus ==
                                                    "Verified") &&
                                            Constants.todayPosts == 0) {
                                          final result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UploadScreenOne(
                                                          challengesModelData:
                                                              challengesModelData)));
                                          if (result != null) {
                                            Map map = result;
                                            FormData formData =
                                                FormData.fromMap({
                                              "challengeId": map['challengeId'],
                                              "description": map['description'],
                                              "closeUp": map['closeUp'],
                                              "medium": map['medium'],
                                              "long": map['long'],
                                              "pose1": map['pose1'],
                                              "pose2": map['pose2'],
                                              "additional": map['additional'],
                                            });
                                            if (map['video'] != null) {
                                              var snackBar = SnackBar(
                                                content: Text('Compressing'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              final MediaInfo? info =
                                                  await VideoCompress
                                                      .compressVideo(
                                                map['video'],
                                                quality:
                                                    VideoQuality.HighestQuality,
                                                deleteOrigin: false,
                                                includeAudio: true,
                                              );
                                              await MultipartFile.fromFile(
                                                      info!.path!,
                                                      filename:
                                                          "${File(map['video']).path.split('/').last}")
                                                  .then((value) async {
                                                formData.files.addAll([
                                                  MapEntry("video", value),
                                                ]);
                                                Api.uploadPost.call(context,
                                                    method: "media/contest",
                                                    param: formData,
                                                    onResponseSuccess:
                                                        (Map object) {
                                                          Constants.todayPosts = 1;
                                                  var snackBar = SnackBar(
                                                    content: Text('Uploaded'),
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                });
                                              });
                                            } else {
                                              Api.uploadPost.call(context,
                                                  method: "media/contest",
                                                  param: formData,
                                                  onResponseSuccess:
                                                      (Map object) {
                                                        Constants.todayPosts = 1;
                                                var snackBar = SnackBar(
                                                  content: Text('Uploaded'),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              });
                                            }
                                          }
                                        } else if (Constants.todayPosts >= 1) {
                                          showPerDayPostDialog();
                                        } else {
                                          showProfileVerifyDialog();
                                        }
                                      } else {
                                        final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FunLinkUploadScreenOne(
                                                        challengesModelData:
                                                            challengesModelData)));
                                        if (result != null) {
                                          var snackBar = SnackBar(
                                            content: Text('Compressing'),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          Map map = result;
                                          FormData formData;
                                          if (map['musicId']
                                              .toString()
                                              .isEmpty) {
                                            formData = FormData.fromMap({
                                              "challenges": map['challenges'],
                                              "description": map['description'],
                                              "musicName": map['musicName'],
                                            });
                                          } else {
                                            formData = FormData.fromMap({
                                              "challenges": map['challenges'],
                                              "description": map['description'],
                                              "musicName": map['musicName'],
                                              "musicId": map['musicId'],
                                            });
                                          }
                                          if (map.containsKey("audio")) {
                                            formData.files.addAll([
                                              MapEntry("audio", map['audio']),
                                            ]);
                                          }
                                          final MediaInfo? info =
                                              await VideoCompress.compressVideo(
                                            map['video'],
                                            quality:
                                                VideoQuality.HighestQuality,
                                            deleteOrigin: false,
                                            includeAudio: true,
                                          );
                                          await MultipartFile.fromFile(
                                                  info!.path!,
                                                  filename:
                                                      "${File(map['video']).path.split('/').last}")
                                              .then((value) async {
                                            formData.files.addAll([
                                              MapEntry("video", value),
                                            ]);
                                            Api.uploadPost.call(context,
                                                method: "media/funlinks",
                                                param: formData,
                                                onResponseSuccess:
                                                    (Map object) {
                                              var snackBar = SnackBar(
                                                content: Text('Uploaded'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            });
                                          });
                                        }
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: ScreenUtil().setSp(16),
                                          bottom: ScreenUtil().setSp(12)),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/svg/upload.svg"),
                                          SizedBox(
                                            width: ScreenUtil().setHeight(9),
                                          ),
                                          Expanded(
                                              child: Text('Participate',
                                                  style: GoogleFonts.nunitoSans(
                                                      color: lightGray,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: ScreenUtil()
                                                          .setSp(12))))
                                        ],
                                      ),
                                    ),
                                  ),
                          )
                        ],
                      ),
                      widget.openChallengesResult != null
                          ? Text('Type: ${widget.openChallengesResult!.type}',
                              style: GoogleFonts.nunitoSans(
                                  color: black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: ScreenUtil().setSp(14)))
                          : SizedBox(),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(24),
                ),
                widget.openChallengesResult != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: ScreenUtil().setSp(43),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Past Challenge Posts',
                                        style: GoogleFonts.nunitoSans(
                                            color: black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(14))),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(130),
                                      child: Divider(
                                        thickness: 1,
                                        height: 1,
                                        color: lightGray,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  ChallengesModelData challengesModelData =
                                      ChallengesModelData(
                                          id: "",
                                          challengeId:
                                              widget.openChallengesResult!.sId!,
                                          challengeName: widget
                                              .openChallengesResult!.hashTag!,
                                          postId: "");
                                  if (widget.openChallengesResult!.type ==
                                      "famelinks") {
                                    var result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FameLinksChallengeScreen(
                                                challengesModelData:
                                                    challengesModelData,
                                              )),
                                    );
                                    if (result != null) {
                                      Navigator.pop(context, result);
                                    }
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FunLinksChallengeScreen(
                                          challengesModelData,
                                          "",
                                          widget.openChallengesResult!.giftCoins
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'See all',
                                      style: GoogleFonts.nunitoSans(
                                        color: lightGray,
                                        fontWeight: FontWeight.w300,
                                        fontSize: ScreenUtil().setSp(14),
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(5),
                                    ),
                                    Icon(Icons.arrow_forward, color: lightGray),
                                    SizedBox(
                                      width: ScreenUtil().setSp(14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: ScreenUtil().setSp(23)),
                            height: ScreenUtil().setHeight(107),
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  widget.openChallengesResult!.posts!.length,
                              itemBuilder: (BuildContext context, int index) {
                                var size = MediaQuery.of(context).size;
                                final double itemWidth = size.width / 4;
                                // Result resultOfFameLinkFullPost = widget.openChallengesResult.posts[index];
                                OpenChallengesResponseResultPosts result =
                                    widget.openChallengesResult!.posts![index];

                                /*if (result.images != null) {
                              for (int i = 0; i < result.images.length; i++) {
                                Media postMedia = result.images[i];
                                if (i == 0 && postMedia.path != null) {
                                  post = postMedia.path;
                                } else if (i == 1 && postMedia.path != null) {
                                  post = postMedia.path;
                                } else if (i == 2 && postMedia.path != null) {
                                  post = postMedia.path;
                                } else if (i == 3 && postMedia.path != null) {
                                  post = postMedia.path;
                                } else if (i == 4 && postMedia.path != null) {
                                  post = postMedia.path;
                                } else if (i == 5 && postMedia.path != null) {
                                  post = postMedia.path;
                                } else if (i == 6 && postMedia.path != null) {
                                  isVideo = true;
                                  post = postMedia.path;
                                }
                              }
                            }*/
                                return InkWell(
                                  onTap: () {
                                    ChallengesModelData challengesModelData =
                                        ChallengesModelData(
                                            id: "",
                                            challengeId: widget
                                                .openChallengesResult!.sId!,
                                            challengeName: widget
                                                .openChallengesResult!.hashTag!,
                                            postId: "");
                                    if (widget.openChallengesResult!.type ==
                                        "famelinks") {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ontext) =>
                                                ChallengeFameLinkFullPostScreen(
                                                    widget.openChallengesResult!
                                                        .postsForFameLink!,
                                                    index,
                                                    1,
                                                    widget.openChallengesResult!
                                                        .sId!,
                                                    widget.openChallengesResult!
                                                        .type!)),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FunLinksChallengeScreen(
                                                    challengesModelData,
                                                    "",
                                                    widget.openChallengesResult!
                                                        .giftCoins
                                                        .toString())),
                                      );
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setSp(3),
                                        bottom: ScreenUtil().setSp(4),
                                        left: ScreenUtil().setSp(2),
                                        right: ScreenUtil().setSp(2)),
                                    child: Container(
                                      color: Colors.blue,
                                      width: itemWidth,
                                      height: ScreenUtil().setHeight(107),
                                      child: result.media?[0]?.type == 'video'
                                          ? Stack(
                                              children: [
                                                Image.network(
                                                  '${widget.openChallengesResult!.type == "famelinks" ? "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}" : "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}"}/${result.media?[0]?.path}-xs', //-sm
                                                  fit: BoxFit.cover,
                                                  width: itemWidth,
                                                  height: itemHeight,
                                                ),
                                                Center(
                                                  child: Container(
                                                    height: ScreenUtil()
                                                        .setHeight(32.94),
                                                    width: ScreenUtil()
                                                        .setWidth(40),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(0.5),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    ScreenUtil()
                                                                        .radius(
                                                                            5)))),
                                                    child: Icon(
                                                      Icons.play_arrow,
                                                      color: black,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          : Image.network(
                                              '${widget.openChallengesResult!.type == "famelinks" ? "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}" : "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}"}/${result.media?[0]?.path}-xs', //-sm
                                              fit: BoxFit.cover,
                                              width: itemWidth,
                                              height:
                                                  ScreenUtil().setHeight(107),
                                            ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
              ],
            ),
          ));
    });
  }

  void showPerDayPostDialog() async {
    var result = await showDialog(
        context: context,
        builder: (BuildContext context3) {
          return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.only(
                  left: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - 300) / 2),
                  right: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - 300) / 2)),
              child: StatefulBuilder(
                  builder: (BuildContext context2, StateSetter setStates) {
                return Container(
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(ScreenUtil().setSp(16))),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          color: black25,
                          blurRadius: 4.0,
                        ),
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(12),
                            bottom: ScreenUtil().setHeight(16),
                            left: ScreenUtil().setHeight(16),
                            right: ScreenUtil().setHeight(16)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setSp(16))),
                          color: appBackgroundColor,
                        ),
                        child: Column(
                          children: [
                            Text.rich(TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text:
                                      'FameLinks is a Contest. As per the rules, you can upload only ',
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      color: black,
                                      fontSize: ScreenUtil().setSp(14))),
                              TextSpan(
                                  text: 'One Post per day',
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: ScreenUtil().setSp(14),
                                      color: black)),
                              TextSpan(
                                  text: ' in FameLinks.',
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      color: black,
                                      fontSize: ScreenUtil().setSp(14))),
                            ])),
                            SizedBox(
                              height: ScreenUtil().setSp(16),
                            ),
                            Text(
                                'Please take your time till tomorrow to prepare well and showcase the best of you.',
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w300,
                                    color: black,
                                    fontStyle: FontStyle.italic,
                                    fontSize: ScreenUtil().setSp(12))),
                            InkWell(
                              onTap: () async {
                                Navigator.pop(context2);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setSp(24),
                                    bottom: ScreenUtil().setSp(12)),
                                width: ScreenUtil().setWidth(96),
                                height: ScreenUtil().setHeight(26),
                                decoration: new BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [lightRedWhite, lightRed]),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Got it',
                                      style: GoogleFonts.nunitoSans(
                                          color: white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: ScreenUtil().setSp(14)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }));
        });
    if (result != null) {
      if (result == true) {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileVideoVerificationScreen()),
        );
        if (result != null) {
          var snackBar = SnackBar(
            content: Text('Compressing'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Constants.verificationStatus = "Submitted";
          final MediaInfo? info = await VideoCompress.compressVideo(
            result,
            quality: VideoQuality.MediumQuality,
            deleteOrigin: false,
            includeAudio: true,
          );
          Constants.video = await MultipartFile.fromFile(info!.path!,
              filename: "${File(result).path.split('/').last}");
          var formData = FormData.fromMap({
            "video": Constants.video,
          });
          Api.uploadPost.call(context,
              method: "users/profile/verify",
              param: formData, onResponseSuccess: (Map object) {
            var snackBar = SnackBar(
              content: Text('Uploaded'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        }
      } else {
        ChallengesModelData challengesModelData = ChallengesModelData(
            id: "",
            challengeId: widget.openChallengesResult!.sId!,
            challengeName: widget.openChallengesResult!.hashTag!,
            postId: "");
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context2) => UploadScreenOne(
                      challengesModelData: challengesModelData,
                    )));
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
          Api.uploadPost.call(context, method: "media/contest", param: formData,
              onResponseSuccess: (Map object) {
            var snackBar = SnackBar(
              content: Text('Uploaded'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        }
      }
    }
  }

  void showProfileVerifyDialog() async {
    var result = await showDialog(
        context: context,
        builder: (BuildContext context3) {
          return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.only(
                  left: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - 300) / 2),
                  right: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - 300) / 2)),
              child: StatefulBuilder(
                  builder: (BuildContext context2, StateSetter setStates) {
                return Form(
                  key: _profileKey,
                  child: Container(
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenUtil().setSp(16))),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            color: black25,
                            blurRadius: 4.0,
                          ),
                        ]),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular(ScreenUtil().setSp(16)),
                                topRight:
                                    Radius.circular(ScreenUtil().setSp(16))),
                          ),
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(16),
                              bottom: ScreenUtil().setHeight(14),
                              left: ScreenUtil().setWidth(16),
                              right: ScreenUtil().setWidth(5)),
                          child: Row(
                            children: [
                              Text(
                                'Please verify your profile',
                                style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(14),
                                    color: black,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(8),
                              ),
                              SvgPicture.asset("assets/icons/svg/done.svg",
                                  height: ScreenUtil().setSp(16),
                                  width: ScreenUtil().setSp(16))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(12),
                              bottom: ScreenUtil().setHeight(16),
                              left: ScreenUtil().setHeight(16),
                              right: ScreenUtil().setHeight(16)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(ScreenUtil().setSp(16)),
                                bottomRight:
                                    Radius.circular(ScreenUtil().setSp(16))),
                            color: appBackgroundColor,
                          ),
                          child: Column(
                            children: [
                              Provider.of<ChallengeScreenProvider>(context)
                                              .getAgeGroup ==
                                          "groupA" ||
                                      Provider.of<ChallengeScreenProvider>(
                                                  context)
                                              .getAgeGroup ==
                                          "groupB" ||
                                      Provider.of<ChallengeScreenProvider>(
                                                  context)
                                              .getAgeGroup ==
                                          "groupC"
                                  ? Text.rich(TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: 'To be able to',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize:
                                                  ScreenUtil().setSp(14))),
                                      TextSpan(
                                          text: ' Upload Posts',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(14),
                                              color: black)),
                                      TextSpan(
                                          text: ' or ',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize:
                                                  ScreenUtil().setSp(14))),
                                      TextSpan(
                                          text: 'Participate in Contests',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(14),
                                              color: black)),
                                      TextSpan(
                                          text:
                                              ' on FameLinks App, you are required to verify your profile.',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize:
                                                  ScreenUtil().setSp(14))),
                                    ]))
                                  : Text.rich(TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: 'To be able to ',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize:
                                                  ScreenUtil().setSp(14))),
                                      TextSpan(
                                          text: 'Participate in Contests',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(14),
                                              color: black)),
                                      TextSpan(
                                          text:
                                              ' on FameLinks App, you are required to verify your profile.',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize:
                                                  ScreenUtil().setSp(14))),
                                    ])),
                              InkWell(
                                onTap: () async {
                                  Navigator.pop(context2, true);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setSp(18),
                                      bottom: ScreenUtil().setSp(21)),
                                  width: ScreenUtil().setWidth(96),
                                  height: ScreenUtil().setHeight(26),
                                  decoration: new BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [lightRedWhite, lightRed]),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6),
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Verify',
                                        style: GoogleFonts.nunitoSans(
                                            color: white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: ScreenUtil().setSp(14)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Provider.of<ChallengeScreenProvider>(context)
                                              .getAgeGroup ==
                                          "groupA" ||
                                      Provider.of<ChallengeScreenProvider>(
                                                  context)
                                              .getAgeGroup ==
                                          "groupB" ||
                                      Provider.of<ChallengeScreenProvider>(
                                                  context)
                                              .getAgeGroup ==
                                          "groupC"
                                  ? Text(
                                      'You can still see Posts and browse the App if you skip this important step',
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w300,
                                          color: black,
                                          fontStyle: FontStyle.italic,
                                          fontSize: ScreenUtil().setSp(12)))
                                  : Text.rich(TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Your posts can still be seen in ',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w300,
                                              color: black,
                                              fontStyle: FontStyle.italic,
                                              fontSize:
                                                  ScreenUtil().setSp(12))),
                                      TextSpan(
                                          text: 'FollowLinks & FunLinks, ',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(12),
                                              color: black)),
                                      TextSpan(
                                          text:
                                              'if you skip this important step',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w300,
                                              color: black,
                                              fontStyle: FontStyle.italic,
                                              fontSize:
                                                  ScreenUtil().setSp(12))),
                                    ])),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () async {
                                      print(
                                          "AGEE:::${Provider.of<ChallengeScreenProvider>(context).getAgeGroup}");
                                      if (Provider.of<ChallengeScreenProvider>(context).getAgeGroup == "groupA" ||
                                          Provider.of<ChallengeScreenProvider>(
                                                      context)
                                                  .getAgeGroup ==
                                              "groupB" ||
                                          Provider.of<ChallengeScreenProvider>(
                                                      context)
                                                  .getAgeGroup ==
                                              "groupC") {
                                        Navigator.pop(context2);
                                      } else {
                                        Navigator.pop(context2, false);
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenUtil().setSp(10),
                                          top: ScreenUtil().setSp(6),
                                          bottom: ScreenUtil().setSp(6)),
                                      child: Text('Skip for Now',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: buttonBlue,
                                              fontSize:
                                                  ScreenUtil().setSp(10))),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }));
        });
    if (result != null) {
      if (result == true) {
        final result3 = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileVideoVerificationScreen()),
        );
        if (result3 != null) {
          var snackBar = SnackBar(
            content: Text('Compressing'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Constants.verificationStatus = "Submitted";
          final MediaInfo? info = await VideoCompress.compressVideo(
            result3,
            quality: VideoQuality.MediumQuality,
            deleteOrigin: false,
            includeAudio: true,
          );
          Constants.video = await MultipartFile.fromFile(info!.path!,
              filename: "${File(result3).path.split('/').last}");
          var formData = FormData.fromMap({
            "video": Constants.video,
          });
          Api.uploadPost.call(context,
              method: "users/profile/verify",
              param: formData, onResponseSuccess: (Map object) {
            var snackBar = SnackBar(
              content: Text('Uploaded'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        }
      } else {
        ChallengesModelData challengesModelData = ChallengesModelData(
            id: "",
            challengeId: widget.openChallengesResult!.sId!,
            challengeName: widget.openChallengesResult!.hashTag!,
            postId: "");
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context2) => UploadScreenOne(
                      challengesModelData: challengesModelData,
                    )));
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
          });
          if (map['video'] != null) {
            var snackBar = SnackBar(
              content: Text('Compressing'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            final MediaInfo? info = await VideoCompress.compressVideo(
              map['video'],
              quality: VideoQuality.HighestQuality,
              deleteOrigin: false,
              includeAudio: true,
            );
            await MultipartFile.fromFile(info!.path!,
                    filename: "${File(map['video']).path.split('/').last}")
                .then((value) async {
              formData.files.addAll([
                MapEntry("video", value),
              ]);
              Api.uploadPost.call(context,
                  method: "media/contest",
                  param: formData, onResponseSuccess: (Map object) {
                    Constants.todayPosts = 1;
                var snackBar = SnackBar(
                  content: Text('Uploaded'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            });
          } else {
            Api.uploadPost.call(context,
                method: "media/contest",
                param: formData, onResponseSuccess: (Map object) {
                  Constants.todayPosts = 1;
              var snackBar = SnackBar(
                content: Text('Uploaded'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });
          }
        }
      }
    }
  }

/*void _openChallengesSlider() async {
    Api.get.call(context, method: "challenges/open/slider", param: {},
        onResponseSuccess: (Map object) {
      var result = ChallengeSlider.fromJson(object);
      openChallengesBanner = result.result;
      setState(() {});
      if (openChallengesBanner.length > 0) {
        _addChallengeImpression(openChallengesBanner.elementAt(0).id, 0);
      }
    });
  }

  void _addChallengeImpression(String id, int index) async {
    Api.put.call(context,
        method: "challenges/${id}/impressions",
        param: {"impressions": "1"},
        isLoading: false, onResponseSuccess: (Map object) {
      openChallengesBanner.elementAt(index).isImpression = true;
    });
  }

  void _addUpcomingChallengeImpression(String id, int index) async {
    Api.put.call(context,
        method: "challenges/${id}/impressions",
        param: {"impressions": "1"},
        isLoading: false, onResponseSuccess: (Map object) {
      upcomingChallengesBanner.elementAt(index).isImpression = true;
    });
  }

  void _upcomingChallengesSlider() async {
    Api.get.call(context, method: "challenges/upcoming/slider", param: {},
        onResponseSuccess: (Map object) {
      var result = ChallengeSlider.fromJson(object);
      upcomingChallengesBanner = result.result;
      setState(() {});
      if (upcomingChallengesBanner.length > 0) {
        _addUpcomingChallengeImpression(
            upcomingChallengesBanner.elementAt(0).id, 0);
      }
    });
  }*/
}

String convertToAgo(DateTime input) {
  Duration diff = DateTime.now().difference(input);

  if (diff.inDays >= 1) {
    return '${diff.inDays} d ago';
  } else if (diff.inHours >= 1) {
    return '${diff.inHours} hr ago';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes} mins ago';
  } else if (diff.inSeconds >= 1) {
    return '${diff.inSeconds} sec ago';
  } else {
    return 'just now';
  }
}
