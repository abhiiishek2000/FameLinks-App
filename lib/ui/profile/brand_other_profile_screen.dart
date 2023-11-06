import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/MyFunLinksResponse.dart';
import 'package:famelink/models/Profile_Model.dart';
import 'package:famelink/models/UsernameCheckModel.dart';
import 'package:famelink/models/famelinks_model.dart';
import 'package:famelink/models/follow_response.dart';
import 'package:famelink/models/likes_model.dart';
import 'package:famelink/models/login_model.dart';
import 'package:famelink/models/register_response.dart';
import 'package:famelink/models/store_model.dart';
import 'package:famelink/models/userUpdateResponse.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/ChattingScreen.dart';
import 'package:famelink/ui/challenge/challenge_screen.dart';
import 'package:famelink/ui/followers/follower_info_screen.dart';
import 'package:famelink/ui/notification/notification_screen.dart';
import 'package:famelink/ui/profile/FullFunLinksPostScreen.dart';
import 'package:famelink/ui/profile/FullPostScreen.dart';
import 'package:famelink/ui/profile/brand_details_screen.dart';
import 'package:famelink/ui/settings/WebViewScreen.dart';
import 'package:famelink/ui/settings/faq_screen.dart';
import 'package:famelink/ui/settings/improvement_feedback_screen.dart';
import 'package:famelink/ui/settings/notification_settings_screen.dart';
import 'package:famelink/ui/settings/profile_verification_screen.dart';
import 'package:famelink/util/ReadMoreText.dart';
import 'package:famelink/util/Validator.dart';
import 'package:famelink/util/appStrings.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/config/image.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../FameChatScreen.dart';
import 'brand_edit_profile_screen.dart';
import 'edit_profile_screen.dart';

class BrandOtherProfileScreen extends StatefulWidget {
  @override
  _BrandOtherProfileScreenState createState() => _BrandOtherProfileScreenState();
}

class _BrandOtherProfileScreenState extends State<BrandOtherProfileScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AnimationController? _speedDialController;

  TabController? _tabController;
  final GlobalKey _childKey = GlobalKey();
  bool isHeightCalculated = false;
  double height = (ScreenUtil().screenHeight / 2) + 130;
  bool silverCollapsed = false;
  MyProfileResult? upperProfileData;
  var userId;
  int agencyPage = 1;
  int funLinksPage = 1;
  int followLinksPage = 1;
  int livePage = 1;
  ScrollController agencyScrollController = ScrollController();
  PageController pageController = PageController(keepPage: true);
  List<MyFunLinksResult> myFunlinksResult = [];
  List<Result> myFollowResult = [];
  List<Store> myFameResult = [];
  List<File> imageList = <File>[];
  File? profileImageFile;
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController phoneCodeNumber = TextEditingController();
  TextEditingController plusCodeNumber = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpNumber = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool? isUserNameAvialble;
  bool showPassword = true;
  bool isOTPLogin = false;
  bool isOTPEmailLogin = false;
  int _start = 30;
  String otpHash = "";
  Timer? _timer;
  // PageController pageController = PageController(keepPage: true);

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: 4);
    _tabController!.addListener(() {
      setState(() {
        print(_tabController!.index);
      });
    });
    agencyScrollController.addListener(() {
      if (agencyScrollController.offset > height - 100 &&
          !agencyScrollController.position.outOfRange) {
        if (!silverCollapsed) {
          // do what ever you want when silver is collapsing !

          silverCollapsed = true;
          setState(() {});
        }
      }
      if (agencyScrollController.offset <= height - 100 &&
          !agencyScrollController.position.outOfRange) {
        if (silverCollapsed) {
          // do what ever you want when silver is expanding !

          silverCollapsed = false;
          setState(() {});
        }
      }
      if (agencyScrollController.position.maxScrollExtent ==
          agencyScrollController.position.pixels) {
        if (_tabController!.index == 0) {
          agencyPage++;
          _myFamelinks();
        } else if (_tabController!.index == 1) {
          funLinksPage++;
          _myFunlinks();
        } else if (_tabController!.index == 2) {
          followLinksPage++;
          _myFollowLinks();
        }
      }
    });
    _speedDialController = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    userId = Constants.profileUserId;
    _profile();
    _myFamelinks();
    _myFunlinks();
    _myFollowLinks();
  }

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawer(upperProfileData!),
      body: DefaultTabController(
        length: 4,
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
                          '${ApiProvider.shareUrl}profile/brand/${userId}',
                        );
                      },
                      icon: Icon(
                        Icons.share_outlined,
                        color: black,
                      ))
                ],
                title: Text(
                    silverCollapsed
                        ? "${upperProfileData != null ? upperProfileData!.name : ""}"
                        : "",
                    style: GoogleFonts.nunitoSans(
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w700,
                        color: black)),
                backgroundColor: appBackgroundColor,
                expandedHeight: isHeightCalculated
                    ? (height - 24)
                    : (ScreenUtil().screenHeight / 2) + 130,
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
                        agencyPage = 1;
                        funLinksPage = 1;
                        followLinksPage = 1;
                        return refresh();
                      },
                      child: SingleChildScrollView(
                        key: _childKey,
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: ScreenUtil().screenWidth,
                                  height: ScreenUtil().setSp(250),
                                  color: appBackgroundColor,
                                  child: Stack(
                                    children: [
                                      upperProfileData != null &&
                                              upperProfileData!.brand != null &&
                                              upperProfileData!
                                                      .brand!.bannerMedia!.length >
                                                  0
                                          ? CarouselSlider.builder(
                                              itemCount: upperProfileData!
                                                  .brand!.bannerMedia!.length,
                                              itemBuilder: (BuildContext context,
                                                  int itemIndex,
                                                  int pageViewIndex) {
                                                return Container(
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    decoration: BoxDecoration(
                                                        color:
                                                        appBackgroundColor),
                                                    child: Image.network(
                                                      "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${upperProfileData!.brand!.bannerMedia![itemIndex]}",
                                                      fit: BoxFit.contain,
                                                    ));
                                              },
                                              options: CarouselOptions(
                                                height: ScreenUtil().setSp(250),
                                                aspectRatio: 16 / 9,
                                                viewportFraction: 1,
                                                initialPage: 0,
                                                enableInfiniteScroll: false,
                                                reverse: false,
                                                autoPlay: true,
                                                autoPlayInterval:
                                                    Duration(seconds: 3),
                                                autoPlayAnimationDuration:
                                                    Duration(milliseconds: 800),
                                                autoPlayCurve:
                                                    Curves.fastOutSlowIn,
                                                enlargeCenterPage: true,
                                                onPageChanged: (index, reason) {
                                                  setState(() {
                                                    pageController =
                                                        PageController(
                                                            keepPage: true,
                                                            initialPage: index);
                                                  });
                                                },
                                                scrollDirection: Axis.horizontal,
                                              ))
                                          : Container(),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Visibility(
                                          visible: upperProfileData != null &&
                                              upperProfileData!.brand != null &&
                                              upperProfileData!
                                                      .brand!.bannerMedia!.length >
                                                  0,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: ScreenUtil().setSp(10)),
                                            child: SmoothPageIndicator(
                                              controller: pageController,
                                              count: upperProfileData != null &&
                                                      upperProfileData!.brand !=
                                                          null &&
                                                      upperProfileData!
                                                              .brand!
                                                              .bannerMedia!
                                                              .length >
                                                          0
                                                  ? upperProfileData!
                                                      .brand!.bannerMedia!.length
                                                  : 0,
                                              axisDirection: Axis.horizontal,
                                              effect: SlideEffect(
                                                  spacing: 10.0,
                                                  radius: 3.0,
                                                  dotWidth: 6.0,
                                                  dotHeight: 6.0,
                                                  paintStyle:
                                                      PaintingStyle.stroke,
                                                  strokeWidth: 1.5,
                                                  dotColor: lightRedWhite,
                                                  activeDotColor: lightRed),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          child: SvgPicture.asset(
                                            "assets/icons/svg/brand_icon.svg",
                                          ),
                                          padding: EdgeInsets.only(
                                              right: ScreenUtil().setSp(23),
                                              bottom: ScreenUtil().setSp(12)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(16),
                                      right: ScreenUtil().setWidth(16),
                                      top: ScreenUtil().setHeight(9)),
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(95)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Wrap(
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.end,
                                                children: [
                                                  ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                        maxWidth: (ScreenUtil()
                                                                    .screenWidth /
                                                                2) -
                                                            30),
                                                    child: Text(
                                                        upperProfileData != null
                                                            ? "${upperProfileData!.name} ${upperProfileData!.profession != null ?"(${upperProfileData!.profession})":''}"
                                                            : "",
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            18),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: black)),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        ScreenUtil().setWidth(5),
                                                  ),
                                                  Visibility(
                                                    child: SvgPicture.asset(
                                                        "assets/icons/svg/verified.svg"),
                                                    visible:
                                                        upperProfileData != null
                                                            ? upperProfileData!
                                                                .isVerified!
                                                            : false,
                                                  )
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                                onTap: (){
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChattingScreen(
                                                                upperProfileData!.name!,
                                                                upperProfileData!
                                                                    .profileImage!,
                                                                upperProfileData!.id!,
                                                                "brand",
                                                                upperProfileData!
                                                                    .chatId!,
                                                                false)),
                                                  );
                                                },
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: ScreenUtil().setSp(8),
                                                        bottom: ScreenUtil().setSp(5),
                                                        left: ScreenUtil().setSp(16),
                                                        right:
                                                        ScreenUtil().setSp(16)),
                                                    child:
                                                    SvgPicture.asset(message))),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setSp(10),
                                      ),
                                      Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: lightGray,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
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
                                                                color:
                                                                    darkGray)))),
                                                child: Text(
                                                  upperProfileData != null ?"${upperProfileData!.followStatus == false ? 'Follow' : 'Unfollow'}":"",
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
                                          SizedBox(
                                            width: ScreenUtil().setSp(30),
                                          ),
                                          Expanded(
                                              child: Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: ScreenUtil().setSp(7),
                                                      bottom:
                                                          ScreenUtil().setSp(7)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        "${NumberFormat.compactCurrency(
                                                          decimalDigits: 0,
                                                          symbol:
                                                              '', // if you want to add currency symbol then pass that in this else leave it empty.
                                                        ).format(upperProfileData != null && upperProfileData!.likesCount != null ? upperProfileData!.likesCount : 0)}",
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
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () async {
                                                    Constants.profileUserId =
                                                        upperProfileData!.id;
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (ontext) =>
                                                              FollowerInfoScreen(isFollowing: false, id: upperProfileData!.id)),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: ScreenUtil().setSp(7),
                                                        bottom:
                                                            ScreenUtil().setSp(7)),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "${NumberFormat.compactCurrency(
                                                            decimalDigits: 0,
                                                            symbol:
                                                                '', // if you want to add currency symbol then pass that in this else leave it empty.
                                                          ).format(upperProfileData != null && upperProfileData!.followersCount != null ? upperProfileData!.followersCount : 0)}",
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
                                                          'Followers',
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
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () async {
                                                    Constants.profileUserId =
                                                        upperProfileData!.id;
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (ontext) =>
                                                              FollowerInfoScreen(isFollowing: true, id: upperProfileData!.id)),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: ScreenUtil().setSp(7),
                                                        bottom:
                                                            ScreenUtil().setSp(7)),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "${NumberFormat.compactCurrency(
                                                            decimalDigits: 0,
                                                            symbol:
                                                                '', // if you want to add currency symbol then pass that in this else leave it empty.
                                                          ).format(upperProfileData != null && upperProfileData!.followingCount != null ? upperProfileData!.followingCount : 0)}",
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
                                              ),
                                            ],
                                          ))
                                        ],
                                      ),
                                      Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: lightGray,
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setSp(10),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: ScreenUtil().setSp(5)),
                                              child: Text(
                                                  upperProfileData != null &&
                                                          upperProfileData!
                                                                  .username! !=
                                                              null
                                                      ? upperProfileData!.username!
                                                      : "",
                                                  style: GoogleFonts.nunitoSans(
                                                      fontSize:
                                                          ScreenUtil().setSp(14),
                                                      fontWeight: FontWeight.w400,
                                                      fontStyle: FontStyle.italic,
                                                      color: buttonBlue)),
                                            ),
                                          ),
                                          /*Image.asset("assets/icons/coin.png"),
                                          SizedBox(
                                            width: ScreenUtil().setSp(5),
                                          ),
                                          Text(
                                              "${NumberFormat.compactCurrency(
                                                decimalDigits: 0,
                                                symbol:
                                                    '', // if you want to add currency symbol then pass that in this else leave it empty.
                                              ).format(upperProfileData != null && upperProfileData.fameCoins != null ? upperProfileData.fameCoins : 0)}",
                                              style: GoogleFonts.nunitoSans(
                                                  fontSize:
                                                      ScreenUtil().setSp(12),
                                                  fontWeight: FontWeight.w400,
                                                  color: darkGray)),
                                          Expanded(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text("10",
                                                  style: GoogleFonts.nunitoSans(
                                                      fontSize:
                                                          ScreenUtil().setSp(14),
                                                      fontWeight: FontWeight.w400,
                                                      color: darkGray)),
                                              SizedBox(
                                                width: ScreenUtil().setSp(5),
                                              ),
                                              SvgPicture.asset(
                                                  "assets/icons/svg/live.svg",
                                                  color: buttonBlue),
                                            ],
                                          ))*/
                                        ],
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setSp(9),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // showAlertDialog(context,
                                          //     '${upperProfileData != null ? upperProfileData.bio : ""}');
                                        },
                                        child: Container(
                                          child: ReadMoreText(
                                            '${upperProfileData != null ? upperProfileData!.bio : ""}',
                                            trimLines: 3,
                                            trimMode: TrimMode.Line,
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: ScreenUtil().setSp(14),
                                                fontWeight: FontWeight.w400,
                                                color: black),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: upperProfileData!=null && upperProfileData!.brand != null?upperProfileData!.brand!.websiteUrl!.isNotEmpty:false,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(4)),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset("assets/icons/svg/link_icon.svg"),
                                              SizedBox(
                                                width: ScreenUtil().setSp(6),
                                              ),
                                              Text(
                                                  upperProfileData!=null && upperProfileData!.brand! != null?upperProfileData!.brand!.websiteUrl!:"",
                                                  style: GoogleFonts.nunitoSans(
                                                      fontSize:
                                                      ScreenUtil().setSp(12),
                                                      fontWeight: FontWeight.w400,
                                                      color: black)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(10)),
                                        child: Text.rich(
                                            TextSpan(children: <TextSpan>[
                                          TextSpan(
                                              text: "Trendz Sponsored: ",
                                              style: GoogleFonts.nunitoSans(
                                                  fontSize:
                                                      ScreenUtil().setSp(14),
                                                  fontWeight: FontWeight.w700,
                                                  color: black)),
                                          TextSpan(
                                              text:
                                              upperProfileData!=null && upperProfileData!.challengesSponsered != null?upperProfileData!.challengesSponsered:"",
                                              style: GoogleFonts.nunitoSans(
                                                  fontSize:
                                                      ScreenUtil().setSp(12),
                                                  fontWeight: FontWeight.w400,
                                                  color: black)),
                                        ])),
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
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setSp(207),
                                  left: ScreenUtil().setSp(17)),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: InkWell(
                                  onTap: () {
                                    showFullProfileDialog(context);
                                  },
                                  child: Container(
                                      height: ScreenUtil().setSp(86),
                                      width: ScreenUtil().setSp(86),
                                      decoration: BoxDecoration(
                                          color: black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenUtil().setSp(16))),
                                          image: profileImageFile! != null?
                                          new DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(profileImageFile!))
                                              :DecorationImage(
                                              fit: BoxFit.cover,
                                              image:  NetworkImage(
                                                  upperProfileData! != null ? '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${upperProfileData!.profileImage!}' :''))
                                      )
                                  ),
                                )
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                bottom: PreferredSize(
                  child: Container(
                    color: white,
                    child: TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(
                          icon: SvgPicture.asset("assets/icons/svg/shop.svg",
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

                        Tab(
                            icon: SvgPicture.asset("assets/icons/svg/live.svg",
                                color: _tabController!.index == 3
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
              /*SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(
                        icon: SvgPicture.asset(
                            "assets/icons/svg/tab_famelinks.svg",
                            color: _tabController.index == 0
                                ? darkGray
                                : lightGray),
                      ),
                      Tab(
                          icon: SvgPicture.asset(
                              "assets/icons/svg/tab_funlinks.svg",
                              color: _tabController.index == 1
                                  ? darkGray
                                  : lightGray)),

                      Tab(
                          icon: SvgPicture.asset(
                              "assets/icons/svg/tab_followlinks.svg",
                              color: _tabController.index == 2
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
                pinned: true,
              ),*/
            ];
          },
          controller: agencyScrollController,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ontext) => BrandDetailsScreen(
                          myFameResult.elementAt(index),
                          index,
                          agencyPage,
                          "",
                          "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}",true)),
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
                      child: myFameResult[index].images != null &&
                          myFameResult[index].images!.length > 0
                          ? myFameResult[index].images![0].type == "video"
                          ? Stack(
                        children: [
                          Container(
                              color: lightGray,
                              child: CachedNetworkImage(
                                imageUrl:
                                '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${myFameResult[index].images![0].path}-sm',
                                errorWidget: (context, url,
                                    error) =>
                                    Icon(Icons.error, color: white),
                                fit: BoxFit.cover,
                                width: itemWidth,
                                height: itemHeight,
                              )),
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
                        child: CachedNetworkImage(
                          imageUrl:
                          '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${myFameResult[index].images![0].path}-sm',
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error, color: white),
                          fit: BoxFit.cover,
                          width: itemWidth,
                          height: itemHeight,
                        ),
                      )
                          : Container(
                        color: lightGray,
                        child: CachedNetworkImage(
                          imageUrl:
                          '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/sm',
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error, color: white),
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
                                child: CachedNetworkImage(
                                  imageUrl:
                                  '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${myFunlinksResult[index].video}-sm',
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error, color: white),
                                  fit: BoxFit.cover,
                                  width: itemWidth,
                                  height: itemHeight,
                                )),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ontext) => FullPostScreen(
                          myFollowResult,
                          index,
                          followLinksPage,
                          "${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}",
                          false)),
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
                          ? myFollowResult[index].images![0].type ==
                          "video"
                          ? Stack(
                        children: [
                          Container(
                              color: lightGray,
                              child: CachedNetworkImage(
                                imageUrl:
                                '${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${myFollowResult[index].images![0].path}-sm',
                                errorWidget:
                                    (context, url, error) =>
                                    Icon(Icons.error,
                                        color: white),
                                fit: BoxFit.cover,
                                width: itemWidth,
                                height: itemHeight,
                              )),
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
                          : Container(
                          color: lightGray,
                          child: CachedNetworkImage(
                            imageUrl:
                            '${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${myFollowResult[index].images![0].path}-sm',
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error, color: white),
                            fit: BoxFit.cover,
                            width: itemWidth,
                            height: itemHeight,
                          ))
                          : SizedBox(),
                    ),
                    Padding(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                                myFollowResult[index]
                                    .images!
                                    .length
                                    .toString(),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ontext) => FullPostScreen(
                                myFollowResult,
                                index,
                                followLinksPage,
                                "${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}",
                                false)),
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
                                ? myFollowResult[index].images![0].type ==
                                        "video"
                                    ? Stack(
                                        children: [
                                          Container(
                                              color: lightGray,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${myFollowResult[index].images![0].path}-sm',
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error,
                                                            color: white),
                                                fit: BoxFit.cover,
                                                width: itemWidth,
                                                height: itemHeight,
                                              )),
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
                                    : Container(
                                        color: lightGray,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${myFollowResult[index].images![0].path}-sm',
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error, color: white),
                                          fit: BoxFit.cover,
                                          width: itemWidth,
                                          height: itemHeight,
                                        ))
                                : SizedBox(),
                          ),
                          Padding(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                      myFollowResult[index]
                                          .images!
                                          .length
                                          .toString(),
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
                child: Text("No Live Found",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              ),
      ],
    );
  }
  Future<String> refresh() async{
    _profile();
    _myFamelinks();
    _myFunlinks();
    _myFollowLinks();
    return 'success';
  }
  _profile() async {
    Api.get.call(context, method: "users/$userId", param: {},
        onResponseSuccess: (Map object) async {
      var result = ProfileResponse.fromJson(object);
      upperProfileData = result.result;
      print('RESPONSE ${result.result}');
      setState(() {});
    });
  }

  _myFamelinks() async {
    Map<String, dynamic> map = {"page": agencyPage.toString()};
    Api.get.call(context, method: "users/brandOne/${userId}/products", param: map,isLoading: false,
        onResponseSuccess: (Map object) async {
      var result = StoreModel.fromJson(object);
      if (result.result!.length > 0) {
        myFameResult.addAll(result.result!);
        setState(() {});
      } else {
        agencyPage == 1 ? agencyPage :agencyPage--;
      }
    });
  }

  _myFunlinks() async {
    Map<String, dynamic> map = {"page": funLinksPage.toString()};
    Api.get.call(context, method: "media/funlinks/${userId}", param: map,isLoading: false,
        onResponseSuccess: (Map object) async {
      var result = MyFunLinksResponse.fromJson(object);
      if (result.result!.length > 0) {
        myFunlinksResult.addAll(result.result!);
        setState(() {});
        print('RESPONSE ${result.result.toString()}');
      } else {
        funLinksPage == 1 ? funLinksPage : funLinksPage--;
      }
    });
  }

  _myFollowLinks() async {
    Map<String, dynamic> map = {"page": followLinksPage.toString()};
    Api.get.call(context, method: "media/followlinks/${userId}", param: map,isLoading: false,
        onResponseSuccess: (Map object) async {
      var result = FamelinksResponse.fromJson(object);
      if (result.result!.length > 0) {
        myFollowResult.addAll(result.result!);
        setState(() {});
        print('RESPONSE ${result.result.toString()}');
      } else {
        followLinksPage == 1 ? followLinksPage : followLinksPage--;
      }
    });
  }

  Widget drawer(MyProfileResult upperProfileData) {
    return Drawer(
      child: Container(
        height: ScreenUtil().screenHeight,
        child: Column(
          children: [
            Container(
                decoration: new BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [lightRedWhite, lightRed]),
                ),
                alignment: Alignment.center,
                height: ScreenUtil().setHeight(90),
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(48),
                    bottom: ScreenUtil().setHeight(12)),
                child: Text(
                  'Settings',
                  style: GoogleFonts.nunitoSans(
                      color: white,
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.w400),
                )),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(32),
                    bottom: ScreenUtil().setHeight(80),
                    left: ScreenUtil().setWidth(17),
                    right: ScreenUtil().setWidth(22)),
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ontext) => NotificationSettingsScreen(
                                upperProfileData.settings!.notification!)),
                      );
                    },
                    child: Row(
                      children: [
                        MyBullet(),
                        SizedBox(
                          width: ScreenUtil().setWidth(8),
                        ),
                        Text(
                          'Notification Settings',
                          style: GoogleFonts.nunitoSans(
                              color: black,
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ontext) => ImprovementFeedbackScreen()),
                      );
                    },
                    child: Row(
                      children: [
                        MyBullet(),
                        SizedBox(
                          width: ScreenUtil().setWidth(8),
                        ),
                        Text(
                          'Feedback',
                          style: GoogleFonts.nunitoSans(
                              color: black,
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (ontext) => FAQScreen()),
                      );
                    },
                    child: Row(
                      children: [
                        MyBullet(),
                        SizedBox(
                          width: ScreenUtil().setWidth(8),
                        ),
                        Text(
                          'Support',
                          style: GoogleFonts.nunitoSans(
                              color: black,
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(8),
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: appBackgroundColor,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(24),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ontext) =>
                                ProfileVideoVerificationScreen()),
                      );
                    },
                    child: Row(
                      children: [
                        MyBullet(),
                        SizedBox(
                          width: ScreenUtil().setWidth(8),
                        ),
                        Text(
                          'Verify your Profile',
                          style: GoogleFonts.nunitoSans(
                              color: black,
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      showUpdateEmailDialog(context, upperProfileData.email!);
                    },
                    child: Row(
                      children: [
                        MyBullet(),
                        SizedBox(
                          width: ScreenUtil().setWidth(8),
                        ),
                        Text(
                          'Update Email ID',
                          style: GoogleFonts.nunitoSans(
                              color: black,
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(9),
                        ),
                        Text(
                          'Verify',
                          style: GoogleFonts.nunitoSans(
                              color: buttonBlue,
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      showUpdateMobileDialog(
                          context, upperProfileData.mobileNumber.toString());
                    },
                    child: Row(
                      children: [
                        MyBullet(),
                        SizedBox(
                          width: ScreenUtil().setWidth(8),
                        ),
                        Text(
                          'Update Contact Number',
                          style: GoogleFonts.nunitoSans(
                              color: black,
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  /*SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      // await Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (ontext) => EditProfileScreen(null)),
                      // );
                    },
                    child: Row(
                      children: [
                        MyBullet(),
                        SizedBox(
                          width: ScreenUtil().setWidth(8),
                        ),
                        Text(
                          'Change Profile Type',
                          style: GoogleFonts.nunitoSans(
                              color: black,
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),*/
                  SizedBox(
                    height: ScreenUtil().setHeight(8),
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: appBackgroundColor,
                  ),
                  /*SizedBox(
                    height: ScreenUtil().setHeight(24),
                  ),
                  Row(
                    children: [
                      MyBullet(),
                      SizedBox(
                        width: ScreenUtil().setWidth(8),
                      ),
                      Text(
                        'Paid Promotions',
                        style: GoogleFonts.nunitoSans(
                            color: black,
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  Row(
                    children: [
                      MyBullet(),
                      SizedBox(
                        width: ScreenUtil().setWidth(8),
                      ),
                      Text(
                        'Collaborations',
                        style: GoogleFonts.nunitoSans(
                            color: black,
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  Row(
                    children: [
                      MyBullet(),
                      SizedBox(
                        width: ScreenUtil().setWidth(8),
                      ),
                      Text(
                        'Fame Points',
                        style: GoogleFonts.nunitoSans(
                            color: black,
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  Row(
                    children: [
                      MyBullet(),
                      SizedBox(
                        width: ScreenUtil().setWidth(8),
                      ),
                      Text(
                        'Statistics',
                        style: GoogleFonts.nunitoSans(
                            color: black,
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(8),
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: appBackgroundColor,
                  ),*/
                  SizedBox(
                    height: ScreenUtil().setHeight(24),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ontext) =>
                                WebViewScreen("Stages of FameLinks")),
                      );
                    },
                    child: Row(
                      children: [
                        MyBullet(),
                        SizedBox(
                          width: ScreenUtil().setWidth(8),
                        ),
                        Text(
                          'Stages of FameLinks',
                          style: GoogleFonts.nunitoSans(
                              color: black,
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(8),
                        ),
                        Image.asset("assets/icons/link.png", color: lightGray)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ontext) =>
                                WebViewScreen("Terms of Usage & Services")),
                      );
                    },
                    child: Row(
                      children: [
                        MyBullet(),
                        SizedBox(
                          width: ScreenUtil().setWidth(8),
                        ),
                        Text(
                          'Terms of Usage & Services',
                          style: GoogleFonts.nunitoSans(
                              color: black,
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(8),
                        ),
                        Image.asset("assets/icons/link.png", color: lightGray)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ontext) =>
                                WebViewScreen("Privacy Policy")),
                      );
                    },
                    child: Row(
                      children: [
                        MyBullet(),
                        SizedBox(
                          width: ScreenUtil().setWidth(8),
                        ),
                        Text(
                          'Privacy Policy',
                          style: GoogleFonts.nunitoSans(
                              color: black,
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(8),
                        ),
                        Image.asset("assets/icons/link.png", color: lightGray)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(71),
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: appBackgroundColor,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(12),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      isLogout().then((value) {
                        if (value!) {
                          Navigator.pop(context, true);
                        }
                      });
                      // showLogOutAlertDialog(context);
                    },
                    child: Row(
                      children: [
                        MyBullet(),
                        SizedBox(
                          width: ScreenUtil().setWidth(8),
                        ),
                        Text(
                          'Logout',
                          style: GoogleFonts.nunitoSans(
                              color: black,
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w400),
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
    );
  }

  showUpdateMobileDialog(BuildContext context, String mobile) {
    phoneNumber.text = mobile;
    phoneCodeNumber.text = "91";
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: TextStyle(color: lightRed)),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setStates) {
              return AlertDialog(
                content: isOTPLogin ? enterOTPNumber() : enterPhoneNumber(),
                actions: [
                  cancelButton,
                  TextButton(
                    child: Text("Submit", style: TextStyle(color: lightRed)),
                    onPressed: () async {
                      if (isOTPLogin) {
                        _handleOTPIn();
                      } else {
                        if (phoneCodeNumber.text.length > 1 &&
                            phoneNumber.text.isNotEmpty) {
                          await _loginService(setStates);
                        } else if (phoneCodeNumber.text.length <= 1) {
                          Constants.toastMessage(msg: "Enter Phone Code");
                        } else if (phoneNumber.text.isEmpty) {
                          Constants.toastMessage(msg: "Enter Phone Number");
                        }
                      }
                    },
                  ),
                ],
              );
            });
      },
    );
  }

  showUpdateEmailDialog(BuildContext context, String email) {
    emailController.text = email;
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: TextStyle(color: lightRed)),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setStates) {
              return AlertDialog(
                content: isOTPEmailLogin ? enterOTPNumber() : enterEmail(),
                actions: [
                  cancelButton,
                  TextButton(
                    child: Text("Submit", style: TextStyle(color: lightRed)),
                    onPressed: () async {
                      if (isOTPEmailLogin) {
                        upperProfileData!.email = emailController.text;
                        _handleOTPEmailIn();
                      } else {
                        if (emailController.text.isNotEmpty) {
                          await _emailLoginService(setStates);
                        } else if (emailController.text.isEmpty) {
                          Constants.toastMessage(msg: "Enter Email");
                        }
                      }
                    },
                  ),
                ],
              );
            });
      },
    );
  }

  Widget enterEmail() {
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(5)),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        border: Border.all(width: 1.0, color: lightRed),
        borderRadius: BorderRadius.all(
            Radius.circular(5.0) //                 <--- border radius here
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextFormField(
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  hintText: 'Enter Email',
                  hintStyle: GoogleFonts.nunitoSans(
                      fontSize: ScreenUtil().setSp(16),
                      color: darkGray,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget enterPhoneNumber() {
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(5)),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        border: Border.all(width: 1.0, color: lightRed),
        borderRadius: BorderRadius.all(
            Radius.circular(5.0) //                 <--- border radius here
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 10,
            height: 50,
            child: TextFormField(
              focusNode: AlwaysDisabledFocusNode(),
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              controller: plusCodeNumber,
              style: GoogleFonts.nunitoSans(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w400),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              validator: (value) {
                return Validator.validateFormField(
                    value!,
                    strErrorEmptyPhoneNumber,
                    strInvalidPhoneNumber,
                    Constants.PHONE_VALIDATION);
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: '+',
                hintStyle: GoogleFonts.nunitoSans(
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          SizedBox(
            width: 40,
            height: 50,
            child: TextFormField(
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              controller: phoneCodeNumber,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              style: GoogleFonts.nunitoSans(
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                hintText: 'Code',
                hintStyle: GoogleFonts.nunitoSans(
                    fontSize: ScreenUtil().setSp(16),
                    color: darkGray,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: VerticalDivider(
              thickness: 1,
              color: lightRed,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextFormField(
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(10),
                ],
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                controller: phoneNumber,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  hintText: 'Enter Phone Number',
                  hintStyle: GoogleFonts.nunitoSans(
                      fontSize: ScreenUtil().setSp(16),
                      color: darkGray,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget enterOTPNumber() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        border: Border.all(width: 1.0, color: lightGray),
        borderRadius: BorderRadius.all(
            Radius.circular(5.0) //                 <--- border radius here
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              inputFormatters: [
                new LengthLimitingTextInputFormatter(6),
              ],
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              controller: otpNumber,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              obscureText: showPassword,
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                contentPadding:
                EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                hintText: 'Enter OTP',
                hintStyle: GoogleFonts.nunitoSans(
                    fontSize: ScreenUtil().setSp(16),
                    color: darkGray,
                    fontWeight: FontWeight.w400),
                prefixIcon: IconButton(
                  onPressed: () async {},
                  padding: EdgeInsets.all(0),
                  icon: SvgPicture.asset("assets/icons/svg/keyOtp.svg"),
                ),
                suffixIcon: IconButton(
                  onPressed: () async {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: showPassword
                      ? Icon(
                    Icons.remove_red_eye_outlined,
                    color: darkGray,
                  )
                      : SvgPicture.asset("assets/icons/svg/hideOtp.svg",
                      color: darkGray),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _loginService(StateSetter setStates) async {
    Map<String, dynamic> map = {
      "mobileNumber": phoneNumber.text,
      "code": phoneCodeNumber.text
    };
    Api.post.call(context, method: "users/contact", param: map,
        onResponseSuccess: (Map object) async {
          var result = LoginResponse.fromJson(object);
          this.otpHash = result.result!.otpHash!;
          setStates(() {
            isOTPLogin = true;
          });
          startTimer();
        });
  }

  _emailLoginService(StateSetter setStates) async {
    Map<String, dynamic> map = {"email": emailController.text};
    Api.post.call(context, method: "users/email", param: map,
        onResponseSuccess: (Map object) async {
          var result = LoginResponse.fromJson(object);
          this.otpHash = result.result!.otpHash!;
          setStates(() {
            isOTPEmailLogin = true;
          });
          startTimer();
        });
  }

  Future<void> _handleOTPIn() async {
    if (otpNumber.text.length != 6) {
      //_mobileVerify();
      Constants.toastMessage(msg: "Enter 6-digit code!");
    } else {
      Map<String, dynamic> map = {
        "otp": int.parse(otpNumber.text),
        "otpHash": otpHash
      };
      Api.post.call(context, method: "users/contact/verify", param: map,
          onResponseSuccess: (Map object) async {
            var result = RegisterResponse.fromJson(object);
            isOTPLogin = false;
            Navigator.pop(context);
            Constants.toastMessage(msg: result.message);
          });
    }
  }

  Future<void> _handleOTPEmailIn() async {
    if (otpNumber.text.length != 6) {
      Constants.toastMessage(msg: "Enter 6-digit code!");
    } else {
      Map<String, dynamic> map = {
        "otp": int.parse(otpNumber.text),
        "otpHash": otpHash
      };
      Api.post.call(context, method: "users/email/verify", param: map,
          onResponseSuccess: (Map object) async {
            var result = RegisterResponse.fromJson(object);
            isOTPEmailLogin = false;
            Navigator.pop(context);
            Constants.toastMessage(msg: result.message);
          });
    }
  }

  void startTimer() {
    if (isOTPLogin) {
      if (_timer != null) {
        _timer!.cancel();
        _timer = null;
      } else {
        _timer = new Timer.periodic(
          const Duration(seconds: 1),
              (Timer timer) => setState(
                () {
              if (_start < 1) {
                timer.cancel();
                _timer = null;
              } else {
                _start = _start - 1;
              }
            },
          ),
        );
      }
    }
  }

  void showReferralCodeDialog(bool isShare) {
    nameController.text =
    upperProfileData != null && upperProfileData!.username != null
        ? upperProfileData!.username!
        : "";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(ScreenUtil().setSp(
                      ((ScreenUtil().screenWidth - ScreenUtil().setSp(300)) /
                          2))),
                  right: ScreenUtil().setWidth(ScreenUtil().setSp(
                      ((ScreenUtil().screenWidth - ScreenUtil().setSp(300)) /
                          2)))),
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
                                'Enter your User Name',
                                style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(14),
                                    color: white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(4),
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
                                      left: ScreenUtil().setWidth(7),
                                      right: ScreenUtil().setWidth(7)),
                                  child: TextFormField(
                                    textAlign: TextAlign.start,
                                    textAlignVertical: TextAlignVertical.center,
                                    controller: nameController,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.done,
                                    onChanged: (text) {
                                      if (text.length >= 6) {
                                        if (text
                                            .toLowerCase()
                                            .contains("famelinks") ||
                                            text
                                                .toLowerCase()
                                                .contains("fame_links") ||
                                            text
                                                .toLowerCase()
                                                .contains("fame.links")) {
                                          isUserNameAvialble = false;
                                          setStates(() {});
                                        } else {
                                          Api.get.call(context,
                                              method:
                                              "users/check/username/${text}",
                                              param: {},
                                              isLoading: false, onResponseSuccess:
                                                  (Map object) async {
                                                var result =
                                                UsernameCheckModel.fromJson(object);
                                                isUserNameAvialble =
                                                    result.result!.isAvailable;
                                                setStates(() {});
                                              });
                                        }
                                      }
                                    },
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(12),
                                        color: buttonBlue,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400),
                                    validator: (value) {
                                      return Validator.validateFormField(
                                          value!,
                                          strErrorEmptyName,
                                          strInvalidName,
                                          Constants.NORMAL_VALIDATION);
                                    },
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: white25,
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: lightGray,
                                              width: ScreenUtil().radius(1)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenUtil().radius(8))),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: buttonBlue,
                                              width: ScreenUtil().radius(1)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenUtil().radius(8))),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: lightGray,
                                              width: ScreenUtil().radius(1)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenUtil().radius(8))),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            top: ScreenUtil().setSp(0),
                                            left: ScreenUtil().setWidth(11),
                                            right: ScreenUtil().setWidth(7)),
                                        hintText: 'username',
                                        prefixText: "@",
                                        hintStyle: GoogleFonts.nunitoSans(
                                            fontStyle: FontStyle.italic,
                                            fontSize: ScreenUtil().setSp(12),
                                            color: buttonBlue,
                                            fontWeight: FontWeight.w400),
                                        suffix: isUserNameAvialble != null
                                            ? isUserNameAvialble!
                                            ? SvgPicture.asset(
                                            "assets/icons/svg/done.svg",
                                            height: ScreenUtil().setSp(16),
                                            width: ScreenUtil().setSp(16))
                                            : Icon(
                                          Icons.close,
                                          color: Colors.red,
                                          size: 16,
                                        )
                                            : null),
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Center(
                                              child: InkWell(
                                                onTap: () async {
                                                  if (nameController.text
                                                      .toLowerCase()
                                                      .contains("famelinks") ||
                                                      nameController.text
                                                          .toLowerCase()
                                                          .contains("fame_links") ||
                                                      nameController.text
                                                          .toLowerCase()
                                                          .contains("fame.links")) {
                                                    Constants.toastMessage(
                                                        msg:
                                                        "This username is not available, Please chose some other username");
                                                  } else if (isUserNameAvialble != null &&
                                                      isUserNameAvialble!) {
                                                    upperProfileData!.username =
                                                        nameController.text;
                                                    Map<String, dynamic> map = {
                                                      "username": nameController.text,
                                                    };
                                                    Api.put.call(context,
                                                        method: "users/update",
                                                        param: map, onResponseSuccess:
                                                            (Map object) async {
                                                          var result =
                                                          UserUpdatedResponse.fromJson(
                                                              object);
                                                          Navigator.pop(context);
                                                          if (isShare) {
                                                            Share.share(
                                                              '${ApiProvider.shareUrl}${upperProfileData!.username}',
                                                            );
                                                          }
                                                        });
                                                  } else if (isUserNameAvialble == null) {
                                                    upperProfileData!.username =
                                                        nameController.text;
                                                    Map<String, dynamic> map = {
                                                      "username": nameController.text,
                                                    };
                                                    Api.put.call(context,
                                                        method: "users/update",
                                                        param: map, onResponseSuccess:
                                                            (Map object) async {
                                                          var result =
                                                          UserUpdatedResponse.fromJson(
                                                              object);
                                                          Navigator.pop(context);
                                                          if (isShare) {
                                                            Share.share(
                                                              '${ApiProvider.shareUrl}${upperProfileData!.username}',
                                                            );
                                                          }
                                                        });
                                                  } else {
                                                    Constants.toastMessage(
                                                        msg: "username not available");
                                                  }
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: ScreenUtil().setSp(32),
                                                      bottom: ScreenUtil().setSp(20)),
                                                  child: Text("Submit",
                                                      style: GoogleFonts.nunitoSans(
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: ScreenUtil().setSp(14),
                                                          color: black)),
                                                ),
                                              ))),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: ScreenUtil().setSp(32),
                                            bottom: ScreenUtil().setSp(20)),
                                        child: VerticalDivider(
                                          thickness: 1,
                                          width: 1,
                                          color: lightGray,
                                        ),
                                      ),
                                      Expanded(
                                          child: Center(
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: ScreenUtil().setSp(32),
                                                      bottom: ScreenUtil().setSp(20)),
                                                  child: Text("Cancel",
                                                      style: GoogleFonts.nunitoSans(
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: ScreenUtil().setSp(14),
                                                          color: lightGray)),
                                                ),
                                              ))),
                                    ],
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
                    return Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: ScreenUtil().setSp(25)),
                          decoration: profileImageFile != null ||
                              (upperProfileData != null &&
                                  upperProfileData!.profileImage != null)
                              ? BoxDecoration(
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
                              image: profileImageFile != null?
                              new DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                       FileImage(profileImageFile!)
                              ):
                              DecorationImage(
                                  fit: BoxFit.cover,
                                  image:  NetworkImage(
                                      '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${upperProfileData!.profileImage}')
                              )
                          )
                              : BoxDecoration(
                              color: white,
                              image: new DecorationImage(
                                  fit: BoxFit.scaleDown,
                                  image: AssetImage("assets/icons/male.png"))),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding:
                            EdgeInsets.only(right: ScreenUtil().setWidth(23)),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                uploadProfilePic();
                              },
                              child: CircleAvatar(
                                radius: ScreenUtil().setSp(25),
                                backgroundColor: lightGray,
                                child: CircleAvatar(
                                  radius: ScreenUtil().setSp(24),
                                  backgroundColor: white,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: lightGray,
                                    size: ScreenUtil().radius(20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }));
        });
  }

  void uploadPic() async {
    FormData formData = FormData.fromMap({
    });
    formData.files.addAll([
      MapEntry("profileImage", Constants.profileImage!),
    ]);
    Api.uploadPut.call(context,
        method: "users/profile/image/upload",
        param: formData,
        onResponseSuccess: (Map object) {
          var result = LikesResponse.fromJson(object);
          Constants.toastMessage(msg: result.message);
        });
  }

  Future uploadProfilePic() async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () async {
                      try {
                        final pickedFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        profileImageFile = File(pickedFile!.path);
                        if (pickedFile != null) {
                          _cropImage2().then((value) async {
                            Constants.profileImage = await MultipartFile.fromFile(
                                value!.path,
                                filename:
                                "${File(pickedFile.path).path.split('/').last}");
                            setState(() {
                              profileImageFile = value;
                            });
                            uploadPic();
                          });
                        }
                      } on PlatformException catch (e) {
                        print('FAILED $e');
                      }
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () async {
                    try {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      profileImageFile = File(pickedFile!.path);
                      if (pickedFile != null) {
                        _cropImage2().then((value) async {
                          Constants.profileImage = await MultipartFile.fromFile(
                              value!.path,
                              filename:
                              "${File(pickedFile.path).path.split('/').last}");
                          setState(() {
                            profileImageFile = value;
                          });
                          uploadPic();
                        });
                      }
                    } on PlatformException catch (e) {
                      print('FAILED $e');
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<File?> _cropImage2() async {
    return await ImageCropper().cropImage(
        sourcePath: profileImageFile!.path,
        aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 4),
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
  }

  showLogOutAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Yes", style: GoogleFonts.nunitoSans(color: lightRed)),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        Navigator.pop(context, true);
      },
    );

    Widget noButton = TextButton(
      child: Text("No", style: GoogleFonts.nunitoSans(color: lightRed)),
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

  Future<bool?> isLogout() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Are you sure you won't to logout this app?"),
          actions: [
            TextButton(
              child:
                  Text("Yes", style: GoogleFonts.nunitoSans(color: lightRed)),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                return Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: Text("No", style: GoogleFonts.nunitoSans(color: lightRed)),
              onPressed: () async {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
        ;
      },
    );
  }

  Future closeUp() async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () async {
                      try {
                        final pickedFile =
                        await ImagePicker().pickImage(source: ImageSource.gallery);
                        if (pickedFile == null) return;
                        int count = 1 +
                            upperProfileData!.agency!.bannerMedia!.length;
                        if (count <= 6) {
                          _cropImage(pickedFile)
                              .then((value) async {
                            print(value!.path);
                            FormData formData = FormData.fromMap({});
                            formData.files.addAll([
                              MapEntry(
                                  "media",
                                  await MultipartFile.fromFile(
                                      value.path)),
                            ]);

                            Api.uploadPost.call(context,
                                method: "users/brand/banner/upload",
                                param: formData, onResponseSuccess: (Map object) {
                                  var snackBar = SnackBar(
                                    content: Text('Uploaded'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  _profile();
                                });
                          });
                        } else {
                          var snackBar = SnackBar(
                            content: Text('max 5 banner allowed'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } on PlatformException catch (e) {
                        print('FAILED $e');
                      }
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () async {
                    try {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (image == null) return;
                      int count =
                          1 + upperProfileData!.brand!.bannerMedia!.length;
                      if (count <= 6) {
                        File closeUpImageFile = File(image.path);
                        _cropImage(closeUpImageFile).then((value) async {
                          print(value!.path);

                          FormData formData = FormData.fromMap({});
                          formData.files.addAll([
                            MapEntry("media",
                                await MultipartFile.fromFile(value.path)),
                          ]);

                          Api.uploadPost.call(context,
                              method: "users/brand/banner/upload",
                              param: formData, onResponseSuccess: (Map object) {
                            var snackBar = SnackBar(
                              content: Text('Uploaded'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            _profile();
                          });
                        });
                      } else {
                        var snackBar = SnackBar(
                          content: Text('max 5 banner allowed'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } on PlatformException catch (e) {
                      print('FAILED $e');
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<File?> _cropImage(profileImageFile) async {
    return await ImageCropper().cropImage(
        sourcePath: profileImageFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1.46, ratioY: 1),
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
          title: 'Cropper',
        ));
  }
  void follow(String sId) async {
    Api.post.call(context, method: "users/follow/$sId",
        param: {},
        onResponseSuccess: (Map<dynamic,dynamic> object)async{
          var result = FollowResponse.fromJson(object);
          upperProfileData!.followStatus = !upperProfileData!.followStatus!;
          upperProfileData!.followersCount =upperProfileData!.followersCount! +1;
          print(result.message.toString());
          setState(() {});
        });
  }

  void unfollow(String sId) async {
    Api.delete.call(context, method: "users/unfollow/$sId",
        param: {},
        onResponseSuccess: (Map<dynamic,dynamic> object)async{
          var result = FollowResponse.fromJson(object);
          upperProfileData!.followStatus = !upperProfileData!.followStatus!;
          upperProfileData!.followersCount= upperProfileData!.followersCount! + 1;
          print(result.message.toString());
          setState(() {});
        });
  }
}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
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
