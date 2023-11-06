import 'dart:io';

import 'package:dio/dio.dart';
import 'package:famelink/databse/AppDatabase.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/ChallengesModel.dart';
import 'package:famelink/models/FunLinksSongPostModel.dart';
import 'package:famelink/models/MyFunLinksResponse.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/challenge/ChallengeFunLinksPostScreen.dart';
import 'package:famelink/ui/upload/funlink_upload_one.dart';
import 'package:famelink/util/ReadMoreText.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:video_compress/video_compress.dart';

class FunLinksSongPostScreen extends StatefulWidget {
  String musicId;
  String musicName;
  String audio;

  FunLinksSongPostScreen(this.musicId, this.musicName, this.audio);

  @override
  _FunLinksSongPostScreenState createState() =>
      _FunLinksSongPostScreenState();
}

class _FunLinksSongPostScreenState extends State<FunLinksSongPostScreen> {
  final ApiProvider _api = ApiProvider();
  List<MyFunLinksResult> challengeList = [];
  int page = 1;
  ScrollController followingScrollController = ScrollController();
  List<int> firstDigits = [2,2,1,1,1,3,1,1,1,1,3,1,1,1];
  List<double> lastDigits = [2,2,1,1,1,2,1,1,1,3,2,1,1,1];

  bool isSaved = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("AUDIO:::${widget.audio}");
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
        method: "media/funlinks/songs/${widget.musicId}/posts",
        param: param,
        onResponseSuccess: (Map<dynamic,dynamic> object) {
          var result = FunLinksSongPostModel.fromJson(object);
          isSaved = result.result!.isSaved!;
          if (result.result!.data!.length > 0) {
            setState(() {
              challengeList.addAll(result.result!.data!);
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
          itemCount: challengeList.length + 1,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          itemBuilder: (BuildContext context, int index) {
            if ((challengeList.length > 0 && index == 1) ||
                challengeList.length == 0 && index == 0) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("#${widget.musicName}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(18),
                            color: black)),
                    /*Text("2.01 B",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(12),
                            color: black)),*/
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
                            child: Text(
                                "${widget.musicName}",
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
                            final result = await Navigator
                                .push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FunLinkUploadScreenOne(musicId: widget.musicId,musicName: widget.musicName,audio: widget.audio)));
                            if (result != null) {
                              var snackBar = SnackBar(
                                content: Text('Compressing'),
                              );
                              ScaffoldMessenger.of(
                                  context).showSnackBar(
                                  snackBar);
                              Map map = result;
                              FormData formData;
                              if (map['musicId']
                                  .toString()
                                  .isEmpty) {
                                formData = FormData.fromMap({
                                  "challenges": map['challenges'],
                                  "description": map['description'],
                                  "musicName": map['musicName'],
                                });
                              } else {
                                formData = FormData.fromMap({
                                  "challenges": map['challenges'],
                                  "description": map['description'],
                                  "musicName": map['musicName'],
                                  "musicId": map['musicId'],
                                });
                              }
                              if (map.containsKey("audio")) {
                                formData.files.addAll([
                                  MapEntry("audio", map['audio']),
                                ]);
                              }
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
                                    method: "media/funlinks",
                                    param: formData,
                                    onResponseSuccess: (
                                        Map object) {
                                      var snackBar = SnackBar(
                                        content: Text('Uploaded'),
                                      );
                                      ScaffoldMessenger.of(
                                          context).showSnackBar(
                                          snackBar);
                                    });
                              });
                            }
                          },
                            child: SvgPicture.asset(
                                "assets/icons/svg/add_post.svg")),
                        SizedBox(
                          width: ScreenUtil().setWidth(67),
                        ),
                        InkWell(onTap:(){
                          Api.put.call(context, method: "users/songs/${widget.musicId}/${isSaved?"unsave":"save"}", param: {},
                              onResponseSuccess: (Map object) {
                                setState(() {
                                  isSaved = !isSaved;
                                });
                              });
                        },child: SvgPicture.asset("assets/icons/svg/${isSaved ? "saved_song.svg":"song_add.svg"}")),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ontext) =>
                            ChallengeFunLinksPostScreen(challengeList, index == 0 ?index:index-1, page,"media/funlinks/songs/${widget.musicId}/posts")),
                  );
                },
                child: Container(
                    child: Stack(
                  children: [
                    Image.network(
                      '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${challengeList.elementAt(index == 0 ?index:index-1).images!.length > 0 ?challengeList.elementAt(index == 0 ?index:index-1).images!.elementAt(0).path:""}-sm',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                    Center(
                      child: Icon(
                        Icons.play_arrow_outlined,
                        color: Colors.white,
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
}
