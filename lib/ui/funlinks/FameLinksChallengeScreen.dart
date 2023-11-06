import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/famelinks_model.dart';
import 'package:famelink/databse/AppDatabase.dart';
import 'package:famelink/models/ChallengesModel.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/challenge/ChallengeFameLinkFullPostScreen.dart';
import 'package:famelink/ui/settings/profile_verification_screen.dart';
import 'package:famelink/ui/upload/upload_screen_one.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:video_compress/video_compress.dart';

class FameLinksChallengeScreen extends StatefulWidget {
  ChallengesModelData? challengesModelData;

  FameLinksChallengeScreen({this.challengesModelData});

  @override
  _FameLinksChallengeScreenState createState() =>
      _FameLinksChallengeScreenState();
}

class _FameLinksChallengeScreenState extends State<FameLinksChallengeScreen> {

  final ApiProvider _api = ApiProvider();
  List<Result> challengeList = [];
  int page = 1;
  ScrollController followingScrollController = ScrollController();
  List<int> firstDigits = [2,2,1,1,1,3,1,1,1,1,3,1,1,1];
  List<double> lastDigits = [2,2,1,1,1,2,1,1,1,3,2,1,1,1];
  final GlobalKey<FormState> _profileKey = GlobalKey<FormState>();
  String ageGroup = 'groupE';
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      Constants.playing = false;
    });
    followingScrollController.addListener(() {
      if (followingScrollController.position.maxScrollExtent ==
          followingScrollController.position.pixels) {
        page++;
        _getChallengeData();
      }
    });
    _getChallengeData();
  }

  _getChallengeData() async {
    Map<String, dynamic> param = {
      "page" : page.toString()
    };
    Api.get.call(context,
        method: "challenges/${widget.challengesModelData!.challengeId}/famelinks",
        param: param,
        onResponseSuccess: (Map<dynamic,dynamic> object) {
          var result = FamelinksResponse.fromJson(object);
          if (result.result!.length > 0) {
            setState(() {
              challengeList.addAll(result.result!);
            });
            print('RESPONSE ${result.result.toString()}');
          } else {
            page--;
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: appBackgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          controller: followingScrollController,
          itemCount: challengeList.length+1,
          mainAxisSpacing: ScreenUtil().setSp(1),
          crossAxisSpacing: ScreenUtil().setSp(1),
          itemBuilder: (BuildContext context, int index) {
            if((challengeList.length > 0 && index == 1) || challengeList.length == 0 && index == 0){
              return Container(
                padding: EdgeInsets.only(left: ScreenUtil().setSp(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${widget.challengesModelData!.challengeName}", overflow: TextOverflow.ellipsis,
                        maxLines: 2,style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: ScreenUtil().setSp(18),color: black)),
                    // Text("2.01 B",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: ScreenUtil().setSp(12),color: black)),
                   /* Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset("assets/icons/svg/ic_music.svg"),
                        SizedBox(
                          width: ScreenUtil().setWidth(3.24),
                        ),
                        Expanded(child: Text("dil ki muraad puri kar lu ... by Tiesto Someone",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: ScreenUtil().setSp(10),color: buttonBlue)))
                      ],
                    ),*/
                    challengeList.length > 0 ?Container(
                      width: (ScreenUtil().screenWidth/2)-ScreenUtil().setSp(15),
                      height: ScreenUtil().setSp(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: lightGray,width: ScreenUtil().setSp(1)),
                        borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(4))),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: ScreenUtil().setSp(16),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(3))),
                              child: LinearProgressIndicator(
                                value: challengeList.elementAt(0).challenges!.elementAt(0).percentCompleted != null ? (challengeList.elementAt(0).challenges!.elementAt(0).percentCompleted / 100):0,
                                valueColor: AlwaysStoppedAnimation(challengeList.elementAt(0).challenges!.elementAt(0).percentCompleted != null ? challengeList.elementAt(0).challenges!.elementAt(0).percentCompleted >= 80 ?lightRed:Colors.green:Colors.green),
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                          Align(
                            child: Text("${challengeList.elementAt(0).challenges!.elementAt(0).percentCompleted != null ? challengeList.elementAt(0).challenges!.elementAt(0).percentCompleted:0}%",style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(8),
                                color: challengeList.elementAt(0).challenges!.elementAt(0).percentCompleted != null ? challengeList.elementAt(0).challenges!.elementAt(0).percentCompleted > 50 ?white:black:black
                            )),
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                    ):Container(),
                    challengeList.length > 0 ? Text(NumberFormat
                        .compactCurrency(
                      decimalDigits: 0,
                      symbol:
                      '', // if you want to add currency symbol then pass that in this else leave it empty.
                    ).format(
                        challengeList.elementAt(0).challenges!.elementAt(0).participantsCount),style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(12),
                        color: darkGray
                    )):Container(),
                    SizedBox(
                      height: ScreenUtil().setHeight(37.13),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(child: SvgPicture.asset("assets/icons/svg/add_post.svg"),onTap: () async{
                          if ((Constants.verificationStatus == "Submitted" || Constants.verificationStatus == "Verified") &&
                              Constants.todayPosts == 0) {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UploadScreenOne(challengesModelData: widget.challengesModelData!)));
                            if (result != null) {
                              Navigator.pop(context,result);
                            }
                          } else if (Constants.todayPosts >= 1) {
                            showPerDayPostDialog();
                          } else {
                            showProfileVerifyDialog();
                          }

                        },),
                      ],
                    ),
                  ],
                ),
              );
            }else {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ontext) =>
                            ChallengeFameLinkFullPostScreen(challengeList, index == 0 ?index:index-1, page,widget.challengesModelData!.challengeId,"famelinks")),
                  );
                },
                child: Container(
                    child: Stack(
                      children: [
                        Image.network(
                          '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${challengeList.elementAt(index == 0 ?index:index-1).images!.length > 0 ?challengeList.elementAt(index == 0 ?index:index-1).images!.elementAt(0).path:""}',
                          fit: BoxFit.cover,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height,
                        ),
                        Visibility(
                          visible: "${challengeList.elementAt(index == 0 ?index:index-1).images!.length > 0 ?challengeList.elementAt(index == 0 ?index:index-1).images!.elementAt(0).type:""}" == "video",
                          child: Center(
                            child: Icon(
                              Icons.play_arrow_outlined,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )),
              );
            }
          },
          staggeredTileBuilder: (int index) {
            return StaggeredTile.count(firstDigits[index % 14], lastDigits[index % 14]);
          }),
    );
  }
  List<Widget> buildGrid(List<Challenge> documents) {
    List<Widget> _gridItems = [];

    for (Challenge product in documents) {
      _gridItems.add(buildGridItem(product));
    }

    return _gridItems;
  }

  Widget buildGridItem(Challenge product) {
    return Container(
        child: Stack(
          children: [
            Image.network(
              '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${product.media!.elementAt(0).path}-sm',
              fit: BoxFit.cover,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
            ),

          ],
        ));
  }

  List<StaggeredTile> generateRandomTiles(int count) {
    Random rnd = new Random();
    List<StaggeredTile> _staggeredTiles = [];
    for (int i=0; i<count; i++) {
      double? mainAxisCellCount = 0;
      double? temp = rnd.nextDouble();

      if (temp > 0.6) {
        mainAxisCellCount = temp + 0.5;
      } else if (temp < 0.3) {
        mainAxisCellCount = temp + 0.9;
      } else {
        mainAxisCellCount = temp + 0.7;
      }
      _staggeredTiles.add(new StaggeredTile.count(rnd.nextInt(1) + 1, mainAxisCellCount));
    }
    return _staggeredTiles;
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
                                      text: 'FameLinks is a Contest. As per the rules, you can upload only ',
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
                                      text:
                                      ' in FameLinks.',
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
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Text(
                                          'Got it',
                                          style: GoogleFonts.nunitoSans(
                                              color: white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(
                                                  14)),
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
                                      ageGroup == "groupC" ? Text.rich(
                                      TextSpan(children: <TextSpan>[
                                        TextSpan(
                                            text: 'To be able to',
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                color: black,
                                                fontSize: ScreenUtil().setSp(
                                                    14))),
                                        TextSpan(
                                            text: ' Upload Posts',
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w700,
                                                fontSize: ScreenUtil().setSp(
                                                    14),
                                                color: black)),
                                        TextSpan(
                                            text: ' or ',
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                color: black,
                                                fontSize: ScreenUtil().setSp(
                                                    14))),
                                        TextSpan(
                                            text: 'Participate in Contests',
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w700,
                                                fontSize: ScreenUtil().setSp(
                                                    14),
                                                color: black)),
                                        TextSpan(
                                            text:
                                            ' on FameLinks App, you are required to verify your profile.',
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                color: black,
                                                fontSize: ScreenUtil().setSp(
                                                    14))),
                                      ])) : Text.rich(
                                      TextSpan(children: <TextSpan>[
                                        TextSpan(
                                            text: 'To be able to ',
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                color: black,
                                                fontSize: ScreenUtil().setSp(
                                                    14))),
                                        TextSpan(
                                            text: 'Participate in Contests',
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w700,
                                                fontSize: ScreenUtil().setSp(
                                                    14),
                                                color: black)),
                                        TextSpan(
                                            text:
                                            ' on FameLinks App, you are required to verify your profile.',
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                color: black,
                                                fontSize: ScreenUtil().setSp(
                                                    14))),
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
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Text(
                                            'Verify',
                                            style: GoogleFonts.nunitoSans(
                                                color: white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: ScreenUtil().setSp(
                                                    14)),
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
                                        text: 'Your posts can still be seen in ',
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w300,
                                            color: black,
                                            fontStyle: FontStyle.italic,
                                            fontSize: ScreenUtil().setSp(12))),
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
                                            fontSize: ScreenUtil().setSp(12))),
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
                                                  fontSize: ScreenUtil().setSp(
                                                      10))),
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
              builder: (context) =>
                  ProfileVideoVerificationScreen()),
        );
        if (result3 != null) {
          var snackBar = SnackBar(
            content: Text('Compressing'),
          );
          ScaffoldMessenger.of(
              context).showSnackBar(
              snackBar);
          Constants.verificationStatus = "Submitted";
          final MediaInfo? info =
          await VideoCompress.compressVideo(
            result3,
            quality: VideoQuality.MediumQuality,
            deleteOrigin: false,
            includeAudio: true,
          );
          Constants.video = await MultipartFile.fromFile(
              info!.path!,
              filename:
              "${File(result3).path.split('/').last}");
          var formData = FormData.fromMap({
            "video": Constants.video,
          });
          Api.uploadPost.call(context,
              method: "users/profile/verify",
              param: formData,
              onResponseSuccess: (Map object) {
                var snackBar = SnackBar(
                  content: Text('Uploaded'),
                );
                ScaffoldMessenger.of(
                    context).showSnackBar(
                    snackBar);
              });
        }
      } else {
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context2) =>
                    UploadScreenOne()));
        if (result != null) {
          Map map = result;
          FormData formData = FormData
              .fromMap({
            "challengeId": map['challengeId'],
            "description": map['description'],
            "closeUp": map['closeUp'],
            "medium": map['medium'],
            "long": map['long'],
            "pose1": map['pose1'],
            "pose2": map['pose2'],
            "additional": map['additional'],
          });
          if(map['video'] != null){
            var snackBar = SnackBar(
              content: Text('Compressing'),
            );
            ScaffoldMessenger.of(
                context).showSnackBar(
                snackBar);
            final MediaInfo? info = await VideoCompress
                .compressVideo(
              map['video'],
              quality: VideoQuality.HighestQuality,
              deleteOrigin: false,
              includeAudio: true,
            );
            await MultipartFile.fromFile(info!.path!,
                filename: "${File(map['video']).path
                    .split('/')
                    .last}").then((value) async {
              formData.files.addAll([
                MapEntry("video", value),
              ]);
              Api.uploadPost.call(context,
                  method: "media/contest",
                  param: formData,
                  onResponseSuccess: (
                      Map object) {
                    Constants.todayPosts = 1;
                    var snackBar = SnackBar(
                      content: Text('Uploaded'),
                    );
                    ScaffoldMessenger.of(
                        context).showSnackBar(
                        snackBar);
                  });
            });
          }else{
            Api.uploadPost.call(context,
                method: "media/contest",
                param: formData,
                onResponseSuccess: (
                    Map object) {
                  Constants.todayPosts = 1;
                  var snackBar = SnackBar(
                    content: Text('Uploaded'),
                  );
                  ScaffoldMessenger.of(
                      context).showSnackBar(
                      snackBar);
                });
          }
        }
      }
    }
  }
}
