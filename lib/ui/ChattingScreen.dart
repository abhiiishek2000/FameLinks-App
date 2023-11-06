import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/ChatMessageModel.dart';
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
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'messages_form.dart';
import 'messages_item.dart';

class ChattingScreen extends StatefulWidget {
  String name;
  String image;
  String userId;
  String chatId;
  String type;
  bool isRequest;

  ChattingScreen(this.name, this.image, this.userId, this.type, this.chatId,
      this.isRequest);

  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  bool _isTyping = false;
  String? _userNameTyping;
  final ApiProvider _api = ApiProvider();
  ScrollController? _scrollController;
  IO.Socket? socket;

  // List<Message> allMessages = [];
  TextEditingController reportPostController = new TextEditingController();
  int chattingPage = 1;

  bool isChatting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MessagesProvider>(context, listen: false).clearMessage();
    if (widget.chatId != null) {
      _followers();
    }
    _scrollController = ScrollController();
    var token = Constants.token;
    socket = IO.io(
        '${ApiProvider.shareUrl}',
        IO.OptionBuilder()
            .enableReconnection()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .setExtraHeaders({
              'Authorization': token,
            })
            .build());
    // Connect to websocket
    socket!.connect();
    socket!.onConnect((_) {
      print('connect');
    });
    print('connect:::${socket!.connected}');
    // socket.onConnect((_) {
    //   print('connect');
    socket!.on('receiveMessage', (data) {
      print("receiveMessage:::${data}");
      Provider.of<MessagesProvider>(context, listen: false)
          .addMessage(Message.fromJson(data));
      data.forEach((v) {
        Message message = Message.fromJson(v);
        message.senderName = widget.name;
      });
      _scrollController!.animateTo(
        0.0,
        duration: Duration(milliseconds: 200),
        curve: Curves.bounceInOut,
      );
      isChatting = true;
    });
    socket!.onConnectError((data) {
      print("ConnectError:::${data}");
      socket!.connect();
    });
    socket!.onError((data) {
      print("Error:::${data}");
    });
    socket!.onConnectTimeout((data) {
      print("ConnectTimeout:::${data}");
      socket!.connect();
    });
    _scrollController!.addListener(() {
      if (_scrollController!.position.maxScrollExtent ==
          _scrollController!.position.pixels) {
        chattingPage++;
        _followers();
      }
    });
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
    // _socketIoManager.sendMessage(
    //   'send_message',
    //   Message(
    //     widget.senderName,
    //     messageContent,
    //     DateTime.now(),
    //   ).toJson(),
    // );
    socket!.emitWithAck(
        'sendMessage',
        Message(
          "",
          widget.userId,
          "",
          messageContent,
          "${DateFormat('yyyy-MM-dd').format(DateTime.now())}T${DateFormat('HH:mm:ss').format(DateTime.now())}Z",
        ).toJson(), ack: (data) {
      print('ack $data');
      if (data != null) {
        print('from server $data');
      } else {
        print("Null");
      }
    });
    //
    Provider.of<MessagesProvider>(context, listen: false).addMessage(Message(
        "",
        Constants.userId,
        "",
        messageContent,
        "${DateFormat('yyyy-MM-dd').format(DateTime.now())}T${DateFormat('HH:mm:ss').format(DateTime.now())}Z"));

    // Provider.of<MessagesProvider>(context, listen: false).allMessages.insert(
    //     0,
    //     Message("", ApiProvider.userId, "", messageContent,
    //         "${DateFormat('yyyy-MM-dd').format(DateTime.now())}T${DateFormat('HH:mm:ss').format(DateTime.now())}Z"));
    isChatting = true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MessagesProvider>(builder: (context, messageData, child) {
      return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: white),
            backgroundColor: lightRed,
            elevation: 0,
            title: InkWell(
              onTap: () {
                Constants.profileUserId = widget.userId;
                if (Constants.userId == Constants.profileUserId) {
                  if (widget.type == "individual") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                  } else if (widget.type == "agency") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AgencyProfileScreen()));
                  } else if (widget.type == "brand") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BrandProfileScreen()));
                  }
                } else {
                  if (widget.type == "individual") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OtherProfileScreen()));
                  } else if (widget.type == "agency") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AgencyOtherProfileScreen()));
                  } else if (widget.type == "brand") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BrandOtherProfileScreen()));
                  }
                }
              },
              child: Row(
                children: [
                  widget.image != null
                      ? CircleAvatar(
                          backgroundColor: white,
                          radius: ScreenUtil().radius(20),
                          backgroundImage: NetworkImage(
                              "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${widget.image}"),
                        )
                      : CircleAvatar(
                          backgroundColor: white,
                          radius: ScreenUtil().radius(20),
                          child: Text(
                            widget.name.substring(0, 1).toUpperCase(),
                            style: GoogleFonts.nunitoSans(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  SizedBox(
                    width: ScreenUtil().setWidth(5),
                  ),
                  Expanded(
                    child: Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: widget.name,
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              color: white,
                              fontSize: ScreenUtil().setSp(16))),
                    ])),
                  )
                ],
              ),
            ),
            actions: [
              Visibility(
                visible: !widget.isRequest,
                child: IconButton(
                    onPressed: () async {
                      showReportPostDialog(widget.userId);
                    },
                    icon: Icon(Icons.more_vert_sharp, color: white)),
              )
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [lightRedWhite, lightRed])),
            )),
        body: WillPopScope(
            onWillPop: () async {
              if (Provider.of<MessagesProvider>(context, listen: false)
                      .allMessages
                      .length >
                  0) {
                messageData.allMessages[0].isChatting = isChatting;
              }
              Navigator.pop(
                  context,
                  messageData.allMessages.length > 0
                      ? messageData.allMessages[0]
                      : null);
              return true;
            },
            child: body()),
      );
    });
  }

  Widget body() {
    final messageData = Provider.of<MessagesProvider>(context);
    return Container(
      color: white,
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
                          ScreenUtil().setHeight(widget.isRequest ? 30 : 90)),
                  itemCount: messageData.allMessages.length,
                  itemBuilder: (ctx, index) => MessagesItem(
                    widget.image,
                    messageData.allMessages[index],
                    messageData.allMessages[index]
                        .isUserMessage(Constants.userId),
                  ),
                ),
              ),
              Visibility(
                visible: widget.isRequest,
                child: Padding(
                  padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(120)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(80),
                        height: ScreenUtil().setHeight(30),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                      ),
                                      side: BorderSide(color: black)))),
                          onPressed: () async {
                            Map<String, dynamic> param = {"accept": true};
                            Api.patch.call(context,
                                method:
                                    "chats/requests/${widget.chatId}/action",
                                param: param, onResponseSuccess: (Map object) {
                              setState(() {
                                widget.isRequest = false;
                              });
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Accept',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(12)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: ScreenUtil().setWidth(32)),
                        width: ScreenUtil().setWidth(80),
                        height: ScreenUtil().setHeight(30),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                      ),
                                      side: BorderSide(color: black)))),
                          onPressed: () async {
                            Map<String, dynamic> param = {"accept": false};
                            Api.patch.call(context,
                                method:
                                    "chats/requests/${widget.chatId}/action",
                                param: param, onResponseSuccess: (Map object) {
                              Navigator.pop(context, true);
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Ignore',
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(12)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
              hint: "Type your Message",
            ),
          ),
        ],
      ),
    );
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
                        onTap: () {
                          Navigator.pop(context);
                          showBlockAlertDialog(userId);
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
                        width: ScreenUtil().setSp(46),
                        child: Divider(
                          height: ScreenUtil().setSp(1),
                          thickness: ScreenUtil().setSp(1),
                          color: lightGray,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setSp(12),
                                bottom: ScreenUtil().setSp(12)),
                            child: Text("Ignore User",
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
                          Navigator.pop(context);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setSp(12),
                                bottom: ScreenUtil().setSp(12)),
                            child: Text("Report User",
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

  showBlockAlertDialog(String userId) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Yes", style: GoogleFonts.nunitoSans(color: lightRed)),
      onPressed: () async {
        Navigator.pop(context, true);
        Api.post.call(context, method: "users/block/${userId}", param: {},
            onResponseSuccess: (Map object) {
          var result = UserUpdatedResponse.fromJson(object);
          Constants.toastMessage(msg: result.message);
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
      content: Text("Are you sure you WANT to block this user?"),
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
                                            ApiProvider.progressDialog(true, context);
                                            var result = await _api.addReportComment(
                                                postId, params);
                                            ApiProvider.progressDialog(false, context);
                                            if (result != null) {
                                              if (result.success) {
                                                ApiProvider.toastMessage(
                                                    msg: result.message);
                                                _postSingleValue = "";
                                                reportPostController.text = "";
                                                Navigator.of(context).pop();
                                              } else {
                                                ApiProvider.toastMessage(
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
    socket!.disconnect();
    // _socketIoManager.disconnect();
    super.dispose();
  }

  void _followers() async {
    Map<String, dynamic> param = {"page": chattingPage.toString()};
    Api.get.call(context,
        method: "chats/${widget.chatId}/messages",
        param: param, onResponseSuccess: (Map<dynamic, dynamic> object) {
      var result = ChatMessageModel.fromJson(object);
      if (!result.result!.readBy!.contains(Constants.userId)) {
        Api.patch.call(context,
            method: "chats/${widget.chatId}/mark-as-read",
            param: {},
            isLoading: false,
            onResponseSuccess: (Map object) {});
      }
      if (result.result!.messages!.length == 0) {
        chattingPage--;
      }
      for (int i = 0; i < result.result!.messages!.length; i++) {
        ChatMessageResult result2 = result.result!.messages![i];
        Message message = Message(result2.user!.name, result2.user!.sId,
            result2.sId, result2.body, result2.updatedAt);
        message.isHeader = i == result.result!.messages!.length - 1 ||
            (result2.date != result.result!.messages![i + 1].date);
        message.timeStamp = result2.date;
        Provider.of<MessagesProvider>(context, listen: false)
            .addMessage(message);
      }
    });
  }
}
