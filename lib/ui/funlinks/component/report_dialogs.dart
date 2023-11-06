import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:famelink/databse/models/FollowFeedPostModel.dart';
import 'package:famelink/databse/models/FunlinksFeedPostModel.dart';
import 'package:famelink/models/InfoPopupModel.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/funlinks/provider/FunLinksFeedProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

import '../../../databse/db_provider.dart';
import '../../../dio/api/api.dart';
import '../../../models/userUpdateResponse.dart';
import '../../../share/firebasedynamiclink.dart';
import '../../../share/sharefile.dart';
import '../../../util/Validator.dart';
import '../../../util/appStrings.dart';
import '../../../util/config/color.dart';
import '../../../util/constants.dart';
import '../../../util/custom_snack_bar.dart';
import '../../settings/profile_verification_screen.dart';
import '../../upload/upload_screen_one.dart';

void showPopUpDialog(BuildContext buildContext, List<PopUpData> data) {
  VideoPlayerController? _controller;
  PageController? popUpPageController;
  showDialog(
      context: buildContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            elevation: 4,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.only(
                top: ScreenUtil().setSp(
                    (ScreenUtil().screenHeight - ScreenUtil().setSp(480)) / 2),
                bottom: ScreenUtil().setSp(
                    (ScreenUtil().screenHeight - ScreenUtil().setSp(480)) / 2),
                left: ScreenUtil().setSp(
                    (ScreenUtil().screenWidth - ScreenUtil().setSp(330)) / 2),
                right: ScreenUtil().setSp(
                    (ScreenUtil().screenWidth - ScreenUtil().setSp(330)) / 2)),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setStates) {
              popUpPageController =
                  PageController(keepPage: true, initialPage: 0);
              return Container(
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
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: black,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(ScreenUtil().setSp(8)),
                              bottomRight:
                                  Radius.circular(ScreenUtil().setSp(8)))),
                      child: PageView.builder(
                        pageSnapping: true,
                        scrollDirection: Axis.horizontal,
                        allowImplicitScrolling: true,
                        itemCount: data.length,
                        itemBuilder: (horizontalContext, ind) {
                          PopUpData mediaModelData = data[ind];
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              mediaModelData.video!.isEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: mediaModelData.image!)
                                  : Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        GestureDetector(
                                          onLongPressUp: () {
                                            _controller!.play();
                                          },
                                          onLongPress: () {
                                            _controller!.pause();
                                          },
                                          onTap: () {
                                            if (_controller!.value.isPlaying) {
                                              _controller!.pause();
                                            } else {
                                              _controller!.play();
                                            }
                                          },
                                          child: Center(
                                            child: _controller != null &&
                                                    _controller!
                                                        .value.isInitialized
                                                ? AspectRatio(
                                                    aspectRatio: _controller!
                                                        .value.aspectRatio,
                                                    child: VideoPlayer(
                                                        _controller!),
                                                  )
                                                : Container(
                                                    color: black,
                                                  ),
                                          ),
                                        ),
                                        Visibility(
                                            visible: _controller != null &&
                                                !_controller!.value.isPlaying &&
                                                _controller!
                                                    .value.isInitialized,
                                            child: Center(
                                              child: FloatingActionButton(
                                                backgroundColor:
                                                    Colors.transparent,
                                                foregroundColor: Colors.black12,
                                                mini: true,
                                                onPressed: () async {
                                                  if (_controller != null) {
                                                    // await _controller.seekTo(Duration.zero);
                                                    setStates(() {
                                                      if (_controller!
                                                          .value.isPlaying) {
                                                        _controller!.pause();
                                                      } else {
                                                        _controller!.play();
                                                      }
                                                    });
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.play_arrow,
                                                  color: Colors.white,
                                                  size: 50,
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                              Align(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: SmoothPageIndicator(
                                    controller: popUpPageController!,
                                    count: data.length,
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
                                alignment: Alignment.bottomCenter,
                              ),
                            ],
                          );
                        },
                        onPageChanged: (value) async {},
                      ),
                    )),
                    InkWell(
                      onTap: () {
                        if (_controller != null) {
                          _controller!.pause();
                          _controller!.dispose();
                          _controller = null;
                        }
                        Navigator.pop(context);
                        Provider.of<FunLinksFeedProvider>(context,
                                listen: false)
                            .check = true;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(ScreenUtil().setSp(8)),
                                bottomRight:
                                    Radius.circular(ScreenUtil().setSp(8)))),
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(7),
                            bottom: ScreenUtil().setHeight(7),
                            left: ScreenUtil().setWidth(16),
                            right: ScreenUtil().setWidth(16)),
                        child: Center(
                          child: Text(
                            "Close",
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(20),
                                color: black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
      });
}

void showReferralCodeDialog(BuildContext context) {
  final GlobalKey<FormState> _referralKey = GlobalKey<FormState>();
  TextEditingController refferalCodeController = TextEditingController();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.only(
                left:
                    ScreenUtil().setWidth((ScreenUtil().screenWidth - 213) / 2),
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
                                          // Api.post.call(context,
                                          //     method: "refer/apply",
                                          //     param: params,
                                          //     isLoading: false,
                                          //     onResponseSuccess:
                                          //         (Map object) {
                                          //       var result =
                                          //       UserUpdatedResponse.fromJson(
                                          //           object);
                                          //       Constants.toastMessage(
                                          //           msg: result.message);
                                          //       refferalCodeController.text = "";
                                          //       if (result.message!.contains(
                                          //           "Referral Applied")) {
                                          //         isReferred = false;
                                          //         myInfoResponse!
                                          //             .result!.referredBy =
                                          //             refferalCodeController.text;
                                          //         setStates(() {});
                                          //       }
                                          //     });
                                        }
                                      },
                                      child: Text("Submit",
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(14),
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
                                              fontSize: ScreenUtil().setSp(14),
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

void showPerDayPostDialog(BuildContext context) async {
  var result = await showDialog(
      context: context,
      builder: (BuildContext context3) {
        return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.only(
                left:
                    ScreenUtil().setWidth((ScreenUtil().screenWidth - 300) / 2),
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
      final result = await Navigator.push(
          context, MaterialPageRoute(builder: (context2) => UploadScreenOne()));
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

void showReportPostDialogFunLink(
    BuildContext context1,
    FunLinksFeedProvider provider,
    String userId,
    String postId,
    bool isComment) async {
  String newUserId =
      await Provider.of<DatabaseProvider>(context1, listen: false).getUserId();
  showDialog(
      context: context1,
      builder: (BuildContext context) {
        return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.only(
                left:
                    ScreenUtil().setWidth((ScreenUtil().screenWidth - 213) / 2),
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
                    if (userId != newUserId)
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          showReportDialog(context, postId, isComment);
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
                    if (userId != newUserId)
                      SizedBox(
                        width: ScreenUtil().setSp(46),
                        child: Divider(
                          height: ScreenUtil().setSp(1),
                          thickness: ScreenUtil().setSp(1),
                          color: lightGray,
                        ),
                      ),
                    if (userId != newUserId)
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          showRestrictAlertDialog(context, userId);
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
                    if (userId != newUserId)
                      SizedBox(
                        width: ScreenUtil().setSp(46),
                        child: Divider(
                          height: ScreenUtil().setSp(1),
                          thickness: ScreenUtil().setSp(1),
                          color: lightGray,
                        ),
                      ),
                    userId == newUserId
                        ? InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              ApiProvider()
                                  .deleteFunLinksPost(postId, context)
                                  .then((value) {
                                if (value!.success == true) {
                                  print('okkkk delete');
                                  showSnackBar(
                                      context: context1,
                                      message: value.message ?? '',
                                      isError: false);
                                  provider.deletePost(provider.getIndex);
                                }
                              });
                            },
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setSp(12),
                                    bottom: ScreenUtil().setSp(12)),
                                child: Text("Delete",
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(14),
                                        color: darkGray))),
                          )
                        : InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              showBlockAlertDialog(userId, context);
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

void showReportDialog(BuildContext context, String postId, bool isComment) {
  final GlobalKey<FormState> _reportKey = GlobalKey<FormState>();
  String _postSingleValue = "";
  TextEditingController reportPostController = new TextEditingController();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.only(
                left:
                    ScreenUtil().setWidth((ScreenUtil().screenWidth - 213) / 2),
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
                                                context, postId, isComment);
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
                                                    "users/report/comment/$postId",
                                                param: params,
                                                onResponseSuccess:
                                                    (Map object) {
                                              var result =
                                                  UserUpdatedResponse.fromJson(
                                                      object);
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
                                                context, postId, isComment);
                                          } else {
                                            Map<String, dynamic> params = {
                                              "body": _postSingleValue ==
                                                      "other"
                                                  ? reportPostController.text
                                                  : "null",
                                              "type": _postSingleValue,
                                            };

                                            var provider = Provider.of<
                                                    FunLinksFeedProvider>(
                                                context,
                                                listen: false);
                                            provider
                                                .deletePost(provider.getIndex);
                                            print(
                                                "get post click ${provider.getIndex}");
                                            Api.post.call(context,
                                                method:
                                                    "users/report/post/$postId",
                                                param: params,
                                                onResponseSuccess:
                                                    (Map object) {
                                              var result =
                                                  UserUpdatedResponse.fromJson(
                                                      object);
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
                                              fontSize: ScreenUtil().setSp(14),
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
                                              fontSize: ScreenUtil().setSp(14),
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

void showOtherReportDialog(
    BuildContext context, String postId, bool isComment) {
  TextEditingController reportPostController = new TextEditingController();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.only(
                left:
                    ScreenUtil().setWidth((ScreenUtil().screenWidth - 245) / 2),
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
                              topLeft: Radius.circular(ScreenUtil().setSp(16)),
                              topRight:
                                  Radius.circular(ScreenUtil().setSp(16))),
                          borderSide: BorderSide(
                            width: 1,
                            color: buttonBlue,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(ScreenUtil().setSp(16)),
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
                              // if (isComment) {
                              //   if (_postSingleValue.isNotEmpty) {
                              //     Map<String, dynamic> params = {
                              //       "body": _postSingleValue == "other"
                              //           ? reportPostController.text
                              //           : "null",
                              //       "type": _postSingleValue,
                              //     };
                              //     Api.post.call(context,
                              //         method: "users/report/comment/$postId",
                              //         param: params,
                              //         onResponseSuccess: (Map object) {
                              //           var result =
                              //           UserUpdatedResponse.fromJson(object);
                              //           Constants.toastMessage(
                              //               msg: result.message);
                              //           _postSingleValue = "";
                              //           reportPostController.text = "";
                              //           Navigator.of(context).pop();
                              //         });
                              //   }
                              // } else {
                              //   if (_postSingleValue.isNotEmpty) {
                              //     Map<String, dynamic> params = {
                              //       "body": _postSingleValue == "other"
                              //           ? reportPostController.text
                              //           : "null",
                              //       "type": _postSingleValue,
                              //     };
                              //     Api.post.call(context,
                              //         method: "users/report/post/$postId",
                              //         param: params,
                              //         onResponseSuccess: (Map object) {
                              //           var result =
                              //           UserUpdatedResponse.fromJson(object);
                              //           Constants.toastMessage(
                              //               msg: result.message);
                              //           _postSingleValue = "";
                              //           reportPostController.text = "";
                              //           Navigator.pop(context);
                              //         });
                              //   }
                              // }
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

showBlockAlertDialog(String userId, BuildContext context) {
  final funda = Provider.of<FunLinksFeedProvider>(context, listen: false);
  // set up the button
  Widget okButton = TextButton(
    child: Text("Yes", style: GoogleFonts.nunitoSans(color: lightRed)),
    onPressed: () async {

      Navigator.pop(context, true);
      Api.post.call(context, method: "users/block/$userId", param: {},
          onResponseSuccess: (Map object) {
        funda.blocktUser(userId);
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

showRestrictAlertDialog(BuildContext context, String userId) {
  final postdata =
  Provider.of<FunLinksFeedProvider>(context, listen: false);
  // set up the button
  Widget okButton = TextButton(
    child: Text("Yes", style: GoogleFonts.nunitoSans(color: lightRed)),
    onPressed: () async {
      Navigator.pop(context, true);
      Api.post.call(context, method: "users/restrict/$userId", param: {},
          onResponseSuccess: (Map object) {

        postdata.restrictUser(userId);
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

void showFamLinkShareDialog(
    BuildContext context, String path, String type, int index, int ind) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<FunLinksFeedProvider>(
            builder: (context, dataFunLink, child) {
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
                        var data = Provider.of<FunLinksFeedProvider>(context,
                                listen: false)
                            .funLinksList[index];
                        Sharedynamic.shareprofile(data.id.toString(),
                            "funlinkfeed", data.description.toString());
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
                        Navigator.pop(context);
                        Sharefiles()
                            .onShareFun(path, type, index, ind, context);
                        //  _onShare(path, type, index);
                      },
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setSp(12),
                              bottom: ScreenUtil().setSp(12)),
                          child: Text(
                              dataFunLink.funLinksList[index].media![ind]
                                          .type ==
                                      "video"
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
      });
}

void showFunLinkShareDialog(
    BuildContext context, FunlinksFeedPostModel data, int ind) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
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
                        Navigator.pop(context2);
                        Share.share(
                          '${ApiProvider.shareUrl}post/funlinks/${data.postModel.postId}',
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
                        //_onFunLinkShare(data);
                      },
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setSp(12),
                              bottom: ScreenUtil().setSp(12)),
                          child: Text(
                              data.mediaList[ind].mediaType == "video"
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

void showFollowLinkShareDialog(
    BuildContext context, FollowFeedPostModel data, int ind) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
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
                        Navigator.pop(context2);
                        Share.share(
                          '${ApiProvider.shareUrl}post/${data.postModel.type}/${data.postModel.postId}',
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
                        // _onFollowLinkShare(data);
                      },
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setSp(12),
                              bottom: ScreenUtil().setSp(12)),
                          child: Text(
                              data.mediaList[ind].mediaType == "video"
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
