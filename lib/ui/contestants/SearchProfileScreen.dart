import 'dart:io';

import 'package:dio/dio.dart';
import 'package:famelink/databse/AppDatabase.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/search_model.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/Famelinkprofile/ProfileFameLink.dart';
import 'package:famelink/ui/funlinks/FameLinksChallengeScreen.dart';
import 'package:famelink/ui/funlinks/FunLinksChallengeScreen.dart';
import 'package:famelink/ui/settings/profile_verification_screen.dart';
import 'package:famelink/ui/upload/upload_screen_one.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_compress/video_compress.dart';

import '../otherUserProfile/OthersProfile.dart';

class SearchProfileScreen extends StatefulWidget {
  String postType;
  String search;

  SearchProfileScreen(this.postType, this.search);

  @override
  _SearchProfileScreenState createState() => _SearchProfileScreenState();
}

class _SearchProfileScreenState extends State<SearchProfileScreen> {
  final ApiProvider _api = ApiProvider();
  TextEditingController nameController = TextEditingController();
  List<SearchUsers> myFollowersResult = [];
  List<SearchChallenges> myChallengeResult = [];
  List<HashTags> myHashTagsResult = [];
  List<SearchChallenges> searchChallenge = [];
  int page = 1;
  final GlobalKey<FormState> _profileKey = GlobalKey<FormState>();
  String ageGroup = 'groupE';

  void _followers(String search) async {
    Map<String, dynamic> param = {
      "page": page.toString(),
      "search": search,
      "type": widget.postType,
    };
    Api.get.call(context, method: "users/search", param: param,
        onResponseSuccess: (Map<dynamic, dynamic> object) {
      var result = SearchResponse.fromJson(object);
      myFollowersResult = result.result!.users!;
      myChallengeResult = result.result!.challenges!;
      myHashTagsResult = result.result!.hashTags!;
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.search.isNotEmpty) {
      _followers(widget.search);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: appBackgroundColor,
        elevation: 0,
      ),
      body: body(),
    );
  }

  Widget body() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(1),
              left: ScreenUtil().setWidth(43),
              right: ScreenUtil().setWidth(43)),
          child: TextFormField(
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            controller: nameController,
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (value) {
              _followers(value);
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: lightRed, width: ScreenUtil().radius(2)),
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().radius(16))),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: lightGray, width: ScreenUtil().radius(2)),
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().radius(16))),
                ),
                contentPadding:
                    EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                hintText: 'Search',
                hintStyle: GoogleFonts.nunitoSans(
                    fontSize: ScreenUtil().setSp(14),
                    color: lightGray,
                    fontWeight: FontWeight.w400),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: lightGray),
                  onPressed: () {
                    _followers(nameController.text);
                  },
                )),
          ),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(25)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: myFollowersResult.length > 0
                        ? myFollowersResult.length + 1
                        : 0,
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(25),
                        right: ScreenUtil().setWidth(25)),
                    itemBuilder: (followersContext, index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(8)),
                          child: Text("Profiles",
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: ScreenUtil().setSp(12),
                                  color: darkGray)),
                        );
                      } else {
                        return Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    // ApiProvider.profileUserId = myFollowersResult[index-1].sId;
                                    // if (Constants.userId == ApiProvider.profileUserId) {
                                    //   if(myFollowersResult[index-1].type == "individual") {
                                    //     Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (context) => ProfileScreen()));
                                    //   }else if(myFollowersResult[index-1].type == "agency") {
                                    //     Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (context) => AgencyProfileScreen()));
                                    //   }else if(myFollowersResult[index-1].type == "brand") {
                                    //     Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (context) => BrandProfileScreen()));
                                    //   }
                                    // } else {
                                    //   if(myFollowersResult[index-1].type == "individual") {
                                    //     Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (context) => OtherProfileScreen()));
                                    //   }else if(myFollowersResult[index-1].type == "agency") {
                                    //     Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (context) => AgencyOtherProfileScreen()));
                                    //   }else if(myFollowersResult[index-1].type == "brand") {
                                    //     Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (context) => BrandOtherProfileScreen()));
                                    //   }
                                    // }
                                  },
                                  child: myFollowersResult[index - 1]
                                              .profileImage !=
                                          null
                                      ? InkWell(
                                          onTap: () async {
                                            SharedPreferences
                                                sharedPreferences =
                                                await SharedPreferences
                                                    .getInstance();
                                            String? ids = sharedPreferences
                                                .getString("id");
                                            if (myFollowersResult[index - 1]
                                                    .sId ==
                                                ids) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProfileFameLink(
                                                            selectPhase: 0,
                                                          )));
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          OtherProfile(
                                                            id: myFollowersResult[
                                                                    index - 1]
                                                                .sId,
                                                            selectPhase: 0,
                                                          )));
                                            }
                                          },
                                          child: CircleAvatar(
                                            radius: ScreenUtil().radius(20),
                                            backgroundImage: NetworkImage(
                                                "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${myFollowersResult[index - 1].profileImage}"),
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: ScreenUtil().radius(20),
                                        ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      SharedPreferences sharedPreferences =
                                          await SharedPreferences.getInstance();
                                      String? ids =
                                          sharedPreferences.getString("id");
                                      if (myFollowersResult[index - 1].sId ==
                                          ids) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfileFameLink(
                                                      selectPhase: 0,
                                                    )));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OtherProfile(
                                                      id: myFollowersResult[
                                                              index - 1]
                                                          .sId,
                                                      selectPhase: 0,
                                                    )));
                                      }
                                      //ApiProvider.profileUserId = myFollowersResult[index-1].sId;

                                      // if (Constants.userId == ApiProvider.profileUserId) {
                                      //   // if(myFollowersResult[index-1].type == "individual") {
                                      //   //   Navigator.push(
                                      //   //       context,
                                      //   //       MaterialPageRoute(
                                      //   //           builder: (context) => ProfileScreen()));
                                      //   // }else if(myFollowersResult[index-1].type == "agency") {
                                      //   //   Navigator.push(
                                      //   //       context,
                                      //   //       MaterialPageRoute(
                                      //   //           builder: (context) => AgencyProfileScreen()));
                                      //   // }else if(myFollowersResult[index-1].type == "brand") {
                                      //   //   Navigator.push(
                                      //   //       context,
                                      //   //       MaterialPageRoute(
                                      //   //           builder: (context) => BrandProfileScreen()));
                                      //   // }
                                      // } else {
                                      //   // if(myFollowersResult[index-1].type == "individual") {
                                      //   //   Navigator.push(
                                      //   //       context,
                                      //   //       MaterialPageRoute(
                                      //   //           builder: (context) => OtherProfileScreen()));
                                      //   // }else if(myFollowersResult[index-1].type == "agency") {
                                      //   //   Navigator.push(
                                      //   //       context,
                                      //   //       MaterialPageRoute(
                                      //   //           builder: (context) => AgencyOtherProfileScreen()));
                                      //   // }else if(myFollowersResult[index-1].type == "brand") {
                                      //   //   Navigator.push(
                                      //   //       context,
                                      //   //       MaterialPageRoute(
                                      //   //           builder: (context) => BrandOtherProfileScreen()));
                                      //   // }
                                      // }
                                    },
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                                    '${myFollowersResult[index - 1].name}',
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(12),
                                                            color: black))),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Visibility(
                                              visible:
                                                  myFollowersResult[index - 1]
                                                          .followStatus ==
                                                      false,
                                              child: InkWell(
                                                onTap: () async {
                                                  Api.post.call(context,
                                                      method:
                                                          "users/follow/${myFollowersResult[index - 1].sId}",
                                                      param: {},
                                                      onResponseSuccess:
                                                          (Map object) {
                                                    myFollowersResult[index - 1]
                                                            .followStatus =
                                                        !myFollowersResult[
                                                                index - 1]
                                                            .followStatus!;
                                                    setState(() {});
                                                  });
                                                },
                                                child: Text(
                                                    '${myFollowersResult[index - 1].followStatus == false ? 'Follow' : 'Unfollow'}',
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(12),
                                                            color: buttonBlue)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                            myFollowersResult[index - 1]
                                                        .district !=
                                                    null
                                                ? '${myFollowersResult[index - 1].district},${myFollowersResult[index - 1].state}, ${myFollowersResult[index - 1].country}'
                                                : "",
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                    ScreenUtil().setSp(10),
                                                color: lightGray)),
                                      ],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(9),
                            ),
                            Divider(
                              thickness: 1,
                              color: lightGray,
                              height: 1,
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(9),
                            ),
                          ],
                        );
                      }
                    }),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: myHashTagsResult.length,
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(25),
                        right: ScreenUtil().setWidth(25)),
                    itemBuilder: (followersContext, index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(8)),
                          child: Text("Hashtags",
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: ScreenUtil().setSp(12),
                                  color: darkGray)),
                        );
                      } else {
                        // SearchChallenges openChallenges = myHashTagsResult[index-1];
                        String name = "";
                        String photos = "";
                        // if(openChallenges.users.length > 1){
                        //   name = "Male/Female";
                        // }else if(openChallenges.users[0].type == "male"){
                        //   name = "Boys";
                        // }else if(openChallenges.users[0].type == "female"){
                        //   name = "Girls";
                        // }

                        // if(openChallenges.mediaPreference.length > 1){
                        //   photos = "(Photo & Videos)";
                        // }else if(openChallenges.mediaPreference[0] == "photo"){
                        //   photos = "(Photo Only)";
                        // }else if(openChallenges.mediaPreference[0] == "video"){
                        //   photos = "(Videos Only)";
                        // }
                        return Column(
                          children: [
                            SizedBox(
                              height: ScreenUtil().setHeight(9),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        // var result = await Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) => ChallengeDetailsScreen(null,openChallenges)));
                                        // if (result != null) {
                                        //   Navigator.pop(context,result);
                                        // }
                                      },
                                      child: Text(
                                          '${name} - ${myHashTagsResult[index].hashTag} ${photos}',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w600,
                                              fontSize: ScreenUtil().setSp(14),
                                              color: black)),
                                    ),
                                    Text(
                                        'Ending in ${myHashTagsResult[index].totalParticipants}%',
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(12),
                                            color: buttonBlue)),
                                  ],
                                ),
                              ],
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: lightGray,
                            )
                          ],
                        );
                      }
                    }),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: myChallengeResult.length > 0
                        ? myChallengeResult.length + 1
                        : 0,
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(25),
                        right: ScreenUtil().setWidth(25)),
                    itemBuilder: (followersContext, index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(8)),
                          child: Text("Challenges",
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: ScreenUtil().setSp(12),
                                  color: darkGray)),
                        );
                      } else {
                        return InkWell(
                          onTap: () async {
                            ChallengesModelData challengesModelData =
                                ChallengesModelData(
                                    id: "",
                                    challengeId:
                                        myChallengeResult[index - 1].sId!,
                                    challengeName:
                                        myChallengeResult[index - 1].hashTag!,
                                    postId: "");
                            if (widget.postType == "famelinks") {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FameLinksChallengeScreen(
                                          challengesModelData:
                                              challengesModelData,
                                        )),
                              );
                              if (result != null) {
                                Navigator.pop(context, result);
                              }
                            } else {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FunLinksChallengeScreen(
                                            challengesModelData, "", "")),
                              );
                              if (result != null) {
                                Navigator.pop(context, result);
                              }
                            }
                          },
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  //     myChallengeResult[index-1]. !=
                                  //         null
                                  //     ? CircleAvatar(
                                  //   radius: ScreenUtil().radius(20),
                                  //   backgroundImage: NetworkImage(
                                  //       "${ApiProvider.imageBaseUrl}/${myChallengeResult[index-1].image}"),
                                  // )
                                  //     : CircleAvatar(
                                  //   radius: ScreenUtil().radius(20),
                                  // ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                            myChallengeResult[index - 1]
                                                        .hashTag !=
                                                    null
                                                ? '${myChallengeResult[index - 1].hashTag}'
                                                : "",
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                    ScreenUtil().setSp(12),
                                                color: lightGray)),
                                        // Text('${myChallengeResult[index-1].sponsor[0].name}',
                                        //     style: GoogleFonts.nunitoSans(
                                        //         fontWeight: FontWeight.w400,fontSize: ScreenUtil().setSp(12),color: black)),
                                      ],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      ChallengesModelData challengesModelData =
                                          ChallengesModelData(
                                              id: "",
                                              challengeId:
                                                  myChallengeResult[index - 1]
                                                      .sId!,
                                              challengeName:
                                                  myChallengeResult[index - 1]
                                                      .hashTag!,
                                              postId: "");
                                      if ((Constants.verificationStatus ==
                                                  "Submitted" ||
                                              Constants.verificationStatus ==
                                                  "Verified") &&
                                          Constants.todayPosts == 0) {
                                        final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UploadScreenOne(
                                                        challengesModelData:
                                                            challengesModelData)));
                                        if (result != null) {
                                          Navigator.pop(context, result);
                                        }
                                      } else if (Constants.todayPosts >= 1) {
                                        showPerDayPostDialog();
                                      } else {
                                        showProfileVerifyDialog();
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                          ScreenUtil().setHeight(5)),
                                      child: Text('Upload',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: lightGray,
                                              fontSize:
                                                  ScreenUtil().setSp(12))),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(9),
                              ),
                              Divider(
                                thickness: 1,
                                color: lightGray,
                                height: 1,
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(9),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        ))
      ],
    );
  }

  void showPerDayPostDialog() async {
    var result = await showDialog(
        context: context,
        builder: (BuildContext context3) {
          return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.only(
                  left: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - 300) / 2),
                  right: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - 300) / 2)),
              child: StatefulBuilder(
                  builder: (BuildContext context2, StateSetter setStates) {
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
                      Container(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(12),
                            bottom: ScreenUtil().setHeight(16),
                            left: ScreenUtil().setHeight(16),
                            right: ScreenUtil().setHeight(16)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setSp(16))),
                          color: appBackgroundColor,
                        ),
                        child: Column(
                          children: [
                            Text.rich(TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text:
                                      'FameLinks is a Contest. As per the rules, you can upload only ',
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      color: black,
                                      fontSize: ScreenUtil().setSp(14))),
                              TextSpan(
                                  text: 'One Post per day',
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: ScreenUtil().setSp(14),
                                      color: black)),
                              TextSpan(
                                  text: ' in FameLinks.',
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      color: black,
                                      fontSize: ScreenUtil().setSp(14))),
                            ])),
                            SizedBox(
                              height: ScreenUtil().setSp(16),
                            ),
                            Text(
                                'Please take your time till tomorrow to prepare well and showcase the best of you.',
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w300,
                                    color: black,
                                    fontStyle: FontStyle.italic,
                                    fontSize: ScreenUtil().setSp(12))),
                            InkWell(
                              onTap: () async {
                                Navigator.pop(context2);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setSp(24),
                                    bottom: ScreenUtil().setSp(12)),
                                width: ScreenUtil().setWidth(96),
                                height: ScreenUtil().setHeight(26),
                                decoration: new BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [lightRedWhite, lightRed]),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Got it',
                                      style: GoogleFonts.nunitoSans(
                                          color: white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: ScreenUtil().setSp(14)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }));
        });
    if (result != null) {
      if (result == true) {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileVideoVerificationScreen()),
        );
        if (result != null) {
          var snackBar = SnackBar(
            content: Text('Compressing'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Constants.verificationStatus = "Submitted";
          final MediaInfo? info = await VideoCompress.compressVideo(
            result,
            quality: VideoQuality.MediumQuality,
            deleteOrigin: false,
            includeAudio: true,
          );
          Constants.video = await MultipartFile.fromFile(info!.path!,
              filename: "${File(result).path.split('/').last}");
          var formData = FormData.fromMap({
            "video": Constants.video,
          });
          Api.uploadPost.call(context,
              method: "users/profile/verify",
              param: formData, onResponseSuccess: (Map object) {
            var snackBar = SnackBar(
              content: Text('Uploaded'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        }
      } else {
        final result = await Navigator.push(context,
            MaterialPageRoute(builder: (context2) => UploadScreenOne()));
        if (result != null) {
          Map map = result;
          FormData formData = FormData.fromMap({
            "challengeId": map['challengeId'],
            "description": map['description'],
            "closeUp": map['closeUp'],
            "medium": map['medium'],
            "long": map['long'],
            "pose1": map['pose1'],
            "pose2": map['pose2'],
            "additional": map['additional'],
            "video": map['video'],
          });
          Api.uploadPost.call(context, method: "media/contest", param: formData,
              onResponseSuccess: (Map object) {
            var snackBar = SnackBar(
              content: Text('Uploaded'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        }
      }
    }
  }

  void showProfileVerifyDialog() async {
    var result = await showDialog(
        context: context,
        builder: (BuildContext context3) {
          return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.only(
                  left: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - 300) / 2),
                  right: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - 300) / 2)),
              child: StatefulBuilder(
                  builder: (BuildContext context2, StateSetter setStates) {
                return Form(
                  key: _profileKey,
                  child: Container(
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
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular(ScreenUtil().setSp(16)),
                                topRight:
                                    Radius.circular(ScreenUtil().setSp(16))),
                          ),
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(16),
                              bottom: ScreenUtil().setHeight(14),
                              left: ScreenUtil().setWidth(16),
                              right: ScreenUtil().setWidth(5)),
                          child: Row(
                            children: [
                              Text(
                                'Please verify your profile',
                                style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(14),
                                    color: black,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(8),
                              ),
                              SvgPicture.asset("assets/icons/svg/done.svg",
                                  height: ScreenUtil().setSp(16),
                                  width: ScreenUtil().setSp(16))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(12),
                              bottom: ScreenUtil().setHeight(16),
                              left: ScreenUtil().setHeight(16),
                              right: ScreenUtil().setHeight(16)),
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
                              ageGroup == "groupA" ||
                                      ageGroup == "groupB" ||
                                      ageGroup == "groupC"
                                  ? Text.rich(TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: 'To be able to',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize:
                                                  ScreenUtil().setSp(14))),
                                      TextSpan(
                                          text: ' Upload Posts',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(14),
                                              color: black)),
                                      TextSpan(
                                          text: ' or ',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize:
                                                  ScreenUtil().setSp(14))),
                                      TextSpan(
                                          text: 'Participate in Contests',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(14),
                                              color: black)),
                                      TextSpan(
                                          text:
                                              ' on FameLinks App, you are required to verify your profile.',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize:
                                                  ScreenUtil().setSp(14))),
                                    ]))
                                  : Text.rich(TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: 'To be able to ',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize:
                                                  ScreenUtil().setSp(14))),
                                      TextSpan(
                                          text: 'Participate in Contests',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(14),
                                              color: black)),
                                      TextSpan(
                                          text:
                                              ' on FameLinks App, you are required to verify your profile.',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize:
                                                  ScreenUtil().setSp(14))),
                                    ])),
                              InkWell(
                                onTap: () async {
                                  Navigator.pop(context2, true);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setSp(18),
                                      bottom: ScreenUtil().setSp(21)),
                                  width: ScreenUtil().setWidth(96),
                                  height: ScreenUtil().setHeight(26),
                                  decoration: new BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [lightRedWhite, lightRed]),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6),
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Verify',
                                        style: GoogleFonts.nunitoSans(
                                            color: white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: ScreenUtil().setSp(14)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ageGroup == "groupA" ||
                                      ageGroup == "groupB" ||
                                      ageGroup == "groupC"
                                  ? Text(
                                      'You can still see Posts and browse the App if you skip this important step',
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w300,
                                          color: black,
                                          fontStyle: FontStyle.italic,
                                          fontSize: ScreenUtil().setSp(12)))
                                  : Text.rich(TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Your posts can still be seen in ',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w300,
                                              color: black,
                                              fontStyle: FontStyle.italic,
                                              fontSize:
                                                  ScreenUtil().setSp(12))),
                                      TextSpan(
                                          text: 'FollowLinks & FunLinks, ',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(12),
                                              color: black)),
                                      TextSpan(
                                          text:
                                              'if you skip this important step',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w300,
                                              color: black,
                                              fontStyle: FontStyle.italic,
                                              fontSize:
                                                  ScreenUtil().setSp(12))),
                                    ])),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () async {
                                      print("AGEE:::${ageGroup}");
                                      if (ageGroup == "groupA" ||
                                          ageGroup == "groupB" ||
                                          ageGroup == "groupC") {
                                        Navigator.pop(context2);
                                      } else {
                                        Navigator.pop(context2, false);
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenUtil().setSp(10),
                                          top: ScreenUtil().setSp(6),
                                          bottom: ScreenUtil().setSp(6)),
                                      child: Text('Skip for Now',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: buttonBlue,
                                              fontSize:
                                                  ScreenUtil().setSp(10))),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }));
        });
    if (result != null) {
      if (result == true) {
        final result3 = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileVideoVerificationScreen()),
        );
        if (result3 != null) {
          var snackBar = SnackBar(
            content: Text('Compressing'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Constants.verificationStatus = "Submitted";
          final MediaInfo? info = await VideoCompress.compressVideo(
            result3,
            quality: VideoQuality.MediumQuality,
            deleteOrigin: false,
            includeAudio: true,
          );
          Constants.video = await MultipartFile.fromFile(info!.path!,
              filename: "${File(result3).path.split('/').last}");
          var formData = FormData.fromMap({
            "video": Constants.video,
          });
          Api.uploadPost.call(context,
              method: "users/profile/verify",
              param: formData, onResponseSuccess: (Map object) {
            var snackBar = SnackBar(
              content: Text('Uploaded'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        }
      } else {
        final result = await Navigator.push(context,
            MaterialPageRoute(builder: (context2) => UploadScreenOne()));
        if (result != null) {
          Map map = result;
          FormData formData = FormData.fromMap({
            "challengeId": map['challengeId'],
            "description": map['description'],
            "closeUp": map['closeUp'],
            "medium": map['medium'],
            "long": map['long'],
            "pose1": map['pose1'],
            "pose2": map['pose2'],
            "additional": map['additional'],
          });
          if (map['video'] != null) {
            var snackBar = SnackBar(
              content: Text('Compressing'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            final MediaInfo? info = await VideoCompress.compressVideo(
              map['video'],
              quality: VideoQuality.HighestQuality,
              deleteOrigin: false,
              includeAudio: true,
            );
            await MultipartFile.fromFile(info!.path!,
                    filename: "${File(map['video']).path.split('/').last}")
                .then((value) async {
              formData.files.addAll([
                MapEntry("video", value),
              ]);
              Api.uploadPost.call(context,
                  method: "media/contest",
                  param: formData, onResponseSuccess: (Map object) {
                Constants.todayPosts = 1;
                var snackBar = SnackBar(
                  content: Text('Uploaded'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            });
          } else {
            Api.uploadPost.call(context,
                method: "media/contest",
                param: formData, onResponseSuccess: (Map object) {
              Constants.todayPosts = 1;
              var snackBar = SnackBar(
                content: Text('Uploaded'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });
          }
        }
      }
    }
  }

  String convertToAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);
    return '${diff.inDays}d';
  }
}
