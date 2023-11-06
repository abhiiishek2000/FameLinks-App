import 'dart:async';

import 'package:decorated_icon/decorated_icon.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/userUpdateResponse.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/providers/FeedProvider/GetPerticularFollowLinksProfileProvider.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../databse/AppDatabase.dart';
import '../../fameLinks/provider/FameLinksFeedProvider.dart';
import '../../funlinks/FameLinksChallengeScreen.dart';
import 'widget/FollowscrollFeed.dart';

class GetParticularFollowLinksProfile extends StatefulWidget {
  final String? id;
  final String? userid;
  final int? index;

  const GetParticularFollowLinksProfile({Key? key, this.id, this.index, this.userid})
      : super(key: key);

  @override
  _GetParticularFollowLinksProfileState createState() =>
      _GetParticularFollowLinksProfileState();
}

class _GetParticularFollowLinksProfileState
    extends State<GetParticularFollowLinksProfile>
    with TickerProviderStateMixin {
  GetParticularFollowLinksProfileProvider? postMdl;

  @override
  void initState() {
    postMdl = Provider.of<GetParticularFollowLinksProfileProvider>(context,
        listen: false);
    // TODO: implement initState
    // getFollowLinkFeed(widget.id!, context);
    getMe();
    _initGoogleMobileAds();
    postMdl!.followLinks();
    postMdl!.controller = PageController(
        viewportFraction: 1, keepPage: true, initialPage: widget.index!);
    postMdl!.controllerMultipleImage =
        PageController(viewportFraction: 1, keepPage: true, initialPage: 0);
    postMdl!.smoothPageController =
        PageController(keepPage: true, initialPage: 0);
    super.initState();
  }

  getMe() async {
    await postMdl!.getFollowLinkFeedData(context, widget.id!,widget.id!);
    postMdl!.changeIndex(int.parse(widget.index.toString()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // videoFollowController.clear();
    Constants.playing = false;
    super.dispose();
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetParticularFollowLinksProfileProvider>(
        builder: (context, provider, child) {
      return Scaffold(
        body: provider.getParticularFunUserProfileModelResultList.result!
                    .length !=
                0
            ? Stack(
                children: [
                  PinchZoom(
                    child: FollowscrollFeed(
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
                  provider.getParticularFunUserProfileModelResultList
                              .result![provider.getIndex] ==
                          null
                      ? Container()
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("asfdsfdsf",
                                style: TextStyle(color: Colors.transparent)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setSp(91),
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
                                                color: black.withOpacity(0.5),
                                                offset: Offset(1.5, 1.5),
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            postMdl!.showReportPostDialog(
                                                context,
                                                provider,
                                                provider
                                                    .getParticularFunUserProfileModelResultList
                                                    .result![provider.getIndex]
                                                    .user!
                                                    .sId!,
                                                provider
                                                    .getParticularFunUserProfileModelResultList
                                                    .result![provider.getIndex]
                                                    .sId!,
                                                false);
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        provider
                                                    .getParticularFunUserProfileModelResultList
                                                    .result![provider.getIndex]
                                                    .media![0]
                                                    .type
                                                    .toString() ==
                                                "video"
                                            ? IconButton(
                                                onPressed: () {
                                                  provider.changeIsMute(
                                                      !provider.getIsMute);
                                                },
                                                icon: Icon(
                                                  provider.getIsMute
                                                      ? Icons.volume_up_sharp
                                                      : Icons.volume_off_sharp,
                                                  color: white,
                                                ))
                                            : Container()
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 120),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              if (postMdl!.isLike == false) {
                                                if (provider
                                                        .getParticularFunUserProfileModelResultList
                                                        .result![
                                                            provider.getIndex]
                                                        .likeStatus ==
                                                    2) {
                                                  provider
                                                      .getParticularFunUserProfileModelResultList
                                                      .result![
                                                          provider.getIndex]
                                                      .likeStatus = null;
                                                  provider
                                                      .getParticularFunUserProfileModelResultList
                                                      .result![
                                                          provider.getIndex]
                                                      .likesCount = provider
                                                          .getParticularFunUserProfileModelResultList
                                                          .result![
                                                              provider.getIndex]
                                                          .likesCount! -
                                                      1;
                                                  postMdl!.isLike = true;
                                                  postMdl!.likeFunLinks(
                                                      null, context);
                                                } else {
                                                  provider
                                                      .getParticularFunUserProfileModelResultList
                                                      .result![
                                                          provider.getIndex]
                                                      .likeStatus = 2;
                                                  provider
                                                      .getParticularFunUserProfileModelResultList
                                                      .result![
                                                          provider.getIndex]
                                                      .likesCount = provider
                                                          .getParticularFunUserProfileModelResultList
                                                          .result![
                                                              provider.getIndex]
                                                          .likesCount! +
                                                      1;
                                                  postMdl!.isLike = true;
                                                  postMdl!
                                                      .likeFunLinks(2, context);
                                                }
                                              }
                                            },
                                            icon: Icon(
                                                provider
                                                            .getParticularFunUserProfileModelResultList
                                                            .result![provider
                                                                .getIndex]
                                                            .likeStatus ==
                                                        null
                                                    ? Icons.favorite_border
                                                    : Icons.favorite_sharp,
                                                color: provider
                                                            .getParticularFunUserProfileModelResultList
                                                            .result![provider
                                                                .getIndex]
                                                            .likeStatus ==
                                                        null
                                                    ? white
                                                    : Colors.red)),
                                        Text(
                                          provider
                                                      .getParticularFunUserProfileModelResultList
                                                      .result![
                                                          provider.getIndex]
                                                      .likesCount !=
                                                  null
                                              ? "${provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].likesCount}"
                                              : "",
                                          style: GoogleFonts.nunitoSans(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: ScreenUtil().setSp(10)),
                                        )
                                      ],
                                    ),
                                  ),
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  provider.getDetailShow == true
                                      ? Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage: NetworkImage(provider
                                                                .getParticularFunUserProfileModelResultList
                                                                .result![provider
                                                                    .getIndex]
                                                                .user!
                                                                .profileImageType ==
                                                            'avatar'
                                                        ? "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].user!.profileImage}"
                                                        : "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].user!.profileImage}"),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    (provider
                                                                    .getParticularFunUserProfileModelResultList
                                                                    .result![
                                                                        provider
                                                                            .getIndex]
                                                                    .user !=
                                                                null &&
                                                            provider
                                                                .getParticularFunUserProfileModelResultList
                                                                .result![provider
                                                                    .getIndex]
                                                                .user
                                                                .toString()
                                                                .isNotEmpty &&
                                                            provider
                                                                .getParticularFunUserProfileModelResultList
                                                                .result![provider
                                                                    .getIndex]
                                                                .user
                                                                .toString()
                                                                .isNotEmpty &&
                                                            provider
                                                                    .getParticularFunUserProfileModelResultList
                                                                    .result![
                                                                        provider
                                                                            .getIndex]
                                                                    .user!
                                                                    .username
                                                                    .toString() !=
                                                                null)
                                                        ? provider
                                                            .getParticularFunUserProfileModelResultList
                                                            .result![provider
                                                                .getIndex]
                                                            .user!
                                                            .name
                                                            .toString()
                                                        : "",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: ScreenUtil()
                                                          .setSp(20),
                                                      shadows: [
                                                        Shadow(
                                                          blurRadius: 7.0,
                                                          color: black
                                                              .withOpacity(0.6),
                                                          offset:
                                                              Offset(2.0, 2.0),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(22),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              provider.changeDetailShow(
                                                  !provider.getDetailShow);
                                            },
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(top: 0.h),
                                              child: Container(
                                                decoration:
                                                    BoxDecoration(boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 3.0,
                                                    color:
                                                        black.withOpacity(0.07),
                                                    offset: Offset(1.0, .0),
                                                  ),
                                                ]),
                                                child: SvgPicture.asset(
                                                    "assets/icons/svg/info.svg"),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Visibility(
                                              visible: true,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8.w, right: 8.w),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      child: ConstrainedBox(
                                                        constraints: BoxConstraints(
                                                            maxWidth: (ScreenUtil()
                                                                        .screenWidth /
                                                                    2) -
                                                                50),
                                                        child: Text(
                                                          (provider
                                                                          .getParticularFunUserProfileModelResultList
                                                                          .result![provider
                                                                              .getIndex]
                                                                          .user !=
                                                                      null &&
                                                                  provider
                                                                          .getParticularFunUserProfileModelResultList
                                                                          .result![provider
                                                                              .getIndex]
                                                                          .user!
                                                                          .username
                                                                          .toString() !=
                                                                      null)
                                                              ? provider.getDetailShow !=
                                                                      true
                                                                  ? provider
                                                                      .getParticularFunUserProfileModelResultList
                                                                      .result![
                                                                          provider
                                                                              .getIndex]
                                                                      .user!
                                                                      .username
                                                                      .toString()
                                                                  : provider
                                                                      .getParticularFunUserProfileModelResultList
                                                                      .result![
                                                                          provider
                                                                              .getIndex]
                                                                      .description
                                                                      .toString()
                                                              : "",
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(16),
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
                                                            color: white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      ScreenUtil().setWidth(9)),
                                              child: provider
                                                          .getParticularFunUserProfileModelResultList
                                                          .result![
                                                              provider.getIndex]
                                                          .tags ==
                                                      null
                                                  ? Container()
                                                  : Text(
                                                      provider
                                                          .getParticularFunUserProfileModelResultList
                                                          .result![
                                                              provider.getIndex]
                                                          .tags
                                                          .toString()
                                                          .replaceAll('[]', ''),
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: ScreenUtil()
                                                            .setSp(16),
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
                                                        color: white,
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // const SizedBox(height: 8.0),

                                  // const SizedBox(height: 2.0),
                                  //ModernMixMetroMast
                                  InkWell(
                                    onTap: () {
                                      print("test");
                                      ChallengesModelData challengesModelData =
                                          ChallengesModelData(
                                              id: "",
                                              challengeId: provider
                                                  .getParticularFunUserProfileModelResultList!
                                                  .result![provider.getIndex]
                                                  .challenges![0]
                                                  .sId!,
                                              challengeName: provider
                                                  .getParticularFunUserProfileModelResultList!
                                                  .result![provider.getIndex]
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
                                          .changeOnPageHorizontalTurning(true);

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
                                      alignment: Alignment.center,
                                      child: Text(
                                        (provider
                                                        .getParticularFunUserProfileModelResultList
                                                        .result![
                                                            provider.getIndex]
                                                        .challenges !=
                                                    null &&
                                                provider
                                                    .getParticularFunUserProfileModelResultList
                                                    .result![provider.getIndex]
                                                    .challenges!
                                                    .isNotEmpty &&
                                                provider
                                                        .getParticularFunUserProfileModelResultList
                                                        .result![
                                                            provider.getIndex]
                                                        .challenges!
                                                        .length !=
                                                    0 &&
                                                provider
                                                        .getParticularFunUserProfileModelResultList
                                                        .result![
                                                            provider.getIndex]
                                                        .challenges![0]
                                                        .hashTag !=
                                                    null &&
                                                provider
                                                    .getParticularFunUserProfileModelResultList
                                                    .result![provider.getIndex]
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
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Comment
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              postMdl!.commentPage = 1;
                                              postMdl!.commentType =
                                                  'famelinks';
                                              postMdl!.getCommentalert(context);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: ScreenUtil()
                                                      .setWidth(20)),
                                              decoration:
                                                  BoxDecoration(boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 3.0,
                                                  color: black.withOpacity(0.1),
                                                  offset: Offset(1.0, .0),
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
                                                left: ScreenUtil().setWidth(5),
                                                bottom:
                                                    ScreenUtil().setHeight(10)),
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: SvgPicture.asset(
                                                  "assets/icons/svg/share.svg",
                                                  color: white),
                                              onPressed: () {
                                                if (provider.getIndex >= 0) {
                                                  provider
                                                          .getParticularFunUserProfileModelResultList
                                                          .result![
                                                              provider.getIndex]
                                                          .media![0]
                                                          .path!
                                                          .isEmpty
                                                      ? null
                                                      : postMdl!.showFamLinkShareDialog(
                                                          context,
                                                          provider
                                                              .getParticularFunUserProfileModelResultList
                                                              .result![provider
                                                                  .getIndex]
                                                              .media![0]
                                                              .path!,
                                                          provider
                                                              .getParticularFunUserProfileModelResultList
                                                              .result![provider
                                                                  .getIndex]
                                                              .media![0]
                                                              .type!,
                                                          provider.getIndex);
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(0)),
                                        child: SmoothPageIndicator(
                                          controller:
                                              postMdl!.smoothPageController!,
                                          count: (provider.getParticularFunUserProfileModelResultList
                                                          .result! !=
                                                      null &&
                                                  provider
                                                      .getParticularFunUserProfileModelResultList
                                                      .result!
                                                      .isNotEmpty &&
                                                  provider
                                                          .getParticularFunUserProfileModelResultList
                                                          .result![
                                                              provider.getIndex]
                                                          .media !=
                                                      null &&
                                                  provider
                                                      .getParticularFunUserProfileModelResultList
                                                      .result![
                                                          provider.getIndex]
                                                      .media!
                                                      .isNotEmpty &&
                                                  provider
                                                          .getParticularFunUserProfileModelResultList
                                                          .result![
                                                              provider.getIndex]
                                                          .media!
                                                          .length !=
                                                      null)
                                              ? provider
                                                  .getParticularFunUserProfileModelResultList
                                                  .result![provider.getIndex]
                                                  .media!
                                                  .length
                                              : 0,
                                          // count: 5,
                                          axisDirection: Axis.horizontal,
                                          effect: SlideEffect(
                                              spacing: 10.0,
                                              radius: 3.0,
                                              dotWidth: 6.0,
                                              dotHeight: 6.0,
                                              paintStyle: PaintingStyle.stroke,
                                              strokeWidth: 1.5,
                                              dotColor: Colors.white,
                                              activeDotColor: lightRed),
                                        ),
                                      ),
                                      Text("",
                                          style: TextStyle(
                                              color: Colors.transparent)),
                                      Text("DAFAF",
                                          style: TextStyle(
                                              color: Colors.transparent)),
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

  showRestrictAlertDialog(String userId) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Yes", style: GoogleFonts.nunitoSans(color: lightRed)),
      onPressed: () async {
        Navigator.pop(context, true);
        Api.post.call(context, method: "users/restrict/${userId}", param: {},
            onResponseSuccess: (Map object) {
          var result = UserUpdatedResponse.fromJson(object);
          Constants.toastMessage(msg: result.message);
        });
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
      content: Text("Are you sure you won't to restrict this user?"),
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

  showBlockAlertDialog(String userId) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Yes", style: GoogleFonts.nunitoSans(color: lightRed)),
      onPressed: () async {
        Navigator.pop(context, true);
        Api.post.call(context, method: "users/block/${userId}", param: {},
            onResponseSuccess: (Map object) {
          var result = UserUpdatedResponse.fromJson(object);
          Constants.toastMessage(msg: result.message);
        });
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
      content: Text("Are you sure you won't to block this user?"),
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

  void showReportDialog(String postId, bool isComment) {
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
                  builder: (BuildContext context, StateSetter setStates) {
                return Form(
                  key: postMdl!.reportKey,
                  child: Container(
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
                              top: ScreenUtil().setHeight(15),
                              bottom: ScreenUtil().setHeight(12),
                              left: ScreenUtil().setWidth(5),
                              right: ScreenUtil().setWidth(5)),
                          child: Center(
                            child: Text(
                              isComment ? "Report Comment" : "Report Post",
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(16),
                                  color: white,
                                  fontWeight: FontWeight.w600),
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
                              Theme(
                                data: ThemeData(
                                  //here change to your color
                                  unselectedWidgetColor: lightGray,
                                ),
                                child: RadioButton(
                                  description: "Nudity",
                                  value: "nudity",
                                  groupValue: postMdl!.postSingleValue,
                                  onChanged: (value) => setStates(
                                    () => postMdl!.postSingleValue = "nudity",
                                  ),
                                  activeColor: lightRed,
                                ),
                              ),
                              Theme(
                                data: ThemeData(
                                  //here change to your color
                                  unselectedWidgetColor: lightGray,
                                ),
                                child: RadioButton(
                                  description: "Spam",
                                  value: "spam",
                                  groupValue: postMdl!.postSingleValue,
                                  onChanged: (value) => setStates(
                                    () => postMdl!.postSingleValue = "spam",
                                  ),
                                  activeColor: lightRed,
                                ),
                              ),
                              Theme(
                                data: ThemeData(
                                  //here change to your color
                                  unselectedWidgetColor: lightGray,
                                ),
                                child: RadioButton(
                                  description: "Vulgarity",
                                  value: "vulgarity",
                                  groupValue: postMdl!.postSingleValue,
                                  onChanged: (value) => setStates(
                                    () =>
                                        postMdl!.postSingleValue = "vulgarity",
                                  ),
                                  activeColor: lightRed,
                                ),
                              ),
                              Theme(
                                data: ThemeData(
                                  //here change to your color
                                  unselectedWidgetColor: lightGray,
                                ),
                                child: RadioButton(
                                  description: "Abusive Content",
                                  value: "abusive",
                                  groupValue: postMdl!.postSingleValue,
                                  onChanged: (value) => setStates(
                                    () => postMdl!.postSingleValue = "abusive",
                                  ),
                                  activeColor: lightRed,
                                ),
                              ),
                              Theme(
                                data: ThemeData(
                                  //here change to your color
                                  unselectedWidgetColor: lightGray,
                                ),
                                child: RadioButton(
                                  description: "Racism",
                                  value: "rasicm",
                                  groupValue: postMdl!.postSingleValue,
                                  onChanged: (value) => setStates(
                                    () => postMdl!.postSingleValue = "rasicm",
                                  ),
                                  activeColor: lightRed,
                                ),
                              ),
                              Theme(
                                data: ThemeData(
                                  //here change to your color
                                  unselectedWidgetColor: lightGray,
                                ),
                                child: RadioButton(
                                  description: "Copyright Issues",
                                  value: "copyright",
                                  groupValue: postMdl!.postSingleValue,
                                  onChanged: (value) => setStates(
                                    () =>
                                        postMdl!.postSingleValue = "copyright",
                                  ),
                                  activeColor: lightRed,
                                ),
                              ),
                              Theme(
                                data: ThemeData(
                                  //here change to your color
                                  unselectedWidgetColor: lightGray,
                                ),
                                child: RadioButton(
                                  description: "Others",
                                  value: "other",
                                  groupValue: postMdl!.postSingleValue,
                                  onChanged: (value) => setStates(
                                    () => postMdl!.postSingleValue = "other",
                                  ),
                                  activeColor: lightRed,
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                height: 1,
                                color: lightGray,
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: InkWell(
                                      onTap: () async {
                                        if (isComment) {
                                          if (postMdl!
                                              .postSingleValue.isNotEmpty) {
                                            if (postMdl!.postSingleValue ==
                                                "other") {
                                              Navigator.pop(context);
                                              showOtherReportDialog(
                                                  postId, isComment);
                                            } else {
                                              Map<String, dynamic> params = {
                                                "body": postMdl!
                                                            .postSingleValue ==
                                                        "other"
                                                    ? postMdl!
                                                        .reportPostController
                                                        .text
                                                    : "null",
                                                "type":
                                                    postMdl!.postSingleValue,
                                              };
                                              Api.post.call(context,
                                                  method:
                                                      "users/report/comment/${postId}",
                                                  param: params,
                                                  onResponseSuccess:
                                                      (Map object) {
                                                var result = UserUpdatedResponse
                                                    .fromJson(object);
                                                Constants.toastMessage(
                                                    msg: result.message);
                                                postMdl!.postSingleValue = "";
                                                postMdl!.reportPostController
                                                    .text = "";
                                                Navigator.of(context).pop();
                                              });
                                            }
                                          }
                                        } else {
                                          if (postMdl!
                                              .postSingleValue.isNotEmpty) {
                                            if (postMdl!.postSingleValue ==
                                                "other") {
                                              Navigator.pop(context);
                                              showOtherReportDialog(
                                                  postId, isComment);
                                            } else {
                                              Map<String, dynamic> params = {
                                                "body": postMdl!
                                                            .postSingleValue ==
                                                        "other"
                                                    ? postMdl!
                                                        .reportPostController
                                                        .text
                                                    : "null",
                                                "type":
                                                    postMdl!.postSingleValue,
                                              };
                                              Api.post.call(context,
                                                  method:
                                                      "users/report/post/${postId}",
                                                  param: params,
                                                  onResponseSuccess:
                                                      (Map object) {
                                                var result = UserUpdatedResponse
                                                    .fromJson(object);
                                                Constants.toastMessage(
                                                    msg: result.message);
                                                postMdl!.postSingleValue = "";
                                                postMdl!.reportPostController
                                                    .text = "";
                                                Navigator.pop(context);
                                              });
                                            }
                                          }
                                        }
                                      },
                                      child: Center(
                                          child: Padding(
                                        padding: EdgeInsets.only(
                                            top: ScreenUtil().setSp(11),
                                            bottom: ScreenUtil().setSp(11)),
                                        child: Text("Submit",
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                color: black)),
                                      )),
                                    )),
                                    VerticalDivider(
                                      thickness: 1,
                                      width: 1,
                                      color: lightGray,
                                    ),
                                    Expanded(
                                        child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Center(
                                          child: Padding(
                                        padding: EdgeInsets.only(
                                            top: ScreenUtil().setSp(11),
                                            bottom: ScreenUtil().setSp(11)),
                                        child: Text("Cancel",
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                color: lightGray)),
                                      )),
                                    )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }));
        });
  }

  void showOtherReportDialog(String postId, bool isComment) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.only(
                  left: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - 245) / 2),
                  right: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - 245) / 2)),
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setStates) {
                return Container(
                  decoration: BoxDecoration(
                      color: appBackgroundColor,
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
                      TextFormField(
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(250),
                        ],
                        controller: postMdl!.reportPostController,
                        minLines: 6,
                        maxLines: 6,
                        keyboardType: TextInputType.multiline,
                        style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: darkGray),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(top: 20, left: 10, right: 10),
                          hintText: 'Write Whats wrong with the Content',
                          hintStyle: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(12),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              color: lightGray),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular(ScreenUtil().setSp(16)),
                                topRight:
                                    Radius.circular(ScreenUtil().setSp(16))),
                            borderSide: BorderSide(
                              width: 1,
                              color: buttonBlue,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular(ScreenUtil().setSp(16)),
                                topRight:
                                    Radius.circular(ScreenUtil().setSp(16))),
                            borderSide: BorderSide(
                              width: 1,
                              color: buttonBlue,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: lightGray,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                                child: Center(
                                    child: InkWell(
                              onTap: () async {
                                if (isComment) {
                                  if (postMdl!.postSingleValue.isNotEmpty) {
                                    Map<String, dynamic> params = {
                                      "body": postMdl!.postSingleValue ==
                                              "other"
                                          ? postMdl!.reportPostController.text
                                          : "null",
                                      "type": postMdl!.postSingleValue,
                                    };
                                    Api.post.call(context,
                                        method:
                                            "users/report/comment/${postId}",
                                        param: params,
                                        onResponseSuccess: (Map object) {
                                      var result =
                                          UserUpdatedResponse.fromJson(object);
                                      Constants.toastMessage(
                                          msg: result.message);
                                      postMdl!.postSingleValue = "";
                                      postMdl!.reportPostController.text = "";
                                      Navigator.of(context).pop();
                                    });
                                  }
                                } else {
                                  if (postMdl!.postSingleValue.isNotEmpty) {
                                    Map<String, dynamic> params = {
                                      "body": postMdl!.postSingleValue ==
                                              "other"
                                          ? postMdl!.reportPostController.text
                                          : "null",
                                      "type": postMdl!.postSingleValue,
                                    };
                                    Api.post.call(context,
                                        method: "users/report/post/${postId}",
                                        param: params,
                                        onResponseSuccess: (Map object) {
                                      var result =
                                          UserUpdatedResponse.fromJson(object);
                                      Constants.toastMessage(
                                          msg: result.message);
                                      postMdl!.postSingleValue = "";
                                      postMdl!.reportPostController.text = "";
                                      Navigator.pop(context);
                                    });
                                  }
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setSp(11),
                                    bottom: ScreenUtil().setSp(11)),
                                child: Text("Submit",
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w700,
                                        fontSize: ScreenUtil().setSp(14),
                                        color: black)),
                              ),
                            ))),
                            VerticalDivider(
                              thickness: 1,
                              width: 1,
                              color: lightGray,
                            ),
                            Expanded(
                                child: Center(
                                    child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setSp(11),
                                    bottom: ScreenUtil().setSp(11)),
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
                );
              }));
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
