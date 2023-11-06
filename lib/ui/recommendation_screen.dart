import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/ChatMessageModel.dart';
import 'package:famelink/models/ChatUserModel.dart';
import 'package:famelink/models/RecommendationModel.dart';
import 'package:famelink/models/message.dart';
import 'package:famelink/models/userUpdateResponse.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/providers/messages_provider.dart';
import 'package:famelink/ui/profile/agency_other_profile_screen.dart';
import 'package:famelink/ui/profile/agency_profile_screen.dart';
import 'package:famelink/ui/profile/brand_other_profile_screen.dart';
import 'package:famelink/ui/profile/brand_profile_screen.dart';
import 'package:famelink/ui/profile/other_profile_screen.dart';
import 'package:famelink/ui/profile/profile_screen.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'messages_form.dart';
import 'messages_item.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class RecomamendationScreen extends StatefulWidget {
  String? name;
  String? agencyId;
  int? recommendationCount;
  RecomamendationScreen({this.name,this.agencyId,this.recommendationCount});

  @override
  _RecomamendationScreenState createState() => _RecomamendationScreenState();
}

class _RecomamendationScreenState extends State<RecomamendationScreen> {
  bool _isTyping = false;
  String? _userNameTyping;
  final ApiProvider _api = ApiProvider();
  ScrollController? _scrollController;
  List<RecommendationData> allMessages = [];
  TextEditingController reportPostController = new TextEditingController();
  int chattingPage = 1;

  bool isChatting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.agencyId != null) {
      _followers();
    }
    _scrollController = ScrollController();
    var token = Constants.token;
    _scrollController!.addListener(() {
      if (_scrollController!.position.maxScrollExtent ==
          _scrollController!.position.pixels) {
        chattingPage++;
        _followers();
      }
    });
    //
    // allMessages.insert(
    //     0,
    //     Message("", Constants.userId, "", "messageContent",
    //         "${DateFormat('yyyy-MM-dd').format(DateTime.now())}T${DateFormat('HH:mm:ss').format(DateTime.now())}Z"));
    // setState(() {});
    // isChatting = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          backgroundColor: white,
          elevation: 0,
          title: Text(
            widget.name!,
            style: GoogleFonts.nunitoSans(
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.w700,
              color: black,
            ),
          )),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      color: white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setSp(16),right: ScreenUtil().setSp(16)),
            child: Row(
              children: [
                Expanded(child: Text("Recommendations",style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w700,fontSize: ScreenUtil().setSp(14),color: black),)),
                Text("${NumberFormat.compactCurrency(
    decimalDigits: 0,
    symbol:
    '', // if you want to add currency symbol then pass that in this else leave it empty.
    ).format(widget.recommendationCount != null ? widget.recommendationCount : 0)} Recommends",style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w400,fontSize: ScreenUtil().setSp(12),color: black),)
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: _scrollController,
                        padding: EdgeInsets.only(
                            bottom:
                            ScreenUtil().setHeight(90)),
                        itemCount: allMessages.length,
                        itemBuilder: (ctx, index) => Padding(
                          padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(12), right: ScreenUtil().setWidth(18)),
                          child: Column(
                            children: <Widget>[
                              // Visibility(child: Text(_message.timeStamp != null ? _message.timeStamp:"",style: GoogleFonts.nunitoSans(color: lightGray)),visible: _message.isHeader),
                              Row(
                                children: [
                                  Card(
                                      elevation: 2,
                                      color: lightGray,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(ScreenUtil().radius(20)),
                                        ),
                                      ),
                                      child: allMessages[index].user!.profileImage != null
                                          ? CircleAvatar(
                                        backgroundColor: buttonBlue.withOpacity(0.7),
                                        radius: ScreenUtil().radius(20),
                                        backgroundImage: NetworkImage(
                                            "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${allMessages[index].user!.profileImage}"),
                                      )
                                          : CircleAvatar(
                                        backgroundColor: buttonBlue.withOpacity(0.7),
                                        radius: ScreenUtil().radius(20),
                                        child: Text(
                                          widget.name!
                                              .substring(0, 1)
                                              .toUpperCase(),
                                          style: GoogleFonts.nunitoSans(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                  Expanded(
                                    child: Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(ScreenUtil().radius(8)),
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: lightGray.withOpacity(0.1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(ScreenUtil().radius(8)),
                                          ),
                                        ),
                                        padding: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(7),
                                            right: ScreenUtil().setWidth(7),
                                            top: ScreenUtil().setHeight(4),
                                            bottom: ScreenUtil().setHeight(4)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            InkWell(
                                              onTap: ()async{
                                              },
                                              child: Text(
                                                allMessages[index].data!,
                                                style: GoogleFonts.nunitoSans(
                                                  color:black,
                                                  fontSize: ScreenUtil().setSp(12),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                convertToAgo(DateTime.parse(allMessages[index]
                                                    .createdAt!)),
                                                style: GoogleFonts.nunitoSans(
                                                  color:black,
                                                  fontSize: ScreenUtil().setSp(12),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(8),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MessageForm(
                    onSendMessage: _sendMessage,
                    onTyping: _onTyping,
                    onStopTyping: _onStopTyping,
                    hint: "Write Recommendation",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
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
  void _onTyping() {
    // _socketIoManager.sendMessage(
    //     'typing', json.encode({'senderName': widget.senderName}));
  }

  void _onStopTyping() {
    // _socketIoManager.sendMessage(
    //     'stop_typing', json.encode({'senderName': widget.senderName}));
  }

  void _sendMessage(String messageContent) {
    Map<String, dynamic> param = {
      "agencyId":widget.agencyId,
      "recommendations":messageContent,
    };
    Api.post.call(context,
        method:
        "users/agency/recommendations",
        param: param,
        onResponseSuccess: (Map object) {
          allMessages.clear();
          _followers();
        });
    //

  }

  void showReportPostDialog(String userId) {
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
                            onTap: (){
                              Navigator.pop(context);
                              showBlockAlertDialog(userId);
                            },
                            child: Padding(
                                padding: EdgeInsets.only(top: ScreenUtil().setSp(12),bottom: ScreenUtil().setSp(12)),
                                child: Text("Block User", style: GoogleFonts
                                    .nunitoSans(fontWeight: FontWeight.w400,
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
                          Padding(
                              padding: EdgeInsets.only(top: ScreenUtil().setSp(12),bottom: ScreenUtil().setSp(12)),
                              child: Text("Ignore User", style: GoogleFonts
                                  .nunitoSans(fontWeight: FontWeight.w400,
                                  fontSize: ScreenUtil().setSp(14),
                                  color: darkGray))),
                          SizedBox(
                            width: ScreenUtil().setSp(46),
                            child: Divider(
                              height: ScreenUtil().setSp(1),
                              thickness: ScreenUtil().setSp(1),
                              color: lightGray,
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Padding(
                                padding: EdgeInsets.only(top: ScreenUtil().setSp(12),bottom: ScreenUtil().setSp(12)),
                                child: Text("Report User", style: GoogleFonts
                                    .nunitoSans(fontWeight: FontWeight.w400,
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

  showBlockAlertDialog(String userId) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Yes", style: GoogleFonts.nunitoSans(color: lightRed)),
      onPressed: () async {
        Navigator.pop(context, true);
        Api.post.call(context,
            method:
            "users/block/${userId}",
            param: {},
            onResponseSuccess: (Map<dynamic,dynamic> object) {
              var result = UserUpdatedResponse.fromJson(object);
              Constants.toastMessage(
                  msg: result.message);
              Navigator.pop(context, null);
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

  void showOtherReportDialog(String postId) {
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
                                            /*var params = {
                                              "body": _postSingleValue == "other"
                                                  ? reportPostController.text
                                                  : "null",
                                              "type": _postSingleValue,
                                            };
                                            Constants.progressDialog(true, context);
                                            var result = await _api.addReportComment(
                                                postId, params);
                                            Constants.progressDialog(false, context);
                                            if (result != null) {
                                              if (result.success) {
                                                Constants.toastMessage(
                                                    msg: result.message);
                                                _postSingleValue = "";
                                                reportPostController.text = "";
                                                Navigator.of(context).pop();
                                              } else {
                                                Constants.toastMessage(
                                                    msg: result.message);
                                              }
                                            }*/
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

  @override
  void dispose() {
    _scrollController!.dispose();
    // _socketIoManager.disconnect();
    super.dispose();
  }

  void _followers() async {
    Map<String, dynamic> param = {
    };
    Api.get.call(context,
        method:
        "users/agency/${widget.agencyId}/recommendations",
        param: param,
        onResponseSuccess: (Map<dynamic,dynamic> object) {
          var result = RecommendationModel.fromJson(object);

          allMessages.addAll(result.data!);
          setState(() {});
        });
  }
}
