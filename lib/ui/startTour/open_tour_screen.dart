import 'package:dots_indicator/dots_indicator.dart';
import 'package:famelink/common/common_image.dart';
import 'package:famelink/ui/authentication/login_screen.dart';
import 'package:famelink/ui/home_feed/view/main_feed_screen.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/registerDialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../util/constants.dart';
import '../settings/WebViewScreen.dart';

class OpenTourScreen extends StatefulWidget {
  final runType;
  final isFrom;

  OpenTourScreen({this.runType, this.isFrom});

  @override
  _OpenTourScreenState createState() => _OpenTourScreenState();
}

class _OpenTourScreenState extends State<OpenTourScreen> {
  int selectedPage = 0;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   systemNavigationBarColor: Colors.transparent, // navigation bar color
    //   statusBarColor: Colors.transparent, // status bar color
    //   statusBarIconBrightness: Brightness.dark, // status bar icons' color
    //   systemNavigationBarIconBrightness: Brightness.dark
    // ));
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                  physics: PageScrollPhysics(),
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  allowImplicitScrolling: true,
                  pageSnapping: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return selectedPage == 0
                        ? Container(
                            margin: EdgeInsets.only(
                                bottom: ScreenUtil().setHeight(40)),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(48),
                                        left: ScreenUtil().setWidth(24),
                                        right: ScreenUtil().setWidth(24),
                                        bottom: ScreenUtil().setHeight(24)),
                                    child: _topBar(context),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: ScreenUtil().setHeight(24),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text('It’s the World’s First',
                                                style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w400,
                                                  color: black,
                                                  fontSize:
                                                      ScreenUtil().setSp(22),
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 2.0),
                                                      blurRadius: 2.0,
                                                      color: Color(0xff000000)
                                                          .withOpacity(0.25),
                                                    ),
                                                  ],
                                                )),
                                            Text('Beauty Contest App',
                                                style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w700,
                                                  color: black,
                                                  fontSize:
                                                      ScreenUtil().setSp(24),
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 2.0),
                                                      blurRadius: 2.0,
                                                      color: Color(0xff000000)
                                                          .withOpacity(0.25),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                        ),
                                      ),
                                      SvgPicture.asset(
                                          "assets/icons/Fashion.svg"),
                                      SizedBox(
                                        width: ScreenUtil().setHeight(5),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(10),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 19.w),
                                    child:
                                        Image.asset("assets/icons/tour_1.png"),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : index == 1
                            ? Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenUtil().setHeight(40)),
                                padding: EdgeInsets.only(
                                    left: ScreenUtil().setHeight(24),
                                    right: ScreenUtil().setHeight(24)),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(48),
                                            bottom: ScreenUtil().setHeight(24)),
                                        child: _topBar(context),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Text.rich(TextSpan(
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: 'Audience',
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: black,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(24),
                                                            shadows: <Shadow>[
                                                              Shadow(
                                                                offset: Offset(
                                                                    0.0, 2.0),
                                                                blurRadius: 2.0,
                                                                color: Color(
                                                                        0xff000000)
                                                                    .withOpacity(
                                                                        0.25),
                                                              ),
                                                            ],
                                                          )),
                                                      TextSpan(
                                                          text:
                                                              ' is the Judge.',
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(22),
                                                            color: black,
                                                            shadows: <Shadow>[
                                                              Shadow(
                                                                offset: Offset(
                                                                    0.0, 2.0),
                                                                blurRadius: 2.0,
                                                                color: Color(
                                                                        0xff000000)
                                                                    .withOpacity(
                                                                        0.25),
                                                              ),
                                                            ],
                                                          )),
                                                    ])),
                                                Text.rich(TextSpan(
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: 'So win their',
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: black,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(22),
                                                            shadows: <Shadow>[
                                                              Shadow(
                                                                offset: Offset(
                                                                    0.0, 2.0),
                                                                blurRadius: 2.0,
                                                                color: Color(
                                                                        0xff000000)
                                                                    .withOpacity(
                                                                        0.25),
                                                              ),
                                                            ],
                                                          )),
                                                      TextSpan(
                                                          text: ' Full Heart',
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(22),
                                                            color: lightRed,
                                                            shadows: <Shadow>[
                                                              Shadow(
                                                                offset: Offset(
                                                                    0.0, 2.0),
                                                                blurRadius: 2.0,
                                                                color: Color(
                                                                        0xff000000)
                                                                    .withOpacity(
                                                                        0.25),
                                                              ),
                                                            ],
                                                          )),
                                                    ])),
                                              ],
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                            ),
                                          ),
                                          SvgPicture.asset(
                                              "assets/icons/heart_rating.svg"),
                                          SizedBox(
                                            width: ScreenUtil().setHeight(5),
                                          ),
                                        ],
                                      ),
                                      Text(
                                          'Increase your chance by following these Rules-',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: buttonBlue,
                                              fontSize:
                                                  ScreenUtil().setSp(15))),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(12),
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/svg/checkbox.svg"),
                                          SizedBox(
                                            width: ScreenUtil().setHeight(16),
                                          ),
                                          Expanded(
                                            child: Text.rich(
                                                TextSpan(children: <TextSpan>[
                                              TextSpan(
                                                  text: 'Upload your',
                                                  style: GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: black,
                                                      fontSize: ScreenUtil()
                                                          .setSp(18))),
                                              TextSpan(
                                                  text:
                                                      ' 6 best Photos & 1 Video.',
                                                  style: GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: ScreenUtil()
                                                          .setSp(18),
                                                      color: black)),
                                              TextSpan(
                                                  text:
                                                      ' (Upload in all options type as below)',
                                                  style: GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: ScreenUtil()
                                                          .setSp(12),
                                                      color: black)),
                                            ])),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(16),
                                      ),
                                      Image.asset(
                                          "assets/icons/user_frame.png"),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(24),
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/svg/checkbox.svg"),
                                          SizedBox(
                                            width: ScreenUtil().setHeight(16),
                                          ),
                                          Expanded(
                                            child: Text.rich(
                                                TextSpan(children: <TextSpan>[
                                              TextSpan(
                                                  text: 'Never miss a day',
                                                  style: GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: black,
                                                      fontSize: ScreenUtil()
                                                          .setSp(18))),
                                              TextSpan(
                                                  text:
                                                      ' to stay on top among other contestants',
                                                  style: GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: ScreenUtil()
                                                          .setSp(18),
                                                      color: black)),
                                            ])),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(24),
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/svg/checkbox.svg"),
                                          SizedBox(
                                            width: ScreenUtil().setHeight(16),
                                          ),
                                          Expanded(
                                            child: Text.rich(
                                                TextSpan(children: <TextSpan>[
                                              TextSpan(
                                                  text: 'Join in Trends',
                                                  style: GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: black,
                                                      fontSize: ScreenUtil()
                                                          .setSp(18))),
                                              TextSpan(
                                                  text:
                                                      ' to Earn Cash & also increase your overall score',
                                                  style: GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: ScreenUtil()
                                                          .setSp(18),
                                                      color: black)),
                                            ])),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : index == 2
                                ? Container(
                                    margin: EdgeInsets.only(
                                        bottom: ScreenUtil().setHeight(40)),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(48),
                                                left: ScreenUtil().setWidth(24),
                                                right:
                                                    ScreenUtil().setWidth(24)),
                                            child: _topBar(context),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: ScreenUtil()
                                                          .setHeight(24),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Container(
                                                                height: 100.h,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: Stack(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomLeft,
                                                                  children: [
                                                                    Positioned(
                                                                      top: 2.r,
                                                                      right:
                                                                          35.r,
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/icons/tour_3.png",
                                                                        height:
                                                                            ScreenUtil().setWidth(80),
                                                                        width: ScreenUtil()
                                                                            .setWidth(80),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              20),
                                                                          color:
                                                                              white),
                                                                      child: Text.rich(
                                                                          TextSpan(
                                                                              children: <TextSpan>[
                                                                            TextSpan(
                                                                                text: 'Quick win',
                                                                                style: GoogleFonts.nunitoSans(
                                                                                  fontWeight: FontWeight.w400,
                                                                                  color: black,
                                                                                  fontSize: ScreenUtil().setSp(22),
                                                                                  shadows: <Shadow>[
                                                                                    Shadow(
                                                                                      offset: Offset(0.0, 2.0),
                                                                                      blurRadius: 2.0,
                                                                                      color: Color(0xff000000).withOpacity(0.25),
                                                                                    ),
                                                                                  ],
                                                                                )),
                                                                            TextSpan(
                                                                                text: ' @FashionTrendz.',
                                                                                style: GoogleFonts.nunitoSans(
                                                                                  fontWeight: FontWeight.w400,
                                                                                  fontSize: ScreenUtil().setSp(22),
                                                                                  color: lightRed,
                                                                                  shadows: <Shadow>[
                                                                                    Shadow(
                                                                                      offset: Offset(0.0, 2.0),
                                                                                      blurRadius: 2.0,
                                                                                      color: Color(0xff000000).withOpacity(0.25),
                                                                                    ),
                                                                                  ],
                                                                                )),
                                                                          ])),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Text.rich(TextSpan(
                                                              children: <TextSpan>[
                                                                TextSpan(
                                                                    text:
                                                                        'Forever win',
                                                                    style: GoogleFonts
                                                                        .nunitoSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color:
                                                                          black,
                                                                      fontSize:
                                                                          ScreenUtil()
                                                                              .setSp(22),
                                                                      shadows: <Shadow>[
                                                                        Shadow(
                                                                          offset: Offset(
                                                                              0.0,
                                                                              2.0),
                                                                          blurRadius:
                                                                              2.0,
                                                                          color:
                                                                              Color(0xff000000).withOpacity(0.25),
                                                                        ),
                                                                      ],
                                                                    )),
                                                                TextSpan(
                                                                    text:
                                                                        ' @BeautyContests',
                                                                    style: GoogleFonts
                                                                        .nunitoSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          ScreenUtil()
                                                                              .setSp(22),
                                                                      color:
                                                                          buttonBlue,
                                                                      shadows: <Shadow>[
                                                                        Shadow(
                                                                          offset: Offset(
                                                                              0.0,
                                                                              2.0),
                                                                          blurRadius:
                                                                              2.0,
                                                                          color:
                                                                              Color(0xff000000).withOpacity(0.25),
                                                                        ),
                                                                      ],
                                                                    )),
                                                              ])),
                                                        ],
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: ScreenUtil()
                                                          .setHeight(5),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(22),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: ScreenUtil().setWidth(24),
                                                right:
                                                    ScreenUtil().setWidth(24)),
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8.h),
                                                  child: SvgPicture.asset(
                                                    "assets/icons/tour_2.svg",
                                                    height: 38.h,
                                                    width: 192.w,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 32),
                                                  child: Image.asset(
                                                      "assets/icons/tour_4.png"),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(30),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : index == 3
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(40)),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: ScreenUtil()
                                                        .setHeight(48),
                                                    left: ScreenUtil()
                                                        .setWidth(24),
                                                    right: ScreenUtil()
                                                        .setWidth(24),
                                                    bottom: ScreenUtil()
                                                        .setHeight(24)),
                                                child: _topBar(context),
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: ScreenUtil()
                                                        .setHeight(24),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Text.rich(TextSpan(
                                                            children: <TextSpan>[
                                                              TextSpan(
                                                                  text:
                                                                      'Beauty is redefined.',
                                                                  //Your links to
                                                                  style: GoogleFonts
                                                                      .nunitoSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        black,
                                                                    fontSize: ScreenUtil()
                                                                        .setSp(
                                                                            22),
                                                                    shadows: <Shadow>[
                                                                      Shadow(
                                                                        offset: Offset(
                                                                            0.0,
                                                                            2.0),
                                                                        blurRadius:
                                                                            2.0,
                                                                        color: Color(0xff000000)
                                                                            .withOpacity(0.25),
                                                                      ),
                                                                    ],
                                                                  )), //22
                                                              TextSpan(
                                                                  text:
                                                                      ' @Fashion Trendz',
                                                                  style: GoogleFonts
                                                                      .nunitoSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize: ScreenUtil()
                                                                        .setSp(
                                                                            24), //24
                                                                    color:
                                                                        black,
                                                                    shadows: <Shadow>[
                                                                      Shadow(
                                                                        offset: Offset(
                                                                            0.0,
                                                                            2.0),
                                                                        blurRadius:
                                                                            2.0,
                                                                        color: Color(0xff000000)
                                                                            .withOpacity(0.25),
                                                                      ),
                                                                    ],
                                                                  )),
                                                            ])),
                                                      ],
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                    ),
                                                  ),
                                                  SvgPicture.asset(
                                                    "assets/icons/amico.svg",
                                                    width: 169.w,
                                                    height: 183.h,
                                                  ),
                                                  SizedBox(
                                                    width: ScreenUtil()
                                                        .setHeight(5),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(30),
                                              ),
                                              Container(
                                                height:
                                                    ScreenUtil().setHeight(300),
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      left: 0,
                                                      right: 0,
                                                      top: 20.h,
                                                      child: Container(
                                                          height: ScreenUtil()
                                                              .setHeight(250),
                                                          child: Image.asset(
                                                              'assets/images/Ellipse 153.png')),
                                                    ),
                                                    Positioned(
                                                        top: 0,
                                                        left: 44.w,
                                                        bottom: 0,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              color: white,
                                                              child: Text.rich(
                                                                TextSpan(
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text:
                                                                              'Brand or Agency\n',
                                                                          //Your links to
                                                                          style: GoogleFonts.nunitoSans(
                                                                              fontWeight: FontWeight.w400,
                                                                              color: black,
                                                                              fontSize: ScreenUtil().setSp(16))),
                                                                      //22
                                                                      TextSpan(
                                                                          text:
                                                                              'Creates',
                                                                          style: GoogleFonts.nunitoSans(
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: ScreenUtil().setSp(20),
                                                                              //24
                                                                              color: buttonBlue)),
                                                                    ]),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                    Positioned(
                                                        top: 90.h,
                                                        left: 56.w,
                                                        bottom: 0,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 72.h,
                                                              width: 72.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: black
                                                                        .withOpacity(
                                                                            0.25),
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            3),
                                                                    blurRadius:
                                                                        4,
                                                                  )
                                                                ],
                                                              ),
                                                              child: Center(
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  CommonImage
                                                                      .ic_trend,
                                                                  height: 44.h,
                                                                  width: 44.w,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                    Positioned(
                                                        top: 72.h,
                                                        left: 44.w,
                                                        bottom: 0,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 32.w,
                                                              width: 32.w,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6),
                                                                  border: Border.all(
                                                                      width:
                                                                          1.5,
                                                                      color:
                                                                          lightGray),
                                                                  color: white),
                                                              child: Center(
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: orange,
                                                                  size: 24,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                    Positioned(
                                                        top: 38.h,
                                                        right: 44.w,
                                                        bottom: 0,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 120.h,
                                                              width: 100.w,
                                                              child: Stack(
                                                                children: [
                                                                  Positioned(
                                                                      top: 0,
                                                                      left:
                                                                          26.w,
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/ic_tour_4_img2.png',
                                                                        height:
                                                                            115.h,
                                                                        width:
                                                                            65.w,
                                                                      )),
                                                                  Positioned(
                                                                    top: 0,
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/ic_tour_4_img1.png',
                                                                      height:
                                                                          115.h,
                                                                      width:
                                                                          65.w,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                    Positioned(
                                                        top: 0,
                                                        left: 44.w,
                                                        bottom: 0,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              color: white,
                                                              child: Text.rich(
                                                                TextSpan(
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text:
                                                                              'Brand or Agency\n',
                                                                          //Your links to
                                                                          style: GoogleFonts.nunitoSans(
                                                                              fontWeight: FontWeight.w400,
                                                                              color: black,
                                                                              fontSize: ScreenUtil().setSp(16))),
                                                                      //22
                                                                      TextSpan(
                                                                          text:
                                                                              'Creates',
                                                                          style: GoogleFonts.nunitoSans(
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: ScreenUtil().setSp(20),
                                                                              //24
                                                                              color: buttonBlue)),
                                                                    ]),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                    Positioned(
                                                        top: 0,
                                                        right: 44.w,
                                                        bottom: 0,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              color: white,
                                                              child: Text.rich(
                                                                TextSpan(
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text:
                                                                              'Contestant\n',
                                                                          //Your links to
                                                                          style: GoogleFonts.nunitoSans(
                                                                              fontWeight: FontWeight.w400,
                                                                              color: black,
                                                                              fontSize: ScreenUtil().setSp(16))),
                                                                      //22
                                                                      TextSpan(
                                                                          text:
                                                                              'Participates',
                                                                          style: GoogleFonts.nunitoSans(
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: ScreenUtil().setSp(20),
                                                                              //24
                                                                              color: orange)),
                                                                    ]),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                    Positioned(
                                                        top: 72.h,
                                                        right: 105.w,
                                                        bottom: 0,
                                                        child: SvgPicture.asset(
                                                            'assets/icons/ic_right_arrow.svg')),
                                                    Positioned(
                                                        top: 72.h,
                                                        left: 105.w,
                                                        bottom: 0,
                                                        child: SvgPicture.asset(
                                                            'assets/icons/ic_left_arrow.svg')),
                                                    Positioned(
                                                        left: 0,
                                                        right: 0,
                                                        bottom: 52.h,
                                                        child: Column(
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/icons/ic_middle_heart.svg',
                                                              width: 52.w,
                                                              height: 49.h,
                                                            ),
                                                          ],
                                                        )),
                                                    Positioned(
                                                        left: 0,
                                                        right: 0,
                                                        bottom: 4.h,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              color: white,
                                                              child: Text.rich(
                                                                TextSpan(
                                                                    children: <TextSpan>[
                                                                      TextSpan(
                                                                          text:
                                                                              'Audience\n',
                                                                          //Your links to
                                                                          style: GoogleFonts.nunitoSans(
                                                                              fontWeight: FontWeight.w400,
                                                                              color: black,
                                                                              fontSize: ScreenUtil().setSp(16))),
                                                                      //22
                                                                      TextSpan(
                                                                          text:
                                                                              'Rates & Both',
                                                                          style: GoogleFonts.nunitoSans(
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: ScreenUtil().setSp(20),
                                                                              //24
                                                                              color: black)),
                                                                    ]),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : index == 4
                                        ? Container(
                                            margin: EdgeInsets.only(
                                                bottom:
                                                    ScreenUtil().setHeight(40)),
                                            child: Stack(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: ScreenUtil()
                                                              .setHeight(48),
                                                          left: ScreenUtil()
                                                              .setWidth(24),
                                                          right: ScreenUtil()
                                                              .setWidth(24),
                                                          bottom: ScreenUtil()
                                                              .setHeight(24)),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text.rich(TextSpan(
                                                              children: <TextSpan>[
                                                                TextSpan(
                                                                    text:
                                                                        'Get set for',
                                                                    style: GoogleFonts
                                                                        .nunitoSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color:
                                                                          black,
                                                                      fontSize:
                                                                          ScreenUtil()
                                                                              .setSp(26),
                                                                      shadows: <Shadow>[
                                                                        Shadow(
                                                                          offset: Offset(
                                                                              0.0,
                                                                              2.0),
                                                                          blurRadius:
                                                                              2.0,
                                                                          color:
                                                                              Color(0xff000000).withOpacity(0.25),
                                                                        ),
                                                                      ],
                                                                    )),
                                                                TextSpan(
                                                                    text:
                                                                        ' FUN & FAME',
                                                                    style: GoogleFonts
                                                                        .nunitoSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          ScreenUtil()
                                                                              .setSp(26),
                                                                      color:
                                                                          lightRed,
                                                                      shadows: <Shadow>[
                                                                        Shadow(
                                                                          offset: Offset(
                                                                              0.0,
                                                                              2.0),
                                                                          blurRadius:
                                                                              2.0,
                                                                          color:
                                                                              Color(0xff000000).withOpacity(0.25),
                                                                        ),
                                                                      ],
                                                                    )),
                                                              ])),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: ScreenUtil()
                                                              .setWidth(24),
                                                          top: ScreenUtil()
                                                              .setWidth(36)),
                                                      child: Text(
                                                        'There are four links to your Fame...',
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            14),
                                                                color:
                                                                    darkGrey),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Image.asset(
                                                    'assets/images/ic_dialer_sample.jpg',
                                                    height: 159.h,
                                                  ),
                                                ),
                                                Positioned(
                                                    top: 0,
                                                    bottom: 0,
                                                    left: ScreenUtil()
                                                        .setWidth(24),
                                                    right: 0,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            width: 155.w,
                                                            height: 114.h,
                                                            child: Stack(
                                                                children: [
                                                                  Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child: SvgPicture
                                                                          .asset(
                                                                        'assets/icons/ic_tour_5_dialog.svg',
                                                                        width:
                                                                            155.w,
                                                                        height:
                                                                            114.h,
                                                                      )),
                                                                  Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(right: 16),
                                                                        child:
                                                                            Text(
                                                                          'You can switch \nbetween different \nLinks using the \nNavigation Dial',
                                                                          style:
                                                                              GoogleFonts.nunitoSans(
                                                                            fontSize:
                                                                                ScreenUtil().setSp(14),
                                                                            color:
                                                                                black,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                      ))
                                                                ])),
                                                      ],
                                                    )),
                                                Positioned(
                                                    bottom: 120.h,
                                                    left: 0,
                                                    right: 0,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () => Navigator
                                                              .pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              MainFeedScreen())),
                                                          child: Container(
                                                            width: 164.w,
                                                            height: 34.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient: Constants
                                                                  .glassGradient,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              border:
                                                                  GradientBoxBorder(
                                                                gradient: Constants
                                                                    .appThemeGradient,
                                                                width: 1,
                                                              ),
                                                            ),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Get Right In',
                                                                  style: GoogleFonts
                                                                      .nunitoSans(
                                                                    fontSize: ScreenUtil()
                                                                        .setSp(
                                                                            16),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color(
                                                                        0xFFFF5C28),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: 8),
                                                                Icon(
                                                                  Icons
                                                                      .arrow_forward,
                                                                  color: Color(
                                                                      0xFFFF5C28),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                Positioned(
                                                  bottom: 30.h,
                                                  left: 0,
                                                  right: 0,
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: ScreenUtil()
                                                              .setWidth(24),
                                                          right: ScreenUtil()
                                                              .setWidth(24)),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          text:
                                                              'By continuing, you agree to the FameLinks ',
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: black,
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              12)),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text:
                                                                    'Terms of Usage',
                                                                style: GoogleFonts.nunitoSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline,
                                                                    fontSize: ScreenUtil()
                                                                        .setSp(
                                                                            12)),
                                                                recognizer:
                                                                    TapGestureRecognizer()
                                                                      ..onTap =
                                                                          () async {
                                                                        // print('terms & usage');
                                                                        await Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (ontext) => WebViewScreen("Terms of Usage & Services")),
                                                                        );
                                                                      }),
                                                            TextSpan(
                                                                text: ', '),
                                                            TextSpan(
                                                                text:
                                                                    'Community Guidelines',
                                                                style: GoogleFonts.nunitoSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline,
                                                                    fontSize: ScreenUtil()
                                                                        .setSp(
                                                                            12)),
                                                                recognizer:
                                                                    TapGestureRecognizer()
                                                                      ..onTap =
                                                                          () async {
                                                                        await Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (ontext) => WebViewScreen("Community Guidelines")),
                                                                        );
                                                                      }),
                                                            TextSpan(
                                                                text: ' and ',
                                                                style: GoogleFonts
                                                                    .nunitoSans(
                                                                        fontSize:
                                                                            ScreenUtil().setSp(12))),
                                                            TextSpan(
                                                                text:
                                                                    'Privacy Policy',
                                                                style: GoogleFonts.nunitoSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline,
                                                                    fontSize: ScreenUtil()
                                                                        .setSp(
                                                                            12)),
                                                                recognizer:
                                                                    TapGestureRecognizer()
                                                                      ..onTap =
                                                                          () async {
                                                                        await Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (ontext) => WebViewScreen("Privacy Policy")),
                                                                        );
                                                                      }),
                                                          ],
                                                        ),
                                                      )),
                                                )
                                              ],
                                            ),
                                          )
                                        : widget.isFrom == 'register' &&
                                                index == 4
                                            ? GestureDetector(
                                                onHorizontalDragEnd:
                                                    (dragDetail) {},
                                                child: Container())
                                            : Container(
                                                color: white,
                                              );
                  },
                  onPageChanged: (count) {
                    setState(() {
                      selectedPage = count;
                    });
                  },
                ),
                selectedPage == 4
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: InkWell(
                                onTap: () {
                                  if (selectedPage == 3) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainFeedScreen()));
                                  } else {
                                    pageController.animateToPage(5,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeIn);
                                  }
                                },
                                child: Text(
                                  selectedPage == 3 ? 'Enter >' : 'Skip Tour >',
                                  style: GoogleFonts.nunitoSans(
                                    color: Colors.transparent,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            DotsIndicator(
                              reversed: false,
                              dotsCount: 4,
                              position: selectedPage.toDouble(),
                              decorator: DotsDecorator(
                                  size: Size.square(ScreenUtil().setWidth(5)),
                                  activeSize: Size(ScreenUtil().setWidth(7),
                                      ScreenUtil().setWidth(7)),
                                  activeColor: lightRed,
                                  color: darkGray,
                                  spacing: const EdgeInsets.symmetric(
                                      horizontal: 3.0),
                                  activeShape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0))),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: InkWell(
                                onTap: () {
                                  registerDialog(context);
                                },
                                child: InkWell(
                                  onTap: () {
                                    if (selectedPage == 3) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MainFeedScreen()));
                                    } else {
                                      pageController.animateToPage(5,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeIn);
                                    }
                                  },
                                  child: Text(
                                    selectedPage == 3
                                        ? 'Enter >'
                                        : 'Skip Tour >',
                                    style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }

  final pageDecor = PageDecoration(
      fullScreen: true,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
      bodyTextStyle: TextStyle(color: Color(0xFF262626)),
      contentMargin: EdgeInsets.all(8));

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );

  Widget _topBar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(
              text: 'KNOW',
              style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w700,
                color: black,
                fontSize: ScreenUtil().setSp(26),
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0.0, 2.0),
                    blurRadius: 2.0,
                    color: Color(0xff000000).withOpacity(0.25),
                  ),
                ],
              )),
          TextSpan(
              text: ' FAMELINKS',
              style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w700,
                fontSize: ScreenUtil().setSp(26),
                color: lightRed,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0.0, 2.0),
                    blurRadius: 2.0,
                    color: Color(0xff000000).withOpacity(0.25),
                  ),
                ],
              )),
        ])),
        Text('in just 4 steps',
            style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w400,
                color: lightGray,
                fontSize: ScreenUtil().setSp(20))),
      ],
    );
  }
}
