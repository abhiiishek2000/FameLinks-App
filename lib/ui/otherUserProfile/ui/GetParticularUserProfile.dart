import 'dart:async';

import 'package:decorated_icon/decorated_icon.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../databse/AppDatabase.dart';
import '../../../providers/FeedProvider/GetParticularUserProfileProvider.dart';
import '../../../share/firebasedynamiclink.dart';
import '../../../util/config/image.dart';
import '../../Famelinkprofile/function/famelinkFun.dart';
import '../../fameLinks/provider/FameLinksFeedProvider.dart';
import '../../funlinks/FameLinksChallengeScreen.dart';
import 'widget/scrollFeed.dart';
import 'widget/showOtherReportDialogs.dart';

class GetParticularUserProfile extends StatefulWidget {
  final String? id;
  final String? userid;
  final int? index;

  const GetParticularUserProfile({Key? key, this.id, this.index, this.userid})
      : super(key: key);

  @override
  _GetParticularUserProfileState createState() =>
      _GetParticularUserProfileState();
}

class _GetParticularUserProfileState extends State<GetParticularUserProfile>
    with TickerProviderStateMixin {
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  void initState() {
    // TODO: implement initState

    postMdl = Provider.of<GetParticularFameLinksProfileProvider>(context,
        listen: false);

    getMe();

    // getFameLinksFeed(widget.id!, context, isPaginate: null);
    postMdl!.controller = PageController(
        viewportFraction: 1, keepPage: true, initialPage: widget.index!);
    postMdl!.controllerMultipleImage =
        PageController(viewportFraction: 1, keepPage: true, initialPage: 0);
    postMdl!.smoothPageController =
        PageController(keepPage: true, initialPage: 0);

    ///postMdl!.fameLinks();// ads call
    _initGoogleMobileAds();
    super.initState();

    print("amarj234  ${widget.index}  ${widget.id}");
  }

  GetParticularFameLinksProfileProvider? postMdl;

  getMe() async {
    await postMdl!.getFollowLinkFeedData(context, widget.id!, widget.userid!);
    postMdl!.changeIndex(int.parse(widget.index.toString()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // videofameController.clear();
    Constants.playing = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<GetParticularFameLinksProfileProvider, FameLinkFun>(
        builder: (context, provider, fameLinkFun, child) {
      print("current index ${provider.index}");
      return provider.getParticularFameLinksProfileLoading
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              backgroundColor: black,
              body:
                  provider.getParticularFunUserProfileModelResultList.result!
                              .length !=
                          0
                      ? Stack(
                          children: [
                            PinchZoom(
                              child: scrollFeed(
                                id: widget.id.toString(),
                              ),
                              resetDuration: const Duration(milliseconds: 100),
                              maxScale: 2.5,
                              onZoomStart: () {
                                print('Start zooming');
                              },
                              onZoomEnd: () {
                                print('Stop zooming');
                              },
                            ),
                            provider.getParticularFunUserProfileModelResultList
                                        .result![provider.getIndex] ==
                                    null
                                ? Container()
                                : Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: ScreenUtil().setSp(30),
                                          left: ScreenUtil().setSp(5)
                                          // right: ScreenUtil().setSp(0),
                                          ),
                                      child: IconButton(
                                        icon: DecoratedIcon(
                                          Icons.keyboard_arrow_left,
                                          color: white,
                                          shadows: [
                                            BoxShadow(
                                              blurRadius: 5.0,
                                              color: black.withOpacity(0.5),
                                              offset: Offset(1.5, 1.5),
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ),
                            // getParticularUserProfileModelResultList[index] == null ? Container() :
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Text("asfdsfdsf",
                                //     style:
                                //         TextStyle(color: Colors.transparent)),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    provider.getParticularFunUserProfileModelResultList
                                                .result![provider.getIndex] ==
                                            null
                                        ? Container()
                                        : Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: ScreenUtil().setSp(30),
                                                  left: ScreenUtil().setSp(10)
                                                  // right: ScreenUtil().setSp(0),
                                                  ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    icon: DecoratedIcon(
                                                      Icons.more_vert,
                                                      color: white,
                                                      shadows: [
                                                        BoxShadow(
                                                          blurRadius: 5.0,
                                                          color: black
                                                              .withOpacity(0.5),
                                                          offset:
                                                              Offset(1.5, 1.5),
                                                        ),
                                                      ],
                                                    ),
                                                    onPressed: () {
                                                      postMdl!.showReportPostDialog(
                                                          context,
                                                          provider,
                                                          provider
                                                              .getParticularFunUserProfileModelResultList
                                                              .result![provider
                                                                  .getIndex]
                                                              .users!
                                                              .sId!,
                                                          provider
                                                              .getParticularFunUserProfileModelResultList
                                                              .result![provider
                                                                  .getIndex]
                                                              .sId!,
                                                          false);
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  provider.getParticularFunUserProfileModelResultList
                                                              .result!.length !=
                                                          0
                                                      ? provider
                                                                  .getParticularFunUserProfileModelResultList
                                                                  .result![provider
                                                                      .getIndex]
                                                                  .media![0]
                                                                  .type
                                                                  .toString() ==
                                                              "video"
                                                          ? IconButton(
                                                              onPressed: () {
                                                                provider.changeIsMute(
                                                                    !provider
                                                                        .getIsMute);
                                                              },
                                                              icon: Icon(
                                                                provider.getIsMute
                                                                    ? Icons
                                                                        .volume_up_sharp
                                                                    : Icons
                                                                        .volume_off_sharp,
                                                                color: white,
                                                              ))
                                                          : Container()
                                                      : Container()
                                                ],
                                              ),
                                            ),
                                          ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Wrap(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    bottom: ScreenUtil()
                                                        .setHeight(40),
                                                    // right: ScreenUtil()
                                                    //     .setWidth(10)
                                                  ),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.black,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  25)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 1.0,
                                                          color: black
                                                              .withOpacity(0.1),
                                                          offset:
                                                              Offset(1.0, 1.0),
                                                        ),
                                                      ]),
                                                  child: provider.getParticularFunUserProfileModelResultList
                                                                  .result![
                                                              provider
                                                                  .getIndex] ==
                                                          null
                                                      ? Container()
                                                      : provider
                                                                  .getParticularFunUserProfileModelResultList
                                                                  .result![provider
                                                                      .getIndex]
                                                                  .likeStatus ==
                                                              null
                                                          ? Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    // setState(() async {
                                                                    if (provider
                                                                            .isLike2 ==
                                                                        false) {
                                                                      if (provider
                                                                              .getParticularFunUserProfileModelResultList
                                                                              .result![provider.getIndex]
                                                                              .likeStatus ==
                                                                          2) {
                                                                        provider
                                                                            .getParticularFunUserProfileModelResultList
                                                                            .result![provider.getIndex]
                                                                            .likeStatus = null;
                                                                        provider
                                                                            .changeIsLike2(true);

                                                                        provider
                                                                            .getParticularFunUserProfileModelResultList
                                                                            .result![widget
                                                                                .index!]
                                                                            .likes2Count = provider
                                                                                .getParticularFunUserProfileModelResultList.result![widget.index!].likes2Count! -
                                                                            1;
                                                                        await postMdl!.likeHeart(
                                                                            null,
                                                                            2,
                                                                            context,
                                                                            widget.index!);
                                                                      } else {
                                                                        provider
                                                                            .getParticularFunUserProfileModelResultList
                                                                            .result![provider.getIndex]
                                                                            .likeStatus = 2;
                                                                        provider
                                                                            .changeIsLike2(true);
                                                                        if (provider.getParticularFunUserProfileModelResultList.result![widget.index!].likeStatus ==
                                                                            1) {
                                                                          provider
                                                                              .getParticularFunUserProfileModelResultList
                                                                              .result![widget.index!]
                                                                              .likes1Count = provider.getParticularFunUserProfileModelResultList.result![widget.index!].likes1Count! - 1;
                                                                        }

                                                                        if (provider.getParticularFunUserProfileModelResultList.result![widget.index!].likes2Count! >=
                                                                            0) {
                                                                          if (provider.getParticularFunUserProfileModelResultList.result![widget.index!].likeStatus !=
                                                                              2) {
                                                                            provider.getParticularFunUserProfileModelResultList.result![widget.index!].likes2Count =
                                                                                provider.getParticularFunUserProfileModelResultList.result![widget.index!].likes2Count! + 1;
                                                                          } else {
                                                                            provider.getParticularFunUserProfileModelResultList.result![widget.index!].likes2Count =
                                                                                provider.getParticularFunUserProfileModelResultList.result![widget.index!].likes2Count! - 1;
                                                                          }
                                                                        } else {
                                                                          provider
                                                                              .getParticularFunUserProfileModelResultList
                                                                              .result![widget.index!]
                                                                              .likes2Count = provider.getParticularFunUserProfileModelResultList.result![widget.index!].likes2Count! + 1;
                                                                        }
                                                                        await postMdl!.likeHeart(
                                                                            2,
                                                                            2,
                                                                            context,
                                                                            widget.index!);
                                                                      }
                                                                    }
                                                                    // });
                                                                  },
                                                                  child: SvgPicture.asset(
                                                                      fullheart,
                                                                      color: provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].likeStatus ==
                                                                              2
                                                                          ? lightRed
                                                                          : Colors
                                                                              .white),
                                                                ),
                                                                SizedBox(
                                                                  height: ScreenUtil()
                                                                      .setHeight(
                                                                          2),
                                                                ),
                                                                Text(
                                                                  provider.getParticularFunUserProfileModelResultList.result![provider.getIndex]
                                                                              .likes2Count! >
                                                                          0
                                                                      ? "${provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].likes2Count}"
                                                                      : "",
                                                                  style: GoogleFonts
                                                                      .nunitoSans(
                                                                          color: Colors
                                                                              .white,
                                                                          shadows: [
                                                                            Shadow(
                                                                              blurRadius: 7.0,
                                                                              color: black.withOpacity(0.6),
                                                                              offset: Offset(2.0, 2.0),
                                                                            ),
                                                                          ],
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              ScreenUtil().setSp(10)),
                                                                ),
                                                                SizedBox(
                                                                  height: ScreenUtil()
                                                                      .setHeight(
                                                                          7),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    // setState(() {
                                                                    // if(isLike1 == false){
                                                                    if (provider
                                                                            .getParticularFunUserProfileModelResultList
                                                                            .result![provider.getIndex]
                                                                            .likeStatus ==
                                                                        1) {
                                                                      provider
                                                                          .getParticularFunUserProfileModelResultList
                                                                          .result![
                                                                              provider.getIndex]
                                                                          .likeStatus = null;
                                                                      provider.changeIsLike1(
                                                                          true);
                                                                      postMdl!.likeHeart(
                                                                          null,
                                                                          1,
                                                                          context,
                                                                          widget
                                                                              .index!);
                                                                      provider
                                                                          .getParticularFunUserProfileModelResultList
                                                                          .result![widget
                                                                              .index!]
                                                                          .likes1Count = provider
                                                                              .getParticularFunUserProfileModelResultList
                                                                              .result![widget.index!]
                                                                              .likes1Count! -
                                                                          1;
                                                                    } else {
                                                                      provider
                                                                          .getParticularFunUserProfileModelResultList
                                                                          .result![
                                                                              provider.getIndex]
                                                                          .likeStatus = 1;
                                                                      provider.changeIsLike1(
                                                                          true);
                                                                      if (provider
                                                                              .getParticularFunUserProfileModelResultList
                                                                              .result![widget.index!]
                                                                              .likeStatus ==
                                                                          2) {
                                                                        provider
                                                                            .getParticularFunUserProfileModelResultList
                                                                            .result![widget
                                                                                .index!]
                                                                            .likes2Count = provider
                                                                                .getParticularFunUserProfileModelResultList.result![widget.index!].likes2Count! -
                                                                            1;
                                                                      }

                                                                      if (provider
                                                                              .getParticularFunUserProfileModelResultList
                                                                              .result![widget.index!]
                                                                              .likes1Count! >=
                                                                          0) {
                                                                        if (provider.getParticularFunUserProfileModelResultList.result![widget.index!].likeStatus !=
                                                                            1) {
                                                                          provider
                                                                              .getParticularFunUserProfileModelResultList
                                                                              .result![widget.index!]
                                                                              .likes1Count = provider.getParticularFunUserProfileModelResultList.result![widget.index!].likes1Count! + 1;
                                                                        } else {
                                                                          provider
                                                                              .getParticularFunUserProfileModelResultList
                                                                              .result![widget.index!]
                                                                              .likes1Count = provider.getParticularFunUserProfileModelResultList.result![widget.index!].likes1Count! - 1;
                                                                        }
                                                                      } else {
                                                                        provider
                                                                            .getParticularFunUserProfileModelResultList
                                                                            .result![widget
                                                                                .index!]
                                                                            .likes1Count = provider
                                                                                .getParticularFunUserProfileModelResultList.result![widget.index!].likes1Count! +
                                                                            1;
                                                                      }
                                                                      postMdl!.likeHeart(
                                                                          1,
                                                                          1,
                                                                          context,
                                                                          widget
                                                                              .index!);
                                                                    }
                                                                    // }
                                                                    // });
                                                                  },
                                                                  child: SvgPicture.asset(
                                                                      halfheart,
                                                                      color: provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].likeStatus ==
                                                                              1
                                                                          ? lightRed
                                                                          : Colors
                                                                              .white),
                                                                ),
                                                                SizedBox(
                                                                  height: ScreenUtil()
                                                                      .setHeight(
                                                                          2),
                                                                ),
                                                                Text(
                                                                  provider.getParticularFunUserProfileModelResultList.result![provider.getIndex]
                                                                              .likes1Count! >
                                                                          0
                                                                      ? "${provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].likes1Count}"
                                                                      : "",
                                                                  style: GoogleFonts
                                                                      .nunitoSans(
                                                                          color: Colors
                                                                              .white,
                                                                          shadows: [
                                                                            Shadow(
                                                                              blurRadius: 7.0,
                                                                              color: black.withOpacity(0.6),
                                                                              offset: Offset(2.0, 2.0),
                                                                            ),
                                                                          ],
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              ScreenUtil().setSp(10)),
                                                                ),
                                                                SizedBox(
                                                                  height: ScreenUtil()
                                                                      .setHeight(
                                                                          7),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    // setState(() {
                                                                    // if(isLike0 == false){
                                                                    if (provider
                                                                            .getParticularFunUserProfileModelResultList
                                                                            .result![provider.getIndex]
                                                                            .likeStatus ==
                                                                        0) {
                                                                      provider
                                                                          .getParticularFunUserProfileModelResultList
                                                                          .result![
                                                                              provider.getIndex]
                                                                          .likeStatus = null;
                                                                      provider.changeIsLike0(
                                                                          true);
                                                                      postMdl!.likeHeart(
                                                                          null,
                                                                          0,
                                                                          context,
                                                                          widget
                                                                              .index!);
                                                                    } else {
                                                                      provider
                                                                          .getParticularFunUserProfileModelResultList
                                                                          .result![
                                                                              provider.getIndex]
                                                                          .likeStatus = 0;
                                                                      provider.changeIsLike0(
                                                                          true);
                                                                      postMdl!.likeHeart(
                                                                          0,
                                                                          0,
                                                                          context,
                                                                          widget
                                                                              .index!);
                                                                    }
                                                                    // }
                                                                    // });
                                                                  },
                                                                  child: SvgPicture.asset(
                                                                      emptyheart,
                                                                      color: provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].likeStatus ==
                                                                              0
                                                                          ? lightRed
                                                                          : Colors
                                                                              .white),
                                                                ),
                                                                SizedBox(
                                                                  height: ScreenUtil()
                                                                      .setHeight(
                                                                          2),
                                                                ),
                                                              ],
                                                            )
                                                          : Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    // setState(() async {
                                                                    // if(isLike2 == false){
                                                                    if (provider
                                                                            .getParticularFunUserProfileModelResultList
                                                                            .result![provider.getIndex]
                                                                            .likeStatus ==
                                                                        2) {
                                                                      provider
                                                                          .getParticularFunUserProfileModelResultList
                                                                          .result![
                                                                              provider.getIndex]
                                                                          .likeStatus = null;
                                                                      provider.changeIsLike2(
                                                                          true);
                                                                      provider
                                                                          .getParticularFunUserProfileModelResultList
                                                                          .result![widget
                                                                              .index!]
                                                                          .likes2Count = provider
                                                                              .getParticularFunUserProfileModelResultList
                                                                              .result![widget.index!]
                                                                              .likes2Count! -
                                                                          1;
                                                                      await postMdl!.likeHeart(
                                                                          null,
                                                                          2,
                                                                          context,
                                                                          widget
                                                                              .index!);
                                                                    } else {
                                                                      provider
                                                                          .getParticularFunUserProfileModelResultList
                                                                          .result![
                                                                              provider.getIndex]
                                                                          .likeStatus = 2;
                                                                      provider.changeIsLike2(
                                                                          true);
                                                                      if (provider
                                                                              .getParticularFunUserProfileModelResultList
                                                                              .result![widget.index!]
                                                                              .likeStatus ==
                                                                          1) {
                                                                        provider
                                                                            .getParticularFunUserProfileModelResultList
                                                                            .result![widget
                                                                                .index!]
                                                                            .likes1Count = provider
                                                                                .getParticularFunUserProfileModelResultList.result![widget.index!].likes1Count! -
                                                                            1;
                                                                      }

                                                                      if (provider
                                                                              .getParticularFunUserProfileModelResultList
                                                                              .result![widget.index!]
                                                                              .likes2Count! >=
                                                                          0) {
                                                                        if (provider.getParticularFunUserProfileModelResultList.result![widget.index!].likeStatus !=
                                                                            2) {
                                                                          provider
                                                                              .getParticularFunUserProfileModelResultList
                                                                              .result![widget.index!]
                                                                              .likes2Count = provider.getParticularFunUserProfileModelResultList.result![widget.index!].likes2Count! + 1;
                                                                        } else {
                                                                          provider
                                                                              .getParticularFunUserProfileModelResultList
                                                                              .result![widget.index!]
                                                                              .likes2Count = provider.getParticularFunUserProfileModelResultList.result![widget.index!].likes2Count! - 1;
                                                                        }
                                                                      } else {
                                                                        provider
                                                                            .getParticularFunUserProfileModelResultList
                                                                            .result![widget
                                                                                .index!]
                                                                            .likes2Count = provider
                                                                                .getParticularFunUserProfileModelResultList.result![widget.index!].likes2Count! +
                                                                            1;
                                                                      }
                                                                      postMdl!.likeHeart(
                                                                          2,
                                                                          2,
                                                                          context,
                                                                          widget
                                                                              .index!);
                                                                    }
                                                                    // }
                                                                    // });
                                                                  },
                                                                  child: SvgPicture.asset(
                                                                      fullheart,
                                                                      color: provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].likeStatus ==
                                                                              2
                                                                          ? lightRed
                                                                          : Colors
                                                                              .white),
                                                                ),
                                                                SizedBox(
                                                                  height: ScreenUtil()
                                                                      .setHeight(
                                                                          2),
                                                                ),
                                                                Text(
                                                                  provider.getParticularFunUserProfileModelResultList.result![provider.getIndex]
                                                                              .likes2Count! >
                                                                          0
                                                                      ? "${provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].likes2Count}"
                                                                      : "",
                                                                  style: GoogleFonts
                                                                      .nunitoSans(
                                                                          color: Colors
                                                                              .white,
                                                                          shadows: [
                                                                            Shadow(
                                                                              blurRadius: 7.0,
                                                                              color: black.withOpacity(0.6),
                                                                              offset: Offset(2.0, 2.0),
                                                                            ),
                                                                          ],
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              ScreenUtil().setSp(10)),
                                                                ),
                                                                SizedBox(
                                                                  height: ScreenUtil()
                                                                      .setHeight(
                                                                          7),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    // setState(() {
                                                                    // if(isLike1 == false){
                                                                    if (provider
                                                                            .getParticularFunUserProfileModelResultList
                                                                            .result![provider.getIndex]
                                                                            .likeStatus ==
                                                                        1) {
                                                                      provider
                                                                          .getParticularFunUserProfileModelResultList
                                                                          .result![
                                                                              provider.getIndex]
                                                                          .likeStatus = null;
                                                                      provider.changeIsLike1(
                                                                          true);
                                                                      postMdl!.likeHeart(
                                                                          null,
                                                                          1,
                                                                          context,
                                                                          widget
                                                                              .index!);
                                                                      provider
                                                                          .getParticularFunUserProfileModelResultList
                                                                          .result![widget
                                                                              .index!]
                                                                          .likes1Count = provider
                                                                              .getParticularFunUserProfileModelResultList
                                                                              .result![widget.index!]
                                                                              .likes1Count! -
                                                                          1;
                                                                    } else {
                                                                      provider
                                                                          .getParticularFunUserProfileModelResultList
                                                                          .result![
                                                                              provider.getIndex]
                                                                          .likeStatus = 1;
                                                                      provider.changeIsLike1(
                                                                          true);
                                                                      postMdl!.likeHeart(
                                                                          1,
                                                                          1,
                                                                          context,
                                                                          widget
                                                                              .index!);
                                                                      if (provider
                                                                              .getParticularFunUserProfileModelResultList
                                                                              .result![widget.index!]
                                                                              .likeStatus ==
                                                                          2) {
                                                                        provider
                                                                            .getParticularFunUserProfileModelResultList
                                                                            .result![widget
                                                                                .index!]
                                                                            .likes2Count = provider
                                                                                .getParticularFunUserProfileModelResultList.result![widget.index!].likes2Count! -
                                                                            1;
                                                                      }

                                                                      if (provider
                                                                              .getParticularFunUserProfileModelResultList
                                                                              .result![widget.index!]
                                                                              .likes1Count! >=
                                                                          0) {
                                                                        if (provider.getParticularFunUserProfileModelResultList.result![widget.index!].likeStatus !=
                                                                            1) {
                                                                          provider
                                                                              .getParticularFunUserProfileModelResultList
                                                                              .result![widget.index!]
                                                                              .likes1Count = provider.getParticularFunUserProfileModelResultList.result![widget.index!].likes1Count! + 1;
                                                                        } else {
                                                                          provider
                                                                              .getParticularFunUserProfileModelResultList
                                                                              .result![widget.index!]
                                                                              .likes1Count = provider.getParticularFunUserProfileModelResultList.result![widget.index!].likes1Count! - 1;
                                                                        }
                                                                      } else {
                                                                        provider
                                                                            .getParticularFunUserProfileModelResultList
                                                                            .result![widget
                                                                                .index!]
                                                                            .likes1Count = provider
                                                                                .getParticularFunUserProfileModelResultList.result![widget.index!].likes1Count! +
                                                                            1;
                                                                      }
                                                                    }
                                                                    // }
                                                                    // });
                                                                  },
                                                                  child: SvgPicture.asset(
                                                                      halfheart,
                                                                      color: provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].likeStatus ==
                                                                              1
                                                                          ? lightRed
                                                                          : Colors
                                                                              .white),
                                                                ),
                                                                SizedBox(
                                                                    height: ScreenUtil()
                                                                        .setHeight(
                                                                            2)),
                                                                Text(
                                                                  provider.getParticularFunUserProfileModelResultList.result![provider.getIndex]
                                                                              .likes1Count! >
                                                                          0
                                                                      ? "${provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].likes1Count}"
                                                                      : "",
                                                                  style: GoogleFonts
                                                                      .nunitoSans(
                                                                          color: Colors
                                                                              .white,
                                                                          shadows: [
                                                                            Shadow(
                                                                              blurRadius: 7.0,
                                                                              color: black.withOpacity(0.6),
                                                                              offset: Offset(2.0, 2.0),
                                                                            ),
                                                                          ],
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontSize:
                                                                              ScreenUtil().setSp(10)),
                                                                ),
                                                                SizedBox(
                                                                  height: ScreenUtil()
                                                                      .setHeight(
                                                                          7),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    // setState(() {
                                                                    // if(isLike0 == false){
                                                                    if (provider
                                                                            .getParticularFunUserProfileModelResultList
                                                                            .result![provider.getIndex]
                                                                            .likeStatus ==
                                                                        0) {
                                                                      provider
                                                                          .getParticularFunUserProfileModelResultList
                                                                          .result![
                                                                              provider.getIndex]
                                                                          .likeStatus = null;
                                                                      provider.changeIsLike0(
                                                                          true);
                                                                      postMdl!.likeHeart(
                                                                          null,
                                                                          0,
                                                                          context,
                                                                          widget
                                                                              .index!);
                                                                    } else {
                                                                      provider
                                                                          .getParticularFunUserProfileModelResultList
                                                                          .result![
                                                                              provider.getIndex]
                                                                          .likeStatus = 0;
                                                                      provider.changeIsLike0(
                                                                          true);
                                                                      postMdl!.likeHeart(
                                                                          0,
                                                                          0,
                                                                          context,
                                                                          widget
                                                                              .index!);
                                                                    }
                                                                    // }
                                                                    // });
                                                                  },
                                                                  child: SvgPicture.asset(
                                                                      emptyheart,
                                                                      color: provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].likeStatus ==
                                                                              0
                                                                          ? lightRed
                                                                          : Colors
                                                                              .white),
                                                                ),
                                                                SizedBox(
                                                                  height: ScreenUtil()
                                                                      .setHeight(
                                                                          2),
                                                                ),
                                                              ],
                                                            ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 31.0),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            provider.getParticularFunUserProfileModelResultList
                                        .result![provider.getIndex] ==
                                    null
                                ? Container()
                                : Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: <Color>[
                                                  Colors.transparent,
                                                  Colors.black54
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            provider.getDetailShow == true
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            14.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage: NetworkImage(provider
                                                                          .getParticularFunUserProfileModelResultList
                                                                          .result![
                                                                              provider.getIndex]
                                                                          .users!
                                                                          .profileImageType ==
                                                                      'avatar'
                                                                  ? "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].users!.profileImage}"
                                                                  : "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].users!.profileImage}"),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              (provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].users !=
                                                                          null &&
                                                                      provider
                                                                          .getParticularFunUserProfileModelResultList
                                                                          .result![provider
                                                                              .getIndex]
                                                                          .users
                                                                          .toString()
                                                                          .isNotEmpty &&
                                                                      provider
                                                                          .getParticularFunUserProfileModelResultList
                                                                          .result![provider
                                                                              .getIndex]
                                                                          .users
                                                                          .toString()
                                                                          .isNotEmpty &&
                                                                      provider
                                                                              .getParticularFunUserProfileModelResultList
                                                                              .result![provider
                                                                                  .getIndex]
                                                                              .users!
                                                                              .username
                                                                              .toString() !=
                                                                          null)
                                                                  ? provider
                                                                      .getParticularFunUserProfileModelResultList
                                                                      .result![
                                                                          provider
                                                                              .getIndex]
                                                                      .users!
                                                                      .name
                                                                      .toString()
                                                                  : "",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts
                                                                  .nunitoSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            20),
                                                                shadows: [
                                                                  Shadow(
                                                                    blurRadius:
                                                                        7.0,
                                                                    color: black
                                                                        .withOpacity(
                                                                            0.6),
                                                                    offset:
                                                                        Offset(
                                                                            2.0,
                                                                            2.0),
                                                                  ),
                                                                ],
                                                                color: white,
                                                              ),
                                                            ),
                                                            SizedBox(width: 15),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : Container(),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                bottom: 0,
                                              ),
                                              child: Row(
                                                children: [
                                                  Wrap(
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: ScreenUtil()
                                                              .setWidth(22),
                                                        ),
                                                        child: InkWell(
                                                          onTap: () {
                                                            provider.changeDetailShow(
                                                                !provider
                                                                    .getDetailShow);
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                    boxShadow: [
                                                                  BoxShadow(
                                                                    blurRadius:
                                                                        3.0,
                                                                    color: black
                                                                        .withOpacity(
                                                                            0.05),
                                                                    offset:
                                                                        Offset(
                                                                            1.0,
                                                                            .0),
                                                                  ),
                                                                ]),
                                                            child: SvgPicture.asset(
                                                                "assets/icons/svg/info.svg"),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: ScreenUtil()
                                                            .setWidth(8),
                                                      ),
                                                      Visibility(
                                                        visible: true,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 5.h),
                                                          child: Row(
                                                            children: [
                                                              InkWell(
                                                                child:
                                                                    ConstrainedBox(
                                                                  constraints: BoxConstraints(
                                                                      maxWidth:
                                                                          (ScreenUtil().screenWidth / 2) -
                                                                              50),
                                                                  child: Text(
                                                                    (provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].users !=
                                                                                null &&
                                                                            provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].users
                                                                                .toString()
                                                                                .isNotEmpty &&
                                                                            provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].users
                                                                                .toString()
                                                                                .isNotEmpty &&
                                                                            provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].users!.username.toString() !=
                                                                                null)
                                                                        ? provider.getDetailShow !=
                                                                                true
                                                                            ? provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].users!.username.toString()
                                                                            : provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].description.toString()
                                                                        : "",
                                                                    style: GoogleFonts
                                                                        .nunitoSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          ScreenUtil()
                                                                              .setSp(16),
                                                                      shadows: [
                                                                        Shadow(
                                                                          blurRadius:
                                                                              7.0,
                                                                          color:
                                                                              black.withOpacity(0.6),
                                                                          offset: Offset(
                                                                              2.0,
                                                                              2.0),
                                                                        ),
                                                                      ],
                                                                      color:
                                                                          white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: ScreenUtil()
                                                            .setWidth(8),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            provider.getIndex >=
                                                    fameLinkFun.dataFameLink
                                                        .length /*&&dataFameLink[particularFameLink.getIndex] == null*/
                                                ? Container()
                                                : Center(
                                                    child: provider.getIndex >=
                                                                fameLinkFun
                                                                    .dataFameLink
                                                                    .length &&
                                                            fameLinkFun
                                                                    .dataFameLink[
                                                                        provider
                                                                            .getIndex]
                                                                    .famelinksContest ==
                                                                true
                                                        ? Image.asset(
                                                            "assets/icons/logo.png",
                                                            height: 20.h,
                                                            width: 20.w,
                                                            color: white)
                                                        : provider.getIndex >=
                                                                    fameLinkFun
                                                                        .dataFameLink
                                                                        .length &&
                                                                fameLinkFun.dataFameLink[provider.getIndex].ambassadorTrendz ==
                                                                    true
                                                            ? Icon(Icons.stars,
                                                                size: 20.r,
                                                                color: white)
                                                            : Container(),
                                                  ),
                                            //ModernMixMetroMast
                                            InkWell(
                                              onTap: () {
                                                print("test");
                                                ChallengesModelData
                                                    challengesModelData =
                                                    ChallengesModelData(
                                                        id: "",
                                                        challengeId: provider
                                                            .getParticularFunUserProfileModelResultList!
                                                            .result![provider
                                                                .getIndex]
                                                            .challenges![0]
                                                            .sId!,
                                                        challengeName: provider
                                                            .getParticularFunUserProfileModelResultList!
                                                            .result![provider
                                                                .getIndex]
                                                            .challenges![0]
                                                            .hashTag!,
                                                        postId: "");

                                                Provider.of<FameLinksFeedProvider>(
                                                        context,
                                                        listen: false)
                                                    .changeOnPageTurning(true);
                                                Provider.of<FameLinksFeedProvider>(
                                                        context,
                                                        listen: false)
                                                    .changeOnPageHorizontalTurning(
                                                        true);

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FameLinksChallengeScreen(
                                                            challengesModelData:
                                                                challengesModelData,
                                                          )),
                                                );
                                              },
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Text(
                                                  (provider
                                                                  .getParticularFunUserProfileModelResultList
                                                                  .result![provider
                                                                      .getIndex]
                                                                  .challenges !=
                                                              null &&
                                                          provider
                                                              .getParticularFunUserProfileModelResultList
                                                              .result![provider
                                                                  .getIndex]
                                                              .challenges!
                                                              .isNotEmpty &&
                                                          provider
                                                                  .getParticularFunUserProfileModelResultList
                                                                  .result![provider
                                                                      .getIndex]
                                                                  .challenges!
                                                                  .length !=
                                                              0 &&
                                                          provider
                                                                  .getParticularFunUserProfileModelResultList
                                                                  .result![provider
                                                                      .getIndex]
                                                                  .challenges![
                                                                      0]
                                                                  .hashTag !=
                                                              null &&
                                                          provider
                                                              .getParticularFunUserProfileModelResultList
                                                              .result![provider
                                                                  .getIndex]
                                                              .challenges![0]
                                                              .hashTag
                                                              .toString()
                                                              .isNotEmpty)
                                                      ? "${provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].challenges![0].hashTag.toString()}"
                                                      : "",
                                                  style: GoogleFonts.nunitoSans(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // Comment
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        postMdl!.commentPage =
                                                            1;
                                                        postMdl!.commentType =
                                                            'famelinks';
                                                        postMdl!
                                                            .getCommentalert(
                                                                context);
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            left: ScreenUtil()
                                                                .setWidth(20)),
                                                        decoration:
                                                            BoxDecoration(
                                                                boxShadow: [
                                                              BoxShadow(
                                                                blurRadius: 3.0,
                                                                color: black
                                                                    .withOpacity(
                                                                        0.1),
                                                                offset: Offset(
                                                                    1.0, .0),
                                                              ),
                                                            ]),
                                                        child: SvgPicture.asset(
                                                            "assets/icons/svg/comment.svg",
                                                            color: white),
                                                      ),
                                                    ),

                                                    // Share
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: ScreenUtil()
                                                              .setWidth(5),
                                                          bottom: ScreenUtil()
                                                              .setHeight(10)),
                                                      child: IconButton(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        icon: SvgPicture.asset(
                                                            "assets/icons/svg/share.svg",
                                                            color: white),
                                                        onPressed: () {
                                                          if (provider
                                                                  .getIndex >=
                                                              0) {
                                                            provider
                                                                    .getParticularFunUserProfileModelResultList
                                                                    .result![
                                                                        provider
                                                                            .getIndex]
                                                                    .media![0]
                                                                    .path!
                                                                    .isEmpty
                                                                ? null
                                                                : showFamLinkShareDialog(
                                                                    context,
                                                                    provider
                                                                        .getParticularFunUserProfileModelResultList
                                                                        .result![provider
                                                                            .getIndex]
                                                                        .media![
                                                                            0]
                                                                        .path!,
                                                                    provider
                                                                        .getParticularFunUserProfileModelResultList
                                                                        .result![provider
                                                                            .getIndex]
                                                                        .media![
                                                                            0]
                                                                        .type!,
                                                                    provider
                                                                        .getIndex);
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: ScreenUtil()
                                                          .setHeight(8),
                                                      left: 20.w),
                                                  child: SmoothPageIndicator(
                                                    controller: provider
                                                        .smoothPageController!,
                                                    count: (provider
                                                                    .getParticularFunUserProfileModelResultList.result !=
                                                                null &&
                                                            provider
                                                                .getParticularFunUserProfileModelResultList
                                                                .result!
                                                                .isNotEmpty &&
                                                            provider
                                                                    .getParticularFunUserProfileModelResultList
                                                                    .result![
                                                                        provider
                                                                            .getIndex]
                                                                    .media !=
                                                                null &&
                                                            provider
                                                                .getParticularFunUserProfileModelResultList
                                                                .result![provider
                                                                    .getIndex]
                                                                .media!
                                                                .isNotEmpty &&
                                                            provider
                                                                    .getParticularFunUserProfileModelResultList
                                                                    .result![
                                                                        provider
                                                                            .getIndex]
                                                                    .media!
                                                                    .length !=
                                                                null)
                                                        ? provider
                                                            .getParticularFunUserProfileModelResultList
                                                            .result![provider
                                                                .getIndex]
                                                            .media!
                                                            .length
                                                        : 0,
                                                    // count: 5,
                                                    axisDirection:
                                                        Axis.horizontal,
                                                    effect: SlideEffect(
                                                        spacing: 10.0,
                                                        radius: 3.0,
                                                        dotWidth: 6.0,
                                                        dotHeight: 6.0,
                                                        paintStyle:
                                                            PaintingStyle
                                                                .stroke,
                                                        strokeWidth: 1.5,
                                                        dotColor: Colors.white,
                                                        activeDotColor:
                                                            lightRed),
                                                  ),
                                                ),
                                                // Text("", style: TextStyle(color: Colors.transparent)),
                                                // Text("DAFAF",
                                                //     style: TextStyle(color: Colors.transparent)),
                                                SvgPicture.asset(
                                                    "assets/icons/svg/comment.svg",
                                                    color: Colors.transparent),

                                                SvgPicture.asset(
                                                    "assets/icons/svg/comment.svg",
                                                    color: Colors.transparent),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        )
                      : Center(child: CircularProgressIndicator()),
            );
    });
  }

  void showFamLinkShareDialog(
      BuildContext context, String path, String type, int index) {
    final data = Provider.of<GetParticularFameLinksProfileProvider>(context,
            listen: false)
        .getParticularFunUserProfileModelResultList
        .result![index];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.only(
                  left: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - 213) / 2),
                  right: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - 213) / 2)),
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
                      SizedBox(
                        height: ScreenUtil().setSp(20),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.pop(context2);

                          Sharedynamic.shareprofile(data.sId.toString(),
                              "famelinkfeed", data.description.toString());
                          Navigator.pop(context);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setSp(12),
                                bottom: ScreenUtil().setSp(12)),
                            child: Text("Share Link",
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
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
                        onTap: () async {
                          // Navigator.pop(context2);
                          postMdl!.onShare(path, type, index, context);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setSp(12),
                                bottom: ScreenUtil().setSp(12)),
                            child: Text(
                                // data.media[ind].mediaType == "video"
                                //     ? "Share Video"
                                //     : "Share Image",
                                "Share Image",
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
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

  void showOtherReportDialog(String postId, bool isComment) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return showOtherReportDialogs(
            isComment: isComment,
            postId: postId,
          );
        });
  }

  @override
  void onPlayingChange(bool isPlaying) {
    // TODO: implement onPlayingChange
  }

  @override
  void onProfileClick() {
    // TODO: implement onProfileClick
  }
}
