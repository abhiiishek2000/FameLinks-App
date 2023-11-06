import 'package:dotted_border/dotted_border.dart';
import 'package:famelink/databse/db_provider.dart';
import 'package:famelink/tour_links_dialogs/provider/tour_dialog_provider.dart';
import 'package:famelink/ui/home_feed/provider/home_feed_provider.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../common/common_image.dart';
import '../util/widgets/circle_button_image_stack.dart';

class FameLinksTourDialog extends StatefulWidget {
  FameLinksTourDialog({Key? key, this.initialSelected}) : super(key: key);
  ProfileType? initialSelected;

  @override
  State<FameLinksTourDialog> createState() => _FameLinksTourDialogState();
}

class _FameLinksTourDialogState extends State<FameLinksTourDialog> {
  @override
  void initState() {
    if (widget.initialSelected != null) {
      Provider.of<TourDialogProvider>(context, listen: false)
          .changeProfileType(widget.initialSelected!);
      if (widget.initialSelected == ProfileType.FAMELinks) {
        Provider.of<DatabaseProvider>(context, listen: false)
            .setIsFameLinksTourShown(true);
      } else if (widget.initialSelected == ProfileType.FUNLinks) {
        Provider.of<DatabaseProvider>(context, listen: false)
            .setIsFunLinksTourShown(true);
      } else if (widget.initialSelected == ProfileType.FOLLOWLinks) {
        Provider.of<DatabaseProvider>(context, listen: false)
            .setIsFollowLinksTourShown(true);
      }
    }
    Provider.of<DatabaseProvider>(context, listen: false).setIsTourShown(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black.withOpacity(0.75),
        body: Consumer<TourDialogProvider>(builder: (context, provider, child) {
          return Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              height: ScreenUtil().setHeight(520),
              width: ScreenUtil().setWidth(363),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/home_dial_dark.png'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: white.withOpacity(0.5), width: 0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Container(
                    height: ScreenUtil().setHeight(80),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: Constants.glassGradient,
                        color: black.withOpacity(0.5),
                        border: Border.all(
                            color: white.withOpacity(0.5), width: 0.5),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16))),
                    child: Center(
                        child: (provider.selectedProfileType ==
                                ProfileType.FAMELinks)
                            ? Text.rich(TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: 'Fame',
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      color: orange,
                                      fontSize: ScreenUtil().setSp(20),
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 2.0,
                                          color: Color(0xff000000)
                                              .withOpacity(0.25),
                                        ),
                                      ],
                                    )),
                                TextSpan(
                                    text: 'Links',
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: ScreenUtil().setSp(20),
                                      color: white,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 2.0,
                                          color: Color(0xff000000)
                                              .withOpacity(0.25),
                                        ),
                                      ],
                                    )),
                                TextSpan(
                                    text: ' -> blaze ',
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: ScreenUtil().setSp(12),
                                      color: white,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 2.0,
                                          color: Color(0xff000000)
                                              .withOpacity(0.25),
                                        ),
                                      ],
                                    )),
                                TextSpan(
                                    text: ' New Trendz',
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      color: white,
                                      fontSize: ScreenUtil().setSp(20),
                                      backgroundColor: orange,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 2.0,
                                          color: Color(0xff000000)
                                              .withOpacity(0.25),
                                        ),
                                      ],
                                    )),
                                TextSpan(
                                    text: ' and stay ',
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: ScreenUtil().setSp(12),
                                      color: white,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 2.0,
                                          color: Color(0xff000000)
                                              .withOpacity(0.25),
                                        ),
                                      ],
                                    )),
                              ]))
                            : (provider.selectedProfileType ==
                                    ProfileType.FOLLOWLinks)
                                ? Text.rich(TextSpan(children: <TextSpan>[
                                    TextSpan(
                                        text: 'Follow',
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w700,
                                          color: orange,
                                          fontSize: ScreenUtil().setSp(20),
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 2.0),
                                              blurRadius: 2.0,
                                              color: Color(0xff000000)
                                                  .withOpacity(0.25),
                                            ),
                                          ],
                                        )),
                                    TextSpan(
                                        text: 'Links',
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w700,
                                          fontSize: ScreenUtil().setSp(20),
                                          color: white,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 2.0),
                                              blurRadius: 2.0,
                                              color: Color(0xff000000)
                                                  .withOpacity(0.25),
                                            ),
                                          ],
                                        )),
                                    TextSpan(
                                        text: ' -> for followers / following',
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w700,
                                          fontSize: ScreenUtil().setSp(12),
                                          color: white,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 2.0),
                                              blurRadius: 2.0,
                                              color: Color(0xff000000)
                                                  .withOpacity(0.25),
                                            ),
                                          ],
                                        )),
                                  ]))
                                : (provider.selectedProfileType ==
                                        ProfileType.FUNLinks)
                                    ? Text.rich(TextSpan(children: <TextSpan>[
                                        TextSpan(
                                            text: 'Fun',
                                            style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              color: orange,
                                              fontSize: ScreenUtil().setSp(20),
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(0.0, 2.0),
                                                  blurRadius: 2.0,
                                                  color: Color(0xff000000)
                                                      .withOpacity(0.25),
                                                ),
                                              ],
                                            )),
                                        TextSpan(
                                            text: 'Links',
                                            style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(20),
                                              color: white,
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(0.0, 2.0),
                                                  blurRadius: 2.0,
                                                  color: Color(0xff000000)
                                                      .withOpacity(0.25),
                                                ),
                                              ],
                                            )),
                                        TextSpan(
                                            text: ' is a channel for ',
                                            style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(12),
                                              color: white,
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(0.0, 2.0),
                                                  blurRadius: 2.0,
                                                  color: Color(0xff000000)
                                                      .withOpacity(0.25),
                                                ),
                                              ],
                                            )),
                                        TextSpan(
                                            text: ' Short Videos',
                                            style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              color: white,
                                              fontSize: ScreenUtil().setSp(20),
                                              backgroundColor: orange,
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(0.0, 2.0),
                                                  blurRadius: 2.0,
                                                  color: Color(0xff000000)
                                                      .withOpacity(0.25),
                                                ),
                                              ],
                                            )),
                                      ]))
                                    : (provider.selectedProfileType ==
                                            ProfileType.JOBLinks)
                                        ? Container()
                                        : Text.rich(
                                            TextSpan(children: <TextSpan>[
                                            TextSpan(
                                                text: 'Fame',
                                                style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w700,
                                                  color: orange,
                                                  fontSize:
                                                      ScreenUtil().setSp(20),
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 2.0),
                                                      blurRadius: 2.0,
                                                      color: Color(0xff000000)
                                                          .withOpacity(0.25),
                                                    ),
                                                  ],
                                                )),
                                            TextSpan(
                                                text: 'Links',
                                                style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                      ScreenUtil().setSp(20),
                                                  color: white,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 2.0),
                                                      blurRadius: 2.0,
                                                      color: Color(0xff000000)
                                                          .withOpacity(0.25),
                                                    ),
                                                  ],
                                                )),
                                            TextSpan(
                                                text: ' -> blaze ',
                                                style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                      ScreenUtil().setSp(12),
                                                  color: white,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 2.0),
                                                      blurRadius: 2.0,
                                                      color: Color(0xff000000)
                                                          .withOpacity(0.25),
                                                    ),
                                                  ],
                                                )),
                                            TextSpan(
                                                text: ' New Trendz',
                                                style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w700,
                                                  color: white,
                                                  fontSize:
                                                      ScreenUtil().setSp(20),
                                                  backgroundColor: orange,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 2.0),
                                                      blurRadius: 2.0,
                                                      color: Color(0xff000000)
                                                          .withOpacity(0.25),
                                                    ),
                                                  ],
                                                )),
                                            TextSpan(
                                                text: ' and stay ',
                                                style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                      ScreenUtil().setSp(12),
                                                  color: white,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 2.0),
                                                      blurRadius: 2.0,
                                                      color: Color(0xff000000)
                                                          .withOpacity(0.25),
                                                    ),
                                                  ],
                                                )),
                                          ]))),
                  ),
                  SizedBox(height: 2.h),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16)),
                      child: Container(
                        padding: EdgeInsets.only(left: 12, top: 12, bottom: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: Constants.glassGradient,
                          color: black.withOpacity(0.5),
                          border: Border(
                              top: BorderSide(
                                  color: white.withOpacity(0.5), width: 0.5)),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomPaint(
                                  painter: ShapePainter(true),
                                  size: Size(208.w, 177.h),
                                ),
                                CustomPaint(
                                  painter: ShapePainter(false),
                                  size: Size(208.w, 177.h),
                                ),
                              ],
                            ),
                            Positioned(
                                top: 2.h,
                                child: Container(
                                  width: 208.w,
                                  height: 177.h,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if ((provider.selectedProfileType ==
                                          ProfileType.FAMELinks)) ...[
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: 12.0.w),
                                          child: Text(
                                            'Win Fame Contests',
                                            style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(20),
                                              color: white,
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black
                                                      .withOpacity(0.25),
                                                  offset: Offset(0, 2),
                                                  blurRadius: 2,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 60.w),
                                          child: SvgPicture.asset(
                                              'assets/icons/ic_fame.svg'),
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(left: 12.w),
                                            child: Text.rich(
                                                TextSpan(children: <TextSpan>[
                                              TextSpan(
                                                  text: 'Intriguing',
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: white,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                        offset:
                                                            Offset(0.0, 2.0),
                                                        blurRadius: 2.0,
                                                        color: Color(0xff000000)
                                                            .withOpacity(0.25),
                                                      ),
                                                    ],
                                                  )),
                                              TextSpan(
                                                  text: ' obstacles \n',
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: white,
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                        offset:
                                                            Offset(0.0, 2.0),
                                                        blurRadius: 2.0,
                                                        color: Color(0xff000000)
                                                            .withOpacity(0.25),
                                                      ),
                                                    ],
                                                  )),
                                              TextSpan(
                                                  text: 'and alluring',
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: white,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                        offset:
                                                            Offset(0.0, 2.0),
                                                        blurRadius: 2.0,
                                                        color: Color(0xff000000)
                                                            .withOpacity(0.25),
                                                      ),
                                                    ],
                                                  )),
                                              TextSpan(
                                                  text: ' benefits',
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: white,
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                        offset:
                                                            Offset(0.0, 2.0),
                                                        blurRadius: 2.0,
                                                        color: Color(0xff000000)
                                                            .withOpacity(0.25),
                                                      ),
                                                    ],
                                                  )),
                                            ])))
                                      ] else if ((provider
                                              .selectedProfileType ==
                                          ProfileType.FUNLinks)) ...[
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: 12.0.w),
                                          child: Text(
                                            'Create and watch',
                                            style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(20),
                                              color: white,
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black
                                                      .withOpacity(0.25),
                                                  offset: Offset(0, 2),
                                                  blurRadius: 2,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 60.w),
                                          child: SvgPicture.asset(
                                              'assets/icons/ic_funlinks.svg'),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 24.w),
                                          child: Text(
                                            'Win and get \nrewarded',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(15),
                                              color: white,
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black
                                                      .withOpacity(0.25),
                                                  offset: Offset(0, 2),
                                                  blurRadius: 2,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ] else if ((provider
                                              .selectedProfileType ==
                                          ProfileType.FOLLOWLinks)) ...[
                                        FollowArrow('Entertain'),
                                        FollowArrow('Retain'),
                                        FollowArrow('Gain'),
                                      ] else if (provider.selectedProfileType ==
                                          ProfileType.JOBLinks)
                                        Container()
                                      else ...[
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: 12.0.w),
                                          child: Text(
                                            'Win Fame Contests',
                                            style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(20),
                                              color: white,
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black
                                                      .withOpacity(0.25),
                                                  offset: Offset(0, 2),
                                                  blurRadius: 2,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 60.w),
                                          child: SvgPicture.asset(
                                              'assets/icons/ic_fame.svg'),
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(left: 12.w),
                                            child: Text.rich(
                                                TextSpan(children: <TextSpan>[
                                              TextSpan(
                                                  text: 'Intriguing',
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: white,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                        offset:
                                                            Offset(0.0, 2.0),
                                                        blurRadius: 2.0,
                                                        color: Color(0xff000000)
                                                            .withOpacity(0.25),
                                                      ),
                                                    ],
                                                  )),
                                              TextSpan(
                                                  text: ' obstacles \n',
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: white,
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                        offset:
                                                            Offset(0.0, 2.0),
                                                        blurRadius: 2.0,
                                                        color: Color(0xff000000)
                                                            .withOpacity(0.25),
                                                      ),
                                                    ],
                                                  )),
                                              TextSpan(
                                                  text: 'and alluring',
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: white,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                        offset:
                                                            Offset(0.0, 2.0),
                                                        blurRadius: 2.0,
                                                        color: Color(0xff000000)
                                                            .withOpacity(0.25),
                                                      ),
                                                    ],
                                                  )),
                                              TextSpan(
                                                  text: ' benefits',
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: white,
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                        offset:
                                                            Offset(0.0, 2.0),
                                                        blurRadius: 2.0,
                                                        color: Color(0xff000000)
                                                            .withOpacity(0.25),
                                                      ),
                                                    ],
                                                  )),
                                            ])))
                                      ],
                                    ],
                                  ),
                                )),
                            Positioned(
                                bottom: 2.h,
                                child: Container(
                                  width: 208.w,
                                  height: 177.h,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if ((provider.selectedProfileType ==
                                          ProfileType.FAMELinks)) ...[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Text(
                                            'Create and watch',
                                            style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(20),
                                              color: Colors.transparent,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 89.h,
                                          width: 140.w,
                                          child: Stack(
                                            children: [
                                              Image.asset(
                                                  'assets/images/cash front_2.png'),
                                              Positioned(
                                                top: 0,
                                                bottom: 0,
                                                right: 2.w,
                                                child: Image.asset(
                                                    'assets/images/trophy front_2.png'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20.w),
                                          child: Text.rich(
                                              TextSpan(children: <TextSpan>[
                                            TextSpan(
                                                text: 'Become Ambassadors\n',
                                                style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w600,
                                                  color: white,
                                                  fontSize:
                                                      ScreenUtil().setSp(13),
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 2.0),
                                                      blurRadius: 2.0,
                                                      color: Color(0xff000000)
                                                          .withOpacity(0.25),
                                                    ),
                                                  ],
                                                )),
                                            TextSpan(
                                                text: '   Earn & Grow',
                                                style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w700,
                                                  color: white,
                                                  fontSize:
                                                      ScreenUtil().setSp(16),
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 2.0),
                                                      blurRadius: 2.0,
                                                      color: Color(0xff000000)
                                                          .withOpacity(0.25),
                                                    ),
                                                  ],
                                                )),
                                          ])),
                                        )
                                      ] else if ((provider
                                              .selectedProfileType ==
                                          ProfileType.FUNLinks)) ...[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Text(
                                            'Create and watch',
                                            style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(20),
                                              color: Colors.transparent,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/images/ic_camera.png',
                                          width: 130.w,
                                          height: 107.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20.w),
                                          child: Text(
                                            'Pick or \nupload new music',
                                            style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(16),
                                              color: white,
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black
                                                      .withOpacity(0.25),
                                                  offset: Offset(0, 2),
                                                  blurRadius: 2,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ] else if ((provider
                                              .selectedProfileType ==
                                          ProfileType.FOLLOWLinks)) ...[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Text(
                                            'Create and watch',
                                            style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(20),
                                              color: Colors.transparent,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/images/ic_tour_heart.png',
                                          width: 130.w,
                                          height: 94.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20.w),
                                          child: Text(
                                            'Your Followers \ncan view your posting \nacross all your channels',
                                            style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(14),
                                              color: white,
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black
                                                      .withOpacity(0.25),
                                                  offset: Offset(0, 2),
                                                  blurRadius: 2,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ] else if (provider.selectedProfileType ==
                                          ProfileType.JOBLinks)
                                        Container()
                                      else ...[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Text(
                                            'Create and watch',
                                            style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(20),
                                              color: Colors.transparent,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 89.h,
                                          width: 140.w,
                                          child: Stack(
                                            children: [
                                              Image.asset(
                                                  'assets/images/cash front_2.png'),
                                              Positioned(
                                                top: 0,
                                                bottom: 0,
                                                right: 2.w,
                                                child: Image.asset(
                                                    'assets/images/trophy front_2.png'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20.w),
                                          child: Text.rich(
                                              TextSpan(children: <TextSpan>[
                                            TextSpan(
                                                text: 'Become Ambassadors\n',
                                                style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w600,
                                                  color: white,
                                                  fontSize:
                                                      ScreenUtil().setSp(13),
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 2.0),
                                                      blurRadius: 2.0,
                                                      color: Color(0xff000000)
                                                          .withOpacity(0.25),
                                                    ),
                                                  ],
                                                )),
                                            TextSpan(
                                                text: '   Earn & Grow',
                                                style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w700,
                                                  color: white,
                                                  fontSize:
                                                      ScreenUtil().setSp(16),
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 2.0),
                                                      blurRadius: 2.0,
                                                      color: Color(0xff000000)
                                                          .withOpacity(0.25),
                                                    ),
                                                  ],
                                                )),
                                          ])),
                                        )
                                      ],
                                    ],
                                  ),
                                )),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                height: 200.h,
                                width: 250.w,
                                child: Stack(
                                  //overflow: Overflow.visible,
                                  fit: StackFit.loose,
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Positioned(
                                      right: -50.w,
                                      child: DottedBorder(
                                        borderType: BorderType.Circle,
                                        color: white,
                                        strokeWidth: 1.5,
                                        child: Container(
                                          height: 140.h,
                                          width: 140.h,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 85.h,
                                                width: 85.w,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: GradientBoxBorder(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xFFFF4944),
                                                        Color(0xFF141070),
                                                        Color(0xFF1C126E),
                                                        Color(0xFFFF4944),
                                                        Color(0xFF0060FF),
                                                      ],
                                                      stops: [
                                                        0,
                                                        0.260417,
                                                        0.260517,
                                                        0.619792,
                                                        1,
                                                      ],
                                                      tileMode: TileMode.decal,
                                                    ),
                                                    width: 2,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(4),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            lightRedWhite,
                                                            lightRed
                                                          ]),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Center(
                                                      child: SvgPicture.asset(
                                                        provider.selectedProfileType ==
                                                                ProfileType
                                                                    .FAMELinks
                                                            ? 'assets/icons/ic_fame.svg'
                                                            : provider.selectedProfileType ==
                                                                    ProfileType
                                                                        .FUNLinks
                                                                ? 'assets/icons/ic_funlinks.svg'
                                                                : provider.selectedProfileType ==
                                                                        ProfileType
                                                                            .FOLLOWLinks
                                                                    ? 'assets/icons/ic_followlinks.svg'
                                                                    : provider.selectedProfileType ==
                                                                            ProfileType.JOBLinks
                                                                        ? 'assets/icons/ic_joblinks.svg'
                                                                        : 'assets/icons/ic_fame.svg',
                                                        height: 25.h,
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
                                    // top Fame Links

                                    Positioned(
                                      // top: -160.0,
                                      // left: -109.0,
                                      right: 44.w,
                                      top: 20.h,
                                      child: InkWell(
                                        onTap: () {
                                          provider.changeProfileType(
                                              ProfileType.FAMELinks);
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: (provider
                                                          .selectedProfileType ==
                                                      ProfileType.FAMELinks)
                                                  ? BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                          CommonImage
                                                              .darkButtonBackIcon,
                                                        ),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )
                                                  : BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                          CommonImage
                                                              .secondBundleIcon,
                                                        ),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6.0,
                                                    right: 6.0,
                                                    top: 2.0,
                                                    bottom: 2.0),
                                                child: Text(
                                                  "FameLinks",
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    color: (provider
                                                                .selectedProfileType ==
                                                            ProfileType
                                                                .FAMELinks)
                                                        ? Colors.white
                                                        : HexColor("#030C23"),
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            (provider.selectedProfileType ==
                                                    ProfileType.FAMELinks)
                                                ? CircleButtonImageStack(
                                                    isButtonSelect: true,
                                                    imgUrl: (true)
                                                        ? "assets/icons/darkFamelinkIcon.png"
                                                        : (provider.isDarkMode ==
                                                                true)
                                                            ? "assets/icons/darkFamelinkIcon.png"
                                                            : "assets/icons/logo.png",
                                                  )
                                                : CircleButtonImageStack(
                                                    imgUrl: (provider
                                                                .isDarkMode ==
                                                            true)
                                                        ? "assets/icons/darkFamelinkIcon.png"
                                                        : "assets/icons/logo.png",
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // left FunLinks
                                    Positioned(
                                      // top: -80.0,
                                      right: 86.w,
                                      // left: -170.0,
                                      top: 64.h,
                                      child: InkWell(
                                        onTap: () {
                                          provider.changeProfileType(
                                              ProfileType.FUNLinks);
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: (provider
                                                          .selectedProfileType ==
                                                      ProfileType.FUNLinks)
                                                  ? BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                          CommonImage
                                                              .darkButtonBackIcon,
                                                        ),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )
                                                  : BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                          CommonImage
                                                              .secondBundleIcon,
                                                        ),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6.0,
                                                    right: 6.0,
                                                    top: 2.0,
                                                    bottom: 2.0),
                                                child: Text(
                                                  "FunLinks",
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    color: (provider
                                                                .selectedProfileType ==
                                                            ProfileType
                                                                .FUNLinks)
                                                        ? Colors.white
                                                        : HexColor("#030C23"),
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            (provider.selectedProfileType ==
                                                    ProfileType.FUNLinks)
                                                ? CircleButtonImageStack(
                                                    isButtonSelect: true,
                                                    imgUrl: (true)
                                                        ? CommonImage
                                                            .dark_videoLink_icon
                                                        : (provider.isDarkMode ==
                                                                true)
                                                            ? CommonImage
                                                                .dark_videoLink_icon
                                                            : "assets/icons/funLinks.png",
                                                  )
                                                : CircleButtonImageStack(
                                                    imgUrl: (provider
                                                                .isDarkMode ==
                                                            true)
                                                        ? CommonImage
                                                            .dark_videoLink_icon
                                                        : "assets/icons/funLinks.png",
                                                  ),
                                          ],
                                        ),
                                      ),
                                      // right: MediaQuery.of(context).size.width/2,
                                    ),
                                    // // right FollowLinks
                                    Positioned(
                                      child: InkWell(
                                        onTap: () {
                                          provider.changeProfileType(
                                              ProfileType.FOLLOWLinks);
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: (provider
                                                          .selectedProfileType ==
                                                      ProfileType.FOLLOWLinks)
                                                  ? BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                          CommonImage
                                                              .darkButtonBackIcon,
                                                        ),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )
                                                  : BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                          CommonImage
                                                              .secondBundleIcon,
                                                        ),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6.0,
                                                    right: 6.0,
                                                    top: 2.0,
                                                    bottom: 2.0),
                                                child: Text(
                                                  "FollowLinks",
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    color: (provider
                                                                .selectedProfileType ==
                                                            ProfileType
                                                                .FOLLOWLinks)
                                                        ? Colors.white
                                                        : HexColor("#030C23"),
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            (provider.selectedProfileType ==
                                                    ProfileType.FOLLOWLinks)
                                                ? CircleButtonImageStack(
                                                    isButtonSelect: true,
                                                    imgUrl: (true)
                                                        ? CommonImage
                                                            .dark_follower_icon
                                                        : (provider.isDarkMode ==
                                                                true)
                                                            ? CommonImage
                                                                .dark_follower_icon
                                                            : "assets/icons/followLinks.png",
                                                  )
                                                : CircleButtonImageStack(
                                                    imgUrl: (provider
                                                                .isDarkMode ==
                                                            true)
                                                        ? CommonImage
                                                            .dark_follower_icon
                                                        : "assets/icons/followLinks.png",
                                                  ),
                                          ],
                                        ),
                                      ),
                                      right: 86.w,
                                      // left: -170.0,
                                      top: 112.h,
                                    ),
                                    // JobLinks
                                    Positioned(
                                      child: InkWell(
                                        onTap: () async {
                                          // provider.changeProfileType(
                                          //     ProfileType.JOBLinks);
                                          Navigator.pop(context, true);
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: (provider
                                                          .selectedProfileType ==
                                                      ProfileType.JOBLinks)
                                                  ? BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                          CommonImage
                                                              .darkButtonBackIcon,
                                                        ),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )
                                                  : BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                          CommonImage
                                                              .secondBundleIcon,
                                                        ),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6.0,
                                                    right: 6.0,
                                                    top: 2.0,
                                                    bottom: 2.0),
                                                child: Text(
                                                  "JobLinks",
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    color: (provider
                                                                .selectedProfileType ==
                                                            ProfileType
                                                                .JOBLinks)
                                                        ? Colors.white
                                                        : HexColor("#030C23"),
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            (provider.selectedProfileType ==
                                                    ProfileType.JOBLinks)
                                                ? CircleButtonImageStack(
                                                    isButtonSelect: true,
                                                    imgUrl: (true)
                                                        ? CommonImage
                                                            .dark_jobLink_icon
                                                        : (provider.isDarkMode ==
                                                                true)
                                                            ? CommonImage
                                                                .dark_jobLink_icon
                                                            : "assets/icons/vector.png",
                                                  )
                                                : CircleButtonImageStack(
                                                    imgUrl: (provider
                                                                .isDarkMode ==
                                                            true)
                                                        ? CommonImage
                                                            .dark_jobLink_icon
                                                        : "assets/icons/vector.png",
                                                  ),
                                          ],
                                        ),
                                      ),
                                      // top: 135.0,
                                      right: 44.w,
                                      bottom: 20.h,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }

  Widget FollowArrow(String title) => Padding(
        padding: EdgeInsets.only(left: 24.0.w),
        child: Row(
          children: [
            SvgPicture.asset('assets/icons/ic_follow_arrow1.svg'),
            SizedBox(
              width: 8.w,
            ),
            Text(
              title,
              style: GoogleFonts.nunitoSans(
                fontSize: ScreenUtil().setSp(22),
                color: white,
                fontWeight: FontWeight.w800,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: Offset(0, 2),
                    blurRadius: 2,
                  )
                ],
              ),
            ),
          ],
        ),
      );
}

class ShapePainter extends CustomPainter {
  ShapePainter(this.first);

  final bool first;

  @override
  void paint(Canvas canvas, Size size) {
    // Define the paint for the shape
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Color(0xFFFF5C28).withOpacity(0.25),
          Colors.white.withOpacity(0.25),
          Colors.white.withOpacity(0.25),
          Color(0xFF0060FF).withOpacity(0.25),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0, 0.458333, 0.723958, 1],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Define the border paint
    final borderPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Color(0xFFFFA88C),
          Color(0xFFFF5C28),
        ],
        stops: [0.114583, 0.671875],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Define the inner shadow paint
    final shadowPaint = Paint()..color = Colors.black.withOpacity(0.25);

    // Calculate the scaled coordinates
    final scaleX = size.width / 208;
    final scaleY = size.height / 177;

    // Create the path for the shape
    final path = Path()
      ..moveTo(1 * scaleX, 5 * scaleY)
      ..lineTo(1 * scaleX, 172 * scaleY)
      ..cubicTo(
        1 * scaleX,
        174.209 * scaleY,
        2.79086 * scaleX,
        176 * scaleY,
        5 * scaleX,
        176 * scaleY,
      )
      ..lineTo(125.044 * scaleX, 176 * scaleY)
      ..cubicTo(
        127.236 * scaleX,
        176 * scaleY,
        129.016 * scaleX,
        174.209 * scaleY,
        129.256 * scaleX,
        172 * scaleY,
      )
      ..cubicTo(
        131.038 * scaleX,
        155.897 * scaleY,
        141.779 * scaleX,
        127.306 * scaleY,
        153 * scaleX,
        107.805 * scaleY,
      )
      ..cubicTo(
        168.33 * scaleX,
        81.1652 * scaleY,
        191.003 * scaleX,
        59.3951 * scaleY,
        205.189 * scaleX,
        49.702 * scaleY,
      )
      ..cubicTo(
        206.312 * scaleX,
        48.9341 * scaleY,
        207 * scaleX,
        47.6773 * scaleY,
        207 * scaleX,
        46.3162 * scaleY,
      )
      ..lineTo(207 * scaleX, 5 * scaleY)
      ..cubicTo(
        207 * scaleX,
        2.79086 * scaleY,
        205.209 * scaleX,
        1 * scaleY,
        203 * scaleX,
        1 * scaleY,
      )
      ..lineTo(5 * scaleX, 1 * scaleY)
      ..close();

    final path1 = Path()
      ..moveTo(1 * scaleX, 172 * scaleY)
      ..lineTo(1 * scaleX, 5 * scaleY)
      ..cubicTo(
        1 * scaleX,
        2.79086 * scaleY,
        2.79086 * scaleX,
        1 * scaleY,
        5 * scaleX,
        1 * scaleY,
      )
      ..lineTo(125.044 * scaleX, 1 * scaleY)
      ..cubicTo(
        127.236 * scaleX,
        1 * scaleY,
        129.016 * scaleX,
        2.75624 * scaleY,
        129.256 * scaleX,
        4.93491 * scaleY,
      )
      ..cubicTo(
        131.038 * scaleX,
        21.1028 * scaleY,
        141.779 * scaleX,
        49.6943 * scaleY,
        153 * scaleX,
        69.1948 * scaleY,
      )
      ..cubicTo(
        168.33 * scaleX,
        95.8348 * scaleY,
        191.003 * scaleX,
        117.605 * scaleY,
        205.189 * scaleX,
        127.298 * scaleY,
      )
      ..cubicTo(
        206.312 * scaleX,
        128.066 * scaleY,
        207 * scaleX,
        129.323 * scaleY,
        207 * scaleX,
        130.684 * scaleY,
      )
      ..lineTo(207 * scaleX, 172 * scaleY)
      ..cubicTo(
        207 * scaleX,
        174.209 * scaleY,
        205.209 * scaleX,
        176 * scaleY,
        203 * scaleX,
        176 * scaleY,
      )
      ..lineTo(5 * scaleX, 176 * scaleY)
      ..cubicTo(
        2.79086 * scaleX,
        176 * scaleY,
        1 * scaleX,
        174.209 * scaleY,
        1 * scaleX,
        172 * scaleY,
      )
      ..close();

    // Draw the border
    canvas.drawPath(first ? path : path1, borderPaint);

    // Draw the shape with fill
    canvas.drawPath(first ? path : path1, paint);

    // Apply inner shadow effect
    canvas.drawPath(
      first ? path : path1,
      shadowPaint..maskFilter = MaskFilter.blur(BlurStyle.inner, 4.0),
    );
  }

  @override
  bool shouldRepaint(ShapePainter oldDelegate) => false;
}

class RoundShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final path = Path()
      ..moveTo(1, 5)
      ..lineTo(1, 172)
      ..cubicTo(1, 174.209, 2.79086, 176, 5, 176)
      ..lineTo(125.044, 176)
      ..cubicTo(127.236, 176, 129.016, 174.244, 129.256, 172.065)
      ..cubicTo(131.038, 155.897, 141.779, 127.306, 153, 107.805)
      ..cubicTo(168.33, 81.1652, 191.003, 59.3951, 205.189, 49.702)
      ..cubicTo(206.312, 48.9341, 207, 47.6773, 207, 46.3162)
      ..lineTo(207, 5)
      ..cubicTo(207, 2.79086, 205.209, 1, 203, 1)
      ..lineTo(5, 1)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
