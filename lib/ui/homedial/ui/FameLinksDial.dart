import 'package:famelink/common/common_image.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/common_textformfield.dart';

class FameLinksDial extends StatefulWidget {
  const FameLinksDial({Key? key}) : super(key: key);

  @override
  State<FameLinksDial> createState() => _FameLinksDialState();
}

class _FameLinksDialState extends State<FameLinksDial> {
  SharedPreferences? prefs;

  Key key = UniqueKey();

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

  bool isDartMode = false;

  bool status1 = false;

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(
            decoration: (isDartMode == true)
                ? BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(CommonImage.dart_back_img),
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                    ),
                  )
                : BoxDecoration(
                    color: HexColor("#FDFCFA"),
                  ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // welcome
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
                              text: "Welcome to ",
                              style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: (isDartMode == true)
                                    ? Colors.white
                                    : HexColor("#030C23"),
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.8, 0.8),
                                    blurRadius: 0.2,
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                  ),
                                  Shadow(
                                    offset: Offset(0.8, 0.8),
                                    blurRadius: 0.2,
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                  ),
                                ],
                                fontSize: 26,
                              ),
                            ),
                            TextSpan(
                              text: "BUDLINKS",
                              style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 26,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.8, 0.8),
                                    blurRadius: 0.2,
                                    color:
                                        HexColor("#FF5C28").withOpacity(0.25),
                                  ),
                                  Shadow(
                                    offset: Offset(0.8, 0.8),
                                    blurRadius: 0.2,
                                    color:
                                        HexColor("#FF5C28").withOpacity(0.25),
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
                  //bud screen
                  // Text((ScreenUtil().screenHeight * 0.07).ceilToDouble().toString()),
                  SizedBox(
                    height: (ScreenUtil().screenHeight * 0.07).ceilToDouble(),
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
                                          fontSize: 16,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Links",
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16,
                                          shadows: <Shadow>[
                                            Shadow(
                                              color: Color(0xFF000000)
                                                  .withOpacity(0.25),
                                              blurRadius: 4,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                          color: HexColor("#030C23"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  " is all about ",
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14,
                                    color: (isDartMode == true)
                                        ? HexColor("#030C23")
                                        : HexColor("#030C23"),
                                  ),
                                ),
                                Text(
                                  "Earn",
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 18,
                                    color: (isDartMode == true)
                                        ? HexColor("#FF5C28")
                                        : HexColor("#FF5C28"),
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
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14,
                                    color: (isDartMode == true)
                                        ? HexColor("#030C23")
                                        : HexColor("#030C23"),
                                  ),
                                ),
                                Text(
                                  "Grow",
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 18,
                                    color: (isDartMode == true)
                                        ? HexColor("#FF5C28")
                                        : HexColor("#FF5C28"),
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
                                          fontWeight: FontWeight.bold,
                                          color: (isDartMode == true)
                                              ? HexColor("#FFFFFF")
                                              : HexColor("#030C23"),
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        "Trendz",
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.bold,
                                          color: (isDartMode == true)
                                              ? HexColor("#FFFFFF")
                                              : HexColor("#030C23"),
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Container(
                                    color: (isDartMode == true)
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
                                          fontWeight: FontWeight.bold,
                                          color: (isDartMode == true)
                                              ? HexColor("#FFFFFF")
                                              : HexColor("#030C23"),
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "Ambassdors",
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.bold,
                                          color: (isDartMode == true)
                                              ? HexColor("#FFFFFF")
                                              : HexColor("#030C23"),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Container(
                                    color: (isDartMode == true)
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
                                          fontWeight: FontWeight.bold,
                                          color: (isDartMode == true)
                                              ? HexColor("#FFFFFF")
                                              : HexColor("#030C23"),
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        "Contests",
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.bold,
                                          color: (isDartMode == true)
                                              ? HexColor("#FFFFFF")
                                              : HexColor("#030C23"),
                                          fontSize: 20,
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
                  (isDartMode == true)
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
                                  color: (isDartMode == true)
                                      ? HexColor("#FF5C28")
                                      : Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: "LINKS",
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: (isDartMode == true)
                                      ? Colors.white
                                      : HexColor("#FF5C28"),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 27.0,
                          // width: 90.0,
                          padding: EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                            top: 4.0,
                            bottom: 4.0,
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: (isDartMode == true)
                                  ? AssetImage(CommonImage.fame_dark_back)
                                  : AssetImage(CommonImage.fame_light_back),
                            ),
                          ),
                          child: Text(
                            'Enter Fame',
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                              color: (isDartMode == true)
                                  ? Colors.white
                                  : HexColor("#FF5C28"),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //
                  // Container(
                  //   margin: EdgeInsets.only(left: 33.0, right: 33.0),
                  //   height: ScreenUtil().screenHeight * 0.46,
                  //   width: ScreenUtil().screenWidth,
                  //   child: Stack(
                  //     overflow: Overflow.visible,
                  //     fit: StackFit.loose,
                  //     alignment: Alignment.center,
                  //     children: [
                  //       Container(
                  //         height: ScreenUtil().screenHeight,
                  //         width: ScreenUtil().screenWidth,
                  //         child: Image.asset("assets/images/home_outer_circle.png"),
                  //       ),
                  //       // top
                  //       Positioned(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Container(
                  //               width: 60,
                  //               height: 60,
                  //               decoration: new BoxDecoration(
                  //                   boxShadow: [
                  //                     BoxShadow(
                  //                       color: Color(0xFF000000).withOpacity(0.25),
                  //                       spreadRadius: 0,
                  //                       blurRadius: 2,
                  //                       offset: Offset(
                  //                           0, 4), // changes position of shadow
                  //                     ),
                  //                   ],
                  //                   color: Color(0xFF9B9B9B),
                  //                   shape: BoxShape.circle,
                  //                   //gradient: LinearGradient(colors: [Color(0xFFFFA88C), Color(0xFFFF5C28)]),
                  //                   border: Border.all(
                  //                       color: Color(0xFFFFA88C), width: 2)),
                  //               child: Padding(
                  //                 padding: const EdgeInsets.all(10.0),
                  //                 child: new Image.asset(
                  //                   "assets/icons/logo.png",
                  //                   width: 25,
                  //                   height: 28,
                  //                   color: Colors.black,
                  //                 ),
                  //               ),
                  //             ),
                  //             Container(
                  //               height: 20.0,
                  //               width: 2.0,
                  //               color: Color(0xFF9B9B9B),
                  //             ),
                  //           ],
                  //         ),
                  //         top: 0.0,
                  //         left: 0.0,
                  //         right: 0.0,
                  //         bottom: 220.0,
                  //       ),
                  //       // left
                  //       Positioned(
                  //         child: Row(
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Container(
                  //               width: 60,
                  //               height: 60,
                  //               decoration: new BoxDecoration(
                  //                   boxShadow: [
                  //                     BoxShadow(
                  //                       color: Color(0xFF000000).withOpacity(0.25),
                  //                       spreadRadius: 0,
                  //                       blurRadius: 2,
                  //                       offset: Offset(
                  //                           0, 4), // changes position of shadow
                  //                     ),
                  //                   ],
                  //                   color: Colors.white,
                  //                   shape: BoxShape.circle,
                  //                   border: Border.all(color: Color(0xFF9B9B9B))),
                  //               child: Padding(
                  //                 padding: const EdgeInsets.all(10.0),
                  //                 child: new Image.asset(
                  //                   "assets/icons/followLinks.png",
                  //                   width: 25,
                  //                   height: 28,
                  //                   color: Colors.black,
                  //                 ),
                  //               ),
                  //             ),
                  //             Container(
                  //               width: 22.0,
                  //               height: 2.0,
                  //               color: Color(0xFF9B9B9B),
                  //             )
                  //           ],
                  //         ),
                  //         top: 0.0,
                  //         right: 220.0,
                  //         left: 0.0,
                  //         bottom: 0.0,
                  //         // right: MediaQuery.of(context).size.width/2,
                  //       ),
                  //       // right
                  //       Positioned(
                  //         child: Row(
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Container(
                  //               width: 22.0,
                  //               height: 2.0,
                  //               color: Color(0xFF9B9B9B),
                  //             ),
                  //             Container(
                  //               width: 60,
                  //               height: 60,
                  //               decoration: new BoxDecoration(
                  //                   boxShadow: [
                  //                     BoxShadow(
                  //                       color: Color(0xFF000000).withOpacity(0.25),
                  //                       spreadRadius: 0,
                  //                       blurRadius: 2,
                  //                       offset: Offset(
                  //                           0, 4), // changes position of shadow
                  //                     ),
                  //                   ],
                  //                   color: Colors.white,
                  //                   shape: BoxShape.circle,
                  //                   border: Border.all(color: Color(0xFF9B9B9B))),
                  //               child: Padding(
                  //                 padding: const EdgeInsets.all(10.0),
                  //                 child: new Image.asset(
                  //                   "assets/icons/funLinks.png",
                  //                   width: 25,
                  //                   height: 28,
                  //                   color: Colors.black,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         top: 0.0,
                  //         right: 0.0,
                  //         left: 220.0,
                  //         bottom: 0.0,
                  //       ),
                  //       // bottom
                  //       Positioned(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Container(
                  //               height: 20.0,
                  //               width: 2.0,
                  //               color: Color(0xFF9B9B9B),
                  //             ),
                  //             Container(
                  //               width: 60,
                  //               height: 60,
                  //               decoration: new BoxDecoration(
                  //                   boxShadow: [
                  //                     BoxShadow(
                  //                       color: Color(0xFF000000).withOpacity(0.25),
                  //                       spreadRadius: 0,
                  //                       blurRadius: 2,
                  //                       offset: Offset(
                  //                           0, 4), // changes position of shadow
                  //                     ),
                  //                   ],
                  //                   color: Colors.white,
                  //                   shape: BoxShape.circle,
                  //                   border: Border.all(color: Color(0xFF9B9B9B))),
                  //               child: Padding(
                  //                 padding: const EdgeInsets.all(10.0),
                  //                 child: new Image.asset(
                  //                   "assets/icons/vector.png",
                  //                   width: 25,
                  //                   height: 28,
                  //                   color: Colors.black,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         top: 220.0,
                  //         left: 0.0,
                  //         right: 0.0,
                  //         bottom: 0.0,
                  //         // right: MediaQuery.of(context).size.width/2,
                  //       ),
                  //
                  //       Stack(
                  //         overflow: Overflow.visible,
                  //         fit: StackFit.loose,
                  //         alignment: Alignment.center,
                  //         children: [
                  //           Container(
                  //               height: 144,
                  //               width: 144,
                  //               child: Image.asset(
                  //                   "assets/images/home_inner_circle.png")),
                  //           Column(
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Image.asset("assets/images/feather_upload.png"),
                  //               SizedBox(
                  //                 height: 8,
                  //               ),
                  //               Text(
                  //                 "Your Avatar",
                  //                 style: TextStyle(
                  //                     fontSize: 12, color: Color(0xFF9B9B9B)),
                  //               )
                  //             ],
                  //           )
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // ),

                  Container(
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
                            (isDartMode == true)
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
                                imgUrl: (true)
                                    ? "assets/icons/darkFamelinkIcon.png"
                                    : (isDartMode == true)
                                        ? "assets/icons/darkFamelinkIcon.png"
                                        : "assets/icons/logo.png",
                                onTaps: () {},
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
                                imgUrl: (isDartMode == true)
                                    ? CommonImage.dark_follower_icon
                                    : "assets/icons/followLinks.png",
                                onTaps: () {},
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
                                imgUrl: (isDartMode == true)
                                    ? CommonImage.dark_videoLink_icon
                                    : "assets/icons/funLinks.png",
                                onTaps: () {},
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
                                onTaps: () {},
                                imgUrl: (isDartMode == true)
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
                                child: Image.asset((isDartMode == true)
                                    ? CommonImage.dark_inner_circle_icon
                                    : "assets/images/home_inner_circle.png")),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/feather_upload.png"),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Your Avatar",
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xFF9B9B9B)),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  Container(
                    height: ScreenUtil().screenHeight * 0.24,
                    child: Column(
                      children: <Widget>[
                        // Individual  design
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Individual',
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  color: (isDartMode == true)
                                      ? Colors.white
                                      : HexColor("#030C23"),
                                  fontSize: 14.0,
                                ),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              SvgPicture.asset(
                                CommonImage.individual_icon,
                                height: 12.0,
                                width: 13.0,
                                color: (isDartMode == true)
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: (ScreenUtil().screenHeight * 0.01)
                              .ceilToDouble(),
                        ),
                        // Name Field
                        Padding(
                          padding: EdgeInsets.only(left: 12.0, right: 12.0),
                          child: Column(
                            children: <Widget>[
                              (isDartMode == true)
                                  ? Container(
                                width: ScreenUtil().screenWidth,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(CommonImage
                                          .bottom_shape_container),
                                      fit: BoxFit.fill),
                                ),
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 30.0,
                                          width: 30.0,
                                          child: CircleAvatar(
                                            radius: 0,
                                            backgroundColor:
                                            HexColor("#FF5C28"),
                                            child: CircleAvatar(
                                              backgroundImage:
                                              NetworkImage(
                                                  "https://ui-avatars.com/api/?name=GA"),
                                              radius: 13,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            child:
                                            CommonTextFormField(
                                              fillColors: HexColor(
                                                  "#9B9B9B")
                                                  .withOpacity(0.03),
                                              underLineColors:
                                              HexColor("#9B9B9B")
                                                  .withOpacity(
                                                  0.03),
                                              bottomPadding: 7.0,
                                              hintText:
                                              'Enter your Name',
                                              hintStyle: GoogleFonts
                                                  .nunitoSans(
                                                fontWeight:
                                                FontWeight.w400,
                                                fontStyle:
                                                FontStyle.italic,
                                                color: HexColor(
                                                    "#FFFFFF")
                                                    .withOpacity(
                                                    0.50),
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            height: 25.0,
                                          ),
                                        ),
                                        Text(
                                          'Date of Birth',
                                          style:
                                          GoogleFonts.nunitoSans(
                                            fontWeight:
                                            FontWeight.w400,
                                            fontStyle:
                                            FontStyle.italic,
                                            color: HexColor("#9B9B9B")
                                                .withOpacity(0.45),
                                            fontSize: 18.0,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 7.0,
                                    ),
                                    Divider(
                                      height: 1,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 7.0,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: SizedBox(
                                            child:
                                            CommonTextFormField(
                                              fillColors: HexColor(
                                                  "#9B9B9B")
                                                  .withOpacity(0.03),
                                              underLineColors:
                                              HexColor("#9B9B9B")
                                                  .withOpacity(
                                                  0.03),
                                              bottomPadding: 12.0,
                                              hintText:
                                              'Enter your District Name (first 3 char)',
                                              hintStyle: GoogleFonts
                                                  .nunitoSans(
                                                fontWeight:
                                                FontWeight.w400,
                                                fontStyle:
                                                FontStyle.italic,
                                                color: HexColor(
                                                    "#FFFFFF")
                                                    .withOpacity(
                                                    0.50),
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            height: 16,
                                          ),
                                        ),
                                        Text(
                                          '@@',
                                          style:
                                          GoogleFonts.nunitoSans(
                                            fontWeight:
                                            FontWeight.w600,
                                            fontStyle:
                                            FontStyle.italic,
                                            color:
                                            HexColor("#FF5C28"),
                                            fontSize: 14.0,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 7.0,
                                    ),
                                  ],
                                ),
                              )
                                  : Card(
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(12.0)),
                                child: Container(
                                  width: ScreenUtil().screenWidth,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(12.0),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color.fromRGBO(
                                          255, 255, 255, 0.5),
                                      width: 1.0,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.35),
                                        blurRadius: 0.25,
                                        offset: Offset(
                                            -0, 5), // Shadow position
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 30.0,
                                            width: 30.0,
                                            child: CircleAvatar(
                                              radius: 0,
                                              backgroundColor:
                                              HexColor("#FF5C28"),
                                              child: CircleAvatar(
                                                backgroundImage:
                                                NetworkImage(
                                                    "https://ui-avatars.com/api/?name=GA"),
                                                radius: 13,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              child:
                                              CommonTextFormField(
                                                bottomPadding: 7.0,
                                                fillColors:
                                                Colors.white,
                                                hintText:
                                                'Enter your Name',
                                                hintStyle: GoogleFonts
                                                    .nunitoSans(
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  fontStyle: FontStyle
                                                      .italic,
                                                  color: HexColor(
                                                      "#9B9B9B"),
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                              height: 25.0,
                                            ),
                                          ),
                                          Text(
                                            'Date of Birth',
                                            style: GoogleFonts
                                                .nunitoSans(
                                              fontWeight:
                                              FontWeight.w400,
                                              fontStyle:
                                              FontStyle.italic,
                                              color:
                                              HexColor("#9B9B9B"),
                                              fontSize: 18.0,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 7.0,
                                      ),
                                      Divider(
                                        height: 1,
                                        color: HexColor("#9B9B9B"),
                                      ),
                                      const SizedBox(
                                        height: 7.0,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: SizedBox(
                                              child:
                                              CommonTextFormField(
                                                bottomPadding: 12.0,
                                                fillColors:
                                                Colors.white,
                                                hintText:
                                                'Enter your District Name (first 3 char)',
                                                hintStyle: GoogleFonts
                                                    .nunitoSans(
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  fontStyle: FontStyle
                                                      .italic,
                                                  color: HexColor(
                                                      "#9B9B9B"),
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                              height: 16,
                                            ),
                                          ),
                                          Text(
                                            '@@',
                                            style: GoogleFonts
                                                .nunitoSans(
                                              fontWeight:
                                              FontWeight.w600,
                                              fontStyle:
                                              FontStyle.italic,
                                              color:
                                              HexColor("#FF5C28"),
                                              fontSize: 14.0,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: (ScreenUtil().screenHeight * 0.03)
                                    .ceilToDouble(),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Skip & Enter ->',
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    color: (isDartMode == true)
                                        ? Colors.white
                                        : HexColor("#4B4E58"),
                                    fontSize: 12.0,
                                  ),
                                ),
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
                          ? CommonImage.dark_circle_avatar_back
                          : CommonImage.light_circle_avatar_back,
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
