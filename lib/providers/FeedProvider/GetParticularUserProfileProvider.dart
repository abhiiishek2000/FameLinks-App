import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:famelink/common/common_routing.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/CommentListResponse.dart';
import 'package:famelink/models/userUpdateResponse.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/otherUserProfile/model/GetParticularUserProfileModel.dart';
import 'package:famelink/ui/profile/agency_other_profile_screen.dart';
import 'package:famelink/ui/profile/agency_profile_screen.dart';
import 'package:famelink/ui/profile/brand_other_profile_screen.dart';
import 'package:famelink/ui/profile/brand_profile_screen.dart';
import 'package:famelink/ui/profile/other_profile_screen.dart';
import 'package:famelink/ui/profile/profile_screen.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:famelink/util/custom_snack_bar.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../databse/db_provider.dart';
import '../../models/CommentAddResponse.dart';
import '../../models/likes_model.dart';
import '../../networking/newconfig.dart';
import '../../ui/challenge/ChallengeDetailsScreen.dart';
import '../../ui/fameLinks/component/post_report_dialog.dart';
import '../../ui/otherUserProfile/ui/widget/buildCommentSheet.dart';
import '../../util/AdHelper.dart';

class GetParticularFameLinksProfileProvider extends ChangeNotifier {
  GetParticularUserProfileModel getParticularFunUserProfileModelResultList =
      GetParticularUserProfileModel();

  bool getParticularFameLinksProfileLoading = false;
  bool isMute = true;
  bool isLike0 = false;
  bool isLike1 = false;
  bool isLike2 = false;
  int index = 0;
  bool detailShow = false;
  bool likeStatus = false;
  bool? likeStatusHalf;
  bool? likeStatusNun;

  final ApiProvider api = ApiProvider();
  TextEditingController reportPostController = new TextEditingController();
  TextEditingController replayController = new TextEditingController();
  TextEditingController commentController = new TextEditingController();
  var focusNode = FocusNode();

  bool isPlaying = true;
  var controller;
  var controllerMultipleImage;
  PageController? smoothPageController;
  final GlobalKey four = GlobalKey();
  NewApiProvider napi = NewApiProvider();
  NativeAd? ad;
  InterstitialAd? interstitialAd;
  bool isAdLoaded = false;

  int likeCount = 0;
  ScrollController commentRepliesScrollController = ScrollController();
  bool commentValidate = false;
  int likeCountHalf = 0;
  ScrollController commentScrollController = ScrollController();
  int count = 0;
  String postSingleValue = "";
  int ind = 0;
  String? commentType;
  String? commentPostId;
  String? commentId;
  String defaultPath = '';
  int commentPage = 1;

  //final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  int commentRepliesPage = 1;
  CommentResult? commentResult;
  List<Comment> commentRepliesList = [];
  List<Comment> commentList = [];
  final GlobalKey<FormState> reportKey = GlobalKey<FormState>();

  getFollowLinkFeedData(BuildContext? context, String id, String userid) async {
    getParticularFameLinksProfileLoading = true;
    // getParticularFunUserProfileModelResultList =
    //     (await _api.getParticularUserProfile(id, famePage))!;

    var data = await napi.getSharefamelink(id, userid);
    if (data != null) {
      // getParticularFunUserProfileModelResultList=data;
    }

    log('Profile id$id ${getParticularFunUserProfileModelResultList.result!.length}');
    getParticularFameLinksProfileLoading = false;
    notifyListeners();
  }

  deleteComment(BuildContext context, String type, Comment comment) async {
    Api.delete.call(context,
        method: "media/${type}/comment/${comment.sId}",
        param: {}, onResponseSuccess: (Map object) {
      // setStates(() {
      commentRepliesList.removeAt(index);
      //  });

      // setCommentStates(() {
      commentList[index].repliesCount = comment.repliesCount != null
          ? comment.repliesCount == 0
              ? 0
              : comment.repliesCount! - 1
          : 0;
      //  });
    });
  }

  replayComments(BuildContext context, Comment comment, String postId,
      String type, bool isFollowLink) async {
    FocusScope.of(context).unfocus();
    Map<String, dynamic> params = {
      "parentId": comment.sId,
      "body": replayController.text,
    };
    Api.post.call(context,
        method: "media/${type}/comment/${postId}",
        param: params,
        isLoading: false, onResponseSuccess: (Map object) {
      var result = CommentAddResponse.fromJson(object);
      Constants.toastMessage(msg: result.message);

      replayController.text = "";
      getCommentData(type, postId, isFollowLink, context);

      // setCommentStates(() {
      commentList[index].repliesCount =
          comment.repliesCount != null ? comment.repliesCount! + 1 : 1;
      // });
      Navigator.pop(context);
      notifyListeners();
    });
  }

  getCommentalert(BuildContext context) async {
    Map<String, String> map = {"page": commentPage.toString()};
    // for(int i=0;i<fameLinkUserProfileModel.result!!.length;i++){
    //
    // }
    Api.get.call(context,
        method:
            "media/${commentType}/comment/${getParticularFunUserProfileModelResultList.result![getIndex].sId}",
        param: map, onResponseSuccess: (Map object) {
      var result = CommentListResponse.fromJson(object);

      commentResult = result.result;
      commentList = result.result!.data!;
      notifyListeners();
      showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          builder: (BuildContext context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setStates) {
              return buildSheet(
                  context,
                  setStates,
                  'famelinks',
                  getParticularFunUserProfileModelResultList
                      .result![getIndex].sId!,
                  getParticularFunUserProfileModelResultList
                      .result![getIndex].users!.sId!,
                  false);
            });
          });
    });
  }

  void showReportDialog(BuildContext context, String postId, bool isComment) {
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
                  key: reportKey,
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
                                  groupValue: postSingleValue,
                                  onChanged: (value) => setStates(
                                    () => postSingleValue = "nudity",
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
                                  groupValue: postSingleValue,
                                  onChanged: (value) => setStates(
                                    () => postSingleValue = "spam",
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
                                  groupValue: postSingleValue,
                                  onChanged: (value) => setStates(
                                    () => postSingleValue = "vulgarity",
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
                                  groupValue: postSingleValue,
                                  onChanged: (value) => setStates(
                                    () => postSingleValue = "abusive",
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
                                  groupValue: postSingleValue,
                                  onChanged: (value) => setStates(
                                    () => postSingleValue = "rasicm",
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
                                  groupValue: postSingleValue,
                                  onChanged: (value) => setStates(
                                    () => postSingleValue = "copyright",
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
                                  groupValue: postSingleValue,
                                  onChanged: (value) => setStates(
                                    () => postSingleValue = "other",
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
                                          if (postSingleValue.isNotEmpty) {
                                            if (postSingleValue == "other") {
                                              Navigator.pop(context);
                                              showOtherReportDialog(
                                                  context, postId, isComment);
                                            } else {
                                              reportComment(context, postId);
                                            }
                                          }
                                        } else {
                                          if (postSingleValue.isNotEmpty) {
                                            if (postSingleValue == "other") {
                                              Navigator.pop(context);
                                              showOtherReportDialog(
                                                  context, postId, isComment);
                                            } else {
                                              reportPost(context, postId);
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

  Widget buildSheet(BuildContext context, StateSetter setCommentStates,
          String type, String postId, String userId, bool isFollowLink) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(
                bottom: ScreenUtil().setWidth(9),
                left: ScreenUtil().setWidth(13),
                right: ScreenUtil().setWidth(16),
                top: ScreenUtil().setHeight(6)),
            height: 50,
            child: TextFormField(
              focusNode: focusNode,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              //Normal textInputField will be displayed
              maxLines: 4,
              controller: commentController,
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: darkGray,
                  fontSize: ScreenUtil().setSp(14)),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 1,
                      color: buttonBlue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 1,
                      color: buttonBlue,
                    ),
                  ),
                  hintText: "Write Comment",
                  hintStyle: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                      color: lightGray,
                      fontSize: ScreenUtil().setSp(14)),
                  errorText: commentValidate ? 'Write a comment' : null,
                  suffixIcon: IconButton(
                      onPressed: () async {
                        if (!commentController.text.isEmpty) {
                          FocusScope.of(context).unfocus();
                          Map<String, dynamic> params = {
                            "body": commentController.text,
                          };
                          Api.post.call(context,
                              method: "media/${type}/comment/${postId}?page=1",
                              param: params,
                              isLoading: false,
                              onResponseSuccess: (Map object) {
                            var result = UserUpdatedResponse.fromJson(object);
                            Constants.toastMessage(msg: result.message);
                            setCommentStates(() {
                              commentController.text = "";
                              getCommentData(
                                  type, postId, isFollowLink, context);
                            });
                            Navigator.pop(context);
                          });
                        }
                      },
                      icon: SvgPicture.asset(
                          "assets/icons/svg/comment_send.svg"))),
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
                          onTap: () {},
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
                        width: ScreenUtil().setWidth(10),
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              //print(comment.sId);
                              gotoOtherProfileScreen(
                                  context, comment.user!.sId!, 0);
                            },
                            child: RichText(
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
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(5),
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
                                                "media/${type}/like/comment/${comment.sId}",
                                            param: map,
                                            isLoading: false,
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
                                            CommentListResponse.fromJson(
                                                object);
                                        commentResult = result.result;
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
                                                  postId: postId,
                                                  userId: userId,
                                                  isFollowLink: isFollowLink,
                                                  type: type,
                                                  index: index,
                                                  comment: comment,
                                                );
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
                                              Constants.userId == userId,
                                      child: InkWell(
                                        child: Icon(
                                          Icons.delete,
                                          size: ScreenUtil().setSp(18),
                                        ),
                                        onTap: () async {
                                          Api.delete.call(context,
                                              method:
                                                  "media/${type}/comment/${comment.sId}",
                                              param: {},
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
                                context,
                                Provider.of<
                                        GetParticularFameLinksProfileProvider>(
                                    context,
                                    listen: false),
                                comment.userId!,
                                comment.sId!,
                                true);
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

  getCommentData(String type, String postId, bool isFollowLink,
      BuildContext context) async {
    commentPage = 1;
    Map<String, String> map = {"page": commentPage.toString()};
    Api.get.call(context, method: "media/${type}/comment/${postId}", param: map,
        onResponseSuccess: (Map object) {
      var result = CommentListResponse.fromJson(object);
      if (result.success == true) {
        print("==${result.message}");
      }
      // setState(() {
      commentResult = result.result;
      commentList = result.result!.data!;
      // });
      notifyListeners();
    });
  }

  reportPost(BuildContext context, String postId) async {
    Map<String, dynamic> params = {
      "body": postSingleValue == "other" ? reportPostController.text : "null",
      "type": postSingleValue,
    };
    Api.post.call(context, method: "users/report/post/${postId}", param: params,
        onResponseSuccess: (Map object) {
      var result = UserUpdatedResponse.fromJson(object);
      Constants.toastMessage(msg: result.message);
      postSingleValue = "";
      reportPostController.text = "";
      Navigator.pop(context);
    });
  }

  void showReportPostDialog(
      BuildContext context,
      GetParticularFameLinksProfileProvider provider,
      String userId,
      String postId,
      bool isComment) async {
    String newUserId =
        await Provider.of<DatabaseProvider>(context, listen: false).getUserId();
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
                              child: Text("Restrict users",
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
                                    .deleteFameLinksPost(postId, context)
                                    .then((value) {
                                  if (value!.success == true) {
                                    showSnackBar(
                                        context: context,
                                        message: value.message ?? '',
                                        isError: false);
                                    provider.deletePost(provider.index);
                                    // Navigator.pop(context, true);
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
                                showBlockAlertDialog(context, userId);
                              },
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setSp(12),
                                      bottom: ScreenUtil().setSp(12)),
                                  child: Text("Block users",
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

  reportComment(BuildContext context, String postId) async {
    Map<String, dynamic> params = {
      "body": postSingleValue == "other" ? reportPostController.text : "null",
      "type": postSingleValue,
    };
    Api.post.call(context,
        method: "users/report/comment/${postId}",
        param: params, onResponseSuccess: (Map object) {
      var result = UserUpdatedResponse.fromJson(object);
      Constants.toastMessage(msg: result.message);
      postSingleValue = "";
      reportPostController.text = "";
      Navigator.of(context).pop();
    });
  }

  fameLinks() {
    ad = NativeAd(
      adUnitId: AdHelper.famelinksFeed,
      factoryId: 'famelink',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          isAdLoaded = true;
          notifyListeners();
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );
    ad!.load();
    notifyListeners();
  }

  void onShare(
      String path, String type, int index, BuildContext context) async {
    final particularFameLink =
        Provider.of<GetParticularFameLinksProfileProvider>(context);

    if (type == "video") {
      var dir = await getApplicationDocumentsDirectory();
      bool fileExists = await File("${dir.path}/${path}").exists();
      if (fileExists) {
        Constants.progressDialog(true, context);
        File _watermarkImage =
            await getImageFileFromAssets('images/watermarkvideo.png');
        String _desFile = await _destinationFile;
        FFmpegKit.execute(
                "-i ${File("${dir.path}/${particularFameLink.getParticularFunUserProfileModelResultList.result![index].media != null ? particularFameLink.getParticularFunUserProfileModelResultList.result![index].media![0].type : defaultPath}").path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-75 -codec:a copy ${_desFile}")
            // "-i ${videoPath} -i ${_musicFile} -c copy -filter_complex [0:a]aformat = fltp:44100:stereo,apad[0a];[1] aformat=fltp:44100:stereo,volume=1.5[1a];[0a] [1a] amerge[a] -map 0:v -map [a] -ac 2 -y -shortest ${_desFile}")
            .then((return_code) async {
          Constants.progressDialog(false, context);
          Share.shareFiles(
            [_desFile],
            text:
                '${ApiProvider.shareUrl}post/famelinks/${particularFameLink.getParticularFunUserProfileModelResultList.result![index].sId}',
          );
        });
      } else {
        Constants.progressDialog(true, context);
        Dio dio = Dio();
        unawaited(dio.download(
            "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${path}",
            "${dir.path}/${path}", onReceiveProgress: (rec, total) async {
          print("Rec: $rec , Total: $total");
          if (rec == total) {
            File _watermarkImage =
                await getImageFileFromAssets('images/watermarkvideo.png');
            String _desFile = await _destinationFile;
            FFmpegKit.execute(
                    "-i ${File("${dir.path}/${particularFameLink.getParticularFunUserProfileModelResultList.result![index].media != null ? particularFameLink.getParticularFunUserProfileModelResultList.result![index].media![0].type : defaultPath}").path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-75 -codec:a copy ${_desFile}")
                // "-i ${videoPath} -i ${_musicFile} -c copy -filter_complex [0:a]aformat = fltp:44100:stereo,apad[0a];[1] aformat=fltp:44100:stereo,volume=1.5[1a];[0a] [1a] amerge[a] -map 0:v -map [a] -ac 2 -y -shortest ${_desFile}")
                .then((return_code) async {
              Constants.progressDialog(false, context);
              Share.shareFiles(
                [_desFile],
                text:
                    '${ApiProvider.shareUrl}post/famelinks/${particularFameLink.getParticularFunUserProfileModelResultList.result![index].sId}',
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
        '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${particularFameLink.getParticularFunUserProfileModelResultList.result![index].media != null ? particularFameLink.getParticularFunUserProfileModelResultList.result![index].media![0].path : defaultPath}',
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
                    '${ApiProvider.shareUrl}post/famelinks/${particularFameLink.getParticularFunUserProfileModelResultList.result![index].sId}',
              );
            });
          }
        },
      );
      print(response.data.toString());
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

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/watermark.png');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  likeHeart(int? i, int findData, BuildContext context, int index) async {
    final particularFameLink =
        Provider.of<GetParticularFameLinksProfileProvider>(context);

    print(particularFameLink
        .getParticularFunUserProfileModelResultList.result![index].sId);

    if (findData == 2) {
      if (i == 2) {
        Map<String, dynamic> map = {
          "status": i != null ? i.toString() : null,
        };
        Api.post.call(context,
            method:
                "media/famelinks/like/media/${particularFameLink.getParticularFunUserProfileModelResultList.result![index].sId}",
            param: map,
            isLoading: false, onResponseSuccess: (Map object) {
          var result = LikesResponse.fromJson(object);
          if (result.success == true) {
            //loadPosts();
            particularFameLink.changeLikeStatus(true);
            particularFameLink.changeLikeStatusHalf(false);
            particularFameLink.changeLikeStatusNun(false);

            particularFameLink
                .getParticularFunUserProfileModelResultList
                .result![particularFameLink.getIndex]
                .likes0Count = result.result!.likes0Count;
            particularFameLink
                .getParticularFunUserProfileModelResultList
                .result![particularFameLink.getIndex]
                .likes1Count = result.result!.likes1Count;
            particularFameLink
                .getParticularFunUserProfileModelResultList
                .result![particularFameLink.getIndex]
                .likes2Count = result.result!.likes2Count;

            particularFameLink.changeIsLike2(false);
          } else {
            particularFameLink.getParticularFunUserProfileModelResultList
                .result![particularFameLink.getIndex].likeStatus = null;
            particularFameLink
                .getParticularFunUserProfileModelResultList
                .result![particularFameLink.getIndex]
                .likes2Count = particularFameLink
                    .getParticularFunUserProfileModelResultList
                    .result![particularFameLink.getIndex]
                    .likes2Count! -
                1;
          }
        });
      } else if (i == null) {
        Map<String, dynamic> map = {
          "status": i != null ? i.toString() : null,
        };
        Api.post.call(context,
            method:
                "media/famelinks/like/media/${particularFameLink.getParticularFunUserProfileModelResultList.result![index].sId}",
            param: map,
            isLoading: false, onResponseSuccess: (Map object) {
          var result = LikesResponse.fromJson(object);
          if (result.success == true) {
            particularFameLink.changeLikeStatus(false);
            particularFameLink.changeLikeStatusHalf(false);
            particularFameLink.changeLikeStatusNun(false);

            print(particularFameLink.getParticularFunUserProfileModelResultList
                .result![index].likes2Count);
            particularFameLink
                .getParticularFunUserProfileModelResultList
                .result![particularFameLink.getIndex]
                .likes0Count = result.result!.likes0Count;
            particularFameLink
                .getParticularFunUserProfileModelResultList
                .result![particularFameLink.getIndex]
                .likes1Count = result.result!.likes1Count;
            particularFameLink
                .getParticularFunUserProfileModelResultList
                .result![particularFameLink.getIndex]
                .likes2Count = result.result!.likes2Count;
            //print("===========$likeCount");
          } else {
            particularFameLink.getParticularFunUserProfileModelResultList
                .result![particularFameLink.getIndex].likeStatus = 2;
            particularFameLink
                .getParticularFunUserProfileModelResultList
                .result![particularFameLink.getIndex]
                .likes2Count = particularFameLink
                    .getParticularFunUserProfileModelResultList
                    .result![particularFameLink.getIndex]
                    .likes2Count! +
                1;
          }
        });
        particularFameLink.changeIsLike2(false);
      }
    } else if (findData == 1) {
      if (i == 1) {
        Map<String, dynamic> map = {
          "status": i != null ? i.toString() : null,
        };
        Api.post.call(context,
            method:
                "media/famelinks/like/media/${particularFameLink.getParticularFunUserProfileModelResultList.result![index].sId}",
            param: map,
            isLoading: false, onResponseSuccess: (Map object) {
          var result = LikesResponse.fromJson(object);
          if (result.success == true) {
            //loadPosts();
            particularFameLink.changeLikeStatus(false);
            particularFameLink.changeLikeStatusHalf(true);
            particularFameLink.changeLikeStatusNun(false);

            particularFameLink
                .getParticularFunUserProfileModelResultList
                .result![particularFameLink.getIndex]
                .likes0Count = result.result!.likes0Count;
            particularFameLink
                .getParticularFunUserProfileModelResultList
                .result![particularFameLink.getIndex]
                .likes1Count = result.result!.likes1Count;
            particularFameLink
                .getParticularFunUserProfileModelResultList
                .result![particularFameLink.getIndex]
                .likes2Count = result.result!.likes2Count;
          } else {
            particularFameLink.getParticularFunUserProfileModelResultList
                .result![particularFameLink.getIndex].likeStatus = null;
            particularFameLink
                .getParticularFunUserProfileModelResultList
                .result![particularFameLink.getIndex]
                .likes1Count = particularFameLink
                    .getParticularFunUserProfileModelResultList
                    .result![particularFameLink.getIndex]
                    .likes1Count! -
                1;
          }
          particularFameLink.changeIsLike1(false);
        });
      } else if (i == null) {
        Map<String, dynamic> map = {
          "status": i != null ? i.toString() : null,
        };
        Api.post.call(context,
            method:
                "media/famelinks/like/media/${particularFameLink.getParticularFunUserProfileModelResultList.result![index].sId}",
            param: map,
            isLoading: false, onResponseSuccess: (Map object) {
          var result = LikesResponse.fromJson(object);
          if (result.success == true) {
            //loadPosts();
            particularFameLink.changeLikeStatus(false);
            particularFameLink.changeLikeStatusHalf(true);
            particularFameLink.changeLikeStatusNun(false);
            particularFameLink
                .getParticularFunUserProfileModelResultList
                .result![particularFameLink.getIndex]
                .likes0Count = result.result!.likes0Count;
            particularFameLink
                .getParticularFunUserProfileModelResultList
                .result![particularFameLink.getIndex]
                .likes1Count = result.result!.likes1Count;
            particularFameLink
                .getParticularFunUserProfileModelResultList
                .result![particularFameLink.getIndex]
                .likes2Count = result.result!.likes2Count;
          } else {
            particularFameLink.getParticularFunUserProfileModelResultList
                .result![particularFameLink.getIndex].likeStatus = 1;
            particularFameLink
                .getParticularFunUserProfileModelResultList
                .result![particularFameLink.getIndex]
                .likes1Count = particularFameLink
                    .getParticularFunUserProfileModelResultList
                    .result![particularFameLink.getIndex]
                    .likes1Count! +
                1;
          }
          particularFameLink.changeIsLike1(false);
        });
      }
    } else if (findData == 0) {
      Map<String, dynamic> map = {
        "status": i != null ? i.toString() : null,
      };
      Api.post.call(context,
          method:
              "media/famelinks/like/media/${particularFameLink.getParticularFunUserProfileModelResultList.result![index].sId}",
          param: map,
          isLoading: false, onResponseSuccess: (Map object) {
        var result = LikesResponse.fromJson(object);
        if (result.success == true) {
          //loadPosts();
          particularFameLink.changeLikeStatus(false);
          particularFameLink.changeLikeStatusHalf(false);
          particularFameLink.changeLikeStatusNun(false);
          particularFameLink
              .getParticularFunUserProfileModelResultList
              .result![particularFameLink.getIndex]
              .likes0Count = result.result!.likes0Count;
          particularFameLink
              .getParticularFunUserProfileModelResultList
              .result![particularFameLink.getIndex]
              .likes1Count = result.result!.likes1Count;
          particularFameLink
              .getParticularFunUserProfileModelResultList
              .result![particularFameLink.getIndex]
              .likes2Count = result.result!.likes2Count;
          //   print( getParticularUserProfileModelResultList[index]
          //       .likes0Count);

          //       if (getParticularUserProfileModelResultList[index].likeStatus == 2) {
          //   getParticularUserProfileModelResultList[index].likes2Count =
          //       getParticularUserProfileModelResultList[index].likes2Count - 1;
          // } else if (getParticularUserProfileModelResultList[index].likeStatus == 1) {
          //   getParticularUserProfileModelResultList[index].likes1Count =
          //       getParticularUserProfileModelResultList[index].likes1Count - 1;
          // }

          // if(getParticularUserProfileModelResultList[index].likeStatus == 0){
          //   getParticularUserProfileModelResultList[index].likeStatus = 4;
          // }else{
          //   getParticularUserProfileModelResultList[index].likeStatus = 0;
          // }
        } else {
          particularFameLink.getParticularFunUserProfileModelResultList
              .result![particularFameLink.getIndex].likeStatus = null;
          particularFameLink
              .getParticularFunUserProfileModelResultList
              .result![particularFameLink.getIndex]
              .likes2Count = particularFameLink
                  .getParticularFunUserProfileModelResultList
                  .result![particularFameLink.getIndex]
                  .likes2Count! -
              1;
        }
        particularFameLink.changeIsLike0(false);
      });
    }
    notifyListeners();
  }

  bool get getIsMute {
    return isMute;
  }

  void changeIsMute(bool value) {
    isMute = value;
    notifyListeners();
  }

  bool get getIsLike0 {
    return isLike0;
  }

  void changeIsLike0(bool value) {
    isLike0 = value;
    notifyListeners();
  }

  bool get getIsLike1 {
    return isLike1;
  }

  void changeIsLike1(bool value) {
    isLike1 = value;
    notifyListeners();
  }

  bool get getIsLike2 {
    return isLike2;
  }

  void changeIsLike2(bool value) {
    isLike2 = value;
    notifyListeners();
  }

  int get getIndex {
    return index;
  }

  void changeIndex(int value) {
    index = value;

    notifyListeners();
  }

  bool get getDetailShow {
    return detailShow;
  }

  void changeDetailShow(bool value) {
    detailShow = value;
    notifyListeners();
  }

  bool get getLikeStatus {
    return likeStatus;
  }

  void changeLikeStatus(bool value) {
    likeStatus = value;
    notifyListeners();
  }

  bool get getLikeStatusHalf {
    return likeStatusHalf!;
  }

  void changeLikeStatusHalf(bool value) {
    likeStatusHalf = value;
    notifyListeners();
  }

  bool get getLikeStatusNun {
    return likeStatusNun!;
  }

  void changeLikeStatusNun(bool value) {
    likeStatusNun = value;
    notifyListeners();
  }

  void deletePost(int index) {
    getParticularFunUserProfileModelResultList.result!.removeAt(index);
    notifyListeners();
  }
}
