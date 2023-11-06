import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/Profile_Model.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationSettingsScreen extends StatefulWidget {
  Notifications notification;

  NotificationSettingsScreen(this.notification);

  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool switchComment = false;
  bool switchHearts = false;
  bool switchTrending = false;
  bool switchFollowers = false;
  bool switchSponsor = false;
  bool switchLive = false;
  bool switchUpcoming = false;
  bool switchEnding = false;
  final ApiProvider _api = ApiProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print('1-1-1-1-1-1${widget.notification.comments}');
    switchComment = widget.notification.comments!;
    switchHearts = widget.notification.likes!;
    switchTrending = widget.notification.trendingPosts!;
    switchFollowers = widget.notification.newFollower!;
    switchSponsor = widget.notification.sponser!;
    switchLive = widget.notification.liveEvents!;
    switchUpcoming = widget.notification.upcomingChallenges!;
    switchEnding = widget.notification.endingChallenges!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        //backwardsCompatibility: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        // iconTheme: IconThemeData(color: black),
        toolbarHeight: ScreenUtil().setHeight(61),
        backgroundColor: appBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(
              text: 'Notification',
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  color: lightRed,
                  fontSize: ScreenUtil().setSp(18))),
          TextSpan(
              text: ' Settings',
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(18),
                  color: black))
        ])),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: Text(
                      'Enable/Disable Notification',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.w400,
                          color: darkGray),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Comments',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(14),
                          color: black),
                    ),
                    trailing: Switch(
                      value: switchComment,
                      inactiveTrackColor: lightGray,
                      activeTrackColor: darkGray,
                      thumbColor: MaterialStateProperty.all(darkGray),
                      onChanged: (bool value) {
                        setState(() {
                          switchComment = !switchComment;
                        });
                        updateSetting();
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Hearts on your Post',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(14),
                          color: black),
                    ),
                    trailing: Switch(
                      value: switchHearts,
                      inactiveTrackColor: lightGray,
                      activeTrackColor: darkGray,
                      thumbColor: MaterialStateProperty.all(darkGray),
                      onChanged: (bool value) {
                        setState(() {
                          switchHearts = !switchHearts;
                        });
                        updateSetting();
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Trending Posts',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(14),
                          color: black),
                    ),
                    trailing: Switch(
                      value: switchTrending,
                      inactiveTrackColor: lightGray,
                      activeTrackColor: darkGray,
                      thumbColor: MaterialStateProperty.all(darkGray),
                      onChanged: (bool value) {
                        setState(() {
                          switchTrending = !switchTrending;
                        });
                        updateSetting();
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'New Followers',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(14),
                          color: black),
                    ),
                    trailing: Switch(
                      value: switchFollowers,
                      inactiveTrackColor: lightGray,
                      activeTrackColor: darkGray,
                      thumbColor: MaterialStateProperty.all(darkGray),
                      onChanged: (bool value) {
                        setState(() {
                          switchFollowers = !switchFollowers;
                        });
                        updateSetting();
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Sponsor Offers & Requests',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(14),
                          color: black),
                    ),
                    trailing: Switch(
                      value: switchSponsor,
                      inactiveTrackColor: lightGray,
                      activeTrackColor: darkGray,
                      thumbColor: MaterialStateProperty.all(darkGray),
                      onChanged: (bool value) {
                        setState(() {
                          switchSponsor = !switchSponsor;
                        });
                        updateSetting();
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Live Events',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(14),
                          color: black),
                    ),
                    trailing: Switch(
                      value: switchLive,
                      inactiveTrackColor: lightGray,
                      activeTrackColor: darkGray,
                      thumbColor: MaterialStateProperty.all(darkGray),
                      onChanged: (bool value) {
                        setState(() {
                          switchLive = !switchLive;
                        });
                        updateSetting();
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Upcoming Challenges',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(14),
                          color: black),
                    ),
                    trailing: Switch(
                      value: switchUpcoming,
                      inactiveTrackColor: lightGray,
                      activeTrackColor: darkGray,
                      thumbColor: MaterialStateProperty.all(darkGray),
                      onChanged: (bool value) {
                        setState(() {
                          switchUpcoming = !switchUpcoming;
                        });
                        updateSetting();
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Ending Challenges',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(14),
                          color: black),
                    ),
                    trailing: Switch(
                      value: switchEnding,
                      inactiveTrackColor: lightGray,
                      activeTrackColor: darkGray,
                      thumbColor: MaterialStateProperty.all(darkGray),
                      onChanged: (bool value) {
                        setState(() {
                          switchEnding = !switchEnding;
                        });
                        updateSetting();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(10),
                  bottom: ScreenUtil().setHeight(72)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        switchComment = true;
                        switchEnding = true;
                        switchUpcoming = true;
                        switchLive = true;
                        switchSponsor = true;
                        switchFollowers = true;
                        switchTrending = true;
                        switchHearts = true;
                      });
                      updateSetting();
                    },
                    child: Text(
                      'Reset All',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(14),
                          color: black),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        switchComment = true;
                        switchEnding = true;
                        switchUpcoming = true;
                        switchLive = true;
                        switchSponsor = true;
                        switchFollowers = true;
                        switchTrending = true;
                        switchHearts = true;
                      });
                      updateSetting();
                    },
                    child: Text(
                      'Enable All',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(14),
                          color: black),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        switchComment = false;
                        switchEnding = false;
                        switchUpcoming = false;
                        switchLive = false;
                        switchSponsor = false;
                        switchFollowers = false;
                        switchTrending = false;
                        switchHearts = false;
                      });
                      updateSetting();
                    },
                    child: Text(
                      'Disable All',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(14),
                          color: black),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  updateSetting() async {
    widget.notification.comments = switchComment;
    widget.notification.likes = switchHearts;
    widget.notification.trendingPosts = switchTrending;
    widget.notification.newFollower = switchFollowers;
    widget.notification.sponser = switchSponsor;
    widget.notification.liveEvents = switchLive;
    widget.notification.upcomingChallenges = switchUpcoming;
    widget.notification.endingChallenges = switchEnding;
    Map<String, dynamic> map = {
      "settings": {
        "notification": {
          "comments": switchComment,
          "likes": switchHearts,
          "trendingPosts": switchTrending,
          "newFollower": switchFollowers,
          "sponser": switchSponsor,
          "liveEvents": switchLive,
          "upcomingChallenges": switchUpcoming,
          "endingChallenges": switchEnding,
        }
      }
    };
    Api.put.call(context,
        method: "users/settings",
        param: map,
        isLoading: false, onResponseSuccess: (Map object) {
      print(object);
    });
  }
}
