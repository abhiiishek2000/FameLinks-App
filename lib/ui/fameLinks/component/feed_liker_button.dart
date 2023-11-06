import 'package:famelink/ui/fameLinks/component/post_report_dialog.dart';
import 'package:famelink/ui/fameLinks/provider/FameLinksFeedProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/common_image.dart';
import '../../../util/config/color.dart';
import '../../../util/config/image.dart';
import '../../../util/registerDialog.dart';

class FameLinkFeedLikerButton extends StatefulWidget {
  FameLinkFeedLikerButton({Key? key, required this.isRegistered})
      : super(key: key);
  bool isRegistered;

  @override
  State<FameLinkFeedLikerButton> createState() =>
      _FameLinkFeedLikerButtonState();
}

class _FameLinkFeedLikerButtonState extends State<FameLinkFeedLikerButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FameLinksFeedProvider>(builder: (context, provider, child) {
      return provider.feedList![provider.getIndex]
                  .media![0].type
                  .toString() ==
              "ads"
          ? Container()
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("asfdsfdsf", style: TextStyle(color: Colors.transparent)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setSp(91),
                          left: ScreenUtil().setSp(10),
                          right: ScreenUtil().setSp(11),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (provider.getOnClickPageImage == false)
                              IconButton(
                                icon: SvgPicture.asset(CommonImage.ic_more,
                                    height: 40, width: 40),
                                onPressed: () {
                                  if (widget.isRegistered == false) {
                                    provider.changeOnPageTurning(true);
                                    provider
                                        .changeOnPageHorizontalTurning(true);
                                    registerDialog(context);
                                  } else {
                                    provider.changeOnPageTurning(true);
                                    provider
                                        .changeOnPageHorizontalTurning(true);
                                    showReportPostDialog(
                                        context,
                                        provider,
                                        provider
                                            .feedList![provider.getIndex]
                                            .user!
                                            .id!,
                                        provider.feedList![provider.getIndex].id!,
                                        false);
                                  }
                                },
                              ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    provider.feedList![provider.getIndex]
                                .type ==
                            'brand'
                        ? Padding(
                            padding:
                                EdgeInsets.only(right: 30.w, bottom: 270.h),
                            // bottom:
                            //     provider.getIsProfileUI == true ? 270.h : 180.h),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.bookmark, color: Colors.white),
                                  SizedBox(height: 24.h),
                                  SvgPicture.asset(
                                      'assets/icons/svg/atTheRate.svg'),
                                  SizedBox(height: 5.h),
                                  Text(
                                    provider.feedList![provider.getIndex].tags
                                        .toString(),
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 7.0,
                                            color: black.withOpacity(0.6),
                                            offset: Offset(2.0, 2.0),
                                          ),
                                        ],
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(12)),
                                  ),
                                ]),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Wrap(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 16.w),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(
                                                provider.onClickPageImage ==
                                                        false
                                                    ? 45
                                                    : 0),
                                            right: ScreenUtil().setWidth(10)),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 1.0,
                                                color: black.withOpacity(0.1),
                                                offset: Offset(1.0, 1.0),
                                              ),
                                            ]),
                                        child: provider
                                                    .feedList![provider.getIndex]
                                                    .likeStatus ==
                                                null
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      if (provider
                                                              .feedList![provider
                                                                  .getIndex]
                                                              .likeStatus ==
                                                          2) {
                                                        provider
                                                            .feedList![provider
                                                                .getIndex]
                                                            .likeStatus = null;
                                                        provider.likeHeart(
                                                            null,
                                                            2,
                                                            context,
                                                            widget
                                                                .isRegistered);
                                                      } else {
                                                        provider.likeHeart(
                                                            2,
                                                            2,
                                                            context,
                                                            widget
                                                                .isRegistered);
                                                      }
                                                    },
                                                    child: SvgPicture.asset(
                                                        fullheart,
                                                        color: provider
                                                                    .feedList![
                                                                        provider
                                                                            .getIndex]
                                                                    .likeStatus ==
                                                                2
                                                            ? lightRed
                                                            : Colors.white),
                                                  ),
                                                  SizedBox(
                                                    height: ScreenUtil()
                                                        .setHeight(2),
                                                  ),
                                                  provider
                                                              .feedList![provider
                                                                  .getIndex]
                                                              .likes2Count ==
                                                          null
                                                      ? Container()
                                                      : Text(
                                                          provider.feedList![
                                                                          provider
                                                                              .getIndex]
                                                                      .likes2Count! >
                                                                  0
                                                              ? "${provider.feedList![provider.getIndex].likes2Count}"
                                                              : "",
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                                  color: Colors
                                                                      .white,
                                                                  shadows: [
                                                                    Shadow(
                                                                      blurRadius:
                                                                          7.0,
                                                                      color: black
                                                                          .withOpacity(
                                                                              0.6),
                                                                      offset: Offset(
                                                                          2.0,
                                                                          2.0),
                                                                    ),
                                                                  ],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              10)),
                                                        ),
                                                  SizedBox(
                                                    height: ScreenUtil()
                                                        .setHeight(7),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      if (provider
                                                              .feedList![provider
                                                                  .getIndex]
                                                              .likeStatus ==
                                                          1) {
                                                        provider
                                                            .feedList![provider
                                                                .getIndex]
                                                            .likeStatus = null;
                                                        provider.likeHeart(
                                                            null,
                                                            1,
                                                            context,
                                                            widget
                                                                .isRegistered);
                                                      } else {
                                                        provider.likeHeart(
                                                            1,
                                                            1,
                                                            context,
                                                            widget
                                                                .isRegistered);
                                                      }
                                                    },
                                                    child: SvgPicture.asset(
                                                        halfheart,
                                                        color: provider
                                                                    .feedList![
                                                                        provider
                                                                            .getIndex]
                                                                    .likeStatus ==
                                                                1
                                                            ? lightRed
                                                            : Colors.white),
                                                  ),
                                                  SizedBox(
                                                    height: ScreenUtil()
                                                        .setHeight(2),
                                                  ),
                                                  provider
                                                              .feedList![provider
                                                                  .getIndex]
                                                              .likes1Count ==
                                                          null
                                                      ? Container()
                                                      : Text(
                                                          provider
                                                                      .feedList![
                                                                          provider
                                                                              .getIndex]
                                                                      .likes1Count! >
                                                                  0
                                                              ? "${provider.feedList![provider.getIndex].likes1Count}"
                                                              : "",
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                                  color: Colors
                                                                      .white,
                                                                  shadows: [
                                                                    Shadow(
                                                                      blurRadius:
                                                                          7.0,
                                                                      color: black
                                                                          .withOpacity(
                                                                              0.6),
                                                                      offset: Offset(
                                                                          2.0,
                                                                          2.0),
                                                                    ),
                                                                  ],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              10)),
                                                        ),
                                                  SizedBox(
                                                    height: ScreenUtil()
                                                        .setHeight(7),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      if (provider
                                                              .feedList![provider
                                                                  .getIndex]
                                                              .likeStatus ==
                                                          0) {
                                                        provider
                                                            .feedList![provider
                                                                .getIndex]
                                                            .likeStatus = null;

                                                        provider.likeHeart(
                                                            null,
                                                            0,
                                                            context,
                                                            widget
                                                                .isRegistered);
                                                      } else {
                                                        provider.likeHeart(
                                                            0,
                                                            0,
                                                            context,
                                                            widget
                                                                .isRegistered);
                                                      }
                                                    },
                                                    child: SvgPicture.asset(
                                                        emptyheart,
                                                        color: provider
                                                                    .feedList![
                                                                        provider
                                                                            .getIndex]
                                                                    .likeStatus ==
                                                                0
                                                            ? lightRed
                                                            : Colors.white),
                                                  ),
                                                  SizedBox(
                                                    height: ScreenUtil()
                                                        .setHeight(2),
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      if (provider
                                                              .feedList![provider
                                                                  .getIndex]
                                                              .likeStatus ==
                                                          2) {
                                                        provider.likeHeart(
                                                            null,
                                                            2,
                                                            context,
                                                            widget
                                                                .isRegistered);
                                                      } else {
                                                        provider.likeHeart(
                                                            2,
                                                            2,
                                                            context,
                                                            widget
                                                                .isRegistered);
                                                      }
                                                    },
                                                    child: SvgPicture.asset(
                                                        fullheart,
                                                        color: provider
                                                                    .feedList![
                                                                        provider
                                                                            .getIndex]
                                                                    .likeStatus ==
                                                                2
                                                            ? lightRed
                                                            : Colors.white),
                                                  ),
                                                  SizedBox(
                                                    height: ScreenUtil()
                                                        .setHeight(2),
                                                  ),
                                                  Text(
                                                    provider.feedList![provider
                                                                    .getIndex]
                                                                .likes2Count! >
                                                            0
                                                        ? "${provider.feedList![provider.getIndex].likes2Count}"
                                                        : "",
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                            color: Colors.white,
                                                            shadows: [
                                                              Shadow(
                                                                blurRadius: 7.0,
                                                                color: black
                                                                    .withOpacity(
                                                                        0.6),
                                                                offset: Offset(
                                                                    2.0, 2.0),
                                                              ),
                                                            ],
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(10)),
                                                  ),
                                                  SizedBox(
                                                    height: ScreenUtil()
                                                        .setHeight(7),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      if (provider
                                                              .feedList![provider
                                                                  .getIndex]
                                                              .likeStatus ==
                                                          1) {
                                                        provider
                                                            .feedList![provider
                                                                .getIndex]
                                                            .likeStatus = null;
                                                        provider.likeHeart(
                                                            null,
                                                            1,
                                                            context,
                                                            widget
                                                                .isRegistered);
                                                      } else {
                                                        provider.likeHeart(
                                                            1,
                                                            1,
                                                            context,
                                                            widget
                                                                .isRegistered);
                                                      }
                                                    },
                                                    child: SvgPicture.asset(
                                                        halfheart,
                                                        color: provider
                                                                    .feedList![
                                                                        provider
                                                                            .getIndex]
                                                                    .likeStatus ==
                                                                1
                                                            ? lightRed
                                                            : Colors.white),
                                                  ),
                                                  SizedBox(
                                                    height: ScreenUtil()
                                                        .setHeight(2),
                                                  ),
                                                  Text(
                                                    provider.feedList![provider
                                                                    .getIndex]
                                                                .likes1Count! >
                                                            0
                                                        ? "${provider.feedList![provider.getIndex].likes1Count}"
                                                        : "",
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                            color: Colors.white,
                                                            shadows: [
                                                              Shadow(
                                                                blurRadius: 7.0,
                                                                color: black
                                                                    .withOpacity(
                                                                        0.6),
                                                                offset: Offset(
                                                                    2.0, 2.0),
                                                              ),
                                                            ],
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(10)),
                                                  ),
                                                  SizedBox(
                                                    height: ScreenUtil()
                                                        .setHeight(7),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      if (provider
                                                              .feedList![provider
                                                                  .getIndex]
                                                              .likeStatus ==
                                                          0) {
                                                        provider
                                                            .feedList![provider
                                                                .getIndex]
                                                            .likeStatus = null;
                                                        provider.likeHeart(
                                                            null,
                                                            0,
                                                            context,
                                                            widget
                                                                .isRegistered);
                                                      } else {
                                                        provider.likeHeart(
                                                            0,
                                                            0,
                                                            context,
                                                            widget
                                                                .isRegistered);
                                                      }
                                                    },
                                                    child: SvgPicture.asset(
                                                        emptyheart,
                                                        color: provider
                                                                    .feedList![
                                                                        provider
                                                                            .getIndex]
                                                                    .likeStatus ==
                                                                0
                                                            ? lightRed
                                                            : Colors.white),
                                                  ),
                                                  SizedBox(
                                                    height: ScreenUtil()
                                                        .setHeight(2),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 130.h)
                              // provider.getIsProfileUI == true ? 38.h : 130.h),
                            ],
                          ),
                  ],
                ),
              ],
            );
    });
  }
}
