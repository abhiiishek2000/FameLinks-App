import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:famelink/databse/AppDatabase.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/MyFunLinksResponse.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/providers/ChallengeProvider/famelinkChallengeProvider.dart';
import 'package:famelink/ui/challenge/ChallengeFunLinksPostScreen.dart';
import 'package:famelink/ui/upload/funlink_upload_one.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FunLinksChallengeScreen extends StatefulWidget {
  ChallengesModelData challengesModelData;
  String musicName;
  String giftCoins;

  FunLinksChallengeScreen(
      this.challengesModelData, this.musicName, this.giftCoins);

  @override
  _FunLinksChallengeScreenState createState() =>
      _FunLinksChallengeScreenState();
}

class _FunLinksChallengeScreenState extends State<FunLinksChallengeScreen>
    with TickerProviderStateMixin {
  final ApiProvider _api = ApiProvider();
  int page = 1;
  ScrollController followingScrollController = ScrollController();
  List<int> firstDigits = [2, 2, 1, 1, 1, 3, 1, 1, 1, 1, 3, 1, 1, 1];
  List<double> lastDigits = [2, 2, 1, 1, 1, 2, 1, 1, 1, 3, 2, 1, 1, 1];
  bool _isPlaying = true;
  int current = 0;
  bool isMute = true;

  //VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    followingScrollController.addListener(() {
      if (followingScrollController.position.maxScrollExtent ==
          followingScrollController.position.pixels) {
        page++;
        _getChallengeData();
      }
    });
    // _controller = VideoPlayerController.network(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
    //   ..initialize().then((_) {
    //     setState(() {
    //
    //       print("clicked");
    //     });
    //   });
    _getChallengeData();
  }

  _getChallengeData() async {
    Map<String, dynamic> param = {"page": "1"};
    Api.get.call(context,
        method: "challenges/${widget.challengesModelData.challengeId}/funlinks",
        param: param, onResponseSuccess: (Map<dynamic, dynamic> object) {
      print('RESPONSEchallenges ${param}');

      var result = MyFunLinksResponse.fromJson(object);
      if (result.result!.length > 0) {
        log("getChallengeData ${object}  ");
        Provider.of<ChallengeScreenProvider>(context, listen: false)
            .changeChallengeList(result.result!);
      } else {
        page--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: appBackgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Consumer<ChallengeScreenProvider>(
          builder: (context, challengeFunLinkScreen, child) {
        return StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            controller: followingScrollController,
            itemCount: challengeFunLinkScreen.getChallengeList.length + 1,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            itemBuilder: (BuildContext context, int index) {
              if ((challengeFunLinkScreen.getChallengeList.isNotEmpty &&
                  index == 1)) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.challengesModelData.challengeName}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(18),
                              color: black)),
                      Row(
                        children: [
                          Text(
                              "by " +
                                  challengeFunLinkScreen
                                      .getChallengeList[0].user!.name
                                      .toString(),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: ScreenUtil().setSp(12),
                                  color: Colors.orange)),
                          Spacer(),
                          Text(
                              challengeFunLinkScreen.getChallengeList
                                      .elementAt(0)
                                      .challenges![0]
                                      .totalPost
                                      .toString() +
                                  " Posts",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: ScreenUtil().setSp(12),
                                  color: black)),
                          Spacer(),
                        ],
                      ),
                      widget.giftCoins == null ||
                              widget.giftCoins == "" ||
                              widget.giftCoins == "null"
                          ? Container()
                          : Text(widget.giftCoins,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: ScreenUtil().setSp(12),
                                  color: black)),
                      SizedBox(
                        height: ScreenUtil().setSp(10),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset("assets/icons/svg/ic_music.svg"),
                          SizedBox(
                            width: ScreenUtil().setWidth(3.24),
                          ),
                          Expanded(
                              child: Text("${widget.musicName}",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(10),
                                      color: buttonBlue)))
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () async {
                                final value = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FunLinkUploadScreenOne(
                                              challengesModelData:
                                                  widget.challengesModelData,
                                            )));
                                if (value != null) {
                                  Map? map = value;
                                  var result = await _api.uploadFunLink(
                                    map!['description'],
                                    map['challengeId'],
                                    map['song'],
                                    map['musicName'],
                                    map['video'],
                                    map['audio'],
                                    map['thumbnail'],
                                    map['context'],
                                    map['profile'],
                                    map['tags'],
                                    map['talentCategory'],
                                  );

                                  if (result == 1) {
                                    var snackBar = SnackBar(
                                      content: Text('Uploaded'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                }
                              },
                              child: SvgPicture.asset(
                                  "assets/icons/svg/add_post.svg")),
                          SizedBox(
                            width: ScreenUtil().setWidth(67),
                          ),
                          SvgPicture.asset("assets/icons/svg/song_add.svg"),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (index == 0) {
                return GestureDetector(
                  onTap: () {
                    // print(videoController.onIsPlaying);
                    print("click");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ontext) => ChallengeFunLinksPostScreen(
                              challengeFunLinkScreen.getChallengeList,
                              0,
                              page,
                              "challenges/${widget.challengesModelData.challengeId}/funlinks")),
                    );
                  },
                  onLongPressUp: () {
                    challengeFunLinkScreen.changeIsOnPageTurning(false);
                  },
                  onLongPress: () {
                    challengeFunLinkScreen.changeIsOnPageTurning(true);
                  },
                  child: CachedNetworkImage(
                      imageUrl:
                          "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${challengeFunLinkScreen.getChallengeList[0].images![0].thumbnail}",
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      fit: BoxFit.cover),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    // print(videoController.onIsPlaying);
                    print("click");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ontext) => ChallengeFunLinksPostScreen(
                              challengeFunLinkScreen.getChallengeList,
                              index - 1,
                              page,
                              "challenges/${widget.challengesModelData.challengeId}/funlinks")),
                    );
                  },
                  onLongPressUp: () {
                    challengeFunLinkScreen.changeIsOnPageTurning(false);
                  },
                  onLongPress: () {
                    challengeFunLinkScreen.changeIsOnPageTurning(true);
                  },
                  child: CachedNetworkImage(
                      imageUrl:
                          "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${challengeFunLinkScreen.getChallengeList[index - 1].images![0].thumbnail}",
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      fit: BoxFit.cover),
                  // child: VideoPlayerScreen(
                  //     "${challengeList[index].images[0].path}",
                  //     ApiProvider.funPostImageBaseUrl,
                  //     index,
                  //     current,
                  //     this,
                  //     index,
                  //     current,
                  //     isMute,
                  //     this.videoController,
                  //     isOnPageTurning),

                  // child: VideoPlayerScreen(
                  //     "${challengeList[index].images[0].path}",
                  //     ApiProvider
                  //         .funPostImageBaseUrl,
                  //     0,
                  //     0,
                  //     this,
                  //     0,
                  //     0,
                  //     false,
                  //     this.videoController,
                  //     false),
                );
              }
            },
            staggeredTileBuilder: (int index) {
              return StaggeredTile.count(
                  firstDigits[index % 14], lastDigits[index % 14]);
            });
      }),
    );
  }

  @override
  void onPlayingChange(bool isPlaying) {
    // TODO: implement onPlayingChange
    setState(() {
      _isPlaying = isPlaying;
    });
  }

  @override
  void onProfileClick() {
    // TODO: implement onProfileClick
  }
}
