import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:famelink/check_app_update.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/LocationResponse.dart';
import 'package:famelink/models/Profile_Model.dart';
import 'package:famelink/models/userUpdateResponse.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/challenge/challenge_screen.dart';
import 'package:famelink/ui/fameLinks/provider/FameLinksFeedProvider.dart';
import 'package:famelink/ui/latest_profile/ProfileFameLinksModel.dart';
import 'package:famelink/ui/settings/WebViewScreenUrl.dart';
import 'package:famelink/ui/settings/profile_verification_screen.dart';
import 'package:famelink/ui/upload/brand_upload_screen_one.dart';
import 'package:famelink/ui/upload/upload_screen_one.dart';
import 'package:famelink/util/ReadMoreText.dart';
import 'package:famelink/util/Validator.dart';
import 'package:famelink/util/appStrings.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_compress/video_compress.dart';

import '../../../common/routscontroll.dart';
import '../../../databse/AppDatabase.dart';
import '../../../databse/db_provider.dart';
import '../../../share/firebasedynamiclink.dart';
import '../../../share/sharefile.dart';
import '../../../util/custom_snack_bar.dart';
import '../../../util/registerDialog.dart';
import '../../../util/time_convert.dart';
import '../../../util/widgets/challenge_icon_widget.dart';
import '../../../util/widgets/follow_button.dart';
import '../../../util/widgets/info_icon.dart';
import '../../../util/widgets/notification_icon_widget.dart';
import '../../Famelinkprofile/ProfileFameLink.dart';
import '../../funlinks/FameLinksChallengeScreen.dart';
import '../../otherUserProfile/OthersProfile.dart';
import '../../otherUserProfile/ui/loading.dart';
import '../component/comment_view.dart';
import '../component/feedView.dart';
import '../component/feed_liker_button.dart';

class FameLinksFeed extends StatefulWidget {
  FameLinksFeed({Key? key, this.id}) : super(key: key);
  final String? id;
  @override
  _FameLinksFeedState createState() => _FameLinksFeedState();
}

class _FameLinksFeedState extends State<FameLinksFeed>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _referralKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _profileKey = GlobalKey<FormState>();
  final ApiProvider _api = ApiProvider();
  String name = 'Hello User';
  TextEditingController nameController = TextEditingController();
  TextEditingController refferalCodeController = TextEditingController();
  String ageGroup = 'groupE';
  String type = 'individual';

  late Animation<Offset> animation;
  late AnimationController animacon;

  bool visibilityTag = false;
  bool isReferred = false;
  File? profileImageFile;
  ProfileResponse? myInfoResponse;
  int ind = 0;
  AddressLocation? locationModel;
  SharedPreferences? sharedPreferences;
  var dir;
  int mSelectedPosition = 0;
  String link = "";
  List mySuggestionsResult = [];
  int suggestionsPage = 1;
  List<ProfileFameLinksModelResult> profileFameLinksList =
      <ProfileFameLinksModelResult>[];
  FameLinksFeedProvider? fameLinksFeedProvider;

  void fameScrollListener() {
    if (fameLinksFeedProvider!.getIsOnPageTurning &&
        fameLinksFeedProvider!.pageController!.page ==
            fameLinksFeedProvider!.pageController!.page!.roundToDouble()) {
      fameLinksFeedProvider!
          .changeCurrent(fameLinksFeedProvider!.pageController!.page!.toInt());
      fameLinksFeedProvider!.changeOnPageTurning(false);
    } else if (!fameLinksFeedProvider!.getIsOnPageTurning &&
        fameLinksFeedProvider!.getCurrent.toDouble() !=
            fameLinksFeedProvider!.pageController!.page) {
      if ((fameLinksFeedProvider!.getCurrent.toDouble() -
                  fameLinksFeedProvider!.pageController!.page!)
              .abs() >
          0.1) {
        fameLinksFeedProvider!.changeOnPageTurning(true);
      }
    }
    print("CURRENT_POS:::${fameLinksFeedProvider!.getCurrent}");
  }

  @override
  void initState() {
    fameLinksFeedProvider =
        Provider.of<FameLinksFeedProvider>(context, listen: false);
    
    fameLinksFeedProvider!.getFameLinksProfileDetails();
    fameLinksFeedProvider!.getFameLinkFeedData();

    animacon =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween(begin: Offset(-2.0, 0.0), end: Offset(0.0, 0.0))
        .animate(animacon.view);

    animacon.addListener(() {
      print(animation.value);
    });

    super.initState();
    _postsController = new StreamController();
    fameLinksFeedProvider!.smoothPageController =
        PageController(keepPage: true, initialPage: 0);
    fameLinksFeedProvider!.myController =
        PageController(keepPage: true, initialPage: 0);
    if (widget.id != null) {
      fameLinksFeedProvider!.deeplinkshare(widget.id.toString());
    } else {
      // fameLinksFeedProvider!.getFamlink();
    }
    Provider.of<CheckAppUpdateProvider>(context, listen: false)
        .checkForUpdate();
    fameLinksFeedProvider!.pageController = PageController(
        initialPage: mSelectedPosition, keepPage: true, viewportFraction: 1);
    fameLinksFeedProvider!.pageController!.addListener(fameScrollListener);
    fameLinksFeedProvider!.followLinksPageController = PageController(
        initialPage: mSelectedPosition, keepPage: true, viewportFraction: 1);
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
    return Consumer<FameLinksFeedProvider>(builder: (context, provider, child) {
      print("indexcheck  ${provider.getIndex}");

      return provider.loading
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

              if ((provider.feedList.length != 0 &&
                  provider.feedList.isNotEmpty)) {
                return provider.getIsProfileUI != true
                    ? Stack(
                        children: [
                          PinchZoom(
                            child: FeedView(),
                            resetDuration: const Duration(milliseconds: 100),
                            maxScale: 2.5,
                            onZoomStart: () {
                              print('Start zooming');
                            },
                            onZoomEnd: () {
                              print('Stop zooming');
                            },
                          ),
                          //TODO: First Liker Button Widget
                          provider.feedList[provider.getIndex] == null
                              ? Container()
                              : provider.feedList[provider.getIndex].media![0]
                                          .type
                                          .toString() ==
                                      "ads"
                                  ? Container()
                                  : FameLinkFeedLikerButton(
                                      isRegistered: provider.isRegistered!),
                          provider.feedList[provider.getIndex] == null
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
                                                        showReferralCodeDialog();
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
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                            ]),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: ScreenUtil().setSp(20),
                                              left: ScreenUtil().setSp(5)),
                                          child: provider
                                                      .feedList[
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
                                                      } else if (Constants
                                                              .userType ==
                                                          'brand') {
                                                        final result =
                                                            await Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            BrandUploadScreenOne()));
                                                        if (result != null) {
                                                          Map map = result;
                                                          FormData formData =
                                                              FormData.fromMap({
                                                            "name": map['name'],
                                                            "price":
                                                                map['price'],
                                                            "description": map[
                                                                'description'],
                                                            "purchaseUrl": map[
                                                                'purchaseUrl'],
                                                            "buttonName": map[
                                                                'buttonName'],
                                                            "tags": map['tags'],
                                                          });
                                                          if (map['closeUp'] !=
                                                              null) {
                                                            formData.files
                                                                .addAll([
                                                              MapEntry(
                                                                  "media",
                                                                  await map[
                                                                      'closeUp']),
                                                            ]);
                                                          }
                                                          if (map['medium'] !=
                                                              null) {
                                                            formData.files
                                                                .addAll([
                                                              MapEntry(
                                                                  "media",
                                                                  await map[
                                                                      'medium']),
                                                            ]);
                                                          }
                                                          if (map['long'] !=
                                                              null) {
                                                            formData.files
                                                                .addAll([
                                                              MapEntry(
                                                                  "media",
                                                                  await map[
                                                                      'long']),
                                                            ]);
                                                          }
                                                          if (map['pose1'] !=
                                                              null) {
                                                            formData.files
                                                                .addAll([
                                                              MapEntry(
                                                                  "media",
                                                                  await map[
                                                                      'pose1']),
                                                            ]);
                                                          }
                                                          if (map['pose2'] !=
                                                              null) {
                                                            formData.files
                                                                .addAll([
                                                              MapEntry(
                                                                  "media",
                                                                  await map[
                                                                      'pose2']),
                                                            ]);
                                                          }
                                                          if (map['additional'] !=
                                                              null) {
                                                            formData.files
                                                                .addAll([
                                                              MapEntry(
                                                                  "media",
                                                                  await map[
                                                                      'additional']),
                                                            ]);
                                                          }
                                                          if (map['video'] !=
                                                              null) {
                                                            var snackBar =
                                                                SnackBar(
                                                              content: Text(
                                                                  'Compressing'),
                                                            );
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    snackBar);
                                                            final MediaInfo?
                                                                info =
                                                                await VideoCompress
                                                                    .compressVideo(
                                                              map['video'],
                                                              quality: VideoQuality
                                                                  .HighestQuality,
                                                              deleteOrigin:
                                                                  false,
                                                              includeAudio:
                                                                  true,
                                                            );
                                                            await MultipartFile
                                                                    .fromFile(
                                                                        info!
                                                                            .path!,
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
                                                            });
                                                          }
                                                          Api.uploadPost.call(
                                                              context,
                                                              method:
                                                                  "users/brand/upload",
                                                              param: formData,
                                                              onResponseSuccess:
                                                                  (Map object) {
                                                            Constants
                                                                .todayPosts = 1;
                                                            var snackBar =
                                                                SnackBar(
                                                              content: Text(
                                                                  'Uploaded'),
                                                            );
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    snackBar);
                                                          });
                                                        }
// }
                                                      } else {
                                                        final result =
                                                            await Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            UploadScreenOne()));
                                                        if (result != null) {
                                                          Map map = result;
                                                          print(map);
                                                          FormData formData =
                                                              FormData.fromMap({
                                                            "challengeId":
                                                                jsonEncode(map[
                                                                    'challengeId']),
                                                            "description":
                                                                map['description'] ??
                                                                    '',
                                                          });
                                                          print(
                                                              'Challenges Id =>${map['challengeId']}');
                                                          if (map['closeUp'] !=
                                                                  null &&
                                                              map['closeUp']
                                                                      .path !=
                                                                  '') {
                                                            print(map['closeUp']
                                                                .path!);
                                                            await MultipartFile.fromFile(
                                                                    map['closeUp']
                                                                        .path!,
                                                                    filename:
                                                                        "${map['closeUp'].path.split('/').last}")
                                                                .then(
                                                                    (value) async {
                                                              formData.files
                                                                  .add(
                                                                MapEntry(
                                                                    "closeUp",
                                                                    value),
                                                              );
                                                            });
                                                          }
                                                          if (map['medium'] !=
                                                                  null &&
                                                              map['medium']
                                                                      .path !=
                                                                  '') {
                                                            await MultipartFile.fromFile(
                                                                    map['medium']
                                                                        .path!,
                                                                    filename:
                                                                        "${map['medium'].path.split('/').last}")
                                                                .then(
                                                                    (value) async {
                                                              formData.files
                                                                  .add(
                                                                MapEntry(
                                                                    "medium",
                                                                    value),
                                                              );
                                                            });
                                                          }
                                                          if (map['long'] !=
                                                                  null &&
                                                              map['long']
                                                                      .path !=
                                                                  '') {
                                                            await MultipartFile.fromFile(
                                                                    map['long']
                                                                        .path!,
                                                                    filename:
                                                                        "${map['long'].path.split('/').last}")
                                                                .then(
                                                                    (value) async {
                                                              formData.files
                                                                  .add(
                                                                MapEntry("long",
                                                                    value),
                                                              );
                                                            });
                                                          }
                                                          if (map['pose1'] !=
                                                                  null &&
                                                              map['pose1']
                                                                      .path !=
                                                                  '') {
                                                            await MultipartFile.fromFile(
                                                                    map['pose1']
                                                                        .path!,
                                                                    filename:
                                                                        "${map['pose1'].path.split('/').last}")
                                                                .then(
                                                                    (value) async {
                                                              formData.files
                                                                  .add(
                                                                MapEntry(
                                                                    "pose1",
                                                                    value),
                                                              );
                                                            });
                                                          }
                                                          if (map['pose2'] !=
                                                                  null &&
                                                              map['pose2']
                                                                      .path !=
                                                                  '') {
                                                            await MultipartFile.fromFile(
                                                                    map['pose2']
                                                                        .path!,
                                                                    filename:
                                                                        "${map['pose2'].path.split('/').last}")
                                                                .then(
                                                                    (value) async {
                                                              formData.files
                                                                  .add(
                                                                MapEntry(
                                                                    "pose2",
                                                                    value),
                                                              );
                                                            });
                                                          }
                                                          if (map['additional'] !=
                                                                  null &&
                                                              map['additional']
                                                                      .path !=
                                                                  '') {
                                                            await MultipartFile.fromFile(
                                                                    map['additional']
                                                                        .path!,
                                                                    filename:
                                                                        "${map['additional'].path.split('/').last}")
                                                                .then(
                                                                    (value) async {
                                                              formData.files
                                                                  .add(
                                                                MapEntry(
                                                                    "additional",
                                                                    value),
                                                              );
                                                            });
                                                          }
                                                          if (map['video'] !=
                                                                  null &&
                                                              map['video']
                                                                      .path !=
                                                                  '') {
                                                            await MultipartFile.fromFile(
                                                                    map['video']
                                                                        .path!,
                                                                    filename:
                                                                        "${map['video'].path.split('/').last}")
                                                                .then(
                                                                    (value) async {
                                                              formData.files
                                                                  .add(
                                                                MapEntry(
                                                                    "video",
                                                                    value),
                                                              );
                                                            });
                                                            await MultipartFile.fromFile(
                                                                    map['video_tmb']
                                                                        .path!,
                                                                    filename:
                                                                        "${map['video_tmb'].path.split('/').last}")
                                                                .then(
                                                                    (value) async {
                                                              formData.files
                                                                  .add(
                                                                MapEntry(
                                                                    "video_tmb",
                                                                    value),
                                                              );
                                                            });
                                                          }
                                                          print(
                                                              "amarformdata ${formData.files}  ${formData.fields}");
                                                          showSnackBar(
                                                              context: context,
                                                              message:
                                                                  "Uploading...",
                                                              isError: false);
                                                          Api.uploadPost.call(
                                                              context,
                                                              method:
                                                                  "media/contest",
                                                              param: formData,
                                                              onResponseSuccess:
                                                                  (Map object) {
                                                            Constants
                                                                .todayPosts = 1;
                                                            showSnackBar(
                                                                context:
                                                                    context,
                                                                message:
                                                                    "Uploaded",
                                                                isError: false);
                                                          });
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
                                      ],
                                    ),
                                  ),
                                ),

                          //TODO: Bottom User Details & Comment Button

                          provider.feedList[provider.getIndex] == null
                              //bottom ads
                              ? Container()
                              : provider.feedList[provider.getIndex].media![0]
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
                                                padding: EdgeInsets.only(
                                                    top: 14,
                                                    left: provider.detailShow
                                                        ? 12
                                                        : 14,
                                                    right: 14,
                                                    bottom: provider
                                                                .feedList[provider
                                                                    .getIndex]
                                                                .type ==
                                                            'brand'
                                                        ? 0
                                                        : 14),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            if (provider.ids ==
                                                                provider
                                                                    .feedList[
                                                                        provider
                                                                            .getIndex]
                                                                    .user!
                                                                    .id) {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          ProfileFameLink(
                                                                            selectPhase:
                                                                                0,
                                                                          )));
                                                            } else {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(rauts().createRoute(OtherProfile(
                                                                      id: provider
                                                                          .feedList[provider
                                                                              .getIndex]
                                                                          .user!
                                                                          .id!,
                                                                      selectPhase:
                                                                          0)));
                                                            }
                                                          },
                                                          child: Container(
                                                            height: 45,
                                                            width: 45,
                                                            decoration:
                                                                BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                            image:
                                                                                NetworkImage(
                                                                      provider.feedList[provider.getIndex].user!.profileImageType ==
                                                                              'avatar'
                                                                          ? "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.feedList[provider.getIndex].user!.profileImage}"
                                                                          : "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.feedList[provider.getIndex].user!.profileImage}",
                                                                    )),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color:
                                                                          white,
                                                                      width: 1,
                                                                    ),
                                                                    boxShadow: [
                                                                  BoxShadow(
                                                                    color: black
                                                                        .withOpacity(
                                                                            0.25),
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            4),
                                                                    blurRadius:
                                                                        4,
                                                                  )
                                                                ]),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            provider.detailShow ==
                                                                        true &&
                                                                    provider.feedList[provider.getIndex]
                                                                            .type ==
                                                                        'brand'
                                                                ? Container(
                                                                    decoration: BoxDecoration(
                                                                        color: Color(
                                                                            0xff4B4E58),
                                                                        border: Border.all(
                                                                            color: Colors
                                                                                .blue),
                                                                        borderRadius:
                                                                            BorderRadius.circular(4)),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top:
                                                                              2,
                                                                          bottom:
                                                                              2,
                                                                          left:
                                                                              8,
                                                                          right:
                                                                              8),
                                                                      child:
                                                                          Text(
                                                                        "@" + provider.feedList[provider.getIndex].name! ??
                                                                            "@ProductName",
                                                                        style: GoogleFonts
                                                                            .nunitoSans(
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          fontSize:
                                                                              ScreenUtil().setSp(10),
                                                                          color:
                                                                              white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(),
                                                            // SizedBox(height: 5.h),
                                                            InkWell(
                                                                onTap: () {
                                                                  if (provider
                                                                          .ids ==
                                                                      provider
                                                                          .feedList[
                                                                              provider.getIndex]
                                                                          .user!
                                                                          .id) {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => ProfileFameLink(
                                                                                  selectPhase: 0,
                                                                                )));
                                                                  } else {
                                                                    Navigator.of(context).push(rauts().createRoute(OtherProfile(
                                                                        id: provider
                                                                            .feedList[provider
                                                                                .getIndex]
                                                                            .user!
                                                                            .id!,
                                                                        selectPhase:
                                                                            0)));
                                                                  }
                                                                },
                                                                child:
                                                                    ConstrainedBox(
                                                                  constraints: BoxConstraints(
                                                                      maxWidth:
                                                                          (ScreenUtil().screenWidth / 2) -
                                                                              50),
                                                                  child: Text(
                                                                    (provider.feedList[provider.getIndex].user !=
                                                                                null &&
                                                                            provider.feedList[provider.getIndex].user
                                                                                .toString()
                                                                                .isNotEmpty &&
                                                                            provider.feedList[provider.getIndex].user
                                                                                .toString()
                                                                                .isNotEmpty &&
                                                                            provider.feedList[provider.getIndex].user!.username.toString() !=
                                                                                null)
                                                                        ? provider
                                                                            .feedList[provider.getIndex]
                                                                            .user!
                                                                            .name
                                                                            .toString()
                                                                        : "",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 2,
                                                                    style: GoogleFonts
                                                                        .nunitoSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          ScreenUtil()
                                                                              .setSp(24),
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
                                                                )),
                                                          ],
                                                        ),
                                                        SizedBox(width: 15),
                                                        if (provider
                                                                .detailShow ==
                                                            true)
                                                          provider.ids ==
                                                                  provider
                                                                      .feedList[
                                                                          provider
                                                                              .getIndex]
                                                                      .user!
                                                                      .id
                                                              ? Container()
                                                              : provider
                                                                          .feedList[provider
                                                                              .getIndex]
                                                                          .followStatus ==
                                                                      "Follow"
                                                                  ? FollowButton(
                                                                      text:
                                                                          'Follow',
                                                                      onPressed:
                                                                          () {
                                                                        provider.getFollowStatus(provider
                                                                            .feedList[provider.getIndex]
                                                                            .user!
                                                                            .id!);
                                                                      },
                                                                    )
                                                                  : provider.feedList[provider.getIndex]
                                                                              .followStatus ==
                                                                          'Following'
                                                                      ? FollowButton(
                                                                          text:
                                                                              'Following',
                                                                          onPressed:
                                                                              () {
                                                                            provider.getUnFollowStatus(provider.feedList[provider.getIndex].user!.id!);
                                                                          },
                                                                        )
                                                                      : Container()
                                                        else
                                                          Container(),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 22, bottom: 12),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      if (provider.detailShow ==
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
                                                  SizedBox(
                                                    width: ScreenUtil()
                                                        .setWidth(8),
                                                  ),
                                                  Visibility(
                                                    visible: !visibilityTag,
                                                    child: Row(
                                                      children: [
                                                        provider.detailShow !=
                                                                true
                                                            ? InkWell(
                                                                onTap: () {
                                                                  if (provider
                                                                          .ids ==
                                                                      provider
                                                                          .feedList[
                                                                              provider.getIndex]
                                                                          .user!
                                                                          .id) {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => ProfileFameLink(
                                                                                  selectPhase: 0,
                                                                                )));
                                                                  } else {
                                                                    Navigator.of(context).push(rauts().createRoute(OtherProfile(
                                                                        id: provider
                                                                            .feedList[provider
                                                                                .getIndex]
                                                                            .user!
                                                                            .id!,
                                                                        selectPhase:
                                                                            0)));
                                                                  }
                                                                },
                                                                child:
                                                                    ConstrainedBox(
                                                                  constraints: BoxConstraints(
                                                                      maxWidth:
                                                                          (ScreenUtil().screenWidth / 2) -
                                                                              50),
                                                                  child: Text(
                                                                    provider.feedList[provider.getIndex].user ==
                                                                            null
                                                                        ? ""
                                                                        : provider.feedList[provider.getIndex].user!.username ??
                                                                            "",
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
                                                              )
                                                            : Container(),
                                                        provider.detailShow ==
                                                                    true &&
                                                                provider
                                                                        .feedList[provider
                                                                            .getIndex]
                                                                        .type ==
                                                                    'brand'
                                                            ? Wrap(
                                                                crossAxisAlignment:
                                                                    WrapCrossAlignment
                                                                        .center,
                                                                children: [
                                                                  ConstrainedBox(
                                                                    constraints:
                                                                        BoxConstraints(
                                                                            maxWidth:
                                                                                (ScreenUtil().screenWidth / 2) - 50),
                                                                    child:
                                                                        ReadMoreText(
                                                                      provider.feedList[provider.getIndex] !=
                                                                              null
                                                                          ? provider.feedList[provider.getIndex].description ??
                                                                              ''
                                                                          : "",
                                                                      trimLines:
                                                                          3,
                                                                      trimMode:
                                                                          TrimMode
                                                                              .Line,
                                                                      style: GoogleFonts.nunitoSans(
                                                                          fontWeight: FontWeight.w400,
                                                                          color: white,
                                                                          shadows: [
                                                                            Shadow(
                                                                              blurRadius: 7.0,
                                                                              color: black.withOpacity(0.6),
                                                                              offset: Offset(2.0, 2.0),
                                                                            ),
                                                                          ],
                                                                          fontSize: ScreenUtil().setSp(14)),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10.w,
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      provider.feedList[provider.getIndex] != null &&
                                                                              provider.feedList[provider.getIndex].price != null &&
                                                                              provider.feedList[provider.getIndex].price.toString() != "0"
                                                                          ? Text(
                                                                              "Rs ${provider.feedList[provider.getIndex].price.toString()}",
                                                                              style: GoogleFonts.nunitoSans(
                                                                                  fontWeight: FontWeight.w400,
                                                                                  color: white,
                                                                                  shadows: [
                                                                                    Shadow(
                                                                                      blurRadius: 7.0,
                                                                                      color: black.withOpacity(0.6),
                                                                                      offset: Offset(2.0, 2.0),
                                                                                    ),
                                                                                  ],
                                                                                  fontSize: ScreenUtil().setSp(10)),
                                                                            )
                                                                          : SizedBox(),
                                                                      provider
                                                                              .feedList[provider.getIndex]
                                                                              .buttonName!
                                                                              .isNotEmpty
                                                                          ? InkWell(
                                                                              onTap: () async {
                                                                                await Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(builder: (context) => WebViewScreenUrl(provider.feedList[provider.getIndex].name ?? "", provider.feedList[provider.getIndex].purchaseUrl!)),
                                                                                );
                                                                              },
                                                                              child: Wrap(
                                                                                children: [
                                                                                  Container(
                                                                                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                                                                                    padding: EdgeInsets.only(left: ScreenUtil().setHeight(12), right: ScreenUtil().setHeight(12)),
                                                                                    height: ScreenUtil().setHeight(30),
                                                                                    decoration: new BoxDecoration(
                                                                                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                                        lightButtonBlue,
                                                                                        buttonBlue
                                                                                      ]),
                                                                                      borderRadius: BorderRadius.only(
                                                                                        topLeft: Radius.circular(8),
                                                                                        topRight: Radius.circular(8),
                                                                                        bottomLeft: Radius.circular(8),
                                                                                        bottomRight: Radius.circular(8),
                                                                                      ),
                                                                                    ),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Text(
                                                                                          provider.feedList[provider.getIndex].buttonName!.isNotEmpty ? provider.feedList[provider.getIndex].buttonName! : 'Buy Now',
                                                                                          style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w400, color: white, fontSize: ScreenUtil().setSp(12)),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          : SizedBox(),
                                                                    ],
                                                                  )
                                                                ],
                                                              )
                                                            : provider.detailShow ==
                                                                    true
                                                                ? provider.feedList[provider.getIndex].description !=
                                                                            null &&
                                                                        provider.feedList[provider.getIndex].description !=
                                                                            ""
                                                                    ? Wrap(
                                                                        crossAxisAlignment:
                                                                            WrapCrossAlignment.center,
                                                                        children: [
                                                                          ConstrainedBox(
                                                                            constraints:
                                                                                BoxConstraints(maxWidth: (ScreenUtil().screenWidth / 1.4)),
                                                                            child:
                                                                                ReadMoreText(
                                                                              '${provider.feedList[provider.getIndex].description} ${convertToAgo(DateTime.parse('${provider.feedList[provider.getIndex].createdAt}'))} ',
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
                                                                        ],
                                                                      )
                                                                    : Text(
                                                                        "${convertToAgo(DateTime.parse('${provider.feedList[provider.getIndex].createdAt}'))} ",
                                                                        style: GoogleFonts
                                                                            .nunitoSans(
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          fontSize:
                                                                              ScreenUtil().setSp(16),
                                                                          shadows: [
                                                                            Shadow(
                                                                              blurRadius: 7.0,
                                                                              color: white.withOpacity(0.6),
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
                                                  Visibility(
                                                    visible: visibilityTag,
                                                    child: Wrap(
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: ScreenUtil()
                                                              .setWidth(5),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: ScreenUtil()
                                                        .setWidth(8),
                                                  ),
                                                  provider.ids ==
                                                          provider
                                                              .feedList[provider
                                                                  .getIndex]
                                                              .user!
                                                              .id
                                                      ? Container()
                                                      : provider.detailShow ==
                                                              true
                                                          ? Container()
                                                          : provider
                                                                      .feedList[
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
                                                                        .feedList[
                                                                            provider.getIndex]
                                                                        .user!
                                                                        .id!);
                                                                  },
                                                                )
                                                              : provider.feedList[provider.getIndex]
                                                                          .followStatus ==
                                                                      'Following'
                                                                  ? FollowButton(
                                                                      text:
                                                                          'Following',
                                                                      onPressed:
                                                                          () {
                                                                        provider.getUnFollowStatus(provider
                                                                            .feedList[provider.getIndex]
                                                                            .user!
                                                                            .id!);
                                                                      },
                                                                    )
                                                                  : Container()
                                                ],
                                              ),
                                            ),
                                            Center(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 39.w),
                                                child: provider
                                                            .feedList[provider
                                                                .getIndex]
                                                            .famelinksContest ==
                                                        true
                                                    ? Image.asset(
                                                        "assets/icons/logo.png",
                                                        height: 20.h,
                                                        width: 20.w,
                                                        color: white)
                                                    : provider
                                                                .feedList[provider
                                                                    .getIndex]
                                                                .ambassadorTrendz ==
                                                            true
                                                        ? Icon(Icons.stars,
                                                            size: 20.r,
                                                            color: white)
                                                        : Container(),
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
                                                InkWell(
                                                  onTap: () async {
                                                    if (provider.isRegistered ==
                                                        false) {
                                                      registerDialog(context);
                                                    } else {
                                                      String newUserId =
                                                          await Provider.of<
                                                                      DatabaseProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .getUserId();

                                                      showModalBottomSheet(
                                                          context: context,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.vertical(
                                                                      top: Radius
                                                                          .circular(
                                                                              20))),
                                                          builder: (BuildContext
                                                              context) {
                                                            return CommentView(
                                                                type:
                                                                    'famelinks',
                                                                postId: provider
                                                                    .feedList[
                                                                        provider
                                                                            .getIndex]
                                                                    .id!,
                                                                newUserId:
                                                                    newUserId,
                                                                userId: provider
                                                                    .feedList[
                                                                        provider
                                                                            .getIndex]
                                                                    .user!
                                                                    .id!);
                                                          });
                                                    }
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: ScreenUtil()
                                                            .setWidth(20),
                                                        bottom: ScreenUtil()
                                                            .setHeight(2)),
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 20.0,
                                                            color: Color(
                                                                    0xff000000)
                                                                .withOpacity(
                                                                    0.25),
                                                            offset: Offset(
                                                                0.0, 4.0),
                                                          ),
                                                        ]),
                                                    child: SvgPicture.asset(
                                                        "assets/icons/svg/comment.svg",
                                                        color: white),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    if (provider.isRegistered ==
                                                        false) {
                                                      registerDialog(context);
                                                    } else {
                                                      Sharedynamic.shareprofile(
                                                          provider
                                                              .feedList[provider
                                                                  .getIndex]
                                                              .id
                                                              .toString(),
                                                          "famelinkfeed",
                                                          provider
                                                              .feedList[provider
                                                                  .getIndex]
                                                              .description
                                                              .toString());
                                                      // showFamLinkShareDialog(
                                                      //     context,
                                                      //     "${provider.feedList[provider.getIndex].media?[ind].path}",
                                                      //     provider
                                                      //         .feedList[provider
                                                      //             .getIndex]
                                                      //         .media![0]
                                                      //         .type!,
                                                      //     provider.getIndex);
                                                    }
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: ScreenUtil()
                                                            .setWidth(20),
                                                        bottom: ScreenUtil()
                                                            .setHeight(10)),
                                                    child: SvgPicture.asset(
                                                        "assets/icons/svg/share.svg",
                                                        color: white),
                                                  ),
                                                ),
                                                Spacer(),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: ScreenUtil()
                                                          .setHeight(23)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            150.w,
                                                        child: Center(
                                                          child: InkWell(
                                                            onTap: () {
                                                              ChallengesModelData challengesModelData = ChallengesModelData(
                                                                  id: "",
                                                                  challengeId: provider
                                                                      .feedList[
                                                                          provider
                                                                              .getIndex]
                                                                      .challenges![
                                                                          0]
                                                                      .id!,
                                                                  challengeName: provider
                                                                      .feedList[
                                                                          provider
                                                                              .getIndex]
                                                                      .challenges![
                                                                          0]
                                                                      .hashTag!,
                                                                  postId: "");
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            FameLinksChallengeScreen(
                                                                              challengesModelData: challengesModelData,
                                                                            )),
                                                              );
                                                            },
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 5.h),
                                                              child: provider
                                                                              .feedList[provider
                                                                                  .getIndex]
                                                                              .challenges !=
                                                                          null &&
                                                                      provider
                                                                          .feedList[provider
                                                                              .getIndex]
                                                                          .challenges!
                                                                          .isNotEmpty &&
                                                                      provider
                                                                              .feedList[provider
                                                                                  .getIndex]
                                                                              .challenges!
                                                                              .length !=
                                                                          0 &&
                                                                      provider.feedList[provider.getIndex].challenges![0].hashTag !=
                                                                          null &&
                                                                      provider
                                                                          .feedList[provider
                                                                              .getIndex]
                                                                          .challenges![
                                                                              0]
                                                                          .hashTag
                                                                          .toString()
                                                                          .isNotEmpty
                                                                  ? Text(
                                                                      ("#${provider.feedList[provider.getIndex].challenges![0].hashTag.toString().replaceAll('#', '')}"),
                                                                      maxLines:
                                                                          2,
                                                                      style: GoogleFonts
                                                                          .nunitoSans(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        shadows: <
                                                                            Shadow>[
                                                                          Shadow(
                                                                            offset:
                                                                                Offset(0.0, 2.0),
                                                                            blurRadius:
                                                                                2.0,
                                                                            color:
                                                                                Color(0xff000000).withOpacity(0.25),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : Container(),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 5.w),
                                                      SmoothPageIndicator(
                                                        controller: provider
                                                            .smoothPageController!,
                                                        count: (provider
                                                                        .feedList !=
                                                                    null &&
                                                                provider
                                                                    .feedList
                                                                    .isNotEmpty &&
                                                                provider
                                                                        .feedList[provider
                                                                            .getIndex]
                                                                        .media !=
                                                                    null &&
                                                                provider
                                                                    .feedList[
                                                                        provider
                                                                            .getIndex]
                                                                    .media!
                                                                    .isNotEmpty &&
                                                                provider
                                                                        .feedList[provider
                                                                            .getIndex]
                                                                        .media!
                                                                        .length !=
                                                                    null)
                                                            ? provider
                                                                .feedList[provider
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
                                                            dotColor:
                                                                Colors.white,
                                                            activeDotColor:
                                                                lightRed),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Spacer(),
                                                NotificationIconWidget(),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                        ],
                      )
                    : Stack(
                        children: [
                          PinchZoom(
                            child: FeedView(),
                            resetDuration: const Duration(milliseconds: 100),
                            maxScale: 2.5,
                            onZoomStart: () {
                              print('Start zooming');
                            },
                            onZoomEnd: () {
                              print('Stop zooming');
                            },
                          ),
                          provider.feedList[provider.getIndex] == null
                              ? Container()
                              : FameLinkFeedLikerButton(
                                  isRegistered: provider.isRegistered!),
                          provider.feedList[provider.getIndex] == null
                              ? Container()
                              : Column(children: [
                                  Padding(
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
                                ]),
                          provider.feedList[provider.getIndex] == null
                              ? Container()
                              : provider.feedList[provider.getIndex] == null
                                  ? Container()
                                  : Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        provider.detailShow == true
                                            ? Padding(
                                                padding: EdgeInsets.only(
                                                    top: 14,
                                                    left: provider.detailShow
                                                        ? 12
                                                        : 14,
                                                    right: 14,
                                                    bottom: provider
                                                                .feedList[provider
                                                                    .getIndex]
                                                                .type ==
                                                            'brand'
                                                        ? 0
                                                        : 14),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            if (provider.ids ==
                                                                provider
                                                                    .feedList[
                                                                        provider
                                                                            .getIndex]
                                                                    .user!
                                                                    .id) {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          ProfileFameLink(
                                                                            selectPhase:
                                                                                0,
                                                                          )));
                                                            } else {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(rauts().createRoute(OtherProfile(
                                                                      id: provider
                                                                          .feedList[provider
                                                                              .getIndex]
                                                                          .user!
                                                                          .id!,
                                                                      selectPhase:
                                                                          0)));
                                                            }
                                                          },
                                                          child: Container(
                                                            height: 45,
                                                            width: 45,
                                                            decoration:
                                                                BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                            image:
                                                                                NetworkImage(
                                                                      provider.feedList[provider.getIndex].user!.profileImageType ==
                                                                              'avatar'
                                                                          ? "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.feedList[provider.getIndex].user!.profileImage}"
                                                                          : "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.feedList[provider.getIndex].user!.profileImage}",
                                                                    )),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color:
                                                                          white,
                                                                      width: 1,
                                                                    ),
                                                                    boxShadow: [
                                                                  BoxShadow(
                                                                    color: black
                                                                        .withOpacity(
                                                                            0.25),
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            4),
                                                                    blurRadius:
                                                                        4,
                                                                  )
                                                                ]),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            provider.detailShow ==
                                                                        true &&
                                                                    provider.feedList[provider.getIndex]
                                                                            .type ==
                                                                        'brand'
                                                                ? Container(
                                                                    decoration: BoxDecoration(
                                                                        color: Color(
                                                                            0xff4B4E58),
                                                                        border: Border.all(
                                                                            color: Colors
                                                                                .blue),
                                                                        borderRadius:
                                                                            BorderRadius.circular(4)),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top:
                                                                              2,
                                                                          bottom:
                                                                              2,
                                                                          left:
                                                                              8,
                                                                          right:
                                                                              8),
                                                                      child:
                                                                          Text(
                                                                        "@" + provider.feedList[provider.getIndex].name! ??
                                                                            "@ProductName",
                                                                        style: GoogleFonts
                                                                            .nunitoSans(
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          fontSize:
                                                                              ScreenUtil().setSp(10),
                                                                          color:
                                                                              white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(),
// SizedBox(height: 5.h),
                                                            InkWell(
                                                              onTap: () {
                                                                if (provider
                                                                        .ids ==
                                                                    provider
                                                                        .feedList[
                                                                            provider.getIndex]
                                                                        .user!
                                                                        .id) {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => ProfileFameLink(
                                                                                selectPhase: 0,
                                                                              )));
                                                                } else {
                                                                  Navigator.of(context).push(rauts().createRoute(OtherProfile(
                                                                      id: provider
                                                                          .feedList[provider
                                                                              .getIndex]
                                                                          .user!
                                                                          .id!,
                                                                      selectPhase:
                                                                          0)));
                                                                }
                                                              },
                                                              child: Text(
                                                                (provider.feedList[provider.getIndex].user !=
                                                                            null &&
                                                                        provider
                                                                            .feedList[provider
                                                                                .getIndex]
                                                                            .user
                                                                            .toString()
                                                                            .isNotEmpty &&
                                                                        provider
                                                                            .feedList[provider
                                                                                .getIndex]
                                                                            .user
                                                                            .toString()
                                                                            .isNotEmpty &&
                                                                        provider.feedList[provider.getIndex].user!.username.toString() !=
                                                                            null)
                                                                    ? provider
                                                                        .feedList[
                                                                            provider.getIndex]
                                                                        .user!
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
                                                                              24),
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
                                                          ],
                                                        ),
                                                        SizedBox(width: 15),
                                                        if (provider
                                                                .detailShow ==
                                                            true)
                                                          provider.ids ==
                                                                  provider
                                                                      .feedList[
                                                                          provider
                                                                              .getIndex]
                                                                      .user!
                                                                      .id
                                                              ? Container()
                                                              : provider.feedList[provider.getIndex]
                                                                          .followStatus ==
                                                                      "Follow"
                                                                  ? FollowButton(
                                                                      text:
                                                                          'Follow',
                                                                      onPressed:
                                                                          () {
                                                                        provider.getFollowStatus(provider
                                                                            .feedList[provider.getIndex]
                                                                            .user!
                                                                            .id!);
                                                                      },
                                                                    )
                                                                  : Container()
                                                        else
                                                          Container(),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        provider.feedList[provider.index]
                                                    .media![0].type
                                                    .toString() ==
                                                "ads"
                                            ? Container()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 22, bottom: 12),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    InkWell(
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
                                                    SizedBox(
                                                      width: ScreenUtil()
                                                          .setWidth(8),
                                                    ),
                                                    Visibility(
                                                      visible: !visibilityTag,
                                                      child: Row(
                                                        children: [
                                                          provider.detailShow !=
                                                                  true
                                                              ? InkWell(
                                                                  onTap: () {
                                                                    if (provider
                                                                            .ids ==
                                                                        provider
                                                                            .feedList[provider.getIndex]
                                                                            .user!
                                                                            .id) {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => ProfileFameLink(
                                                                                    selectPhase: 0,
                                                                                  )));
                                                                    } else {
                                                                      Navigator.of(context).push(rauts().createRoute(OtherProfile(
                                                                          id: provider
                                                                              .feedList[provider
                                                                                  .getIndex]
                                                                              .user!
                                                                              .id!,
                                                                          selectPhase:
                                                                              0)));
                                                                    }
                                                                  },
                                                                  child:
                                                                      ConstrainedBox(
                                                                    constraints:
                                                                        BoxConstraints(
                                                                            maxWidth:
                                                                                (ScreenUtil().screenWidth / 2) - 50),
                                                                    child: Text(
                                                                      provider.feedList[provider.getIndex].user ==
                                                                              null
                                                                          ? ""
                                                                          : provider.feedList[provider.getIndex].user!.username ??
                                                                              "",
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: GoogleFonts
                                                                          .nunitoSans(
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        fontSize:
                                                                            ScreenUtil().setSp(16),
                                                                        shadows: [
                                                                          Shadow(
                                                                            blurRadius:
                                                                                7.0,
                                                                            color:
                                                                                black.withOpacity(0.6),
                                                                            offset:
                                                                                Offset(2.0, 2.0),
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
                                                                      true &&
                                                                  provider
                                                                          .feedList[provider
                                                                              .getIndex]
                                                                          .type ==
                                                                      'brand'
                                                              ? Wrap(
                                                                  crossAxisAlignment:
                                                                      WrapCrossAlignment
                                                                          .center,
                                                                  children: [
                                                                    ConstrainedBox(
                                                                      constraints:
                                                                          BoxConstraints(
                                                                              maxWidth: (ScreenUtil().screenWidth / 2) - 50),
                                                                      child:
                                                                          ReadMoreText(
                                                                        provider.feedList[provider.getIndex] !=
                                                                                null
                                                                            ? provider.feedList[provider.getIndex].description ??
                                                                                ''
                                                                            : "",
                                                                        trimLines:
                                                                            3,
                                                                        trimMode:
                                                                            TrimMode.Line,
                                                                        style: GoogleFonts.nunitoSans(
                                                                            fontWeight: FontWeight.w400,
                                                                            color: white,
                                                                            shadows: [
                                                                              Shadow(
                                                                                blurRadius: 7.0,
                                                                                color: black.withOpacity(0.6),
                                                                                offset: Offset(2.0, 2.0),
                                                                              ),
                                                                            ],
                                                                            fontSize: ScreenUtil().setSp(14)),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          10.w,
                                                                    ),
                                                                    Column(
                                                                      children: [
                                                                        provider.feedList[provider.getIndex] != null &&
                                                                                provider.feedList[provider.getIndex].price != null &&
                                                                                provider.feedList[provider.getIndex].price.toString() != "0"
                                                                            ? Text(
                                                                                "Rs ${provider.feedList[provider.getIndex].price.toString()}",
                                                                                style: GoogleFonts.nunitoSans(
                                                                                    fontWeight: FontWeight.w400,
                                                                                    color: white,
                                                                                    shadows: [
                                                                                      Shadow(
                                                                                        blurRadius: 7.0,
                                                                                        color: black.withOpacity(0.6),
                                                                                        offset: Offset(2.0, 2.0),
                                                                                      ),
                                                                                    ],
                                                                                    fontSize: ScreenUtil().setSp(10)),
                                                                              )
                                                                            : SizedBox(),
                                                                        provider.feedList[provider.getIndex].buttonName!.isNotEmpty
                                                                            ? InkWell(
                                                                                onTap: () async {
                                                                                  await Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(builder: (ontext) => WebViewScreenUrl(provider.feedList[provider.getIndex].name ?? "", provider.feedList[provider.getIndex].purchaseUrl!)),
                                                                                  );
                                                                                },
                                                                                child: Wrap(
                                                                                  children: [
                                                                                    Container(
                                                                                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                                                                                      padding: EdgeInsets.only(left: ScreenUtil().setHeight(12), right: ScreenUtil().setHeight(12)),
                                                                                      height: ScreenUtil().setHeight(30),
                                                                                      decoration: new BoxDecoration(
                                                                                        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                                          lightButtonBlue,
                                                                                          buttonBlue
                                                                                        ]),
                                                                                        borderRadius: BorderRadius.only(
                                                                                          topLeft: Radius.circular(8),
                                                                                          topRight: Radius.circular(8),
                                                                                          bottomLeft: Radius.circular(8),
                                                                                          bottomRight: Radius.circular(8),
                                                                                        ),
                                                                                      ),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.min,
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Text(
                                                                                            provider.feedList[provider.getIndex].buttonName!.isNotEmpty ? provider.feedList[provider.getIndex].buttonName! : 'Buy Now',
                                                                                            style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w400, color: white, fontSize: ScreenUtil().setSp(12)),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            : SizedBox(),
                                                                      ],
                                                                    )
                                                                  ],
                                                                )
                                                              : provider.detailShow ==
                                                                      true
                                                                  ? provider.feedList[provider.getIndex].description !=
                                                                              null &&
                                                                          provider.feedList[provider.getIndex].description !=
                                                                              ""
                                                                      ? Wrap(
                                                                          crossAxisAlignment:
                                                                              WrapCrossAlignment.center,
                                                                          children: [
                                                                            ConstrainedBox(
                                                                              constraints: BoxConstraints(maxWidth: (ScreenUtil().screenWidth / 1.4)),
                                                                              child: ReadMoreText(
                                                                                '${provider.feedList[provider.getIndex].description} ${convertToAgo(DateTime.parse('${provider.feedList[provider.getIndex].createdAt}'))}',
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
                                                                          ],
                                                                        )
                                                                      : Text(
                                                                          "${convertToAgo(DateTime.parse('${provider.feedList[provider.getIndex].createdAt}'))} ",
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
                                                    Visibility(
                                                      visible: visibilityTag,
                                                      child: Wrap(
                                                        crossAxisAlignment:
                                                            WrapCrossAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            width: ScreenUtil()
                                                                .setWidth(5),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: ScreenUtil()
                                                          .setWidth(8),
                                                    ),
                                                    provider.ids ==
                                                            provider
                                                                .feedList[provider
                                                                    .getIndex]
                                                                .user!
                                                                .id
                                                        ? Container()
                                                        : provider.detailShow ==
                                                                true
                                                            ? Container()
                                                            : provider
                                                                        .feedList[
                                                                            provider.getIndex]
                                                                        .followStatus ==
                                                                    "Follow"
                                                                ? FollowButton(
                                                                    text:
                                                                        'Follow',
                                                                    onPressed:
                                                                        () {
                                                                      provider.getFollowStatus(provider
                                                                          .feedList[
                                                                              provider.getIndex]
                                                                          .user!
                                                                          .id!);
                                                                    },
                                                                  )
                                                                : Container()
                                                  ],
                                                ),
                                              ),
                                        Center(
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 39.w),
                                            child: provider
                                                        .feedList[
                                                            provider.getIndex]
                                                        .famelinksContest ==
                                                    true
                                                ? Image.asset(
                                                    "assets/icons/logo.png",
                                                    height: 20.h,
                                                    width: 20.w,
                                                    color: white)
                                                : provider
                                                            .feedList[provider
                                                                .getIndex]
                                                            .ambassadorTrendz ==
                                                        true
                                                    ? Icon(Icons.stars,
                                                        size: 20.r,
                                                        color: white)
                                                    : Container(),
                                          ),
                                        ),
                                        SizedBox(height: 32)
                                      ],
                                    ),
                          provider.getIsProfileUI == false
                              ? Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 33.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[],
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      );
              } else {
                return Container(
                  color: Colors.black,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            });
    });
  }

  void showReferralCodeDialog() {
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
                  key: _referralKey,
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
                              top: ScreenUtil().setHeight(7),
                              bottom: ScreenUtil().setHeight(7),
                              left: ScreenUtil().setWidth(16),
                              right: ScreenUtil().setWidth(16)),
                          child: Center(
                            child: Text(
                              'Enter username of the person who referred you',
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  color: white,
                                  fontWeight: FontWeight.w400),
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
                              Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(14),
                                    left: ScreenUtil().setWidth(20),
                                    right: ScreenUtil().setWidth(20)),
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  textAlignVertical: TextAlignVertical.center,
                                  controller: refferalCodeController,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.done,
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(14),
                                      color: darkGray,
                                      fontWeight: FontWeight.w700),
                                  validator: (value) {
                                    return Validator.validateFormField(
                                        value!,
                                        strErrorEmptyName,
                                        strInvalidName,
                                        Constants.NORMAL_VALIDATION);
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: white25,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGray,
                                          width: ScreenUtil().radius(1)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenUtil().radius(8))),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: buttonBlue,
                                          width: ScreenUtil().radius(1)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenUtil().radius(8))),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGray,
                                          width: ScreenUtil().radius(1)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenUtil().radius(8))),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(11)),
                                    prefixText: '@',
                                    prefixStyle: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(14),
                                        color: darkGray,
                                        fontWeight: FontWeight.w700),
                                    hintText: "username",
                                    hintStyle: GoogleFonts.nunitoSans(
                                        fontStyle: FontStyle.italic,
                                        fontSize: ScreenUtil().setSp(12),
                                        color: lightGray,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setSp(32),
                                    bottom: ScreenUtil().setSp(20)),
                                child: IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Center(
                                              child: InkWell(
                                        onTap: () async {
                                          Navigator.pop(context);
                                          if (refferalCodeController
                                              .text.isNotEmpty) {
                                            Map<String, dynamic> params = {
                                              "referralCode":
                                                  refferalCodeController.text
                                            };
                                            Api.post.call(context,
                                                method: "refer/apply",
                                                param: params,
                                                isLoading: false,
                                                onResponseSuccess:
                                                    (Map object) {
                                              var result =
                                                  UserUpdatedResponse.fromJson(
                                                      object);
                                              // print(result);
                                              Constants.toastMessage(
                                                  msg: result.message);
                                              refferalCodeController.text = "";
                                              if (result.message!.contains(
                                                  "Referral Applied")) {
                                                isReferred = false;
                                                myInfoResponse!
                                                        .result!.referredBy =
                                                    refferalCodeController.text;
                                                setState(() {});
                                              }
                                            });
                                          }
                                        },
                                        child: Text("Submit",
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                color: black)),
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
                                        child: Text("Cancel",
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                color: lightGray)),
                                      ))),
                                    ],
                                  ),
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

  void showProfileVerifyDialog() async {
    var result = await showDialog(
        context: context,
        builder: (BuildContext context3) {
          return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.only(
                  left: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - 300) / 2),
                  right: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - 300) / 2)),
              child: StatefulBuilder(
                  builder: (BuildContext context2, StateSetter setStates) {
                return Form(
                  key: _profileKey,
                  child: Container(
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
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular(ScreenUtil().setSp(16)),
                                topRight:
                                    Radius.circular(ScreenUtil().setSp(16))),
                          ),
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(16),
                              bottom: ScreenUtil().setHeight(14),
                              left: ScreenUtil().setWidth(16),
                              right: ScreenUtil().setWidth(5)),
                          child: Row(
                            children: [
                              Text(
                                'Please verify your profile',
                                style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(14),
                                    color: black,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(8),
                              ),
                              SvgPicture.asset("assets/icons/svg/done.svg",
                                  height: ScreenUtil().setSp(16),
                                  width: ScreenUtil().setSp(16))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(12),
                              bottom: ScreenUtil().setHeight(16),
                              left: ScreenUtil().setHeight(16),
                              right: ScreenUtil().setHeight(16)),
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
                              ageGroup == "groupA" ||
                                      ageGroup == "groupB" ||
                                      ageGroup == "groupC"
                                  ? Text.rich(TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: 'To be able to',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize:
                                                  ScreenUtil().setSp(14))),
                                      TextSpan(
                                          text: ' Upload Posts',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(14),
                                              color: black)),
                                      TextSpan(
                                          text: ' or ',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize:
                                                  ScreenUtil().setSp(14))),
                                      TextSpan(
                                          text: 'Participate in Contests',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(14),
                                              color: black)),
                                      TextSpan(
                                          text:
                                              ' on FameLinks App, you are required to verify your profile.',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize:
                                                  ScreenUtil().setSp(14))),
                                    ]))
                                  : Text.rich(TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: 'To be able to ',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize:
                                                  ScreenUtil().setSp(14))),
                                      TextSpan(
                                          text: 'Participate in Contests',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(14),
                                              color: black)),
                                      TextSpan(
                                          text:
                                              ' on FameLinks App, you are required to verify your profile.',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize:
                                                  ScreenUtil().setSp(14))),
                                    ])),
                              InkWell(
                                onTap: () async {
                                  Navigator.pop(context2, true);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setSp(18),
                                      bottom: ScreenUtil().setSp(21)),
                                  width: ScreenUtil().setWidth(96),
                                  height: ScreenUtil().setHeight(26),
                                  decoration: new BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [lightRedWhite, lightRed]),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6),
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Verify',
                                        style: GoogleFonts.nunitoSans(
                                            color: white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: ScreenUtil().setSp(14)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ageGroup == "groupA" ||
                                      ageGroup == "groupB" ||
                                      ageGroup == "groupC"
                                  ? Text(
                                      'You can still see Posts and browse the App if you skip this important step',
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w300,
                                          color: black,
                                          fontStyle: FontStyle.italic,
                                          fontSize: ScreenUtil().setSp(12)))
                                  : Text.rich(TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Your posts can still be seen in ',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w300,
                                              color: black,
                                              fontStyle: FontStyle.italic,
                                              fontSize:
                                                  ScreenUtil().setSp(12))),
                                      TextSpan(
                                          text: 'FollowLinks & FunLinks, ',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(12),
                                              color: black)),
                                      TextSpan(
                                          text:
                                              'if you skip this important step',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w300,
                                              color: black,
                                              fontStyle: FontStyle.italic,
                                              fontSize:
                                                  ScreenUtil().setSp(12))),
                                    ])),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () async {
                                      print("AGEE:::${ageGroup}");
                                      if (ageGroup == "groupA" ||
                                          ageGroup == "groupB" ||
                                          ageGroup == "groupC") {
                                        Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UploadScreenOne()))
                                            .then((value) async {
                                          if (value != null) {
                                            // print("===> value is :- $value");
                                            Map map = value;
                                            var val =
                                                await _api.uploadFameLinksPost(
                                                    map['challengeId'],
                                                    context,
                                                    map['description'],
                                                    map['closeUp'],
                                                    map['medium'],
                                                    map['long'],
                                                    map['pose1'],
                                                    map['pose2'],
                                                    map['additional'],
                                                    map['video'],
                                                    map['video_tmb'],
                                                    map['ambassadorTrendz'],
                                                    map['famelinksContest']);

                                            if (val == 0) {
                                              DateTime date = DateTime.now();
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              await prefs.setString(
                                                  "fameContest",
                                                  map['famelinksContest']
                                                          .toString() +
                                                      "/" +
                                                      DateFormat('dd-MMM-yyyy')
                                                          .format(date));
                                              await prefs.setString(
                                                  "ambContest",
                                                  map['ambassadorTrendz']
                                                          .toString() +
                                                      "/" +
                                                      DateFormat('dd-MMM-yyyy')
                                                          .format(date));
                                              var snackBar = SnackBar(
                                                content: Text('Uploaded'),
                                              );

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          }
                                        });

//Navigator.pop(context2);
                                      } else {
//Navigator.pop(context2, false);
                                        Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UploadScreenOne()))
                                            .then((value) async {
                                          print("value======$value");
                                          if (value != null) {
                                            Map map = value;
                                            var val =
                                                await _api.uploadFameLinksPost(
                                                    map['challengeId'],
                                                    context,
                                                    map['description'],
                                                    map['closeUp'],
                                                    map['medium'],
                                                    map['long'],
                                                    map['pose1'],
                                                    map['pose2'],
                                                    map['additional'],
                                                    map['video'],
                                                    map['video_tmb'],
                                                    map['ambassadorTrendz'],
                                                    map['famelinksContest']);

                                            if (val == 0) {
                                              DateTime date = DateTime.now();
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              await prefs.setString(
                                                  "fameContest",
                                                  map['famelinksContest']
                                                          .toString() +
                                                      "/" +
                                                      DateFormat('dd-MMM-yyyy')
                                                          .format(date));
                                              await prefs.setString(
                                                  "ambContest",
                                                  map['ambassadorTrendz']
                                                          .toString() +
                                                      "/" +
                                                      DateFormat('dd-MMM-yyyy')
                                                          .format(date));
                                              var snackBar = SnackBar(
                                                content: Text('Uploaded'),
                                              );

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          }
                                        });
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenUtil().setSp(10),
                                          top: ScreenUtil().setSp(6),
                                          bottom: ScreenUtil().setSp(6)),
                                      child: Text('Skip for Now',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: buttonBlue,
                                              fontSize:
                                                  ScreenUtil().setSp(10))),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }));
        });
    if (result != null) {
      if (result == true) {
        Provider.of<FameLinksFeedProvider>(context, listen: false)
            .changeOnPageTurning(true);
        Provider.of<FameLinksFeedProvider>(context, listen: false)
            .changeOnPageHorizontalTurning(true);
        final result3 = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileVideoVerificationScreen()),
        );
        if (result3 != null) {
          var snackBar = SnackBar(
            content: Text('Compressing'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Constants.verificationStatus = "Submitted";
          final MediaInfo? info = await VideoCompress.compressVideo(
            result3,
            quality: VideoQuality.MediumQuality,
            deleteOrigin: false,
            includeAudio: true,
          );
          Constants.video = await MultipartFile.fromFile(info!.path!,
              filename: "${File(result3).path.split('/').last}");
          var formData = FormData.fromMap({
            "video": Constants.video,
          });
          Api.uploadPost.call(context,
              method: "users/profile/verify",
              param: formData, onResponseSuccess: (Map object) {
            var snackBar = SnackBar(
              content: Text('Uploaded'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });

          final result2 = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => UploadScreenOne()));
          if (result2 != null) {
            Map map = result2;
            FormData formData = FormData.fromMap({
              "challengeId": map['challengeId'],
              "description": map['description'],
              "closeUp": map['closeUp'],
              "medium": map['medium'],
              "long": map['long'],
              "pose1": map['pose1'],
              "pose2": map['pose2'],
              "additional": map['additional'],
              "video": map['video'],
            });
            Api.uploadPost.call(context,
                method: "media/contest",
                param: formData, onResponseSuccess: (Map object) {
              Constants.todayPosts = 1;
              var snackBar = SnackBar(
                content: Text('Uploaded'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });
          }
        }
      } else {
        Provider.of<FameLinksFeedProvider>(context, listen: false)
            .changeOnPageTurning(true);
        Provider.of<FameLinksFeedProvider>(context, listen: false)
            .changeOnPageHorizontalTurning(true);
        final result = await Navigator.push(context,
            MaterialPageRoute(builder: (context2) => UploadScreenOne()));
        if (result != null) {
          Map map = result;
          FormData formData = FormData.fromMap({
            "challengeId": map['challengeId'],
            "description": map['description'],
            "closeUp": map['closeUp'],
            "medium": map['medium'],
            "long": map['long'],
            "pose1": map['pose1'],
            "pose2": map['pose2'],
            "additional": map['additional'],
            "video": map['video'],
          });
          Api.uploadPost.call(context, method: "media/contest", param: formData,
              onResponseSuccess: (Map object) {
            var snackBar = SnackBar(
              content: Text('Uploaded'),
            );
            Constants.todayPosts = 1;
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        }
      }
    }
  }

  void showPerDayPostDialog() async {
    var result = await showDialog(
        context: context,
        builder: (BuildContext context3) {
          return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.only(
                  left: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - 300) / 2),
                  right: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - 300) / 2)),
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
                      Container(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(12),
                            bottom: ScreenUtil().setHeight(16),
                            left: ScreenUtil().setHeight(16),
                            right: ScreenUtil().setHeight(16)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setSp(16))),
                          color: appBackgroundColor,
                        ),
                        child: Column(
                          children: [
                            Text.rich(TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text:
                                      'FameLinks is a Contest. As per the rules, you can upload only ',
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      color: black,
                                      fontSize: ScreenUtil().setSp(14))),
                              TextSpan(
                                  text: 'One Post per day',
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: ScreenUtil().setSp(14),
                                      color: black)),
                              TextSpan(
                                  text: ' in FameLinks.',
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      color: black,
                                      fontSize: ScreenUtil().setSp(14))),
                            ])),
                            SizedBox(
                              height: ScreenUtil().setSp(16),
                            ),
                            Text(
                                'Please take your time till tomorrow to prepare well and showcase the best of you.',
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w300,
                                    color: black,
                                    fontStyle: FontStyle.italic,
                                    fontSize: ScreenUtil().setSp(12))),
                            InkWell(
                              onTap: () async {
                                Navigator.pop(context2);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setSp(24),
                                    bottom: ScreenUtil().setSp(12)),
                                width: ScreenUtil().setWidth(96),
                                height: ScreenUtil().setHeight(26),
                                decoration: new BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [lightRedWhite, lightRed]),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Got it',
                                      style: GoogleFonts.nunitoSans(
                                          color: white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: ScreenUtil().setSp(14)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }));
        });
    if (result != null) {
      if (result == true) {
        Provider.of<FameLinksFeedProvider>(context, listen: false)
            .changeOnPageTurning(true);
        Provider.of<FameLinksFeedProvider>(context, listen: false)
            .changeOnPageHorizontalTurning(true);
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileVideoVerificationScreen()),
        );
        if (result != null) {
          var snackBar = SnackBar(
            content: Text('Compressing'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Constants.verificationStatus = "Submitted";
          final MediaInfo? info = await VideoCompress.compressVideo(
            result,
            quality: VideoQuality.MediumQuality,
            deleteOrigin: false,
            includeAudio: true,
          );
          Constants.video = await MultipartFile.fromFile(info!.path!,
              filename: "${File(result).path.split('/').last}");
          var formData = FormData.fromMap({
            "video": Constants.video,
          });
          Api.uploadPost.call(context,
              method: "users/profile/verify",
              param: formData, onResponseSuccess: (Map object) {
            var snackBar = SnackBar(
              content: Text('Uploaded'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        }
      } else {
        Provider.of<FameLinksFeedProvider>(context, listen: false)
            .changeOnPageTurning(true);
        Provider.of<FameLinksFeedProvider>(context, listen: false)
            .changeOnPageHorizontalTurning(true);
        final result = await Navigator.push(context,
            MaterialPageRoute(builder: (context2) => UploadScreenOne()));
        if (result != null) {
          Map map = result;
          FormData formData = FormData.fromMap({
            "challengeId": map['challengeId'],
            "description": map['description'],
            "closeUp": map['closeUp'],
            "medium": map['medium'],
            "long": map['long'],
            "pose1": map['pose1'],
            "pose2": map['pose2'],
            "additional": map['additional'],
            "video": map['video'],
          });
          Api.uploadPost.call(context, method: "media/contest", param: formData,
              onResponseSuccess: (Map object) {
            var snackBar = SnackBar(
              content: Text('Uploaded'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        }
      }
    }
  }

  void showFamLinkShareDialog(
      BuildContext context, String path, String type, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          var data = Provider.of<FameLinksFeedProvider>(context, listen: false)
              .feedList[index];
          return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.only(
                left:
                    ScreenUtil().setWidth((ScreenUtil().screenWidth - 213) / 2),
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
                        Sharedynamic.shareprofile(data.id.toString(),
                            "famelinkfeed", data.description.toString());
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
                        Navigator.pop(context2);

                        Sharefiles()
                            .onShareFame(path, type, index, ind, context);
                      },
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setSp(12),
                              bottom: ScreenUtil().setSp(12)),
                          child: Text(
                              data.media![ind].type == "video"
                                  ? "Share Video"
                                  : "Share Image",
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
            }),
          );
        });
  }
}
