import 'package:famelink/common/common_image.dart';
import 'package:famelink/ui/Famelinkprofile/ProfileFameLink.dart';
import 'package:famelink/ui/profile_UI/PhotoImageScreen.dart';
import 'package:famelink/ui/startTour/open_tour_screen.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/common_textformfield.dart';

enum RegistrationType { FAMELinks, JOBLinks, FUNLinks, FOLLOWLinks, STORELinks }

class TourFollowLink extends StatefulWidget {
  @override
  State<TourFollowLink> createState() => _TourFollowLinkState();
}

class _TourFollowLinkState extends State<TourFollowLink> {
  SharedPreferences? prefs;

  Key key = UniqueKey();
  static bool isDarkMode = true;
  static String selectRegistration = RegistrationType.FAMELinks.toString();
  String selectDistrict = "_";
  String selectState = "_";
  String selectCountry = "_";
  String selectGender = "_";
  static String? selectedDob;
  final TextEditingController nameController = TextEditingController();
  String selectDateOfBirth = '_';
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    prefs = await SharedPreferences.getInstance();
    // selectDateOfBirth = selectedDob;
    if (prefs!.getString('mode').toString() == 'dark') {
      setState(() {
        isDartMode = true;
      });
    } else {
      setState(() {
        isDartMode = false;
      });
    }
  }

  int selectPhase = 0;
  bool isDartMode = true;
  static String selectType = "Individual";
  bool status1 = false;
  bool selected = false;
  bool selectedFameLinks = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
      statusBarIconBrightness: Brightness.light, // status bar icons' color
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return KeyedSubtree(
      key: key,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          padding: EdgeInsets.only(top: 30.h),
          height: MediaQuery.of(context).size.height,
          decoration: (isDarkMode == true)
              ? BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(CommonImage.dart_back_img),
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                  ),
                )
              : BoxDecoration(color: HexColor("#FDFCFA")),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: (ScreenUtil().screenHeight * 0.06).ceilToDouble(),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: "Know ",
                              style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: (isDarkMode == true)
                                    ? Colors.white
                                    : HexColor("#030C23"),
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0, 2),
                                    blurRadius: 2,
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                  ),
                                ],
                                fontSize: 26.sp,
                              ),
                            ),
                            TextSpan(
                              text: "FAMELINKS",
                              style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 26.sp,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0, 2),
                                    blurRadius: 2,
                                    color:
                                        HexColor("#FF5C28").withOpacity(0.25),
                                  )
                                ],
                                color: HexColor("#FF5C28"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: "Follow",
                              style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: HexColor("FF5C28"),
                                fontSize: 16.sp,
                                shadows: [
                                  Shadow(
                                      color:
                                          Color(0xff000000).withOpacity(0.25),
                                      offset: Offset(0, 2),
                                      blurRadius: 2)
                                ],
                              ),
                            ),
                            TextSpan(
                              text: "Links",
                              style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 16.sp,
                                color: (isDarkMode == true)
                                    ? HexColor("#FFFFFF")
                                    : HexColor("#030C23"),
                                shadows: [
                                  Shadow(
                                      color:
                                          Color(0xff000000).withOpacity(0.25),
                                      offset: Offset(0, 2),
                                      blurRadius: 2)
                                ],
                              ),
                            ),
                            TextSpan(
                              text: "->",
                              style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w700,
                                shadows: [
                                  Shadow(
                                      color:
                                          Color(0xff000000).withOpacity(0.25),
                                      offset: Offset(0, 2),
                                      blurRadius: 2)
                                ],
                                fontStyle: FontStyle.normal,
                                fontSize: 16.sp,
                                color: (isDarkMode == true)
                                    ? HexColor("#FFFFFF")
                                    : HexColor("#030C23"),
                              ),
                            ),
                            TextSpan(
                              text: " what is your secret",
                              style: GoogleFonts.nunitoSans(
                                fontStyle: FontStyle.normal,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                shadows: [
                                  Shadow(
                                      color:
                                          Color(0xff000000).withOpacity(0.25),
                                      offset: Offset(0, 2),
                                      blurRadius: 2)
                                ],
                                color: (isDarkMode == true)
                                    ? HexColor("#FFFFFF")
                                    : HexColor("#030C23"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 95.11,
                        height: 85,
                        child: Image.asset(
                          CommonImage.darkFollowLinksPotionIcon,
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Stack(
                    //overflow: Overflow.visible,
                    fit: StackFit.loose,
                    children: <Widget>[
                      // upper shape
                      Container(
                        height:
                            (ScreenUtil().screenHeight * 0.410).ceilToDouble(),
                        width: (ScreenUtil().screenWidth).ceilToDouble(),
                        child: Text('  '),
                      ),
                      Positioned(
                        bottom: (ScreenUtil().screenHeight * 0.260)
                            .ceilToDouble(), //0.220
                        right: (ScreenUtil().screenWidth / 4.0).ceilToDouble(),
                        child: Container(
                          padding: EdgeInsets.only(right: 20.0),
                          height:
                              (ScreenUtil().screenHeight * 0.26).ceilToDouble(),
                          width:
                              (ScreenUtil().screenWidth * 0.60).ceilToDouble(),
                          margin: EdgeInsets.only(right: 24.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: (isDarkMode == false)
                                  ? AssetImage(
                                      CommonImage.lightFollowLinksTopShape)
                                  : AssetImage(
                                      CommonImage.darkFollowLinksTopShape),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              top: 16.0,
                              bottom: 16.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 28.0, left: 10.0),
                                  child: Text(
                                      "Your Followers see all your posts from all the other channels",
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        shadows: [
                                          Shadow(
                                              color: Color(0xff000000)
                                                  .withOpacity(0.25),
                                              offset: Offset(0, 2),
                                              blurRadius: 2)
                                        ],
                                        color: (isDarkMode == true)
                                            ? white
                                            : HexColor('#030C23'),
                                      )),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/images/homefollow.svg',
                                          color: orange),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          'FameLinks',
                                          style: GoogleFonts.nunitoSans(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: (isDarkMode == true)
                                                ? HexColor('#FFFFFF')
                                                : HexColor('#030C23'),
                                            shadows: [
                                              Shadow(
                                                  color: Color(0xff000000)
                                                      .withOpacity(0.25),
                                                  offset: Offset(0, 2),
                                                  blurRadius: 2)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/images/homefollow.svg',
                                          color: orange),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          'FunLinks',
                                          style: GoogleFonts.nunitoSans(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: (isDarkMode == true)
                                                ? HexColor('#FFFFFF')
                                                : HexColor('#030C23'),
                                            shadows: [
                                              Shadow(
                                                  color: Color(0xff000000)
                                                      .withOpacity(0.25),
                                                  offset: Offset(0, 2),
                                                  blurRadius: 2)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/images/homefollow.svg',
                                          color: orange),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          'FollowLinks',
                                          style: GoogleFonts.nunitoSans(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: (isDarkMode == true)
                                                ? HexColor('#FFFFFF')
                                                : HexColor('#030C23'),
                                            shadows: [
                                              Shadow(
                                                  color: Color(0xff000000)
                                                      .withOpacity(0.25),
                                                  offset: Offset(0, 2),
                                                  blurRadius: 2)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: (ScreenUtil().screenHeight * 0.225)
                              .ceilToDouble(),
                          right: (ScreenUtil().screenWidth / 2).ceilToDouble(),
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Follow",
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    color: HexColor("FF5C28"),
                                    fontSize: 16.sp,
                                    shadows: [
                                      Shadow(
                                          color: Color(0xff000000)
                                              .withOpacity(0.25),
                                          offset: Offset(0, 2),
                                          blurRadius: 2)
                                    ],
                                  ),
                                ),
                                TextSpan(
                                  text: "Links",
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.sp,
                                    shadows: [
                                      Shadow(
                                          color: Color(0xff000000)
                                              .withOpacity(0.25),
                                          offset: Offset(0, 2),
                                          blurRadius: 2)
                                    ],
                                    color: (isDarkMode == true)
                                        ? HexColor("#FFFFFF")
                                        : HexColor("#030C23"),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      // down Shape

                      Container(
                        height: 380, //250
                        width: 250,
                        child: Stack(
                          //clipBehavior: Clip.antiAlias,
                          //overflow: Overflow.visible,
                          fit: StackFit.loose,
                          //fit: StackFit.expand,
                          children: [
                            Positioned(
                              top: 190,
                              right: -30,
                              child: (isDarkMode == true)
                                  ? SizedBox(
                                      height: 250,
                                      width: 250,
                                      child: Image.asset(CommonImage
                                          .darkFollowLinksBottomShape))
                                  : SizedBox(
                                      height: 250,
                                      width: 250,
                                      child: Image.asset(CommonImage
                                          .lightFollowLinksBottomShape)),
                            ),
                            Positioned(
                              top: 220.h,
                              right: 140.w,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 15),
                                child: Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.circle_fill,
                                      color: (isDarkMode == true)
                                          ? HexColor('#FFFFFF')
                                          : HexColor('#030C23'),
                                      size: 10,
                                    ),
                                    SizedBox(width: 10),
                                    Text('Gain',
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.sp,
                                          color: (isDarkMode == true)
                                              ? HexColor('#FFFFFF')
                                              : HexColor('#030C23'),
                                          shadows: [
                                            Shadow(
                                                color: Color(0xff000000)
                                                    .withOpacity(0.25),
                                                offset: Offset(0, 2),
                                                blurRadius: 2)
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 268.h,
                              right: 128.w,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.circle_fill,
                                      color: (isDarkMode == true)
                                          ? HexColor('#FFFFFF')
                                          : HexColor('#030C23'),
                                      size: 10,
                                    ),
                                    SizedBox(width: 10),
                                    Text('Retain',
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.sp,
                                          color: (isDarkMode == true)
                                              ? HexColor('#FFFFFF')
                                              : HexColor('#030C23'),
                                          shadows: [
                                            Shadow(
                                                color: Color(0xff000000)
                                                    .withOpacity(0.25),
                                                offset: Offset(0, 2),
                                                blurRadius: 2)
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 300.h,
                              right: 110.w,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.circle_fill,
                                      color: (isDarkMode == true)
                                          ? HexColor('#FFFFFF')
                                          : HexColor('#030C23'),
                                      size: 10,
                                    ),
                                    SizedBox(width: 10),
                                    Text('Entertain',
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.sp,
                                          color: (isDarkMode == true)
                                              ? HexColor('#FFFFFF')
                                              : HexColor('#030C23'),
                                          shadows: [
                                            Shadow(
                                                color: Color(0xff000000)
                                                    .withOpacity(0.25),
                                                offset: Offset(0, 2),
                                                blurRadius: 2)
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) =>
                                          OpenTourScreen(runType: 2)),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 45.w),
                                  padding: EdgeInsets.only(
                                      left: 8.0,
                                      right: 8.0,
                                      top: 4.0,
                                      bottom: 4.0),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          (isDarkMode == true)
                                              ? CommonImage.dark_Funzone_shape
                                              : CommonImage.light_Funzone_shape,
                                        ),
                                        fit: BoxFit.fill),
                                  ),
                                  child: Text(
                                    'Get Followers',
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.bold,
                                      color: (isDarkMode == true)
                                          ? HexColor("#FFFFFF")
                                          : HexColor("#0060FF"),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // circle
                      Positioned(
                        right:
                            (-ScreenUtil().screenWidth * 0.42.w).ceilToDouble(),
                        child: SizedBox(
                          height: ScreenUtil().screenHeight * 0.473.h,
                          width: ScreenUtil().screenWidth,
                          child: Stack(
                            //overflow: Overflow.visible,
                            fit: StackFit.loose,
                            alignment: Alignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: (ScreenUtil().screenHeight * 0.34)
                                    .ceilToDouble(),
                                width: (ScreenUtil().screenWidth * 0.73)
                                    .ceilToDouble(),
                                child: Image.asset(
                                  (isDarkMode == true)
                                      ? CommonImage.dark_outer_circle_icon
                                      : "assets/images/home_outer_circle.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              // top
                              Positioned(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    circleButtonImage(
                                      isButtonSelect: true,
                                      imgUrl: (selectType.toString() ==
                                              "Agency")
                                          ? (isDarkMode == true)
                                              ? CommonImage.store_links_icons
                                              : CommonImage
                                                  .light_store_links_icons
                                          : (isDarkMode == true)
                                              ? "assets/icons/darkFamelinkIcon.png"
                                              : "assets/icons/logo.png",
                                      onTaps: () {
                                        setState(() {
                                          selectPhase = 1;
                                          selectedFameLinks =
                                              !selectedFameLinks;
                                          print("================");
                                          selectRegistration = RegistrationType
                                              .FAMELinks.toString();
                                        });
                                      },
                                    ),
                                    Container(
                                      height: 20.0,
                                      width: 2.0,
                                      color: Color(0xFF9B9B9B),
                                    ),
                                  ],
                                ),
                                top: 0.0,
                                left: 0.0,
                                right: 0.0,
                                bottom: (ScreenUtil().screenHeight * 0.30)
                                    .ceilToDouble(),
                              ),
                              // left
                              Positioned(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    circleButtonImage(
                                      imgUrl: (true)
                                          ? CommonImage.dark_follower_icon
                                          : (isDarkMode == true)
                                              ? CommonImage.dark_follower_icon
                                              : "assets/icons/funLinks.png",
                                      isButtonSelect: true,
                                      onTaps: () {
                                        setState(() {
                                          selectPhase = 0;
                                          selectRegistration = RegistrationType
                                              .FOLLOWLinks.toString();
                                        });
                                      },
                                    ),
                                    Container(
                                      width: 22.0,
                                      height: 2.0,
                                      color: Color(0xFF9B9B9B),
                                    )
                                  ],
                                ),
                                top: 0.0,
                                right: 216.0,
                                left: 0.0,
                                bottom: 0.0,
                                // right: MediaQuery.of(context).size.width/2,
                              ),
                              // right
                              Positioned(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 22.0,
                                      height: 2.0,
                                      color: Color(0xFF9B9B9B),
                                    ),
                                    circleButtonImage(
                                      imgUrl: (true)
                                          ? CommonImage.dark_videoLink_icon
                                          : (isDarkMode == true)
                                              ? CommonImage.dark_videoLink_icon
                                              : "assets/icons/funLinks.png",
                                      isButtonSelect: true,
                                      onTaps: () {
                                        print("fsdfsdf");
                                        setState(() {
                                          selectPhase = 3;
                                          selected = !selected;
                                          selectRegistration = RegistrationType
                                              .FUNLinks.toString();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                top: 0.0,
                                right: 0.0,
                                left: (ScreenUtil().screenWidth * 0.59)
                                    .ceilToDouble(),
                                bottom: 0.0,
                              ),
                              // bottom
                              Positioned(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 20.0,
                                      width: 2.0,
                                      color: Color(0xFF9B9B9B),
                                    ),
                                    circleButtonImage(
                                      isButtonSelect: true,
                                      onTaps: () {
                                        debugPrint("Hellos");
                                        setState(() {
                                          key = UniqueKey();
                                          selectPhase = 1;
                                          selectedFameLinks =
                                              !selectedFameLinks;
                                          print("===============");
                                          selectRegistration = RegistrationType
                                              .FAMELinks.toString();
                                        });
                                      },
                                      imgUrl: (isDarkMode == true)
                                          ? CommonImage.dark_jobLink_icon
                                          : "assets/icons/vector.png",
                                    ),
                                  ],
                                ),
                                top: (ScreenUtil().screenHeight * 0.30)
                                    .ceilToDouble(),
                                left: 0.0,
                                right: 0.0,
                                bottom: 0.0,
                                // right: MediaQuery.of(context).size.width/2,
                              ),
                              Stack(
                                //overflow: Overflow.visible,
                                fit: StackFit.loose,
                                alignment: Alignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: (ScreenUtil().screenHeight * 0.18.h)
                                        .ceilToDouble(),
                                    width: (ScreenUtil().screenWidth * 0.36.w)
                                        .ceilToDouble(),
                                    child: Image.asset(
                                      (isDarkMode == true)
                                          ? CommonImage.dark_inner_circle_icon
                                          : "assets/images/home_inner_circle.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  // (selectAvatar == '_') ?
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PhotoImageScreen(
                                                getRunScreen: 'homedial',
                                              ),
                                            ),
                                          );
                                        },
                                        child: Image.asset(
                                            "assets/images/feather_upload.png"),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Your Avatar",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF9B9B9B),
                                        ),
                                      )
                                    ],
                                  )
                                  // : InkWell(
                                  //     onTap: () {
                                  //       Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //           builder: (context) => PhotoImageScreen(
                                  //             getRunScreen: 'homedial',
                                  //           ),
                                  //         ),
                                  //       );
                                  //     },
                                  //     child: (selectAvatarStatus.toString() ==
                                  //             "localAvatar")
                                  //         ? CircleAvatar(
                                  //             backgroundImage: NetworkImage(
                                  //               "${ApiProvider.avtarBaseURL}/${selectAvatar.toString()}",
                                  //             ),
                                  //             backgroundColor: Colors.transparent,
                                  //             radius: 70,
                                  //           )
                                  //         : (selectAvatarStatus.toString() ==
                                  //                 "localfile")
                                  //             ? CircleAvatar(
                                  //                 radius: 70,
                                  //                 backgroundImage: FileImage(
                                  //                   selectImageFile,
                                  //                 ),
                                  //                 backgroundColor:
                                  //                     Colors.transparent,
                                  //               )
                                  //             : CircleAvatar(
                                  //                 radius: 70,
                                  //                 backgroundImage: NetworkImage(
                                  //                   "${ApiProvider.imageBaseUrl}/${selectAvatar.toString()}",
                                  //                 ),
                                  //                 backgroundColor:
                                  //                     Colors.transparent,
                                  //               ),
                                  //   ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 130.h,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          // Navigator.pushAndRemoveUntil(
                          //    context,
                          //     MaterialPageRoute<void>(builder: (BuildContext context) =>  ProfileFameLink(runSelectPhase: 2)),
                          //     ModalRoute.withName('/'),
                          // );
                        },
                        child: Text(
                          'End Tour',
                          style: GoogleFonts.nunitoSans(
                            color: (isDarkMode == true)
                                ? Colors.white
                                : Colors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget circleButtonImage({
    String? imgUrl,
    bool isButtonSelect = false,
    void Function()? onTaps,
  }) =>
      InkWell(
        key: key,
        onTap: onTaps,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: (isButtonSelect == true)
                  ? AssetImage((isButtonSelect == true)
                      ? CommonImage.selected_circle_back
                      : CommonImage.unSelected_circle_back)
                  : AssetImage(
                      (isDartMode == true)
                          ? CommonImage.light_circle_avatar_back
                          : CommonImage.dark_circle_avatar_back,
                    ),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: SizedBox(
              key: key,
              width: 30,
              height: 28,
              child: Image.asset(
                imgUrl.toString(),
                width: 30,
                height: 28,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      );
}

// import 'package:famelink/common/common_image.dart';
// import 'package:famelink/ui/latest_profile/ProfileFameLink.dart';
// import 'package:famelink/ui/profile_UI/PhotoImageScreen.dart';
// import 'package:famelink/ui/startTour/open_tour_screen.dart';
// import 'package:famelink/util/config/color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../common/common_textformfield.dart';

// enum RegistrationType { FAMELinks, JOBLinks, FUNLinks, FOLLOWLinks, STORELinks }

// class TourFollowLink extends StatefulWidget {
//   @override
//   State<TourFollowLink> createState() => _TourFollowLinkState();
// }

// class _TourFollowLinkState extends State<TourFollowLink> {
//   SharedPreferences prefs;

//   Key key = UniqueKey();
//   static bool isDarkMode = true;
//   static String selectRegistration = RegistrationType.FAMELinks.toString();
//   String selectDistrict = "_";
//   String selectState = "_";
//   String selectCountry = "_";
//   String selectGender = "_";
//   static String selectedDob;
//   final TextEditingController nameController = TextEditingController();
//   String selectDateOfBirth = '_';
//   @override
//   void initState() {
//     super.initState();
//     _init();
//   }

//   _init() async {
//     prefs = await SharedPreferences.getInstance();
//     // selectDateOfBirth = selectedDob;
//     if (prefs.getString('mode').toString() == 'dark') {
//       setState(() {
//         isDartMode = true;
//       });
//     } else {
//       setState(() {
//         isDartMode = false;
//       });
//     }
//   }

//   int selectPhase = 0;
//   bool isDartMode = true;
//   static String selectType = "Individual";
//   bool status1 = false;
//   bool selected = false;
//   bool selectedFameLinks = false;

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       systemNavigationBarColor: Colors.transparent, // navigation bar color
//       statusBarColor: Colors.transparent, // status bar color
//       statusBarIconBrightness: Brightness.light, // status bar icons' color
//       systemNavigationBarIconBrightness: Brightness.dark,
//     ));
//     return KeyedSubtree(
//       key: key,
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         body: Container(
//           padding: EdgeInsets.only(top: 30.h),
//           height: MediaQuery.of(context).size.height,
//           decoration: (isDarkMode == true)
//               ? BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(CommonImage.dart_back_img),
//                     alignment: Alignment.center,
//                     fit: BoxFit.fill,
//                   ),
//                 )
//               : BoxDecoration(color: HexColor("#FDFCFA")),
//           child: SingleChildScrollView(
//             child: Container(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   SizedBox(
//                     height: (ScreenUtil().screenHeight * 0.06).ceilToDouble(),
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text.rich(
//                         TextSpan(
//                           children: <TextSpan>[
//                             TextSpan(
//                               text: "Know ",
//                               style: GoogleFonts.nunitoSans(
//                                 fontWeight: FontWeight.w700,
//                                 fontStyle: FontStyle.normal,
//                                 color: (isDarkMode == true)
//                                     ? Colors.white
//                                     : HexColor("#030C23"),
//                                 shadows: <Shadow>[
//                                   Shadow(
//                                     offset: Offset(0.8, 0.8),
//                                     blurRadius: 2,
//                                     color: Color.fromRGBO(0, 0, 0, 0.25),
//                                   ),
//                                   Shadow(
//                                     offset: Offset(0.8, 0.8),
//                                     blurRadius: 2,
//                                     color: Color.fromRGBO(0, 0, 0, 0.25),
//                                   ),
//                                 ],
//                                 fontSize: 26,
//                               ),
//                             ),
//                             TextSpan(
//                               text: "FAMELINKS",
//                               style: GoogleFonts.nunitoSans(
//                                 fontWeight: FontWeight.w700,
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 26,
//                                 shadows: <Shadow>[
//                                   Shadow(
//                                     offset: Offset(0.8, 0.8),
//                                     blurRadius: 0.2,
//                                     color:
//                                         HexColor("#FF5C28").withOpacity(0.25),
//                                   ),
//                                   Shadow(
//                                     offset: Offset(0.8, 0.8),
//                                     blurRadius: 0.2,
//                                     color:
//                                         HexColor("#FF5C28").withOpacity(0.25),
//                                   ),
//                                 ],
//                                 color: HexColor("#FF5C28"),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       SizedBox(
//                         height: 15,
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Text.rich(
//                             TextSpan(
//                               children: <TextSpan>[
//                                 TextSpan(
//                                   text: "Follow",
//                                   style: GoogleFonts.nunitoSans(
//                                     fontWeight: FontWeight.w700,
//                                     fontStyle: FontStyle.normal,
//                                     color: HexColor("FF5C28"),
//                                     fontSize: 16.sp,
//                                     shadows: [
//                                       Shadow(
//                                           color: Color(0xff000000)
//                                               .withOpacity(0.25),
//                                           offset: Offset(0, 2),
//                                           blurRadius: 2)
//                                     ],
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: "Links",
//                                   style: GoogleFonts.nunitoSans(
//                                     fontWeight: FontWeight.w700,
//                                     fontStyle: FontStyle.normal,
//                                     fontSize: 16.sp,
//                                     color: (isDarkMode == true)
//                                         ? HexColor("#FFFFFF")
//                                         : HexColor("#030C23"),
//                                     shadows: [
//                                       Shadow(
//                                           color: Color(0xff000000)
//                                               .withOpacity(0.25),
//                                           offset: Offset(0, 2),
//                                           blurRadius: 2)
//                                     ],
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: "->",
//                                   style: GoogleFonts.nunitoSans(
//                                     fontWeight: FontWeight.w700,
//                                     shadows: [
//                                       Shadow(
//                                           color: Color(0xff000000)
//                                               .withOpacity(0.25),
//                                           offset: Offset(0, 2),
//                                           blurRadius: 2)
//                                     ],
//                                     fontStyle: FontStyle.normal,
//                                     fontSize: 16.sp,
//                                     color: (isDarkMode == true)
//                                         ? HexColor("#FFFFFF")
//                                         : HexColor("#030C23"),
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: " what is your secret",
//                                   style: GoogleFonts.nunitoSans(
//                                     fontStyle: FontStyle.normal,
//                                     fontSize: 14.sp,
//                                     fontWeight: FontWeight.w400,
//                                     shadows: [
//                                       Shadow(
//                                           color: Color(0xff000000)
//                                               .withOpacity(0.25),
//                                           offset: Offset(0, 2),
//                                           blurRadius: 2)
//                                     ],
//                                     color: (isDarkMode == true)
//                                         ? HexColor("#FFFFFF")
//                                         : HexColor("#030C23"),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: 95.11,
//                             height: 85,
//                             child: Image.asset(
//                               CommonImage.darkFollowLinksPotionIcon,
//                               fit: BoxFit.fill,
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 60,
//                       ),
//                       Stack(
//                         overflow: Overflow.visible,
//                         fit: StackFit.loose,
//                         children: <Widget>[
//                           // upper shape
//                           Container(
//                             height: (ScreenUtil().screenHeight * 0.410)
//                                 .ceilToDouble(),
//                             width: (ScreenUtil().screenWidth).ceilToDouble(),
//                             child: Text('  '),
//                           ),
//                           Positioned(
//                             bottom: (ScreenUtil().screenHeight * 0.220)
//                                 .ceilToDouble(),
//                             right:
//                                 (ScreenUtil().screenWidth / 4.0).ceilToDouble(),
//                             child: Container(
//                               padding: EdgeInsets.only(right: 20.0),
//                               height: (ScreenUtil().screenHeight * 0.26)
//                                   .ceilToDouble(),
//                               width: (ScreenUtil().screenWidth * 0.60)
//                                   .ceilToDouble(),
//                               margin: EdgeInsets.only(right: 24.0),
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   image: (isDarkMode == false)
//                                       ? AssetImage(
//                                           CommonImage.lightFollowLinksTopShape)
//                                       : AssetImage(
//                                           CommonImage.darkFollowLinksTopShape),
//                                 ),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                   left: 16.0,
//                                   top: 16.0,
//                                   bottom: 16.0,
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           right: 28.0, left: 10.0),
//                                       child: Text(
//                                         "Your Followers see all your posts from all the other channels",
//                                         style: GoogleFonts.nunitoSans(
//                                           fontSize: 14.sp,
//                                           fontWeight: FontWeight.w700,
//                                           shadows: [
//                                             Shadow(
//                                                 color: Color(0xff000000)
//                                                     .withOpacity(0.25),
//                                                 offset: Offset(0, 2),
//                                                 blurRadius: 2)
//                                           ],
//                                           color: (isDarkMode == true)
//                                               ? white
//                                               : HexColor('#030C23'),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 8.0,
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 10, top: 10),
//                                       child: Row(
//                                         children: [
//                                           SvgPicture.asset(
//                                               'assets/images/homefollow.svg',
//                                               color: orange),
//                                           Padding(
//                                             padding:
//                                                 const EdgeInsets.only(left: 10),
//                                             child: Text(
//                                               'FameLinks',
//                                               style: GoogleFonts.nunitoSans(
//                                                 fontSize: 14.sp,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: (isDarkMode == true)
//                                                     ? HexColor('#FFFFFF')
//                                                     : HexColor('#030C23'),
//                                                 shadows: [
//                                                   Shadow(
//                                                       color: Color(0xff000000)
//                                                           .withOpacity(0.25),
//                                                       offset: Offset(0, 2),
//                                                       blurRadius: 2)
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(height: 4),
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                         left: 10,
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           SvgPicture.asset(
//                                               'assets/images/homefollow.svg',
//                                               color: orange),
//                                           Padding(
//                                             padding:
//                                                 const EdgeInsets.only(left: 10),
//                                             child: Text(
//                                               'FunLinks',
//                                               style: GoogleFonts.nunitoSans(
//                                                 fontSize: 14.sp,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: (isDarkMode == true)
//                                                     ? HexColor('#FFFFFF')
//                                                     : HexColor('#030C23'),
//                                                 shadows: [
//                                                   Shadow(
//                                                       color: Color(0xff000000)
//                                                           .withOpacity(0.25),
//                                                       offset: Offset(0, 2),
//                                                       blurRadius: 2)
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(height: 4),
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                         left: 10,
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           SvgPicture.asset(
//                                               'assets/images/homefollow.svg',
//                                               color: orange),
//                                           Padding(
//                                             padding:
//                                                 const EdgeInsets.only(left: 10),
//                                             child: Text(
//                                               'FollowLinks',
//                                               style: GoogleFonts.nunitoSans(
//                                                 fontSize: 14.sp,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: (isDarkMode == true)
//                                                     ? HexColor('#FFFFFF')
//                                                     : HexColor('#030C23'),
//                                                 shadows: [
//                                                   Shadow(
//                                                       color: Color(0xff000000)
//                                                           .withOpacity(0.25),
//                                                       offset: Offset(0, 2),
//                                                       blurRadius: 2)
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             top: 170.h,
//                             right: 190.w,
//                             child: Text.rich(
//                               TextSpan(
//                                 children: <TextSpan>[
//                                   TextSpan(
//                                     text: "FOLLOW",
//                                     style: GoogleFonts.nunitoSans(
//                                       fontWeight: FontWeight.w700,
//                                       fontStyle: FontStyle.normal,
//                                       color: (isDarkMode == true)
//                                           ? HexColor("#FF5C28")
//                                           : Colors.black,
//                                       fontSize: 14.sp,
//                                       shadows: [
//                                         Shadow(
//                                             color: Color(0xff000000)
//                                                 .withOpacity(0.25),
//                                             offset: Offset(0, 2),
//                                             blurRadius: 2)
//                                       ],
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: "LINKS",
//                                     style: GoogleFonts.nunitoSans(
//                                       fontWeight: FontWeight.w700,
//                                       fontStyle: FontStyle.normal,
//                                       color: (isDarkMode == true)
//                                           ? Colors.white
//                                           : HexColor("#FF5C28"),
//                                       fontSize: 14.sp,
//                                       shadows: [
//                                         Shadow(
//                                             color: Color(0xff000000)
//                                                 .withOpacity(0.25),
//                                             offset: Offset(0, 2),
//                                             blurRadius: 2)
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // down Shape

//                           Column(
//                             children: [
//                               Positioned(
//                                 bottom: (-ScreenUtil().screenHeight * 0.110)
//                                     .ceilToDouble(),
//                                 right:
//                                     (ScreenUtil().screenWidth / 4.0).ceilToDouble(),
//                                 child: Container(
//                                   padding: EdgeInsets.only(right: 20.0),
//                                   height: (ScreenUtil().screenHeight * 0.26)
//                                       .ceilToDouble(),
//                                   width: (ScreenUtil().screenWidth * 0.60)
//                                       .ceilToDouble(),
//                                   margin: EdgeInsets.only(right: 24.0),
//                                   decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                       image: (isDarkMode == true)
//                                           ? AssetImage(CommonImage
//                                               .darkFollowLinksBottomShape)
//                                           : AssetImage(CommonImage
//                                               .lightFollowLinksBottomShape),
//                                     ),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                       left: 16.0,
//                                       top: 16.0,
//                                       bottom: 16.0,
//                                     ),
//                                     child: Column(
//                                       children: <Widget>[
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 10, top: 15),
//                                           child: Row(
//                                             children: [
//                                               Icon(
//                                                 CupertinoIcons.circle_fill,
//                                                 color: (isDarkMode == true)
//                                                     ? HexColor('#FFFFFF')
//                                                     : HexColor('#030C23'),
//                                                 size: 10,
//                                               ),
//                                               SizedBox(width: 10),
//                                               Text('Gain',
//                                                   style: GoogleFonts.nunitoSans(
//                                                     fontWeight: FontWeight.w700,
//                                                     fontSize: 14.sp,
//                                                     color: (isDarkMode == true)
//                                                         ? HexColor('#FFFFFF')
//                                                         : HexColor('#030C23'),
//                                                     shadows: [
//                                                       Shadow(
//                                                           color: Color(0xff000000)
//                                                               .withOpacity(0.25),
//                                                           offset: Offset(0, 2),
//                                                           blurRadius: 2)
//                                                     ],
//                                                   )),
//                                             ],
//                                           ),
//                                         ),
//                                         SizedBox(height: 4),
//                                         Padding(
//                                           padding: const EdgeInsets.only(left: 10),
//                                           child: Row(
//                                             children: [
//                                               Icon(
//                                                 CupertinoIcons.circle_fill,
//                                                 color: (isDarkMode == true)
//                                                     ? HexColor('#FFFFFF')
//                                                     : HexColor('#030C23'),
//                                                 size: 10,
//                                               ),
//                                               SizedBox(width: 10),
//                                               Text('Retain',
//                                                   style: GoogleFonts.nunitoSans(
//                                                     fontWeight: FontWeight.w700,
//                                                     fontSize: 14.sp,
//                                                     color: (isDarkMode == true)
//                                                         ? HexColor('#FFFFFF')
//                                                         : HexColor('#030C23'),
//                                                     shadows: [
//                                                       Shadow(
//                                                           color: Color(0xff000000)
//                                                               .withOpacity(0.25),
//                                                           offset: Offset(0, 2),
//                                                           blurRadius: 2)
//                                                     ],
//                                                   )),
//                                             ],
//                                           ),
//                                         ),
//                                         SizedBox(height: 4),
//                                         Padding(
//                                           padding: const EdgeInsets.only(left: 10),
//                                           child: Row(
//                                             children: [
//                                               Icon(
//                                                 CupertinoIcons.circle_fill,
//                                                 color: (isDarkMode == true)
//                                                     ? HexColor('#FFFFFF')
//                                                     : HexColor('#030C23'),
//                                                 size: 10,
//                                               ),
//                                               SizedBox(width: 10),
//                                               Text('Entertain',
//                                                   style: GoogleFonts.nunitoSans(
//                                                     fontWeight: FontWeight.w700,
//                                                     fontSize: 14.sp,
//                                                     color: (isDarkMode == true)
//                                                         ? HexColor('#FFFFFF')
//                                                         : HexColor('#030C23'),
//                                                     shadows: [
//                                                       Shadow(
//                                                           color: Color(0xff000000)
//                                                               .withOpacity(0.25),
//                                                           offset: Offset(0, 2),
//                                                           blurRadius: 2)
//                                                     ],
//                                                   )),
//                                             ],
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 20,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // circle
//                           Positioned(
//                             right: (-ScreenUtil().screenWidth * 0.42)
//                                 .ceilToDouble(),
//                             child: SizedBox(
//                               height: ScreenUtil().screenHeight * 0.440,
//                               width: ScreenUtil().screenWidth,
//                               child: Stack(
//                                 overflow: Overflow.visible,
//                                 fit: StackFit.loose,
//                                 alignment: Alignment.center,
//                                 children: <Widget>[
//                                   SizedBox(
//                                     height: (ScreenUtil().screenHeight * 0.34)
//                                         .ceilToDouble(),
//                                     width: (ScreenUtil().screenWidth * 0.73)
//                                         .ceilToDouble(),
//                                     child: Image.asset(
//                                       (isDarkMode == true)
//                                           ? CommonImage.dark_outer_circle_icon
//                                           : "assets/images/home_outer_circle.png",
//                                       fit: BoxFit.fill,
//                                     ),
//                                   ),
//                                   // top
//                                   Positioned(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         circleButtonImage(
//                                           imgUrl: (selectType.toString() ==
//                                                   "Agency")
//                                               ? (isDarkMode == true)
//                                                   ? CommonImage
//                                                       .store_links_icons
//                                                   : CommonImage
//                                                       .light_store_links_icons
//                                               : (isDarkMode == true)
//                                                   ? "assets/icons/darkFamelinkIcon.png"
//                                                   : "assets/icons/logo.png",
//                                           onTaps: () {
//                                             setState(() {
//                                               selectPhase = 1;
//                                               selectedFameLinks =
//                                                   !selectedFameLinks;
//                                               print("================");
//                                               selectRegistration =
//                                                   RegistrationType.FAMELinks
//                                                       .toString();
//                                             });
//                                           },
//                                         ),
//                                         Container(
//                                           height: 20.0,
//                                           width: 2.0,
//                                           color: Color(0xFF9B9B9B),
//                                         ),
//                                       ],
//                                     ),
//                                     top: 0.0,
//                                     left: 0.0,
//                                     right: 0.0,
//                                     bottom: (ScreenUtil().screenHeight * 0.30)
//                                         .ceilToDouble(),
//                                   ),
//                                   // left
//                                   Positioned(
//                                     child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         circleButtonImage(
//                                           imgUrl: (true)
//                                               ? CommonImage.dark_follower_icon
//                                               : (isDarkMode == true)
//                                                   ? CommonImage
//                                                       .dark_follower_icon
//                                                   : "assets/icons/funLinks.png",
//                                           isButtonSelect: true,
//                                           onTaps: () {
//                                             setState(() {
//                                               selectPhase = 0;
//                                               selectRegistration =
//                                                   RegistrationType.FOLLOWLinks
//                                                       .toString();
//                                             });
//                                           },
//                                         ),
//                                         Container(
//                                           width: 22.0,
//                                           height: 2.0,
//                                           color: Color(0xFF9B9B9B),
//                                         )
//                                       ],
//                                     ),
//                                     top: 0.0,
//                                     right: 216.0,
//                                     left: 0.0,
//                                     bottom: 0.0,
//                                     // right: MediaQuery.of(context).size.width/2,
//                                   ),
//                                   // right
//                                   Positioned(
//                                     child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                           width: 22.0,
//                                           height: 2.0,
//                                           color: Color(0xFF9B9B9B),
//                                         ),
//                                         circleButtonImage(
//                                           imgUrl: (true)
//                                               ? CommonImage.dark_videoLink_icon
//                                               : (isDarkMode == true)
//                                                   ? CommonImage
//                                                       .dark_videoLink_icon
//                                                   : "assets/icons/funLinks.png",
//                                           isButtonSelect: true,
//                                           onTaps: () {
//                                             print("fsdfsdf");
//                                             setState(() {
//                                               selectPhase = 3;
//                                               selected = !selected;
//                                               selectRegistration =
//                                                   RegistrationType.FUNLinks
//                                                       .toString();
//                                             });
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                     top: 0.0,
//                                     right: 0.0,
//                                     left: (ScreenUtil().screenWidth * 0.59)
//                                         .ceilToDouble(),
//                                     bottom: 0.0,
//                                   ),
//                                   // bottom
//                                   Positioned(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                           height: 20.0,
//                                           width: 2.0,
//                                           color: Color(0xFF9B9B9B),
//                                         ),
//                                         circleButtonImage(
//                                           onTaps: () {
//                                             debugPrint("Hellos");
//                                             setState(() {
//                                               key = UniqueKey();
//                                               selectPhase = 2;
//                                               selectedFameLinks =
//                                                   !selectedFameLinks;
//                                               print("===============");
//                                               selectRegistration =
//                                                   RegistrationType.JOBLinks
//                                                       .toString();
//                                             });
//                                           },
//                                           imgUrl: (isDarkMode == true)
//                                               ? CommonImage.dark_jobLink_icon
//                                               : "assets/icons/vector.png",
//                                         ),
//                                       ],
//                                     ),
//                                     top: (ScreenUtil().screenHeight * 0.30)
//                                         .ceilToDouble(),
//                                     left: 0.0,
//                                     right: 0.0,
//                                     bottom: 0.0,
//                                     // right: MediaQuery.of(context).size.width/2,
//                                   ),
//                                   Stack(
//                                     overflow: Overflow.visible,
//                                     fit: StackFit.loose,
//                                     alignment: Alignment.center,
//                                     children: <Widget>[
//                                       SizedBox(
//                                         height:
//                                             (ScreenUtil().screenHeight * 0.18)
//                                                 .ceilToDouble(),
//                                         width: (ScreenUtil().screenWidth * 0.36)
//                                             .ceilToDouble(),
//                                         child: Image.asset(
//                                           (isDarkMode == true)
//                                               ? CommonImage
//                                                   .dark_inner_circle_icon
//                                               : "assets/images/home_inner_circle.png",
//                                           fit: BoxFit.fill,
//                                         ),
//                                       ),
//                                       // (selectAvatar == '_') ?
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           InkWell(
//                                             onTap: () {
//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       PhotoImageScreen(
//                                                     getRunScreen: 'homedial',
//                                                     name: nameController.text,
//                                                     district: selectDistrict,
//                                                     state: selectState,
//                                                     country: selectCountry,
//                                                     Selectedgender:
//                                                         selectGender,
//                                                     dob: selectDateOfBirth,
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                             child: Image.asset(
//                                                 "assets/images/feather_upload.png"),
//                                           ),
//                                           SizedBox(
//                                             height: 8,
//                                           ),
//                                           Text(
//                                             "Your Avatar",
//                                             style: TextStyle(
//                                               fontSize: 12,
//                                               color: Color(0xFF9B9B9B),
//                                             ),
//                                           )
//                                         ],
//                                       )
//                                       // : InkWell(
//                                       //     onTap: () {
//                                       //       Navigator.push(
//                                       //         context,
//                                       //         MaterialPageRoute(
//                                       //           builder: (context) => PhotoImageScreen(
//                                       //             getRunScreen: 'homedial',
//                                       //           ),
//                                       //         ),
//                                       //       );
//                                       //     },
//                                       //     child: (selectAvatarStatus.toString() ==
//                                       //             "localAvatar")
//                                       //         ? CircleAvatar(
//                                       //             backgroundImage: NetworkImage(
//                                       //               "${ApiProvider.avtarBaseURL}/${selectAvatar.toString()}",
//                                       //             ),
//                                       //             backgroundColor: Colors.transparent,
//                                       //             radius: 70,
//                                       //           )
//                                       //         : (selectAvatarStatus.toString() ==
//                                       //                 "localfile")
//                                       //             ? CircleAvatar(
//                                       //                 radius: 70,
//                                       //                 backgroundImage: FileImage(
//                                       //                   selectImageFile,
//                                       //                 ),
//                                       //                 backgroundColor:
//                                       //                     Colors.transparent,
//                                       //               )
//                                       //             : CircleAvatar(
//                                       //                 radius: 70,
//                                       //                 backgroundImage: NetworkImage(
//                                       //                   "${ApiProvider.imageBaseUrl}/${selectAvatar.toString()}",
//                                       //                 ),
//                                       //                 backgroundColor:
//                                       //                     Colors.transparent,
//                                       //               ),
//                                       //   ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 130.0,
//                       ),
//                     ],
//                   ),
//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child: Padding(
//                       padding: EdgeInsets.all(8.r),
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.of(context).pop();
//                           // Navigator.pushAndRemoveUntil(
//                           //    context,
//                           //     MaterialPageRoute<void>(builder: (BuildContext context) =>  ProfileFameLink(runSelectPhase: 2)),
//                           //     ModalRoute.withName('/'),
//                           // );
//                         },
//                         child: Text(
//                           'End Tour',
//                           style: GoogleFonts.nunitoSans(
//                             color: (isDarkMode == true)
//                                 ? Colors.white
//                                 : Colors.black,
//                             fontSize: 12.sp,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget circleButtonImage({
//     String imgUrl,
//     bool isButtonSelect = false,
//     void Function() onTaps,
//   }) =>
//       InkWell(
//         key: key,
//         onTap: onTaps,
//         child: Container(
//           width: 60,
//           height: 60,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: (isButtonSelect == true)
//                   ? AssetImage((isButtonSelect == true)
//                       ? CommonImage.selected_circle_back
//                       : CommonImage.unSelected_circle_back)
//                   : AssetImage(
//                       (isDartMode == true)
//                           ? CommonImage.light_circle_avatar_back
//                           : CommonImage.dark_circle_avatar_back,
//                     ),
//               fit: BoxFit.fill,
//             ),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(18.0),
//             child: SizedBox(
//               key: key,
//               width: 30,
//               height: 28,
//               child: Image.asset(
//                 imgUrl.toString(),
//                 width: 30,
//                 height: 28,
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//         ),
//       );
// }
