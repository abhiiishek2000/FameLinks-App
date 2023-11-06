import 'package:famelink/common/common_routing.dart';
import 'package:famelink/ui/otherUserProfile/model/OtherUserProfileFunlinksPostModel.dart';
import 'package:famelink/ui/profile/agency_other_profile_screen.dart';
import 'package:famelink/ui/profile/agency_profile_screen.dart';
import 'package:famelink/ui/profile/brand_other_profile_screen.dart';
import 'package:famelink/ui/profile/brand_profile_screen.dart';
import 'package:famelink/ui/profile/other_profile_screen.dart';
import 'package:famelink/ui/profile/profile_screen.dart';
import 'package:famelink/util/custom_snack_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../databse/db_provider.dart';
import '../../dio/api/api.dart';
import '../../models/CommentListResponse.dart';
import '../../models/likes_model.dart';
import '../../models/userUpdateResponse.dart';
import '../../networking/config.dart';
import '../../networking/newconfig.dart';
import '../../ui/challenge/ChallengeDetailsScreen.dart';
import '../../ui/funlinks/component/report_dialogs.dart';
import '../../ui/otherUserProfile/ui/widget/buildCommentSheet.dart';
import '../../util/config/color.dart';
import '../../util/constants.dart';

class GetParticularFunLinksProfileProvider extends ChangeNotifier {
  OtherUserProfileFunlinksPostModel getParticularFunUserProfileModelResultList =
      OtherUserProfileFunlinksPostModel();

  final ApiProvider api = ApiProvider();
  NewApiProvider napi = NewApiProvider();
  TextEditingController reportPostController = new TextEditingController();
  TextEditingController replayController = new TextEditingController();
  TextEditingController commentController = new TextEditingController();
  var focusNode = FocusNode();

  // List<GetParticularUserProfileModelResult>  = <GetParticularUserProfileModelResult>[];
  // List<OtherUserProfileFunlinksPostModelResult> getParticularFunUserProfileModelResultList = <OtherUserProfileFunlinksPostModelResult>[];

  // List<VideoPlayerController> videoFunController = [];
  var controller;
  var controllerMultipleImage;
  PageController? smoothPageController;
  final GlobalKey _four = GlobalKey();
  bool likeStatus = false;
  bool? likeStatusHalf;
  bool? likeStatusNun;
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

  // final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  int commentRepliesPage = 1;
  CommentResult? commentResult;
  List<Comment> commentRepliesList = [];
  List<Comment> commentList = [];
  final GlobalKey<FormState> reportKey = GlobalKey<FormState>();
  NativeAd? ad;
  InterstitialAd? interstitialAd;
  bool isAdLoaded = false;

  bool getParticularFunLinksProfileLoading = false;
  bool isMute = true;
  bool isLike = false;
  bool detailShow = false;
  int index = 0;
  final ApiProvider _api = ApiProvider();

  getFollowLinkFeedData(BuildContext? context, String id, String userid) async {
    getParticularFunLinksProfileLoading = true;
    // getParticularFunUserProfileModelResultList =
    //     (await _api.getParticularUserProfileFunLinks(id, funPage))!;

    var data = await napi.getSharefamelink(id, userid);
    if (data != null) {
     // getParticularFunUserProfileModelResultList=data;
    }
    getParticularFunLinksProfileLoading = false;

    notifyListeners();
  }

  ReportDialog(String postId, bool isComment, BuildContext context) {
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
                                                  postId, isComment, context);
                                            } else {
                                              Map<String, dynamic> params = {
                                                "body": postSingleValue ==
                                                        "other"
                                                    ? reportPostController.text
                                                    : "null",
                                                "type": postSingleValue,
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
                                                postSingleValue = "";
                                                reportPostController.text = "";
                                                Navigator.of(context).pop();
                                              });
                                            }
                                          }
                                        } else {
                                          if (postSingleValue.isNotEmpty) {
                                            if (postSingleValue == "other") {
                                              Navigator.pop(context);
                                              showOtherReportDialog(
                                                  postId, isComment, context);
                                            } else {
                                              Map<String, dynamic> params = {
                                                "body": postSingleValue ==
                                                        "other"
                                                    ? reportPostController.text
                                                    : "null",
                                                "type": postSingleValue,
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
                                                postSingleValue = "";
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

  replayCount(String postId, Comment comment, BuildContext context, String type,
      String userId, bool isFollowLink) async {
    FocusScope.of(context).unfocus();
    commentId = comment.sId;
    commentRepliesPage = 1;
    Map<String, String> map = {"page": commentRepliesPage.toString()};
    Api.get.call(context,
        method: "media/${commentType}/comment/${commentId}/replies",
        param: map,
        isLoading: false, onResponseSuccess: (Map object) {
      var result = CommentListResponse.fromJson(object);
      commentResult = result.result;
      commentRepliesList = result.result!.data!;
      showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          builder: (BuildContext context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setStates) {
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
  }

  grtComment(
    BuildContext context,
  ) async {
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
      // });
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
                      .result![getIndex].user!.sId!,
                  false);
            });
          });
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
                                      replayCount(postId, comment, context,
                                          type, userId, isFollowLink);
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
                                        GetParticularFunLinksProfileProvider>(
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

  void showReportPostDialog(
      BuildContext context,
      GetParticularFunLinksProfileProvider provider,
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
                            ReportDialog(postId, isComment, context);
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
                                    .deleteFunLinksPost(postId, context)
                                    .then((value) {
                                  if (value!.success == true) {
                                    print('okkkk delete');
                                    showSnackBar(
                                        context: context,
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

  void showOtherReportDialog(
      String postId, bool isComment, BuildContext context) {
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
                                  if (postSingleValue.isNotEmpty) {
                                    Map<String, dynamic> params = {
                                      "body": postSingleValue == "other"
                                          ? reportPostController.text
                                          : "null",
                                      "type": postSingleValue,
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
                                      postSingleValue = "";
                                      reportPostController.text = "";
                                      Navigator.of(context).pop();
                                    });
                                  }
                                } else {
                                  if (postSingleValue.isNotEmpty) {
                                    Map<String, dynamic> params = {
                                      "body": postSingleValue == "other"
                                          ? reportPostController.text
                                          : "null",
                                      "type": postSingleValue,
                                    };
                                    Api.post.call(context,
                                        method: "users/report/post/${postId}",
                                        param: params,
                                        onResponseSuccess: (Map object) {
                                      var result =
                                          UserUpdatedResponse.fromJson(object);
                                      Constants.toastMessage(
                                          msg: result.message);
                                      postSingleValue = "";
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

  bool get getIsMute {
    return isMute;
  }

  void changeIsMute(bool value) {
    isMute = value;
    notifyListeners();
  }

  bool get getIsLike {
    return isLike;
  }

  void changeIsLike(bool value) {
    isLike = value;
    notifyListeners();
  }

  bool get getDetailShow {
    return detailShow;
  }

  void changeDetailShow(bool value) {
    detailShow = value;
    notifyListeners();
  }

  int get getIndex {
    return index;
  }

  void changeIndex(int value) {
    index = value;
    notifyListeners();
  }

  likeFunLinks(int? i, BuildContext context) async {
    if (i == null) {
      Map<String, dynamic> map = {
        "status": null,
      };
      getParticularFunUserProfileModelResultList.result![getIndex].likeStatus =
          null;
      getParticularFunUserProfileModelResultList.result![getIndex].likesCount =
          getParticularFunUserProfileModelResultList
                  .result![getIndex].likesCount! -
              1;

      notifyListeners();

      Api.post.call(context,
          method:
              "media/funlinks/like/media/${getParticularFunUserProfileModelResultList.result![getIndex].sId}",
          param: map,
          isLoading: false, onResponseSuccess: (Map object) {
        var result = LikesResponse.fromJson(object);
        if (result.success == true) {
        } else {}
      });
    } else {
      Map<String, dynamic> map = {
        "status": i != null ? i.toString() : null,
      };
      getParticularFunUserProfileModelResultList.result![getIndex].likeStatus =
          2;
      getParticularFunUserProfileModelResultList.result![getIndex].likesCount =
          getParticularFunUserProfileModelResultList
                  .result![getIndex].likesCount! +
              1;
      notifyListeners();
      Api.post.call(context,
          method:
              "media/funlinks/like/media/${getParticularFunUserProfileModelResultList.result![getIndex].sId}",
          param: map,
          isLoading: false, onResponseSuccess: (Map object) {
        var result = LikesResponse.fromJson(object);
        if (result.success == true) {
        } else {}
      });
    }
  }

  void deletePost(int index) {
    getParticularFunUserProfileModelResultList.result!.removeAt(index);
    notifyListeners();
  }
}
