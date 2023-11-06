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
import 'package:famelink/models/likes_model.dart';
import 'package:famelink/models/login_model.dart';
import 'package:famelink/models/register_response.dart';
import 'package:famelink/models/userUpdateResponse.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/challenge/challenge_screen.dart';
import 'package:famelink/ui/followers/follower_info_screen.dart';
import 'package:famelink/ui/notification/notification_screen.dart';
import 'package:famelink/ui/profile/FullFunLinksPostScreen.dart';
import 'package:famelink/ui/profile/FullPostScreen.dart';
import 'package:famelink/ui/profile/fame_coins_screen.dart';
import 'package:famelink/ui/recommendation_screen.dart';
import 'package:famelink/ui/settings/WebViewScreen.dart';
import 'package:famelink/ui/settings/faq_screen.dart';
import 'package:famelink/ui/settings/improvement_feedback_screen.dart';
import 'package:famelink/ui/settings/notification_settings_screen.dart';
import 'package:famelink/ui/settings/profile_verification_screen.dart';
import 'package:famelink/ui/upload/followlink_upload.dart';
import 'package:famelink/ui/upload/funlink_upload_one.dart';
import 'package:famelink/ui/upload/upload_screen_one.dart';
import 'package:famelink/util/ReadMoreText.dart';
import 'package:famelink/util/UnicornOutlineButton.dart';
import 'package:famelink/util/Validator.dart';
import 'package:famelink/util/appStrings.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/config/image.dart';
import 'package:famelink/util/constants.dart';
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
import 'package:video_compress/video_compress.dart';

import '../FameChatScreen.dart';
import 'brand_edit_profile_screen.dart';

class AgencyProfileScreen extends StatefulWidget {
  @override
  _AgencyProfileScreenState createState() => _AgencyProfileScreenState();
}

class _AgencyProfileScreenState extends State<AgencyProfileScreen>
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
  List<Result> myFameResult = [];
  List<File?> imageList = <File?>[];
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
  String ageGroup = 'groupE';

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageList.add(null);
    _tabController = new TabController(vsync: this, length: 4);
    _tabController?.addListener(() {
      setState(() {
        print(_tabController?.index);
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
        if (_tabController?.index == 0) {
          agencyPage++;
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
          height = (_childKey.currentContext?.findRenderObject() as RenderBox)
              .size
              .height;
        });
      }
    });
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawer(upperProfileData!),
      floatingActionButton: SpeedDial(
        openBackgroundColor: appBackgroundColor,
        closedBackgroundColor: appBackgroundColor,
        controller: _speedDialController,
        child: UnicornOutlineButton(
          strokeWidth:
          ScreenUtil()
              .setSp(2),
          bottomLeftRadius:
          ScreenUtil()
              .setSp(28),
          bottomRightRadius:
          ScreenUtil()
              .setSp(28),
          topLeftRadius:
          ScreenUtil()
              .setSp(28),
          topRightRadius:
          ScreenUtil()
              .setSp(28),
          gradient: LinearGradient(
              begin: Alignment
                  .centerLeft,
              end: Alignment
                  .centerRight,
              colors: [
                profileBorder1,
                profileBorder2,
                profileBorder3,
                profileBorder4
              ]),
          onPressed: () {
            if (!_speedDialController!.isDismissed) {
              _speedDialController?.reverse();
            }else{
              _speedDialController?.animateTo(100);
            }
          },
          child: Container(
            height: ScreenUtil().setSp(56),
            width: ScreenUtil().setSp(56),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().setSp(28)),
            ),
            padding: EdgeInsets.all(ScreenUtil().setSp(18)),
            child: SvgPicture.asset(
              home,
            ),
          ),
        ),
        speedDialChildren: <SpeedDialChild>[
          SpeedDialChild(
            backgroundColor: white,
            label: 'Notification',
            child: IconButton(
                onPressed: () {
                  if (!_speedDialController!.isDismissed) {
                    _speedDialController!.reverse();
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationScreen()),
                  );
                },
                icon: SvgPicture.asset(notifications, color: black)), onPressed: (){},
          ),
          SpeedDialChild(
            backgroundColor: white,
            label: 'Message',
            child: IconButton(
                onPressed: () {
                  if (!_speedDialController!.isDismissed) {
                    _speedDialController!.reverse();
                  }
                  Constants.profileUserId = Constants.userId;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => FameChatScreen()),
                  );
                },
                icon: SvgPicture.asset(messages, color: black)), onPressed: (){},
          ),
          /*SpeedDialChild(
            backgroundColor: white,
            label: 'Hall of Fame',
            child: IconButton(
                onPressed: () {
                  if (!_speedDialController.isDismissed) {
                    _speedDialController.reverse();
                  }
                },
                icon: SvgPicture.asset(halloffame, color: black)),
          ),*/
          SpeedDialChild(
            backgroundColor: white,
            label: 'Trendz',
            child: IconButton(
                onPressed: () async {
                  if (!_speedDialController!.isDismissed) {
                    _speedDialController!.reverse();
                  }
                  var result = await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ChallengeScreen()),
                  );
                  if (result != null) {
                    Navigator.pop(context, result);
                  }
                },
                icon: SvgPicture.asset(challenge, color: black)), onPressed: (){},
          ),
        ],
      ),
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                leading: IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    icon: SvgPicture.asset(
                      menu,
                      width: 20,
                      height: 12,
                    )),
                actions: [
                  IconButton(
                      onPressed: () {
                        showAddPostDialog();
                      },
                      icon: SvgPicture.asset("assets/icons/svg/add_profile_post.svg")),
                  IconButton(
                      onPressed: () {
                        Share.share(
                          '"Hey buddy,\nI am on FameLinks App, where we can participate in Worldwide Beauty Contests, right from the comfort of our homes. I recommend you too to download and join me on FameLinks.\n${ApiProvider.shareUrl}profile/agency/$userId',
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
                    ? (height + ScreenUtil().setSp(24))
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
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Stack(
                          children: [
                            Column(
                              key: _childKey,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: ScreenUtil().screenWidth,
                                  height: ScreenUtil().setSp(174),
                                  color: appBackgroundColor,
                                  child: Stack(
                                    children: [
                                      upperProfileData != null &&
                                          upperProfileData!.agency != null &&
                                          upperProfileData!
                                              .agency!.bannerMedia!.length >
                                              1
                                          ? CarouselSlider.builder(
                                          itemCount: upperProfileData!
                                              .agency!.bannerMedia!.length,
                                          itemBuilder: (BuildContext context,
                                              int itemIndex,
                                              int pageViewIndex) {
                                            if (itemIndex ==
                                                upperProfileData!.agency!
                                                    .bannerMedia!.length -
                                                    1 && upperProfileData!.agency!
                                                .bannerMedia!.elementAt(itemIndex).isEmpty) {
                                              return InkWell(
                                                onTap: () {
                                                  closeUp();
                                                },
                                                child: Container(
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    child: Stack(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .center,
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .min,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  "assets/icons/svg/upload_banner.svg"),
                                                              SizedBox(
                                                                height:
                                                                ScreenUtil()
                                                                    .setSp(
                                                                    8),
                                                              ),
                                                              Text(
                                                                  "Upload Banner",
                                                                  style: GoogleFonts.nunitoSans(
                                                                      fontSize:
                                                                      ScreenUtil().setSp(
                                                                          12),
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                      color:
                                                                      lightGray)),
                                                              SizedBox(
                                                                height:
                                                                ScreenUtil()
                                                                    .setSp(
                                                                    1),
                                                              ),
                                                              Text(
                                                                  "(Upload Multiple Image for Scrolling)",
                                                                  style: GoogleFonts.nunitoSans(
                                                                      fontSize:
                                                                      ScreenUtil().setSp(
                                                                          10),
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                      color:
                                                                      lightGray)),
                                                            ],
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: Padding(
                                                              padding: EdgeInsets.only(
                                                                  right: ScreenUtil()
                                                                      .setSp(
                                                                      8),
                                                                  bottom: ScreenUtil()
                                                                      .setSp(
                                                                      8)),
                                                              child: Text(
                                                                  "Dimension 375width x 257 height",
                                                                  style: GoogleFonts.nunitoSans(
                                                                      fontSize:
                                                                      ScreenUtil().setSp(
                                                                          12),
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                      color:
                                                                      lightGray))),
                                                        )
                                                      ],
                                                    )),
                                              );
                                            } else {
                                              return InkWell(
                                                onTap: (){
                                                  showFullBannerDialog(context,"${upperProfileData!.agency!.bannerMedia![itemIndex]}",itemIndex);
                                                },
                                                child: Container(
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    decoration: BoxDecoration(
                                                        color:
                                                        appBackgroundColor),
                                                    child: Image.network(
                                                      "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${upperProfileData!.agency!.bannerMedia![itemIndex]}",
                                                      fit: BoxFit.contain,
                                                    )),
                                              );
                                            }
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
                                          : CarouselSlider.builder(
                                          itemCount: imageList.length,
                                          itemBuilder: (BuildContext context,
                                              int itemIndex,
                                              int pageViewIndex) {
                                            if (itemIndex ==
                                                imageList.length - 1) {
                                              return InkWell(
                                                onTap: () {
                                                  closeUp();
                                                },
                                                child: Container(
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    child: Stack(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .center,
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .min,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  "assets/icons/svg/upload_banner.svg"),
                                                              SizedBox(
                                                                height:
                                                                ScreenUtil()
                                                                    .setSp(
                                                                    8),
                                                              ),
                                                              Text(
                                                                  "Upload Banner",
                                                                  style: GoogleFonts.nunitoSans(
                                                                      fontSize:
                                                                      ScreenUtil().setSp(
                                                                          12),
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                      color:
                                                                      lightGray)),
                                                              SizedBox(
                                                                height:
                                                                ScreenUtil()
                                                                    .setSp(
                                                                    1),
                                                              ),
                                                              Text(
                                                                  "(Upload Multiple Image for Scrolling)",
                                                                  style: GoogleFonts.nunitoSans(
                                                                      fontSize:
                                                                      ScreenUtil().setSp(
                                                                          10),
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                      color:
                                                                      lightGray)),
                                                            ],
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: Padding(
                                                              padding: EdgeInsets.only(
                                                                  right: ScreenUtil()
                                                                      .setSp(
                                                                      8),
                                                                  bottom: ScreenUtil()
                                                                      .setSp(
                                                                      8)),
                                                              child: Text(
                                                                  "Dimension 375width x 257 height",
                                                                  style: GoogleFonts.nunitoSans(
                                                                      fontSize:
                                                                      ScreenUtil().setSp(
                                                                          12),
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                      color:
                                                                      lightGray))),
                                                        )
                                                      ],
                                                    )),
                                              );
                                            } else {
                                              return InkWell(
                                                onTap: () {
                                                  _cropImage(imageList[
                                                  itemIndex])
                                                      .then((value) async {
                                                    print(value!.path);
                                                    setState(() {
                                                      imageList.removeAt(
                                                          itemIndex);
                                                      imageList.insert(
                                                          itemIndex, value as File);
                                                    });
                                                  });
                                                },
                                                child: Container(
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    decoration: BoxDecoration(
                                                        color:
                                                        appBackgroundColor),
                                                    child: Image.file(
                                                      imageList[itemIndex]!,
                                                      fit: BoxFit.contain,
                                                    )),
                                              );
                                            }
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
                                          )),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Visibility(
                                          visible: upperProfileData != null &&
                                              upperProfileData!.agency != null &&
                                              upperProfileData!
                                                  .agency!.bannerMedia!.length >
                                                  0,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: ScreenUtil().setSp(10)),
                                            child: SmoothPageIndicator(
                                              controller: pageController,
                                              count: upperProfileData != null &&
                                                  upperProfileData!.agency !=
                                                      null &&
                                                  upperProfileData!
                                                      .agency!
                                                      .bannerMedia!
                                                      .length >
                                                      0
                                                  ? upperProfileData!
                                                  .agency!.bannerMedia!.length
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
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                  height: 1,
                                  color: lightGray,
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
                                            left: ScreenUtil().setWidth(110)),
                                        child: Wrap(
                                          crossAxisAlignment:
                                          WrapCrossAlignment.end,
                                          children: [
                                            ConstrainedBox(
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                  (ScreenUtil().screenWidth /
                                                      2) -
                                                      30),
                                              child: Text(
                                                  upperProfileData != null
                                                      ? "${upperProfileData!.name} (${upperProfileData!.district})"
                                                      : "",
                                                  style: GoogleFonts.nunitoSans(
                                                      fontSize:
                                                      ScreenUtil().setSp(16),
                                                      fontWeight: FontWeight.w700,
                                                      color: black)),
                                            ),
                                            SizedBox(
                                              width: ScreenUtil().setWidth(5),
                                            ),
                                            Visibility(
                                              child: SvgPicture.asset(
                                                  "assets/icons/svg/verified.svg"),
                                              visible: upperProfileData != null
                                                  ? upperProfileData!.isVerified!
                                                  : false,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(110)),
                                        child: Text(
                                            upperProfileData != null
                                                ? "${upperProfileData!.district}, ${upperProfileData!.state}, ${upperProfileData!.country}"
                                                : "",
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: ScreenUtil().setSp(10),
                                                fontWeight: FontWeight.w300,
                                                color: lightGray)),
                                      ),
                                      /*Align(
                                        alignment: Alignment.centerRight,
                                        child: SizedBox(
                                          height: ScreenUtil().setHeight(20),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                                    EdgeInsets.only(
                                                        left: 0, right: 0)),
                                                backgroundColor:
                                                    MaterialStateProperty.all<Color>(
                                                        darkGray),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(10)),
                                                        side: BorderSide(color: darkGray)))),
                                            child: Text(
                                              "Promote",
                                              style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize:
                                                      ScreenUtil().setSp(12),
                                                  color: white),
                                            ),
                                            onPressed: () async {
                                              print('ppppp');
                                              // var result =
                                              // await Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //       builder: (ontext) =>
                                              //           EditProfileScreen(
                                              //               upperProfileData)),
                                              // );
                                              // if (result != null &&
                                              //     result == true) {
                                              //   _profile();
                                              // }
                                            },
                                          ),
                                        ),
                                      ),*/
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
                                                  "Edit Profile",
                                                  style: GoogleFonts.nunitoSans(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize:
                                                      ScreenUtil().setSp(14),
                                                      color: lightRed),
                                                ),
                                                onPressed: () async {
                                                  print('ppppp');
                                                  var result =
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (ontext) =>
                                                            BrandEditProfileScreen(
                                                                upperProfileData!,
                                                                true)),
                                                  );
                                                  if (result != null &&
                                                      result == true) {
                                                    _profile();
                                                  }
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
                                                            top:
                                                            ScreenUtil().setSp(7),
                                                            bottom: ScreenUtil()
                                                                .setSp(7)),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
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
                                                              builder: (context) =>
                                                                  FollowerInfoScreen(isFollowing: true, id: upperProfileData!.id)),
                                                        );
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                            top:
                                                            ScreenUtil().setSp(7),
                                                            bottom: ScreenUtil()
                                                                .setSp(7)),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
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
                                            child: InkWell(
                                              onTap: () {
                                                showReferralCodeDialog(false);
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: ScreenUtil().setSp(5)),
                                                child: Text(upperProfileData!
                                                    .username!,
                                                    style: GoogleFonts.nunitoSans(
                                                        fontSize: ScreenUtil()
                                                            .setSp(14),
                                                        fontWeight:
                                                        FontWeight.w400,
                                                        fontStyle:
                                                        FontStyle.italic,
                                                        color: buttonBlue)),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Constants.fameCoins = upperProfileData!.fameCoins!;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FameCoinsScreen(upperProfileData!.fameCoins!)),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Image.asset("assets/icons/coin.png"),
                                                SizedBox(
                                                  width: ScreenUtil().setSp(5),
                                                ),
                                                Text(
                                                    "${NumberFormat.compactCurrency(
                                                      decimalDigits: 0,
                                                      symbol:
                                                      '', // if you want to add currency symbol then pass that in this else leave it empty.
                                                    ).format(upperProfileData != null && upperProfileData!.fameCoins != null ? upperProfileData!.fameCoins : 0)}",
                                                    style: GoogleFonts.nunitoSans(
                                                        fontSize:
                                                        ScreenUtil().setSp(12),
                                                        fontWeight: FontWeight.w400,
                                                        color: darkGray)),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  // Text("10",
                                                  //     style: GoogleFonts.nunitoSans(
                                                  //         fontSize:
                                                  //             ScreenUtil().setSp(14),
                                                  //         fontWeight: FontWeight.w400,
                                                  //         color: darkGray)),
                                                  // SizedBox(
                                                  //   width: ScreenUtil().setSp(5),
                                                  // ),
                                                  // SvgPicture.asset(
                                                  //     "assets/icons/svg/live.svg",
                                                  //     color: buttonBlue),
                                                ],
                                              ))
                                        ],
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setSp(9),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text.rich(TextSpan(children: <TextSpan>[
                                              TextSpan(
                                                  text: "About Us: ",
                                                  style: GoogleFonts.nunitoSans(
                                                      fontSize: ScreenUtil().setSp(16),
                                                      fontWeight: FontWeight.w700,
                                                      color: black)),
                                              upperProfileData != null &&
                                                  upperProfileData!.profession !=
                                                      null
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
                                          SizedBox(
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
                                                "${NumberFormat.compactCurrency(
                                                  decimalDigits: 0,
                                                  symbol:
                                                  '', // if you want to add currency symbol then pass that in this else leave it empty.
                                                ).format(upperProfileData != null && upperProfileData!.recommendationCount != null ? upperProfileData!.recommendationCount : 0)} Recommends",
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize:
                                                    ScreenUtil().setSp(12),
                                                    color: darkGray),
                                              ),
                                              onPressed: () async {
                                                print('ppppp');
                                                var result =
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (ontext) =>
                                                          RecomamendationScreen(name: upperProfileData != null
                                                              ? "${upperProfileData!.name} (${upperProfileData!.district})"
                                                              : "",agencyId: upperProfileData!.id!,recommendationCount: upperProfileData!.recommendationCount!)),
                                                );
                                                // if (result != null &&
                                                //     result == true) {
                                                //   _profile();
                                                // }
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // showAlertDialog(context,
                                          //     '${upperProfileData != null ? upperProfileData.bio : ""}');
                                        },
                                        child: Container(
                                          child: ReadMoreText(
                                            '${upperProfileData != null && upperProfileData!.bio != null ? upperProfileData!.bio : ""}',
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
                                        visible: upperProfileData!=null && upperProfileData!.agency != null?upperProfileData!.agency!.websiteUrl!.isNotEmpty:false,
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
                                                  upperProfileData!=null?upperProfileData!.agency!.websiteUrl!:"",
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
                                            top: ScreenUtil().setHeight(6)),
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
                                  top: ScreenUtil().setSp(124),
                                  left: ScreenUtil().setSp(17)),
                              child: InkWell(
                                onTap: () {
                                  showFullProfileDialog(context);
                                },
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: profileImageFile != null
                                      ? CircleAvatar(
                                    backgroundColor: white,
                                    radius: ScreenUtil().radius(50),
                                    child: CircleAvatar(
                                      backgroundColor: white,
                                      radius: ScreenUtil().radius(49),
                                      backgroundImage:
                                      FileImage(profileImageFile!),
                                    ),
                                  )
                                      : upperProfileData != null &&
                                      upperProfileData!.profileImage !=
                                          null
                                      ? CircleAvatar(
                                    backgroundColor: white,
                                    radius: ScreenUtil().radius(50),
                                    child: CircleAvatar(
                                      backgroundColor: white,
                                      radius: ScreenUtil().radius(49),
                                      backgroundImage: NetworkImage(
                                          "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${upperProfileData!.profileImage}"),
                                    ),
                                  )
                                      : CircleAvatar(
                                    backgroundColor: white,
                                    radius: ScreenUtil().radius(49),
                                  ),
                                ),
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
                          icon: SvgPicture.asset("assets/icons/svg/collaborate.svg",
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
                      builder: (ontext) => FullPostScreen(myFameResult, index,
                          agencyPage, "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}", true)),
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

  void showAddPostDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.only(
                  left: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - 213) / 2),
                  right: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - 213) / 2)),
              child: StatefulBuilder(
                  builder: (BuildContext context3, StateSetter setStates) {
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
                                'Create Post',
                                style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(16),
                                    color: white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setSp(20),
                          ),
                          InkWell(
                            onTap: () async{
                              Navigator.pop(context);
                              if ((Constants.verificationStatus == "Submitted" || Constants.verificationStatus == "Verified") &&
                                  Constants.todayPosts == 0) {
                                final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UploadScreenOne()));
                                if (result != null) {
                                  Map map = result;
                                  FormData formData = FormData
                                      .fromMap({
                                    "challengeId": map['challengeId'],
                                    "description": map['description'],
                                    "closeUp": map['closeUp'],
                                    "medium": map['medium'],
                                    "long": map['long'],
                                    "pose1": map['pose1'],
                                    "pose2": map['pose2'],
                                    "additional": map['additional'],
                                  });
                                  if(map['video'] != null){
                                    var snackBar = SnackBar(
                                      content: Text('Compressing'),
                                    );
                                    ScaffoldMessenger.of(
                                        context).showSnackBar(
                                        snackBar);
                                    final MediaInfo? info = await VideoCompress
                                        .compressVideo(
                                      map['video'],
                                      quality: VideoQuality.HighestQuality,
                                      deleteOrigin: false,
                                      includeAudio: true,
                                    );
                                    await MultipartFile.fromFile(info!.path!,
                                        filename: "${File(map['video']).path
                                            .split('/')
                                            .last}").then((value) async {
                                      formData.files.addAll([
                                        MapEntry("video", value),
                                      ]);
                                      Api.uploadPost.call(context,
                                          method: "media/contest",
                                          param: formData,
                                          onResponseSuccess: (
                                              Map object) {
                                            Constants.todayPosts = 1;
                                            var snackBar = SnackBar(
                                              content: Text('Uploaded'),
                                            );
                                            ScaffoldMessenger.of(
                                                context).showSnackBar(
                                                snackBar);
                                          }, onRetry: (String message) {  }, onProgress: (double percentage) {  }, isLoading: false);
                                    });
                                  }else{
                                    Api.uploadPost.call(context,
                                        method: "media/contest",
                                        param: formData,
                                        onResponseSuccess: (
                                            Map object) {
                                          Constants.todayPosts = 1;
                                          var snackBar = SnackBar(
                                            content: Text('Uploaded'),
                                          );
                                          ScaffoldMessenger.of(
                                              context).showSnackBar(
                                              snackBar);
                                        }, onRetry: (String message) {  }, onProgress: (double percentage) {  }, isLoading: false);
                                  }
                                }
                              } else if (Constants.todayPosts >= 1) {
                                showPerDayPostDialog();
                              } else {
                                showProfileVerifyDialog();
                              }
                            },
                            child: Padding(
                                padding: EdgeInsets.only(top: ScreenUtil()
                                    .setSp(12), bottom: ScreenUtil().setSp(12)),
                                child: Text("FameLinks", style: GoogleFonts
                                    .nunitoSans(fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(14),
                                    color: darkGray))),
                          ),
                          SizedBox(
                            width: ScreenUtil().setSp(46),
                            child: Divider(
                              height: ScreenUtil().setSp(1),
                              thickness: ScreenUtil().setSp(1),
                              color: lightGray,
                            ),
                          ),
                          InkWell(
                            onTap: () async{
                              Navigator.pop(context);
                              final result =
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder:
                                          (context) =>
                                          FunLinkUploadScreenOne()));
                              if (result != null) {
                                var snackBar = SnackBar(
                                  content: Text('Compressing'),
                                );
                                ScaffoldMessenger.of(
                                    context).showSnackBar(
                                    snackBar);
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
                                final MediaInfo? info = await VideoCompress
                                    .compressVideo(
                                  map['video'],
                                  quality: VideoQuality.HighestQuality,
                                  deleteOrigin: false,
                                  includeAudio: true,
                                );
                                await MultipartFile.fromFile(info!.path!,
                                    filename: "${File(map['video']).path
                                        .split('/')
                                        .last}").then((value) async {
                                  formData.files.addAll([
                                    MapEntry("video", value),
                                  ]);
                                  Api.uploadPost.call(context,
                                      method: "media/funlinks",
                                      param: formData,
                                      onResponseSuccess: (
                                          Map object) {
                                        var snackBar = SnackBar(
                                          content: Text('Uploaded'),
                                        );
                                        ScaffoldMessenger.of(
                                            context).showSnackBar(
                                            snackBar);
                                        funLinksPage = 1;
                                        myFunlinksResult.clear();
                                        _myFunlinks();
                                      }, onRetry: (String message) {  }, onProgress: (double percentage) {  }, isLoading: false);
                                });
                              }
                            },
                            child: Padding(
                                padding: EdgeInsets.only(top: ScreenUtil()
                                    .setSp(12), bottom: ScreenUtil().setSp(12)),
                                child: Text("FunLinks", style: GoogleFonts
                                    .nunitoSans(fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(14),
                                    color: darkGray))),
                          ),
                          SizedBox(
                            width: ScreenUtil().setSp(46),
                            child: Divider(
                              height: ScreenUtil().setSp(1),
                              thickness: ScreenUtil().setSp(1),
                              color: lightGray,
                            ),
                          ),
                          InkWell(
                            onTap: () async{
                              Navigator.pop(context);
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FollowLinkUploadScreen()));
                              if (result != null) {
                                Map map = result;
                                FormData formData = FormData.fromMap({
                                  "challenges": map['challenges'],
                                  "description": map['description'],
                                });
                                for (int i = 0; i <
                                    (map.length - 2); i++) {
                                  formData.files.addAll([
                                    MapEntry("media",
                                        await map['media${i
                                            .toString()}']),
                                  ]);
                                }
                                Api.uploadPost.call(context,
                                    method: "media/followlinks",
                                    param: formData,
                                    isLoading: false,
                                    onResponseSuccess: (Map object) {
                                      var snackBar = SnackBar(
                                        content: Text('Uploaded'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      followLinksPage = 1;
                                      myFollowResult.clear();
                                      _myFollowLinks();
                                    }, onRetry: (String message) {  }, onProgress: (double percentage) {  });
                              }
                            },
                            child: Padding(
                                padding: EdgeInsets.only(top: ScreenUtil()
                                    .setSp(12), bottom: ScreenUtil().setSp(12)),
                                child: Text("FollowLinks", style: GoogleFonts
                                    .nunitoSans(fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(14),
                                    color: darkGray))),
                          ),
                          SizedBox(
                            height: ScreenUtil().setSp(20),
                          ),
                        ],
                      ),
                    );
                  }));
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
                                      text: 'FameLinks is a Contest. As per the rules, you can upload only ',
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
                                      text:
                                      ' in FameLinks.',
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
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Text(
                                          'Got it',
                                          style: GoogleFonts.nunitoSans(
                                              color: white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(
                                                  14)),
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
              builder: (context) =>
                  ProfileVideoVerificationScreen()),
        );
        if (result != null) {
          if (result == true) {
            final result2 = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        UploadScreenOne()));
            if (result2 != null) {
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
              Api.uploadPost.call(context,
                  method: "media/contest",
                  param: formData,
                  onResponseSuccess: (Map object) {
                    var snackBar = SnackBar(
                      content: Text('Uploaded'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }, onRetry: (String message) {  }, onProgress: (double percentage) {  }, isLoading: false);
            }
          }
        }
      } else {
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context2) =>
                    UploadScreenOne()));
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
          Api.uploadPost.call(context,
              method: "media/contest",
              param: formData,
              onResponseSuccess: (Map object) {
                var snackBar = SnackBar(
                  content: Text('Uploaded'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }, onRetry: (String message) {  }, onProgress: (double percentage) {  }, isLoading: false);
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
                                ageGroup == "groupA" ||
                                    ageGroup == "groupB" ||
                                    ageGroup == "groupC" ? Text.rich(
                                    TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: 'To be able to',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize: ScreenUtil().setSp(
                                                  14))),
                                      TextSpan(
                                          text: ' Upload Posts',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(
                                                  14),
                                              color: black)),
                                      TextSpan(
                                          text: ' or ',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize: ScreenUtil().setSp(
                                                  14))),
                                      TextSpan(
                                          text: 'Participate in Contests',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(
                                                  14),
                                              color: black)),
                                      TextSpan(
                                          text:
                                          ' on FameLinks App, you are required to verify your profile.',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize: ScreenUtil().setSp(
                                                  14))),
                                    ])) : Text.rich(
                                    TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: 'To be able to ',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize: ScreenUtil().setSp(
                                                  14))),
                                      TextSpan(
                                          text: 'Participate in Contests',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(
                                                  14),
                                              color: black)),
                                      TextSpan(
                                          text:
                                          ' on FameLinks App, you are required to verify your profile.',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize: ScreenUtil().setSp(
                                                  14))),
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
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Text(
                                          'Verify',
                                          style: GoogleFonts.nunitoSans(
                                              color: white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(
                                                  14)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                ageGroup == "groupA" ||
                                    ageGroup == "groupB" ||
                                    ageGroup == "groupC"
                                    ? Text(
                                    'You can still see Posts and browse the App if you skip this important step',
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w300,
                                        color: black,
                                        fontStyle: FontStyle.italic,
                                        fontSize: ScreenUtil().setSp(12)))
                                    : Text.rich(TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: 'Your posts can still be seen in ',
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w300,
                                          color: black,
                                          fontStyle: FontStyle.italic,
                                          fontSize: ScreenUtil().setSp(12))),
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
                                          fontSize: ScreenUtil().setSp(12))),
                                ])),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                      onTap: () async {
                                        print("AGEE:::$ageGroup");
                                        if (ageGroup == "groupA" ||
                                            ageGroup == "groupB" ||
                                            ageGroup == "groupC") {
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
                                                fontSize: ScreenUtil().setSp(
                                                    10))),
                                      ),
                                    ))
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
        final result3 = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProfileVideoVerificationScreen()),
        );
        if (result3 != null) {
          var snackBar = SnackBar(
            content: Text('Compressing'),
          );
          ScaffoldMessenger.of(
              context).showSnackBar(
              snackBar);
          Constants.verificationStatus = "Submitted";
          final MediaInfo? info =
          await VideoCompress.compressVideo(
            result3,
            quality: VideoQuality.MediumQuality,
            deleteOrigin: false,
            includeAudio: true,
          );
          Constants.video = await MultipartFile.fromFile(
              info!.path!,
              filename:
              "${File(result3).path.split('/').last}");
          var formData = FormData.fromMap({
            "video": Constants.video,
          });
          Api.uploadPost.call(context,
              method: "users/profile/verify",
              param: formData,
              onResponseSuccess: (Map object) {
                var snackBar = SnackBar(
                  content: Text('Uploaded'),
                );
                ScaffoldMessenger.of(
                    context).showSnackBar(
                    snackBar);
              }, onRetry: (String message) {  }, onProgress: (double percentage) {  }, isLoading: false);
        }
      } else {
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context2) =>
                    UploadScreenOne()));
        if (result != null) {
          Map map = result;
          FormData formData = FormData
              .fromMap({
            "challengeId": map['challengeId'],
            "description": map['description'],
            "closeUp": map['closeUp'],
            "medium": map['medium'],
            "long": map['long'],
            "pose1": map['pose1'],
            "pose2": map['pose2'],
            "additional": map['additional'],
          });
          if(map['video'] != null){
            var snackBar = SnackBar(
              content: Text('Compressing'),
            );
            ScaffoldMessenger.of(
                context).showSnackBar(
                snackBar);
            final MediaInfo? info = await VideoCompress
                .compressVideo(
              map['video'],
              quality: VideoQuality.HighestQuality,
              deleteOrigin: false,
              includeAudio: true,
            );
            await MultipartFile.fromFile(info!.path!,
                filename: "${File(map['video']).path
                    .split('/')
                    .last}").then((value) async {
              formData.files.addAll([
                MapEntry("video", value),
              ]);
              Api.uploadPost.call(context,
                  method: "media/contest",
                  param: formData,
                  onResponseSuccess: (
                      Map object) {
                    Constants.todayPosts = 1;
                    var snackBar = SnackBar(
                      content: Text('Uploaded'),
                    );
                    ScaffoldMessenger.of(
                        context).showSnackBar(
                        snackBar);
                  }, onRetry: (String message) {  }, onProgress: (double percentage) {  }, isLoading: false);
            });
          }else{
            Api.uploadPost.call(context,
                method: "media/contest",
                param: formData,
                onResponseSuccess: (
                    Map object) {
                  Constants.todayPosts = 1;
                  var snackBar = SnackBar(
                    content: Text('Uploaded'),
                  );
                  ScaffoldMessenger.of(
                      context).showSnackBar(
                      snackBar);
                }, onRetry: (String message) {  }, onProgress: (double percentage) {  }, isLoading: false);
          }
        }
      }
    }
  }

  Future<String> refresh() async{
    _profile();
    _myFamelinks();
    _myFunlinks();
    _myFollowLinks();
    return 'success';
  }

  _profile() async {
    Api.get.call(context, method: "users/me", param: {},
        onResponseSuccess: (Map object) async {
          var result = ProfileResponse.fromJson(object as Map<String, dynamic>);
          upperProfileData = result.result;
          ageGroup = upperProfileData!.ageGroup!;
          Constants.fameCoins = upperProfileData!.fameCoins!;
          Constants.verificationStatus = upperProfileData!.verificationStatus!;
          if (upperProfileData?.agency?.bannerMedia != null &&
              upperProfileData!.agency!.bannerMedia!.length < 5) {
            upperProfileData?.agency?.bannerMedia?.add("");
          }
          print('RESPONSE ${result.result}');
          setState(() {});
        }, onProgress: (double percentage) {  }, isLoading: false, contentType: '');
  }

  _myFamelinks() async {
    Map<String, dynamic> map = {"page": agencyPage.toString()};
    Api.get.call(context, method: "media/famelinks/$userId", param: map,isLoading: false,
        onResponseSuccess: (Map object) async {
          var result = FamelinksResponse.fromJson(object  as Map<String, dynamic>);
          if (result.result!.length > 0) {
            myFameResult.addAll(result.result!);
            setState(() {});
          } else {
            agencyPage == 1 ? agencyPage :agencyPage--;
          }
        }, onProgress: (double percentage) {  }, contentType: '');
  }

  _myFunlinks() async {
    Map<String, dynamic> map = {"page": funLinksPage.toString()};
    Api.get.call(context, method: "media/funlinks/me", param: map,isLoading: false,
        onResponseSuccess: (Map object) async {
          var result = MyFunLinksResponse.fromJson(object  as Map<String, dynamic>);
          if (result.result!.length > 0) {
            myFunlinksResult.addAll(result.result!);
            setState(() {});
            print('RESPONSE ${result.result.toString()}');
          } else {
            funLinksPage == 1 ? funLinksPage : funLinksPage--;
          }
        }, onProgress: (double percentage) {  }, contentType: '');
  }

  _myFollowLinks() async {
    Map<String, dynamic> map = {"page": followLinksPage.toString()};
    Api.get.call(context, method: "media/followlinks/$userId", param: map,isLoading: false,
        onResponseSuccess: (Map object) async {
          var result = FamelinksResponse.fromJson(object  as Map<String, dynamic>);
          if (result.result!.length > 0) {
            myFollowResult.addAll(result.result!);
            setState(() {});
            print('RESPONSE ${result.result.toString()}');
          } else {
            followLinksPage == 1 ? followLinksPage : followLinksPage--;
          }
        }, onProgress: (double percentage) {  }, contentType: '');
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
                            builder: (context) => NotificationSettingsScreen(
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
                      var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ontext) =>
                                ProfileVideoVerificationScreen()),
                      );
                      if(result != null){
                        var snackBar = SnackBar(
                          content: Text('Compressing'),
                        );
                        ScaffoldMessenger.of(
                            context).showSnackBar(
                            snackBar);
                        Constants.verificationStatus = "Submitted";
                        final MediaInfo? info =
                        await VideoCompress.compressVideo(
                          result,
                          quality: VideoQuality.MediumQuality,
                          deleteOrigin: false,
                          includeAudio: true,
                        );
                        Constants.video = await MultipartFile.fromFile(
                            info!.path!,
                            filename:
                            "${File(result).path.split('/').last}");
                        var formData = FormData.fromMap({
                          "video": Constants.video,
                        });
                        Api.uploadPost.call(context,
                            method: "users/profile/verify",
                            param: formData,
                            onResponseSuccess: (Map object) {
                              var snackBar = SnackBar(
                                content: Text('Uploaded'),
                              );
                              ScaffoldMessenger.of(
                                  context).showSnackBar(
                                  snackBar);
                            }, onRetry: (String message) {  }, onProgress: (double percentage) {  }, isLoading: false);
                      }
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
                    height: ScreenUtil().setHeight(12),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ontext) =>
                                WebViewScreen("Community Guidelines")),
                      );
                    },
                    child: Row(
                      children: [
                        MyBullet(),
                        SizedBox(
                          width: ScreenUtil().setWidth(8),
                        ),
                        Text(
                          'Community Guidelines',
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
                        upperProfileData?.email = emailController.text;
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
          var result = LoginResponse.fromJson(object as Map<String, dynamic>);
          this.otpHash = result.result!.otpHash!;
          setStates(() {
            isOTPLogin = true;
          });
          startTimer();
        }, onRetry: (String message) {  }, onProgress: (double percentage) {  }, isLoading: false);
  }

  _emailLoginService(StateSetter setStates) async {
    Map<String, dynamic> map = {"email": emailController.text};
    Api.post.call(context, method: "users/email", param: map,
        onResponseSuccess: (Map object) async {
          var result = LoginResponse.fromJson(object as Map<String, dynamic>);
          this.otpHash = result.result!.otpHash!;
          setStates(() {
            isOTPEmailLogin = true;
          });
          startTimer();
        }, onRetry: (String message) {  }, onProgress: (double percentage) {  }, isLoading: false);
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
            var result = RegisterResponse.fromJson(object as Map<String, dynamic>);
            isOTPLogin = false;
            Navigator.pop(context);
            Constants.toastMessage(msg: result.message!);
          }, onRetry: (String message) {  }, onProgress: (double percentage) {  }, isLoading: false);
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
            var result = RegisterResponse.fromJson(object as Map<String, dynamic>);
            isOTPEmailLogin = false;
            Navigator.pop(context);
            Constants.toastMessage(msg: result.message!);
          }, onRetry: (String message) {  }, onProgress: (double percentage) {  }, isLoading: false);
    }
  }

  void startTimer() {
    if (isOTPLogin) {
      if (_timer != null) {
        _timer?.cancel();
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
                                              "users/check/username/$text",
                                              param: {},
                                              isLoading: false, onResponseSuccess:
                                                  (Map object) async {
                                                var result =
                                                UsernameCheckModel.fromJson(object as Map<String, dynamic>);
                                                isUserNameAvialble =
                                                    result.result!.isAvailable;
                                                setStates(() {});
                                              }, onProgress: (double percentage) {  }, contentType: '');
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
                                                              object as Map<String, dynamic>);
                                                          Navigator.pop(context);
                                                          if (isShare) {
                                                            Share.share(
                                                              '${ApiProvider.shareUrl}${upperProfileData!.username}',
                                                            );
                                                          }
                                                        }, onRetry: (String message) {  }, onProgress: (double percentage) {  }, isLoading: false);
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
                                                              object as Map<String, dynamic>);
                                                          Navigator.pop(context);
                                                          if (isShare) {
                                                            Share.share(
                                                              '${ApiProvider.shareUrl}${upperProfileData!.username}',
                                                            );
                                                          }
                                                        }, onRetry: (String message) {  }, onProgress: (double percentage) {  }, isLoading: false);
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
                              image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image:NetworkImage(
                                      '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${upperProfileData!.profileImage}')))
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

  void showFullBannerDialog(BuildContext buildContext, String bannerImg, int itemIndex) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.only(
                  top: ScreenUtil().setSp((ScreenUtil().screenHeight / 2)-ScreenUtil().setSp(130)),
                  bottom:
                  ScreenUtil().setSp((ScreenUtil().screenHeight / 2)-ScreenUtil().setSp(130)),
                  left: ScreenUtil().setWidth(26),
                  right: ScreenUtil().setWidth(26)),
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setStates) {
                    return Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: ScreenUtil().setSp(25)),
                          decoration:BoxDecoration(
                              color: Colors.white,
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
                                  fit: BoxFit.contain,
                                  image: NetworkImage(
                                      "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/$bannerImg"))),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding:
                            EdgeInsets.only(right: ScreenUtil().setWidth(23)),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Api.delete.call(context,
                                    method: "users/agency/banner/$bannerImg",isLoading: false,
                                    param: {}, onResponseSuccess:
                                        (Map object) async {
                                      setState(() {
                                        upperProfileData!.agency!.bannerMedia!.removeAt(itemIndex);
                                      });
                                    }, onRetry: (String message) {  }, onProgress: (double percentage) {  });
                              },
                              child: CircleAvatar(
                                radius: ScreenUtil().setSp(25),
                                backgroundColor: lightGray,
                                child: CircleAvatar(
                                  radius: ScreenUtil().setSp(24),
                                  backgroundColor: white,
                                  child: Icon(
                                    Icons.delete,
                                    color: lightGray,
                                    size: ScreenUtil().radius(20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        /*Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(23)),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                closeUp();
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
                        ),*/
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
          var result = LikesResponse.fromJson(object as Map<String, dynamic>);
          Constants.toastMessage(msg: result.message);
        }, onRetry: (String message) {  }, onProgress: (double percentage) {  }, isLoading: false);
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
                              profileImageFile = value as File?;
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
                            profileImageFile = value as File?;
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
      // androidUiSettings: AndroidUiSettings(
      //     toolbarTitle: 'Cropper',
      //     toolbarColor: Colors.deepOrange,
      //     toolbarWidgetColor: Colors.white,
      //     initAspectRatio: CropAspectRatioPreset.original,
      //     lockAspectRatio: false),
      // iosUiSettings: IOSUiSettings(
      //   title: 'Cropper',
      // )
    );
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
                            // print(value.path);
                            FormData formData = FormData.fromMap({});
                            formData.files.addAll([
                              MapEntry(
                                  "media",
                                  await MultipartFile.fromFile(
                                      value!.path)),
                            ]);

                            Api.uploadPost.call(context,
                                method: "users/agency/banner/upload",
                                param: formData, onResponseSuccess: (Map object) {
                                  var snackBar = SnackBar(
                                    content: Text('Uploaded'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  _profile();
                                }, onRetry: (String message) {  }, onProgress: (double percentage) {  }, isLoading: false);
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
                          1 + upperProfileData!.agency!.bannerMedia!.length;
                      if (count <= 6) {
                        File closeUpImageFile = File(image.path);
                        _cropImage(closeUpImageFile).then((value) async {
                          // print(value.path);
                          FormData formData = FormData.fromMap({});
                          formData.files.addAll([
                            MapEntry("media",
                                await MultipartFile.fromFile(value!.path)),
                          ]);

                          Api.uploadPost.call(context,
                              method: "users/agency/banner/upload",
                              param: formData, onResponseSuccess: (Map object) {
                                var snackBar = SnackBar(
                                  content: Text('Uploaded'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                _profile();
                              }, onRetry: (String message) {  }, onProgress: (double percentage) {  }, isLoading: false);
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
      aspectRatio: CropAspectRatio(ratioX: 2.15, ratioY: 1),
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
      // androidUiSettings: AndroidUiSettings(
      //     toolbarTitle: 'Cropper',
      //     toolbarColor: Colors.deepOrange,
      //     toolbarWidgetColor: Colors.white,
      //     initAspectRatio: CropAspectRatioPreset.original,
      //     lockAspectRatio: false),
      // iosUiSettings: IOSUiSettings(
      //   minimumAspectRatio: 1.0,
      //   title: 'Cropper',
      // )
    );
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
