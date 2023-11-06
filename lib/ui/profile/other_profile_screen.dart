import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/MyFunLinksResponse.dart';
import 'package:famelink/models/Profile_Model.dart';
import 'package:famelink/models/famelinks_model.dart';
import 'package:famelink/models/follow_response.dart';
import 'package:famelink/models/my_challenges_response.dart';
import 'package:famelink/models/userUpdateResponse.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/followers/follower_info_screen.dart';
import 'package:famelink/ui/profile/FullFunLinksPostScreen.dart';
import 'package:famelink/ui/profile/FullPostScreen.dart';
import 'package:famelink/util/ReadMoreText.dart';
import 'package:famelink/util/UnicornOutlineButton.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/config/image.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:video_trimmer/video_trimmer.dart';

import '../ChattingScreen.dart';

class OtherProfileScreen extends StatefulWidget {
  @override
  _OtherProfileScreenState createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen>
    with SingleTickerProviderStateMixin {
  bool showPassword = true;
  bool isOTPLogin = false;
  bool isOTPEmailLogin = false;
  Timer? _timer;
  int _start = 30;

  String otpHash = "";
  String name = 'Hello, User';

  // int followers = 0;
  // int following = 0;
  // int likes = 0;

  // String bio = '';

  MyProfileResult? upperProfileData;
  final dateFormat = DateFormat("yyyy");
  List<RunnerUp> winnerList = [];
  List<Result> myFameResult = [];
  List<Result> myFollowResult = [];

  List<MyFunLinksResult> myFunlinksResult = [];

  List<MyChallengesResult> myChallengesResult = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _referralKey = GlobalKey<FormState>();

  TextEditingController phoneNumber = TextEditingController();
  TextEditingController phoneCodeNumber = TextEditingController();
  TextEditingController plusCodeNumber = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpNumber = TextEditingController();
  VideoPlayerController? _controller;
  Trimmer? _trimmer;

  String? videoThumb;

  int page = 1;
  int funLinksPage = 1;
  int followLinksPage = 1;
  TabController? _tabController;
  ScrollController fameLinksScrollController = ScrollController();
  // ScrollController funLinksScrollController = ScrollController();
  // ScrollController followScrollController = ScrollController();
  final GlobalKey _childKey = GlobalKey();
  bool isHeightCalculated = false;
  double height = 454;
  bool silverCollapsed = false;
  var userId;

  TextEditingController fameCoinController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    _tabController?.addListener(() {
      setState(() {});
    });
    fameLinksScrollController.addListener(() {
      if (fameLinksScrollController.offset > height-100 && !fameLinksScrollController.position.outOfRange) {
        if(!silverCollapsed){

          // do what ever you want when silver is collapsing !

          silverCollapsed = true;
          setState(() {});
        }
      }
      if (fameLinksScrollController.offset <= height-100 && !fameLinksScrollController.position.outOfRange) {
        if(silverCollapsed){

          // do what ever you want when silver is expanding !

          silverCollapsed = false;
          setState(() {});
        }
      }
      if (fameLinksScrollController.position.maxScrollExtent ==
          fameLinksScrollController.position.pixels) {
        if (_tabController?.index == 0) {
          page++;
          _myFamelinks();
        } else if (_tabController?.index == 1) {
          funLinksPage++;
          _myFunlinks();
        } else if (_tabController?.index == 2) {
          followLinksPage++;
          _myFollowLinks();
        }
      }
    });
    userId = Constants.profileUserId;
    _profile();
    _myFamelinks();
    _myFunlinks();
    _myFollowLinks();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: black,
                    )),
                actions: [
                  IconButton(
                      onPressed: () {
                        Share.share(
                          '${ApiProvider.shareUrl}profile/individual/$userId',
                        );
                      },
                      icon: Icon(
                        Icons.share_outlined,
                        color: black,
                      ))
                ],
                title: Text(silverCollapsed ? "${upperProfileData != null ? upperProfileData?.name : ""}":"",
                    style: GoogleFonts
                        .nunitoSans(
                        fontSize:
                        ScreenUtil()
                            .setSp(
                            16),
                        fontWeight:
                        FontWeight
                            .w700,
                        color: black)),
                backgroundColor: appBackgroundColor,
                expandedHeight: isHeightCalculated
                    ? (height-24)
                    : ScreenUtil().setSp(454),
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    background: RefreshIndicator(
                      onRefresh: (){
                        myFameResult.clear();
                        myFunlinksResult.clear();
                        myFollowResult.clear();
                        page = 1;
                        funLinksPage = 1;
                        followLinksPage = 1;
                        return refresh();
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          key: _childKey,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: ScreenUtil().setHeight(292),
                                      color: Colors.transparent,
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: white,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(
                                                        ScreenUtil().radius(60)),
                                                    bottomRight: Radius.circular(
                                                        ScreenUtil().radius(60)))),
                                            width: ScreenUtil().setWidth(116),
                                            height: ScreenUtil().setHeight(260),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        top: ScreenUtil()
                                                            .setHeight(60))),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: ScreenUtil()
                                                              .setHeight(36)),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            '${upperProfileData != null && upperProfileData!.likesCount != null ? upperProfileData!.likesCount : "0"}',
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                                fontSize:
                                                                ScreenUtil()
                                                                    .setSp(
                                                                    14),
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700,
                                                                color: black),
                                                          ),
                                                          Text(
                                                            'Hearts',
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                                fontSize:
                                                                ScreenUtil()
                                                                    .setSp(
                                                                    12),
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700,
                                                                color: black),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: ScreenUtil()
                                                              .setWidth(31),
                                                          right: ScreenUtil()
                                                              .setWidth(31)),
                                                      child: Divider(
                                                        thickness: 1,
                                                        color: lightGray,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        Constants.profileUserId = upperProfileData!.id;
                                                        await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (ontext) =>
                                                                  FollowerInfoScreen(isFollowing: true, id: upperProfileData?.id)),
                                                        );
                                                      },
                                                      child: Container(
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              '${upperProfileData != null && upperProfileData!.followingCount != null ? upperProfileData!.followingCount : "0"}',
                                                              style: GoogleFonts
                                                                  .nunitoSans(
                                                                  fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                      14),
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                                  color: black),
                                                            ),
                                                            Text(
                                                              'Following',
                                                              style: GoogleFonts
                                                                  .nunitoSans(
                                                                  fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                      12),
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                                  color: black),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: ScreenUtil()
                                                              .setWidth(31),
                                                          right: ScreenUtil()
                                                              .setWidth(31)),
                                                      child: Divider(
                                                        thickness: 1,
                                                        color: lightGray,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        Constants.profileUserId = upperProfileData!.id;
                                                        await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (ontext) =>
                                                                  FollowerInfoScreen(isFollowing: false, id: upperProfileData!.id)),
                                                        );
                                                      },
                                                      child: Container(
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              '${upperProfileData != null && upperProfileData!.followersCount != null ? upperProfileData!.followersCount : "0"}',
                                                              style: GoogleFonts
                                                                  .nunitoSans(
                                                                  fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                      14),
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                                  color: black),
                                                            ),
                                                            Text('Followers',
                                                                style: GoogleFonts.nunitoSans(
                                                                    fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                        12),
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                    color: black)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //info section
                                  Container(
                                    width: ScreenUtil().setWidth(115),
                                    color: Colors.transparent,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        UnicornOutlineButton(
                                          strokeWidth: ScreenUtil().setSp(1),
                                          topLeftRadius: ScreenUtil().radius(0),
                                          topRightRadius: ScreenUtil().radius(0),
                                          bottomLeftRadius:
                                          ScreenUtil().setSp(57.5),
                                          bottomRightRadius:
                                          ScreenUtil().setSp(57.5),
                                          gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                profileBorder1,
                                                profileBorder2,
                                                profileBorder3,
                                                profileBorder4
                                              ]),
                                          onPressed: () {},
                                          child: Container(
                                            width: ScreenUtil().setSp(115),
                                            height: ScreenUtil().setSp(260),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                      ScreenUtil().setWidth(5),
                                                      right:
                                                      ScreenUtil().setWidth(5)),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "${upperProfileData != null && upperProfileData!.username != null ? upperProfileData!.username : ""}",
                                                        textAlign: TextAlign.center,
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style:
                                                        GoogleFonts.nunitoSans(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontSize:
                                                            ScreenUtil()
                                                                .setSp(14),
                                                            fontWeight:
                                                            FontWeight.w400,
                                                            color: buttonBlue),
                                                      ),
                                                      Text(
                                                        "${upperProfileData != null ? upperProfileData!.name : ""}",
                                                        textAlign: TextAlign.center,
                                                        style:
                                                        GoogleFonts.nunitoSans(
                                                            fontSize:
                                                            ScreenUtil()
                                                                .setSp(16),
                                                            fontWeight:
                                                            FontWeight.w700,
                                                            color: black),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            upperProfileData != null
                                                                ? '${upperProfileData!.district}, ${upperProfileData!.state}, ${upperProfileData!.country}'
                                                                : "",
                                                            textAlign:
                                                            TextAlign.center,
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                                fontSize:
                                                                ScreenUtil()
                                                                    .setSp(
                                                                    10),
                                                                fontWeight:
                                                                FontWeight
                                                                    .w400,
                                                                color: black),
                                                          ),
                                                          /*Text(
                                                          '${upperProfileData != null ? upperProfileData.country : ""}',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: ScreenUtil()
                                                                  .setSp(14),
                                                              fontWeight:
                                                                  FontWeight.w300,
                                                              color: darkGray),
                                                        )*/
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top:
                                                      ScreenUtil().setHeight(8),
                                                      bottom:
                                                      ScreenUtil().setHeight(3),
                                                      left:
                                                      ScreenUtil().setHeight(3),
                                                      right: ScreenUtil()
                                                          .setHeight(3)),
                                                  child: InkWell(
                                                    onTap: () {
                                                      if(upperProfileData != null &&
                                                          upperProfileData!.profileImage !=
                                                              null)
                                                        showFullProfileDialog(
                                                            context);
                                                    },
                                                    child: Container(
                                                      width: ScreenUtil().setSp(109),
                                                      height: ScreenUtil().setSp(109),
                                                      child: Stack(
                                                        children: [
                                                          UnicornOutlineButton(
                                                            strokeWidth: ScreenUtil().setSp(1),
                                                            bottomLeftRadius:
                                                            ScreenUtil().setSp(57.5),
                                                            bottomRightRadius:
                                                            ScreenUtil().setSp(57.5),topLeftRadius:
                                                          ScreenUtil().setSp(57.5),topRightRadius:
                                                          ScreenUtil().setSp(57.5),
                                                            gradient: LinearGradient(
                                                                begin: Alignment.centerLeft,
                                                                end: Alignment.centerRight,
                                                                colors: [
                                                                  profileBorder1,
                                                                  profileBorder2,
                                                                  profileBorder3,
                                                                  profileBorder4
                                                                ]),
                                                            onPressed: () {},
                                                            child: Container(
                                                              width: ScreenUtil()
                                                                  .setSp(110),
                                                              height: ScreenUtil()
                                                                  .setSp(110),
                                                            ),
                                                          ),
                                                          Center(
                                                            child: Container(
                                                              margin: EdgeInsets.all(ScreenUtil().setSp(1)),
                                                              alignment: Alignment.center,
                                                              child: upperProfileData != null &&
                                                                  upperProfileData!.profileImage !=
                                                                      null
                                                                  ? Container(
                                                                  alignment: Alignment.center,
                                                                  width: ScreenUtil()
                                                                      .setSp(109),
                                                                  height: ScreenUtil()
                                                                      .setSp(109),
                                                                  decoration: new BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      image: new DecorationImage(fit: BoxFit.cover, image: NetworkImage('${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${upperProfileData!.profileImage}'))))
                                                                  : Container(width: ScreenUtil().setSp(109), height: ScreenUtil().setSp(109), decoration: new BoxDecoration(color: white, shape: BoxShape.circle, image: new DecorationImage(fit: BoxFit.scaleDown, image: AssetImage("assets/icons/male.png")))),
                                                            ),
                                                          ),
                                                          Align(
                                                            child: Visibility(child: Padding(padding:EdgeInsets.only(right: ScreenUtil().setSp(10.5),bottom: ScreenUtil().setSp(18.5)),child: SvgPicture.asset("assets/icons/svg/profile_verified.svg")),visible: upperProfileData!.isVerified!,),
                                                            alignment: Alignment.bottomRight,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(16)),
                                            child: SizedBox(
                                              height: ScreenUtil().setHeight(24),
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                    MaterialStateProperty.all<Color>(
                                                        appBackgroundColor),
                                                    shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                            side: BorderSide(
                                                                color: darkGray)))),
                                                child: Text(
                                                  upperProfileData != null
                                                      ? "${upperProfileData!.followStatus == false ? 'Follow' : 'Unfollow'}"
                                                      : "",
                                                  style: GoogleFonts.nunitoSans(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize:
                                                      ScreenUtil().setSp(14),
                                                      color: lightRed),
                                                ),
                                                onPressed: () async {
                                                  print('ppppp');
                                                  upperProfileData!.followStatus ==
                                                      false
                                                      ? follow(upperProfileData!.id!)
                                                      : unfollow(
                                                      upperProfileData!.id!);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(color: white),
                                            width: ScreenUtil().setSp(116),
                                            height: ScreenUtil().setSp(260),
                                            child: Column(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        top: ScreenUtil()
                                                            .setHeight(70))),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: [
                                                      Expanded(
                                                          child: ListView.builder(
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                            Axis.vertical,
                                                            itemCount:
                                                            winnerList.length,
                                                            padding: EdgeInsets.zero,
                                                            itemBuilder:
                                                                (BuildContext context,
                                                                int index) {
                                                              RunnerUp runnerUp =
                                                              winnerList[index];
                                                              if (runnerUp.date !=
                                                                  null) {
                                                                return Column(
                                                                  mainAxisSize:
                                                                  MainAxisSize.min,
                                                                  children: [
                                                                    Text(
                                                                        '${runnerUp.title != null ? runnerUp.title : ""}',
                                                                        textAlign: TextAlign.center,
                                                                        style: GoogleFonts.nunitoSans(
                                                                            fontSize: ScreenUtil()
                                                                                .setSp(
                                                                                12),
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                            color:
                                                                            black)),
                                                                    Text(
                                                                      runnerUp.type !=
                                                                          null
                                                                          ? "${runnerUp.type}-${dateFormat.format(DateTime.parse(runnerUp.date!))}"
                                                                          : "${dateFormat.format(DateTime.parse(runnerUp.date!))}",
                                                                      textAlign: TextAlign.center,
                                                                      style: GoogleFonts.nunitoSans(
                                                                          fontSize:
                                                                          ScreenUtil()
                                                                              .setSp(
                                                                              10),
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                          color:
                                                                          lightGray),
                                                                    )
                                                                  ],
                                                                );
                                                              } else {
                                                                return Center(
                                                                  child: Text(
                                                                    runnerUp.title.toString(),
                                                                    style: GoogleFonts.nunitoSans(
                                                                        fontSize:
                                                                        ScreenUtil()
                                                                            .setSp(
                                                                            12),
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                        color:
                                                                        lightRed),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                          )),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            left: ScreenUtil()
                                                                .setWidth(31),
                                                            right: ScreenUtil()
                                                                .setWidth(31)),
                                                        child: Divider(
                                                          thickness: 1,
                                                          color: black,
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Column(
                                                          mainAxisSize:
                                                          MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                                upperProfileData !=
                                                                    null &&
                                                                    upperProfileData!
                                                                        .countryLevel !=
                                                                        null
                                                                    ? '@${upperProfileData!.countryLevel}'
                                                                    : "",
                                                                style: GoogleFonts.nunitoSans(
                                                                    fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                        12),
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                    color: black)),
                                                            Visibility(
                                                              child: Text(
                                                                  'Current Score',
                                                                  style: GoogleFonts.nunitoSans(
                                                                      fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                          10),
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                      color:
                                                                      black)),
                                                              visible: upperProfileData !=
                                                                  null &&
                                                                  upperProfileData!
                                                                      .score !=
                                                                      null,
                                                            ),
                                                            Text(
                                                                '${upperProfileData != null && upperProfileData!.score != null ? upperProfileData!.score : ""}',
                                                                style: GoogleFonts.nunitoSans(
                                                                    fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                        10),
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                    color: black)),
                                                            SizedBox(
                                                              height: ScreenUtil()
                                                                  .setHeight(22),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                    padding: EdgeInsets.only(top: ScreenUtil().setSp(12)),
                                                    icon: SvgPicture.asset(gift),
                                                    onPressed: () {
                                                      showReferralCodeDialog();
                                                    }),
                                                IconButton(
                                                    padding: EdgeInsets.only(top: ScreenUtil().setSp(12)),
                                                    icon: SvgPicture.asset(message),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ChattingScreen(
                                                                    upperProfileData!.name.toString(),
                                                                    upperProfileData!
                                                                        .profileImage!,
                                                                    upperProfileData!.id!,
                                                                    "individual",
                                                                    upperProfileData!
                                                                        .chatId!,
                                                                    false)),
                                                      );
                                                    }),
                                              ],
                                            ),
                                          ),
                                          /*Container(
                                                child: IconButton(
                                                    padding: EdgeInsets.only(top: ScreenUtil().setSp(12)),
                                                    icon: SvgPicture.asset(message),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ChattingScreen(
                                                                    upperProfileData.name,
                                                                    upperProfileData
                                                                        .profileImage,
                                                                    upperProfileData.id,
                                                                    "individual",
                                                                    upperProfileData
                                                                        .chatId,
                                                                    false)),
                                                      );
                                                    }),
                                              ),*/
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(16),
                                  right: ScreenUtil().setWidth(11),
                                  top: ScreenUtil().setHeight(14)),
                              alignment: Alignment.topLeft,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // showAlertDialog(context,
                                      //     '${upperProfileData != null ? upperProfileData.bio : ""}');
                                    },
                                    child: Container(
                                      child:
                                      Text.rich(TextSpan(children: <TextSpan>[
                                        TextSpan(
                                            text: "It\'s me: ",
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: ScreenUtil().setSp(16),
                                                fontWeight: FontWeight.w700,
                                                color: black)),
                                        upperProfileData != null &&
                                            upperProfileData!.profession != null
                                            ? TextSpan(
                                            text:
                                            "(${upperProfileData!.profession})",
                                            style: GoogleFonts.nunitoSans(
                                                fontSize:
                                                ScreenUtil().setSp(16),
                                                fontWeight: FontWeight.w400,
                                                color: black))
                                            : TextSpan(
                                            text: "",
                                            style: GoogleFonts.nunitoSans(
                                                fontSize:
                                                ScreenUtil().setSp(16),
                                                fontWeight: FontWeight.w400,
                                                color: black)),
                                      ])),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // showAlertDialog(context,
                                      //     '${upperProfileData != null ? upperProfileData.bio : ""}');
                                    },
                                    child: Container(
                                      child: ReadMoreText(
                                        upperProfileData!.bio.toString(),
                                        trimLines: 3,
                                        trimMode: TrimMode.Line,
                                        style: GoogleFonts.nunitoSans(
                                            fontSize: ScreenUtil().setSp(14),
                                            fontWeight: FontWeight.w400,
                                            color: black),
                                      ),
                                    ),
                                  ),
                                  /*Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Text(
                                  'Thanks: ',
                                  style: TextStyle(
                                      color: darkGray,
                                      fontSize: ScreenUtil().setSp(14),
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'Gifted 0 Points',
                                  style: TextStyle(
                                      color: black, fontSize: ScreenUtil().setSp(14)),
                                )
                              ],
                            ),
                        ),*/
                                  Visibility(
                                    visible: upperProfileData!=null && upperProfileData!.challengesWon != null,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: ScreenUtil().setHeight(10)),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Trendz Set: ',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: ScreenUtil().setSp(14),
                                                fontWeight: FontWeight.w700,
                                                color: black),
                                          ),
                                          Expanded(
                                            child: Text(
                                              upperProfileData!=null && upperProfileData!.challengesWon != null?upperProfileData!.challengesWon!:"",
                                              style: GoogleFonts.nunitoSans(
                                                  fontSize: ScreenUtil().setSp(12),
                                                  fontWeight: FontWeight.w400,
                                                  color: black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(21),
                              width: ScreenUtil().setWidth(62),
                              child: Divider(
                                height: 1,
                                thickness: 1,
                                color: lightGray,
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setSp(45),
                            ),
                          ],
                        ),
                        physics: AlwaysScrollableScrollPhysics(),
                      ),
                    )),
                bottom: PreferredSize(
                  child: Container(
                    color: white,
                    child: TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(
                          icon: SvgPicture.asset(
                              "assets/icons/svg/tab_famelinks.svg",
                              color: _tabController!.index == 0
                                  ? darkGray
                                  : lightGray),
                        ),
                        Tab(
                            icon: SvgPicture.asset(
                                "assets/icons/svg/tab_funlinks.svg",
                                color: _tabController!.index == 1
                                    ? darkGray
                                    : lightGray)),

                        Tab(
                            icon: SvgPicture.asset(
                                "assets/icons/svg/tab_followlinks.svg",
                                color: _tabController!.index == 2
                                    ? darkGray
                                    : lightGray)),
                        // Tab(text: "Challenges"),
                      ],
                      labelColor: darkGray,
                      unselectedLabelColor: lightGray,
                      indicatorColor: darkGray,
                      unselectedLabelStyle: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(14)),
                      labelStyle: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtil().setSp(14)),
                    ),
                  ),
                  preferredSize: Size.fromHeight(ScreenUtil().setSp(45)),
                ),
              ),
            ];
          },
          controller: fameLinksScrollController,
          body: _tabSection(context),
        ),
      ),
    );
  }

  Widget _tabSection(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 3;
    final double itemHeight = itemWidth + 30;
    return TabBarView(
      controller: _tabController,
      children: [
        myFameResult.isNotEmpty
            ? GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          childAspectRatio: (itemWidth / itemHeight),
          padding: EdgeInsets.only(
              top: ScreenUtil().setSp(5),
              left: ScreenUtil().setSp(2.5),
              right: ScreenUtil().setSp(2.5)),
          children: List.generate(myFameResult.length, (index) {
            // if(myFameResult[index].images[0].type == "video"){
            //   print("VIDEO:::${myFameResult[index].images[0].type}");
            //   downloadFile(myFameResult[index].images[0].path);
            // }
            return InkWell(
              onTap: () {
                Map<String, dynamic> json = {
                  "_id":upperProfileData!.id,
                  "name":upperProfileData!.name,
                };
                var model = FameUser.fromJson(json);
                myFameResult[index].user = model;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FullPostScreen(myFameResult, index, page,"${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}",true)),
                );
              },
              child: Container(
                margin: EdgeInsets.only(
                    bottom: ScreenUtil().setSp(5),
                    left: ScreenUtil().setSp(2.5),
                    right: ScreenUtil().setSp(2.5)),
                child: Stack(
                  children: [
                    SizedBox(
                      child: myFameResult[index].images!.length > 0
                          ? myFameResult[index].images![0].type == "video"
                          ? Stack(
                        children: [
                          Container(
                              color: lightGray,
                              child:CachedNetworkImage(
                                imageUrl:
                                '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${myFameResult[index].images![0].path}-sm',
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error,color: white),
                                fit: BoxFit.cover,
                                width: itemWidth,
                                height: itemHeight,
                              )
                          ),
                          Center(
                            child: Container(
                              height: ScreenUtil().setHeight(32.94),
                              width: ScreenUtil().setWidth(40),
                              decoration: BoxDecoration(
                                  color:
                                  Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenUtil().radius(5)))),
                              child: Icon(
                                Icons.play_arrow,
                                color: black,
                              ),
                            ),
                          )
                        ],
                      )
                          : Container(
                          color: lightGray,
                          child:CachedNetworkImage(
                            imageUrl:
                            '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${myFameResult[index].images![0].path}-sm',
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error,color: white),
                            fit: BoxFit.cover,
                            width: itemWidth,
                            height: itemHeight,
                          )
                      )
                          : Container(
                        color: lightGray,
                        child: CachedNetworkImage(
                          imageUrl:
                          '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/sm',
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error,color: white),
                          fit: BoxFit.cover,
                          width: itemWidth,
                          height: itemHeight,
                        ),
                      ),
                    ),
                    Padding(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(myFameResult[index].images!.length.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11)),
                            SizedBox(
                              width: 5,
                            ),
                            Image.asset("assets/images/multiple_img.png",
                                color: Colors.white),
                          ],
                        ),
                      ),
                      padding: EdgeInsets.only(right: 7, bottom: 3),
                    )
                  ],
                ),
                color: Colors.blue,
              ),
            );
          }),
        )
            : Center(
          child: Text("No FameLinks Found",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
        ),
        myFunlinksResult.isNotEmpty
            ? GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          childAspectRatio: (itemWidth / itemHeight),
          padding: EdgeInsets.only(
              top: ScreenUtil().setSp(5),
              left: ScreenUtil().setSp(2.5),
              right: ScreenUtil().setSp(2.5)),
          children: List.generate(myFunlinksResult.length, (index) {
            return InkWell(
              onTap: () {
                Map<String, dynamic> json = {
                  "_id":upperProfileData!.id,
                  "name":upperProfileData!.name,
                };
                var model = MyFunLinkUser.fromJson(json);
                myFunlinksResult[index].user = model;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ontext) => FullFunLinksPostScreen(
                          myFunlinksResult, index, funLinksPage)),
                );
              },
              child: Container(
                margin: EdgeInsets.only(
                    bottom: ScreenUtil().setSp(5),
                    left: ScreenUtil().setSp(2.5),
                    right: ScreenUtil().setSp(2.5)),
                child: Stack(
                  children: [
                    SizedBox(
                        child: Stack(
                          children: [
                            Container(
                                color: lightGray,
                                child:CachedNetworkImage(
                                  imageUrl:
                                  '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${myFunlinksResult[index].video}-sm',
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error,color: white),
                                  fit: BoxFit.cover,
                                  width: itemWidth,
                                  height: itemHeight,
                                )
                            ),
                            Center(
                              child: Container(
                                height: ScreenUtil().setHeight(32.94),
                                width: ScreenUtil().setWidth(40),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenUtil().radius(5)))),
                                child: Icon(
                                  Icons.play_arrow,
                                  color: black,
                                ),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
                color: Colors.blue,
              ),
            );
          }),
        )
            : Center(
          child: Text("No FunLinks Found",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
        ),
        myFollowResult.isNotEmpty
            ? GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          childAspectRatio: (itemWidth / itemHeight),
          padding: EdgeInsets.only(
              top: ScreenUtil().setSp(5),
              left: ScreenUtil().setSp(2.5),
              right: ScreenUtil().setSp(2.5)),
          children: List.generate(myFollowResult.length, (index) {
            // if(myFameResult[index].images[0].type == "video"){
            //   print("VIDEO:::${myFameResult[index].images[0].type}");
            //   downloadFile(myFameResult[index].images[0].path);
            // }
            return InkWell(
              onTap: () {
                Map<String, dynamic> json = {
                  "_id":upperProfileData!.id,
                  "name":upperProfileData!.name,
                };
                var model = FameUser.fromJson(json);
                myFollowResult[index].user = model;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ontext) =>
                          FullPostScreen(myFollowResult, index, followLinksPage,"${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}",false)),
                );
              },
              child: Container(
                margin: EdgeInsets.only(
                    bottom: ScreenUtil().setSp(5),
                    left: ScreenUtil().setSp(2.5),
                    right: ScreenUtil().setSp(2.5)),
                child: Stack(
                  children: [
                    SizedBox(
                      child: myFollowResult[index].images!.length > 0
                          ? myFollowResult[index].images![0].type == "video"
                          ? Stack(
                        children: [
                          Container(
                              color: lightGray,
                              child:CachedNetworkImage(
                                imageUrl:
                                '${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${myFollowResult[index].images![0].path}-sm',
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error,color: white),
                                fit: BoxFit.cover,
                                width: itemWidth,
                                height: itemHeight,
                              )
                          ),
                          Center(
                            child: Container(
                              height: ScreenUtil().setHeight(32.94),
                              width: ScreenUtil().setWidth(40),
                              decoration: BoxDecoration(
                                  color:
                                  Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenUtil().radius(5)))),
                              child: Icon(
                                Icons.play_arrow,
                                color: black,
                              ),
                            ),
                          )
                        ],
                      )
                          : Container(
                          color: lightGray,
                          child:CachedNetworkImage(
                            imageUrl:
                            '${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${myFollowResult[index].images![0].path}-sm',
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error,color: white),
                            fit: BoxFit.cover,
                            width: itemWidth,
                            height: itemHeight,
                          )
                      )
                          : SizedBox(),
                    ),
                    Padding(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(myFollowResult[index].images!.length.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11)),
                            SizedBox(
                              width: 5,
                            ),
                            Image.asset("assets/images/multiple_img.png",
                                color: Colors.white),
                          ],
                        ),
                      ),
                      padding: EdgeInsets.only(right: 7, bottom: 3),
                    )
                  ],
                ),
                color: Colors.blue,
              ),
            );
          }),
        )
            : Center(
          child: Text("No FollowLinks Found",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }

  void showReferralCodeDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.only(
                  left: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - ScreenUtil().setSp(315)) / 2),
                  right: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - ScreenUtil().setSp(315)) / 2)),
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setStates) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
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
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [lightRedWhite, lightRed])),
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(21),
                                bottom: ScreenUtil().setHeight(12),
                                left: ScreenUtil().setWidth(5),
                                right: ScreenUtil().setWidth(5)),
                            child: Center(
                              child: Text(
                                'Send Gift type to your beloved person',
                                style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(16),
                                    color: white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Container(
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
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(14),
                                      left: ScreenUtil().setWidth(20),
                                      right: ScreenUtil().setWidth(20)),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Fame Coins: ',
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize: ScreenUtil().setSp(12),
                                                    color: black,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                              Text(
                                                '${Constants.fameCoins} Coins Left',
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize: ScreenUtil().setSp(12),
                                                    color: black,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '(Max 5 Coins per person per day allowed)',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: ScreenUtil().setSp(10),
                                                color: lightGray,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setSp(5),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          textAlign: TextAlign.start,
                                          textAlignVertical: TextAlignVertical
                                              .center,
                                          controller: fameCoinController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.digitsOnly],
                                          textInputAction: TextInputAction.done,
                                          style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(12),
                                              color: darkGray,
                                              fontWeight: FontWeight.w400),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: buttonBlue,
                                                  width: ScreenUtil().radius(1)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      ScreenUtil().radius(2))),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: buttonBlue,
                                                  width: ScreenUtil().radius(1)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      ScreenUtil().radius(2))),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: buttonBlue,
                                                  width: ScreenUtil().radius(1)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      ScreenUtil().radius(2))),
                                            ),
                                            contentPadding: EdgeInsets.only(left:ScreenUtil().setWidth(5),top: 0,bottom: 0),
                                            hintStyle: GoogleFonts.nunitoSans(
                                                fontStyle: FontStyle.italic,
                                                fontSize: ScreenUtil().setSp(12),
                                                color: lightGray,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setSp(32),
                                      bottom: ScreenUtil().setSp(20)),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Center(
                                                child: InkWell(
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                    if (fameCoinController
                                                        .text.isNotEmpty) {
                                                      if (Constants.fameCoins >=
                                                          int.parse(
                                                              fameCoinController
                                                                  .text)) {
                                                        Map<String,
                                                            dynamic> params = {
                                                          "fameCoins": fameCoinController
                                                              .text,
                                                          "toUserId": userId
                                                        };
                                                        Api.post.call(context,
                                                            method: "users/fameCoins",
                                                            param: params,
                                                            isLoading: false,
                                                            onResponseSuccess: (
                                                                Map object) {
                                                              var result = UserUpdatedResponse
                                                                  .fromJson(
                                                                  object as Map<String,dynamic>);
                                                              Constants
                                                                  .toastMessage(
                                                                  msg: result
                                                                      .message!);

                                                              Constants.fameCoins = Constants.fameCoins - int.parse(
                                                                  fameCoinController
                                                                      .text);
                                                              fameCoinController
                                                                  .text =
                                                              "";
                                                            }, onRetry: (String message) {  }, onProgress: (double percentage) {  });
                                                      }else{
                                                        var snackBar = SnackBar(
                                                          content: Text('only for ${Constants.fameCoins} coins left'),
                                                        );
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                            snackBar);
                                                      }
                                                    }
                                                  },
                                                  child: Text("Send",
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                          fontWeight: FontWeight
                                                              .w700,
                                                          fontSize:
                                                          ScreenUtil().setSp(
                                                              14),
                                                          color: black)),
                                                ))),
                                        Expanded(
                                            child: Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Cancel",
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                          fontWeight: FontWeight
                                                              .w400,
                                                          fontSize:
                                                          ScreenUtil().setSp(
                                                              14),
                                                          color: black)),
                                                ))),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }));
        });
  }

  Future<String> refresh() async{
    _profile();
    _myFamelinks();
    _myFunlinks();
    _myFollowLinks();
    return 'success';
  }
  _profile() async {
    Api.get.call(context, method: "users/$userId",
        param: {},
        onResponseSuccess: (Map object)async{
          var result = ProfileResponse.fromJson(object as Map<String,dynamic>);
          upperProfileData = result.result;
          if (upperProfileData!.winnerTitles!.length > 0) {
            RunnerUp runnerUp = new RunnerUp();
            runnerUp.title = "Winner";
            winnerList.add(runnerUp);
            winnerList.addAll(upperProfileData!.winnerTitles!);
          }
          if (upperProfileData!.runnerUp!.length > 0) {
            RunnerUp runnerUp = new RunnerUp();
            runnerUp.title = "Runner up";
            winnerList.add(runnerUp);
            winnerList.addAll(upperProfileData!.runnerUp!);
          }
          print('RESPONSE ${result.result}');
          setState(() {});
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            if (!isHeightCalculated) {
              isHeightCalculated = true;
              setState(() {
                height = (_childKey.currentContext!.findRenderObject() as RenderBox)
                    .size
                    .height;
              });
            }
          });
        }, onProgress: (double percentage) {  }, isLoading: false, contentType: '');
  }

  _myFamelinks() async {
    Map<String, dynamic> map = {
      "page": page.toString()
    };
    Api.get.call(context, method: "media/famelinks/$userId",isLoading: false,
        param: map,
        onResponseSuccess: (Map object)async{
          var result = FamelinksResponse.fromJson(object as Map<String,dynamic>);
          if (result.result!.length > 0) {
            myFameResult.addAll(result.result!);
            setState(() {});
          } else {
            page = page > 1 ? (page - 1) : page;
          }
        }, onProgress: (double percentage) {  }, contentType: '');
  }

  _myFunlinks() async {
    Map<String, dynamic> map = {
      "page": funLinksPage.toString()
    };
    Api.get.call(context, method: "media/funlinks/$userId",isLoading: false,
        param: map,
        onResponseSuccess: (Map object)async{
          var result = MyFunLinksResponse.fromJson(object as Map<String,dynamic>);
          if (result.result!.length > 0) {
            myFunlinksResult.addAll(result.result!);
            setState(() {});
            print('RESPONSE ${result.result.toString()}');
          } else {
            funLinksPage = funLinksPage > 1 ? (funLinksPage - 1) : funLinksPage;
          }
        }, onProgress: (double percentage) {  }, contentType: '');
  }

  _myFollowLinks() async {
    Map<String, dynamic> map = {
      "page": followLinksPage.toString()
    };
    Api.get.call(context, method: "media/followlinks/$userId",isLoading: false,
        param: map,
        onResponseSuccess: (Map object)async{
          var result = FamelinksResponse.fromJson(object as Map<String,dynamic>);
          if (result.result!.length > 0) {
            myFollowResult.addAll(result.result!);
            setState(() {});
            print('RESPONSE ${result.result.toString()}');
          } else {
            followLinksPage = followLinksPage > 1 ? (followLinksPage - 1) : followLinksPage;
          }
        }, onProgress: (double percentage) {  }, contentType: '');
  }

  void showFullProfileDialog(BuildContext buildContext) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.only(
                  top: ScreenUtil().setSp((ScreenUtil().screenHeight / 3) / 2),
                  bottom:
                  ScreenUtil().setSp((ScreenUtil().screenHeight / 3) / 2),
                  left: ScreenUtil().setWidth(26),
                  right: ScreenUtil().setWidth(26)),
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setStates) {
                    return Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setSp(25)),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setSp(16))),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              color: black25,
                              blurRadius: 4.0,
                            ),
                          ],
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${upperProfileData!.profileImage}'))),
                    );
                  }));
        });
  }

  showLogOutAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Yes", style: GoogleFonts.poppins(color: lightRed)),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        Navigator.pop(context, true);
      },
    );

    Widget noButton = TextButton(
      child: Text("No", style: GoogleFonts.poppins(color: lightRed)),
      onPressed: () async {
        Navigator.pop(context, true);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Are you sure you won't to logout this app?"),
      actions: [
        okButton,
        noButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool>? isLogout() {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Are you sure you won't to logout this app?"),
          actions: [
            TextButton(
              child: Text("Yes", style: GoogleFonts.poppins(color: lightRed)),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                return Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: Text("No", style: GoogleFonts.poppins(color: lightRed)),
              onPressed: () async {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );
  }

  void follow(String sId) async {
    Api.post.call(context, method: "users/follow/$sId",
        param: {},
        onResponseSuccess: (Map object)async{
          var result = FollowResponse.fromJson(object as Map<String,dynamic>);
          upperProfileData!.followStatus = !upperProfileData!.followStatus!;
          upperProfileData!.followersCount= upperProfileData!.followersCount!+1;
          print(result.message.toString());
          setState(() {});
        }, onRetry: (String message) {  }, onProgress: (double percentage) {  }, isLoading: false);
  }

  void unfollow(String sId) async {
    Api.delete.call(context, method: "users/unfollow/$sId",
        param: {},
        onResponseSuccess: (Map object)async{
          var result = FollowResponse.fromJson(object as Map<String,dynamic>);
          upperProfileData!.followStatus = !upperProfileData!.followStatus!;
          upperProfileData!.followersCount=upperProfileData!.followersCount!-1;
          print(result.message.toString());
          setState(() {});
        }, onRetry: (String message) {  }, onProgress: (double percentage) {  }, isLoading: false);
  }
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: ScreenUtil().setHeight(5),
      width: ScreenUtil().setHeight(5),
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
