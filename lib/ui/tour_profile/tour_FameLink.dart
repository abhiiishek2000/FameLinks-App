import 'package:famelink/common/common_image.dart';
import 'package:famelink/ui/profile_UI/PhotoImageScreen.dart';
import 'package:famelink/ui/startTour/open_tour_screen.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RegistrationType { FAMELinks, JOBLinks, FUNLinks, FOLLOWLinks, STORELinks }

class TourFameLink extends StatefulWidget {
  @override
  State<TourFameLink> createState() => _TourFameLinkState();
}

class _TourFameLinkState extends State<TourFameLink> {
  SharedPreferences? prefs;

  Key key = UniqueKey();
  static bool isDarkMode = true;
  static String selectRegistration = RegistrationType.FAMELinks.toString();
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    prefs = await SharedPreferences.getInstance();
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
                                    color:
                                        HexColor("#000000").withOpacity(0.25),
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
                                        HexColor("#000000").withOpacity(0.25),
                                  ),
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
                    height: (ScreenUtil().screenHeight * 0.06).ceilToDouble(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Container(
                      height: 171.5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/fameLinksMessageBox.png",
                            ),
                            fit: BoxFit.fill),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Fame",
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("#FF5C28"),
                                          shadows: <Shadow>[
                                            Shadow(
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.25),
                                              blurRadius: 4,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Links",
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16.sp,
                                          shadows: <Shadow>[
                                            Shadow(
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.25),
                                              blurRadius: 2,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                          color: white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  " is all about ",
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.sp,
                                    color: (isDarkMode == true)
                                        ? HexColor("#030C23")
                                        : HexColor("#030C23"),
                                    shadows: <Shadow>[
                                      Shadow(
                                        color:
                                            Color(0xFF000000).withOpacity(0.25),
                                        blurRadius: 2,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "Earn",
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20.sp,
                                    color: (isDarkMode == true)
                                        ? HexColor("#FF5C28")
                                        : HexColor("#FF5C28"),
                                    shadows: <Shadow>[
                                      Shadow(
                                        color:
                                            Color(0xFF000000).withOpacity(0.25),
                                        blurRadius: 2,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/moneyBag.png",
                                  height: 35,
                                  width: 35,
                                ),
                                Text(
                                  " & ",
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.sp,
                                    color: (isDarkMode == true)
                                        ? HexColor("#030C23")
                                        : HexColor("#030C23"),
                                    shadows: <Shadow>[
                                      Shadow(
                                        color:
                                            Color(0xFF000000).withOpacity(0.25),
                                        blurRadius: 2,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "Grow",
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20.sp,
                                    color: (isDarkMode == true)
                                        ? HexColor("#FF5C28")
                                        : HexColor("#FF5C28"),
                                    shadows: <Shadow>[
                                      Shadow(
                                        color:
                                            Color(0xFF000000).withOpacity(0.25),
                                        blurRadius: 2,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/growImage.png",
                                  height: 25,
                                  width: 25,
                                  fit: BoxFit.fill,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 13.0, right: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Set",
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w900,
                                          color: (isDarkMode == true)
                                              ? HexColor("#FFFFFF")
                                              : HexColor("#030C23"),
                                          fontSize: 20.sp,
                                          shadows: <Shadow>[
                                            Shadow(
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.25),
                                              blurRadius: 2,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "Trendz",
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w900,
                                          color: (isDarkMode == true)
                                              ? HexColor("#FFFFFF")
                                              : HexColor("#030C23"),
                                          fontSize: 20.sp,
                                          shadows: <Shadow>[
                                            Shadow(
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.25),
                                              blurRadius: 2,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Container(
                                    color: (isDarkMode == true)
                                        ? HexColor("#FFFFFF")
                                        : HexColor("#9B9B9B"),
                                    height: 1,
                                    width: 12,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Become",
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w700,
                                          color: (isDarkMode == true)
                                              ? HexColor("#FFFFFF")
                                              : HexColor("#030C23"),
                                          fontSize: 16.sp,
                                          shadows: <Shadow>[
                                            Shadow(
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.25),
                                              blurRadius: 2,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "Ambassdors",
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w700,
                                          color: (isDarkMode == true)
                                              ? HexColor("#FFFFFF")
                                              : HexColor("#030C23"),
                                          fontSize: 16.sp,
                                          shadows: <Shadow>[
                                            Shadow(
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.25),
                                              blurRadius: 2,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Container(
                                    color: (isDarkMode == true)
                                        ? HexColor("#FFFFFF")
                                        : HexColor("#9B9B9B"),
                                    height: 1,
                                    width: 12,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Win",
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w900,
                                          color: (isDarkMode == true)
                                              ? HexColor("#FFFFFF")
                                              : HexColor("#030C23"),
                                          fontSize: 20.sp,
                                          shadows: <Shadow>[
                                            Shadow(
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.25),
                                              blurRadius: 2,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "Contests",
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w900,
                                          color: (isDarkMode == true)
                                              ? HexColor("#FFFFFF")
                                              : HexColor("#030C23"),
                                          fontSize: 20.sp,
                                          shadows: <Shadow>[
                                            Shadow(
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.25),
                                              blurRadius: 2,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  (isDarkMode == true)
                      ? SizedBox(
                          height: 5.0,
                        )
                      : SizedBox(
                          height: 0.0,
                        ),
                  Container(
                    margin:
                        EdgeInsets.only(left: ScreenUtil().screenWidth / 2.5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "FAME",
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: (isDarkMode == true)
                                      ? HexColor("#FF5C28")
                                      : Colors.black,
                                  fontSize: 14.sp,
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
                                text: "LINKS",
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: (isDarkMode == true)
                                      ? Colors.white
                                      : HexColor("#FF5C28"),
                                  fontSize: 14.sp,
                                  shadows: [
                                    Shadow(
                                        color:
                                            Color(0xff000000).withOpacity(0.25),
                                        offset: Offset(0, 2),
                                        blurRadius: 2)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) =>
                                    OpenTourScreen(runType: 0)),
                              ),
                            );
                          },
                          child: Container(
                            height: 30.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: (isDarkMode == true)
                                    ? AssetImage(CommonImage.fame_dark_back)
                                    : AssetImage(CommonImage.fame_light_back),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 8.r,
                                right: 8.r,
                                top: 3.r,
                                bottom: 8.r,
                              ),
                              child: Center(
                                child: Text(
                                  'Know More',
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: (isDarkMode == true)
                                        ? Colors.white
                                        : HexColor("#FF5C28"),
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(left: 27.0, right: 27.0),
                      height: ScreenUtil().screenHeight * 0.469,
                      width: ScreenUtil().screenWidth,
                      child: Stack(
                        //overflow: Overflow.visible,
                        fit: StackFit.loose,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: ScreenUtil().screenHeight,
                            width: ScreenUtil().screenWidth,
                            child: Image.asset(
                              (isDarkMode == true)
                                  ? CommonImage.dark_outer_circle_icon
                                  : "assets/images/home_outer_circle.png",
                            ),
                          ),
                          // top
                          Positioned(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                circleButtonImage(
                                  imgUrl: (selectType.toString() == "Agency")
                                      ? (true)
                                          ? CommonImage.store_links_icons
                                          : (isDarkMode == true)
                                              ? CommonImage.store_links_icons
                                              : CommonImage
                                                  .light_store_links_icons
                                      : (true)
                                          ? "assets/icons/darkFamelinkIcon.png"
                                          : (isDarkMode == true)
                                              ? "assets/icons/darkFamelinkIcon.png"
                                              : "assets/icons/logo.png",
                                  onTaps: () {
                                    setState(() {
                                      selectPhase = 0;
                                      selectRegistration =
                                          RegistrationType.FAMELinks.toString();
                                    });
                                  },
                                  isButtonSelect: true,
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
                            bottom: 220.0,
                          ),
                          // left
                          Positioned(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                circleButtonImage(
                                  imgUrl: (isDarkMode == true)
                                      ? CommonImage.dark_follower_icon
                                      : "assets/icons/followLinks.png",
                                  isButtonSelect: false,
                                  onTaps: () {
                                    setState(() {
                                      selectPhase = 3;
                                      selected = !selected;
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
                            right: 220.0,
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
                                  imgUrl: (isDarkMode == true)
                                      ? CommonImage.dark_videoLink_icon
                                      : "assets/icons/funLinks.png",
                                  onTaps: () {
                                    setState(() {
                                      selectPhase = 3;
                                      selected = !selected;
                                      selectRegistration =
                                          RegistrationType.FUNLinks.toString();
                                    });
                                  },
                                ),
                              ],
                            ),
                            top: 0.0,
                            right: 0.0,
                            left: 220.0,
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
                                  onTaps: () {
                                    setState(() {
                                      selectPhase = 2;
                                      selectRegistration =
                                          RegistrationType.JOBLinks.toString();
                                    });
                                  },
                                  imgUrl: (isDarkMode == true)
                                      ? CommonImage.dark_jobLink_icon
                                      : "assets/icons/vector.png",
                                ),
                              ],
                            ),
                            top: 220.0,
                            left: 0.0,
                            right: 0.0,
                            bottom: 0.0,
                            // right: MediaQuery.of(context).size.width/2,
                          ),

                          Stack(
                            //overflow: Overflow.visible,
                            fit: StackFit.loose,
                            alignment: Alignment.center,
                            children: [
                              Container(
                                  height: 144,
                                  width: 144,
                                  child: Image.asset((isDarkMode == true)
                                      ? CommonImage.dark_inner_circle_icon
                                      : "assets/images/home_inner_circle.png")),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                            ],
                          )
                        ],
                      ),
                    ),
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
                          //     MaterialPageRoute<void>(builder: (BuildContext context) =>  ProfileFameLink(runSelectPhase: 0)),
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
                  // SizedBox(
                  //   height: 50.0,
                  // ),
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
