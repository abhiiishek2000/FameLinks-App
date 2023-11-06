import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../providers/FeedProvider/GetParticularUserProfileProvider.dart';
import '../../../../util/config/color.dart';

class showOtherReportDialogs extends StatelessWidget {
  showOtherReportDialogs(
      {Key? key, required this.postId, required this.isComment})
      : super(key: key);
  final String postId;
  final bool isComment;
  @override
  Widget build(BuildContext context) {
    return Consumer<GetParticularFameLinksProfileProvider>(
      builder: (context, postMdl, child) {
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
                      controller: postMdl!.reportPostController,
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
                              if (isComment) {
                                if (postMdl!.postSingleValue.isNotEmpty) {
                                  postMdl!.reportComment(context, postId);
                                }
                              } else {
                                if (postMdl!.postSingleValue.isNotEmpty) {
                                  postMdl!.reportPost(context, postId);
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
      },
    );
  }
}
