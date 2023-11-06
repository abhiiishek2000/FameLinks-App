import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/CommentAddResponse.dart';
import 'package:famelink/models/CommentListResponse.dart';
import 'package:famelink/models/famelinks_model.dart';
import 'package:famelink/models/userUpdateResponse.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/profile/agency_other_profile_screen.dart';
import 'package:famelink/ui/profile/agency_profile_screen.dart';
import 'package:famelink/ui/profile/brand_other_profile_screen.dart';
import 'package:famelink/ui/profile/brand_profile_screen.dart';
import 'package:famelink/ui/profile/other_profile_screen.dart';
import 'package:famelink/ui/profile/profile_screen.dart';
import 'package:famelink/util/ReadMoreText.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/config/image.dart';
import 'package:famelink/util/constants.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../util/widgets/FeedVideoPlayer.dart';

class ChallengeFameLinkFullPostScreen extends StatefulWidget {
  List<Result> myFameResult;
  int index;
  int page;
  String challengeId;
  String type;

  ChallengeFameLinkFullPostScreen(
      this.myFameResult, this.index, this.page, this.challengeId, this.type);

  @override
  _ChallengeFameLinkFullPostScreenState createState() =>
      _ChallengeFameLinkFullPostScreenState();
}

class _ChallengeFameLinkFullPostScreenState
    extends State<ChallengeFameLinkFullPostScreen>
    with TickerProviderStateMixin {
  int index = 0;
  int ind = 0;
  final ApiProvider _api = ApiProvider();
  //final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  List<Comment> commentList = [];
  List<Comment> commentRepliesList = [];
  TextEditingController replayController = new TextEditingController();
  TextEditingController commentController = new TextEditingController();
  TextEditingController reportCommentController = new TextEditingController();
  TextEditingController reportPostController = new TextEditingController();
  var focusNode = FocusNode();
  bool _commentValidate = false;
  String _singleValue = "";
  String _postSingleValue = "";
  bool visibilityTag = false;
  String? mediaId;
  int current = 0;
  int currentHorizontal = 1;
  bool isOnPageTurning = false;
  bool isOnPageHorizontalTurning = false;
  PageController? pageController;
  int page = 1;
  final GlobalKey<FormState> _reportKey = GlobalKey<FormState>();
  bool isEdit = false;
  //final FlutterFFmpeg _flutterFFmpeg = new FlutterFFmpeg();

  CommentResult? commentResult;

  bool _isPlaying = true;
  ScrollController commentScrollController = ScrollController();
  ScrollController commentRepliesScrollController = ScrollController();
  int commentPage = 1;
  int commentRepliesPage = 1;
  String? commentId;
  String commentType = "";

  PageController? smoothPageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = widget.page;
    index = widget.index;
    current = widget.index;
    smoothPageController = PageController(
        keepPage: true,
        initialPage: widget.myFameResult[index].images!.length > 1 &&
                widget.myFameResult[index].images!.elementAt(0).type == "video"
            ? 1
            : 0);
    pageController = PageController(
        initialPage: widget.index, keepPage: true, viewportFraction: 1);
    pageController!.addListener(scrollListener);
    mediaId = widget.myFameResult[widget.index].sId;
    commentScrollController.addListener(() {
      if (commentScrollController.position.maxScrollExtent ==
          commentScrollController.position.pixels) {
        commentPage++;
        Map<String, String> map = {"page": commentPage.toString()};
        Api.get.call(context,
            method: "media/${commentType}/comment/${mediaId}",
            param: map,
            isLoading: false, onResponseSuccess: (Map object) {
          var result = CommentListResponse.fromJson(object);
          if (result.result!.data!.length > 0) {
            setState(() {
              commentResult = result.result;
              commentList = result.result!.data!;
            });
          } else {
            commentPage--;
          }
        });
      }
    });
    commentRepliesScrollController.addListener(() {
      if (commentRepliesScrollController.position.maxScrollExtent ==
          commentRepliesScrollController.position.pixels) {
        commentRepliesPage++;
        Map<String, String> map = {"page": commentRepliesPage.toString()};
        Api.get.call(context,
            method: "media/$commentType/comment/$commentId/replies",
            param: map,
            isLoading: false, onResponseSuccess: (Map object) {
          var result = CommentListResponse.fromJson(object);
          if (result.result!.data!.length > 0) {
            setState(() {
              commentResult = result.result!;
              commentRepliesList = result.result!.data!;
            });
          } else {
            commentRepliesPage--;
          }
        });
      }
    });
  }

  void scrollListener() {
    if (isOnPageTurning &&
        pageController!.page == pageController!.page!.roundToDouble()) {
      setState(() {
        current = pageController!.page!.toInt();
        isOnPageTurning = false;
      });
    } else if (!isOnPageTurning && current.toDouble() != pageController!.page) {
      if ((current.toDouble() - pageController!.page!).abs() > 0.1) {
        setState(() {
          isOnPageTurning = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          PageView.builder(
            physics: PageScrollPhysics(),
            controller: pageController,
            scrollDirection: Axis.vertical,
            allowImplicitScrolling: true,
            pageSnapping: true,
            itemCount: widget.myFameResult.length,
            itemBuilder: (context, index) {
              Result resultModel = widget.myFameResult[index];
              PageController famePageController;
              famePageController = PageController(
                  keepPage: true,
                  initialPage: resultModel.images!.length > 1 &&
                          resultModel.images!.elementAt(0).type == "video"
                      ? 1
                      : 0);
              famePageController.addListener(() {
                if (isOnPageHorizontalTurning &&
                    famePageController.page ==
                        famePageController.page!.roundToDouble()) {
                  setState(() {
                    currentHorizontal = famePageController.page!.toInt();
                    isOnPageHorizontalTurning = false;
                  });
                } else if (!isOnPageHorizontalTurning &&
                    currentHorizontal.toDouble() != famePageController.page) {
                  if ((currentHorizontal.toDouble() - famePageController.page!)
                          .abs() >
                      0.1) {
                    setState(() {
                      isOnPageHorizontalTurning = true;
                    });
                  }
                }
              });
              return Container(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenHeight,
                child: PageView.builder(
                  pageSnapping: true,
                  controller: famePageController,
                  scrollDirection: Axis.horizontal,
                  allowImplicitScrolling: true,
                  physics: PageScrollPhysics(),
                  itemCount: resultModel.images!.length,
                  itemBuilder: (horizontalContext, ind) {
                    Media mediaModelData = resultModel.images![ind];
                    print(
                        "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${mediaModelData.path}");
                    return Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: mediaModelData.type == "video"
                                ? Stack(
                                    children: [
                                      GestureDetector(
                                        onLongPressUp: () {
                                          setState(() {
                                            isOnPageTurning = false;
                                            isOnPageHorizontalTurning = false;
                                          });
                                        },
                                        onLongPress: () {
                                          setState(() {
                                            isOnPageTurning = true;
                                            isOnPageHorizontalTurning = true;
                                          });
                                        },
                                        onTap: () {
                                          setState(() {
                                            if (visibilityTag) {
                                              visibilityTag = false;
                                            }
                                          });
                                        },
                                        child: FeedVideoPlayer(
                                            videoUrl: widget.type == "famelinks"
                                                ? "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${mediaModelData.path!}"
                                                : "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${mediaModelData.path!}"),
                                      ),
                                    ],
                                  )
                                : InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (visibilityTag) {
                                          visibilityTag = false;
                                        }
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl:
                                              '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${mediaModelData.path}',
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error, color: white),
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (visibilityTag) {
                                                visibilityTag = false;
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                  Colors.transparent,
                                                  Colors.black.withOpacity(0.15)
                                                ])),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (visibilityTag) {
                                                visibilityTag = false;
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Colors.black
                                                          .withOpacity(0.15),
                                                      Colors.transparent,
                                                      Colors.transparent,
                                                      Colors.transparent
                                                    ],
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomRight,
                                                    stops: [0, 0.2, 0.8, 1])),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    );
                  },
                  onPageChanged: (value) async {
                    setState(() {
                      this.ind = value;
                      smoothPageController =
                          PageController(keepPage: true, initialPage: value);
                      // _getCommentData();
                    });
                  },
                ),
              );
            },
            onPageChanged: (value) {
              setState(() {
                mediaId = widget.myFameResult[value].sId!;
                // if(ApiProvider.likeStatus!=fameResult[value].contest.images[0].likeStatus){
                //   ApiProvider.likeStatus=4;
                // }
                this.index = value;
                this.ind = widget.myFameResult[value].images!.length > 1 &&
                        widget.myFameResult[value].images!.elementAt(0).type ==
                            "video"
                    ? 1
                    : 0;
                this.currentHorizontal = 1;
                this.isOnPageHorizontalTurning = false;
                smoothPageController = PageController(
                    keepPage: true,
                    initialPage:
                        widget.myFameResult[value].images!.length > 1 &&
                                widget.myFameResult[value].images!
                                        .elementAt(0)
                                        .type ==
                                    "video"
                            ? 1
                            : 0);
                if (value == widget.myFameResult.length - 1) {
                  page++;
                  _myFamelinks();
                }
                // _getCommentData();
              });
            },
          ),
          Padding(
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(40),
                left: ScreenUtil().setWidth(20)),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: white.withOpacity(0.5))),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(40),
                right: ScreenUtil().setWidth(20)),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  Visibility(
                    visible: Constants.userId ==
                        widget.myFameResult[index].user!.sId,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            isEdit = true;
                          });
                        },
                        icon: SvgPicture.asset("assets/icons/svg/edit.svg")),
                  ),
                  Visibility(
                    visible: isEdit,
                    child: IconButton(
                        onPressed: () async {
                          Api.delete.call(context,
                              method:
                                  "media/famelinks/${mediaId}/${widget.myFameResult[index].images![ind].type}",
                              param: {},
                              isLoading: false,
                              onResponseSuccess: (Map object) {
                            setState(() {
                              widget.myFameResult[index].images!.removeAt(ind);
                            });
                          });
                        },
                        icon: SvgPicture.asset("assets/icons/svg/delete.svg")),
                  ),
                  Visibility(
                    visible: Constants.userId !=
                        widget.myFameResult[index].user!.sId,
                    child: IconButton(
                        onPressed: () async {
                          setState(() {
                            isOnPageTurning = true;
                            isOnPageHorizontalTurning = true;
                          });
                          showReportPostDialog(
                              widget.myFameResult[index].user!.sId!,
                              widget.myFameResult[index].sId!,
                              false);
                        },
                        icon: Image.asset(
                          "assets/images/more.png",
                          color: white,
                        )),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                      index >= 0
                          ? '${widget.myFameResult[index].challenges!.length > 0 ? widget.myFameResult[index].challenges![0].hashTag : ''}'
                          : "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w500, color: white)),
                  SizedBox(
                    height: ScreenUtil().setSp(10),
                  ),
                  SmoothPageIndicator(
                    controller: smoothPageController!,
                    count: widget.myFameResult[index].images!.length,
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
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Wrap(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      bottom: ScreenUtil().setHeight(99),
                      right: ScreenUtil().setWidth(32)),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          if (index >= 0 &&
                              widget.myFameResult[index].likeStatus != 2) {
                            likeHeart(2, 2, widget.myFameResult[index]);
                          } else {
                            likeHeart(null, 2, widget.myFameResult[index]);
                          }
                        },
                        child: SvgPicture.asset(fullheart,
                            color: index >= 0 &&
                                    widget.myFameResult[index].likeStatus == 2
                                ? lightRed
                                : Colors.white),
                      ),
                      SizedBox(
                        height: index >= 0 &&
                                widget.myFameResult[index].likeStatus != null
                            ? ScreenUtil().setHeight(2)
                            : ScreenUtil().setHeight(4),
                      ),
                      Visibility(
                        visible: index >= 0 &&
                            widget.myFameResult[index].likeStatus != null,
                        child: Text(
                          index >= 0 &&
                                  widget.myFameResult[index].likes2Count != null
                              ? "${NumberFormat.compactCurrency(
                                  decimalDigits: 0,
                                  symbol:
                                      '', // if you want to add currency symbol then pass that in this else leave it empty.
                                ).format(widget.myFameResult[index].likes2Count)}"
                              : "",
                          style: GoogleFonts.nunitoSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenUtil().setSp(10)),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(7),
                      ),
                      InkWell(
                        onTap: () {
                          if (index >= 0 &&
                              widget.myFameResult[index].likeStatus != 1) {
                            likeHeart(1, 1, widget.myFameResult[index]);
                          } else {
                            likeHeart(null, 1, widget.myFameResult[index]);
                          }
                        },
                        child: SvgPicture.asset(halfheart,
                            color: index >= 0 &&
                                    widget.myFameResult[index].likeStatus == 1
                                ? lightRed
                                : Colors.white),
                      ),
                      SizedBox(
                        height: index >= 0 &&
                                widget.myFameResult[index].likeStatus != null
                            ? ScreenUtil().setHeight(2)
                            : ScreenUtil().setHeight(4),
                      ),
                      Text(
                        index >= 0 &&
                                widget.myFameResult[index].likes1Count != null
                            ? "${NumberFormat.compactCurrency(
                                decimalDigits: 0,
                                symbol:
                                    '', // if you want to add currency symbol then pass that in this else leave it empty.
                              ).format(widget.myFameResult[index].likes1Count)}"
                            : "",
                        style: GoogleFonts.nunitoSans(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(10)),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(7),
                      ),
                      InkWell(
                        onTap: () {
                          if (index >= 0 &&
                              widget.myFameResult[index].likeStatus != 0) {
                            likeHeart(0, 0, widget.myFameResult[index]);
                          } else {
                            likeHeart(null, 0, widget.myFameResult[index]);
                          }
                        },
                        child: SvgPicture.asset(emptyheart,
                            color: index >= 0 &&
                                    widget.myFameResult[index].likeStatus == 0
                                ? lightRed
                                : Colors.white),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(2),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: visibilityTag,
                  child: index >= 0
                      ? infoCard(index, widget.myFameResult)
                      : Container(),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: ScreenUtil().setSp(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(22),
                        ),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                visibilityTag == false
                                    ? visibilityTag = true
                                    : visibilityTag = false;
                              });
                              // infoCard(index, data.data);
                            },
                            child: SvgPicture.asset(visibilityTag == false
                                ? "assets/icons/svg/info.svg"
                                : "assets/icons/svg/info_select.svg")),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(8),
                      ),
                      Visibility(
                        visible: !visibilityTag,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              visibilityTag == false
                                  ? visibilityTag = true
                                  : visibilityTag = false;
                            });
                            // infoCard(index, data.data);
                          },
                          child: Text(
                            index >= 0 &&
                                    widget.myFameResult[index].user!.name! !=
                                        null
                                ? widget.myFameResult[index].user!.name!
                                : "",
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(16),
                                color: white),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: visibilityTag,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: widget.myFameResult[index].description !=
                                          null &&
                                      widget.myFameResult[index].description!
                                          .isNotEmpty
                                  ? ScreenUtil().setWidth(200)
                                  : 0,
                              child: ReadMoreText(
                                widget.myFameResult[index].description! == null
                                    ? ''
                                    : widget.myFameResult[index].description!,
                                trimLines: 3,
                                trimMode: TrimMode.Line,
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    color: white,
                                    fontSize: ScreenUtil().setSp(10)),
                              ),
                            ),
                            Text(
                              convertToAgo(DateTime.parse(
                                  widget.myFameResult[index].createdAt!)),
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w400,
                                  color: lightRed,
                                  fontSize: ScreenUtil().setSp(10)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(8),
                      ),
                      Visibility(
                        visible: !visibilityTag &&
                            Constants.userId !=
                                widget.myFameResult[index].user!.sId &&
                            widget.myFameResult[index].followStatus == false,
                        child: SizedBox(
                          height: ScreenUtil().setHeight(22),
                          child: ElevatedButton(
                            onPressed: () {
                              widget.myFameResult[index].followStatus == false
                                  ? follow(
                                      widget.myFameResult[index].user!.sId!)
                                  : unfollow(
                                      widget.myFameResult[index].user!.sId!);
                              //widget.myFameResult[index].followStatus == !widget.myFameResult[index].followStatus;
                            },
                            child: Text(
                              widget.myFameResult[index].followStatus == false
                                  ? 'Follow'
                                  : 'Unfollow',
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w400,
                                  color: white,
                                  fontSize: ScreenUtil().setSp(12)),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.only(
                                          topRight: Radius.circular(
                                              ScreenUtil().radius(0)),
                                          topLeft: Radius.circular(
                                              ScreenUtil().radius(10)),
                                          bottomLeft: Radius.circular(
                                              ScreenUtil().radius(0)),
                                          bottomRight: Radius.circular(
                                              ScreenUtil().radius(10))),
                                      side: BorderSide(
                                        color: Colors.white.withOpacity(0.75),
                                      ))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        setState(() {
                          isOnPageTurning = true;
                          isOnPageHorizontalTurning = true;
                        });
                        commentPage = 1;
                        commentType = widget.type;
                        Map<String, String> map = {
                          "page": commentPage.toString()
                        };
                        Api.get.call(context,
                            method: "media/${commentType}/comment/${mediaId}",
                            param: map, onResponseSuccess: (Map object) {
                          var result = CommentListResponse.fromJson(object);
                          setState(() {
                            commentResult = result.result!;
                            commentList = result.result!.data!;
                          });
                          showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20))),
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setStates) {
                                  return buildSheet(context, setStates);
                                });
                              });
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                        child: SvgPicture.asset("assets/icons/svg/comment.svg",
                            color: white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(5),
                          bottom: ScreenUtil().setHeight(10)),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: SvgPicture.asset("assets/icons/svg/share.svg",
                            color: white),
                        onPressed: () {
                          setState(() {
                            isOnPageTurning = true;
                            isOnPageHorizontalTurning = true;
                          });
                          if (index >= 0) {
                            widget.myFameResult[index].images![ind].path!
                                    .isEmpty
                                ? null
                                : showFamLinkShareDialog(
                                    context,
                                    widget.myFameResult[index].sId!,
                                    widget.myFameResult[index].images![ind]);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoCard(index, List<Result> data) {
    return Container(
      margin: EdgeInsets.only(
        left: ScreenUtil().setWidth(8),
        bottom: ScreenUtil().setHeight(10),
      ),
      color: Colors.transparent,
      width: ScreenUtil().setWidth(266),
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: Constants.userId != data[index].user!.sId &&
                        data[index].followStatus == false
                    ? ScreenUtil().setWidth(0)
                    : ScreenUtil().setWidth(49)),
            child: Text(
              '${data[index].winnerTitles!.length == 1 ? data[index].winnerTitles!.elementAt(0) : data[index].winnerTitles!.length == 2 ? "${data[index].winnerTitles!.elementAt(0)}, ${data[index].winnerTitles!.elementAt(1)}" : ""}',
              style: GoogleFonts.play(
                  fontWeight: FontWeight.w400,
                  color: white,
                  fontSize: ScreenUtil().setSp(14)),
            ),
          ),
          Visibility(
            visible: Constants.userId != data[index].user!.sId &&
                data[index].followStatus == false,
            child: InkWell(
              onTap: () {
                setState(() {
                  isOnPageTurning = true;
                  isOnPageHorizontalTurning = true;
                });
                Constants.profileUserId = data[index].user!.sId;
                if (Constants.userId == Constants.profileUserId) {
                  if (data[index].user!.type == "individual") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                  } else if (data[index].user!.type == "agency") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AgencyProfileScreen()));
                  } else if (data[index].user!.type == "brand") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BrandProfileScreen()));
                  }
                } else {
                  if (data[index].user!.type == "individual") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OtherProfileScreen()));
                  } else if (data[index].user!.type == "agency") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AgencyOtherProfileScreen()));
                  } else if (data[index].user!.type == "brand") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BrandOtherProfileScreen()));
                  }
                }
              },
              child: Text(
                data[index].user!.name! != null ? data[index].user!.name! : '',
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w400,
                    color: white,
                    fontSize: ScreenUtil().setSp(24)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isOnPageTurning = true;
                    isOnPageHorizontalTurning = true;
                  });
                  Constants.profileUserId = data[index].user!.sId;
                  if (Constants.userId == Constants.profileUserId) {
                    if (data[index].user!.type == "individual") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()));
                    } else if (data[index].user!.type == "agency") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AgencyProfileScreen()));
                    } else if (data[index].user!.type == "brand") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BrandProfileScreen()));
                    }
                  } else {
                    if (data[index].user!.type == "individual") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtherProfileScreen()));
                    } else if (data[index].user!.type == "agency") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AgencyOtherProfileScreen()));
                    } else if (data[index].user!.type == "brand") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BrandOtherProfileScreen()));
                    }
                  }
                },
                child: data[index].user!.profileImage != null
                    ? CircleAvatar(
                        backgroundColor: lightGray,
                        radius: ScreenUtil().radius(23),
                        child: CircleAvatar(
                          backgroundColor: white,
                          radius: ScreenUtil().radius(22),
                          backgroundImage: NetworkImage(
                              "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${data[index].user!.profileImage}"),
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: white,
                        radius: ScreenUtil().radius(22),
                      ),
              ),
              Visibility(
                child: Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(24)),
                    child: SizedBox(
                      height: ScreenUtil().setHeight(22),
                      child: ElevatedButton(
                        onPressed: () {
                          data[index].followStatus == false
                              ? follow(data[index].user!.sId!)
                              : unfollow(data[index].user!.sId!);
                          //data[index].followStatus == !data[index].followStatus;
                        },
                        child: Text(
                          data[index].followStatus == false
                              ? 'Follow'
                              : 'Unfollow',
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              color: white,
                              fontSize: ScreenUtil().setSp(12)),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.only(
                                          topRight: Radius.circular(
                                              ScreenUtil().radius(0)),
                                          topLeft: Radius.circular(
                                              ScreenUtil().radius(10)),
                                          bottomLeft: Radius.circular(
                                              ScreenUtil().radius(0)),
                                          bottomRight: Radius.circular(
                                              ScreenUtil().radius(10))),
                                      side: BorderSide(
                                        color: Colors.white.withOpacity(0.75),
                                      ))),
                        ),
                      ),
                    )),
                visible: Constants.userId != data[index].user!.sId &&
                    data[index].followStatus == false,
              ),
              Visibility(
                visible: Constants.userId == data[index].user!.sId ||
                    data[index].followStatus == true,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isOnPageTurning = true;
                      isOnPageHorizontalTurning = true;
                    });
                    Constants.profileUserId = data[index].user!.sId;
                    if (Constants.userId == Constants.profileUserId) {
                      if (data[index].user!.type == "individual") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()));
                      } else if (data[index].user!.type == "agency") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AgencyProfileScreen()));
                      } else if (data[index].user!.type == "brand") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BrandProfileScreen()));
                      }
                    } else {
                      if (data[index].user!.type == "individual") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtherProfileScreen()));
                      } else if (data[index].user!.type == "agency") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AgencyOtherProfileScreen()));
                      } else if (data[index].user!.type == "brand") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BrandOtherProfileScreen()));
                      }
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(4)),
                    child: Text(
                      data[index].user!.name != null
                          ? data[index].user!.name!
                          : '',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          color: white,
                          fontSize: ScreenUtil().setSp(24)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          /* ListTile(
            tileColor: Colors.transparent,
            title: Text(
              'Miss ${data[index].postModel.district}, Miss ${data[index].postModel.state}',
              style: GoogleFonts.play(
                  fontWeight: FontWeight.w400,
                  color: white,
                  fontSize: ScreenUtil().setSp(14)),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              ],
            ),
          ),*/
        ],
      ),
    );
  }

  void follow(String sId) async {
    Api.post.call(context, method: "users/follow/${sId}", param: {},
        onResponseSuccess: (Map object) {
      // widget.myFameResult[index].followStatus = !widget.myFameResult[index].followStatus;
      setState(() {});
    });
  }

  void unfollow(String sId) async {
    Api.delete.call(context, method: "users/unfollow/${sId}", param: {},
        onResponseSuccess: (Map object) {
      // widget.myFameResult[index].followStatus = !widget.myFameResult[index].followStatus;
      setState(() {});
    });
  }

  showAlertDialog(BuildContext context, String bio) {
    TextEditingController bioController = TextEditingController();
    bioController.text = bio;
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: TextStyle(color: lightRed)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Submit", style: TextStyle(color: lightRed)),
      onPressed: () async {
        /*var map = {
          "bio": bioController.text,
        };
        print(map.toString());
        Constants.progressDialog(true, context);
        var result = await _api.editProfileService(map);
        Constants.progressDialog(false, context);
        if (result != null) {
          if (result.success) {
            setState(() {
              widget.myFameResult[index]
                  .description = bioController.text;
            });
            Navigator.pop(context);
          } else {
            Constants.toastMessage(msg: result.message);
          }
        }*/
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: TextFormField(
        inputFormatters: [
          new LengthLimitingTextInputFormatter(230),
        ],
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        controller: bioController,
        minLines: 5,
        maxLines: 6,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: lightRed, width: ScreenUtil().radius(1)),
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().radius(8))),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey, width: ScreenUtil().radius(1)),
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().radius(8))),
          ),
          contentPadding: EdgeInsets.only(
              left: ScreenUtil().setWidth(10), top: ScreenUtil().setSp(5)),
          hintText: 'Bio',
          hintStyle: GoogleFonts.nunitoSans(
              fontSize: ScreenUtil().setSp(12),
              color: darkGray,
              fontWeight: FontWeight.w400),
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
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
                  key: _reportKey,
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
                                  groupValue: _postSingleValue,
                                  onChanged: (value) => setStates(
                                    () => _postSingleValue = "nudity",
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
                                  groupValue: _postSingleValue,
                                  onChanged: (value) => setStates(
                                    () => _postSingleValue = "spam",
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
                                  groupValue: _postSingleValue,
                                  onChanged: (value) => setStates(
                                    () => _postSingleValue = "vulgarity",
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
                                  groupValue: _postSingleValue,
                                  onChanged: (value) => setStates(
                                    () => _postSingleValue = "abusive",
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
                                  groupValue: _postSingleValue,
                                  onChanged: (value) => setStates(
                                    () => _postSingleValue = "rasicm",
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
                                  groupValue: _postSingleValue,
                                  onChanged: (value) => setStates(
                                    () => _postSingleValue = "copyright",
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
                                  groupValue: _postSingleValue,
                                  onChanged: (value) => setStates(
                                    () => _postSingleValue = "other",
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
                                          if (_postSingleValue.isNotEmpty) {
                                            if (_postSingleValue == "other") {
                                              Navigator.pop(context);
                                              showOtherReportDialog(
                                                  postId, isComment);
                                            } else {
                                              Map<String, dynamic> params = {
                                                "body": _postSingleValue ==
                                                        "other"
                                                    ? reportPostController.text
                                                    : "null",
                                                "type": _postSingleValue,
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
                                                _postSingleValue = "";
                                                reportPostController.text = "";
                                                Navigator.of(context).pop();
                                              });
                                            }
                                          }
                                        } else {
                                          if (_postSingleValue.isNotEmpty) {
                                            if (_postSingleValue == "other") {
                                              Navigator.pop(context);
                                              showOtherReportDialog(
                                                  postId, isComment);
                                            } else {
                                              Map<String, dynamic> params = {
                                                "body": _postSingleValue ==
                                                        "other"
                                                    ? reportPostController.text
                                                    : "null",
                                                "type": _postSingleValue,
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
                                                _postSingleValue = "";
                                                reportPostController.text = "";
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

  void showReportPostDialog(String userId, String postId, bool isComment) {
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
                          Navigator.pop(context);
                          showReportDialog(postId, isComment);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setSp(12),
                                bottom: ScreenUtil().setSp(12)),
                            child: Text(
                                isComment ? "Report Comment" : "Report Post",
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
                        onTap: () {
                          Navigator.pop(context);
                          showRestrictAlertDialog(userId);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setSp(12),
                                bottom: ScreenUtil().setSp(12)),
                            child: Text("Restrict User",
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
                        onTap: () {
                          Navigator.pop(context);
                          showBlockAlertDialog(userId);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setSp(12),
                                bottom: ScreenUtil().setSp(12)),
                            child: Text("Block User",
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
                        controller: reportPostController,
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
                                  if (_postSingleValue.isNotEmpty) {
                                    Map<String, dynamic> params = {
                                      "body": _postSingleValue == "other"
                                          ? reportPostController.text
                                          : "null",
                                      "type": _postSingleValue,
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
                                      _postSingleValue = "";
                                      reportPostController.text = "";
                                      Navigator.of(context).pop();
                                    });
                                  }
                                } else {
                                  if (_postSingleValue.isNotEmpty) {
                                    Map<String, dynamic> params = {
                                      "body": _postSingleValue == "other"
                                          ? reportPostController.text
                                          : "null",
                                      "type": _postSingleValue,
                                    };
                                    Api.post.call(context,
                                        method: "users/report/post/${postId}",
                                        param: params,
                                        onResponseSuccess: (Map object) {
                                      var result =
                                          UserUpdatedResponse.fromJson(object);
                                      Constants.toastMessage(
                                          msg: result.message);
                                      _postSingleValue = "";
                                      reportPostController.text = "";
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
          widget.myFameResult.clear();
          page = 1;
          index = 0;
          if (pageController!.positions.isNotEmpty) {
            pageController!.jumpToPage(0);
          }
          _myFamelinks();
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

  void _myFamelinks() async {
    Map<String, dynamic> param = {"page": page.toString()};
    Api.get.call(context,
        method: "challenges/${widget.challengeId}/famelinks",
        param: param, onResponseSuccess: (Map object) {
      var result = FamelinksResponse.fromJson(object);
      if (result.result!.length > 0) {
        widget.myFameResult.addAll(result.result!);
        setState(() {});
        print('RESPONSE ${result.result.toString()}');
      } else {
        page--;
      }
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
          widget.myFameResult.clear();
          page = 1;
          index = 0;
          if (pageController!.positions.isNotEmpty) {
            pageController!.jumpToPage(0);
          }
          _myFamelinks();
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

  void showFamLinkShareDialog(BuildContext context, String postId, Media data) {
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
                          Navigator.pop(context2);
                          Share.share(
                            '${ApiProvider.shareUrl}post/${widget.type}/${postId}',
                          );
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
                        onTap: () {
                          Navigator.pop(context2);
                          _onShare(data);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setSp(12),
                                bottom: ScreenUtil().setSp(12)),
                            child: Text(
                                data.type == "video"
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
              }));
        });
  }

  void _onShare(Media data) async {
    if (data.type == "video") {
      var dir = await getApplicationDocumentsDirectory();
      bool fileExists = await File("${dir.path}/${data.path}").exists();
      if (fileExists) {
        Constants.progressDialog(true, context);
        File _watermarkImage =
            await getImageFileFromAssets('images/watermarkvideo.png');
        String _desFile = await _destinationFile;
        FFmpegKit.execute(
                "-i ${File("${dir.path}/${data.path}").path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-75 -c:a copy ${_desFile}")
            // "-i ${videoPath} -i ${_musicFile} -c copy -filter_complex [0:a]aformat = fltp:44100:stereo,apad[0a];[1] aformat=fltp:44100:stereo,volume=1.5[1a];[0a] [1a] amerge[a] -map 0:v -map [a] -ac 2 -y -shortest ${_desFile}")
            .then((return_code) async {
          Constants.progressDialog(false, context);
          Share.shareFiles(
            [_desFile],
            text: 'https://play.google.com/store/apps/details?id=app.famelinks',
          );
        });
      } else {
        Constants.progressDialog(true, context);
        Dio dio = Dio();
        unawaited(dio.download(
            "${widget.type == "funlinks" ? "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}" : widget.type == "followlinks" ? "${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}" : "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}"}/${data}",
            "${dir.path}/${data}", onReceiveProgress: (rec, total) async {
          print("Rec: $rec , Total: $total");
          if (rec == total) {
            File _watermarkImage =
                await getImageFileFromAssets('images/watermarkvideo.png');
            String _desFile = await _destinationFile;
            FFmpegKit.execute(
                    "-i ${File("${dir.path}/${data}").path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-75 -codec:a copy ${_desFile}")
                // "-i ${videoPath} -i ${_musicFile} -c copy -filter_complex [0:a]aformat = fltp:44100:stereo,apad[0a];[1] aformat=fltp:44100:stereo,volume=1.5[1a];[0a] [1a] amerge[a] -map 0:v -map [a] -ac 2 -y -shortest ${_desFile}")
                .then((return_code) async {
              Constants.progressDialog(false, context);
              Share.shareFiles(
                [_desFile],
                text:
                    'https://play.google.com/store/apps/details?id=app.famelinks',
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
        '${widget.type == "funlinks" ? "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}" : widget.type == "followlinks" ? "${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}" : "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}"}/${data.path}-xlg',
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
                    'https://play.google.com/store/apps/details?id=app.famelinks',
              );
            });
          }
        },
      );
      print(response.data.toString());
    }
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/watermark.png');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
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

  Widget buildSheet(BuildContext context, StateSetter setCommentStates) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.all(15),
            height: 50,
            child: TextFormField(
              focusNode: focusNode,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              //Normal textInputField will be displayed
              maxLines: 4,
              controller: commentController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.red[500]!,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: "Write a comment...",
                  errorText: _commentValidate ? 'Write a comment' : null,
                  suffixIcon: IconButton(
                      onPressed: () async {
                        if (!commentController.text.isEmpty) {
                          FocusScope.of(context).unfocus();
                          Map<String, dynamic> params = {
                            "body": commentController.text,
                          };
                          Api.post.call(context,
                              method: "media/${widget.type}/comment/${mediaId}",
                              param: params,
                              isLoading: false,
                              onResponseSuccess: (Map object) {
                            var result = CommentAddResponse.fromJson(object);
                            Constants.toastMessage(msg: result.message);
                            setCommentStates(() {
                              commentController.text = "";
                              _getCommentData();
                            });
                            Navigator.pop(context);
                          });
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.black38,
                      ))),
            ),
          ),
          Align(
              child: Padding(
                padding: EdgeInsets.only(right: ScreenUtil().setWidth(24)),
                child: Text(
                  "Comments: ${commentResult != null ? NumberFormat.compactCurrency(
                      decimalDigits: 0,
                      symbol:
                          '', // if you want to add currency symbol then pass that in this else leave it empty.
                    ).format(commentResult!.count) : ""}",
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                      color: black,
                      fontSize: ScreenUtil().setSp(10)),
                ),
              ),
              alignment: Alignment.topRight),
          SizedBox(
            height: (MediaQuery.of(context).size.height / 2) -
                ScreenUtil().setSp(50),
            child: ListView.builder(
              controller: commentScrollController,
              itemCount: commentList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                Comment comment = commentList[index];
                DateTime now = DateTime.parse(comment.createdAt!);
                return Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        child: InkWell(
                          onTap: () {
                            Constants.profileUserId = comment.user!.sId;
                            if (Constants.userId == Constants.profileUserId) {
                              if (comment.user!.type == "individual") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileScreen()));
                              } else if (comment.user!.type == "agency") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AgencyProfileScreen()));
                              } else if (comment.user!.type == "brand") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BrandProfileScreen()));
                              }
                            } else {
                              if (comment.user!.type == "individual") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OtherProfileScreen()));
                              } else if (comment.user!.type == "agency") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AgencyOtherProfileScreen()));
                              } else if (comment.user!.type == "brand") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BrandOtherProfileScreen()));
                              }
                            }
                          },
                          child: comment.user!.profileImage != null
                              ? CircleAvatar(
                                  radius: ScreenUtil().radius(22),
                                  backgroundImage: NetworkImage(
                                      "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${comment.user!.profileImage}"),
                                )
                              : CircleAvatar(
                                  radius: ScreenUtil().radius(22),
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () {
                                        Constants.profileUserId =
                                            comment.user!.sId;
                                        if (Constants.userId ==
                                            Constants.profileUserId) {
                                          if (comment.user!.type ==
                                              "individual") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfileScreen()));
                                          } else if (comment.user!.type ==
                                              "agency") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AgencyProfileScreen()));
                                          } else if (comment.user!.type ==
                                              "brand") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BrandProfileScreen()));
                                          }
                                        } else {
                                          if (comment.user!.type ==
                                              "individual") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OtherProfileScreen()));
                                          } else if (comment.user!.type ==
                                              "agency") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AgencyOtherProfileScreen()));
                                          } else if (comment.user!.type ==
                                              "brand") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BrandOtherProfileScreen()));
                                          }
                                        }
                                      },
                                    text: "${comment.user!.name} : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                TextSpan(
                                    text: comment.body,
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                        '${comment.likesCount != null ? comment.likesCount : 0} likes',
                                        style: TextStyle(fontSize: 12)),
                                    SizedBox(width: 5),
                                    InkWell(
                                      child: comment.likeStatus != null
                                          ? Icon(
                                              Icons.favorite,
                                              size: ScreenUtil().setSp(18),
                                              color: Colors.red,
                                            )
                                          : Icon(
                                              Icons.favorite_border,
                                              size: ScreenUtil().setSp(18),
                                            ),
                                      onTap: () async {
                                        Map<String, dynamic> map = {
                                          "status": comment.likeStatus != null
                                              ? null
                                              : "3",
                                        };
                                        Api.post.call(context,
                                            method:
                                                "media/${widget.type}/like/comment/${comment.sId}",
                                            param: map,
                                            onResponseSuccess: (Map object) {
                                          setCommentStates(() {
                                            commentList[index].likeStatus =
                                                comment.likeStatus != null
                                                    ? null
                                                    : 3;
                                            commentList[index]
                                                .likesCount = comment
                                                        .likeStatus !=
                                                    null
                                                ? comment.likesCount != null
                                                    ? comment.likesCount! + 1
                                                    : 1
                                                : comment.likesCount != null
                                                    ? comment.likesCount! - 1
                                                    : 0;
                                          });
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                flex: 3,
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: InkWell(
                                    child: Text(
                                        '${comment.repliesCount != null ? comment.repliesCount : 0} replies',
                                        style: TextStyle(fontSize: 12)),
                                    onTap: () async {
                                      FocusScope.of(context).unfocus();
                                      commentId = comment.sId!;
                                      commentRepliesPage = 1;
                                      Map<String, String> map = {
                                        "page": commentRepliesPage.toString()
                                      };
                                      Api.get.call(context,
                                          method:
                                              "media/${commentType}/comment/${commentId}/replies",
                                          param: map,
                                          isLoading: false,
                                          onResponseSuccess: (Map object) {
                                        var result =
                                            CommentListResponse.fromJson(
                                                object);
                                        if (result.result!.data!.length > 0) {
                                          commentResult = result.result!;
                                          commentRepliesList =
                                              result.result!.data!;
                                          showModalBottomSheet(
                                              context: context,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              20))),
                                              builder: (BuildContext context) {
                                                return StatefulBuilder(builder:
                                                    (BuildContext context,
                                                        StateSetter setStates) {
                                                  return buildCommentSheet(
                                                      context,
                                                      setStates,
                                                      comment,
                                                      setCommentStates,
                                                      index);
                                                });
                                              });
                                        }
                                      });
                                    }),
                                flex: 2,
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                  child: Text(convertToAgo(now),
                                      style: TextStyle(fontSize: 12)),
                                  flex: 3),
                              Expanded(
                                child: Row(
                                  children: [
                                    Visibility(
                                      visible:
                                          Constants.userId == comment.userId ||
                                              Constants.userId ==
                                                  Constants.profileUserId,
                                      child: InkWell(
                                        child: Icon(
                                          Icons.delete,
                                          size: ScreenUtil().setSp(18),
                                        ),
                                        onTap: () async {
                                          Api.delete.call(context,
                                              method:
                                                  "media/${widget.type}/comment/${comment.sId}",
                                              param: {},
                                              isLoading: false,
                                              onResponseSuccess: (Map object) {
                                            setCommentStates(() {
                                              commentList.removeAt(index);
                                            });
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                flex: 1,
                              ),
                            ],
                            mainAxisSize: MainAxisSize.min,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      )),
                      Visibility(
                        child: IconButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            showReportPostDialog(
                                comment.userId!, comment.sId!, true);
                          },
                        ),
                        visible: Constants.userId != comment.userId,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );

  Widget buildCommentSheet(BuildContext context, StateSetter setStates,
          Comment comment, StateSetter setCommentStates, int index) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: "Replying to ",
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: "${comment.user!.name} : ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 15, right: 15, top: 5),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              //Normal textInputField will be displayed
              maxLines: 4,
              controller: replayController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.red[500]!,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: "Write a reply...",
                  errorText: _commentValidate ? 'Write a reply' : null,
                  suffixIcon: IconButton(
                      onPressed: () async {
                        if (!replayController.text.isEmpty) {
                          FocusScope.of(context).unfocus();
                          Map<String, dynamic> params = {
                            "parentId": comment.sId,
                            "body": replayController.text,
                          };
                          Api.post.call(context,
                              method: "media/${widget.type}/comment/${mediaId}",
                              param: params,
                              isLoading: false,
                              onResponseSuccess: (Map object) {
                            var result = CommentAddResponse.fromJson(object);
                            Constants.toastMessage(msg: result.message);
                            setStates(() {
                              replayController.text = "";
                              _getCommentData();
                            });
                            setCommentStates(() {
                              commentList[index].repliesCount =
                                  comment.repliesCount != null
                                      ? comment.repliesCount! + 1
                                      : 1;
                            });
                            Navigator.pop(context);
                          });
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.black38,
                      ))),
            ),
          ),
          SizedBox(
            height: (MediaQuery.of(context).size.height / 2) -
                ScreenUtil().setSp(50),
            child: ListView.builder(
              controller: commentRepliesScrollController,
              shrinkWrap: true,
              itemCount: commentRepliesList.length,
              itemBuilder: (BuildContext context, int index) {
                Comment comment = commentRepliesList[index];
                DateTime now = DateTime.parse(comment.createdAt!);
                return Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        child: InkWell(
                          onTap: () {
                            Constants.profileUserId = comment.user!.sId;
                            if (Constants.userId == Constants.profileUserId) {
                              if (comment.user!.type == "individual") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileScreen()));
                              } else if (comment.user!.type == "agency") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AgencyProfileScreen()));
                              } else if (comment.user!.type == "brand") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BrandProfileScreen()));
                              }
                            } else {
                              if (comment.user!.type == "individual") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OtherProfileScreen()));
                              } else if (comment.user!.type == "agency") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AgencyOtherProfileScreen()));
                              } else if (comment.user!.type == "brand") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BrandOtherProfileScreen()));
                              }
                            }
                          },
                          child: comment.user!.profileImage != null
                              ? CircleAvatar(
                                  radius: ScreenUtil().radius(22),
                                  backgroundImage: NetworkImage(
                                      "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${comment.user!.profileImage}"),
                                )
                              : CircleAvatar(
                                  radius: ScreenUtil().radius(22),
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () {
                                        Constants.profileUserId =
                                            comment.user!.sId;
                                        if (Constants.userId ==
                                            Constants.profileUserId) {
                                          if (comment.user!.type ==
                                              "individual") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfileScreen()));
                                          } else if (comment.user!.type ==
                                              "agency") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AgencyProfileScreen()));
                                          } else if (comment.user!.type ==
                                              "brand") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BrandProfileScreen()));
                                          }
                                        } else {
                                          if (comment.user!.type ==
                                              "individual") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OtherProfileScreen()));
                                          } else if (comment.user!.type ==
                                              "agency") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AgencyOtherProfileScreen()));
                                          } else if (comment.user!.type ==
                                              "brand") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BrandOtherProfileScreen()));
                                          }
                                        }
                                      },
                                    text: "${comment.user!.name} : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                TextSpan(
                                    text: comment.body,
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(convertToAgo(now),
                                      style: TextStyle(fontSize: 12))),
                            ],
                            mainAxisSize: MainAxisSize.min,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      )),
                      Visibility(
                        visible: Constants.userId == comment.user!.sId ||
                            Constants.userId == Constants.profileUserId,
                        child: InkWell(
                          child: Icon(
                            Icons.delete,
                            size: ScreenUtil().setSp(18),
                          ),
                          onTap: () async {
                            Api.delete.call(context,
                                method:
                                    "media/${widget.type}/comment/${comment.sId}",
                                param: {},
                                isLoading: false,
                                onResponseSuccess: (Map object) {
                              setStates(() {
                                commentRepliesList.removeAt(index);
                              });
                              setCommentStates(() {
                                commentList[index].repliesCount =
                                    comment.repliesCount != null
                                        ? comment.repliesCount == 0
                                            ? 0
                                            : comment.repliesCount! - 1
                                        : 0;
                              });
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );

  _getCommentData() async {
    commentPage = 1;
    commentType = widget.type;
    Map<String, String> map = {"page": commentPage.toString()};
    Api.get.call(context,
        method: "media/${commentType}/comment/${mediaId}",
        param: map, onResponseSuccess: (Map object) {
      var result = CommentListResponse.fromJson(object);
      setState(() {
        commentResult = result.result!;
        commentList = result.result!.data!;
      });
    });
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

  void likeHeart(int? i, int index2, Result data) async {
    Map<String, dynamic> map = {
      "status": i != null ? i.toString() : null,
    };
    Api.post.call(context,
        method: "media/${widget.type}/like/media/${mediaId}",
        param: map, onResponseSuccess: (Map object) {
      setState(() {
        if (i == 0) {
          if (data.likeStatus != null && data.likeStatus == 2) {
            widget.myFameResult[index].likes2Count = data.likes2Count! >= 0
                ? (data.likes2Count)! - 1
                : data.likes2Count;
          } else if (data.likeStatus != null && data.likeStatus == 1) {
            widget.myFameResult[index].likes1Count = data.likes1Count! >= 0
                ? (data.likes1Count)! - 1
                : data.likes1Count;
          }
        } else if (i == 1) {
          if (data.likeStatus != null && data.likeStatus == 2) {
            widget.myFameResult[index].likes2Count = data.likes2Count! >= 0
                ? (data.likes2Count)! - 1
                : data.likes2Count;
            widget.myFameResult[index].likes1Count = (data.likes1Count)! + 1;
          } else if (data.likeStatus != i) {
            widget.myFameResult[index].likes1Count = (data.likes1Count)! + 1;
          }
        } else if (i == 2) {
          if (data.likeStatus != null && data.likeStatus == 1) {
            widget.myFameResult[index].likes1Count = data.likes1Count! >= 0
                ? (data.likes1Count)! - 1
                : data.likes1Count;
            widget.myFameResult[index].likes2Count = (data.likes2Count)! + 1;
          } else if (data.likeStatus != i) {
            widget.myFameResult[index].likes2Count = (data.likes2Count)! + 1;
          }
        } else if (i == null) {
          if (index2 == 2) {
            widget.myFameResult[index].likes2Count = (data.likes2Count)! - 1;
          } else if (index2 == 1) {
            widget.myFameResult[index].likes1Count = (data.likes1Count)! - 1;
          } else if (index2 == 0) {
            widget.myFameResult[index].likes0Count = (data.likes0Count)! - 1;
          }
        }
        if (i == null) {
          widget.myFameResult[index].likeStatus = 7;
        } else {
          widget.myFameResult[index].likeStatus = i;
        }
      });
    });
  }


}
