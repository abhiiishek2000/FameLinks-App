import 'package:famelink/databse/AppDatabase.dart';
import 'package:famelink/models/WinnersModel.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/challenge/ChallengeFameLinkFullPostScreen.dart';
import 'package:famelink/ui/funlinks/FameLinksChallengeScreen.dart';
import 'package:famelink/ui/funlinks/FunLinksChallengeScreen.dart';
import 'package:famelink/ui/profile/other_profile_screen.dart';
import 'package:famelink/ui/profile/profile_screen.dart';
import 'package:famelink/util/ReadMoreText.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:famelink/models/famelinks_model.dart';

class WinnerChallengeDetailsScreen extends StatefulWidget {
  WinnersResult winnersResult;

  WinnerChallengeDetailsScreen(this.winnersResult);

  @override
  _WinnerChallengeDetailsScreenState createState() =>
      _WinnerChallengeDetailsScreenState();
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

class _WinnerChallengeDetailsScreenState
    extends State<WinnerChallengeDetailsScreen> {
  // List<BannerImage> openChallengesBanner = [];
  // List<BannerImage> upcomingChallengesBanner = [];
  PageController pageController = PageController(keepPage: true);

  int endTime = 0;

  String type = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.winnersResult.mediaPreference!.length > 1) {
      type = "Image & Videos";
    } else if (widget.winnersResult.mediaPreference![0] == "photo") {
      type = "Image Only";
    } else if (widget.winnersResult.mediaPreference![0] == "video") {
      type = "Videos Only";
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    final double itemWidth = size.width / 2;
    final double itemHeight = itemWidth + 30;
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
              "${widget.winnersResult.name} ",
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: ScreenUtil().setSp(32),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                            "Sponsored by-",
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w400,
                                color: black)),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                            "${widget.winnersResult.sponsor!
                                .elementAt(0)
                                .name}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(18),
                                fontWeight: FontWeight.w700,
                                color: buttonBlue)),
                      ),
                      SizedBox(
                        height: ScreenUtil().setSp(12),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                            "${widget.winnersResult.reward}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w700,
                                color: black)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: widget.winnersResult.winner!.length > 0 ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          alignment:
                          Alignment.center,
                          width: ScreenUtil().setSp(50),
                          height: ScreenUtil().setSp(50),
                          decoration: new BoxDecoration(shape: BoxShape.circle,
                              image: new DecorationImage(fit: BoxFit.cover,
                                  image: NetworkImage(
                                      '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${widget
                                          .winnersResult.winner!
                                          .elementAt(0)
                                          .profileImage}')))),

                      Text(
                        widget.winnersResult.winner!.elementAt(0).name
                            .toString(),
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(12),
                            color: black),
                      ),
                      Text.rich(TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: widget.winnersResult.winner!
                                .elementAt(0)
                                .country,
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w300,
                                color: black,
                                fontSize: ScreenUtil().setSp(10))),
                        TextSpan(
                            text: " ${NumberFormat
                                .compactCurrency(
                              decimalDigits: 0,
                              symbol:
                              '', // if you want to add currency symbol then pass that in this else leave it empty.
                            ).format(widget.winnersResult.winner!
                                .elementAt(0)
                                .likesCount)} Hearts",
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(10),
                                color: darkGray)),
                      ])),
                    ],
                  ) : Container(),
                )
              ],
            ),
            SizedBox(
              height: ScreenUtil().setSp(29),
            ),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              childAspectRatio: (itemWidth / itemHeight),
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                  top: ScreenUtil().setSp(5),
                  left: ScreenUtil().setSp(8),
                  right: ScreenUtil().setSp(8)),
              children: List.generate(
                  widget.winnersResult.winner!.length > 1 ? widget.winnersResult
                      .winner!.length - 1 : 0, (index) {
                // if(myFameResult[index].images[0].type == "video"){
                //   print("VIDEO:::${myFameResult[index].images[0].type}");
                //   downloadFile(myFameResult[index].images[0].path);
                // }
                Winner winner = widget.winnersResult.winner!.elementAt(
                    index + 1);

                return InkWell(
                  onTap: () {
                    Constants.profileUserId   =
                        winner.sId;
                    if (Constants.userId ==
                        Constants.profileUserId  ) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfileScreen()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OtherProfileScreen()));
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                          alignment:
                          Alignment.center,
                          width: ScreenUtil().setSp(50),
                          height: ScreenUtil().setSp(50),
                          decoration: new BoxDecoration(shape: BoxShape.circle,
                              image: new DecorationImage(fit: BoxFit.cover,
                                  image: NetworkImage(
                                      '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${winner
                                          .profileImage}')))),

                      Text(
                        winner.name.toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(fontWeight: FontWeight
                            .w400,
                            fontSize: ScreenUtil().setSp(10),
                            color: black),
                      ),
                      Text.rich(TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: " ${NumberFormat
                                .compactCurrency(
                              decimalDigits: 0,
                              symbol:
                              '', // if you want to add currency symbol then pass that in this else leave it empty.
                            ).format(winner.likesCount)} Hearts",
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(8),
                                color: darkGray)),
                      ])),
                    ],
                  ),
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setSp(22), right: ScreenUtil().setSp(22)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ReadMoreText(
                  //     '${widget.winnersResult.description}',
                  //     trimLines: 4,
                  //     trimMode: TrimMode.Line,
                  //     style: GoogleFonts.nunitoSans(
                  //         fontSize: ScreenUtil().setSp(12),
                  //         fontWeight: FontWeight.w300,
                  //         color: black),
                  //
                  // ),
                  SizedBox(
                    height: ScreenUtil().setSp(16),
                  ),
                  Row(
                    children: [
                      Text(
                        "Joined by ${NumberFormat
                            .compactCurrency(
                          decimalDigits: 0,
                          symbol:
                          '', // if you want to add currency symbol then pass that in this else leave it empty.
                        ).format(widget.winnersResult.participantsCount)}",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(10),
                            color: black),
                      ), Text(
                        widget.winnersResult
                            .endDate != null ? 'Ended ${convertToAgo(
                            DateTime.parse(widget.winnersResult
                                .endDate.toString()))}' : "",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(10),
                            color: black),
                      ), Text(
                        'See Prev Session ->',
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(10),
                            color: black),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(24),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setSp(22),
                  right: ScreenUtil().setSp(22),
                  bottom: ScreenUtil().setSp(8)),
              child: Text('Type: ${type}',
                  style: GoogleFonts.nunitoSans(
                      color: black,
                      fontWeight: FontWeight.w300,
                      fontSize: ScreenUtil().setSp(14))),
            ),
            widget.winnersResult != null
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: ScreenUtil().setSp(22),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Challenge Posts',
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
                            widget.winnersResult.sId.toString(),
                            challengeName:
                            widget.winnersResult.name.toString(),
                            postId: "");
                        if (widget.winnersResult.type ==
                            "famelinks") {
                          var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FameLinksChallengeScreen(
                                      challengesModelData: challengesModelData,)),
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
                                        challengesModelData, "", "")),
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Text('See all',
                              style: GoogleFonts.nunitoSans(
                                  color: lightGray,
                                  fontWeight: FontWeight.w300,
                                  fontSize: ScreenUtil().setSp(14))),
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
                  margin: EdgeInsets.only(left: ScreenUtil().setSp(22)),
                  child: GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    childAspectRatio: (itemWidth / itemHeight),
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(
                        widget.winnersResult.posts!.length, (index) {
                      var size = MediaQuery
                          .of(context)
                          .size;
                      final double itemWidth = size.width / 3;
                      Result result =
                      widget.winnersResult.posts![index];
                      String post = "";
                      bool isVideo = false;
                      if (result.images!.length > 0) {
                        Media postMedia = result.images![0];
                        post = postMedia.path!;
                        if (postMedia.type == "video") {
                          isVideo = true;
                        }
                      }
                      return InkWell(
                        onTap: () {
                          ChallengesModelData challengesModelData =
                          ChallengesModelData(
                              id: "",
                              challengeId:
                              widget.winnersResult.sId.toString(),
                              challengeName:
                              widget.winnersResult.name.toString(),
                              postId: "");
                          if (widget.winnersResult.type ==
                              "famelinks") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ontext) =>
                                      ChallengeFameLinkFullPostScreen(
                                          widget.winnersResult.posts!.toList(),
                                          index,
                                          1,
                                          widget.winnersResult.sId.toString(),
                                          widget
                                              .winnersResult.type.toString())),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FunLinksChallengeScreen(
                                          challengesModelData, "", "")),
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
                            child: isVideo
                                ? Stack(
                              children: [
                                Image.network(
                                  '${widget.winnersResult.type == "famelinks"
                                      ? "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks }"
                                      : "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}"}/${post}-sm',
                                  fit: BoxFit.cover,
                                  width: itemWidth,
                                  height: itemHeight,
                                ),
                                Center(
                                  child: Container(
                                    height:
                                    ScreenUtil().setHeight(32.94),
                                    width: ScreenUtil().setWidth(40),
                                    decoration: BoxDecoration(
                                        color: Colors.white
                                            .withOpacity(0.5),
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil()
                                                    .radius(5)))),
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: black,
                                    ),
                                  ),
                                )
                              ],
                            )
                                : Image.network(
                              '${widget.winnersResult.type == "famelinks"
                                  ? "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks }"
                                  : "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}"}/${post}-sm',
                              fit: BoxFit.cover,
                              width: itemWidth,
                              height: ScreenUtil().setHeight(107),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            )
                : SizedBox(),
          ],
        ),
      ),
    );
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
