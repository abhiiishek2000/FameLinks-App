import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:famelink/common/common_image.dart';
import 'package:famelink/databse/AppDatabase.dart';
import 'package:famelink/databse/db_provider.dart';
import 'package:famelink/databse/models/FollowFeedPostModel.dart';
import 'package:famelink/databse/models/FunlinksFeedPostModel.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/funlinks/FunLinksChallengeScreen.dart';
import 'package:famelink/ui/funlinks/component/comment_view.dart';
import 'package:famelink/ui/funlinks/provider/FunLinksFeedProvider.dart';
import 'package:famelink/ui/latest_profile/ProfileFunLinksModel.dart';
import 'package:famelink/ui/upload/funlink_upload_one.dart';
import 'package:famelink/ui/upload/upload_screen_one.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:famelink/util/widgets/follow_button.dart';
import 'package:famelink/util/widgets/info_icon.dart';
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

import '../../../check_app_update.dart';
import '../../../common/routscontroll.dart';
import '../../../media_compression_provider.dart';
import '../../../share/firebasedynamiclink.dart';
import '../../../util/ReadMoreText.dart';
import '../../../util/registerDialog.dart';
import '../../../util/time_convert.dart';
import '../../../util/widgets/notification_icon_widget.dart';
import '../../Famelinkprofile/ProfileFameLink.dart';
import '../../otherUserProfile/OthersProfile.dart';
import '../../otherUserProfile/ui/loading.dart';
import '../component/funlinks_feeds.dart';
import '../component/report_dialogs.dart';

class FunLinksUserProfile extends StatefulWidget {
  FunLinksUserProfile({Key? key, this.id}) : super(key: key);
  final String? id;
  @override
  _FunLinksUserProfileState createState() => _FunLinksUserProfileState();
}

class _FunLinksUserProfileState extends State<FunLinksUserProfile>
    with TickerProviderStateMixin {
  final ApiProvider _api = ApiProvider();
  String defaultPath = '';
  bool visibilityTag = false;
  bool isReferred = false;
  int ind = 0;
  SharedPreferences? sharedPreferences;
  var dir;
  PageController? pageController;
  int mSelectedPosition = 0;
  PageController? followPageController;
  String? profileFunLinksImage;
  String? followStatus;
  List<ProfileFunLinksModelResult> profileFunLinksList =
      <ProfileFunLinksModelResult>[];
  FunLinksFeedProvider? funLinksFeedProvider;

  void fameScrollListener() {
    if (Provider.of<FunLinksFeedProvider>(context, listen: false)
            .getIsOnPageTurning &&
        pageController!.page == pageController!.page!.roundToDouble()) {
      Provider.of<FunLinksFeedProvider>(context, listen: false)
          .changeCurrent(pageController!.page!.toInt());
      Provider.of<FunLinksFeedProvider>(context, listen: false)
          .changeOnPageTurning(false);
    } else if (!Provider.of<FunLinksFeedProvider>(context, listen: false)
            .getIsOnPageTurning &&
        Provider.of<FunLinksFeedProvider>(context, listen: false)
                .getCurrent
                .toDouble() !=
            pageController!.page) {
      if ((Provider.of<FunLinksFeedProvider>(context, listen: false)
                      .getCurrent
                      .toDouble() -
                  pageController!.page!)
              .abs() >
          0.1) {
        Provider.of<FunLinksFeedProvider>(context, listen: false)
            .changeOnPageTurning(true);
      }
    }
    print(
        "CURRENT_POS:::${Provider.of<FunLinksFeedProvider>(context, listen: false).getCurrent}");
  }

  getMe() async {
    final postMdl = Provider.of<FunLinksFeedProvider>(context, listen: false);
    await postMdl.getFunLinkFeedData();
  }

  @override
  void initState() {
    funLinksFeedProvider =
        Provider.of<FunLinksFeedProvider>(context, listen: false);
    funLinksFeedProvider!.getFunLinksProfileDetails();
    funLinksFeedProvider!.getFunLinkFeedData();
    if (widget.id != null) {
      funLinksFeedProvider!.deeplinkshare(widget.id.toString());
    } else {
      //   funLinksFeedProvider!.getFundata();
    }

    super.initState();
    Provider.of<CheckAppUpdateProvider>(context, listen: false)
        .checkForUpdate();
    _postsController = new StreamController();
    funLinksFeedProvider!.smoothPageController =
        PageController(keepPage: true, initialPage: 0);
    funLinksFeedProvider!.myController =
        PageController(keepPage: true, initialPage: 0);
    followPageController = PageController(keepPage: true, initialPage: 0);
    pageController = PageController(
        initialPage: mSelectedPosition, keepPage: true, viewportFraction: 1);
    pageController!.addListener(fameScrollListener);
    setToken();
  }

  void setToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    Constants.token = sharedPreferences!.getString("token");
    Constants.userId = sharedPreferences!.getString("id");
    dir = await getApplicationDocumentsDirectory();
    print(Constants.token);
  }

  Key key = UniqueKey();

  StreamController? _postsController;

  @override
  Widget build(BuildContext context) {
    return Consumer<FunLinksFeedProvider>(builder: (context, provider, child) {
      return provider.funLinkLoading == true
          ? Loading()
          : StreamBuilder(builder: (buildContext, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Container(
                  color: Colors.black,
                );
              }
              if (!snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return Text('No Posts');
              }
              return ((provider.funLinksList.length != 0 &&
                      provider.funLinksList.isNotEmpty))
                  ? Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            provider.changeIsProfileUI(false);
                          },
                          child: PinchZoom(
                            child: FunLinksFeed(),
                            resetDuration: const Duration(milliseconds: 100),
                            maxScale: 2.5,
                            onZoomStart: () {
                              debugPrint('Start zooming');
                            },
                            onZoomEnd: () {
                              debugPrint('Stop zooming');
                            },
                          ),
                        ),
                        provider.funLinksList[provider.index] == null
                            ? Container()
                            : provider.funLinksList[provider.index].media![0]
                                        .type
                                        .toString() ==
                                    "ads"
                                ? Container()
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("asfdsfdsf",
                                          style: TextStyle(
                                              color: Colors.transparent)),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Constants.isClicked == true
                                              ? Container()
                                              : Align(
                                                  alignment: Alignment.topRight,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: ScreenUtil()
                                                            .setSp(91),
                                                        left: ScreenUtil()
                                                            .setSp(5),
                                                        right: 10.w),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        IconButton(
                                                          icon:
                                                              SvgPicture.asset(
                                                                  CommonImage
                                                                      .ic_more,
                                                                  height: 40,
                                                                  width: 40),
                                                          onPressed: () {
                                                            if (provider
                                                                    .isRegistered ==
                                                                false) {
                                                              provider
                                                                  .changeOnPageTurning(
                                                                      true);
                                                              provider
                                                                  .changeOnPageHorizontalTurning(
                                                                      true);
                                                              registerDialog(
                                                                  context);
                                                            } else {
                                                              provider
                                                                  .changeOnPageTurning(
                                                                      true);
                                                              provider
                                                                  .changeOnPageHorizontalTurning(
                                                                      true);

                                                              showReportPostDialogFunLink(
                                                                  context,
                                                                  provider,
                                                                  provider
                                                                      .funLinksList[
                                                                          provider
                                                                              .index]
                                                                      .user!
                                                                      .id!,
                                                                  provider
                                                                      .funLinksList[
                                                                          provider
                                                                              .index]
                                                                      .id!,
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
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
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
                                                              ? 260.h
                                                              : ScreenUtil()
                                                                  .setHeight(
                                                                      135),
                                                  right:
                                                      ScreenUtil().setWidth(16),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () async {
                                                          if (provider
                                                                  .isRegistered ==
                                                              false) {
                                                            registerDialog(
                                                                context);
                                                          } else {
                                                            // if(isLike == false){
                                                            if (provider
                                                                    .funLinksList[
                                                                        provider
                                                                            .index]
                                                                    .likeStatus ==
                                                                2) {
                                                              await provider
                                                                  .likeFunLinks(
                                                                      null,
                                                                      context);
                                                            } else {
                                                              await provider
                                                                  .likeFunLinks(
                                                                      2,
                                                                      context);
                                                            }
                                                            // }
                                                          }
                                                        },
                                                        icon: Icon(
                                                            provider
                                                                        .funLinksList[provider
                                                                            .index]
                                                                        .likeStatus ==
                                                                    null
                                                                ? Icons
                                                                    .favorite_border
                                                                : Icons
                                                                    .favorite_sharp,
                                                            color: provider
                                                                        .funLinksList[
                                                                            provider.index]
                                                                        .likeStatus ==
                                                                    null
                                                                ? white
                                                                : Colors.red)),
                                                    Text(
                                                      provider
                                                                  .funLinksList[
                                                                      provider
                                                                          .index]
                                                                  .likesCount! >
                                                              0
                                                          ? "${provider.funLinksList[provider.index].likesCount}"
                                                          : "",
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                              color:
                                                                  Colors.white,
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
                                              const SizedBox(height: 31.0),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                        Constants.isClicked == true
                            ? Container()
                            : provider.funLinksList[provider.index] == null
                                ? Container()
                                : isReferred == false
                                    ? Container()
                                    : provider.funLinksList[provider.index]
                                                .media![0].type
                                                .toString() ==
                                            "ads"
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                top: 38, left: 14),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    //onClickPageImage = !onClickPageImage;
                                                    showReferralCodeDialog(
                                                        context);
                                                  },
                                                  child: Text(
                                                    'Referral\nCode',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                        Constants.isClicked == true
                            ? Container()
                            : provider.funLinksList[provider.index] == null
                                ? Container()
                                : Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: ScreenUtil().setHeight(40)),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: ScreenUtil().setSp(20),
                                              left: ScreenUtil().setSp(5)),
                                          child: provider
                                                      .funLinksList[
                                                          provider.getIndex]
                                                      .media![0]
                                                      .type
                                                      .toString() ==
                                                  "ads"
                                              ? Container()
                                              : Container(
                                                  decoration: BoxDecoration(
                                                      gradient: Constants
                                                          .glassGradient,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 7.0,
                                                          color: black
                                                              .withOpacity(0.2),
                                                          offset:
                                                              Offset(2.0, 2.0),
                                                        ),
                                                      ],
                                                      border: Border.all(
                                                          color: white,
                                                          width: ScreenUtil()
                                                              .setSp(1.5)),
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(
                                                              ScreenUtil()
                                                                  .radius(6)))),
                                                  height:
                                                      ScreenUtil().setSp(30),
                                                  width: ScreenUtil().setSp(30),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      if (provider
                                                              .isRegistered ==
                                                          false) {
                                                        registerDialog(context);
                                                      } else {
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
                                                          if (result != null) {
                                                            Map map = result;
                                                            FormData formData =
                                                                FormData
                                                                    .fromMap({
                                                              "challengeId": map[
                                                                  'challengeId'],
                                                              "description": map[
                                                                  'description'],
                                                              "closeUp": map[
                                                                  'closeUp'],
                                                              "medium":
                                                                  map['medium'],
                                                              "long":
                                                                  map['long'],
                                                              "pose1":
                                                                  map['pose1'],
                                                              "pose2":
                                                                  map['pose2'],
                                                              "additional": map[
                                                                  'additional'],
                                                            });
                                                            if (map['video'] !=
                                                                null) {
                                                              var snackBar =
                                                                  SnackBar(
                                                                content: Text(
                                                                    'Compressing'),
                                                              );
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      snackBar);
                                                              // final MediaInfo? info =
                                                              //     await VideoCompress
                                                              //         .compressVideo(
                                                              //   map['video'],
                                                              //   quality: VideoQuality
                                                              //       .HighestQuality,
                                                              //   deleteOrigin: false,
                                                              //   includeAudio: true,
                                                              // );
                                                              MediaCompressionProvider()
                                                                  .compressVideo(
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
                                                                  formData.files
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
                                                                          (Map
                                                                              object) {
                                                                    Constants
                                                                        .todayPosts = 1;
                                                                    var snackBar =
                                                                        SnackBar(
                                                                      content: Text(
                                                                          'Uploaded'),
                                                                    );
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            snackBar);
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
                                                                  content: Text(
                                                                      'Uploaded'),
                                                                );
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        snackBar);
                                                              });
                                                            }
                                                          }
                                                        } else {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      FunLinkUploadScreenOne(
                                                                          // userProfile: true,
                                                                          ))).then(
                                                              (value) async {
                                                            setState(() {
                                                              Constants
                                                                      .playing =
                                                                  true;
                                                            });
                                                            if (value != null) {
                                                              Map? map = value;
                                                              var result =
                                                                  await _api
                                                                      .uploadFunLink(
                                                                map![
                                                                    'description'],
                                                                map['challengeId'],
                                                                map['song'],
                                                                map['musicName'],
                                                                map['video'],
                                                                map['audio'],
                                                                map['thumbnail'],
                                                                map['context'],
                                                                map['profile'],
                                                                map['tags'],
                                                                map['talentCategory'],
                                                              );

                                                              if (result == 1) {
                                                                var snackBar =
                                                                    SnackBar(
                                                                  content: Text(
                                                                      'Uploaded'),
                                                                );
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        snackBar);
                                                              }
                                                            }
                                                          });
                                                          // showProfileVerifyDialog();
                                                        }
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
                                      ),
                                    ),
                                  ),
                        Constants.isClicked == false
                            ? Container()
                            : provider.funLinksList[provider.index] == null
                                ? Container()
                                : Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: ScreenUtil().setSp(45),
                                        right: ScreenUtil().setSp(10),
                                      ),
                                      child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Image.asset(
                                              'assets/images/watermark.png',
                                              height: 70.h,
                                              width: 120.w,
                                            ),
                                          )),
                                    ),
                                  ),
                        provider.funLinksList[provider.index] == null
                            ? Container()
                            : provider.funLinksList[provider.index].media![0]
                                        .type
                                        .toString() ==
                                    "ads"
                                ? Container()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      provider.detailShow == true
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(14.0),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      if (provider.ids ==
                                                          provider
                                                              .funLinksList[
                                                                  provider
                                                                      .index]
                                                              .user!
                                                              .id) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ProfileFameLink(
                                                                          selectPhase:
                                                                              1,
                                                                        )));
                                                      } else {
                                                        Navigator.of(context).push(
                                                            rauts().createRoute(
                                                                OtherProfile(
                                                                    id: provider
                                                                        .funLinksList[provider
                                                                            .getIndex]
                                                                        .user!
                                                                        .id!,
                                                                    selectPhase:
                                                                        1)));
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 45,
                                                      width: 45,
                                                      decoration: BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                                  image:
                                                                      NetworkImage(
                                                            provider
                                                                        .funLinksList[
                                                                            provider.index]
                                                                        .user!
                                                                        .profileImageType ==
                                                                    'avatar'
                                                                ? "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.funLinksList[provider.index].user!.profileImage}"
                                                                : "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.funLinksList[provider.index].user!.profileImage}",
                                                          )),
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: white,
                                                            width: 1,
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: black
                                                                  .withOpacity(
                                                                      0.25),
                                                              offset:
                                                                  Offset(0, 4),
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
                                                              .funLinksList[
                                                                  provider
                                                                      .index]
                                                              .user!
                                                              .id) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ProfileFameLink(
                                                                          selectPhase:
                                                                              1,
                                                                        )));
                                                      } else {
                                                        Navigator.of(context).push(
                                                            rauts().createRoute(
                                                                OtherProfile(
                                                                    id: provider
                                                                        .funLinksList[provider
                                                                            .getIndex]
                                                                        .user!
                                                                        .id!,
                                                                    selectPhase:
                                                                        1)));
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
                                                                        .funLinksList[provider
                                                                            .index]
                                                                        .user !=
                                                                    null &&
                                                                provider
                                                                    .funLinksList[
                                                                        provider
                                                                            .index]
                                                                    .user
                                                                    .toString()
                                                                    .isNotEmpty &&
                                                                provider
                                                                    .funLinksList[
                                                                        provider
                                                                            .index]
                                                                    .user
                                                                    .toString()
                                                                    .isNotEmpty &&
                                                                provider
                                                                        .funLinksList[provider
                                                                            .index]
                                                                        .user!
                                                                        .username
                                                                        .toString() !=
                                                                    null)
                                                            ? provider
                                                                .funLinksList[
                                                                    provider
                                                                        .index]
                                                                .user!
                                                                .name
                                                                .toString()
                                                            : "",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: ScreenUtil()
                                                              .setSp(24),
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
                                                  SizedBox(width: 15),
                                                  if (provider.detailShow ==
                                                      true)
                                                    provider.ids ==
                                                            provider
                                                                .funLinksList[
                                                                    provider
                                                                        .index]
                                                                .user!
                                                                .id!
                                                        ? Container()
                                                        : provider
                                                                    .funLinksList[
                                                                        provider
                                                                            .getIndex]
                                                                    .followStatus ==
                                                                "Follow"
                                                            ? FollowButton(
                                                                text: 'Follow',
                                                                onPressed: () {
                                                                  provider.getFollowStatus(provider
                                                                      .funLinksList[
                                                                          provider
                                                                              .getIndex]
                                                                      .user!
                                                                      .id!);
                                                                },
                                                              )
                                                            : provider
                                                                        .funLinksList[
                                                                            provider.getIndex]
                                                                        .followStatus ==
                                                                    'Following'
                                                                ? FollowButton(
                                                                    text:
                                                                        'Following',
                                                                    onPressed:
                                                                        () {
                                                                      provider.getUnFollowStatus(provider
                                                                          .funLinksList[
                                                                              provider.getIndex]
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
                                      Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: Constants.isClicked
                                                        ? 32.h
                                                        : 0.0),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left: ScreenUtil()
                                                            .setWidth(22),
                                                        top: 5.h,
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
                                                      width: 10,
                                                    ),
                                                    provider.detailShow != true
                                                        ? InkWell(
                                                            onTap: () {
                                                              if (provider
                                                                      .ids ==
                                                                  provider
                                                                      .funLinksList[
                                                                          provider
                                                                              .index]
                                                                      .user!
                                                                      .id) {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            ProfileFameLink(
                                                                              selectPhase: 1,
                                                                            )));
                                                              } else {
                                                                Navigator.of(context).push(rauts().createRoute(OtherProfile(
                                                                    id: provider
                                                                        .funLinksList[provider
                                                                            .getIndex]
                                                                        .user!
                                                                        .id!,
                                                                    selectPhase:
                                                                        1)));
                                                              }
                                                            },
                                                            child:
                                                                ConstrainedBox(
                                                              constraints:
                                                                  BoxConstraints(
                                                                      maxWidth:
                                                                          (ScreenUtil().screenWidth / 2) -
                                                                              50),
                                                              child: Text(
                                                                "${provider.funLinksList[provider.index].user!.username ?? ''}",
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: GoogleFonts
                                                                    .nunitoSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
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
                                                                      offset: Offset(
                                                                          2.0,
                                                                          2.0),
                                                                    ),
                                                                  ],
                                                                  color: white,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                    provider.detailShow == true
                                                        ? provider
                                                                        .funLinksList[provider
                                                                            .index]
                                                                        .description !=
                                                                    null &&
                                                                provider
                                                                        .funLinksList[provider
                                                                            .index]
                                                                        .description !=
                                                                    ""
                                                            ? Wrap(
                                                                crossAxisAlignment:
                                                                    WrapCrossAlignment
                                                                        .start,
                                                                children: [
                                                                    ConstrainedBox(
                                                                      constraints:
                                                                          BoxConstraints(
                                                                              maxWidth: (ScreenUtil().screenWidth / 1.4)),
                                                                      child:
                                                                          ReadMoreText(
                                                                        "${provider.funLinksList[provider.index].description} ${convertToAgo(DateTime.parse('${'${provider.funLinksList[provider.index].createdAt}'}'))} ",
                                                                        trimLines:
                                                                            2,
                                                                        trimMode:
                                                                            TrimMode.Line,
                                                                        style: GoogleFonts.nunitoSans(
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontSize: ScreenUtil().setSp(16),
                                                                            color: white,
                                                                            shadows: [
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
                                                                "${convertToAgo(DateTime.parse('${'${provider.funLinksList[provider.index].createdAt}'}'))} ",
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
                                                                      offset: Offset(
                                                                          2.0,
                                                                          2.0),
                                                                    ),
                                                                  ],
                                                                  color: white,
                                                                ),
                                                              )
                                                        : Container(),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    provider.detailShow == false
                                                        ? provider.ids ==
                                                                provider
                                                                    .funLinksList[
                                                                        provider
                                                                            .index]
                                                                    .user!
                                                                    .id
                                                            ? Container()
                                                            : provider
                                                                        .funLinksList[provider
                                                                            .getIndex]
                                                                        .followStatus ==
                                                                    "Follow"
                                                                ? FollowButton(
                                                                    text:
                                                                        'Follow',
                                                                    onPressed:
                                                                        () {
                                                                      provider.getFollowStatus(provider
                                                                          .funLinksList[
                                                                              provider.getIndex]
                                                                          .user!
                                                                          .id!);
                                                                    },
                                                                  )
                                                                : provider.funLinksList[provider.getIndex]
                                                                            .followStatus ==
                                                                        'Following'
                                                                    ? FollowButton(
                                                                        text:
                                                                            'Following',
                                                                        onPressed:
                                                                            () {
                                                                          provider.getUnFollowStatus(provider
                                                                              .funLinksList[provider.getIndex]
                                                                              .user!
                                                                              .id!);
                                                                        },
                                                                      )
                                                                    : Container()
                                                        : Container(),
                                                  ],
                                                ),
                                              ),
                                              provider
                                                              .funLinksList[
                                                                  provider
                                                                      .index]
                                                              .tags ==
                                                          null ||
                                                      provider
                                                              .funLinksList[
                                                                  provider
                                                                      .index]
                                                              .tags!
                                                              .length ==
                                                          0
                                                  ? Container()
                                                  : Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left: ScreenUtil()
                                                                  .setWidth(
                                                                      30)),
                                                          child: InfoIcon(),
                                                        ),
                                                        Text(
                                                          provider
                                                              .funLinksList[
                                                                  provider
                                                                      .index]
                                                              .tags
                                                              .toString()
                                                              .replaceAll(
                                                                  '[]', ''),
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(12),
                                                            color: white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                              provider
                                                          .funLinksList[
                                                              provider.index]
                                                          .musicName ==
                                                      ''
                                                  ? Container()
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 27.w),
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                            'assets/images/music.svg',
                                                            color: orange,
                                                          ),
                                                          SizedBox(width: 5.w),
                                                          Text(
                                                            provider
                                                                .funLinksList[
                                                                    provider
                                                                        .index]
                                                                .musicName!,
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          14),
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
                                                        ],
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: ScreenUtil().setWidth(8),
                                          ),
                                          Visibility(
                                            visible: visibilityTag,
                                            child: Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      ScreenUtil().setWidth(5),
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
                                      const SizedBox(height: 8.0),
                                      //ModernMixMetroMast
                                      Constants.isClicked == true
                                          ? Container()
                                          : Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        if (provider
                                                                .isRegistered ==
                                                            false) {
                                                          registerDialog(
                                                              context);
                                                        } else {
                                                          String newUserId =
                                                              await Provider.of<
                                                                          DatabaseProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .getUserId();

                                                          showModalBottomSheet(
                                                              context: context,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.vertical(
                                                                          top: Radius.circular(
                                                                              20))),
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                Constants
                                                                    .progressDialog(
                                                                        false,
                                                                        context);
                                                                return CommentView(
                                                                  type:
                                                                      "funlinks",
                                                                  postId: provider
                                                                      .funLinksList[
                                                                          provider
                                                                              .index]
                                                                      .id!,
                                                                  userId: provider
                                                                      .funLinksList[
                                                                          provider
                                                                              .index]
                                                                      .user!
                                                                      .id!,
                                                                  newUserId:
                                                                      newUserId,
                                                                );
                                                              });
                                                        }
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            left: ScreenUtil()
                                                                .setWidth(20),
                                                            top: 5.h),
                                                        child: SvgPicture.asset(
                                                            "assets/icons/svg/comment.svg",
                                                            color: white),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: ScreenUtil()
                                                              .setWidth(5),
                                                          bottom: ScreenUtil()
                                                              .setHeight(5)),
                                                      child: IconButton(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        icon: SvgPicture.asset(
                                                            "assets/icons/svg/share.svg",
                                                            color: white),
                                                        onPressed: () {
                                                          if (provider
                                                                  .isRegistered ==
                                                              false) {
                                                            registerDialog(
                                                                context);
                                                          } else {
                                                            Constants
                                                                .progressDialog(
                                                                    true,
                                                                    context);
                                                            Provider.of<FunLinksFeedProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changeOnPageTurning(
                                                                    true);
                                                            Provider.of<FunLinksFeedProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changeOnPageHorizontalTurning(
                                                                    true);
                                                            if (provider
                                                                    .index >=
                                                                0) {
                                                              Sharedynamic.shareprofile(
                                                                  provider
                                                                      .funLinksList[
                                                                          provider
                                                                              .getIndex]
                                                                      .id
                                                                      .toString(),
                                                                  "funlinkfeed",
                                                                  provider
                                                                      .funLinksList[
                                                                          provider
                                                                              .getIndex]
                                                                      .description
                                                                      .toString());
                                                              // provider
                                                              //         .funLinksList[
                                                              //             provider
                                                              //                 .index]
                                                              //         .media![
                                                              //             ind]
                                                              //         .path!
                                                              //         .isEmpty
                                                              //     ? null
                                                              //     : showFamLinkShareDialog(
                                                              //         context,
                                                              //         provider
                                                              //             .funLinksList[provider
                                                              //                 .index]
                                                              //             .media![
                                                              //                 0]
                                                              //             .path!,
                                                              //         provider
                                                              //             .funLinksList[provider
                                                              //                 .index]
                                                              //             .media![
                                                              //                 0]
                                                              //             .type!,
                                                              //         provider
                                                              //             .index,
                                                              //         ind);
                                                            }
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Center(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 6.h),
                                                        child: InkWell(
                                                          onTap: () {
                                                            ChallengesModelData challengesModelData = ChallengesModelData(
                                                                id: "",
                                                                challengeId: provider
                                                                    .funLinksList[
                                                                        provider
                                                                            .index]
                                                                    .challenges![
                                                                        0]
                                                                    .id!,
                                                                challengeName: provider
                                                                    .funLinksList[
                                                                        provider
                                                                            .index]
                                                                    .challenges![
                                                                        0]
                                                                    .hashTag!,
                                                                postId: "");

                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => FunLinksChallengeScreen(
                                                                      challengesModelData,
                                                                      provider.funLinksList[provider.index].musicName ==
                                                                              ''
                                                                          ? ''
                                                                          : provider
                                                                              .funLinksList[provider.index]
                                                                              .musicName
                                                                              .toString(),
                                                                      "")),
                                                            );
                                                          },
                                                          child: Text(
                                                            (provider
                                                                            .funLinksList[provider
                                                                                .index]
                                                                            .challenges !=
                                                                        null &&
                                                                    provider
                                                                        .funLinksList[provider
                                                                            .index]
                                                                        .challenges!
                                                                        .isNotEmpty &&
                                                                    provider
                                                                            .funLinksList[provider
                                                                                .index]
                                                                            .challenges!
                                                                            .length !=
                                                                        0 &&
                                                                    provider
                                                                            .funLinksList[provider
                                                                                .index]
                                                                            .challenges![
                                                                                0]
                                                                            .hashTag !=
                                                                        null &&
                                                                    provider
                                                                        .funLinksList[provider
                                                                            .index]
                                                                        .challenges![
                                                                            0]
                                                                        .hashTag
                                                                        .toString()
                                                                        .isNotEmpty)
                                                                ? "${provider.funLinksList[provider.index].challenges![0].hashTag.toString()}"
                                                                : "",
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                              shadows: <Shadow>[
                                                                Shadow(
                                                                  offset:
                                                                      Offset(
                                                                          0.0,
                                                                          2.0),
                                                                  blurRadius:
                                                                      2.0,
                                                                  color: Color(
                                                                          0xff000000)
                                                                      .withOpacity(
                                                                          0.25),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      child: SvgPicture.asset(
                                                          "assets/icons/svg/share.svg",
                                                          color: Colors
                                                              .transparent),
                                                    ),
                                                    NotificationIconWidget(),
                                                  ],
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                      ],
                    )
                  : Center(
                      child: Container(
                        color: Colors.black,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
            });
    });
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/watermark.png');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
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

  void _onFollowLinkShare(FollowFeedPostModel data) async {
    if (data.mediaList[ind].mediaType == "video") {
      var dir = await getApplicationDocumentsDirectory();
      bool fileExists = await File(
              "${dir.path}/${data.mediaList != null ? data.mediaList[ind].mediaPath : defaultPath}")
          .exists();
      if (fileExists) {
        Constants.progressDialog(true, context);
        File _watermarkImage =
            await getImageFileFromAssets('images/watermarkvideo.png');
        String _desFile = await _destinationFile;
        FFmpegKit.execute(
                "-i ${File("${dir.path}/${data.mediaList != null ? data.mediaList[ind].mediaPath : defaultPath}").path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-75 -codec:a copy $_desFile")
            // "-i ${videoPath} -i ${_musicFile} -c copy -filter_complex [0:a]aformat = fltp:44100:stereo,apad[0a];[1] aformat=fltp:44100:stereo,volume=1.5[1a];[0a] [1a] amerge[a] -map 0:v -map [a] -ac 2 -y -shortest ${_desFile}")
            .then((return_code) async {
          Constants.progressDialog(false, context);
          Share.shareFiles(
            [_desFile],
            text:
                '${ApiProvider.shareUrl}post/${data.postModel.type}/${data.postModel.postId}',
          );
        });
      } else {
        Constants.progressDialog(true, context);
        Dio dio = Dio();
        unawaited(dio.download(
            "${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${data.mediaList[ind].mediaPath}",
            "${dir.path}/${data.mediaList[ind].mediaPath}",
            onReceiveProgress: (rec, total) async {
          print("Rec: $rec , Total: $total");
          if (rec == total) {
            File _watermarkImage =
                await getImageFileFromAssets('images/watermarkvideo.png');
            String _desFile = await _destinationFile;
            FFmpegKit.execute(
                    "-i ${File("${dir.path}/${data.mediaList != null ? data.mediaList[ind].mediaPath : defaultPath}").path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-75 -codec:a copy $_desFile")
                // "-i ${videoPath} -i ${_musicFile} -c copy -filter_complex [0:a]aformat = fltp:44100:stereo,apad[0a];[1] aformat=fltp:44100:stereo,volume=1.5[1a];[0a] [1a] amerge[a] -map 0:v -map [a] -ac 2 -y -shortest ${_desFile}")
                .then((return_code) async {
              Constants.progressDialog(false, context);
              Share.shareFiles(
                [_desFile],
                text:
                    '${ApiProvider.shareUrl}post/${data.postModel.type}/${data.postModel.postId}',
              );
            });
          }
        }));
      }
    } else {
      final Directory temp = await getTemporaryDirectory();
      final File imageFile = File('${temp.path}/tempImage.jpg');
      Dio dio = Dio();
      Constants.progressDialog(true, context);
      final response = await dio.download(
        '${data.postModel.type == "funlinks" ? "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}" : data.postModel.type == "followlinks" ? "${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}" : "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}"}/${data.mediaList != null ? data.mediaList[ind].mediaPath : defaultPath}-xlg',
        imageFile.path,
        onReceiveProgress: (count, total) async {
          print("Rec: $count , Total: $total");
          if (count == total) {
            File _watermarkImage =
                await getImageFileFromAssets('images/watermark.png');
            String _desFile = await _destinationImageFile;
            FFmpegKit.execute(
                    "-i ${imageFile.path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-150 $_desFile")
                .then((return_code) async {
              Constants.progressDialog(false, context);
              Share.shareFiles(
                [_desFile],
                text:
                    '${ApiProvider.shareUrl}post/${data.postModel.type}/${data.postModel.postId}',
              );
            });
          }
        },
      );
      print(response.data.toString());
    }
  }

  void _onFunLinkShare(FunlinksFeedPostModel data) async {
    var dir = await getApplicationDocumentsDirectory();
    bool fileExists = await File(
            "${dir.path}/${data.mediaList != null ? data.mediaList.elementAt(0).mediaPath : defaultPath}")
        .exists();
    if (fileExists) {
      Constants.progressDialog(true, context);
      File _watermarkImage =
          await getImageFileFromAssets('images/watermarkvideo.png');
      String _desFile = await _destinationFile;
      FFmpegKit.execute(
              "-i ${File("${dir.path}/${data.mediaList != null ? data.mediaList[ind].mediaPath : defaultPath}").path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-75 -c:a copy $_desFile")
          // "-i ${videoPath} -i ${_musicFile} -c copy -filter_complex [0:a]aformat = fltp:44100:stereo,apad[0a];[1] aformat=fltp:44100:stereo,volume=1.5[1a];[0a] [1a] amerge[a] -map 0:v -map [a] -ac 2 -y -shortest ${_desFile}")
          .then((return_code) async {
        Constants.progressDialog(false, context);
        Share.shareFiles(
          [_desFile],
          text: '${ApiProvider.shareUrl}post/funlinks/${data.postModel.postId}',
        );
      });
    } else {
      Constants.progressDialog(true, context);
      Dio dio = Dio();
      unawaited(dio.download(
          "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${data.mediaList[ind].mediaPath}",
          "${dir.path}/${data.mediaList[ind].mediaPath}",
          onReceiveProgress: (rec, total) async {
        print("Rec: $rec , Total: $total");
        if (rec == total) {
          File _watermarkImage =
              await getImageFileFromAssets('images/watermarkvideo.png');
          String _desFile = await _destinationFile;
          FFmpegKit.execute(
                  "-i ${File("${dir.path}/${data.mediaList != null ? data.mediaList[ind].mediaPath : defaultPath}").path} -i ${_watermarkImage.path} -filter_complex overlay=20:20 -codec:a copy $_desFile")
              // "-i ${videoPath} -i ${_musicFile} -c copy -filter_complex [0:a]aformat = fltp:44100:stereo,apad[0a];[1] aformat=fltp:44100:stereo,volume=1.5[1a];[0a] [1a] amerge[a] -map 0:v -map [a] -ac 2 -y -shortest ${_desFile}")
              .then((return_code) async {
            Constants.progressDialog(false, context);
            Share.shareFiles(
              [_desFile],
              text:
                  '${ApiProvider.shareUrl}post/funlinks/${data.postModel.postId}',
            );
          });
        }
      }));
    }
  }
}
