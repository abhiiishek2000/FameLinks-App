import 'package:famelink/databse/AppDatabase.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/util/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:provider/provider.dart';

import '../../../databse/db_provider.dart';
import '../../../models/userUpdateResponse.dart';
import '../../../util/config/color.dart';
import '../../../util/constants.dart';
import '../provider/FameLinksFeedProvider.dart';

void showReportPostDialog(BuildContext context1, FameLinksFeedProvider provider,
    String userId, String postId, bool isComment) async {
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
                                  .deleteFameLinksPost(postId, context)
                                  .then((value) {
                                if (value!.success == true) {
                                  showSnackBar(
                                      context: context1,
                                      message: value.message ?? '',
                                      isError: false);
                                  provider.deletePost(provider.index);
                                }
                              });
                              // showBlockAlertDialog(context,userId);
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
  TextEditingController reportPostController = new TextEditingController();
  String _postSingleValue = "";
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
                                                    "users/report/comment/${postId}",
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
                                                    FameLinksFeedProvider>(
                                                context,
                                                listen: false);
                                            provider.deletePost(provider.index);

                                            Api.post.call(context,
                                                method:
                                                    "users/report/post/${postId}",
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


void showRestrictAlertDialog(BuildContext context, String userId) {
  final dataFameLink =
      Provider.of<FameLinksFeedProvider>(context, listen: false);

// set up the button
  Widget okButton = TextButton(
    child: Text("Yes", style: GoogleFonts.nunitoSans(color: lightRed)),
    onPressed: () async {
      final myres = Provider.of<FameLinksFeedProvider>(context, listen: false);
      myres.restrictUser(userId);

      Navigator.pop(context, true);
      Api.post.call(context, method: "users/restrict/${userId}", param: {},
          onResponseSuccess: (Map object) {
        var result = UserUpdatedResponse.fromJson(object);
        Constants.toastMessage(msg: result.message);
        if (dataFameLink.tabpos == 0) {
          dataFameLink.page = 1;
          dataFameLink.changeIndex(0, true);
          if (dataFameLink.pageController!.positions.isNotEmpty) {
            dataFameLink.pageController!.jumpToPage(0);
          }
          AppDatabase.database.deleteFameLink();
        } else if (dataFameLink.tabpos == 1) {
          dataFameLink.page = 1;
          dataFameLink.changeIndex(0, true);
          if (dataFameLink.funLinksPageController!.positions.isNotEmpty) {
            dataFameLink.funLinksPageController!.jumpToPage(0);
          }
          AppDatabase.database.deleteFunLink();
        } else if (dataFameLink.tabpos == 2) {
          dataFameLink.page = 1;
          dataFameLink.changeIndex(0, true);
          if (dataFameLink.followLinksPageController!.positions.isNotEmpty) {
            dataFameLink.followLinksPageController!.jumpToPage(0);
          }
          AppDatabase.database.deleteFollowLink();
        }
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

void showBlockAlertDialog(BuildContext context, String userId) {
// set up the button
  final dataFameLink =
      Provider.of<FameLinksFeedProvider>(context, listen: false);
  dataFameLink.blocktUser(userId);

  Widget okButton = TextButton(
    child: Text("Yes", style: GoogleFonts.nunitoSans(color: lightRed)),
    onPressed: () async {
      Navigator.pop(context, true);
      Api.post.call(context, method: "users/block/${userId}", param: {},
          onResponseSuccess: (Map object) {
        var result = UserUpdatedResponse.fromJson(object);
        Constants.toastMessage(msg: result.message);
        if (dataFameLink.tabpos == 0) {
          dataFameLink.page = 1;
          dataFameLink.changeIndex(0, true);
          if (dataFameLink.pageController!.positions.isNotEmpty) {
            dataFameLink.pageController!.jumpToPage(0);
          }
          AppDatabase.database.deleteFameLink();
        } else if (dataFameLink.tabpos == 1) {
          dataFameLink.page = 1;
          dataFameLink.changeIndex(0, true);
          if (dataFameLink.funLinksPageController!.positions.isNotEmpty) {
            dataFameLink.funLinksPageController!.jumpToPage(0);
          }
          AppDatabase.database.deleteFunLink();
        } else if (dataFameLink.tabpos == 2) {
          dataFameLink.page = 1;
          dataFameLink.changeIndex(0, true);
          if (dataFameLink.followLinksPageController!.positions.isNotEmpty) {
            dataFameLink.followLinksPageController!.jumpToPage(0);
          }
          AppDatabase.database.deleteFollowLink();
        }
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

void showOtherReportDialog(
    BuildContext context, String postId, bool isComment) {
  final provider = Provider.of<FameLinksFeedProvider>(context, listen: false);
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
                      controller: provider.reportPostController,
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
                                if (provider.postSingleValue.isNotEmpty) {
                                  Map<String, dynamic> params = {
                                    "body": provider.postSingleValue == "other"
                                        ? provider.reportPostController.text
                                        : "null",
                                    "type": provider.postSingleValue,
                                  };
                                  Api.post.call(context,
                                      method: "users/report/comment/${postId}",
                                      param: params,
                                      onResponseSuccess: (Map object) {
                                    var result =
                                        UserUpdatedResponse.fromJson(object);
                                    Constants.toastMessage(msg: result.message);
                                    provider.postSingleValue = "";
                                    provider.reportPostController.text = "";
                                    Navigator.of(context).pop();
                                  });
                                }
                              } else {
                                if (provider.postSingleValue.isNotEmpty) {
                                  Map<String, dynamic> params = {
                                    "body": provider.postSingleValue == "other"
                                        ? provider.reportPostController.text
                                        : "null",
                                    "type": provider.postSingleValue,
                                  };
                                  Api.post.call(context,
                                      method: "users/report/post/${postId}",
                                      param: params,
                                      onResponseSuccess: (Map object) {
                                    var result =
                                        UserUpdatedResponse.fromJson(object);
                                    Constants.toastMessage(msg: result.message);
                                    provider.postSingleValue = "";
                                    provider.reportPostController.text = "";
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
