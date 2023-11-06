import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/CommentAddResponse.dart';
import 'package:famelink/models/CommentListResponse.dart';
import 'package:famelink/models/famelink_model.dart';
import 'package:famelink/models/userUpdateResponse.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/profile/agency_other_profile_screen.dart';
import 'package:famelink/ui/profile/agency_profile_screen.dart';
import 'package:famelink/ui/profile/brand_other_profile_screen.dart';
import 'package:famelink/ui/profile/brand_profile_screen.dart';
import 'package:famelink/ui/profile/profile_screen.dart';
import 'package:famelink/util/ReadMoreText.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/config/image.dart';
import 'package:famelink/util/constants.dart';
import 'package:famelink/util/widgets/FeedVideoPlayer.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:share_plus/share_plus.dart';

import 'other_profile_screen.dart';

class NotificationPostScreen extends StatefulWidget {
  String postId;
  String postType;
  String type;

  NotificationPostScreen(this.postId, this.postType, this.type);

  @override
  _NotificationPostScreenState createState() => _NotificationPostScreenState();
}

class _NotificationPostScreenState extends State<NotificationPostScreen>
    with TickerProviderStateMixin {
  int ind = 0;
  final ApiProvider _api = ApiProvider();
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

  String? mediaId;
  int current = 0;
  bool isOnPageTurning = false;
  PageController? pageController;
  Result? resultModel;
  bool _isPlaying = true;
  bool isEdit = false;
  final GlobalKey<FormState> _reportKey = GlobalKey<FormState>();

  CommentResult? commentResult;
  ScrollController commentScrollController = ScrollController();
  ScrollController commentRepliesScrollController = ScrollController();
  int commentPage = 1;
  int commentRepliesPage = 1;
  String? commentId;
  String commentType = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController =
        PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
    pageController!.addListener(scrollListener);
    mediaId = widget.postId;
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
            method: "media/${commentType}/comment/${commentId}/replies",
            param: map,
            isLoading: false, onResponseSuccess: (Map object) {
          var result = CommentListResponse.fromJson(object);
          if (result.result!.data!.length > 0) {
            setState(() {
              commentResult = result.result;
              commentRepliesList = result.result!.data!;
            });
          } else {
            commentRepliesPage--;
          }
        });
      }
    });
    _myFameLink();
  }

  void scrollListener() {
    if (isOnPageTurning &&
        pageController!.page == pageController!.page!.roundToDouble()) {
      setState(() {
        current = pageController!.page!.toInt();
        isOnPageTurning = false;
      });
    } else if (!isOnPageTurning &&
        current.toDouble() != pageController!.page!) {
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
      body: resultModel != null
          ? Stack(
              children: [
                PinchZoom(
                  child: Container(
                    width: ScreenUtil().screenWidth,
                    height: ScreenUtil().screenHeight,
                    child: PageView.builder(
                      pageSnapping: true,
                      controller: PageController(
                        keepPage: true,
                        initialPage: 0,
                        viewportFraction: 1,
                      ),
                      scrollDirection: Axis.horizontal,
                      physics: PageScrollPhysics(),
                      itemCount: resultModel!.images!.length,
                      itemBuilder: (horizontalContext, ind) {
                        Media mediaModelData = resultModel!.images![ind];
                        return Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: mediaModelData.type == "video"
                                    ? Stack(
                                        children: [
                                          FeedVideoPlayer(
                                            videoUrl: widget.postType ==
                                                    "funlinks"
                                                ? "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${mediaModelData.path!}"
                                                : widget.postType ==
                                                        "followlinks"
                                                    ? "${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${mediaModelData.path!}"
                                                    : "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${mediaModelData.path!}",
                                          ),
                                        ],
                                      )
                                    : InkWell(
                                        onTap: () {},
                                        child: Stack(
                                          children: [
                                            Image.network(
                                              '${widget.postType == "funlinks" ? "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}" : widget.postType == "followlinks" ? "${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}" : "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}"}/${mediaModelData.path}-xlg',
                                              fit: BoxFit.cover,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin: Alignment.topRight,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                    Colors.transparent,
                                                    Colors.black
                                                        .withOpacity(0.40)
                                                  ])),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.black
                                                            .withOpacity(0.40),
                                                        Colors.transparent,
                                                        Colors.transparent,
                                                        Colors.transparent
                                                      ],
                                                      begin: Alignment.topRight,
                                                      end:
                                                          Alignment.bottomRight,
                                                      stops: [0, 0.2, 0.8, 1])),
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
                          // _getCommentData();
                        });
                      },
                    ),
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
                        icon: Icon(Icons.arrow_back,
                            color: white.withOpacity(0.5))),
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
                          visible: Constants.userId != Constants.profileUserId,
                          child: IconButton(
                              onPressed: () async {
                                showReportPostDialog(resultModel!.user!.sId!,
                                    widget.postId, false);
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
                    padding:
                        EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                            '${resultModel!.challenges!.length > 0 ? resultModel!.challenges![0].name : ''}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w500, color: white)),
                        Text.rich(TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "${ind + 1}/",
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: ScreenUtil().setSp(18),
                                  color: white)),
                          TextSpan(
                              text: "${resultModel!.images!.length}",
                              style: GoogleFonts.nunitoSans(
                                  color: white,
                                  fontSize: ScreenUtil().setSp(12))),
                        ]))
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                if (resultModel!.likeStatus != 2) {
                                  likeHeart(2, 2, resultModel!);
                                } else {
                                  likeHeart(null, 2, resultModel!);
                                }
                              },
                              child: SvgPicture.asset(fullheart,
                                  color: resultModel!.likeStatus == 2
                                      ? lightRed
                                      : Colors.white),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(2),
                            ),
                            Text(
                              resultModel!.likes2Count != null
                                  ? "${NumberFormat.compactCurrency(
                                      decimalDigits: 0,
                                      symbol:
                                          '', // if you want to add currency symbol then pass that in this else leave it empty.
                                    ).format(resultModel!.likes2Count)}"
                                  : "",
                              style: GoogleFonts.nunitoSans(
                                  color: resultModel!.likeStatus == 2
                                      ? lightRed
                                      : Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: ScreenUtil().setSp(10)),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(7),
                            ),
                            InkWell(
                              onTap: () {
                                if (resultModel!.likeStatus != 1) {
                                  likeHeart(1, 1, resultModel!);
                                } else {
                                  likeHeart(null, 1, resultModel!);
                                }
                              },
                              child: SvgPicture.asset(halfheart,
                                  color: resultModel!.likeStatus == 1
                                      ? lightRed
                                      : Colors.white),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(2),
                            ),
                            Text(
                              resultModel!.likes1Count != null
                                  ? "${NumberFormat.compactCurrency(
                                      decimalDigits: 0,
                                      symbol:
                                          '', // if you want to add currency symbol then pass that in this else leave it empty.
                                    ).format(resultModel!.likes1Count!)}"
                                  : "",
                              style: GoogleFonts.nunitoSans(
                                  color: resultModel!.likeStatus == 1
                                      ? lightRed
                                      : Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: ScreenUtil().setSp(10)),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(7),
                            ),
                            InkWell(
                              onTap: () {
                                if (resultModel!.likeStatus != 0) {
                                  likeHeart(0, 0, resultModel!);
                                } else {
                                  likeHeart(null, 0, resultModel!);
                                }
                              },
                              child: SvgPicture.asset(emptyheart,
                                  color: resultModel!.likeStatus == 0
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
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(25)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: ScreenUtil().setWidth(18),
                            ),
                            SizedBox(
                              width: ScreenUtil().screenWidth - 100,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: ReadMoreText(
                                      resultModel!.description! == null
                                          ? ''
                                          : resultModel!.description!,
                                      trimLines: 3,
                                      trimMode: TrimMode.Line,
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w400,
                                          color: white,
                                          fontSize: ScreenUtil().setSp(10)),
                                    ),
                                  ),
                                  Visibility(
                                    visible: isEdit,
                                    child: IconButton(
                                        onPressed: () {
                                          showAlertDialog(context,
                                              '${resultModel!.description != null ? resultModel!.description : ""}');
                                        },
                                        icon: SvgPicture.asset(
                                            "assets/icons/svg/edit.svg")),
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
                        children: [
                          InkWell(
                            onTap: () async {
                              commentPage = 1;
                              commentType = widget.postType;
                              Map<String, String> map = {
                                "page": commentPage.toString()
                              };
                              Api.get.call(context,
                                  method:
                                      "media/${commentType}/comment/${mediaId}",
                                  param: map, onResponseSuccess: (Map object) {
                                var result =
                                    CommentListResponse.fromJson(object);
                                setState(() {
                                  commentResult = result.result;
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
                                        return buildSheet(
                                            context, setStates, false);
                                      });
                                    });
                                commentScrollController.jumpTo(
                                    commentScrollController
                                        .position.maxScrollExtent);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(20)),
                              child: SvgPicture.asset(
                                  "assets/icons/svg/comment.svg",
                                  color: white),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: ScreenUtil().setWidth(5),
                                bottom: ScreenUtil().setHeight(10)),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: SvgPicture.asset(
                                  "assets/icons/svg/share.svg",
                                  color: white),
                              onPressed: () {
                                resultModel!.images![ind].path!.isEmpty
                                    ? null
                                    : showFamLinkShareDialog(
                                        context,
                                        resultModel!.sId!,
                                        resultModel!.images![ind]);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Container(),
    );
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
              resultModel
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

  void _myFameLink() async {
    Api.get.call(context,
        method: "media/${widget.postType}/single/${widget.postId}",
        param: {},
        isLoading: false, onResponseSuccess: (Map<dynamic, dynamic> object) {
      var result = FameLinkResponse.fromJson(object);
      resultModel = result.result;
      setState(() {});
    });
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
                            '${ApiProvider.shareUrl}post/${widget.postType}/${postId}',
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
        Share.shareFiles(
          ['${File("${dir.path}/${data.path}").path}'],
          text: 'https://play.google.com/store/apps/details?id=app.famelinks',
        );
      } else {
        Constants.progressDialog(true, context);
        Dio dio = Dio();
        unawaited(dio.download(
            "${widget.postType == "funlinks" ? "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}" : widget.postType == "followlinks" ? "${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}" : "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}"}/${data.path}",
            "${dir.path}/${data.path}", onReceiveProgress: (rec, total) async {
          print("Rec: $rec , Total: $total");
          if (rec == total) {
            File _watermarkImage =
                await getImageFileFromAssets('images/watermarkvideo.png');
            String _desFile = await _destinationFile;
            FFmpegKit.execute(
                    "-i ${File("${dir.path}/${data.path}").path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-75 -codec:a copy ${_desFile}")
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
        '${widget.postType == "funlinks" ? "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}" : widget.postType == "followlinks" ? "${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}" : "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}"}/${data.path}-xlg',
        imageFile.path,
        onReceiveProgress: (count, total) {
          print("Rec: $count , Total: $total");
          if (count == total) {
            Constants.progressDialog(false, context);
            Share.shareFiles(
              ['${imageFile.path}'],
              text:
                  'https://play.google.com/store/apps/details?id=app.famelinks',
            );
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

  Widget buildSheet(
      BuildContext context, StateSetter setCommentStates, bool isCommentPost) {
    return Column(
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
                            method:
                                "media/${widget.postType}/comment/${mediaId}",
                            param: params,
                            isLoading: false, onResponseSuccess: (Map object) {
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
          height:
              (MediaQuery.of(context).size.height / 2) - ScreenUtil().setSp(50),
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
                                              "media/${widget.postType}/like/comment/${comment.sId}",
                                          param: map,
                                          onResponseSuccess: (Map object) {
                                        setCommentStates(() {
                                          commentList[index].likeStatus =
                                              comment.likeStatus != null
                                                  ? null
                                                  : 3;
                                          commentList[index].likesCount =
                                              comment.likeStatus != null
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
                                    commentId = comment.sId;
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
                                          CommentListResponse.fromJson(object);
                                      commentResult = result.result;
                                      commentRepliesList = result.result!.data!;
                                      showModalBottomSheet(
                                          context: context,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(20))),
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
                                                "media/${widget.postType}/comment/${comment.sId}",
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
  }

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
                              method:
                                  "media/${widget.postType}/comment/${mediaId}",
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
                                    "media/${widget.postType}/comment/${comment.sId}",
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
    commentType = widget.postType;
    Map<String, String> map = {"page": commentPage.toString()};
    Api.get.call(context,
        method: "media/${commentType}/comment/${mediaId}",
        param: map, onResponseSuccess: (Map object) {
      var result = CommentListResponse.fromJson(object);
      setState(() {
        commentResult = result.result;
        commentList = result.result!.data!;
      });
    });
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
    setState(() {
      if (i == 0) {
        if (data.likeStatus != null && data.likeStatus == 2) {
          resultModel!.likes2Count = data.likes2Count! >= 0
              ? (data.likes2Count)! - 1
              : data.likes2Count;
        } else if (data.likeStatus != null && data.likeStatus == 1) {
          resultModel!.likes1Count = data.likes1Count! >= 0
              ? (data.likes1Count)! - 1
              : data.likes1Count;
        }
      } else if (i == 1) {
        if (data.likeStatus != null && data.likeStatus == 2) {
          resultModel!.likes2Count = data.likes2Count! >= 0
              ? (data.likes2Count)! - 1
              : data.likes2Count;
          resultModel!.likes1Count = (data.likes1Count!) + 1;
        } else if (data.likeStatus != i) {
          resultModel!.likes1Count = (data.likes1Count!) + 1;
        }
      } else if (i == 2) {
        if (data.likeStatus != null && data.likeStatus == 1) {
          resultModel!.likes1Count = data.likes1Count! >= 0
              ? (data.likes1Count!) - 1
              : data.likes1Count;
          resultModel!.likes2Count = (data.likes2Count)! + 1;
        } else if (data.likeStatus != i) {
          resultModel!.likes2Count = (data.likes2Count!) + 1;
        }
      } else if (i == null) {
        if (index2 == 2) {
          resultModel!.likes2Count = (data.likes2Count!) - 1;
        } else if (index2 == 1) {
          resultModel!.likes1Count = (data.likes1Count!) - 1;
        } else if (index2 == 0) {
          resultModel!.likes0Count = (data.likes0Count!) - 1;
        }
      }
      if (i == null) {
        resultModel!.likeStatus = 7;
      } else {
        resultModel!.likeStatus = i;
      }
    });
    Map<String, dynamic> map = {
      "status": i != null ? i.toString() : null,
    };
    Api.post.call(context,
        method: "media/${widget.postType}/like/media/${mediaId}",
        param: map,
        onResponseSuccess: (Map object) {});
  }

  @override
  void onProfileClick() {
    // TODO: implement onProfileClick
  }

  @override
  void onPlayingChange(bool isPlaying) {
    // TODO: implement onPlayingChange
    setState(() {
      _isPlaying = isPlaying;
    });
  }
}
