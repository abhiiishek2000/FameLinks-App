import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:famelink/databse/AppDatabase.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/main.dart';
import 'package:famelink/models/ChallengeSlider.dart';
import 'package:famelink/models/OpenChallengesResponse.dart';
import 'package:famelink/models/store_model.dart';
import 'package:famelink/models/upcoming_challenges_model.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/challenge/ChallengeFameLinkFullPostScreen.dart';
import 'package:famelink/ui/funlinks/FameLinksChallengeScreen.dart';
import 'package:famelink/ui/funlinks/FunLinksChallengeScreen.dart';
import 'package:famelink/ui/settings/WebViewScreenUrl.dart';
import 'package:famelink/ui/settings/profile_verification_screen.dart';
import 'package:famelink/ui/upload/brand_upload_edit_screen.dart';
import 'package:famelink/ui/upload/funlink_upload_one.dart';
import 'package:famelink/ui/upload/upload_screen_one.dart';
import 'package:famelink/util/ReadMoreText.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:famelink/models/famelinks_model.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:video_compress/video_compress.dart';

class BrandDetailsScreen extends StatefulWidget {
  Store? myFameResult;
  int index;
  int page;
  String postImageBaseUrl;
  String brandId;
  bool isOther;

  BrandDetailsScreen(this.myFameResult, this.index, this.page, this.brandId,
      this.postImageBaseUrl, this.isOther);

  @override
  _BrandDetailsScreenState createState() => _BrandDetailsScreenState();
}

void printHello() {
  FlutterLocalNotificationsPlugin().show(
      456,
      "Challenge Started",
      "",
      NotificationDetails(
        android: AndroidNotificationDetails("4563", "channelName",
            playSound: true,
            enableVibration: true,
            importance: Importance.max,
            priority: Priority.high
            // other properties...
            ),
      ));
}

class _BrandDetailsScreenState extends State<BrandDetailsScreen> {
  // List<BannerImage> openChallengesBanner = [];
  // List<BannerImage> upcomingChallengesBanner = [];
  PageController pageController = PageController(keepPage: true);
  final GlobalKey<FormState> _profileKey = GlobalKey<FormState>();
  String ageGroup = 'groupE';
  int endTime = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.brandId != null) {
      Map<String, dynamic> map = {"page": "1"};
      Api.get.call(context,
          method: "users/brand/${widget.brandId}/products",
          param: map,
          isLoading: false, onResponseSuccess: (Map<dynamic,dynamic> object) async {
        var result = StoreModel.fromJson(object);
        if (result.result!.length > 0) {
          widget.myFameResult = result.result!.elementAt(0);
          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    final double itemHeight = itemWidth + 30;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            widget.myFameResult != null
                ? Container(
                    width: ScreenUtil().screenWidth,
                    height: ScreenUtil().setHeight(468),
                    child: Stack(
                      children: [
                        CarouselSlider(
                            items: widget.myFameResult!.images!.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  if (i.type == "video") {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: appBackgroundColor),
                                        child: Stack(
                                          children: [
                                            Container(
                                                color: lightGray,
                                                child: Center(
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        "${widget.postImageBaseUrl}/${i.path}-sm",
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                            Center(
                                              child: Container(
                                                height: ScreenUtil()
                                                    .setHeight(32.94),
                                                width:
                                                    ScreenUtil().setWidth(40),
                                                decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            ScreenUtil()
                                                                .radius(5)))),
                                                child: Icon(
                                                  Icons.play_arrow,
                                                  color: black,
                                                ),
                                              ),
                                            )
                                          ],
                                        ));
                                  } else {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: appBackgroundColor),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "${widget.postImageBaseUrl}/${i.path}",
                                          fit: BoxFit.cover,
                                        ));
                                  }
                                },
                              );
                            }).toList(),
                            options: CarouselOptions(
                              height: ScreenUtil().setHeight(468),
                              aspectRatio: 16 / 9,
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  pageController = PageController(
                                      keepPage: true, initialPage: index);
                                });
                                // if (!openChallengesBanner
                                //     .elementAt(index)
                                //     .isImpression) {
                                //   _addChallengeImpression(
                                //       openChallengesBanner.elementAt(index).id,
                                //       index);
                                // }
                              },
                              scrollDirection: Axis.horizontal,
                            )),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: ScreenUtil().setHeight(10)),
                            child: SmoothPageIndicator(
                              controller: pageController,
                              count: widget.myFameResult!.images!.length,
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
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              AppBar(
                                iconTheme: IconThemeData(color: black),
                                backgroundColor: Colors.white24,
                                elevation: 0,
                                actions: [
                                  IconButton(
                                      onPressed: () {
                                        Share.share(
                                          '${ApiProvider.shareUrl}brand/product/${widget.myFameResult!.sId}',
                                        );
                                      },
                                      icon: Icon(
                                        Icons.share_outlined,
                                        color: black,
                                      )),
                                ],
                              ),
                              Visibility(
                                visible: !widget.isOther,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                      onPressed: () async {
                                        final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BrandUploadEditScreen(
                                                        myFameResult: widget
                                                            .myFameResult)));
                                        if (result != null) {
                                          Map map = result;
                                          Navigator.pop(context, map);
                                        }
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: black,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            widget.myFameResult != null
                ? Padding(
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setSp(24),
                        right: ScreenUtil().setSp(24)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text("${widget.myFameResult!.name}",
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(18),
                                      fontWeight: FontWeight.w600,
                                      color: black)),
                            ),
                            Text("Rs. ${widget.myFameResult!.price}",
                                style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(14),
                                    fontWeight: FontWeight.w600,
                                    color: black)),
                            SizedBox(
                              width: ScreenUtil().setSp(10),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(20),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsetsGeometry>(
                                            EdgeInsets.only(left: 0, right: 0)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            buttonBlue),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            side:
                                                BorderSide(color: buttonBlue)))),
                                child: Text(
                                  widget.isOther
                                      ? "${widget.myFameResult!.buttonName}"
                                      : "Promote",
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: ScreenUtil().setSp(12),
                                      color: white),
                                ),
                                onPressed: () async {
                                  print('ppppp');
                                  if (widget.isOther) {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              WebViewScreenUrl(
                                                  widget.myFameResult!.name!,
                                                  widget.myFameResult!
                                                      .purchaseUrl!)),
                                    );
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        ReadMoreText(
                          '${widget.myFameResult!.description}',
                          trimLines: 4,
                          trimMode: TrimMode.Line,
                          style: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w400,
                              color: black),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(12),
                        ),
                        Divider(
                          thickness: 1,
                          height: 1,
                          color: lightGray,
                        )
                      ],
                    ),
                  )
                : Container(),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            widget.myFameResult != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: ScreenUtil().setSp(24),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tags by user of Prosche',
                                    style: GoogleFonts.nunitoSans(
                                        color: black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(14))),
                              ],
                            ),
                          ),
                        ],
                      ),
                      /*Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setSp(24)),
                  height: ScreenUtil().setHeight(135),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.openChallengesResult.posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      var size = MediaQuery
                          .of(context)
                          .size;
                      final double itemWidth = size.width / 4;
                      Result result =
                      widget.openChallengesResult.posts[index];
                      String post = "";
                      bool isVideo = false;
                      if (result.images.length > 0) {
                        Media postMedia = result.images[0];
                        post = postMedia.path;
                        if (postMedia.type == "video") {
                          isVideo = true;
                        }
                      }
                      if (result.images != null) {
                              for (int i = 0; i < result.images.length; i++) {
                                Media postMedia = result.images[i];
                                if (i == 0 && postMedia.path != null) {
                                  post = postMedia.path;
                                } else if (i == 1 && postMedia.path != null) {
                                  post = postMedia.path;
                                } else if (i == 2 && postMedia.path != null) {
                                  post = postMedia.path;
                                } else if (i == 3 && postMedia.path != null) {
                                  post = postMedia.path;
                                } else if (i == 4 && postMedia.path != null) {
                                  post = postMedia.path;
                                } else if (i == 5 && postMedia.path != null) {
                                  post = postMedia.path;
                                } else if (i == 6 && postMedia.path != null) {
                                  isVideo = true;
                                  post = postMedia.path;
                                }
                              }
                            }
                      return InkWell(
                        onTap: () {
                          ChallengesModelData challengesModelData =
                          ChallengesModelData(
                              id: "",
                              challengeId:
                              widget.openChallengesResult.sId,
                              challengeName:
                              widget.openChallengesResult.name,
                              postId: "");
                          if (widget.openChallengesResult.type ==
                              "famelinks") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ontext) =>
                                      ChallengeFameLinkFullPostScreen(
                                          widget.openChallengesResult.posts,
                                          index,
                                          1,
                                          widget.openChallengesResult.sId,
                                          widget
                                              .openChallengesResult.type)),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FunLinksChallengeScreen(
                                          challengesModelData, "")),
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setSp(3),
                              bottom: ScreenUtil().setSp(4),
                              left: ScreenUtil().setSp(2),
                              right: ScreenUtil().setSp(2)),
                          child: Column(
                            children: [
                              Container(
                                width: itemWidth,
                                height: ScreenUtil().setHeight(107),
                                child: isVideo
                                    ? Stack(
                                  children: [
                                    Image.network(
                                      '${widget.openChallengesResult.type ==
                                          "famelinks" ? ApiProvider
                                          .postImageBaseUrl : ApiProvider
                                          .funPostImageBaseUrl}/${post}-sm',
                                      fit: BoxFit.cover,
                                      width: itemWidth,
                                      height: itemHeight,
                                    ),
                                    Center(
                                      child: Container(
                                        height:
                                        ScreenUtil().setHeight(32.94),
                                        width: ScreenUtil().setWidth(40),
                                        decoration: BoxDecoration(
                                            color: Colors.white
                                                .withOpacity(0.5),
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(
                                                    ScreenUtil()
                                                        .radius(5)))),
                                        child: Icon(
                                          Icons.play_arrow,
                                          color: black,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                                    : Image.network(
                                  '${widget.openChallengesResult.type ==
                                      "famelinks"
                                      ? ApiProvider.postImageBaseUrl
                                      : ApiProvider
                                      .funPostImageBaseUrl}/${post}-sm',
                                  fit: BoxFit.cover,
                                  width: itemWidth,
                                  height: ScreenUtil().setHeight(107),
                                ),
                              ),
                              Text(
                                "Patricia Kuli", style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: ScreenUtil().setSp(12),
                                  color: black),)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),*/
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

/*void _openChallengesSlider() async {
    Api.get.call(context, method: "challenges/open/slider", param: {},
        onResponseSuccess: (Map object) {
      var result = ChallengeSlider.fromJson(object);
      openChallengesBanner = result.result;
      setState(() {});
      if (openChallengesBanner.length > 0) {
        _addChallengeImpression(openChallengesBanner.elementAt(0).id, 0);
      }
    });
  }

  void _addChallengeImpression(String id, int index) async {
    Api.put.call(context,
        method: "challenges/${id}/impressions",
        param: {"impressions": "1"},
        isLoading: false, onResponseSuccess: (Map object) {
      openChallengesBanner.elementAt(index).isImpression = true;
    });
  }

  void _addUpcomingChallengeImpression(String id, int index) async {
    Api.put.call(context,
        method: "challenges/${id}/impressions",
        param: {"impressions": "1"},
        isLoading: false, onResponseSuccess: (Map object) {
      upcomingChallengesBanner.elementAt(index).isImpression = true;
    });
  }

  void _upcomingChallengesSlider() async {
    Api.get.call(context, method: "challenges/upcoming/slider", param: {},
        onResponseSuccess: (Map object) {
      var result = ChallengeSlider.fromJson(object);
      upcomingChallengesBanner = result.result;
      setState(() {});
      if (upcomingChallengesBanner.length > 0) {
        _addUpcomingChallengeImpression(
            upcomingChallengesBanner.elementAt(0).id, 0);
      }
    });
  }*/
}

String convertToAgo(DateTime input) {
  Duration diff = DateTime.now().difference(input);

  if (diff.inDays >= 1) {
    return '${diff.inDays} d ago';
  } else if (diff.inHours >= 1) {
    return '${diff.inHours} hr ago';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes} mins ago';
  } else if (diff.inSeconds >= 1) {
    return '${diff.inSeconds} sec ago';
  } else {
    return 'just now';
  }
}
