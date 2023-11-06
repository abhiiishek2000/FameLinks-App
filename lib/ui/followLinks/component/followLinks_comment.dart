import 'package:famelink/ui/followLinks/component/report_dialogs.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../models/CommentListResponse.dart';
import '../../../networking/config.dart';
import '../../../util/constants.dart';
import '../../../util/time_convert.dart';
import '../../profile/agency_other_profile_screen.dart';
import '../../profile/agency_profile_screen.dart';
import '../../profile/brand_other_profile_screen.dart';
import '../../profile/brand_profile_screen.dart';
import '../../profile/other_profile_screen.dart';
import '../../profile/profile_screen.dart';
import '../provider/FollowLinksFeedProvider.dart';
import 'followLinks_reply.dart';

class FollowLinksComment extends StatefulWidget {
  FollowLinksComment(
      {Key? key,
      required this.type,
      required this.newUserId,
      required this.userId,
      required this.postId})
      : super(key: key);
  String type;
  String postId;
  String newUserId;
  String userId;

  @override
  State<FollowLinksComment> createState() => _FollowLinksCommentState();
}

class _FollowLinksCommentState extends State<FollowLinksComment> {
  var focusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ScrollController commentScrollController = ScrollController();




  @override
  void initState() {
    Provider.of<FollowLinksFeedProvider>(context, listen: false)
        .getCommentData(context, widget.type, widget.postId);
    commentScrollController.addListener(() {
      if(commentScrollController.position.maxScrollExtent==commentScrollController.offset){
        Provider.of<FollowLinksFeedProvider>(context, listen: false)
            .getCommentData(context, widget.type, widget.postId,isPaginate: true);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FollowLinksFeedProvider>(
        builder: (context, provider, child) {
      return Column(
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
              controller: provider.commentController,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please write comment';
                }
              },
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
                  suffixIcon: IconButton(
                      onPressed: () async {
                        if (provider.followLinkList[provider.getIndex].type ==
                            "famelinks") {
                          if (formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            Navigator.pop(context);
                            Map<String, dynamic> params = {
                              "body": provider.commentController.text,
                            };
                            provider
                                .addComment(
                                    context, widget.type, widget.postId, params)
                                .then((value) {});
                          }
                        } else if (provider.followLinkList[provider.getIndex].type ==
                            "funlinks") {
                          if (formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            Navigator.pop(context);
                            Map<String, dynamic> params = {
                              "body": provider.commentController.text,
                            };
                            provider
                                .addComment(
                                context, widget.type, widget.postId, params)
                                .then((value) {});
                          }
                        } else if (provider.followLinkList[provider.getIndex].type ==
                            "followlinks") {
                          if (formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            Navigator.pop(context);
                            Map<String, dynamic> params = {
                              "body": provider.commentController.text,
                            };
                            provider
                                .addComment(
                                context, widget.type, widget.postId, params)
                                .then((value) {});
                          }
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
                  "Comments: ${provider.commentResult != null ? NumberFormat.compactCurrency(
                      decimalDigits: 0,
                      symbol:
                          '', // if you want to add currency symbol then pass that in this else leave it empty.
                    ).format(provider.commentResult!.count) : ""}",
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
            child: RefreshIndicator(
              onRefresh: () async{
                provider.getCommentData(context, widget.type, widget.postId);
              },
              child: ListView.builder(
                controller: commentScrollController,
                itemCount: provider.commentList.length,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  Comment comment = provider.commentList[index];
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
                          width: ScreenUtil().setWidth(10),
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
                                          provider.commentLike(
                                              context, comment, widget.type,index);
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
                                        provider.getCommentReplies(context, comment.sId!).then((value) {
                                          showModalBottomSheet(
                                              context: context,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(
                                                          20))),
                                              builder: (BuildContext context) {
                                                return FollowLinksReplyView(postId: widget.postId, userId: widget.userId, newUserId: widget.newUserId, type: widget.type, index: index, comment: comment);
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
                                        visible: widget.newUserId == comment.user!.sId,
                                        child: InkWell(
                                          child: Icon(
                                            Icons.delete,
                                            size: ScreenUtil().setSp(18),
                                          ),
                                          onTap: () async {
                                            provider.deleteComment(
                                                context, widget.type, comment,index);
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
                                  Provider.of<FollowLinksFeedProvider>(context,
                                      listen: false),
                                  comment.userId!,
                                  comment.sId!,
                                  true);
                            },
                          ),
                          visible: widget.newUserId != comment.user!.sId,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    });
  }
}
