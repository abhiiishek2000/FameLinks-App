import 'package:carousel_slider/carousel_slider.dart';
import 'package:famelink/databse/AppDatabase.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/ChallengeSlider.dart';
import 'package:famelink/models/OpenChallengesResponse.dart';
import 'package:famelink/models/WinnersModel.dart';
import 'package:famelink/models/upcoming_challenges_model.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/providers/ChallengeProvider/famelinkChallengeProvider.dart';
import 'package:famelink/ui/challenge/WinnerChallengeDetailsScreen.dart';
import 'package:famelink/ui/challenge/widgets/rating_dialog.dart';
import 'package:famelink/ui/funlinks/FunLinksChallengeScreen.dart';
import 'package:famelink/ui/profile/agency_other_profile_screen.dart';
import 'package:famelink/ui/profile/agency_profile_screen.dart';
import 'package:famelink/ui/profile/brand_other_profile_screen.dart';
import 'package:famelink/ui/profile/brand_profile_screen.dart';
import 'package:famelink/ui/profile/other_profile_screen.dart';
import 'package:famelink/ui/profile/profile_screen.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../common/common_image.dart';
import '../../share/firebasedynamiclink.dart';
import 'ChallengeDetailsScreen.dart';

class ChallengeScreen extends StatefulWidget {
  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen>
    with TickerProviderStateMixin {
  final ApiProvider _api = ApiProvider();

  // List<OpenChallengesResult> openChallengesResult = [];
  // List<BannerImage> openChallengesBanner = [];
  // List<BannerImage> upcomingChallengesBanner = [];

  // List<UpcomingChallengesResult> upcomingChallengesResult = [];
  // List<WinnersResult> winnersResult = [];
  // PageController pageController = PageController(keepPage: true);
  // PageController upComingPageController = PageController(keepPage: true);
  ScrollController upcomingScrollController = ScrollController();
  ScrollController winnersScrollController = ScrollController();
  AnimationController? _speedDialController;

  int upcomingPage = 1;
  int winnersPage = 1;

  TabController? tabController;

  double sliderValue = 1;

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      Constants.playing = false;
    });
    _speedDialController = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    tabController = TabController(length: 3, vsync: this);
    tabController!.addListener(() {
      if (Provider.of<ChallengeScreenProvider>(context, listen: false)
              .upcomingChallengesBanner
              .length >
          0) {
        if (!Provider.of<ChallengeScreenProvider>(context, listen: false)
            .upcomingChallengesBanner
            .elementAt(0)
            .isImpression!) {
          print(
              "ID:::${Provider.of<ChallengeScreenProvider>(context, listen: false).upcomingChallengesBanner.elementAt(0).id}");
          _addUpcomingChallengeImpression(
              Provider.of<ChallengeScreenProvider>(context, listen: false)
                  .upcomingChallengesBanner
                  .elementAt(0)
                  .id!,
              0);
        }
      }
    });
    //_challenges();
    upcomingScrollController.addListener(() {
      if (upcomingScrollController.position.maxScrollExtent ==
          upcomingScrollController.position.pixels) {
        upcomingPage++;
        _upComingChallenges();
      }
    });
    winnersScrollController.addListener(() {
      if (winnersScrollController.position.maxScrollExtent ==
          winnersScrollController.position.pixels) {
        winnersPage++;
        _winnersChallenges();
      }
    });
    _openChallengesSlider();
    _openChallenges();
    _upcomingChallengesSlider();
    _upComingChallenges();
    _winnersChallenges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: ScreenUtil().setHeight(84),
          backgroundColor: appBackgroundColor,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          actions: [
            // IconButton(
            //     onPressed: () {},
            //     icon: SvgPicture.asset("assets/icons/svg/search.svg",color: lightGray,))
          ],
          title: Text.rich(TextSpan(children: <TextSpan>[
            TextSpan(
                text: "Trendz",
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w700,
                    color: lightRed,
                    fontSize: ScreenUtil().setSp(24))),
          ]))),
      body: _challengesTabSection(context),
    );
  }

  Widget _challengesTabSection(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    final double itemHeight = itemWidth + 30;
    return Consumer<ChallengeScreenProvider>(
        builder: (context, challengeScreen, child) {
      return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(8),
                  right: ScreenUtil().setWidth(8)),
              height: ScreenUtil().setHeight(28),
              child: TabBar(
                controller: tabController,
                tabs: [
                  Tab(
                    text: "Open",
                  ),
                  Tab(text: "Upcoming"),
                  Tab(text: "Winners"),
                ],
                labelColor: darkGray,
                unselectedLabelColor: lightGray,
                indicatorColor: darkGray,
                unselectedLabelStyle: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(14)),
                labelStyle: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenUtil().setSp(16)),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(2)),
                height: MediaQuery.of(context).size.height,
                width: ScreenUtil().screenWidth,
                child: TabBarView(children: [
                  ///open
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(10)),
                    child: challengeScreen.openChallengesResult.isEmpty
                        ? Center(
                            child: Text("",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                          )
                        : ListView.builder(
                            itemBuilder: (openContext, index) {
                              double parti;
                              if (challengeScreen
                                      .openChallengesResult[index].category ==
                                  "participants") {
                                parti = challengeScreen
                                        .openChallengesResult[index]
                                        .totalParticipants! /
                                    challengeScreen.openChallengesResult[index]
                                        .requiredParticipants! *
                                    100;
                              } else if (challengeScreen
                                      .openChallengesResult[index].category ==
                                  "post") {
                                parti = challengeScreen
                                        .openChallengesResult[index]
                                        .totalPost! /
                                    challengeScreen.openChallengesResult[index]
                                        .requiredPost! *
                                    100;
                              } else if (challengeScreen
                                      .openChallengesResult[index].category ==
                                  "impressions") {
                                parti = challengeScreen
                                        .openChallengesResult[index]
                                        .totalImpressions! /
                                    challengeScreen.openChallengesResult[index]
                                        .requiredImpressions! *
                                    100;
                              }

                              if (index == 0) {
                                return Container(
                                  width: ScreenUtil().screenWidth,
                                  height: ScreenUtil().setHeight(214),
                                  color: appBackgroundColor,
                                  child: Stack(
                                    children: [
                                      CarouselSlider(
                                          items: Provider.of<
                                                      ChallengeScreenProvider>(
                                                  context,
                                                  listen: false)
                                              .getChallengeSlider
                                              .map((i) {
                                            return Builder(
                                              builder: (BuildContext context) {
                                                return Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            appBackgroundColor),
                                                    child: Image.network(
                                                      i.media!,
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
                                            autoPlay: false,
                                            autoPlayInterval:
                                                Duration(seconds: 3),
                                            autoPlayAnimationDuration:
                                                Duration(milliseconds: 800),
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            enlargeCenterPage: true,
                                            onPageChanged: (index, reason) {
                                              Provider.of<ChallengeScreenProvider>(
                                                      context,
                                                      listen: false)
                                                  .changePageController(
                                                      PageController(
                                                          keepPage: true,
                                                          initialPage: index));
                                              if (!Provider.of<
                                                              ChallengeScreenProvider>(
                                                          context,
                                                          listen: false)
                                                      .getChallengeSlider
                                                      .elementAt(index)
                                                      .isImpression! &&
                                                  tabController!.index == 0) {
                                                _addChallengeImpression(
                                                    Provider.of<ChallengeScreenProvider>(
                                                            context,
                                                            listen: false)
                                                        .getChallengeSlider
                                                        .elementAt(index)
                                                        .id!,
                                                    index);
                                              }
                                            },
                                            scrollDirection: Axis.horizontal,
                                          )),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom:
                                                  ScreenUtil().setHeight(10)),
                                          child: SmoothPageIndicator(
                                            controller: Provider.of<
                                                        ChallengeScreenProvider>(
                                                    context,
                                                    listen: false)
                                                .getPageController,
                                            count: Provider.of<
                                                        ChallengeScreenProvider>(
                                                    context,
                                                    listen: false)
                                                .getChallengeSlider
                                                .length,
                                            axisDirection: Axis.horizontal,
                                            effect: SlideEffect(
                                                spacing: 10.0,
                                                radius: 3.0,
                                                dotWidth: 6.0,
                                                dotHeight: 6.0,
                                                paintStyle:
                                                    PaintingStyle.stroke,
                                                strokeWidth: 1.5,
                                                dotColor: Colors.white,
                                                activeDotColor: lightRed),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                OpenChallengesResult openChallenges =
                                    challengeScreen
                                        .openChallengesResult[index - 1];
                                String name = "";
                                String photos = "";

                                // print(openChallenges.percentCompleted / 100);
                                // if(openChallenges.users.length > 0) {
                                //   name = openChallenges.users.join("/");
                                // }
                                // if(openChallenges.mediaPreference.length > 0) {
                                //   if (openChallenges.mediaPreference.length > 1) {
                                //     photos = "(Photo & Videos)";
                                //   } else
                                //   if (openChallenges.mediaPreference[0] == "photo") {
                                //     photos = "(Photo Only)";
                                //   } else
                                //   if (openChallenges.mediaPreference[0] == "video") {
                                //     photos = "(Videos Only)";
                                //   }
                                // }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: ScreenUtil().setHeight(9),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            var result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChallengeDetailsScreen(
                                                        null,
                                                        challengeScreen
                                                                .openChallengesResult[
                                                            index - 1],
                                                        index - 1),
                                              ),
                                            );
                                            if (result != null) {
                                              Navigator.pop(context, result);
                                            }
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Wrap(
                                                  alignment:
                                                      WrapAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                                '${openChallenges.hashTag}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: GoogleFonts.nunitoSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize: ScreenUtil()
                                                                        .setSp(
                                                                            14),
                                                                    color:
                                                                        black)),
                                                            Container(
                                                              height: 20,
                                                              child: Row(
                                                                children: [
                                                                  Text("("),
                                                                  Wrap(
                                                                    children: openChallenges
                                                                        .for1!
                                                                        .map<
                                                                            Widget>((e) => openChallenges.for1!.length ==
                                                                                0
                                                                            ? Text(
                                                                                '${openChallenges.for1![0]}/ ',
                                                                                style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w600, fontSize: ScreenUtil().setSp(14), color: black),
                                                                              )
                                                                            : Text(
                                                                                '${openChallenges.for1![0]}',
                                                                                style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w600, fontSize: ScreenUtil().setSp(14), color: black),
                                                                              ))
                                                                        .toList(),
                                                                  ),
                                                                  Text(")"),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          openChallenges.sponsor !=
                                                                      null &&
                                                                  openChallenges
                                                                      .sponsor!
                                                                      .isNotEmpty
                                                              ? 'by ${openChallenges.sponsor![0].name}'
                                                              : '',
                                                          style: GoogleFonts.nunitoSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          14),
                                                              color: HexColor(
                                                                  "FF5C28")),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Sharedynamic.shareprofile(
                                                      challengeScreen
                                                          .openChallengesResult[
                                                              index]
                                                          .sId
                                                          .toString(),
                                                      "trendz",
                                                      openChallenges.hashTag
                                                          .toString());
                                                },
                                                child: Image.asset(
                                                  CommonImage.share,
                                                  color: Colors.black,
                                                  width: 15,
                                                ),
                                              ),
                                              SizedBox(width: 12.w),
                                              InkWell(
                                                onTap: () => showRateDialog(
                                                  context,
                                                  openChallenges,
                                                  index - 1,
                                                  '${openChallenges.sId}',
                                                  initialValue:
                                                      openChallenges.rating !=
                                                              null
                                                          ? openChallenges
                                                              .rating!.rating
                                                          : null,
                                                ),
                                                child: openChallenges.rating !=
                                                        null
                                                    ? Row(
                                                        children: [
                                                          Text(
                                                            "Rated",
                                                            style: GoogleFonts.nunitoSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            12),
                                                                color:
                                                                    lightGray),
                                                          ),
                                                          SizedBox(width: 4),
                                                          Container(
                                                            height: 18,
                                                            width: 18,
                                                            child: Stack(
                                                              children: [
                                                                SvgPicture.asset(
                                                                    'assets/icons/ic_liked.svg'),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    openChallenges
                                                                        .rating!
                                                                        .rating
                                                                        .toString(),
                                                                    style: GoogleFonts.nunitoSans(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            ScreenUtil().setSp(
                                                                                10),
                                                                        color:
                                                                            white),
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
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            12),
                                                                color: orange),
                                                          ),
                                                          SizedBox(width: 4),
                                                          SvgPicture.asset(
                                                              'assets/icons/svg/ic_like.svg'),
                                                        ],
                                                      ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            openChallenges.percentCompleted !=
                                                    null
                                                ? Flexible(
                                                    child: Container(
                                                      height: ScreenUtil()
                                                          .setSp(16),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: lightGray,
                                                            width: ScreenUtil()
                                                                .setSp(1)),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            4))),
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            height: ScreenUtil()
                                                                .setSp(16),
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              3))),
                                                              child:
                                                                  LinearProgressIndicator(
                                                                value: openChallenges
                                                                        .percentCompleted /
                                                                    100.toDouble(),
                                                                //(parti)
                                                                valueColor: AlwaysStoppedAnimation(
                                                                    openChallenges.percentCompleted >=
                                                                            80
                                                                        ? lightRed
                                                                        : Colors
                                                                            .green),
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                              // child: LinearPercentIndicator(
                                                              //   percent: openChallenges.percentCompleted/100,
                                                              //   progressColor: openChallenges.percentCompleted >=80 ?lightRed:Colors.green,
                                                              //   backgroundColor: Colors.white,
                                                              // ),
                                                            ),
                                                          ),
                                                          Align(
                                                            child: Text(
                                                                "${openChallenges.percentCompleted}%",
                                                                style: GoogleFonts.nunitoSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize: ScreenUtil()
                                                                        .setSp(
                                                                            8),
                                                                    color: openChallenges.percentCompleted >
                                                                            50
                                                                        ? white
                                                                        : black)),
                                                            alignment: Alignment
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    fit: FlexFit.tight,
                                                  )
                                                : SizedBox(),
                                            SizedBox(
                                              width: ScreenUtil().setSp(8),
                                            ),
                                            Text(
                                                'Started ${convertToAgo(DateTime.parse(openChallenges.startDate!))}',
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: buttonBlue)),
                                            SizedBox(
                                              width: ScreenUtil().setSp(15),
                                            ),
                                            SvgPicture.asset(
                                              CommonImage.upload,
                                              color: Colors.black,
                                              width: 16,
                                              height: 16,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text("Participate",
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: Color(0xff4B4E58))),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(107),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: openChallenges.posts!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var size =
                                              MediaQuery.of(context).size;
                                          final double itemWidth =
                                              size.width / 4;
                                          // Result result = openChallenges.posts[index];
                                          OpenChallengesResponseResultPosts
                                              result =
                                              openChallenges.posts![index];

                                          return InkWell(
                                            onTap: () {
                                              ChallengesModelData
                                                  challengesModelData =
                                                  ChallengesModelData(
                                                      id: "",
                                                      challengeId:
                                                          openChallenges.sId!,
                                                      challengeName:
                                                          openChallenges
                                                              .hashTag!,
                                                      postId: "");
                                              if (openChallenges.type ==
                                                  "famelinks") {
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //       builder: (ontext) =>
                                                //           ChallengeFameLinkFullPostScreen(
                                                //               openChallenges.posts,
                                                //               index, 1,
                                                //               openChallenges.sId,
                                                //               openChallenges.type)),
                                                // );
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FunLinksChallengeScreen(
                                                              challengesModelData,
                                                              "",
                                                              openChallenges
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
                                                height:
                                                    ScreenUtil().setHeight(107),
                                                child: result.media?[0]?.type ==
                                                        'video'
                                                    ? Stack(
                                                        children: [
                                                          Image.network(
                                                            '${openChallenges.type == "famelinks" ? "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}" : "${ApiProvider.s3UrlPath}${ApiProvider.funlinks}"}/${result.media?[0]?.path}-xs',
                                                            fit: BoxFit.cover,
                                                            width: itemWidth,
                                                            height: itemHeight,
                                                          ),
                                                          Center(
                                                            child: Container(
                                                              height: ScreenUtil()
                                                                  .setHeight(
                                                                      32.94),
                                                              width:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          40),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.5),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              ScreenUtil().radius(5)))),
                                                              child: Icon(
                                                                Icons
                                                                    .play_arrow,
                                                                color: black,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    : Image.network(
                                                        '${openChallenges.type == "famelinks" ? "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}" : "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}"}/${result.media?[0]?.path}-xs',
                                                        fit: BoxFit.cover,
                                                        width: itemWidth,
                                                        height: ScreenUtil()
                                                            .setHeight(107),
                                                      ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: lightGray,
                                    )
                                  ],
                                );
                              }
                            },
                            itemCount:
                                challengeScreen.openChallengesResult.length,
                          ),
                  ),

                  ///upcoming
                  SingleChildScrollView(
                    controller: upcomingScrollController,
                    child: Column(
                      children: [
                        Container(
                          width: ScreenUtil().screenWidth,
                          height: ScreenUtil().setHeight(214),
                          color: appBackgroundColor,
                          child: Stack(
                            children: [
                              CarouselSlider(
                                  items: Provider.of<ChallengeScreenProvider>(
                                          context,
                                          listen: false)
                                      .upcomingChallengesBanner
                                      .map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                color: appBackgroundColor),
                                            child: Image.network(
                                              i.media!,
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
                                      Provider.of<ChallengeScreenProvider>(
                                              context,
                                              listen: false)
                                          .changeUpComingPageController(
                                              PageController(
                                                  keepPage: true,
                                                  initialPage: index));
                                      if (!Provider.of<ChallengeScreenProvider>(
                                                  context,
                                                  listen: false)
                                              .upcomingChallengesBanner
                                              .elementAt(index)
                                              .isImpression! &&
                                          tabController!.index == 1) {
                                        _addUpcomingChallengeImpression(
                                            Provider.of<ChallengeScreenProvider>(
                                                    context,
                                                    listen: false)
                                                .upcomingChallengesBanner
                                                .elementAt(index)
                                                .id!,
                                            index);
                                      }
                                    },
                                    scrollDirection: Axis.horizontal,
                                  )),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: ScreenUtil().setHeight(10)),
                                  child: SmoothPageIndicator(
                                    controller:
                                        Provider.of<ChallengeScreenProvider>(
                                                context,
                                                listen: false)
                                            .getUpComingPageController,
                                    count: Provider.of<ChallengeScreenProvider>(
                                            context,
                                            listen: false)
                                        .upcomingChallengesBanner
                                        .length,
                                    axisDirection: Axis.horizontal,
                                    effect: SlideEffect(
                                        spacing: 10.0,
                                        radius: 3.0,
                                        dotWidth: 6.0,
                                        dotHeight: 6.0,
                                        paintStyle: PaintingStyle.stroke,
                                        strokeWidth: 1.5,
                                        dotColor: Colors.white,
                                        activeDotColor: lightRed),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///open contest data
                        Container(
                          child: Provider.of<ChallengeScreenProvider>(context,
                                      listen: false)
                                  .getUpcomingChallengesResult
                                  .isEmpty
                              ? Center(
                                  child: Text("No Data!",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                )
                              : GridView.count(
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  childAspectRatio: (itemWidth / itemHeight),
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setSp(5),
                                      left: ScreenUtil().setSp(8),
                                      right: ScreenUtil().setSp(8)),
                                  children: List.generate(
                                      Provider.of<ChallengeScreenProvider>(
                                              context,
                                              listen: false)
                                          .getUpcomingChallengesResult
                                          .length, (index) {
                                    // if(myFameResult[index].images[0].type == "video"){
                                    //   print("VIDEO:::${myFameResult[index].images[0].type}");
                                    //   downloadFile(myFameResult[index].images[0].path);
                                    // }
                                    int endTime = DateTime.parse(Provider.of<
                                                    ChallengeScreenProvider>(
                                                context,
                                                listen: false)
                                            .getUpcomingChallengesResult[index]
                                            .startDate!)
                                        .millisecondsSinceEpoch;
                                    return InkWell(
                                      onTap: () async {
                                        Constants.profileUserId =
                                            challengeScreen
                                                .openChallengesResult[0].sId;

                                        var result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChallengeDetailsScreen(
                                                        Provider.of<ChallengeScreenProvider>(
                                                                    context,
                                                                    listen: false)
                                                                .getUpcomingChallengesResult[
                                                            index],
                                                        null,
                                                        index)));
                                        if (result != null) {
                                          Navigator.pop(context, result);
                                        }
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      ScreenUtil().radius(14)),
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            ScreenUtil()
                                                                .radius(14)),
                                                    child: Image.network(
                                                      "${ApiProvider.s3UrlPath}/${ApiProvider.challenges}/${Provider.of<ChallengeScreenProvider>(context, listen: false).getUpcomingChallengesResult[index].images!.length > 0 ? Provider.of<ChallengeScreenProvider>(context, listen: false).getUpcomingChallengesResult[index].images!.elementAt(0) : ""}",
                                                      width: itemWidth,
                                                      height: itemHeight - 33,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: ScreenUtil()
                                                            .setHeight(38)),
                                                    child: Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Container(
                                                        width: itemWidth,
                                                        height: ScreenUtil()
                                                            .setHeight(30),
                                                        color: lightRed
                                                            .withOpacity(0.75),
                                                        child: Center(
                                                          child: Text(
                                                              Provider.of<ChallengeScreenProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .getUpcomingChallengesResult[
                                                                      index]
                                                                  .hashTag!,
                                                              style: GoogleFonts.nunitoSans(
                                                                  color: white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              18))),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: ScreenUtil().setWidth(5)),
                                            child: CountdownTimer(
                                              endTime: endTime,
                                              widgetBuilder: (_,
                                                  CurrentRemainingTime? time) {
                                                if (time == null) {
                                                  return Text('Start');
                                                }
                                                return Text(
                                                    'Starts in ${time.days != null ? time.days : 0}d:${time.hours}:${time.min}:${time.sec}',
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                            color: lightGray,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(
                                                                        12)));
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setSp(16)),
                    child: Provider.of<ChallengeScreenProvider>(context,
                                listen: false)
                            .getWinnersResult
                            .isEmpty
                        ? Center(
                            child: Text("No Data!",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                          )
                        : ListView.builder(
                            padding:
                                EdgeInsets.only(bottom: ScreenUtil().setSp(80)),
                            itemBuilder: (openContext, index) {
                              WinnersResult winnersChallenges =
                                  Provider.of<ChallengeScreenProvider>(context,
                                          listen: false)
                                      .getWinnersResult[index];
                              String name = "";
                              String photos = "";
                              if (winnersChallenges.forGender!.length > 0) {
                                if (winnersChallenges.forGender!.length > 1) {
                                  name = "Male/Female";
                                } else if (winnersChallenges.forGender![0] ==
                                    "male") {
                                  name = "Boys";
                                } else if (winnersChallenges.forGender![0] ==
                                    "female") {
                                  name = "Girls";
                                }
                              }
                              var size = (ScreenUtil().screenWidth -
                                      ScreenUtil().setSp(140)) -
                                  ScreenUtil().setSp(52);
                              final double itemWidth = size / 2;
                              final double itemHeight = itemWidth + 30;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    child: Padding(
                                      child: Text(
                                        '${name} - ${winnersChallenges.name}',
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w600,
                                            fontSize: ScreenUtil().setSp(18),
                                            color: black),
                                      ),
                                      padding: EdgeInsets.only(
                                          top: ScreenUtil().setSp(11),
                                          bottom: ScreenUtil().setSp(5)),
                                    ),
                                    onTap: () async {
                                      var result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WinnerChallengeDetailsScreen(
                                                      winnersChallenges)));
                                      if (result != null) {
                                        Navigator.pop(context, result);
                                      }
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Joined by ${NumberFormat.compactCurrency(
                                          decimalDigits: 0,
                                          symbol:
                                              '', // if you want to add currency symbol then pass that in this else leave it empty.
                                        ).format(winnersChallenges.participantsCount)}",
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(10),
                                            color: black),
                                      ),
                                      Text(
                                        'Ended ${winnersChallenges.endDate != null ? convertToAgo(DateTime.parse(winnersChallenges.endDate!)) : ""}',
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(10),
                                            color: black),
                                      ),
                                      Text(
                                        'See Prev Session ->',
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(10),
                                            color: black),
                                      ),
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setSp(10),
                                  ),
                                  winnersChallenges.winner!.length > 0
                                      ? Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Constants.profileUserId =
                                                    winnersChallenges.winner!
                                                        .elementAt(0)
                                                        .sId;
                                                if (Constants.userId ==
                                                    Constants.profileUserId) {
                                                  if (winnersChallenges.winner!
                                                          .elementAt(0)
                                                          .type ==
                                                      "individual") {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProfileScreen()));
                                                  } else if (winnersChallenges
                                                          .winner!
                                                          .elementAt(0)
                                                          .type ==
                                                      "agency") {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AgencyProfileScreen()));
                                                  } else if (winnersChallenges
                                                          .winner!
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
                                                  if (winnersChallenges.winner!
                                                          .elementAt(0)
                                                          .type ==
                                                      "individual") {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                OtherProfileScreen()));
                                                  } else if (winnersChallenges
                                                          .winner!
                                                          .elementAt(0)
                                                          .type ==
                                                      "agency") {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AgencyOtherProfileScreen()));
                                                  } else if (winnersChallenges
                                                          .winner!
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
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: ScreenUtil()
                                                          .setSp(140),
                                                      height: ScreenUtil()
                                                          .setSp(140),
                                                      decoration: new BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image: new DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${winnersChallenges.winner!.elementAt(0).profileImage}')))),
                                                  Text(
                                                    winnersChallenges.winner!
                                                        .elementAt(0)
                                                        .name!,
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(12),
                                                            color: black),
                                                  ),
                                                  Text.rich(TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text:
                                                                winnersChallenges
                                                                    .winner!
                                                                    .elementAt(
                                                                        0)
                                                                    .country,
                                                            style: GoogleFonts.nunitoSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: black,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            10))),
                                                        TextSpan(
                                                            text:
                                                                " ${NumberFormat.compactCurrency(
                                                              decimalDigits: 0,
                                                              symbol:
                                                                  '', // if you want to add currency symbol then pass that in this else leave it empty.
                                                            ).format(winnersChallenges.winner!.elementAt(0).likesCount)} Hearts",
                                                            style: GoogleFonts.nunitoSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            10),
                                                                color:
                                                                    lightGray)),
                                                      ])),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                                child: winnersChallenges
                                                            .winner!.length >
                                                        1
                                                    ? GridView.count(
                                                        crossAxisCount: 2,
                                                        shrinkWrap: true,
                                                        childAspectRatio:
                                                            (itemWidth /
                                                                itemHeight),
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        padding:
                                                            EdgeInsets.only(
                                                                top:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            5),
                                                                left:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            8),
                                                                right:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            8)),
                                                        children: List.generate(
                                                            winnersChallenges
                                                                    .winner!
                                                                    .length -
                                                                1, (index) {
                                                          return Container();
                                                          // if(myFameResult[index].images[0].type == "video"){
                                                          //   print("VIDEO:::${myFameResult[index].images[0].type}");
                                                          //   downloadFile(myFameResult[index].images[0].path);
                                                          // }
                                                          // Winner winner = winnersChallenges.winner.elementAt(index+1);
                                                          // return InkWell(
                                                          //   onTap:(){
                                                          //     Constants.profileUserId =
                                                          //         winner.sId;
                                                          //     if (Constants.userId == Constants.profileUserId) {
                                                          //       if(winner.type == "individual") {
                                                          //         Navigator.push(
                                                          //             context,
                                                          //             MaterialPageRoute(
                                                          //                 builder: (context) => ProfileScreen()));
                                                          //       }else if(winner.type == "agency") {
                                                          //         Navigator.push(
                                                          //             context,
                                                          //             MaterialPageRoute(
                                                          //                 builder: (context) => AgencyProfileScreen()));
                                                          //       }else if(winner.type == "brand") {
                                                          //         Navigator.push(
                                                          //             context,
                                                          //             MaterialPageRoute(
                                                          //                 builder: (context) => BrandProfileScreen()));
                                                          //       }
                                                          //     } else {
                                                          //       if(winner.type == "individual") {
                                                          //         Navigator.push(
                                                          //             context,
                                                          //             MaterialPageRoute(
                                                          //                 builder: (context) => OtherProfileScreen()));
                                                          //       }else if(winner.type == "agency") {
                                                          //         Navigator.push(
                                                          //             context,
                                                          //             MaterialPageRoute(
                                                          //                 builder: (context) => AgencyOtherProfileScreen()));
                                                          //       }else if(winner.type == "brand") {
                                                          //         Navigator.push(
                                                          //             context,
                                                          //             MaterialPageRoute(
                                                          //                 builder: (context) => BrandOtherProfileScreen()));
                                                          //       }
                                                          //     }
                                                          //   },
                                                          //   child: Column(
                                                          //     children: [
                                                          //       Container(
                                                          //           alignment:
                                                          //           Alignment.center,
                                                          //           width: itemWidth,
                                                          //           height: ScreenUtil().setSp(80),
                                                          //           decoration: new BoxDecoration(shape: BoxShape.circle, image: new DecorationImage(fit: BoxFit.cover, image: NetworkImage('${ApiProvider.imageBaseUrl}/${winner.profileImage}')))),
                                                          //
                                                          //       Text(
                                                          //         winner.name,
                                                          //         style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w400,fontSize: ScreenUtil().setSp(10),color: black),
                                                          //       ),
                                                          //       Text.rich(TextSpan(children: <TextSpan>[
                                                          //         TextSpan(
                                                          //             text: " ${NumberFormat
                                                          //                 .compactCurrency(
                                                          //               decimalDigits: 0,
                                                          //               symbol:
                                                          //               '', // if you want to add currency symbol then pass that in this else leave it empty.
                                                          //             ).format(winner.likesCount)} Hearts",
                                                          //             style: GoogleFonts.nunitoSans(
                                                          //                 fontWeight: FontWeight.w400,
                                                          //                 fontSize: ScreenUtil().setSp(8),
                                                          //                 color: lightGray)),
                                                          //       ])),
                                                          //     ],
                                                          //   ),
                                                          // );
                                                        }),
                                                      )
                                                    : Container())
                                          ],
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: ScreenUtil().setSp(10),
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: lightGray,
                                  )
                                ],
                              );
                            },
                            itemCount: Provider.of<ChallengeScreenProvider>(
                                    context,
                                    listen: false)
                                .getWinnersResult
                                .length,
                          ),
                  ),
                ], controller: tabController),
              ),
            )
          ],
        ),
      );
    });
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

  void _openChallenges() async {
    Api.get.call(context, method: "challenges/dashboard/open", param: {},
        onResponseSuccess: (Map<dynamic, dynamic> object) {
      var result = OpenChallengesResponse.fromJson(object);
      Provider.of<ChallengeScreenProvider>(context, listen: false)
          .changePostsOfChallenge(result.result!);
    });
  }

  void _openChallengesSlider() async {
    Api.get.call(context, method: "challenges/open/slider", param: {},
        onResponseSuccess: (Map<dynamic, dynamic> object) {
      var result = ChallengeSlider.fromJson(object);
      Provider.of<ChallengeScreenProvider>(context, listen: false)
          .changeChallengeSlider(result.result!);
      if (Provider.of<ChallengeScreenProvider>(context, listen: false)
              .getChallengeSlider
              .length >
          0) {
        _addChallengeImpression(
            Provider.of<ChallengeScreenProvider>(context, listen: false)
                .getChallengeSlider
                .elementAt(0)
                .id!,
            0);
      }
    });
  }

  void _addChallengeImpression(String id, int index) async {
    Api.put.call(context,
        method: "challenges/${id}/impressions",
        param: {"impressions": "1"},
        isLoading: false, onResponseSuccess: (Map object) {
      Provider.of<ChallengeScreenProvider>(context, listen: false)
          .getChallengeSlider
          .elementAt(index)
          .isImpression = true;
    });
  }

  void _addUpcomingChallengeImpression(String id, int index) async {
    Api.put.call(context,
        method: "challenges/${id}/impressions",
        param: {"impressions": "1"},
        isLoading: false, onResponseSuccess: (Map object) {
      Provider.of<ChallengeScreenProvider>(context, listen: false)
          .upcomingChallengesBanner
          .elementAt(index)
          .isImpression = true;
    });
  }

  void _upcomingChallengesSlider() async {
    Api.get.call(context,
        method: "challenges/upcoming/slider",
        param: {},
        isLoading: false, onResponseSuccess: (Map object) {
      var result = ChallengeSlider.fromJson(object);
      Provider.of<ChallengeScreenProvider>(context, listen: false)
          .changeUpcomingChallengesBanner(result.result!);
    });
  }

  void _upComingChallenges() async {
    Map<String, dynamic> param = {"page": upcomingPage.toString()};
    Api.get.call(context,
        method: "challenges/upcoming/famelinks",
        param: param,
        isLoading: false, onResponseSuccess: (Map object) {
      var result = UpcomingChallengesResponse.fromJson(object);
      if (result.result!.length > 0) {
        Provider.of<ChallengeScreenProvider>(context, listen: false)
            .changeUpcomingChallengesResult(result.result!);
      } else {
        upcomingPage--;
      }
    });
  }

  void _winnersChallenges() async {
    Map<String, dynamic> param = {"page": winnersPage.toString()};
    Api.get.call(context,
        method: "challenges/winners",
        param: param,
        isLoading: false, onResponseSuccess: (Map object) {
      var result = WinnersModel.fromJson(object);
      if (result.result!.length > 0) {
        Provider.of<ChallengeScreenProvider>(context, listen: false)
            .changeWinnersResult(result.result!);
      } else {
        winnersPage = winnersPage == 1 ? winnersPage : winnersPage--;
      }
    });
  }

// _challenges() async {
//   bool internet = await Constants.isInternetAvailable();
//   if (internet) {
//     var result = await _api.challengesService();
//     if (result != null) {
//       Constants.progressDialog(false, context);
//       if (result.success.toString() == "true") {
//         print('RESPONSE ${result.result}');
//         setState(() {
//           _challengesList = result.result;
//         });
//         // Navigator.push(context, MaterialPageRoute(builder: (c) =>
//         //     EditAddChildScreen()));
//       } else
//         Constants.toastMessage(msg: result.message);
//     }
//   } else
//     Constants.toastMessage(msg: strInternet);
//   setState(() {});
// }
}
