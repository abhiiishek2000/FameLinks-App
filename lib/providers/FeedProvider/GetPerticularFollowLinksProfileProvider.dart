import 'package:famelink/common/common_routing.dart';
import 'package:famelink/databse/db_provider.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/userUpdateResponse.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/profile/agency_other_profile_screen.dart';
import 'package:famelink/ui/profile/agency_profile_screen.dart';
import 'package:famelink/ui/profile/brand_other_profile_screen.dart';
import 'package:famelink/ui/profile/brand_profile_screen.dart';
import 'package:famelink/ui/profile/other_profile_screen.dart';
import 'package:famelink/ui/profile/profile_screen.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../models/CommentListResponse.dart';
import '../../../util/custom_snack_bar.dart';
import '../../models/likes_model.dart';
import '../../networking/newconfig.dart';
import '../../share/firebasedynamiclink.dart';
import '../../ui/challenge/ChallengeDetailsScreen.dart';
import '../../ui/followLinks/component/report_dialogs.dart';
import '../../ui/otherUserProfile/model/OtherUserProfileFunlinksPostModel.dart';
import '../../ui/otherUserProfile/provder/ShareFunction.dart';
import '../../ui/otherUserProfile/ui/widget/buildCommentSheet.dart';
import '../../util/AdHelper.dart';

class GetParticularFollowLinksProfileProvider extends ChangeNotifier {
  OtherUserProfileFunlinksPostModel getParticularFunUserProfileModelResultList =
      OtherUserProfileFunlinksPostModel();
  bool getParticularFollowLinksProfileLoading = false;
  bool isMute = true;
  bool detailShow = false;
  int index = 0;

  final ApiProvider api = ApiProvider();
  NewApiProvider napi = NewApiProvider();
  TextEditingController reportPostController = new TextEditingController();
  TextEditingController replayController = new TextEditingController();
  TextEditingController commentController = new TextEditingController();
  var focusNode = FocusNode();
  bool isPlaying = true;

  var controller;
  var controllerMultipleImage;
  PageController? smoothPageController;
  final GlobalKey four = GlobalKey();
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

  int commentPage = 1;

  //final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  int commentRepliesPage = 1;
  CommentResult? commentResult;
  List<Comment> commentRepliesList = [];
  List<Comment> commentList = [];
  final GlobalKey<FormState> reportKey = GlobalKey<FormState>();
  bool isLike = false;
  bool isAdLoaded = false;
  NativeAd? ad;
  InterstitialAd? interstitialAd;
  final ApiProvider _api = ApiProvider();

  void likeFunLinks(int? i, BuildContext context) async {
    if (i == null) {
      Map<String, dynamic> map = {
        "status": null,
      };
      Api.post.call(context,
          method:
              "media/followlinks/like/media/${getParticularFunUserProfileModelResultList.result![getIndex].sId}",
          param: map,
          isLoading: false, onResponseSuccess: (Map object) {
        var result = LikesResponse.fromJson(object);
        if (result.success == true) {
          //loadPosts();
          // likeStatus=true;
          // likeStatusHalf=false;
          // likeStatusNun=false;
          getParticularFunUserProfileModelResultList
              .result![getIndex].likeStatus = null;
          getParticularFunUserProfileModelResultList
              .result![getIndex].likesCount = result.result!.likesCount;
        } else {
          getParticularFunUserProfileModelResultList
              .result![getIndex].likeStatus = 2;
          getParticularFunUserProfileModelResultList.result![getIndex]
              .likesCount = getParticularFunUserProfileModelResultList
                  .result![getIndex].likesCount! +
              1;
        }
        isLike = false;
      });
    } else {
      Map<String, dynamic> map = {
        "status": i != null ? i.toString() : null,
      };
      Api.post.call(context,
          method:
              "media/followlinks/like/media/${getParticularFunUserProfileModelResultList.result![getIndex].sId}",
          param: map,
          isLoading: false, onResponseSuccess: (Map object) {
        var result = LikesResponse.fromJson(object);
        if (result.success == true) {
          //loadPosts();
          // likeStatus=true;
          // likeStatusHalf=false;
          // likeStatusNun=false;

          getParticularFunUserProfileModelResultList
              .result![getIndex].likeStatus = 2;
          getParticularFunUserProfileModelResultList
              .result![getIndex].likesCount = result.result!.likesCount;
        } else {
          getParticularFunUserProfileModelResultList
              .result![getIndex].likeStatus = null;

          getParticularFunUserProfileModelResultList.result![getIndex]
              .likesCount = getParticularFunUserProfileModelResultList
                  .result![getIndex].likesCount! -
              1;
        }
        isLike = false;
      });
      notifyListeners();
    }
  }

  void showFamLinkShareDialog(
      BuildContext context, String path, String type, int index) {
    final data = getParticularFunUserProfileModelResultList.result![index];

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
                          Sharedynamic.shareprofile(data.sId.toString(),
                              "followlinkfeed", data.description.toString());
                          Navigator.pop(context);
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
                          // Navigator.pop(context2);
                          ShareFunction().onShare(path, type, index, context);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setSp(12),
                                bottom: ScreenUtil().setSp(12)),
                            child: Text(
                                // data.media[ind].mediaType == "video"
                                //     ? "Share Video"
                                //     : "Share Image",
                                "Share Image",
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
                                        '${comment.likesCount! > 0 ? comment.likesCount : 0} likes',
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
                                              color: white,
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
                                        GetParticularFollowLinksProfileProvider>(
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
      GetParticularFollowLinksProfileProvider provider,
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
                                    .deleteFollowLinksPost(postId, context)
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

      commentResult = result.result;
      commentList = result.result!.data!;
      notifyListeners();
    });
  }

  followLinks() {
    ad = NativeAd(
      adUnitId: AdHelper.followLinksFeed,
      factoryId: 'famelink',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          //setState(() {
          isAdLoaded = true;
          // });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );
    ad!.load();
  }

  getFollowLinkFeedData(BuildContext? context, String id, String userid) async {
    getParticularFollowLinksProfileLoading = true;
    // getParticularFunUserProfileModelResultList =
    //     (await _api.getParticularUserProfileFollowLinks(id, followPage))!;

    var data = await napi.getSharefamelink(id, userid);
    if (data != null) {
      //  getParticularFunUserProfileModelResultList=data;
    }
    getParticularFollowLinksProfileLoading = false;
    notifyListeners();
  }

  bool get getIsMute {
    return isMute;
  }

  void changeIsMute(bool value) {
    isMute = value;
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

  void deletePost(int index) {
    getParticularFunUserProfileModelResultList.result!.removeAt(index);
    notifyListeners();
  }
}
