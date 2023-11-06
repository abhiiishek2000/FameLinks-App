import 'package:famelink/models/CommentListResponse.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../networking/config.dart';
import '../../../../providers/FeedProvider/GetParticularUserProfileProvider.dart';
import '../../../../util/config/color.dart';
import '../../../../util/constants.dart';
import '../../../challenge/ChallengeDetailsScreen.dart';
import '../../../profile/agency_other_profile_screen.dart';
import '../../../profile/agency_profile_screen.dart';
import '../../../profile/brand_other_profile_screen.dart';
import '../../../profile/brand_profile_screen.dart';
import '../../../profile/other_profile_screen.dart';
import '../../../profile/profile_screen.dart';

class buildCommentSheet extends StatelessWidget {
  buildCommentSheet(
      {Key? key,
      required this.comment,
      required this.index,
      required this.type,
      required this.postId,
      required this.userId,
      required this.isFollowLink})
      : super(key: key);

  final Comment comment;
  // final StateSetter setCommentStates;
  final int index;
  final String type;
  final String postId;
  final String userId;
  final bool isFollowLink;
  @override
  Widget build(BuildContext context) {
    return Consumer<GetParticularFameLinksProfileProvider>(
      builder: (context, postMdl, child) {
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
                controller: postMdl!.replayController,
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    color: darkGray,
                    fontSize: ScreenUtil().setSp(14)),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, top: 10),
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
                    errorText:
                        postMdl!.commentValidate ? 'Write a reply' : null,
                    suffixIcon: IconButton(
                        onPressed: () async {
                          if (!postMdl!.replayController.text.isEmpty) {
                            postMdl!.replayComments(
                                context, comment, postId, type, isFollowLink);
                          }
                        },
                        icon: SvgPicture.asset(
                            "assets/icons/svg/comment_send.svg"))),
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height / 2) -
                  ScreenUtil().setSp(50),
              child: ListView.builder(
                controller: postMdl!.commentRepliesScrollController,
                shrinkWrap: true,
                itemCount: postMdl!.commentRepliesList.length,
                itemBuilder: (BuildContext context, int index) {
                  Comment comment = postMdl!.commentRepliesList[index];
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
                                          builder: (context) =>
                                              ProfileScreen()));
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
                          visible: Constants.userId == comment.user!.sId ||
                              Constants.userId == userId,
                          child: InkWell(
                            child: Icon(
                              Icons.delete,
                              size: ScreenUtil().setSp(18),
                            ),
                            onTap: () async {
                              postMdl!.deleteComment(context, type, comment);
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
      },
    );
  }
}
