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

class TourFunLink extends StatefulWidget {
  @override
  State<TourFunLink> createState() => _TourFunLinkState();
}

class _TourFunLinkState extends State<TourFunLink> {
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
                              text: "Fun",
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
                          ],
                        ),
                      ),
                      Text(
                        " is a channel for ",
                        style: GoogleFonts.nunitoSans(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: (isDarkMode == true)
                              ? HexColor("#FFFFFF")
                              : HexColor("#030C23"),
                          shadows: [
                            Shadow(
                                color: Color(0xff000000).withOpacity(0.25),
                                offset: Offset(0, 2),
                                blurRadius: 2)
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: (isDarkMode == true)
                                ? AssetImage(
                                    CommonImage.dark_funLinks_shortVideo)
                                : AssetImage(
                                    CommonImage.light_funLinks_shortVideo),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 2, top: 5, bottom: 5, right: 2),
                          child: Text(
                            "Short Videos",
                            style: GoogleFonts.nunitoSans(
                              color: (isDarkMode == true)
                                  ? HexColor("#FFFFFF")
                                  : HexColor("#FF5C28"),
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
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
                        bottom:
                            (ScreenUtil().screenHeight * 0.220).ceilToDouble(),
                        left: (ScreenUtil().screenWidth / 2.7).ceilToDouble(),
                        child: Container(
                          padding: EdgeInsets.only(right: 20.0),
                          height:
                              (ScreenUtil().screenHeight * 0.23).ceilToDouble(),
                          width:
                              (ScreenUtil().screenWidth * 0.60).ceilToDouble(),
                          margin: EdgeInsets.only(right: 55.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: (isDarkMode == false)
                                  ? AssetImage(
                                      CommonImage.light_funLinks_first_icon)
                                  : AssetImage(
                                      CommonImage.dark_funLinks_first_icon),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, top: 16.0, right: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 18.0,
                                      width: 16.2,
                                      child: Image.asset(
                                        (isDarkMode == true)
                                            ? CommonImage
                                                .dark_funLinks_first_shape
                                            : CommonImage
                                                .light_funLinks_first_shape,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    Text(
                                      "Watch Talented &\nBeautiful\npeople making\nVideos",
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w700,
                                        color: (isDarkMode == true)
                                            ? HexColor("#FFFFFF")
                                            : HexColor("#030C23"),
                                        fontSize: 14.sp,
                                        shadows: [
                                          Shadow(
                                              color: Color(0xff000000)
                                                  .withOpacity(0.25),
                                              offset: Offset(0, 2),
                                              blurRadius: 2)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(right: 30.w, top: 8.h),
                                  child: SizedBox(
                                    height: (ScreenUtil().screenHeight * 0.08)
                                        .ceilToDouble(),
                                    width: 54,
                                    child: Image.asset(
                                      (isDarkMode == true)
                                          ? CommonImage.dark_talent_icon
                                          : CommonImage.light_talent_icon,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: (ScreenUtil().screenHeight * 0.170)
                              .ceilToDouble(),
                          left: (ScreenUtil().screenWidth / 2).ceilToDouble(),
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Fun",
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    color: HexColor("FF5C28"),
                                    fontSize: 16,
                                  ),
                                ),
                                TextSpan(
                                  text: "Links",
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16,
                                    color: (isDarkMode == true)
                                        ? HexColor("#FFFFFF")
                                        : HexColor("#030C23"),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      // down Shape
                      Positioned(
                        bottom:
                            (-ScreenUtil().screenHeight * 0.120).ceilToDouble(),
                        left: (ScreenUtil().screenWidth / 2.7).ceilToDouble(),
                        child: Container(
                          padding: EdgeInsets.only(right: 20.0),
                          height:
                              (ScreenUtil().screenHeight * 0.26).ceilToDouble(),
                          width:
                              (ScreenUtil().screenWidth * 0.60).ceilToDouble(),
                          margin: EdgeInsets.only(right: 24.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: (isDarkMode == true)
                                  ? AssetImage(
                                      CommonImage.dark_funLinks_second_icon)
                                  : AssetImage(
                                      CommonImage.light_funLinks_second_icon),
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, top: 16.0, right: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 25.0,
                                      width: 25.0,
                                      child: Image.asset(
                                        (isDarkMode == true)
                                            ? CommonImage.dark_play_icon
                                            : CommonImage.light_play_icon,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 0.0,
                                    ),
                                    Text(
                                      "Pick or\nupload\nnew music",
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w700,
                                        color: (isDarkMode == true)
                                            ? HexColor("#FFFFFF")
                                            : HexColor("#030C23"),
                                        fontSize: 14.sp,
                                        shadows: [
                                          Shadow(
                                              color: Color(0xff000000)
                                                  .withOpacity(0.25),
                                              offset: Offset(0, 2),
                                              blurRadius: 2)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: (ScreenUtil().screenHeight * 0.01)
                                    .ceilToDouble(),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) =>
                                          OpenTourScreen(runType: 1)),
                                    ),
                                  );
                                },
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 16.0),
                                    padding: EdgeInsets.only(
                                        left: 8.0,
                                        right: 8.0,
                                        top: 3.0,
                                        bottom: 6.0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            (isDarkMode == true)
                                                ? CommonImage.dark_Funzone_shape
                                                : CommonImage
                                                    .light_Funzone_shape,
                                          ),
                                          fit: BoxFit.fill),
                                    ),
                                    child: Text(
                                      'Enter Funzone',
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.bold,
                                        color: (isDarkMode == true)
                                            ? HexColor("#FFFFFF")
                                            : HexColor("#FF4944"),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 50.0, top: 8.0),
                                  child: SizedBox(
                                    height: 30,
                                    width: 36.77,
                                    child: Image.asset(
                                      (isDarkMode == true)
                                          ? CommonImage.dark_player_icon
                                          : CommonImage.light_player_icon,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // circle
                      Positioned(
                        left: (-ScreenUtil().screenWidth * 0.42).ceilToDouble(),
                        // right: 0.0,
                        // top:0.0,
                        // bottom:0.0,

                        child: AnimatedAlign(
                          alignment:
                              selected ? Alignment.topRight : Alignment.topLeft,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                          child: SizedBox(
                            height: ScreenUtil().screenHeight * 0.440,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      circleButtonImage(
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
                                            print("===============");
                                            selectRegistration =
                                                RegistrationType.FAMELinks
                                                    .toString();
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      circleButtonImage(
                                        imgUrl: (isDarkMode == true)
                                            ? CommonImage.dark_follower_icon
                                            : "assets/icons/followLinks.png",
                                        onTaps: () {
                                          setState(() {
                                            selectPhase = 3;
                                            selected = !selected;
                                            selectRegistration =
                                                RegistrationType.FOLLOWLinks
                                                    .toString();
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                ? CommonImage
                                                    .dark_videoLink_icon
                                                : "assets/icons/funLinks.png",
                                        isButtonSelect: true,
                                        onTaps: () {
                                          print("fsdfsdf");
                                          setState(() {
                                            selectPhase = 0;
                                            selectRegistration =
                                                RegistrationType.FUNLinks
                                                    .toString();
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 20.0,
                                        width: 2.0,
                                        color: Color(0xFF9B9B9B),
                                      ),
                                      circleButtonImage(
                                        onTaps: () {
                                          debugPrint("Hellos");
                                          setState(() {
                                            key = UniqueKey();
                                            selectPhase = 1;
                                            selectedFameLinks =
                                                !selectedFameLinks;
                                            print("===============");
                                            selectRegistration =
                                                RegistrationType.FAMELinks
                                                    .toString();
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
                                      height: (ScreenUtil().screenHeight * 0.18)
                                          .ceilToDouble(),
                                      width: (ScreenUtil().screenWidth * 0.36)
                                          .ceilToDouble(),
                                      child: Image.asset(
                                        (isDarkMode == true)
                                            ? CommonImage.dark_inner_circle_icon
                                            : "assets/images/home_inner_circle.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    //(selectAvatar == '_') ?
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    //           builder: (context) =>
                                    //               PhotoImageScreen(
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
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.all(20.r),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          // Navigator.pushAndRemoveUntil(
                          //    context,
                          //     MaterialPageRoute<void>(builder: (BuildContext context) =>  ProfileFameLink(runSelectPhase: 1)),
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
