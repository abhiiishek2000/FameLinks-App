import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/my_followers_model.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/home_feed/component/home_feed.dart';
import 'package:famelink/ui/otherUserProfile/OthersProfile.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowerInfoScreen extends StatefulWidget {
  bool? isFollowing;
  final id;
  FollowerInfoScreen({this.isFollowing, this.id});
  @override
  _FollowerInfoScreenState createState() => _FollowerInfoScreenState();
}

class _FollowerInfoScreenState extends State<FollowerInfoScreen>
    with SingleTickerProviderStateMixin {
  final ApiProvider _api = ApiProvider();

  List<MyFollowersResult> myFollowersResult = [];

  List<MyFollowersResult> mySuggestionsResult = [];

  List myFollowingResult = [];

  int followersPage = 1;
  int followingPage = 1;
  int suggestionsPage = 1;
  ScrollController followersScrollController = ScrollController();
  ScrollController followingScrollController = ScrollController();
  ScrollController suggestionsScrollController = ScrollController();

  TabController? tabController;
  String? id;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    followersScrollController.addListener(() {
      if (followersScrollController.position.maxScrollExtent ==
          followersScrollController.position.pixels) {
        followersPage++;
        _followers();
      }
    });
    followingScrollController.addListener(() {
      if (followingScrollController.position.maxScrollExtent ==
          followingScrollController.position.pixels) {
        followingPage++;
        _following();
      }
    });
    suggestionsScrollController.addListener(() {
      if (suggestionsScrollController.position.maxScrollExtent ==
          suggestionsScrollController.position.pixels) {
        suggestionsPage++;
        _suggestions();
      }
    });
    _followers();
    _following();
    _suggestions();
    if (widget.isFollowing!) {
      setState(() {
        tabController!.index = 1;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //floatingActionButton: CustomFab(),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        //backwardsCompatibility: true,
        iconTheme: IconThemeData(color: black),
        toolbarHeight: ScreenUtil().setHeight(61),
        backgroundColor: appBackgroundColor,
        elevation: 0,
      ),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: TabBar(
                tabs: [
                  Tab(
                    text: "Followers",
                  ),
                  Tab(text: "Following"),
                  Tab(text: "Suggestions"),
                ],
                labelColor: black,
                unselectedLabelColor: lightGray,
                indicatorColor: black,
                unselectedLabelStyle: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(14)),
                labelStyle: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenUtil().setSp(14)),
                controller: tabController,
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Container(
                      child: myFollowersResult.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              controller: followersScrollController,
                              itemCount: myFollowersResult.length,
                              itemBuilder: (followersContext, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setSp(20),
                                      right: ScreenUtil().setSp(20),
                                      top: ScreenUtil().setSp(15)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OtherProfile(
                                                        id: myFollowersResult[
                                                                index]
                                                            .id!,
                                                        selectPhase: 0,
                                                      )));
                                          // Constants.profileUserId =
                                          //     myFollowersResult[index].id;
                                          // if (Constants.userId == Constants.profileUserId) {
                                          //   if(myFollowersResult[index].type == "individual") {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) => ProfileScreen()));
                                          //   }else if(myFollowersResult[index].type == "agency") {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) => AgencyProfileScreen()));
                                          //   }else if(myFollowersResult[index].type == "brand") {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) => BrandProfileScreen()));
                                          //   }
                                          // } else {
                                          //   if(myFollowersResult[index].type == "individual") {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) => OtherProfileScreen()));
                                          //   }else if(myFollowersResult[index].type == "agency") {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) => AgencyOtherProfileScreen()));
                                          //   }else if(myFollowersResult[index].type == "brand") {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) => BrandOtherProfileScreen()));
                                          //   }
                                          // }
                                        },
                                        child: myFollowersResult[index]
                                                    .profileImage !=
                                                null
                                            ? myFollowersResult[index]
                                                        .profileImageType ==
                                                    "avatar"
                                                ? CircleAvatar(
                                                    backgroundColor: lightGray,
                                                    radius:
                                                        ScreenUtil().radius(17),
                                                    backgroundImage: NetworkImage(
                                                        "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${myFollowersResult[index].profileImage}"),
                                                  )
                                                : CircleAvatar(
                                                    backgroundColor: lightGray,
                                                    radius:
                                                        ScreenUtil().radius(17),
                                                    backgroundImage: NetworkImage(
                                                        "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${myFollowersResult[index].profileImage}"),
                                                  )
                                            : CircleAvatar(
                                                backgroundColor: lightGray,
                                                radius: ScreenUtil().radius(17),
                                              ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OtherProfile(
                                                          id: myFollowersResult[
                                                                  index]
                                                              .id!,
                                                          selectPhase: 0,
                                                        )));

                                            // Constants.profileUserId =
                                            //     myFollowersResult[index].id;
                                            // if (Constants.userId == Constants.profileUserId) {
                                            //   if(myFollowersResult[index].type == "individual") {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) => ProfileScreen()));
                                            //   }else if(myFollowersResult[index].type == "agency") {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) => AgencyProfileScreen()));
                                            //   }else if(myFollowersResult[index].type == "brand") {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) => BrandProfileScreen()));
                                            //   }
                                            // } else {
                                            //   if(myFollowersResult[index].type == "individual") {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) => OtherProfileScreen()));
                                            //   }else if(myFollowersResult[index].type == "agency") {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) => AgencyOtherProfileScreen()));
                                            //   }else if(myFollowersResult[index].type == "brand") {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) => BrandOtherProfileScreen()));
                                            //   }
                                            // }
                                          },
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                        '${myFollowersResult[index].name}',
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            14),
                                                                color: black)),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        ScreenUtil().setSp(5),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      Api.post.call(context,
                                                          method:
                                                              "users/follow/${myFollowersResult[index].id}",
                                                          param: {},
                                                          onResponseSuccess:
                                                              (Map object) {
                                                        myFollowingResult.add(
                                                            myFollowersResult[
                                                                index]);
                                                        setState(() {});
                                                      });
                                                    },
                                                    child: Text(
                                                      'Follow Back',
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          12),
                                                              color: black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Wrap(
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                children: [
                                                  ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                        maxWidth: (ScreenUtil()
                                                                .screenWidth /
                                                            2)),
                                                    child: Text(
                                                        myFollowersResult[
                                                                        index]
                                                                    .name !=
                                                                null
                                                            ? '${myFollowersResult[index].username} '
                                                            : "",
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            12),
                                                                color:
                                                                    darkGray)),
                                                  ),
                                                  Container(
                                                    width:
                                                        ScreenUtil().setSp(3),
                                                    height:
                                                        ScreenUtil().setSp(3),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: lightGray,
                                                    ),
                                                  ),
                                                  Text(
                                                      myFollowersResult[
                                                                      index]
                                                                  .district !=
                                                              null
                                                          ? ' ${myFollowersResult[index].district}, ${myFollowersResult[index].country}'
                                                          : "",
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          12),
                                                              color:
                                                                  lightGray)),
                                                ],
                                              )
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Visibility(
                                        visible: Constants.userId ==
                                            Constants.profileUserId,
                                        child: SizedBox(
                                          height: ScreenUtil().setHeight(30),
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          appBackgroundColor),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                          ),
                                                          side: BorderSide(
                                                              color:
                                                                  lightGray)))),
                                              onPressed: () async {
                                                Api.delete.call(context,
                                                    method:
                                                        "users/removeFollower/${myFollowersResult[index].id}",
                                                    param: {},
                                                    onResponseSuccess:
                                                        (Map object) {
                                                  myFollowersResult
                                                      .removeAt(index);
                                                  setState(() {

                                                  });
                                                });
                                              },
                                              child: Text(
                                                'Remove',
                                                style: GoogleFonts.nunitoSans(
                                                    color: lightGray,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        appBackgroundColor),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                          topRight:
                                                              Radius.circular(
                                                                  5),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5),
                                                        ),
                                                        side: BorderSide(
                                                            color:
                                                                buttonBlue)))),
                                            onPressed: () async {
                                              Api.post.call(context,
                                                  method:
                                                      "users/follow/${myFollowersResult[index].id}",
                                                  param: {}, onResponseSuccess:
                                                      (Map object) {
                                                myFollowersResult[index]
                                                    .followStatus = "follow";
                                                setState(() {});
                                              });
                                            },
                                            child: Text(
                                              'Follow',
                                              style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize:
                                                      ScreenUtil().setSp(12),
                                                  color: buttonBlue),
                                            )),
                                        height: ScreenUtil().setHeight(30),
                                      ),
                                    ],
                                  ),
                                );
                              })
                          : Center(
                              child: Text("No Followers Found",
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                    ),
                    Container(
                      child: myFollowingResult.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              controller: followingScrollController,
                              itemCount: myFollowingResult.length,
                              itemBuilder: (followersContext, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setSp(20),
                                      right: ScreenUtil().setSp(20),
                                      top: ScreenUtil().setSp(15)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OtherProfile(
                                                        id: myFollowingResult[
                                                                index]
                                                            .id,
                                                        selectPhase: 0,
                                                      )));

                                          // Constants.profileUserId =
                                          //     myFollowingResult[index].id;
                                          // if (Constants.userId == Constants.profileUserId) {
                                          //   if(myFollowingResult[index].type == "individual") {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) => ProfileScreen()));
                                          //   }else if(myFollowingResult[index].type == "agency") {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) => AgencyProfileScreen()));
                                          //   }else if(myFollowingResult[index].type == "brand") {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) => BrandProfileScreen()));
                                          //   }
                                          // } else {
                                          //   if(myFollowingResult[index].type == "individual") {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) => OtherProfileScreen()));
                                          //   }else if(myFollowingResult[index].type == "agency") {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) => AgencyOtherProfileScreen()));
                                          //   }else if(myFollowingResult[index].type == "brand") {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) => BrandOtherProfileScreen()));
                                          //   }
                                          // }
                                        },
                                        child: myFollowingResult[index]
                                                    .profileImage !=
                                                null
                                            ? CircleAvatar(
                                                backgroundColor: lightGray,
                                                radius: ScreenUtil().radius(17),
                                                backgroundImage: NetworkImage(
                                                    "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${myFollowingResult[index].profileImage}"),
                                              )
                                            : CircleAvatar(
                                                backgroundColor: lightGray,
                                                radius: ScreenUtil().radius(17),
                                              ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OtherProfile(
                                                          id: myFollowingResult[
                                                                  index]
                                                              .id,
                                                          selectPhase: 0,
                                                        )));
                                            // Constants.profileUserId =
                                            //     myFollowingResult[index].id;
                                            // if (Constants.userId == Constants.profileUserId) {
                                            //   if(myFollowingResult[index].type == "individual") {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) => ProfileScreen()));
                                            //   }else if(myFollowingResult[index].type == "agency") {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) => AgencyProfileScreen()));
                                            //   }else if(myFollowingResult[index].type == "brand") {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) => BrandProfileScreen()));
                                            //   }
                                            // } else {
                                            //   if(myFollowingResult[index].type == "individual") {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) => OtherProfileScreen()));
                                            //   }else if(myFollowingResult[index].type == "agency") {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) => AgencyOtherProfileScreen()));
                                            //   }else if(myFollowingResult[index].type == "brand") {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) => BrandOtherProfileScreen()));
                                            //   }
                                            // }
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                  '${myFollowingResult[index].name}',
                                                  style: GoogleFonts.nunitoSans(
                                                      fontSize: ScreenUtil()
                                                          .setSp(14),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: black)),
                                              Wrap(
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                children: [
                                                  ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                        maxWidth: (ScreenUtil()
                                                                .screenWidth /
                                                            2)),
                                                    child: Text(
                                                        myFollowingResult[
                                                                        index]
                                                                    .name !=
                                                                null
                                                            ? '${myFollowingResult[index].username} '
                                                            : "",
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            12),
                                                                color:
                                                                    darkGray)),
                                                  ),
                                                  Container(
                                                    width:
                                                        ScreenUtil().setSp(3),
                                                    height:
                                                        ScreenUtil().setSp(3),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: lightGray,
                                                    ),
                                                  ),
                                                  Text(
                                                      myFollowingResult[
                                                                      index]
                                                                  .district !=
                                                              null
                                                          ? ' ${myFollowingResult[index].district}, ${myFollowingResult[index].country}'
                                                          : "",
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          12),
                                                              color:
                                                                  lightGray)),
                                                ],
                                              )
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Visibility(
                                        // visible: Constants.userId == Constants.profileUserId,
                                        child: SizedBox(
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          appBackgroundColor),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    5),
                                                          ),
                                                          side: BorderSide(
                                                              color:
                                                                  lightGray)))),
                                              onPressed: () async {
                                                Api.delete.call(context,
                                                    method:
                                                        "users/unfollow/${myFollowingResult[index].id}",
                                                    param: {},
                                                    onResponseSuccess:
                                                        (Map object) {
                                                  myFollowingResult
                                                      .removeAt(index);
                                                  setState(() {
                                                  });
                                                });
                                              },
                                              child: Text(
                                                'UnFollow',
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    fontWeight: FontWeight.w400,
                                                    color: lightGray),
                                              )),
                                          height: ScreenUtil().setHeight(30),
                                        ),
                                      ),
                                      // Visibility(
                                      //   // visible:
                                      //   // !myFollowingResult[index]
                                      //   //     .followStatus &&
                                      //   //     Constants.userId !=
                                      //   //         Constants.profileUserId,
                                      //   child: SizedBox(
                                      //     child: ElevatedButton(
                                      //         style: ButtonStyle(
                                      //             backgroundColor:
                                      //             MaterialStateProperty.all<
                                      //                 Color>(
                                      //                 appBackgroundColor),
                                      //             shape: MaterialStateProperty.all<
                                      //                 RoundedRectangleBorder>(
                                      //                 RoundedRectangleBorder(
                                      //                     borderRadius:
                                      //                     BorderRadius.only(
                                      //                       topLeft:
                                      //                       Radius.circular(
                                      //                           5),
                                      //                       topRight:
                                      //                       Radius.circular(
                                      //                           5),
                                      //                       bottomLeft:
                                      //                       Radius.circular(
                                      //                           5),
                                      //                       bottomRight:
                                      //                       Radius.circular(
                                      //                           5),
                                      //                     ),
                                      //                     side: BorderSide(
                                      //                         color:
                                      //                         buttonBlue)))),
                                      //         onPressed: () async {
                                      //           Api.post.call(context, method: "users/follow/${myFollowingResult[index]
                                      //               .id}",
                                      //               param: {},
                                      //               onResponseSuccess: (Map object){
                                      //                 myFollowingResult[index].followStatus = true;
                                      //                 setState(() {});
                                      //               });
                                      //         },
                                      //         child: Text(
                                      //           'Follow',
                                      //           style: GoogleFonts.nunitoSans(
                                      //               fontWeight: FontWeight.w400,
                                      //               fontSize:
                                      //               ScreenUtil().setSp(12),
                                      //               color: buttonBlue),
                                      //         )),
                                      //     height: ScreenUtil().setHeight(30),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                );
                              })
                          : Center(
                              child: Text("No Following Found",
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                    ),
                    Container(
                      child: mySuggestionsResult.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              controller: suggestionsScrollController,
                              itemCount: mySuggestionsResult.length,
                              itemBuilder: (followersContext, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setSp(20),
                                      right: ScreenUtil().setSp(20),
                                      top: ScreenUtil().setSp(15)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OtherProfile(
                                                        id: mySuggestionsResult[
                                                                index]
                                                            .id!,
                                                        selectPhase: 0,
                                                      )));
                                          // Constants.profileUserId =
                                          //     mySuggestionsResult[index].id;
                                          // if (Constants.userId == Constants.profileUserId) {
                                          //   if(mySuggestionsResult[index].type == "individual") {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) => ProfileScreen()));
                                          //   }else if(mySuggestionsResult[index].type == "agency") {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) => AgencyProfileScreen()));
                                          //   }else if(mySuggestionsResult[index].type == "brand") {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) => BrandProfileScreen()));
                                          //   }
                                          // } else {
                                          //   if(mySuggestionsResult[index].type == "individual") {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) => OtherProfileScreen()));
                                          //   }else if(mySuggestionsResult[index].type == "agency") {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) => AgencyOtherProfileScreen()));
                                          //   }else if(mySuggestionsResult[index].type == "brand") {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) => BrandOtherProfileScreen()));
                                          //   }
                                          // }
                                        },
                                        child: mySuggestionsResult[index]
                                                    .profileImage !=
                                                null
                                            ? CircleAvatar(
                                                backgroundColor: lightGray,
                                                radius: ScreenUtil().radius(17),
                                                backgroundImage: NetworkImage(
                                                    "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${mySuggestionsResult[index].profileImage}"),
                                              )
                                            : CircleAvatar(
                                                backgroundColor: lightGray,
                                                radius: ScreenUtil().radius(17),
                                              ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OtherProfile(
                                                          id: mySuggestionsResult[
                                                                  index]
                                                              .id!,
                                                          selectPhase: 0,
                                                        )));
                                            // Constants.profileUserId =
                                            //     mySuggestionsResult[index].id;
                                            // if (Constants.userId == Constants.profileUserId) {
                                            //   if(mySuggestionsResult[index].type == "individual") {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) => ProfileScreen()));
                                            //   }else if(mySuggestionsResult[index].type == "agency") {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) => AgencyProfileScreen()));
                                            //   }else if(mySuggestionsResult[index].type == "brand") {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) => BrandProfileScreen()));
                                            //   }
                                            // } else {
                                            //   if(mySuggestionsResult[index].type == "individual") {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) => OtherProfileScreen()));
                                            //   }else if(mySuggestionsResult[index].type == "agency") {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) => AgencyOtherProfileScreen()));
                                            //   }else if(mySuggestionsResult[index].type == "brand") {
                                            //     Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //             builder: (context) => BrandOtherProfileScreen()));
                                            //   }
                                            // }
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                  '${mySuggestionsResult[index].name}',
                                                  style: GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: ScreenUtil()
                                                          .setSp(14),
                                                      color: black)),
                                              Text(
                                                  mySuggestionsResult[index]
                                                              .district !=
                                                          null
                                                      ? '${mySuggestionsResult[index].district}, ${mySuggestionsResult[index].country}'
                                                      : "",
                                                  style: GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: ScreenUtil()
                                                          .setSp(12),
                                                      color: lightGray)),
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        appBackgroundColor),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  5),
                                                          topRight:
                                                              Radius.circular(
                                                                  5),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  5),
                                                        ),
                                                        side: BorderSide(
                                                            color:
                                                                buttonBlue)))),
                                            onPressed: () async {
                                              if (mySuggestionsResult[index]
                                                      .followStatus ==
                                                  "") {
                                                Api.delete.call(context,
                                                    method:
                                                        "users/unfollow/${mySuggestionsResult[index].id}",
                                                    param: {},
                                                    onResponseSuccess:
                                                        (Map object) {
                                                  myFollowingResult.add(
                                                      mySuggestionsResult[
                                                          index]);
                                                  setState(() {
                                                  });
                                                });
                                              } else {
                                                Api.post.call(context,
                                                    method:
                                                        "users/follow/${mySuggestionsResult[index].id}",
                                                    param: {},
                                                    onResponseSuccess:
                                                        (Map object) {
                                                  myFollowingResult.insert(
                                                      0,
                                                      mySuggestionsResult[
                                                          index]);
                                                  mySuggestionsResult
                                                      .removeAt(index);
                                                  setState(() {
                                                  });
                                                });
                                              }
                                            },
                                            child: Text(
                                              mySuggestionsResult[index]
                                                          .followStatus ==
                                                      "Follow"
                                                  ? 'UnFollow'
                                                  : 'Follow',
                                              style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize:
                                                      ScreenUtil().setSp(12),
                                                  color: buttonBlue),
                                            )),
                                        height: ScreenUtil().setHeight(30),
                                      ),
                                    ],
                                  ),
                                );
                              })
                          : Center(
                              child: Text("No Suggestions Found",
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
    Map<String, dynamic> param = {"page": followersPage.toString()};

    Api.get.call(context, method: "users/${widget.id}/followers", param: param,
        onResponseSuccess: (Map<dynamic, dynamic> object) {
      var result = MyFollowersResponse.fromJson(object);
      if (result.result!.length > 0) {
        myFollowersResult.addAll(result.result!);
        setState(() {});
        print('RESPONSE ${result.result.toString()}');
      } else {
        followersPage--;
      }
    });
  }

  void _following() async {
    Map<String, dynamic> param = {
      "page": followingPage.toString(),
    };

    Api.get.call(context,
        method: "users/${widget.id}/followees",
        param: param,
        isLoading: false, onResponseSuccess: (Map object) {
      var result = MyFollowersResponse.fromJson(object);
      if (result.result!.length > 0) {
        myFollowingResult.addAll(result.result!);
        setState(() {});
        print('RESPONSE ${result.result.toString()}');
      } else {
        followingPage--;
      }
    });
  }

  void _suggestions() async {
    Map<String, dynamic> param = {
      "page": suggestionsPage.toString(),
    };

    Api.get.call(context,
        method: "users/follow/suggestions",
        param: param,
        isLoading: false, onResponseSuccess: (Map object) {
      var result = MyFollowersResponse.fromJson(object);
      if (result.result!.length > 0) {
        mySuggestionsResult.addAll(result.result!);
        setState(() {});
        print('RESPONSE ${result.result.toString()}');
      } else {
        suggestionsPage--;
      }
    });
  }

// void _notification() async {
//   bool internet = await Constants.isInternetAvailable();
//   if (internet) {
//     Constants.progressDialog(true, context);
//     var result = await _api.getnotificationService();
//     if (result != null) {
//       Constants.progressDialog(false, context);
//       if (result.success.toString() == "true") {
//         myNotificationResult = result.result;
//         setState(() {});
//         print('RESPONSE ${result.result.toString()}');
//       } else
//         Constants.toastMessage(msg: result.message);
//     }
//   }
//
// }
}
