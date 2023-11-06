import 'package:dio/dio.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/ChatUserModel.dart';
import 'package:famelink/models/ConversationModel.dart';
import 'package:famelink/models/message.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/ChattingScreen.dart';
import 'package:famelink/ui/followers/following_info_screen.dart';
import 'package:famelink/ui/profile/agency_profile_screen.dart';
import 'package:famelink/ui/profile/brand_profile_screen.dart';
import 'package:famelink/ui/profile/profile_screen.dart';
import 'package:famelink/util/UnicornOutlineButton.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/config/image.dart';
import 'package:famelink/util/constants.dart';
import 'package:famelink/util/widgets/custom_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'authentication/login_screen.dart';
import 'challenge/challenge_screen.dart';
import 'notification/notification_screen.dart';

class FameChatScreen extends StatefulWidget {
  const FameChatScreen({Key? key}) : super(key: key);

  @override
  _FameChatScreenState createState() => _FameChatScreenState();
}

class _FameChatScreenState extends State<FameChatScreen> with TickerProviderStateMixin{
  final ApiProvider _api = ApiProvider();

  List<Chat> myFollowersResult = [];
  List<Result> myRequestResult = [];

  final dateFormat = DateFormat('dd-MM-yyyy');
  final dateShowFormat = DateFormat('dd-MMM');
  final monthFormat = DateFormat('MM');
  final timeFormat = DateFormat('hh:mm a');
  ScrollController conversationsScrollController = ScrollController();
  ScrollController requestsScrollController = ScrollController();
  int conversationsPage = 1;
  int requestsPage = 1;
  IO.Socket? socket;
  AnimationController? _speedDialController;

  Data? requestModel;

  TabController? _tabController;

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 2);
    _tabController!.addListener(() {
      setState(() {
        print(_tabController!.index);
      });
    });
    conversationsScrollController.addListener(() {
      if (conversationsScrollController.position.maxScrollExtent ==
          conversationsScrollController.position.pixels) {
        conversationsPage++;
        _followers();
      }
    });
    requestsScrollController.addListener(() {
      if (requestsScrollController.position.maxScrollExtent ==
          requestsScrollController.position.pixels) {
        requestsPage++;
        getRequests();
      }
    });
    _speedDialController = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
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
      data.forEach((v) {
        Message message = Message.fromJson(v);
        for(int i=0; i<myFollowersResult.length; i++){
          if(message.messageId == myFollowersResult[i].sId){
            myFollowersResult[i].lastMessage!.body = message.content;
            myFollowersResult[i].lastMessage!.updatedAt = message.date;
            setState((){
              final Chat first = myFollowersResult.elementAt(i);
              myFollowersResult.removeAt(i);
              myFollowersResult.insert(0,first);
            });
            return false;
          }
        }
      });
      // Provider.of<MessagesProvider>(context, listen: false)
      //     .addMessage(Message.fromJson(data));

      conversationsScrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 200),
        curve: Curves.bounceInOut,
      );
    });
    socket!.onConnectError((data) {
      print("ConnectError:::${data}");
      // socket.connect();
    });
    socket!.onError((data) {
      print("Error:::${data}");
    });
    socket!.onConnectTimeout((data) {
      print("ConnectTimeout:::${data}");
      socket!.connect();
    });
    _followers();
    getRequests();
    // _suggestions();
    super.initState();
  }
  @override
  void dispose() {
    socket!.disconnect();
    // _socketIoManager.disconnect();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // floatingActionButton: SpeedDial(
      //   openBackgroundColor: appBackgroundColor,
      //   closedBackgroundColor: appBackgroundColor,
      //   controller: _speedDialController,
      //   child: UnicornOutlineButton(
      //     strokeWidth:
      //     ScreenUtil()
      //         .setSp(2),
      //     bottomLeftRadius:
      //     ScreenUtil()
      //         .setSp(28),
      //     bottomRightRadius:
      //     ScreenUtil()
      //         .setSp(28),
      //     topLeftRadius:
      //     ScreenUtil()
      //         .setSp(28),
      //     topRightRadius:
      //     ScreenUtil()
      //         .setSp(28),
      //     gradient: LinearGradient(
      //         begin: Alignment
      //             .centerLeft,
      //         end: Alignment
      //             .centerRight,
      //         colors: [
      //           profileBorder1,
      //           profileBorder2,
      //           profileBorder3,
      //           profileBorder4
      //         ]),
      //     onPressed: () {
      //       if (!_speedDialController.isDismissed) {
      //         _speedDialController.reverse();
      //       }else{
      //         _speedDialController.animateTo(100);
      //       }
      //     },
      //     child: Container(
      //       height: ScreenUtil().setSp(56),
      //       width: ScreenUtil().setSp(56),
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(ScreenUtil().setSp(28)),
      //       ),
      //       padding: EdgeInsets.all(ScreenUtil().setSp(18)),
      //       child: SvgPicture.asset(
      //         home,
      //       ),
      //     ),
      //   ),
      //   speedDialChildren: <SpeedDialChild>[
      //     SpeedDialChild(
      //       backgroundColor: white,
      //       label: 'Notification',
      //       child: IconButton(
      //           onPressed: () {
      //             if (!_speedDialController.isDismissed) {
      //               _speedDialController.reverse();
      //             }
      //             Navigator.pushReplacement(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (context) => NotificationScreen()),
      //             );
      //           },
      //           icon: SvgPicture.asset(
      //               notifications,
      //               color: black
      //           )),
      //     ),
      //     /*SpeedDialChild(
      //       backgroundColor: white,
      //       label: 'Hall of Fame',
      //       child: IconButton(
      //           onPressed: () {
      //             if (!_speedDialController.isDismissed) {
      //               _speedDialController.reverse();
      //             }
      //           },
      //           icon: SvgPicture.asset(
      //               halloffame,
      //               color: black
      //           )),
      //     ),*/
      //     SpeedDialChild(
      //       backgroundColor: white,
      //       label: 'Trendz',
      //       child: IconButton(
      //           onPressed: () async {
      //             if (!_speedDialController.isDismissed) {
      //               _speedDialController.reverse();
      //             }
      //             var result = await Navigator.pushReplacement(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (context) => ChallengeScreen()),
      //             );
      //             if(result != null){
      //               Map map = result;
      //               FormData formData = FormData.fromMap({
      //                 "challengeId": map['challengeId'],
      //                 "description":map['description'],
      //                 "closeUp": map['closeUp'],
      //                 "medium": map['medium'],
      //                 "long": map['long'],
      //                 "pose1": map['pose1'],
      //                 "pose2": map['pose2'],
      //                 "additional": map['additional'],
      //                 "video": map['video'],
      //               });
      //               Api.uploadPost.call(context,
      //                   method: "media/contest",
      //                   param: formData,
      //                   onResponseSuccess: (Map object) {
      //                     var snackBar = SnackBar(
      //                       content: Text('Uploaded'),
      //                     );
      //                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //                   });
      //             }
      //           },
      //           icon: SvgPicture.asset(
      //               challenge,
      //               color: black
      //           )),
      //     ),
      //     SpeedDialChild(
      //         backgroundColor: white,
      //         label: 'Profile',
      //         onPressed: () async {
      //           if (!_speedDialController.isDismissed) {
      //             _speedDialController.reverse();
      //           }
      //           ApiProvider.profileUserId = ApiProvider.userId;
      //           var result;
      //           if(ApiProvider.userType == "agency"){
      //             result = await Navigator.pushReplacement(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => AgencyProfileScreen()));
      //           }else if(ApiProvider.userType == "brand"){
      //             result = await Navigator.pushReplacement(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => BrandProfileScreen()));
      //           }else {
      //             result = await Navigator.pushReplacement(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => ProfileScreen()));
      //           }
      //           if (result != null && result == true) {
      //             Navigator.pushReplacement(context,
      //                 MaterialPageRoute(builder: (context) => LoginScreen()));
      //           }
      //         },
      //         child: SvgPicture.asset(
      //             profile,
      //             color: black
      //         )),
      //   ],
      // ),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: ScreenUtil().setHeight(96),
          backgroundColor: appBackgroundColor,
          elevation: 0,
          centerTitle: true,
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FollowingInfoScreen()));
                },
                icon: SvgPicture.asset("assets/icons/svg/chat_edit.svg"))
          ],
          title: Text.rich(TextSpan(children: <TextSpan>[
            TextSpan(
                text: "Fame",
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w700,
                    color: black,
                    fontSize: ScreenUtil().setSp(24))),
            TextSpan(
                text: " Chat",
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenUtil().setSp(24),
                    color: lightRed)),
          ]))),
      body: body(),
    );
  }


  Widget body() {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: "Conversations",
                  ),
                  Tab(
                    child: Text("Requests (${requestModel != null ?NumberFormat.compactCurrency(
                      decimalDigits: 0,
                      symbol:
                      '', // if you want to add currency symbol then pass that in this else leave it empty.
                    ).format(requestModel!.count):"0"})",style: GoogleFonts.nunitoSans(
                        fontWeight:_tabController!.index == 0 ?FontWeight.w400:FontWeight.w700,
                        color: requestModel != null && requestModel!.count! > 0 ?buttonBlue:_tabController!.index == 0 ?lightGray:darkGray,
                        fontSize: ScreenUtil().setSp(14)),),
                  ),
                  // Tab(text: "Requests (${requestModel != null ?NumberFormat.compactCurrency(
                  //   decimalDigits: 0,
                  //   symbol:
                  //   '', // if you want to add currency symbol then pass that in this else leave it empty.
                  // ).format(requestModel.count):"0"})"),
                ],
                labelColor: darkGray,
                unselectedLabelColor: lightGray,
                indicatorColor: darkGray,
                unselectedLabelStyle: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(14)),
                labelStyle: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenUtil().setSp(14)),
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      child: myFollowersResult.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              controller: conversationsScrollController,
                              itemCount: myFollowersResult.length,
                              itemBuilder: (followersContext, index) {
                                Chat resultModel = myFollowersResult[index];
                                DateTime date = DateTime.parse(
                                    resultModel.lastMessage!.updatedAt!).toLocal();
                                DateTime today = dateFormat
                                    .parse(dateFormat.format(DateTime.now()));
                                DateTime yesterday = dateFormat
                                    .parse(dateFormat.format(DateTime.now()))
                                    .subtract(Duration(days: 1));
                                DateTime updatedAt =
                                    dateFormat.parse(dateFormat.format(date));
                                String updatedAtTime = timeFormat.format(date);
                                String updatedAtDate =
                                    dateShowFormat.format(date);
                                myFollowersResult[index].time = updatedAtTime;
                                if (updatedAt.compareTo(today) == 0) {
                                  myFollowersResult[index].date = "Today";
                                } else if (updatedAt.compareTo(yesterday) ==
                                    0) {
                                  myFollowersResult[index].date = "Yesterday";
                                } else {
                                  myFollowersResult[index].date = updatedAtDate;
                                }
                                return InkWell(
                                  onTap: () async {
                                    // socket.disconnect();
                                    // socket.dispose();
                                    if(!myFollowersResult[index].readBy!.contains(Constants.userId)) {
                                      setState(() {
                                        myFollowersResult[index].readBy!.add(
                                            Constants.userId);
                                      });
                                    }
                                    var result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChattingScreen(
                                              myFollowersResult[index].title!,myFollowersResult[index].image!,myFollowersResult[index].userId!,myFollowersResult[index].type!,myFollowersResult[index].sId!, false)),
                                    );
                                    if (result != null) {
                                      Message _message = result;
                                      if(_message.isChatting!) {
                                        myFollowersResult[index].lastMessage!
                                            .body = _message.content;
                                        myFollowersResult[index].lastMessage!
                                            .updatedAt = _message.date;
                                        setState(() {
                                          final Chat first = myFollowersResult
                                              .elementAt(index);
                                          myFollowersResult.removeAt(index);
                                          myFollowersResult.insert(0, first);
                                        });
                                      }
                                    }else{
                                      setState(() {
                                        myFollowersResult.removeAt(index);
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(13)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: ScreenUtil().setWidth(16),
                                        ),
                                        myFollowersResult[index].image !=
                                                null
                                            ? CircleAvatar(
                                          backgroundColor: lightGray,
                                                radius: ScreenUtil().radius(22),
                                                backgroundImage: NetworkImage(
                                                    "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${myFollowersResult[index].image}"),
                                              )
                                            : CircleAvatar(
                                          backgroundColor: lightGray,
                                                radius: ScreenUtil().radius(22),
                                              ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(18),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                        '${myFollowersResult[index].title}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: GoogleFonts.nunitoSans(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: black,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(
                                                                        14))),
                                                  ),
                                                  Text(
                                                      myFollowersResult[index]
                                                          .date!,
                                                      style: GoogleFonts.nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: black,
                                                          fontSize: ScreenUtil()
                                                              .setSp(12)))
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(2),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                        myFollowersResult[index]
                                                            .lastMessage!
                                                            .body!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: GoogleFonts.nunitoSans(
                                                            fontWeight: !myFollowersResult[index].readBy!.contains(Constants.userId) ?FontWeight.w800:FontWeight.w400,
                                                            color: black,
                                                            fontSize: ScreenUtil()
                                                                    .setSp(
                                                                        12))),
                                                  ),
                                                  Text(
                                                      myFollowersResult[index]
                                                          .time!,
                                                      style: GoogleFonts.nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: lightGray,
                                                          fontSize: ScreenUtil()
                                                              .setSp(12)))
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(11),
                                              ),
                                              Divider(
                                                thickness:
                                                    ScreenUtil().setSp(1),
                                                height: ScreenUtil().setSp(1),
                                                color: lightGray,
                                              )
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                          ),
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(16),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : Center(
                              child: Text("No Conversations Found",
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                    ),
                    Container(
                      child: myRequestResult.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              controller: requestsScrollController,
                              itemCount: myRequestResult.length,
                              itemBuilder: (followersContext, index) {
                                Result resultModel = myRequestResult[index];
                                DateTime date = DateTime.parse(
                                    resultModel.lastMessage!.updatedAt!);
                                DateTime today = dateFormat
                                    .parse(dateFormat.format(DateTime.now()));
                                DateTime yesterday = dateFormat
                                    .parse(dateFormat.format(DateTime.now()))
                                    .subtract(Duration(days: 1));
                                DateTime updatedAt =
                                    dateFormat.parse(dateFormat.format(date));
                                String updatedAtTime = timeFormat.format(date);
                                String updatedAtDate =
                                    dateShowFormat.format(date);
                                myRequestResult[index].time = updatedAtTime;
                                if (updatedAt.compareTo(today) == 0) {
                                  myRequestResult[index].date = "Today";
                                } else if (updatedAt.compareTo(yesterday) ==
                                    0) {
                                  myRequestResult[index].date = "Yesterday";
                                } else {
                                  myRequestResult[index].date = updatedAtDate;
                                }
                                return InkWell(
                                  onTap: () async {
                                    var result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChattingScreen(
                                              myRequestResult[index].title!,myRequestResult[index].profileImage!,myRequestResult[index].userId!,myRequestResult[index].type!,myRequestResult[index].sId!, true)),
                                    );
                                    if (result != null) {
                                      myRequestResult.clear();
                                      myFollowersResult.clear();
                                      requestsPage = 1;
                                      conversationsPage = 1;
                                      getRequests();
                                      _followers();
                                    }else{
                                      setState(() {
                                        myRequestResult.removeAt(index);
                                      });
                                    }

                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(13)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: ScreenUtil().setWidth(16),
                                        ),
                                        myRequestResult[index].profileImage !=
                                                null
                                            ? CircleAvatar(
                                                radius: ScreenUtil().radius(22),
                                                backgroundImage: NetworkImage(
                                                    "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${myRequestResult[index].profileImage}"),
                                              )
                                            : CircleAvatar(
                                                radius: ScreenUtil().radius(22),
                                              ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(18),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                        '${myRequestResult[index].title}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: GoogleFonts.nunitoSans(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: black,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(
                                                                        14))),
                                                  ),
                                                  Text(
                                                      myRequestResult[index]
                                                          .date!,
                                                      style: GoogleFonts.nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: black,
                                                          fontSize: ScreenUtil()
                                                              .setSp(12)))
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(5),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                        myRequestResult[index]
                                                            .lastMessage!
                                                            .body!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: GoogleFonts.nunitoSans(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: black,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(
                                                                        12))),
                                                  ),
                                                  Text(
                                                      myRequestResult[index]
                                                          .time!,
                                                      style: GoogleFonts.nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: lightGray,
                                                          fontSize: ScreenUtil()
                                                              .setSp(12)))
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(12),
                                              ),
                                              Divider(
                                                thickness:
                                                    ScreenUtil().setSp(1),
                                                height: ScreenUtil().setSp(1),
                                                color: lightGray,
                                              )
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                          ),
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(16),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : Center(
                              child: Text("No Requests Found",
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                    ),
                  ],
                  physics: ScrollPhysics(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _followers() async {
    Map<String, dynamic> param = {
      "page" : conversationsPage.toString()
    };
    Api.get.call(context,
        method:
        "chats/me",
        param: param,
        onResponseSuccess: (Map<dynamic,dynamic> object) {
          var result = ConversationModel.fromJson(object);
          if(result.result!.length > 0) {
            myFollowersResult.addAll(result.result!);
            setState(() {});
            print('RESPONSE ${result.result.toString()}');
          }else{
            conversationsPage--;
          }
        });
  }

  void getRequests() async {
    Map<String, dynamic> param = {
      "page" : requestsPage.toString()
    };
    Api.get.call(context,
        method:
        "chats/requests",
        param: param,
        isLoading: false,
        onResponseSuccess: (Map<dynamic,dynamic> object) {
          var result = ChatUserModel.fromJson(object);
          if(result.data!.result!.length > 0) {
            requestModel = result.data;
            myRequestResult.addAll(result.data!.result!);
            setState(() {});
          }else{
            if(myRequestResult.isEmpty){
              setState(() {
                requestModel = null;
              });
            }
            requestsPage--;
          }
        });
  }

// void _notification() async {
//   bool internet = await ApiProvider.isInternetAvailable();
//   if (internet) {
//     ApiProvider.progressDialog(true, context);
//     var result = await _api.getnotificationService();
//     if (result != null) {
//       ApiProvider.progressDialog(false, context);
//       if (result.success.toString() == "true") {
//         myNotificationResult = result.result;
//         setState(() {});
//         print('RESPONSE ${result.result.toString()}');
//       } else
//         ApiProvider.toastMessage(msg: result.message);
//     }
//   }
//
// }
}
