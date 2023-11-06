import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:famelink/common/common_image.dart';
import 'package:famelink/databse/AppDatabase.dart';
import 'package:famelink/databse/db_provider.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/challenge/challenge_screen.dart';
import 'package:famelink/ui/followLinks/component/follow_link_feed.dart';
import 'package:famelink/ui/followLinks/component/report_dialogs.dart';
import 'package:famelink/ui/funlinks/FameLinksChallengeScreen.dart';
import 'package:famelink/ui/upload/followlink_upload.dart';
import 'package:famelink/ui/upload/upload_screen_one.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/config/image.dart';
import 'package:famelink/util/constants.dart';
import 'package:famelink/util/widgets/challenge_icon_widget.dart';
import 'package:famelink/util/widgets/follow_button.dart';
import 'package:famelink/util/widgets/info_icon.dart';
import 'package:famelink/util/widgets/notification_icon_widget.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../check_app_update.dart';
import '../../../common/routscontroll.dart';
import '../../../media_compression_provider.dart';
import '../../../share/firebasedynamiclink.dart';
import '../../../util/ReadMoreText.dart';
import '../../../util/registerDialog.dart';
import '../../../util/time_convert.dart';
import '../../Famelinkprofile/ProfileFameLink.dart';
import '../../otherUserProfile/OthersProfile.dart';
import '../../otherUserProfile/ui/loading.dart';
import '../component/followLinks_comment.dart';
import '../component/suggestion_view.dart';
import '../provider/FollowLinksFeedProvider.dart';

class FollowLinksUserProfile extends StatefulWidget {
  FollowLinksUserProfile({Key? key, this.id}) : super(key: key);
  final String? id;

  @override
  _FollowLinksUserProfileState createState() => _FollowLinksUserProfileState();
}

class _FollowLinksUserProfileState extends State<FollowLinksUserProfile>
    with TickerProviderStateMixin {
  final ApiProvider _api = ApiProvider();
  String name = 'Hello User';
  String defaultPath = '';
  bool visibilityTag = false;
  bool hideShowTag = true;
  bool isDarkMode = false;
  File? profileImageFile;
  int ind = 0;
  int tabpos = 0;
  bool isReferred = false;
  SharedPreferences? sharedPreferences;
  var dir;
  int mSelectedPosition = 0;
  bool agree = false;
  String link = "";
  int suggestionsPage = 1;
  int fameSubTab = 1;
  int followSubTab = 1;
  bool isVideo = false;
  String? followStatus;
  StreamController? postsController;
  FollowLinksFeedProvider? followLinksFeedProvider;

  @override
  void initState() {
    followLinksFeedProvider =
        Provider.of<FollowLinksFeedProvider>(context, listen: false);
    followLinksFeedProvider!.getFollowLinksProfileDetails();
    followLinksFeedProvider!.getFollowLinkFeedData();
    super.initState();

    if (widget.id != null) {
      followLinksFeedProvider!.deeplinkshare(widget.id.toString());
    } else {
      // followLinksFeedProvider!.getFollowlocal();
    }

    postsController = new StreamController();
    followLinksFeedProvider!.smoothPageController =
        PageController(keepPage: true, initialPage: 0);
    followLinksFeedProvider!.myController =
        PageController(keepPage: true, initialPage: 0);
    Provider.of<CheckAppUpdateProvider>(context, listen: false)
        .checkForUpdate();
    // TODO: implement initState
    setToken();
  }

  void setToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    Constants.token = sharedPreferences!.getString("token");
    Constants.userId = sharedPreferences!.getString("id");
    dir = await getApplicationDocumentsDirectory();
    print(Constants.token);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FollowLinksFeedProvider>(
        builder: (context, provider, child) {
      return provider.followLinkLoading == true
          ? Loading()
          : (provider.followLinkList.length != 0 &&
                  provider.followLinkList.isNotEmpty)
              ? Stack(
                  children: [
                    PinchZoom(
                      child: FollowLinksFeed(),
                      resetDuration: const Duration(milliseconds: 100),
                      maxScale: 2.5,
                      onZoomStart: () {
                        print('Start zooming');
                      },
                      onZoomEnd: () {
                        print('Stop zooming');
                      },
                    ),
                    provider.followLinkList[provider.getIndex] == null
                        ? Container()
                        : Stack(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("asfdsfdsf",
                                      style:
                                          TextStyle(color: Colors.transparent)),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Constants.isClicked == true
                                          ? Container()
                                          : Align(
                                              alignment: Alignment.topRight,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  top: ScreenUtil().setSp(91),
                                                  left: ScreenUtil().setSp(5),
                                                  right: 10.w,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      icon: SvgPicture.asset(
                                                          CommonImage.ic_more,
                                                          height: 40,
                                                          width: 40),
                                                      onPressed: () {
                                                        if (provider
                                                                .isRegistered ==
                                                            false) {
                                                          registerDialog(
                                                              context);
                                                        } else {
                                                          provider
                                                              .changeOnPageTurning(
                                                                  true);
                                                          provider
                                                              .changeOnPageHorizontalTurning(
                                                                  true);
                                                          showReportPostDialog(
                                                              context,
                                                              provider,
                                                              provider
                                                                  .followLinkList[
                                                                      provider
                                                                          .getIndex]
                                                                  .user!
                                                                  .id!,
                                                              provider
                                                                  .followLinkList[
                                                                      provider
                                                                          .index]
                                                                  .id!,
                                                              false);
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: provider
                                                            .followLinkList[
                                                                provider
                                                                    .getIndex]
                                                            .type ==
                                                        "famelinks"
                                                    ? 26.w
                                                    : 16.w),
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                bottom: Constants.isClicked ==
                                                            true &&
                                                        provider.getIsProfileUI ==
                                                            true
                                                    ? 200.h
                                                    : Constants.isClicked ==
                                                                true &&
                                                            provider.getIsProfileUI ==
                                                                false
                                                        ? 90.h
                                                        : Constants.isClicked ==
                                                                    false &&
                                                                provider.getIsProfileUI ==
                                                                    true
                                                            ? 270.h
                                                            : ScreenUtil()
                                                                .setHeight(135),
                                              ),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: provider
                                                                .followLinkList[
                                                                    provider
                                                                        .getIndex]
                                                                .type ==
                                                            "famelinks"
                                                        ? Colors.black
                                                        : Colors.transparent,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 1.0,
                                                      color: provider
                                                                  .followLinkList[
                                                                      provider
                                                                          .getIndex]
                                                                  .type ==
                                                              "famelinks"
                                                          ? black
                                                              .withOpacity(0.1)
                                                          : Colors.transparent,
                                                      offset: Offset(1.0, 1.0),
                                                    ),
                                                  ]),
                                              child: provider
                                                          .followLinkList[
                                                              provider.getIndex]
                                                          .type ==
                                                      "famelinks"
                                                  ? provider
                                                              .followLinkList[
                                                                  provider
                                                                      .getIndex]
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
                                                                        .followLinkList[
                                                                            provider.getIndex]
                                                                        .likeStatus ==
                                                                    2) {
                                                                  provider.likeHeart(
                                                                      context,
                                                                      provider
                                                                          .getIndex,
                                                                      null,
                                                                      2,
                                                                      provider
                                                                          .isRegistered!);
                                                                } else {
                                                                  provider.likeHeart(
                                                                      context,
                                                                      provider
                                                                          .getIndex,
                                                                      2,
                                                                      2,
                                                                      provider
                                                                          .isRegistered!);
                                                                }
                                                                //}
                                                              },
                                                              child: SvgPicture.asset(
                                                                  fullheart,
                                                                  color: provider
                                                                              .followLinkList[provider
                                                                                  .getIndex]
                                                                              .likeStatus ==
                                                                          2
                                                                      ? lightRed
                                                                      : Colors
                                                                          .white),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          2),
                                                            ),
                                                            Text(
                                                              provider.followLinkList[provider.getIndex]
                                                                          .likes2Count! >
                                                                      0
                                                                  ? "${provider.followLinkList[provider.getIndex].likes2Count}"
                                                                  : "",
                                                              style: GoogleFonts
                                                                  .nunitoSans(
                                                                      color: Colors
                                                                          .white,
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
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          ScreenUtil()
                                                                              .setSp(10)),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          7),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                if (provider
                                                                        .followLinkList[
                                                                            provider.getIndex]
                                                                        .likeStatus ==
                                                                    1) {
                                                                  provider.likeHeart(
                                                                      context,
                                                                      provider
                                                                          .getIndex,
                                                                      null,
                                                                      1,
                                                                      provider
                                                                          .isRegistered!);
                                                                } else {
                                                                  provider.likeHeart(
                                                                      context,
                                                                      provider
                                                                          .getIndex,
                                                                      1,
                                                                      1,
                                                                      provider
                                                                          .isRegistered!);
                                                                }
                                                              },
                                                              child: SvgPicture.asset(
                                                                  halfheart,
                                                                  color: provider
                                                                              .followLinkList[provider
                                                                                  .getIndex]
                                                                              .likeStatus ==
                                                                          1
                                                                      ? lightRed
                                                                      : Colors
                                                                          .white),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          2),
                                                            ),
                                                            Text(
                                                              provider.followLinkList[provider.getIndex]
                                                                          .likes1Count! >
                                                                      0
                                                                  ? "${provider.followLinkList[provider.getIndex].likes1Count}"
                                                                  : "",
                                                              style: GoogleFonts
                                                                  .nunitoSans(
                                                                      color: Colors
                                                                          .white,
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
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          ScreenUtil()
                                                                              .setSp(10)),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          7),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                if (provider
                                                                        .followLinkList[
                                                                            provider.getIndex]
                                                                        .likeStatus ==
                                                                    0) {
                                                                  provider.likeHeart(
                                                                      context,
                                                                      provider
                                                                          .getIndex,
                                                                      null,
                                                                      0,
                                                                      provider
                                                                          .isRegistered!);
                                                                } else {
                                                                  provider.likeHeart(
                                                                      context,
                                                                      provider
                                                                          .getIndex,
                                                                      0,
                                                                      0,
                                                                      provider
                                                                          .isRegistered!);
                                                                }
                                                                // }
                                                              },
                                                              child: SvgPicture.asset(
                                                                  emptyheart,
                                                                  color: provider
                                                                              .followLinkList[provider
                                                                                  .getIndex]
                                                                              .likeStatus ==
                                                                          0
                                                                      ? lightRed
                                                                      : Colors
                                                                          .white),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  ScreenUtil()
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
                                                              onTap: () {
                                                                if (provider
                                                                        .followLinkList[
                                                                            provider.getIndex]
                                                                        .likeStatus ==
                                                                    2) {
                                                                  provider.likeHeart(
                                                                      context,
                                                                      provider
                                                                          .getIndex,
                                                                      null,
                                                                      2,
                                                                      provider
                                                                          .isRegistered!);
                                                                } else {
                                                                  provider.likeHeart(
                                                                      context,
                                                                      provider
                                                                          .getIndex,
                                                                      2,
                                                                      2,
                                                                      provider
                                                                          .isRegistered!);
                                                                }
                                                                // }
                                                              },
                                                              child: SvgPicture.asset(
                                                                  fullheart,
                                                                  color: provider
                                                                              .followLinkList[provider
                                                                                  .getIndex]
                                                                              .likeStatus ==
                                                                          2
                                                                      ? lightRed
                                                                      : Colors
                                                                          .white),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          2),
                                                            ),
                                                            Text(
                                                              provider.followLinkList[provider.getIndex]
                                                                          .likes2Count! >
                                                                      0
                                                                  ? "${provider.followLinkList[provider.getIndex].likes2Count}"
                                                                  : "",
                                                              style: GoogleFonts
                                                                  .nunitoSans(
                                                                      color: Colors
                                                                          .white,
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
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          ScreenUtil()
                                                                              .setSp(10)),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          7),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                if (provider
                                                                        .followLinkList[
                                                                            provider.getIndex]
                                                                        .likeStatus ==
                                                                    1) {
                                                                  provider.likeHeart(
                                                                      context,
                                                                      provider
                                                                          .getIndex,
                                                                      null,
                                                                      1,
                                                                      provider
                                                                          .isRegistered!);
                                                                } else {
                                                                  provider.likeHeart(
                                                                      context,
                                                                      provider
                                                                          .getIndex,
                                                                      1,
                                                                      1,
                                                                      provider
                                                                          .isRegistered!);
                                                                }
                                                              },
                                                              child: SvgPicture.asset(
                                                                  halfheart,
                                                                  color: provider
                                                                              .followLinkList[provider
                                                                                  .getIndex]
                                                                              .likeStatus ==
                                                                          1
                                                                      ? lightRed
                                                                      : Colors
                                                                          .white),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          2),
                                                            ),
                                                            Text(
                                                              provider.followLinkList[provider.getIndex]
                                                                          .likes1Count! >
                                                                      0
                                                                  ? "${provider.followLinkList[provider.getIndex].likes1Count}"
                                                                  : "",
                                                              style: GoogleFonts
                                                                  .nunitoSans(
                                                                      color: Colors
                                                                          .white,
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
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          ScreenUtil()
                                                                              .setSp(10)),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          7),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                if (provider
                                                                        .followLinkList[
                                                                            provider.getIndex]
                                                                        .likeStatus ==
                                                                    0) {
                                                                  provider.likeHeart(
                                                                      context,
                                                                      provider
                                                                          .getIndex,
                                                                      null,
                                                                      0,
                                                                      provider
                                                                          .isRegistered!);
                                                                } else {
                                                                  provider.likeHeart(
                                                                      context,
                                                                      provider
                                                                          .getIndex,
                                                                      0,
                                                                      0,
                                                                      provider
                                                                          .isRegistered!);
                                                                }
                                                              },
                                                              child: SvgPicture.asset(
                                                                  emptyheart,
                                                                  color: provider
                                                                              .followLinkList[provider
                                                                                  .getIndex]
                                                                              .likeStatus ==
                                                                          0
                                                                      ? lightRed
                                                                      : Colors
                                                                          .white),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  ScreenUtil()
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
                                                        IconButton(
                                                            onPressed: () {
                                                              if (provider
                                                                      .isRegistered ==
                                                                  false) {
                                                                registerDialog(
                                                                    context);
                                                              } else {
                                                                if (provider
                                                                        .followLinkList[
                                                                            provider.getIndex]
                                                                        .likeStatus ==
                                                                    null) {
                                                                  provider.likeFunLinks(
                                                                      context,
                                                                      provider
                                                                          .getIndex,
                                                                      2,
                                                                      provider
                                                                          .followLinkList[
                                                                              provider.getIndex]
                                                                          .type!);
                                                                } else {
                                                                  provider.likeFunLinks(
                                                                      context,
                                                                      provider
                                                                          .getIndex,
                                                                      null,
                                                                      provider
                                                                          .followLinkList[
                                                                              provider.getIndex]
                                                                          .type!);
                                                                }
                                                              }
                                                            },
                                                            icon: Icon(
                                                                provider.followLinkList[provider.getIndex].likeStatus ==
                                                                        null
                                                                    ? Icons
                                                                        .favorite_border
                                                                    : Icons
                                                                        .favorite_sharp,
                                                                color: provider
                                                                            .followLinkList[provider
                                                                                .getIndex]
                                                                            .likeStatus ==
                                                                        null
                                                                    ? white
                                                                    : Colors
                                                                        .red)),
                                                        Text(
                                                          provider
                                                                      .followLinkList[
                                                                          provider
                                                                              .getIndex]
                                                                      .likesCount! >
                                                                  0
                                                              ? "${provider.followLinkList[provider.getIndex].likesCount}"
                                                              : "",
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              10)),
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ),
                                          const SizedBox(height: 31.0),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Constants.isClicked == true
                                  ? Container()
                                  : Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(40)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    provider
                                                        .changeOnPageTurning(
                                                            true);
                                                    provider
                                                        .changeOnPageHorizontalTurning(
                                                            true);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ChallengeScreen()));
                                                  },
                                                  child: ChallengeIconWidget(),
                                                ),
                                                isReferred == false
                                                    ? Container()
                                                    : InkWell(
                                                        onTap: () {
                                                          // onClickPageImage = !onClickPageImage;
                                                          showReferralCodeDialog(
                                                              context);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 14,
                                                                  top: 8),
                                                          child: Text(
                                                            'Referral\nCode',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      )
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: ScreenUtil().setSp(20),
                                                  left: ScreenUtil().setSp(5)),
                                              child:
                                                  provider
                                                              .followLinkList[
                                                                  provider
                                                                      .getIndex]
                                                              .media![0]
                                                              .type
                                                              .toString() ==
                                                          "ads"
                                                      ? Container()
                                                      : Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  gradient:
                                                                      Constants
                                                                          .glassGradient,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                          7.0,
                                                                      color: black
                                                                          .withOpacity(
                                                                              0.2),
                                                                      offset: Offset(
                                                                          2.0,
                                                                          2.0),
                                                                    ),
                                                                  ],
                                                                  border: Border.all(
                                                                      color:
                                                                          white,
                                                                      width: ScreenUtil()
                                                                          .setSp(
                                                                              1.5)),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              ScreenUtil().radius(6)))),
                                                          height: ScreenUtil()
                                                              .setSp(30),
                                                          width: ScreenUtil()
                                                              .setSp(30),
                                                          child: InkWell(
                                                            onTap: () async {
                                                              provider
                                                                  .changeOnPageTurning(
                                                                      true);
                                                              provider
                                                                  .changeOnPageHorizontalTurning(
                                                                      true);
                                                              if ((Constants.verificationStatus ==
                                                                          "Submitted" ||
                                                                      Constants
                                                                              .verificationStatus ==
                                                                          "Verified") &&
                                                                  Constants
                                                                          .todayPosts ==
                                                                      0) {
                                                                final result = await Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                UploadScreenOne()));
                                                                if (result !=
                                                                    null) {
                                                                  Map map =
                                                                      result;
                                                                  FormData
                                                                      formData =
                                                                      FormData
                                                                          .fromMap({
                                                                    "challengeId":
                                                                        map['challengeId'],
                                                                    "description":
                                                                        map['description'],
                                                                    "closeUp": map[
                                                                        'closeUp'],
                                                                    "medium": map[
                                                                        'medium'],
                                                                    "long": map[
                                                                        'long'],
                                                                    "pose1": map[
                                                                        'pose1'],
                                                                    "pose2": map[
                                                                        'pose2'],
                                                                    "additional":
                                                                        map['additional'],
                                                                  });
                                                                  if (map['video'] !=
                                                                      null) {
                                                                    var snackBar =
                                                                        SnackBar(
                                                                      content: Text(
                                                                          'Compressing'),
                                                                    );
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            snackBar);
                                                                    // final MediaInfo?
                                                                    //     info =
                                                                    //     await VideoCompress
                                                                    //         .compressVideo(
                                                                    //   map['video'],
                                                                    //   quality: VideoQuality
                                                                    //       .HighestQuality,
                                                                    //   deleteOrigin: false,
                                                                    //   includeAudio: true,
                                                                    // );

                                                                    MediaCompressionProvider().compressVideo(
                                                                        context,
                                                                        map['video'],
                                                                        onSave: (String?
                                                                            outputPath) async {
                                                                      await MultipartFile.fromFile(
                                                                              outputPath!,
                                                                              filename:
                                                                                  "${File(map['video']).path.split('/').last}")
                                                                          .then(
                                                                              (value) async {
                                                                        formData
                                                                            .files
                                                                            .addAll([
                                                                          MapEntry(
                                                                              "video",
                                                                              value),
                                                                        ]);
                                                                        Api.uploadPost.call(
                                                                            context,
                                                                            method:
                                                                                "media/contest",
                                                                            param:
                                                                                formData,
                                                                            onResponseSuccess:
                                                                                (Map object) {
                                                                          Constants.todayPosts =
                                                                              1;
                                                                          var snackBar =
                                                                              SnackBar(
                                                                            content:
                                                                                Text('Uploaded'),
                                                                          );
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(snackBar);
                                                                        });
                                                                      });
                                                                    });
                                                                  } else {
                                                                    Api.uploadPost.call(
                                                                        context,
                                                                        method:
                                                                            "media/contest",
                                                                        param:
                                                                            formData,
                                                                        onResponseSuccess:
                                                                            (Map
                                                                                object) {
                                                                      Constants
                                                                          .todayPosts = 1;
                                                                      var snackBar =
                                                                          SnackBar(
                                                                        content:
                                                                            Text('Uploaded'),
                                                                      );
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              snackBar);
                                                                    });
                                                                  }
                                                                }
                                                              } else {
                                                                provider
                                                                    .changeOnPageTurning(
                                                                        true);
                                                                provider
                                                                    .changeOnPageHorizontalTurning(
                                                                        true);

                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            FollowLinkUploadScreen(
                                                                              userProfile: true,
                                                                            ))).then(
                                                                    (value) async {
                                                                  print(
                                                                      "amarfollowpath $value");
                                                                  if (value !=
                                                                      null) {
                                                                    Map map =
                                                                        value;
                                                                    var result = await _api.uploadFollowLink(
                                                                        map['description'],
                                                                        map['challengeId'],
                                                                        map['image'],
                                                                        map['thumbnail'],
                                                                        map['context'],
                                                                        map['profile'],
                                                                        map['tags']);

                                                                    if (result ==
                                                                        1) {
                                                                      var snackBar =
                                                                          SnackBar(
                                                                        content:
                                                                            Text('Uploaded'),
                                                                      );
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              snackBar);
                                                                    }
                                                                  }
                                                                });
                                                                //showProfileVerifyDialog();
                                                              }
                                                            },
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.add,
                                                                color: lightRed,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              Constants.isClicked == false
                                  ? Container()
                                  : provider.followLinkList[
                                              provider.getIndex] ==
                                          null
                                      ? Container()
                                      : Align(
                                          alignment: Alignment.topLeft,
                                          child: Column(children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: ScreenUtil().setSp(45),
                                                right: ScreenUtil().setSp(10),
                                              ),
                                              child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: Image.asset(
                                                      'assets/images/watermark.png',
                                                      height: 70.h,
                                                      width: 120.w,
                                                    ),
                                                  )),
                                            ),
                                          ]),
                                        ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  provider.detailShow == true
                                      ? Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (provider.ids ==
                                                      provider
                                                          .followLinkList[
                                                              provider.getIndex]
                                                          .user!
                                                          .id) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProfileFameLink(
                                                                  selectPhase:
                                                                      2,
                                                                )));
                                                  } else {
                                                    Navigator.of(context).push(rauts()
                                                        .createRoute(OtherProfile(
                                                            id: provider
                                                                .followLinkList[
                                                                    provider
                                                                        .getIndex]
                                                                .user!
                                                                .id!,
                                                            selectPhase: 2)));
                                                  }
                                                },
                                                child: Container(
                                                  height: 45,
                                                  width: 45,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                        provider
                                                                    .followLinkList[
                                                                        provider
                                                                            .getIndex]
                                                                    .user!
                                                                    .profileImageType ==
                                                                'avatar'
                                                            ? "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.followLinkList[provider.getIndex].user!.profileImage}"
                                                            : "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.followLinkList[provider.getIndex].user!.profileImage}",
                                                      )),
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: white,
                                                        width: 1,
                                                      ),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color:
                                                              black.withOpacity(
                                                                  0.25),
                                                          offset: Offset(0, 4),
                                                          blurRadius: 4,
                                                        )
                                                      ]),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              InkWell(
                                                onTap: () {
                                                  if (provider.ids ==
                                                      provider
                                                          .followLinkList[
                                                              provider.getIndex]
                                                          .user!
                                                          .id) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProfileFameLink(
                                                                  selectPhase:
                                                                      2,
                                                                )));
                                                  } else {
                                                    Navigator.of(context).push(rauts()
                                                        .createRoute(OtherProfile(
                                                            id: provider
                                                                .followLinkList[
                                                                    provider
                                                                        .getIndex]
                                                                .user!
                                                                .id!,
                                                            selectPhase: 2)));
                                                  }
                                                },
                                                child: ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxWidth: (ScreenUtil()
                                                                  .screenWidth /
                                                              2) -
                                                          50),
                                                  child: Text(
                                                    (provider
                                                                    .followLinkList[
                                                                        provider
                                                                            .getIndex]
                                                                    .user !=
                                                                null &&
                                                            provider
                                                                .followLinkList[
                                                                    provider
                                                                        .getIndex]
                                                                .user
                                                                .toString()
                                                                .isNotEmpty &&
                                                            provider
                                                                .followLinkList[
                                                                    provider
                                                                        .getIndex]
                                                                .user
                                                                .toString()
                                                                .isNotEmpty &&
                                                            provider
                                                                    .followLinkList[
                                                                        provider
                                                                            .getIndex]
                                                                    .user!
                                                                    .username
                                                                    .toString() !=
                                                                null)
                                                        ? provider
                                                            .followLinkList[
                                                                provider
                                                                    .getIndex]
                                                            .user!
                                                            .name
                                                            .toString()
                                                        : "",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: ScreenUtil()
                                                          .setSp(24),
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
                                                ),
                                              ),
                                              SizedBox(width: 15),
                                              if (provider.detailShow == true)
                                                provider.ids ==
                                                        provider
                                                            .followLinkList[
                                                                provider
                                                                    .getIndex]
                                                            .user!
                                                            .id
                                                    ? Container()
                                                    : provider
                                                                .followLinkList[
                                                                    provider
                                                                        .getIndex]
                                                                .followStatus ==
                                                            "Follow"
                                                        ? FollowButton(
                                                            text: 'Follow',
                                                            onPressed: () {
                                                              provider.getFollowStatus(provider
                                                                  .followLinkList[
                                                                      provider
                                                                          .getIndex]
                                                                  .user!
                                                                  .id!);
                                                            },
                                                          )
                                                        : provider
                                                                    .followLinkList[
                                                                        provider
                                                                            .getIndex]
                                                                    .followStatus ==
                                                                'Following'
                                                            ? FollowButton(
                                                                text:
                                                                    'Following',
                                                                onPressed: () {
                                                                  provider.getUnFollowStatus(provider
                                                                      .followLinkList[
                                                                          provider
                                                                              .getIndex]
                                                                      .user!
                                                                      .id!);
                                                                },
                                                              )
                                                            : Container()
                                              else
                                                Container(),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, bottom: 12),
                                    child: Wrap(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: Constants.isClicked
                                                      ? 20.h
                                                      : 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
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
                                                            if (provider
                                                                    .detailShow ==
                                                                true) {
                                                              provider
                                                                  .changeChangeDetailsStatus(
                                                                      false);
                                                            } else {
                                                              provider
                                                                  .changeChangeDetailsStatus(
                                                                      true);
                                                            }
                                                          },
                                                          child: InfoIcon(),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: ScreenUtil()
                                                            .setWidth(8),
                                                      ),
                                                      Visibility(
                                                        visible: !visibilityTag,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 8.h),
                                                          child: Row(
                                                            children: [
                                                              provider.detailShow !=
                                                                      true
                                                                  ? InkWell(
                                                                      onTap:
                                                                          () {
                                                                        if (provider.ids ==
                                                                            provider.followLinkList[provider.getIndex].user!.id) {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => ProfileFameLink(
                                                                                        selectPhase: 2,
                                                                                      )));
                                                                        } else {
                                                                          Navigator.of(context).push(rauts().createRoute(OtherProfile(
                                                                              id: provider.followLinkList[provider.getIndex].user!.id!,
                                                                              selectPhase: 2)));
                                                                        }
                                                                      },
                                                                      child:
                                                                          ConstrainedBox(
                                                                        constraints:
                                                                            BoxConstraints(maxWidth: (ScreenUtil().screenWidth / 2) - 50),
                                                                        child:
                                                                            Text(
                                                                          "${provider.followLinkList[provider.getIndex].user!.username ?? ''}",
                                                                          style:
                                                                              GoogleFonts.nunitoSans(
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            fontSize:
                                                                                ScreenUtil().setSp(16),
                                                                            shadows: [
                                                                              Shadow(
                                                                                blurRadius: 7.0,
                                                                                color: black.withOpacity(0.6),
                                                                                offset: Offset(2.0, 2.0),
                                                                              ),
                                                                            ],
                                                                            color:
                                                                                white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Container(),
                                                              provider.detailShow ==
                                                                      true
                                                                  ? provider.followLinkList[provider.getIndex].description !=
                                                                              null &&
                                                                          provider.followLinkList[provider.getIndex].description !=
                                                                              ""
                                                                      ? Wrap(
                                                                          crossAxisAlignment:
                                                                              WrapCrossAlignment.start,
                                                                          children: [
                                                                              ConstrainedBox(
                                                                                constraints: BoxConstraints(maxWidth: (ScreenUtil().screenWidth / 1.4)),
                                                                                child: ReadMoreText(
                                                                                  "${provider.followLinkList[provider.getIndex].description} ${convertToAgo(provider.followLinkList[provider.getIndex].createdAt!)} ",
                                                                                  trimLines: 2,
                                                                                  trimMode: TrimMode.Line,
                                                                                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w400, fontSize: ScreenUtil().setSp(16), color: white, shadows: [
                                                                                    Shadow(
                                                                                      blurRadius: 7.0,
                                                                                      color: black.withOpacity(0.6),
                                                                                      offset: Offset(2.0, 2.0),
                                                                                    ),
                                                                                  ]),
                                                                                ),
                                                                              ),
                                                                            ])
                                                                      : Text(
                                                                          "${convertToAgo(provider.followLinkList[provider.getIndex].createdAt!)} ",
                                                                          style:
                                                                              GoogleFonts.nunitoSans(
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontSize:
                                                                                ScreenUtil().setSp(16),
                                                                            shadows: [
                                                                              Shadow(
                                                                                blurRadius: 7.0,
                                                                                color: black.withOpacity(0.6),
                                                                                offset: Offset(2.0, 2.0),
                                                                              ),
                                                                            ],
                                                                            color:
                                                                                white,
                                                                          ),
                                                                        )
                                                                  : Container(),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: visibilityTag,
                                                        child: Wrap(
                                                          crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          5),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: ScreenUtil()
                                                        .setWidth(8),
                                                  ),
                                                  provider.detailShow == true
                                                      ? Container()
                                                      : provider.ids ==
                                                              provider
                                                                  .followLinkList[
                                                                      provider
                                                                          .getIndex]
                                                                  .user!
                                                                  .id
                                                          ? Container()
                                                          : provider
                                                                      .followLinkList[
                                                                          provider
                                                                              .getIndex]
                                                                      .followStatus ==
                                                                  "Follow"
                                                              ? FollowButton(
                                                                  text:
                                                                      'Follow',
                                                                  onPressed:
                                                                      () {
                                                                    provider.getFollowStatus(provider
                                                                        .followLinkList[
                                                                            provider.getIndex]
                                                                        .user!
                                                                        .id!);
                                                                  },
                                                                )
                                                              : provider.followLinkList[provider.getIndex]
                                                                          .followStatus ==
                                                                      'Following'
                                                                  ? FollowButton(
                                                                      text:
                                                                          'Following',
                                                                      onPressed:
                                                                          () {
                                                                        provider.getUnFollowStatus(provider
                                                                            .followLinkList[provider.getIndex]
                                                                            .user!
                                                                            .id!);
                                                                      },
                                                                    )
                                                                  : Container()
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Visibility(
                                          visible: visibilityTag,
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: ScreenUtil().setWidth(5),
                                              ),
                                              SizedBox(
                                                width:
                                                    ScreenUtil().setWidth(10),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(8),
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
                                      InkWell(
                                        onTap: () async {
                                          if (provider.isRegistered == false) {
                                            registerDialog(context);
                                          } else {
                                            String newUserId = await Provider
                                                    .of<DatabaseProvider>(
                                                        context,
                                                        listen: false)
                                                .getUserId();
                                            if (provider
                                                    .followLinkList[
                                                        provider.getIndex]
                                                    .type ==
                                                "famelinks") {
                                              showModalBottomSheet(
                                                  context: context,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      20))),
                                                  builder:
                                                      (BuildContext context) {
                                                    return FollowLinksComment(
                                                      type: "famelinks",
                                                      postId: provider
                                                          .followLinkList[
                                                              provider.index]
                                                          .id!,
                                                      userId: provider
                                                          .followLinkList[
                                                              provider.index]
                                                          .user!
                                                          .id!,
                                                      newUserId: newUserId,
                                                    );
                                                  });
                                            } else if (provider
                                                    .followLinkList[
                                                        provider.getIndex]
                                                    .type ==
                                                "funlinks") {
                                              showModalBottomSheet(
                                                  context: context,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      20))),
                                                  builder:
                                                      (BuildContext context) {
                                                    return FollowLinksComment(
                                                      type: "funlinks",
                                                      postId: provider
                                                          .followLinkList[
                                                              provider.index]
                                                          .id!,
                                                      userId: provider
                                                          .followLinkList[
                                                              provider.index]
                                                          .user!
                                                          .id!,
                                                      newUserId: newUserId,
                                                    );
                                                  });
                                            } else if (provider
                                                    .followLinkList[
                                                        provider.getIndex]
                                                    .type ==
                                                "followlinks") {
                                              showModalBottomSheet(
                                                  context: context,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      20))),
                                                  builder:
                                                      (BuildContext context) {
                                                    return FollowLinksComment(
                                                      type: "followlinks",
                                                      postId: provider
                                                          .followLinkList[
                                                              provider.index]
                                                          .id!,
                                                      userId: provider
                                                          .followLinkList[
                                                              provider.index]
                                                          .user!
                                                          .id!,
                                                      newUserId: newUserId,
                                                    );
                                                  });
                                            }
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: ScreenUtil().setWidth(20)),
                                          child: SvgPicture.asset(
                                              "assets/icons/svg/comment.svg",
                                              color: white),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(5),
                                            bottom: ScreenUtil().setHeight(5)),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: SvgPicture.asset(
                                              "assets/icons/svg/share.svg",
                                              color: white),
                                          onPressed: () {
                                            if (provider.isRegistered ==
                                                false) {
                                              registerDialog(context);
                                            } else {
                                              provider
                                                  .changeOnPageTurning(true);
                                              provider
                                                  .changeOnPageHorizontalTurning(
                                                      true);
                                              // if (provider.getIndex >= 0) {
                                              //   provider
                                              //           .followLinkList[
                                              //               provider.getIndex]
                                              //           .media![ind]
                                              //           .path!
                                              //           .isEmpty
                                              //       ? null
                                              //       : showFollowLinkShareDialog(
                                              //           context,
                                              //           provider
                                              //               .followLinkList[
                                              //                   provider
                                              //                       .getIndex]
                                              //               .media![0]
                                              //               .path!,
                                              //           provider
                                              //               .followLinkList[
                                              //                   provider
                                              //                       .getIndex]
                                              //               .media![0]
                                              //               .type!,
                                              //           provider.getIndex,
                                              //           ind);
                                              // }

                                              Sharedynamic.shareprofile(
                                                  provider
                                                      .followLinkList[
                                                          provider.getIndex]
                                                      .id
                                                      .toString(),
                                                  "followlinkfeed",
                                                  provider
                                                      .followLinkList[
                                                          provider.getIndex]
                                                      .description
                                                      .toString());
                                            }
                                          },
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(23)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  150.w,
                                              child: Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    ChallengesModelData
                                                        challengesModelData =
                                                        ChallengesModelData(
                                                            id: "",
                                                            challengeId: provider
                                                                .followLinkList[
                                                                    provider
                                                                        .getIndex]
                                                                .challenges![0]
                                                                .id!,
                                                            challengeName: provider
                                                                .followLinkList[
                                                                    provider
                                                                        .getIndex]
                                                                .challenges![0]
                                                                .hashTag!,
                                                            postId: "");
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
                                                  child: provider
                                                              .followLinkList[
                                                                  provider
                                                                      .getIndex]
                                                              .challenges!
                                                              .length !=
                                                          0
                                                      ? Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              150.w,
                                                          child: Center(
                                                            child: Text(
                                                              (provider.followLinkList != null &&
                                                                      provider
                                                                          .followLinkList[provider
                                                                              .getIndex]
                                                                          .challenges![
                                                                              0]
                                                                          .hashTag!
                                                                          .isNotEmpty &&
                                                                      provider
                                                                              .followLinkList[provider
                                                                                  .getIndex]
                                                                              .challenges!
                                                                              .length !=
                                                                          0 &&
                                                                      provider.followLinkList[provider.getIndex].challenges![0].hashTag !=
                                                                          null &&
                                                                      provider
                                                                          .followLinkList[provider
                                                                              .getIndex]
                                                                          .challenges![
                                                                              0]
                                                                          .hashTag
                                                                          .toString()
                                                                          .isNotEmpty)
                                                                  ? "${provider.followLinkList[provider.getIndex].challenges![0].hashTag}"
                                                                  : "",
                                                              maxLines: 2,
                                                              style: GoogleFonts
                                                                  .nunitoSans(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Container(),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5.w),
                                            SmoothPageIndicator(
                                              controller: provider
                                                  .smoothPageController!,
                                              count: (provider
                                                  .followLinkList !=
                                                  null &&
                                                  provider
                                                      .followLinkList
                                                      .isNotEmpty &&
                                                  provider
                                                      .followLinkList[provider
                                                      .getIndex]
                                                      .media !=
                                                      null &&
                                                  provider
                                                      .followLinkList[
                                                  provider
                                                      .getIndex]
                                                      .media!
                                                      .isNotEmpty &&
                                                  provider
                                                      .followLinkList[provider
                                                      .getIndex]
                                                      .media!
                                                      .length !=
                                                      null)
                                                  ? provider
                                                  .followLinkList[provider
                                                  .getIndex]
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
                                                  paintStyle:
                                                      PaintingStyle.stroke,
                                                  strokeWidth: 1.5,
                                                  dotColor: Colors.white,
                                                  activeDotColor: lightRed),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      NotificationIconWidget(),
                                    ],
                                  ),
                                ],
                                //   ),
                                // ],
                              ),
                            ],
                          ),
                  ],
                )
              : SuggestionView(isRegistered: provider.isRegistered!);
    });
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/watermark.png');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  void _onShare(
      String mediapath, String mediatype, int index, String type) async {
    final postMdl =
        Provider.of<FollowLinksFeedProvider>(context, listen: false);

    if (mediatype == "video") {
      var dir = await getApplicationDocumentsDirectory();
      bool fileExists = await File(
              "${dir.path}/${postMdl.followLinkList[index].media != null ? postMdl.followLinkList[index].media![ind].path : defaultPath}")
          .exists();
      if (type == "famelinks") {
        if (fileExists) {
          Constants.progressDialog(true, context);
          File _watermarkImage =
              await getImageFileFromAssets('images/watermarkvideo.png');
          String _desFile = await _destinationFile;
          FFmpegKit.execute(
                  "-i ${File("${dir.path}/${postMdl.followLinkList[index].media != null ? postMdl.followLinkList[index].media![ind].path : defaultPath}").path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-75 -codec:a copy ${_desFile}")
              // "-i ${videoPath} -i ${_musicFile} -c copy -filter_complex [0:a]aformat = fltp:44100:stereo,apad[0a];[1] aformat=fltp:44100:stereo,volume=1.5[1a];[0a] [1a] amerge[a] -map 0:v -map [a] -ac 2 -y -shortest ${_desFile}")
              .then((return_code) async {
            Constants.progressDialog(false, context);
            Share.shareFiles(
              [_desFile],
              text:
                  '${ApiProvider.shareUrl}post/famelinks/${postMdl.followLinkList[index].id}',
            );
          });
        } else {
          Constants.progressDialog(true, context);
          Dio dio = Dio();
          unawaited(dio.download(
              "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${postMdl.followLinkList[index].media![ind].path}",
              "${dir.path}/${postMdl.followLinkList[index].media![ind].path}",
              onReceiveProgress: (rec, total) async {
            print("Rec: $rec , Total: $total");
            if (rec == total) {
              File _watermarkImage =
                  await getImageFileFromAssets('images/watermarkvideo.png');
              String _desFile = await _destinationFile;
              FFmpegKit.execute(
                      "-i ${File("${dir.path}/${postMdl.followLinkList != null ? postMdl.followLinkList[index].media![ind].path : defaultPath}").path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-75 -codec:a copy ${_desFile}")
                  // "-i ${videoPath} -i ${_musicFile} -c copy -filter_complex [0:a]aformat = fltp:44100:stereo,apad[0a];[1] aformat=fltp:44100:stereo,volume=1.5[1a];[0a] [1a] amerge[a] -map 0:v -map [a] -ac 2 -y -shortest ${_desFile}")
                  .then((return_code) async {
                Constants.progressDialog(false, context);
                Share.shareFiles(
                  [_desFile],
                  text:
                      '${ApiProvider.shareUrl}post/famelinks/${postMdl.followLinkList[index].id}',
                );
              });
            }
          }));
        }
      } else if (type == "funlinks") {
        if (fileExists) {
          Constants.progressDialog(true, context);
          File _watermarkImage =
              await getImageFileFromAssets('images/watermarkvideo.png');
          String _desFile = await _destinationFile;
          FFmpegKit.execute(
                  "-i ${File("${dir.path}/${postMdl.followLinkList[index].media != null ? postMdl.followLinkList[index].media![ind].path : defaultPath}").path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-75 -codec:a copy ${_desFile}")
              // "-i ${videoPath} -i ${_musicFile} -c copy -filter_complex [0:a]aformat = fltp:44100:stereo,apad[0a];[1] aformat=fltp:44100:stereo,volume=1.5[1a];[0a] [1a] amerge[a] -map 0:v -map [a] -ac 2 -y -shortest ${_desFile}")
              .then((return_code) async {
            Constants.progressDialog(false, context);
            Share.shareFiles(
              [_desFile],
              text:
                  '${ApiProvider.shareUrl}post/funlinks/${postMdl.followLinkList[index].id}',
            );
          });
        } else {
          Constants.progressDialog(true, context);
          Dio dio = Dio();
          unawaited(dio.download(
              "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${postMdl.followLinkList[index].media![ind].path}",
              "${dir.path}/${postMdl.followLinkList[index].media![ind].path}",
              onReceiveProgress: (rec, total) async {
            print("Rec: $rec , Total: $total");
            if (rec == total) {
              File _watermarkImage =
                  await getImageFileFromAssets('images/watermarkvideo.png');
              String _desFile = await _destinationFile;
              FFmpegKit.execute(
                      "-i ${File("${dir.path}/${postMdl.followLinkList != null ? postMdl.followLinkList[index].media![ind].path : defaultPath}").path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-75 -codec:a copy ${_desFile}")
                  // "-i ${videoPath} -i ${_musicFile} -c copy -filter_complex [0:a]aformat = fltp:44100:stereo,apad[0a];[1] aformat=fltp:44100:stereo,volume=1.5[1a];[0a] [1a] amerge[a] -map 0:v -map [a] -ac 2 -y -shortest ${_desFile}")
                  .then((return_code) async {
                Constants.progressDialog(false, context);
                Share.shareFiles(
                  [_desFile],
                  text:
                      '${ApiProvider.shareUrl}post/famelinks/${postMdl.followLinkList[index].id}',
                );
              });
            }
          }));
        }
      } else if (type == "followlinks") {
        if (fileExists) {
          Constants.progressDialog(true, context);
          File _watermarkImage =
              await getImageFileFromAssets('images/watermarkvideo.png');
          String _desFile = await _destinationFile;
          FFmpegKit.execute(
                  "-i ${File("${dir.path}/${postMdl.followLinkList[index].media != null ? postMdl.followLinkList[index].media![ind].path : defaultPath}").path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-75 -codec:a copy ${_desFile}")
              // "-i ${videoPath} -i ${_musicFile} -c copy -filter_complex [0:a]aformat = fltp:44100:stereo,apad[0a];[1] aformat=fltp:44100:stereo,volume=1.5[1a];[0a] [1a] amerge[a] -map 0:v -map [a] -ac 2 -y -shortest ${_desFile}")
              .then((return_code) async {
            Constants.progressDialog(false, context);
            Share.shareFiles(
              [_desFile],
              text:
                  '${ApiProvider.shareUrl}post/followlinks/${postMdl.followLinkList[index].id}',
            );
          });
        } else {
          Constants.progressDialog(true, context);
          Dio dio = Dio();
          unawaited(dio.download(
              "${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${postMdl.followLinkList[index].media![ind].path}",
              "${dir.path}/${postMdl.followLinkList[index].media![ind].path}",
              onReceiveProgress: (rec, total) async {
            print("Rec: $rec , Total: $total");
            if (rec == total) {
              File _watermarkImage =
                  await getImageFileFromAssets('images/watermarkvideo.png');
              String _desFile = await _destinationFile;
              FFmpegKit.execute(
                      "-i ${File("${dir.path}/${postMdl.followLinkList != null ? postMdl.followLinkList[index].media![ind].path : defaultPath}").path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-75 -codec:a copy ${_desFile}")
                  // "-i ${videoPath} -i ${_musicFile} -c copy -filter_complex [0:a]aformat = fltp:44100:stereo,apad[0a];[1] aformat=fltp:44100:stereo,volume=1.5[1a];[0a] [1a] amerge[a] -map 0:v -map [a] -ac 2 -y -shortest ${_desFile}")
                  .then((return_code) async {
                Constants.progressDialog(false, context);
                Share.shareFiles(
                  [_desFile],
                  text:
                      '${ApiProvider.shareUrl}post/famelinks/${postMdl.followLinkList[index].id}',
                );
              });
            }
          }));
        }
      }
    } else {
      if (type == "famelinks") {
        final Directory temp = await getTemporaryDirectory();
        final File imageFile = File('${temp.path}/tempImage.jpg');
        Dio dio = Dio();
        Constants.progressDialog(true, context);
        final response = await dio.download(
          '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${postMdl.followLinkList[index].media != null ? postMdl.followLinkList[index].media![ind].path : defaultPath}-xlg',
          imageFile.path,
          onReceiveProgress: (count, total) async {
            print("Rec: $count , Total: $total");
            if (count == total) {
              File _watermarkImage =
                  await getImageFileFromAssets('images/watermark.png');
              String _desFile = await _destinationImageFile;
              FFmpegKit.execute(
                      "-i ${imageFile.path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-150 ${_desFile}")
                  .then((return_code) async {
                Constants.progressDialog(false, context);
                Share.shareFiles(
                  [_desFile],
                  text:
                      '${ApiProvider.shareUrl}post/famelinks/${postMdl.followLinkList[index].id}',
                );
              });
            }
          },
        );
        print(response.data.toString());
      } else if (type == "funlinks") {
        final Directory temp = await getTemporaryDirectory();
        final File imageFile = File('${temp.path}/tempImage.jpg');
        Dio dio = Dio();
        Constants.progressDialog(true, context);
        final response = await dio.download(
          '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${postMdl.followLinkList[index].media != null ? postMdl.followLinkList[index].media![ind].path : defaultPath}-xlg',
          imageFile.path,
          onReceiveProgress: (count, total) async {
            print("Rec: $count , Total: $total");
            if (count == total) {
              File _watermarkImage =
                  await getImageFileFromAssets('images/watermark.png');
              String _desFile = await _destinationImageFile;
              FFmpegKit.execute(
                      "-i ${imageFile.path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-150 ${_desFile}")
                  .then((return_code) async {
                Constants.progressDialog(false, context);
                Share.shareFiles(
                  [_desFile],
                  text:
                      '${ApiProvider.shareUrl}post/funlinks/${postMdl.followLinkList[index].id}',
                );
              });
            }
          },
        );
        print(response.data.toString());
      } else if (type == "followlinks") {
        final Directory temp = await getTemporaryDirectory();
        final File imageFile = File('${temp.path}/tempImage.jpg');
        Dio dio = Dio();
        Constants.progressDialog(true, context);
        final response = await dio.download(
          '${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${postMdl.followLinkList[index].media != null ? postMdl.followLinkList[index].media![ind].path : defaultPath}-xlg',
          imageFile.path,
          onReceiveProgress: (count, total) async {
            print("Rec: $count , Total: $total");
            if (count == total) {
              File _watermarkImage =
                  await getImageFileFromAssets('images/watermark.png');
              String _desFile = await _destinationImageFile;
              FFmpegKit.execute(
                      "-i ${imageFile.path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-150 ${_desFile}")
                  .then((return_code) async {
                Constants.progressDialog(false, context);
                Share.shareFiles(
                  [_desFile],
                  text:
                      '${ApiProvider.shareUrl}post/followlinks/${postMdl.followLinkList[index].id}',
                );
              });
            }
          },
        );
        print(response.data.toString());
      }
    }
  }

  Future<String> get _destinationFile async {
    String directory;
    final String videoName = '${DateTime.now().millisecondsSinceEpoch}.mp4';
    if (Platform.isAndroid) {
      // Handle this part the way you want to save it in any directory you wish.
      final List<Directory>? dir =
          await getExternalStorageDirectories(type: StorageDirectory.movies);
      directory = dir!.first.path;
      return File('$directory/$videoName').path;
    } else {
      final Directory dir = await getLibraryDirectory();
      directory = dir.path;
      return File('$directory/$videoName').path;
    }
  }

  Future<String> get _destinationImageFile async {
    String directory;
    final String videoName = '${DateTime.now().millisecondsSinceEpoch}.png';
    if (Platform.isAndroid) {
      // Handle this part the way you want to save it in any directory you wish.
      final List<Directory>? dir =
          await getExternalStorageDirectories(type: StorageDirectory.pictures);
      directory = dir!.first.path;
      return File('$directory/$videoName').path;
    } else {
      final Directory dir = await getLibraryDirectory();
      directory = dir.path;
      return File('$directory/$videoName').path;
    }
  }
}
