import 'package:famelink/dio/api/api.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/followers/follower_info_screen.dart';
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
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:famelink/models/notification_model.dart';

import 'NotificationPostScreen.dart';

class FameCoinsScreen extends StatefulWidget {
  final coin;
  FameCoinsScreen(this.coin);

  @override
  _FameCoinsScreenState createState() => _FameCoinsScreenState();
}

class _FameCoinsScreenState extends State<FameCoinsScreen> {

  List<Result> myNotificationResult = [];
  List<Result> mygiftedNotificationResult = [];
  final dateFormat = DateFormat('dd-MM-yyyy');
  final monthFormat = DateFormat('MM');
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notification();
    _giftedNotification();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: appBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(
              text: "Fame ",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  color: black,
                  fontSize: ScreenUtil().setSp(18))),
          TextSpan(
              text: "Coins",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(18),
                  color: lightRed)),
        ])),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ScreenUtil().setSp(12)),
            ),
            margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(24),
                bottom: ScreenUtil().setHeight(16),
                left: ScreenUtil().setWidth(92),
                right: ScreenUtil().setWidth(92)),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft:
                          Radius.circular(ScreenUtil().setSp(12)),
                          topRight:
                          Radius.circular(ScreenUtil().setSp(12))),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [lightRedWhite, lightRed])),
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(21),
                      bottom: ScreenUtil().setHeight(12),
                      left: ScreenUtil().setWidth(5),
                      right: ScreenUtil().setWidth(5)),
                  child: Center(
                    child: Text(
                      'Your Wallet Balance',
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(16),
                          color: white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setSp(13),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft:
                        Radius.circular(ScreenUtil().setSp(12)),
                        bottomRight:
                        Radius.circular(ScreenUtil().setSp(12))),
                    color: appBackgroundColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/icons/coin.png"),
                      SizedBox(
                        width: ScreenUtil().setHeight(6),
                      ),
                      Text(widget.coin.toString(),
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w700,
                              fontSize:
                              ScreenUtil().setSp(12),
                              color: black)),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setSp(17),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setSp(16),
          ),
          Center(
            child: SizedBox(
              width: ScreenUtil().setSp(69),
              child: Divider(
                height: 1,
                thickness: 1,
                color: lightGray,
              ),
            ),
          ),
          /*Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ScreenUtil().setSp(12)),
            ),
            margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(10),
                bottom: ScreenUtil().setHeight(16),
                left: ScreenUtil().setWidth(92),
                right: ScreenUtil().setWidth(92)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(12))),
                color: appBackgroundColor,
              ),
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(10),
                  bottom: ScreenUtil().setHeight(10),
                  left: ScreenUtil().setWidth(50),
                  right: ScreenUtil().setWidth(50)),
              child: Text("Buy Fame Coin",
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w400,
                      fontSize:
                      ScreenUtil().setSp(12),
                      color: black)),
            ),
          ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ScreenUtil().setSp(12)),
            ),
            margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(12),
                bottom: ScreenUtil().setHeight(16),
                left: ScreenUtil().setWidth(92),
                right: ScreenUtil().setWidth(92)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(12))),
                color: appBackgroundColor,
              ),
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(10),
                  bottom: ScreenUtil().setHeight(10),
                  left: ScreenUtil().setWidth(40),
                  right: ScreenUtil().setWidth(40)),
              child: Text("Redeem Fame Coin",
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w400,
                      fontSize:
                      ScreenUtil().setSp(12),
                      color: black)),
            ),
          ),*/
          Expanded(
            child: Container(
              margin: EdgeInsets.all(ScreenUtil().setSp(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Received from-",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          fontSize:
                          ScreenUtil().setSp(12),
                          color: black)),
                  SizedBox(
                    height: ScreenUtil().setSp(4),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: lightGray,
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: myNotificationResult.length,
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setSp(25),
                            right: ScreenUtil().setSp(37)),
                        itemBuilder: (listContext, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setSp(12),
                                      bottom: ScreenUtil().setSp(7)),
                                  child: Text(
                                      myNotificationResult[index].durationTime != null
                                          ? myNotificationResult[index].durationTime!
                                          : "",
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: FontWeight.w400,
                                          color: lightGray)),
                                ),
                                visible:
                                myNotificationResult[index].durationTime != null,
                              ),
                              InkWell(
                                onTap: () {
                                  Constants.profileUserId =
                                      myNotificationResult[index].targetId;
                                  if (myNotificationResult[index].type ==
                                      "followUser") {
                                    if (Constants.userId == Constants.profileUserId) {
                                      if (myNotificationResult[index].sourceType == "individual") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ProfileScreen()));
                                      } else if (myNotificationResult[index].sourceType == "agency") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AgencyProfileScreen()));
                                      } else if (myNotificationResult[index].sourceType == "brand") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BrandProfileScreen()));
                                      }
                                    } else {
                                      if (myNotificationResult[index].sourceType == "individual") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OtherProfileScreen()));
                                      } else if (myNotificationResult[index].sourceType == "agency") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AgencyOtherProfileScreen()));
                                      } else if (myNotificationResult[index].sourceType == "brand") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BrandOtherProfileScreen()));
                                      }
                                    }
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: ScreenUtil().setSp(12)),
                                  child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Constants.profileUserId =
                                                myNotificationResult[index].sourceId;
                                            if (Constants.userId == Constants.profileUserId) {
                                              if (myNotificationResult[index].sourceType == "individual") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => ProfileScreen()));
                                              } else if (myNotificationResult[index].sourceType == "agency") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AgencyProfileScreen()));
                                              } else if (myNotificationResult[index].sourceType == "brand") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BrandProfileScreen()));
                                              }
                                            } else {
                                              if (myNotificationResult[index].sourceType == "individual") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OtherProfileScreen()));
                                              } else if (myNotificationResult[index].sourceType == "agency") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AgencyOtherProfileScreen()));
                                              } else if (myNotificationResult[index].sourceType == "brand") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BrandOtherProfileScreen()));
                                              }
                                            }
                                          },
                                          child:
                                          myNotificationResult[index].sourceMedia !=
                                              null
                                              ? CircleAvatar(
                                            radius: ScreenUtil().radius(15),
                                            backgroundImage: NetworkImage(
                                                "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${myNotificationResult[index].sourceMedia}-xs"),
                                          )
                                              : CircleAvatar(
                                            radius: ScreenUtil().radius(15),
                                          ),
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setSp(6),
                                        ),
                                        Expanded(
                                            child: Column(
                                              children: [
                                                Text.rich(TextSpan(children: <TextSpan>[
                                                  TextSpan(
                                                      recognizer: new TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Constants.profileUserId =
                                                              myNotificationResult[index]
                                                                  .sourceId;
                                                          if (Constants.userId == Constants.profileUserId) {
                                                            if (myNotificationResult[index].sourceType == "individual") {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => ProfileScreen()));
                                                            } else if (myNotificationResult[index].sourceType == "agency") {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          AgencyProfileScreen()));
                                                            } else if (myNotificationResult[index].sourceType == "brand") {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          BrandProfileScreen()));
                                                            }
                                                          } else {
                                                            if (myNotificationResult[index].sourceType == "individual") {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          OtherProfileScreen()));
                                                            } else if (myNotificationResult[index].sourceType == "agency") {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          AgencyOtherProfileScreen()));
                                                            } else if (myNotificationResult[index].sourceType == "brand") {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          BrandOtherProfileScreen()));
                                                            }
                                                          }
                                                        },
                                                      text: myNotificationResult[index]
                                                          .source!.contains("&")?myNotificationResult[index]
                                                          .source!.split("&")[0]:myNotificationResult[index]
                                                          .source,
                                                      style: GoogleFonts.nunitoSans(
                                                          fontWeight: FontWeight.w700,
                                                          color: black,
                                                          fontSize:
                                                          ScreenUtil().setSp(12))),
                                                  TextSpan(
                                                      recognizer: new TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Constants.profileUserId =
                                                              myNotificationResult[index]
                                                                  .sourceId;
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      FollowerInfoScreen(isFollowing: false, id: myNotificationResult[index].sourceId)));
                                                        },
                                                      text: myNotificationResult[index]
                                                          .source!.contains("&")?' & ${myNotificationResult[index]
                                                          .source!.split("&")[1]}':"",
                                                      style: GoogleFonts.nunitoSans(
                                                          fontWeight: FontWeight.w700,
                                                          color: black,
                                                          fontSize:
                                                          ScreenUtil().setSp(12))),
                                                  TextSpan(
                                                      text: myNotificationResult[index]
                                                          .action !=
                                                          null
                                                          ? ' ${myNotificationResult[index].action}'
                                                          : "",
                                                      style: GoogleFonts.nunitoSans(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: ScreenUtil().setSp(12),
                                                          color: black)),
                                                  TextSpan(
                                                      text: myNotificationResult[index]
                                                          .data !=
                                                          null
                                                          ? ' ${myNotificationResult[index].data}'
                                                          : "",
                                                      style: GoogleFonts.nunitoSans(
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: ScreenUtil().setSp(12),
                                                          color: buttonBlue)),
                                                  TextSpan(
                                                      text: myNotificationResult[index]
                                                          .body !=
                                                          null
                                                          ? ' ${myNotificationResult[index].body}'
                                                          : "",
                                                      style: GoogleFonts.nunitoSans(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: ScreenUtil().setSp(12),
                                                          color: black))
                                                ])),
                                                Text(
                                                  convertToAgo(DateTime.parse(
                                                      myNotificationResult[index]
                                                          .updatedAt!)),
                                                  style: GoogleFonts.nunitoSans(
                                                      fontWeight: FontWeight.w400,
                                                      color: darkGray,
                                                      fontSize: ScreenUtil().setSp(10)),
                                                )
                                              ],
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                            )),
                                        SizedBox(
                                          width: ScreenUtil().setSp(6),
                                        ),
                                        myNotificationResult[index].targetMedia != null
                                            ? InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ontext) =>
                                                      NotificationPostScreen(myNotificationResult[index].targetId!,myNotificationResult[index].postType!,myNotificationResult[index].type!)),
                                            );
                                          },
                                          child: Container(
                                            child: Image.network(
                                              '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${myNotificationResult[index].targetMedia}-xs',
                                              fit: BoxFit.cover,
                                            ),
                                            height: ScreenUtil().radius(35),
                                            width: ScreenUtil().radius(35),
                                          ),
                                        )
                                            : Container()
                                      ]),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  SizedBox(
                    height: ScreenUtil().setSp(38),
                  ),
                  Text("Gifted to-",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          fontSize:
                          ScreenUtil().setSp(12),
                          color: black)),
                  SizedBox(
                    height: ScreenUtil().setSp(4),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: lightGray,
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: mygiftedNotificationResult.length,
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setSp(25),
                            right: ScreenUtil().setSp(37)),
                        itemBuilder: (listContext, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setSp(12),
                                      bottom: ScreenUtil().setSp(7)),
                                  child: Text(
                                      mygiftedNotificationResult[index].durationTime != null
                                          ? mygiftedNotificationResult[index].durationTime!
                                          : "",
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: FontWeight.w400,
                                          color: lightGray)),
                                ),
                                visible:
                                mygiftedNotificationResult[index].durationTime != null,
                              ),
                              InkWell(
                                onTap: () {
                                  Constants.profileUserId =
                                      mygiftedNotificationResult[index].targetId;
                                  if (mygiftedNotificationResult[index].type ==
                                      "followUser") {
                                    if (Constants.userId == Constants.profileUserId) {
                                      if (mygiftedNotificationResult[index].sourceType == "individual") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ProfileScreen()));
                                      } else if (mygiftedNotificationResult[index].sourceType == "agency") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AgencyProfileScreen()));
                                      } else if (mygiftedNotificationResult[index].sourceType == "brand") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BrandProfileScreen()));
                                      }
                                    } else {
                                      if (mygiftedNotificationResult[index].sourceType == "individual") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OtherProfileScreen()));
                                      } else if (mygiftedNotificationResult[index].sourceType == "agency") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AgencyOtherProfileScreen()));
                                      } else if (mygiftedNotificationResult[index].sourceType == "brand") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BrandOtherProfileScreen()));
                                      }
                                    }
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: ScreenUtil().setSp(12)),
                                  child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Constants.profileUserId =
                                                mygiftedNotificationResult[index].sourceId;
                                            if (Constants.userId == Constants.profileUserId) {
                                              if (mygiftedNotificationResult[index].sourceType == "individual") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => ProfileScreen()));
                                              } else if (mygiftedNotificationResult[index].sourceType == "agency") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AgencyProfileScreen()));
                                              } else if (mygiftedNotificationResult[index].sourceType == "brand") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BrandProfileScreen()));
                                              }
                                            } else {
                                              if (mygiftedNotificationResult[index].sourceType == "individual") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OtherProfileScreen()));
                                              } else if (mygiftedNotificationResult[index].sourceType == "agency") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AgencyOtherProfileScreen()));
                                              } else if (mygiftedNotificationResult[index].sourceType == "brand") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BrandOtherProfileScreen()));
                                              }
                                            }
                                          },
                                          child:
                                          mygiftedNotificationResult[index].sourceMedia !=
                                              null
                                              ? CircleAvatar(
                                            radius: ScreenUtil().radius(15),
                                            backgroundImage: NetworkImage(
                                                "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${mygiftedNotificationResult[index].sourceMedia}-xs"),
                                          )
                                              : CircleAvatar(
                                            radius: ScreenUtil().radius(15),
                                          ),
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setSp(6),
                                        ),
                                        Expanded(
                                            child: Column(
                                              children: [
                                                Text.rich(TextSpan(children: <TextSpan>[
                                                  TextSpan(
                                                      recognizer: new TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Constants.profileUserId =
                                                              mygiftedNotificationResult[index]
                                                                  .sourceId;
                                                          if (Constants.userId == Constants.profileUserId) {
                                                            if (mygiftedNotificationResult[index].sourceType == "individual") {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => ProfileScreen()));
                                                            } else if (mygiftedNotificationResult[index].sourceType == "agency") {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          AgencyProfileScreen()));
                                                            } else if (mygiftedNotificationResult[index].sourceType == "brand") {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          BrandProfileScreen()));
                                                            }
                                                          } else {
                                                            if (mygiftedNotificationResult[index].sourceType == "individual") {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          OtherProfileScreen()));
                                                            } else if (mygiftedNotificationResult[index].sourceType == "agency") {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          AgencyOtherProfileScreen()));
                                                            } else if (mygiftedNotificationResult[index].sourceType == "brand") {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          BrandOtherProfileScreen()));
                                                            }
                                                          }
                                                        },
                                                      text: mygiftedNotificationResult[index]
                                                          .source!.contains("&")?mygiftedNotificationResult[index]
                                                          .source!.split("&")[0]:mygiftedNotificationResult[index]
                                                          .source,
                                                      style: GoogleFonts.nunitoSans(
                                                          fontWeight: FontWeight.w700,
                                                          color: black,
                                                          fontSize:
                                                          ScreenUtil().setSp(12))),
                                                  TextSpan(
                                                      recognizer: new TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Constants.profileUserId =
                                                              mygiftedNotificationResult[index]
                                                                  .sourceId;
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      FollowerInfoScreen(id: myNotificationResult[index].sourceId)));
                                                        },
                                                      text: mygiftedNotificationResult[index]
                                                          .source!.contains("&")?' & ${mygiftedNotificationResult[index]
                                                          .source!.split("&")[1]}':"",
                                                      style: GoogleFonts.nunitoSans(
                                                          fontWeight: FontWeight.w700,
                                                          color: black,
                                                          fontSize:
                                                          ScreenUtil().setSp(12))),
                                                  TextSpan(
                                                      text: mygiftedNotificationResult[index]
                                                          .action !=
                                                          null
                                                          ? ' ${mygiftedNotificationResult[index].action}'
                                                          : "",
                                                      style: GoogleFonts.nunitoSans(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: ScreenUtil().setSp(12),
                                                          color: black)),
                                                  TextSpan(
                                                      text: mygiftedNotificationResult[index]
                                                          .data !=
                                                          null
                                                          ? ' ${mygiftedNotificationResult[index].data}'
                                                          : "",
                                                      style: GoogleFonts.nunitoSans(
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: ScreenUtil().setSp(12),
                                                          color: buttonBlue)),
                                                  TextSpan(
                                                      text: mygiftedNotificationResult[index]
                                                          .body !=
                                                          null
                                                          ? ' ${mygiftedNotificationResult[index].body}'
                                                          : "",
                                                      style: GoogleFonts.nunitoSans(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: ScreenUtil().setSp(12),
                                                          color: black))
                                                ])),
                                                Text(
                                                  convertToAgo(DateTime.parse(
                                                      mygiftedNotificationResult[index]
                                                          .updatedAt!)),
                                                  style: GoogleFonts.nunitoSans(
                                                      fontWeight: FontWeight.w400,
                                                      color: darkGray,
                                                      fontSize: ScreenUtil().setSp(10)),
                                                )
                                              ],
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                            )),
                                        SizedBox(
                                          width: ScreenUtil().setSp(6),
                                        ),
                                        mygiftedNotificationResult[index].targetMedia != null
                                            ? InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ontext) =>
                                                      NotificationPostScreen(mygiftedNotificationResult[index].targetId!,mygiftedNotificationResult[index].postType!,mygiftedNotificationResult[index].type!)),
                                            );
                                          },
                                          child: Container(
                                            child: Image.network(
                                              '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${mygiftedNotificationResult[index].targetMedia}-xs',
                                              fit: BoxFit.cover,
                                            ),
                                            height: ScreenUtil().radius(35),
                                            width: ScreenUtil().radius(35),
                                          ),
                                        )
                                            : Container()
                                      ]),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
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

  void _notification() async {
    Map<String, dynamic> formData = {
      "page": page.toString(),
      "type": "received",
    };
    Api.get.call(context,
        method: "users/notifications",
        param: formData,
        onResponseSuccess: (Map object) {
          List<Result> todayList = [];
          List<Result> yesterdayList = [];
          List<Result> lastWeekList = [];
          List<Result> lastMonthList = [];
          var result = MyNotificationResponse.fromJson(object);
          for (int i = 0; i < result.result!.length; i++) {
            Result resultModel = result.result![i];
            DateTime date = DateTime.parse(resultModel.updatedAt!);
            DateTime today =
            dateFormat.parse(dateFormat.format(DateTime.now()));
            DateTime yesterday = dateFormat
                .parse(dateFormat.format(DateTime.now()))
                .subtract(Duration(days: 1));
            DateTime updatedAt = dateFormat.parse(dateFormat.format(date));
            if (updatedAt.compareTo(today) == 0) {
              if (todayList.length == 0) {
                resultModel.durationTime = "Today";
              }
              todayList.add(resultModel);
            } else if (updatedAt.compareTo(yesterday) == 0) {
              if (yesterdayList.length == 0) {
                resultModel.durationTime = "Yesterday";
              }
              yesterdayList.add(resultModel);
            } else if (updatedAt.month < today.month) {
              if (lastMonthList.length == 0) {
                resultModel.durationTime = "Last Month";
              }
              lastMonthList.add(resultModel);
            } else {
              print("API_MONTH::${updatedAt.month}");
              print("TODAY_MONTH::${today.month}");
              if (lastWeekList.length == 0) {
                resultModel.durationTime = "Last Week";
              }
              lastWeekList.add(resultModel);
            }
          }
          myNotificationResult.addAll(todayList);
          myNotificationResult.addAll(yesterdayList);
          myNotificationResult.addAll(lastWeekList);
          myNotificationResult.addAll(lastMonthList);
          setState(() {});
        });
  }
  void _giftedNotification() async {
    Map<String, dynamic> formData = {
      "page": page.toString(),
      "type": "gifted",
    };
    Api.get.call(context,
        method: "users/notifications",
        param: formData,
        isLoading: false,
        onResponseSuccess: (Map object) {
          List<Result> todayList = [];
          List<Result> yesterdayList = [];
          List<Result> lastWeekList = [];
          List<Result> lastMonthList = [];
          var result = MyNotificationResponse.fromJson(object);
          for (int i = 0; i < result.result!.length; i++) {
            Result resultModel = result.result![i];
            DateTime date = DateTime.parse(resultModel.updatedAt!);
            DateTime today =
            dateFormat.parse(dateFormat.format(DateTime.now()));
            DateTime yesterday = dateFormat
                .parse(dateFormat.format(DateTime.now()))
                .subtract(Duration(days: 1));
            DateTime updatedAt = dateFormat.parse(dateFormat.format(date));
            if (updatedAt.compareTo(today) == 0) {
              if (todayList.length == 0) {
                resultModel.durationTime = "Today";
              }
              todayList.add(resultModel);
            } else if (updatedAt.compareTo(yesterday) == 0) {
              if (yesterdayList.length == 0) {
                resultModel.durationTime = "Yesterday";
              }
              yesterdayList.add(resultModel);
            } else if (updatedAt.month < today.month) {
              if (lastMonthList.length == 0) {
                resultModel.durationTime = "Last Month";
              }
              lastMonthList.add(resultModel);
            } else {
              print("API_MONTH::${updatedAt.month}");
              print("TODAY_MONTH::${today.month}");
              if (lastWeekList.length == 0) {
                resultModel.durationTime = "Last Week";
              }
              lastWeekList.add(resultModel);
            }
          }
          mygiftedNotificationResult.addAll(todayList);
          mygiftedNotificationResult.addAll(yesterdayList);
          mygiftedNotificationResult.addAll(lastWeekList);
          mygiftedNotificationResult.addAll(lastMonthList);
          setState(() {});
        });
  }
}
