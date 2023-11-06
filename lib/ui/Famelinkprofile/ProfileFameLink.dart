import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:famelink/common/common_image.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/Profile_Model.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/providers/UserProfileProvider/userProfile_provider.dart';
import 'package:famelink/ui/FameChatScreen.dart';
import 'package:famelink/ui/joblinks/createJob.dart';
import 'package:famelink/ui/tour_profile/tour_FameLink.dart';
import 'package:famelink/ui/tour_profile/tour_FollowLink.dart';
import 'package:famelink/ui/tour_profile/tour_FunLink.dart';
import 'package:famelink/ui/upload/brand_upload_screen_one.dart';
import 'package:famelink/ui/upload/followlink_upload.dart';
import 'package:famelink/ui/upload/funlink_upload_one.dart';
import 'package:famelink/ui/upload/upload_screen_one.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_compress/video_compress.dart';

import '../../util/custom_snack_bar.dart';
import '../funlinks/provider/FunLinksFeedProvider.dart';
import '../otherUserProfile/component/drawer.dart';
import '../otherUserProfile/provder/OtherPofileprovider.dart';
import 'SelfprofileUi.dart';
import 'function/famelinkFun.dart';

class ProfileFameLink extends StatefulWidget {
  int? selectPhase = 0;
  var id;
  var status;

  ProfileFameLink({
    this.selectPhase,
    this.id,
    this.status,
  });

  @override
  _ProfileFameLinkState createState() => _ProfileFameLinkState();
}

final ApiProvider _api = ApiProvider();

class _ProfileFameLinkState extends State<ProfileFameLink>
    with TickerProviderStateMixin {
  final GlobalKey _menuKey = GlobalKey();

  Key key = UniqueKey();
  FameLinkFun? fameLinkFun;
  UserProfileProvider? userProfileProvider;

  bool isShowDropDown = false;
  DateTime selectedDate = DateTime.now();
  String selectDistrict = "_";
  String selectState = "_";
  String selectCountry = "_";
  String selectContinent = "_";

  MyProfileResult? upperProfileData;

  bool isShowRightButton = false;
  String selectGender = "_";

  String dropdownValue = "Individual";
  SharedPreferences? prefs;
  FunLinksFeedProvider? funLinksFeedProvider;
  // String titleWon;

  RelativeRectTween? fametransition;
  RelativeRectTween? followtransition;
  RelativeRectTween? funtransition;
  RelativeRectTween? jobtransition;
  OtherPofileprovider? otherPofileprovider;

  int fai = 1;
  int fni = 1;
  int foi = 1;

  @override
  void initState() {
    // setState(() {
    Constants.playing = false;
    // });
    otherPofileprovider =
        Provider.of<OtherPofileprovider>(context, listen: false);
    fameLinkFun = Provider.of<FameLinkFun>(context, listen: false);
    fameLinkFun!.animacon =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    fameLinkFun!.animation =
        Tween(begin: Offset(-2.0, 0.0), end: Offset(0.0, 0.0))
            .animate(fameLinkFun!.animacon.view);

    fameLinkFun!.animacon.addListener(() {
      print(fameLinkFun!.animation.value);
    });
    funLinksFeedProvider =
        Provider.of<FunLinksFeedProvider>(context, listen: false);
    userProfileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    if (fameLinkFun!.isDarkMode == true) {
      fameLinkFun!.fameDialer.add("assets/icons/followlinks1.png");
      fameLinkFun!.fameDialer.add("assets/icons/joblinks.png");
      fameLinkFun!.fameDialer.add("assets/icons/funlinks1.png");
      Constants.userType == "brand"
          ? fameLinkFun!.fameDialer.add("assets/icons/StoreLinks.png")
          : fameLinkFun!.fameDialer
              .add("assets/icons/famelinks.png"); //"assets/icons/famelinks.png"

      Constants.userType == "brand"
          ? fameLinkFun!.fameDialer.add("assets/icons/StoreLinks.png")
          : fameLinkFun!.fameDialer.add("assets/icons/famelinks.png");
      fameLinkFun!.funDialer.add("assets/icons/followlinks1.png");
      fameLinkFun!.funDialer.add("assets/icons/joblinks.png");
      fameLinkFun!.funDialer.add("assets/icons/funlinks1.png");

      fameLinkFun!.followDialer.add("assets/icons/joblinks.png");
      fameLinkFun!.followDialer.add("assets/icons/funlinks1.png");
      Constants.userType == "brand"
          ? fameLinkFun!.fameDialer.add("assets/icons/StoreLinks.png")
          : fameLinkFun!.fameDialer.add("assets/icons/famelinks.png");
      fameLinkFun!.followDialer.add("assets/icons/followlinks1.png");

      fameLinkFun!.jobDialer.add("assets/icons/funlinks1.png");
      Constants.userType == "brand"
          ? fameLinkFun!.fameDialer.add("assets/icons/StoreLinks.png")
          : fameLinkFun!.fameDialer.add("assets/icons/famelinks.png");
      fameLinkFun!.jobDialer.add("assets/icons/followlinks1.png");
      fameLinkFun!.jobDialer.add("assets/icons/joblinks.png");
    } else {
      fameLinkFun!.fameDialer.add("assets/icons/followLinks.png");
      fameLinkFun!.fameDialer.add("assets/icons/vector.png");
      fameLinkFun!.fameDialer.add("assets/icons/funLinks.png");
      Constants.userType == "brand"
          ? fameLinkFun!.fameDialer.add("assets/icons/StoreLinks.png")
          : fameLinkFun!.fameDialer.add("assets/icons/logo.png");

      Constants.userType == "brand"
          ? fameLinkFun!.funDialer.add("assets/icons/StoreLinks.png")
          : fameLinkFun!.funDialer.add("assets/icons/logo.png");
      fameLinkFun!.funDialer.add("assets/icons/followLinks.png");
      fameLinkFun!.funDialer.add("assets/icons/vector.png");
      fameLinkFun!.funDialer.add("assets/icons/funLinks.png");

      fameLinkFun!.followDialer.add("assets/icons/vector.png");
      fameLinkFun!.followDialer.add("assets/icons/funLinks.png");
      Constants.userType == "brand"
          ? fameLinkFun!.followDialer.add("assets/icons/StoreLinks.png")
          : fameLinkFun!.followDialer.add("assets/icons/logo.png");
      fameLinkFun!.followDialer.add("assets/icons/followLinks.png");

      fameLinkFun!.jobDialer.add("assets/icons/funLinks.png");
      Constants.userType == "brand"
          ? fameLinkFun!.jobDialer.add("assets/icons/StoreLinks.png")
          : fameLinkFun!.jobDialer
              .add("assets/icons/logo.png"); //assets/icons/logo.png
      fameLinkFun!.jobDialer.add("assets/icons/followLinks.png");
      fameLinkFun!.jobDialer.add("assets/icons/vector.png");
    }
    // userProfileProvider!.getProfileFameLinkslocal();
    fameLinkFun!.getProfileFameLinksData(widget.id, context, 1);
    //_profile();
    otherPofileprovider!.getProfile(context, widget.id.toString());
    userProfileProvider!.getUserProfileFollowLinks();
    //getFollowLinkProfilelocal();
    fameLinkFun!.getFollowLinkProfile(widget.id ?? fameLinkFun!.id, context, 1);

    fameLinkFun!.init(widget.id, widget.status, context);
    fameLinkFun!.controller = AnimationController(
      vsync: this,
    );
    fameLinkFun!.controller!.duration = Duration(milliseconds: 400);
    fameLinkFun!.controller!.reverseDuration = Duration(milliseconds: 400);
    fameLinkFun!.controller!.addListener(() {
      print("cercal val ${fameLinkFun!.controller!.value}");
      // setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fameLinkFun!.controller!.forward();
    });
    fameLinkFun!.selectPhase = widget.selectPhase ?? 0;

    fameLinkFun!.scrollControllerpage.addListener(() {
      if (fameLinkFun!.scrollControllerpage.position.maxScrollExtent ==
          fameLinkFun!.scrollControllerpage.offset) {
        //the bottom of the scrollbar is reached
        //adding more widgets
        //   if (fameLinkFun!.ispagination) {
        print("function call $fai $fni $foi");
        if (fameLinkFun!.selectPhase == 0) {
          if (fameLinkFun!.fameload) {
            fai++;
            fameLinkFun!
                .getProfileFameLinksData(widget.id.toString(), context, fai);
          }
        } else if (fameLinkFun!.selectPhase == 1) {
          if (fameLinkFun!.funload) {
            fni++;
            fameLinkFun!.getFunLinkProfile(widget.id, context, fni);
          }
        } else if (fameLinkFun!.selectPhase == 2) {
          if (fameLinkFun!.followload) {
            foi++;
            fameLinkFun!.getFollowLinkProfile(
                widget.id ?? fameLinkFun!.id, context, foi);
          }
        }
        // }
        print(fameLinkFun!.scrollControllerpage.position);
        //
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fameLinkFun!.famevideo.clear();
    fameLinkFun!.postsListOfFunLink.clear();
    fameLinkFun!.postsListOfFollowLink.clear();
    fameLinkFun!.fameload = true;
    fameLinkFun!.funload = true;
    fameLinkFun!.followload = true;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 3;
    final double itemHeight = itemWidth + 30;

    return KeyedSubtree(
      key: fameLinkFun!.keys,
      child: WillPopScope(
        onWillPop: () async {
          bool isDrawer = false;
          setState(() {
            if (Provider.of<UserProfileProvider>(context, listen: false)
                    .getIsDrawerOpen ==
                true) {
              Provider.of<UserProfileProvider>(context, listen: false)
                  .changeIsDrawerOpen(false);
              isDrawer = true;
            }
            if (fameLinkFun!.selectPhase == 2) {
              Provider.of<UserProfileProvider>(context, listen: false)
                  .changeIsFromProfilePage(true);
              // isFromProfilePage = true;

              Future.delayed(Duration(seconds: 1), () {
                fameLinkFun!.getFollowLinkFeed(
                    fameLinkFun!.profileFollowLinksList[0].sId!, context,
                    isPaginate: false);
              });
            }
          });

          return isDrawer == true ? false : true;
        },
        child: Consumer<UserProfileProvider>(
          builder: (context, userProfileData, child) {
            return fameLinkFun!.profileFameLInkLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.black.withOpacity(0.25),
                      //withOpacity(0.25)
                      elevation: 2,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          widget.id != null
                              ? Container()
                              : InkWell(
                                  onTap: () {
                                    if (fameLinkFun!.selectPhase == 0) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) =>
                                              TourFameLink()),
                                        ),
                                      );
                                    } else if (fameLinkFun!.selectPhase == 1) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) => TourFunLink()),
                                        ),
                                      );
                                    } else if (fameLinkFun!.selectPhase == 2) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) =>
                                              TourFollowLink()),
                                        ),
                                      );
                                    }
                                    // debugPrint("Tour Click ");
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/tourIcon.png",
                                        height: 16,
                                        width: 16,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Stack(
                                        children: [
                                          Text(
                                            "Tour",
                                            style: GoogleFonts.nunitoSans(
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic,
                                              // foreground: Paint()
                                              //   ..style = PaintingStyle.stroke
                                              //   ..strokeWidth = 6
                                              //   ..color = Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "Tour",
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 12,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                          widget.id == null ? Container() : Spacer(),
                          Center(
                            child: fameLinkFun!.selectPhase == 0 &&
                                    Constants.userType == 'brand'
                                ? Text(
                                    "@${fameLinkFun!.myFameResult[0].user![0].username ?? ' ---'}",
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white),
                                  )
                                : fameLinkFun!.profileFameLinksModelResult
                                                .result !=
                                            null &&
                                        fameLinkFun!.profileFameLinksModelResult
                                                .result!.length !=
                                            0
                                    ? Text(
                                        "@${fameLinkFun!.profileFameLinksModelResult.result![0].masterUser!.username ?? ' ___'}",
                                        style: GoogleFonts.nunitoSans(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.white),
                                      )
                                    : fameLinkFun!.selectPhase == 1 &&
                                            fameLinkFun!.profileFunLinksList !=
                                                null &&
                                            fameLinkFun!.profileFunLinksList
                                                    .length !=
                                                0
                                        ? Text(
                                            "@${fameLinkFun!.profileFunLinksList[0].masterUser!.username ?? ' ---'}",
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 14,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.white),
                                          )
                                        : fameLinkFun!.selectPhase ==
                                                    2 &&
                                                fameLinkFun!
                                                        .profileFollowLinksList !=
                                                    null &&
                                                fameLinkFun!
                                                        .profileFollowLinksList
                                                        .length !=
                                                    0
                                            ? Text(
                                                "@${fameLinkFun!.profileFollowLinksList[0].masterUser!.username ?? ' ---'}",
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize: 14,
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.white),
                                              )
                                            : Text(
                                                "---", //@pet_baby
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize: 14,
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.white),
                                              ),
                          ),
                          widget.id == null ? Container() : Spacer(),
                          widget.id != null
                              ? Container()
                              : InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FameChatScreen()));
                                  },
                                  child: Image.asset(
                                    'assets/icons/sendmessage.png',
                                    height: 20,
                                    width: 23,
                                  )),
                          widget.id != null
                              ? Container()
                              : InkWell(
                                  onTap: () {
                                    setState(() async {
                                      //async
                                      // isNavigationOn = true;
                                      funLinksFeedProvider!
                                          .changeIsNavigationOn(true);
                                      if (fameLinkFun!.selectPhase == 0) {
                                        if (Constants.userType == 'brand' ||
                                            Constants.userType == 'agency') {
                                          final result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BrandUploadScreenOne()));
                                          if (result != null) {
                                            Map map = result;
                                            FormData formData =
                                                FormData.fromMap({
                                              "name": map['name'],
                                              "price": map['price'],
                                              "description": map['description'],
                                              "purchaseUrl": map['purchaseUrl'],
                                              "buttonName": map['buttonName'],
                                              "tags": map['tags'],
                                            });
                                            if (map['closeUp'] != null) {
                                              formData.files.addAll([
                                                MapEntry("media",
                                                    await map['closeUp']),
                                              ]);
                                            }
                                            if (map['medium'] != null) {
                                              formData.files.addAll([
                                                MapEntry("media",
                                                    await map['medium']),
                                              ]);
                                            }
                                            if (map['long'] != null) {
                                              formData.files.addAll([
                                                MapEntry(
                                                    "media", await map['long']),
                                              ]);
                                            }
                                            if (map['pose1'] != null) {
                                              formData.files.addAll([
                                                MapEntry("media",
                                                    await map['pose1']),
                                              ]);
                                            }
                                            if (map['pose2'] != null) {
                                              formData.files.addAll([
                                                MapEntry("media",
                                                    await map['pose2']),
                                              ]);
                                            }
                                            if (map['additional'] != null) {
                                              formData.files.addAll([
                                                MapEntry("media",
                                                    await map['additional']),
                                              ]);
                                            }
                                            if (map['video'] != null) {
                                              var snackBar = SnackBar(
                                                content: Text('Compressing'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              final MediaInfo? info =
                                                  await VideoCompress
                                                      .compressVideo(
                                                map['video'],
                                                quality:
                                                    VideoQuality.HighestQuality,
                                                deleteOrigin: false,
                                                includeAudio: true,
                                              );
                                              await MultipartFile.fromFile(
                                                      info!.path!,
                                                      filename:
                                                          "${File(map['video']).path.split('/').last}")
                                                  .then((value) async {
                                                formData.files.addAll([
                                                  MapEntry("video", value),
                                                ]);
                                              });
                                            }
                                            Api.uploadPost.call(context,
                                                method: "users/brand/upload",
                                                param: formData,
                                                onResponseSuccess:
                                                    (Map object) {
                                              Constants.todayPosts = 1;
                                              var snackBar = SnackBar(
                                                content: Text('Uploaded'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            });
                                          }
                                        } else {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UploadScreenOne(
                                                        userProfile: true,
                                                      ))).then((value) async {
                                            if (value != null) {
                                              showSnackBar(
                                                  context: context,
                                                  message: "Uploading...",
                                                  isError: false);
                                              Map map = value;
                                              var val = await _api
                                                  .uploadFameLinksPost(
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
                                                        DateFormat(
                                                                'dd-MMM-yyyy')
                                                            .format(date));
                                                await prefs.setString(
                                                    "ambContest",
                                                    map['ambassadorTrendz']
                                                            .toString() +
                                                        "/" +
                                                        DateFormat(
                                                                'dd-MMM-yyyy')
                                                            .format(date));
                                                showSnackBar(
                                                    context: context,
                                                    message: "Uploaded",
                                                    isError: false);
                                              } else {
                                                // showSnackBar(context: context, message: "$val", isError: true);
                                              }
                                              if (Constants.userType ==
                                                  'brand') {
                                                await fameLinkFun!
                                                    .getStoreLinkProfile(
                                                        context);
                                              } else {
                                                fameLinkFun!.famePage = 0;
                                                fameLinkFun!
                                                        .getParticularUserProfileModel =
                                                    null;
                                                fameLinkFun!
                                                    .getParticularUserProfileModelResultList
                                                    .clear();
                                                fameLinkFun!.videofameController
                                                    .clear();
                                                await fameLinkFun!
                                                    .getFameLinkProfile(
                                                        widget.id ??
                                                            fameLinkFun!.id,
                                                        context);
                                                fameLinkFun!.getFameLinksFeed(
                                                    fameLinkFun!
                                                        .profileFameLinksModelResult
                                                        .result![0]
                                                        .sId!,
                                                    context,
                                                    isPaginate: false);
                                              }
                                            }
                                          });
                                        }
                                      } else if (fameLinkFun!.selectPhase ==
                                          1) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FunLinkUploadScreenOne(
                                                      userProfile: true,
                                                    ))).then((value) async {
                                          if (value != null) {
                                            Map map = value;

                                            showSnackBar(
                                                context: context,
                                                message: "Uploading...",
                                                isError: false);

                                            var result =
                                                await _api.uploadFunLink(
                                                    map['description'],
                                                    map['challengeId'],
                                                    map['song'],
                                                    map['musicName'],
                                                    map['video'],
                                                    map['audio'],
                                                    map['thumbnail'],
                                                    context,
                                                    map['profile'],
                                                    map['tags'],
                                                    map['talentCategory']);

                                            if (result == 1) {
                                              showSnackBar(
                                                  context: context,
                                                  message: "Uploaded",
                                                  isError: false);
                                              fameLinkFun!.funPage = 0;
                                              fameLinkFun!
                                                  .getParticularFunUserProfileModelResultList
                                                  .clear();
                                              fameLinkFun!.videoFunController
                                                  .clear();
                                              fameLinkFun!.getFunLinkProfile(
                                                  widget.id ?? fameLinkFun!.id,
                                                  context,
                                                  1);
                                              fameLinkFun!.getFunLinkFeed(
                                                  fameLinkFun!
                                                      .profileFunLinksList[0]
                                                      .sId!,
                                                  isPaginate: false);
                                            } else {
                                              // showSnackBar(context: context, message: "$result", isError: false);
                                            }
                                          }
                                        });
                                      } else if (fameLinkFun!.selectPhase ==
                                          2) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FollowLinkUploadScreen(
                                                      userProfile: true,
                                                    ))).then((value) async {
                                          if (value != null) {
                                            showSnackBar(
                                                context: context,
                                                message: 'Uploading...',
                                                isError: false);
                                            Map map = value;
                                            var result =
                                                await _api.uploadFollowLink(
                                                    map['description'],
                                                    map['challengeId'],
                                                    map['image'],
                                                    map['thumbnail'],
                                                    context,
                                                    map['profile'],
                                                    map['tags']);

                                            if (result == 1) {
                                              showSnackBar(
                                                  context: context!,
                                                  message: 'Uploaded',
                                                  isError: false);
                                            } else {
                                              print("ffffff");
                                            }
                                            fameLinkFun!.followPage = 0;
                                            fameLinkFun!
                                                .getParticularFollowUserProfileModelResultList
                                                .clear();
                                            fameLinkFun!.videoFollowController
                                                .clear();
                                            fameLinkFun!.getFollowLinkProfile(
                                                widget.id ?? fameLinkFun!.id,
                                                context,
                                                1);
                                            fameLinkFun!.getFollowLinkFeed(
                                                fameLinkFun!
                                                    .profileFollowLinksList[0]
                                                    .sId!,
                                                context,
                                                isPaginate: false);
                                          }
                                        });
                                      } else if (fameLinkFun!.selectPhase ==
                                          3) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CreateJob()));
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: Image.asset(
                                        "assets/icons/plusIcon.png"),
                                  ),
                                )
                        ],
                      ),
                      actions: [
                        widget.id == null
                            ? Container()
                            : InkWell(
                                onTap: () {
                                  Share.share(
                                    '"Hey buddy,\nI am on BudLinks App, where we can participate in Worldwide Beauty Contests, right from the comfort of our homes. I recommend you too to download and join me on FameLinks.\n${ApiProvider.shareUrl}profile/agency/${fameLinkFun!.profileFameLinksModelResult.result![0].masterUser!.sId}',
                                  );
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(right: 12.w, left: 15.w),
                                  child: Image.asset(
                                    "assets/images/share.png",
                                    height: 22,
                                    width: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                      ],
                      leading: InkWell(
                        onTap: () {
                          // setState(() {
                          if (fameLinkFun!.selectPhase == 2) {
                            Provider.of<UserProfileProvider>(context,
                                    listen: false)
                                .changeIsFromProfilePage(true);
                            // dataFollowLink.clear();
                          }

                          if (Provider.of<UserProfileProvider>(context,
                                      listen: false)
                                  .getIsDrawerOpen ==
                              true) {
                            Provider.of<UserProfileProvider>(context,
                                    listen: false)
                                .changeIsDrawerOpen(false);
                          } else {
                            Navigator.of(context).pop();
                          }
                          funLinksFeedProvider!.changeIsNavigationOn(false);
                          // isNavigationOn = false;
                          // });
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    body: RefreshIndicator(
                      onRefresh: () async {
                        // dataFameLink.clear();
                        //page = 1;
                        if (fameLinkFun!.selectPhase == 0) {
                          if (Constants.userType == 'brand') {
                            return await fameLinkFun!
                                .getStoreLinkProfile(context);
                          } else {
                            fameLinkFun!.getParticularUserProfileModel = null;
                            fameLinkFun!.getParticularUserProfileModelResultList
                                .clear();
                            fameLinkFun!.videofameController.clear();
                            fameLinkFun!.famePage = 0;
                            await fameLinkFun!.getFameLinkProfile(
                                widget.id ?? fameLinkFun!.id, context);
                            return fameLinkFun!.getFameLinksFeed(
                                fameLinkFun!.profileFameLinksModelResult
                                    .result![0].sId!,
                                context,
                                isPaginate: false);
                          }
                        } else if (fameLinkFun!.selectPhase == 1) {
                          fameLinkFun!
                              .getParticularFunUserProfileModelResultList
                              .clear();
                          fameLinkFun!.videoFunController.clear();
                          fameLinkFun!.getFunLinkProfile(
                              widget.id ?? fameLinkFun!.id, context, 1);
                          return fameLinkFun!.getFunLinkFeed(
                              fameLinkFun!.profileFunLinksList[0].sId!,
                              isPaginate: false);
                        } else if (fameLinkFun!.selectPhase == 2) {
                          fameLinkFun!
                              .getParticularFollowUserProfileModelResultList
                              .clear();
                          fameLinkFun!.videoFollowController.clear();
                          fameLinkFun!.getFollowLinkProfile(
                              widget.id ?? fameLinkFun!.id, context, 1);
                          return fameLinkFun!.getFollowLinkFeed(
                              fameLinkFun!.profileFollowLinksList[0].sId!,
                              context,
                              isPaginate: false);
                        }
                      },
                      child: fameLinkFun!.profileFameLInkLoading == true
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : SafeArea(
                              child: Provider.of<UserProfileProvider>(context,
                                              listen: false)
                                          .getIsDrawerOpen ==
                                      true
                                  ? Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  CommonImage.dart_back_img),
                                              alignment: Alignment.center,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          height: ScreenUtil().screenHeight,
                                          width: ScreenUtil().screenWidth,
                                        ),
                                        SlideTransition(
                                            position: fameLinkFun!.animation,
                                            child: DrawerPage()),
                                        Container(
                                            transform:
                                                Matrix4.translationValues(
                                                    fameLinkFun!.xOffset, 0, 0),
                                            height: ScreenUtil().screenHeight,
                                            width: ScreenUtil().screenWidth,
                                            child: SelfprofileUi(
                                              //   userProfileData: userProfileData,
                                              itemHeight: itemHeight,
                                              status: widget.status.toString(),
                                              id: widget.id.toString(),
                                              itemWidth: itemWidth,
                                            ))
                                      ],
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              CommonImage.dart_back_img),
                                          alignment: Alignment.center,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      height: ScreenUtil().screenHeight,
                                      width: ScreenUtil().screenWidth,
                                      child: SelfprofileUi(
                                        //  userProfileData: userProfileData,
                                        itemHeight: itemHeight,
                                        status: widget.status.toString(),
                                        id: widget.id.toString(),
                                        itemWidth: itemWidth,
                                      )),
                            ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  // followLinks

  // storeLinks
  Widget storeLinksWidget() => Container(
        child: Text("storeLinksWidget"),
      );

  @override
  void onPlayingChange(bool isPlaying) {
    // TODO: implement onPlayingChange
  }

  @override
  void onProfileClick() {
    // TODO: implement onProfileClick
  }
}
