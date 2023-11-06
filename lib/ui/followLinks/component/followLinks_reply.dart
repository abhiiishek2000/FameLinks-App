
import 'package:famelink/ui/followLinks/provider/FollowLinksFeedProvider.dart';
import 'package:famelink/ui/profile/other_profile_screen.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../models/CommentListResponse.dart';
import '../../../networking/config.dart';
import '../../../util/constants.dart';
import '../../../util/time_convert.dart';
import '../../profile/agency_other_profile_screen.dart';
import '../../profile/agency_profile_screen.dart';
import '../../profile/brand_other_profile_screen.dart';
import '../../profile/brand_profile_screen.dart';
import '../../profile/profile_screen.dart';

class FollowLinksReplyView extends StatefulWidget {
   FollowLinksReplyView({Key? key,required this.postId,required this.userId,required this.newUserId,required this.type,required this.index,required this.comment}) : super(key: key);
  Comment comment;
  int index;
  String type;
  String postId;
  String newUserId;
  String userId;
  @override
  State<FollowLinksReplyView> createState() => _FollowLinksReplyViewState();
}

class _FollowLinksReplyViewState extends State<FollowLinksReplyView> {

  var focusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ScrollController commentRepliesScrollController = ScrollController();



  @override
  void initState() {
    commentRepliesScrollController.addListener(() {
      if(commentRepliesScrollController.position.maxScrollExtent == commentRepliesScrollController.offset){
        Provider.of<FollowLinksFeedProvider>(context,listen: false).getCommentReplies(context, widget.comment.sId!,isPaginate: true);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FollowLinksFeedProvider>(builder: (context,provider,child){
      return Column(
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
                      text: "${widget.comment.user!.name} : ",
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
              controller: provider.replayController,
              validator: (String? value){
                if(value!.isEmpty){
                  return 'Please write something...';
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
                  hintText: "Write a reply",
                  hintStyle: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                      color: lightGray,
                      fontSize: ScreenUtil().setSp(14)),
                  suffixIcon: IconButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          Map<String, dynamic> params = {
                            "parentId": widget.comment.sId,
                            "body": provider.replayController.text,
                          };
                          provider.addReplies(context, widget.type, widget.postId, params, widget.comment);
                        }
                      },
                      icon: SvgPicture.asset(
                          "assets/icons/svg/comment_send.svg"))),
            ),
          ),
          SizedBox(
            height: (MediaQuery.of(context).size.height / 2) -
                ScreenUtil().setSp(50),
            child: RefreshIndicator(
              onRefresh: () async{
                provider.getCommentReplies(context, widget.comment.sId!);
              },
              child: ListView.builder(
                controller: commentRepliesScrollController,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: provider.commentRepliesList.length,
                itemBuilder: (BuildContext context, int index) {
                  Comment comment = provider.commentRepliesList[index];
                  DateTime now = DateTime.parse(comment.createdAt!);
                  return Container(
                    margin: EdgeInsets.all(ScreenUtil().setSp(10)),
                    padding: EdgeInsets.only(right: ScreenUtil().setSp(10)),
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
                                        child: Text(convertToAgo(now),
                                            style: TextStyle(fontSize: 12))),
                                  ],
                                  mainAxisSize: MainAxisSize.min,
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            )),
                        Visibility(
                          visible: widget.newUserId == comment.user!.sId,
                          child: InkWell(
                            child: Icon(
                              Icons.delete,
                              size: ScreenUtil().setSp(18),
                            ),
                            onTap: () async {
                              provider.deleteReplies(context, widget.type, comment, index);
                            },
                          ),
                        ),
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
