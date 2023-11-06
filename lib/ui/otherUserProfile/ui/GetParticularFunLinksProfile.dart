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

import '../../../databse/AppDatabase.dart';
import '../../../nativeads/nativeadsprovider.dart';
import '../../../providers/FeedProvider/GetParticularFunLinksProfileProvider.dart';
import '../../../share/firebasedynamiclink.dart';
import '../../../util/widgets/FeedVideoPlayer.dart';
import '../../Famelinkprofile/function/famelinkFun.dart';
import '../../fameLinks/provider/FameLinksFeedProvider.dart';
import '../../funlinks/FameLinksChallengeScreen.dart';
import '../provder/ShareFunction.dart';

class GetParticularFunLinksProfile extends StatefulWidget {
  final String? id;
  final String? userid;
  final int? index;

  const GetParticularFunLinksProfile(
      {Key? key, this.id, this.index, this.userid})
      : super(key: key);

  @override
  _GetParticularFunLinksProfileState createState() =>
      _GetParticularFunLinksProfileState();
}

class _GetParticularFunLinksProfileState
    extends State<GetParticularFunLinksProfile> with TickerProviderStateMixin {
  // GetParticularUserProfileModel getParticularUserProfileModel;
  // OtherUserProfileFollowLinksModel otherUserProfileFollowLinksModel;

  GetParticularFunLinksProfileProvider? postMdl;

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Constants.playing = false;
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _initGoogleMobileAds();
    postMdl = Provider.of<GetParticularFunLinksProfileProvider>(context,
        listen: false);

    getMe();
    // getFunLinkFeed(widget.id!);
    postMdl!.controller = PageController(
        viewportFraction: 1, keepPage: true, initialPage: widget.index!);
    postMdl!.controllerMultipleImage =
        PageController(viewportFraction: 1, keepPage: true, initialPage: 0);
    postMdl!.smoothPageController =
        PageController(keepPage: true, initialPage: 0);
    Constants.playing = true;
    super.initState();
  }

  getMe() async {
    await postMdl!.getFollowLinkFeedData(context, widget.id!, widget.id!);
    postMdl!.changeIndex(int.parse(widget.index.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetParticularFunLinksProfileProvider>(
        builder: (context, provider, child) {
      return Scaffold(
        body: provider.getParticularFunUserProfileModelResultList! != null
            ? Stack(
                children: [
                  PinchZoom(
                    child: scrollFeed(),
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
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: ScreenUtil().setSp(32),
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
                                    ],
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
                                              // setState(() {
                                              // if(isLike == false){
                                              if (provider
                                                      .getParticularFunUserProfileModelResultList
                                                      .result![
                                                          provider.getIndex]
                                                      .likeStatus ==
                                                  2) {
                                                provider.likeFunLinks(
                                                    null, context);
                                              } else {
                                                provider.likeFunLinks(
                                                    2, context);
                                              }
                                              // }
                                              // });
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
                                                      .likesCount! >
                                                  0
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
                                      children: [
                                        Column(
                                          children: [
                                            Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
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
                                                      decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 3.0,
                                                              color: black
                                                                  .withOpacity(
                                                                      0.03),
                                                              offset: Offset(
                                                                  1.0, .0),
                                                            ),
                                                          ]),
                                                      child: SvgPicture.asset(
                                                          "assets/icons/svg/info.svg"),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      ScreenUtil().setWidth(8),
                                                ),
                                                Visibility(
                                                  visible: true,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 5.h),
                                                    child: Row(
                                                      children: [
                                                        InkWell(
                                                          child: ConstrainedBox(
                                                            constraints: BoxConstraints(
                                                                maxWidth:
                                                                    (ScreenUtil().screenWidth /
                                                                            2) -
                                                                        50),
                                                            child: Text(
                                                              (provider.getParticularFunUserProfileModelResultList.result![provider.getIndex].user !=
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
                                                                              .user!
                                                                              .username
                                                                              .toString() !=
                                                                          null)
                                                                  ? provider.getDetailShow !=
                                                                          true
                                                                      ? provider
                                                                          .getParticularFunUserProfileModelResultList
                                                                          .result![provider
                                                                              .getIndex]
                                                                          .user!
                                                                          .username
                                                                          .toString()
                                                                      : provider
                                                                          .getParticularFunUserProfileModelResultList
                                                                          .result![
                                                                              provider.getIndex]
                                                                          .description
                                                                          .toString()
                                                                  : "",
                                                              style: GoogleFonts
                                                                  .nunitoSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            16),
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
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      ScreenUtil().setWidth(8),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: ScreenUtil()
                                                      .setWidth(45)),
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

                                  Column(
                                    children: [
                                      provider
                                                  .getParticularFunUserProfileModelResultList
                                                  .result![provider.getIndex]
                                                  .musicName ==
                                              null
                                          ? Container()
                                          : Padding(
                                              padding:
                                                  EdgeInsets.only(left: 27.w),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/music.svg',
                                                    color: orange,
                                                  ),
                                                  SizedBox(width: 5.w),
                                                  Text(
                                                    provider
                                                        .getParticularFunUserProfileModelResultList
                                                        .result![
                                                            provider.getIndex]
                                                        .musicName
                                                        .toString(),
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: ScreenUtil()
                                                          .setSp(14),
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
                                                ],
                                              ),
                                            ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Comment
                                          InkWell(
                                            onTap: () async {
                                              postMdl!.commentPage = 1;
                                              postMdl!.commentType =
                                                  'famelinks';
                                              postMdl!.getCommentData(
                                                  'famelinks',
                                                  postMdl!
                                                      .getParticularFunUserProfileModelResultList
                                                      .result![
                                                          postMdl!.getIndex]
                                                      .sId!,
                                                  false,
                                                  context);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: ScreenUtil()
                                                      .setWidth(20)),
                                              decoration:
                                                  BoxDecoration(boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 3.0,
                                                  color:
                                                      black.withOpacity(0.03),
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
                                                      : showFamLinkShareDialog(
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
                                          Spacer(),
                                          InkWell(
                                            onTap: () {
                                              print("test");
                                              ChallengesModelData
                                                  challengesModelData =
                                                  ChallengesModelData(
                                                      id: "",
                                                      challengeId: provider
                                                          .getParticularFunUserProfileModelResultList!
                                                          .result![
                                                              provider.getIndex]
                                                          .challenges![0]
                                                          .sId!,
                                                      challengeName: provider
                                                          .getParticularFunUserProfileModelResultList!
                                                          .result![
                                                              provider.getIndex]
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
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 10.h),
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
                                                                .challenges![0]
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
                                          Spacer(),
                                          Spacer(),
                                          Spacer(),
                                        ],
                                      ),
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

  Widget scrollFeed() {
    return Consumer2<GetParticularFunLinksProfileProvider, FameLinkFun>(
        builder: (context, provider, fameLinkFun, child) {
      return RefreshIndicator(
        onRefresh: () {
          return fameLinkFun.getFunLinkFeed(widget.id!, isPaginate: false);
          // getParticularFunUserProfileModelResultList.clear();
        },
        child: provider.getParticularFunUserProfileModelResultList.result!
                    .length !=
                0
            ? PageView.builder(
                controller: postMdl!.controller,
                scrollDirection: Axis.vertical,
                itemCount: provider
                    .getParticularFunUserProfileModelResultList.result!.length,
                itemBuilder: (BuildContext context, int index) {
                  if (provider.getParticularFunUserProfileModelResultList
                          .result![index].media!.length ==
                      1) {
                    return SizedBox(
                      height: ScreenUtil().screenHeight,
                      width: ScreenUtil().screenWidth,
                      child: provider.getParticularFunUserProfileModelResultList
                                  .result![index].media![0].type ==
                              "video"
                          ? FeedVideoPlayer(
                              videoUrl:
                                  "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.getParticularFunUserProfileModelResultList.result![index].media![0].path}",
                            )
                          : provider.getParticularFunUserProfileModelResultList
                                      .result![index].media![0].type ==
                                  "ads"
                              ? Consumer<Nativeadsprovider>(
                                  builder: (context, nativeadsprovider, child) {
                                    return nativeadsprovider.nativeAdIsLoaded
                                        ? Container(
                                            // color: Colors.red,
                                            height: double.infinity,
                                            child: AdWidget(
                                                ad: nativeadsprovider
                                                    .nativeAd!),
                                          )
                                        : Container(
                                            child: Center(
                                              child: Text(
                                                "ads not loads",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          );
                                  },
                                )
                              : provider
                                      .getParticularFunUserProfileModelResultList
                                      .result![index]
                                      .media![0]
                                      .image ??
                                  Image.network(
                                    "${ApiProvider.s3UrlPath}/${provider.getParticularFunUserProfileModelResultList.result![index].media![0].path}",
                                    fit: BoxFit.fill,
                                  ),
                    );
                  } else
                  // if(particularFunLink.getParticularFunUserProfileModelResultList.result![index].media.length>0)
                  {
                    //count=particularFunLink.getParticularFunUserProfileModelResultList.result![index].media.length;
                    return PageView.builder(
                      itemCount: provider
                          .getParticularFunUserProfileModelResultList
                          .result![index]
                          .media!
                          .length,
                      controller: postMdl!.smoothPageController,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int i) {
                        return SizedBox(
                            height: ScreenUtil().screenHeight,
                            width: ScreenUtil().screenWidth,
                            child: provider
                                        .getParticularFunUserProfileModelResultList
                                        .result![index]
                                        .media![i]
                                        .type ==
                                    "video"
                                ? FeedVideoPlayer(
                                    videoUrl:
                                        "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.getParticularFunUserProfileModelResultList.result![index].media![i].path}",
                                  )
                                : provider
                                    .getParticularFunUserProfileModelResultList
                                    .result![index]
                                    .media![i]
                                    .image
                            //   : Image.network(
                            // "${ApiProvider.funPostImageBaseUrl}/${getParticularFunUserProfileModelResultList[index].media[i].path}",
                            // fit: BoxFit.fill,
                            // ),
                            );
                      },
                      onPageChanged: (value) {
                        setState(() {
                          if (provider
                                  .getParticularFunUserProfileModelResultList
                                  .result![index] !=
                              null) {
                            // for(int i = 0; i<=dataFameLink[index2].media.length; i++){
                            if (provider
                                    .getParticularFunUserProfileModelResultList
                                    .result![index]
                                    .media![value]
                                    .type ==
                                'video') {
                              Constants.playing = true;
                            } else {
                              Constants.playing = false;
                            }
                            // }
                          } else {
                            Constants.playing = false;
                          }
                          postMdl!.ind = value;
                        });
                      },
                    );
                  }
                },
                onPageChanged: (value) async {
                  debugPrint("On Page Changed ${value.toString()}");
                  provider.changeIndex(value);

                  if (provider.getParticularFunUserProfileModelResultList
                          .result![value + 3].media![0].type
                          .toString() ==
                      "ads") {
                    print("adscall");
                    final asdcall =
                        Provider.of<Nativeadsprovider>(context, listen: false);

                    asdcall
                        .initializeAd("ca-app-pub-3940256099942544/1044960115");
                  }

                  if (provider.getParticularFunUserProfileModelResultList
                          .result![value] !=
                      null) {
                    if (provider.getParticularFunUserProfileModelResultList
                            .result![value].media![0].type ==
                        'video') {
                      Constants.playing = true;
                    } else {
                      Constants.playing = false;
                    }
                  } else {
                    Constants.playing = false;
                  }
                  debugPrint("On Page Changed ${value.toString()}");
                  if (value ==
                      provider.getParticularFunUserProfileModelResultList
                              .result!.length -
                          1) {
                    await fameLinkFun.getFunLinkFeed(widget.id!,
                        isPaginate: true);
                  }
                },
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }

  void showFamLinkShareDialog(
      BuildContext context, String path, String type, int index) {
    final data = Provider.of<GetParticularFunLinksProfileProvider>(context,
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
                          Sharedynamic.shareprofile(data.sId.toString(),
                              "funlinkfeed", data.description.toString());
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
                          ShareFunction().onShare(path, type, index, context);
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

  @override
  void onPlayingChange(bool isPlaying) {
    // TODO: implement onPlayingChange
  }

  @override
  void onProfileClick() {
    // TODO: implement onProfileClick
  }
}
