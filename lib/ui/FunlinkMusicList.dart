import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/funlinks_songs_model.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

class FunlinkMusicList extends StatefulWidget {
  @override
  _FunlinkMusicListState createState() => _FunlinkMusicListState();
}

class _FunlinkMusicListState extends State<FunlinkMusicList>
    with TickerProviderStateMixin {
  final ApiProvider _api = ApiProvider();
  TextEditingController nameController = TextEditingController();
  ScrollController scrollController = ScrollController();
  ScrollController fameScrollController = ScrollController();
  ScrollController fameVoiceScrollController = ScrollController();
  ScrollController savedScrollController = ScrollController();
  List<ResultSongs> myTrendingSongs = [];
  List<ResultSongs> fameSongs = [];
  List<ResultSongs> fameVoiceSongs = [];
  List<ResultSongs> savedSongs = [];
  int trendingPage = 1;
  int famePage = 1;
  int fameVoicePage = 1;
  int savedPage = 1;
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlay = false;
  TabController? tabController;
  int trendingPlayIndex = -1;
  int famePlayIndex = -1;
  int fameVoicePlayIndex = -1;
  int savedPlayIndex = -1;

  void getTrendingSongs(String search) async {
    Map<String, dynamic> param = {
      "page": trendingPage.toString(),
      "type": "trending",
    };
    if (search.isNotEmpty) {
      param.putIfAbsent("search", () => search);
    }
    Api.get.call(context, method: "media/funlinks/songs", param: param,
        onResponseSuccess: (Map<dynamic, dynamic> object) {
      var result = FunLinksSongs.fromJson(object);
      if (result.result!.length > 0) {
        //myTrendingSongs.addAll(result.result!);
        setState(() {
          myTrendingSongs.addAll(result.result!);
        });
        print('RESPONSE ${result.result.toString()}');
      } else {
        trendingPage == 1 ? trendingPage : trendingPage--;
      }
    });
  }

  void getFameSongs(String search) async {
    Map<String, dynamic> param = {
      "page": famePage.toString(),
      "type": "songs",
    };
    if (search.isNotEmpty) {
      param.putIfAbsent("search", () => search);
    }
    Api.get.call(context,
        method: "media/funlinks/songs",
        param: param,
        isLoading: false, onResponseSuccess: (Map object) {
      var result = FunLinksSongs.fromJson(object);
      if (result.result!.length > 0) {
        fameSongs.addAll(result.result!);
        setState(() {});
        print('RESPONSE ${result.result.toString()}');
      } else {
        famePage == 1 ? famePage : famePage--;
      }
    });
  }

  void getFameVoice(String search) async {
    Map<String, dynamic> param = {
      "page": fameVoicePage.toString(),
      "type": "voice",
    };
    if (search.isNotEmpty) {
      param.putIfAbsent("search", () => search);
    }
    Api.get.call(context,
        method: "media/funlinks/songs",
        param: param,
        isLoading: false, onResponseSuccess: (Map object) {
      var result = FunLinksSongs.fromJson(object);
      if (result.result!.length > 0) {
        fameVoiceSongs.addAll(result.result!);
        setState(() {});
        print('RESPONSE ${result.result.toString()}');
      } else {
        fameVoicePage == 1 ? fameVoicePage : fameVoicePage--;
      }
    });
  }

  void getSavedSongs(String search) async {
    savedSongs.clear();
    Map<String, dynamic> param = {
      "page": savedPage.toString(),
      "type": "saved",
    };
    if (search.isNotEmpty) {
      param.putIfAbsent("search", () => search);
    }
    Api.get.call(context,
        method: "media/funlinks/songs",
        param: param,
        isLoading: false, onResponseSuccess: (Map object) {
      var result = FunLinksSongs.fromJson(object);
      if (result.result!.length > 0) {
        // savedSongs.addAll(result.result!);
        // setState(() {});
        setState(() {
          savedSongs.addAll(result.result!);
          print('SavedSongsLength ' + savedSongs.length.toString());
        });
        print('RESPONSE ${result.result.toString()}');
      } else {
        savedPage == 1 ? savedPage : savedPage--;
      }
    });
  }

  void getSavedMoreSongs(String search) async {
    Map<String, dynamic> param = {
      "page": savedPage.toString(),
      "type": "saved",
    };
    if (search.isNotEmpty) {
      param.putIfAbsent("search", () => search);
    }
    Api.get.call(context,
        method: "media/funlinks/songs",
        param: param,
        isLoading: false, onResponseSuccess: (Map object) {
      var result = FunLinksSongs.fromJson(object);
      if (result.result!.length > 0) {
        savedSongs.addAll(result.result!);
        setState(() {});
        print('RESPONSE ${result.result.toString()}');
      } else {
        savedPage == 1 ? savedPage : savedPage--;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController!.dispose();
    if (audioPlayer != null) {
      audioPlayer.release();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        isPlay = !isPlay;
      });
    });
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        trendingPage++;
        getTrendingSongs(nameController.text);
      }
    });
    fameScrollController.addListener(() {
      if (fameScrollController.position.maxScrollExtent ==
          fameScrollController.position.pixels) {
        famePage++;
        getFameSongs(nameController.text);
      }
    });
    fameVoiceScrollController.addListener(() {
      if (fameVoiceScrollController.position.maxScrollExtent ==
          fameVoiceScrollController.position.pixels) {
        fameVoicePage++;
        getFameVoice(nameController.text);
      }
    });
    savedScrollController.addListener(() {
      if (savedScrollController.position.maxScrollExtent ==
          savedScrollController.position.pixels) {
        savedPage++;
        getSavedMoreSongs(nameController.text);
      }
    });
    getTrendingSongs(nameController.text);
    getFameSongs(nameController.text);
    getFameVoice(nameController.text);
    getSavedSongs(nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: appBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(
              text: "Popular",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  color: black,
                  fontSize: ScreenUtil().setSp(18))),
          TextSpan(
              text: ' Sounds',
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(18),
                  color: lightRed)),
        ])),
      ),
      body: body(),
    );
  }

  Widget body() {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(16),
              left: ScreenUtil().setWidth(34),
              right: ScreenUtil().setWidth(21),
              bottom: ScreenUtil().setWidth(25),
            ),
            child: TextFormField(
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              controller: nameController,
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                if (tabController!.index == 0 && value.length >= 2 ||
                    value.isEmpty) {
                  myTrendingSongs.clear();
                  trendingPage = 1;
                  getTrendingSongs(value);
                } else if (tabController!.index == 1 && value.length >= 2 ||
                    value.isEmpty) {
                  fameSongs.clear();
                  famePage = 1;
                  getFameSongs(value);
                } else if (tabController!.index == 2 && value.length >= 2 ||
                    value.isEmpty) {
                  fameVoiceSongs.clear();
                  fameVoicePage = 1;
                  getFameVoice(value);
                } else if (tabController!.index == 3 && value.length >= 2 ||
                    value.isEmpty) {
                  savedSongs.clear();
                  savedPage = 1;
                  getSavedSongs(value);
                }
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.25),
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
                      fontSize: ScreenUtil().setSp(12),
                      color: lightGray,
                      fontWeight: FontWeight.w400),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: lightGray),
                    onPressed: () {
                      if (tabController!.index == 0) {
                        myTrendingSongs.clear();
                        trendingPage = 1;
                        getTrendingSongs(nameController.text);
                      } else if (tabController!.index == 1) {
                        fameSongs.clear();
                        famePage = 1;
                        getFameSongs(nameController.text);
                      } else if (tabController!.index == 2) {
                        fameVoiceSongs.clear();
                        fameVoicePage = 1;
                        getFameVoice(nameController.text);
                      } else if (tabController!.index == 3) {
                        savedSongs.clear();
                        savedPage = 1;
                        getSavedSongs(nameController.text);
                      }
                    },
                  )),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(8),
                right: ScreenUtil().setWidth(8)),
            height: ScreenUtil().setHeight(28),
            child: TabBar(
              controller: tabController,
              tabs: [
                Tab(
                  text: "Trending",
                ),
                Tab(text: "Fame Songs"),
                Tab(text: "Fame Voice"),
                Tab(text: "Saved"),
              ],
              isScrollable: true,
              labelColor: darkGray,
              unselectedLabelColor: lightGray,
              indicatorColor: darkGray,
              unselectedLabelStyle: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(12)),
              labelStyle: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(12)),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(14)),
            child: TabBarView(children: [
              ListView.builder(
                  shrinkWrap: true,
                  controller: scrollController,
                  itemCount: myTrendingSongs.length,
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(16),
                      right: ScreenUtil().setWidth(24)),
                  itemBuilder: (followersContext, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            downloadFile(myTrendingSongs[index].song,
                                myTrendingSongs[index]);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: ScreenUtil().setSp(20),
                                    backgroundImage: NetworkImage(
                                        "${ApiProvider.s3UrlPath}/${ApiProvider.funlinksMusic}/${myTrendingSongs[index].thumbnail}"),
                                  ),
                                  Align(
                                    child: SizedBox(
                                      height: ScreenUtil().setSp(40),
                                      width: ScreenUtil().setSp(40),
                                      child: IconButton(
                                          onPressed: () async {
                                            if (trendingPlayIndex != index) {
                                              isPlay = false;
                                            }
                                            trendingPlayIndex = index;
                                            if (!isPlay) {
                                              setState(() {
                                                isPlay = !isPlay;
                                              });
                                              await audioPlayer.stop();
                                              int result = await audioPlayer.play(
                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.funlinksMusic}/${myTrendingSongs[index].song}");
                                            } else {
                                              setState(() {
                                                isPlay = !isPlay;
                                              });
                                              await audioPlayer.stop();
                                            }
                                          },
                                          icon: Icon(
                                              isPlay &&
                                                      trendingPlayIndex == index
                                                  ? Icons.pause_sharp
                                                  : Icons.play_arrow_sharp,
                                              color: white,
                                              size: ScreenUtil().setSp(15))),
                                    ),
                                    alignment: Alignment.center,
                                  )
                                ],
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(15),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                                '${myTrendingSongs[index].name}',
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: Colors.black),
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                        Expanded(
                                            child: Text(
                                                'by ${myTrendingSongs[index].by}',
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: darkGray)))
                                      ],
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(5),
                                    ),
                                    Text("${myTrendingSongs[index].duration}",
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(12),
                                            color: Colors.black)),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setSp(15),
                              ),
                              InkWell(
                                  child: Padding(
                                    child: SvgPicture.asset(
                                        "assets/icons/svg/${myTrendingSongs[index].isSaved! ? "saved_song.svg" : "song_add.svg"}"),
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil().setSp(15),
                                        right: ScreenUtil().setSp(5)),
                                  ),
                                  onTap: () {
                                    Api.put.call(context,
                                        method:
                                            "users/songs/${myTrendingSongs[index].id}/${myTrendingSongs[index].isSaved! ? "unsave" : "save"}",
                                        //param:{}
                                        onResponseSuccess: (Map object) {
                                      myTrendingSongs[index].isSaved =
                                          !myTrendingSongs[index].isSaved!;
                                      getSavedSongs(nameController.text);
                                    });
                                  })
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setSp(15),
                        )
                      ],
                    );
                  }),
              ListView.builder(
                  shrinkWrap: true,
                  controller: fameScrollController,
                  itemCount: fameSongs.length,
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(16),
                      right: ScreenUtil().setWidth(24)),
                  itemBuilder: (followersContext, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            downloadFile(
                                fameSongs[index].song, fameSongs[index]);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: ScreenUtil().setSp(20),
                                    backgroundImage: NetworkImage(
                                        "${ApiProvider.s3UrlPath}/${ApiProvider.funlinksMusic}/${fameSongs[index].thumbnail}"),
                                  ),
                                  Align(
                                    child: SizedBox(
                                      height: ScreenUtil().setSp(40),
                                      width: ScreenUtil().setSp(40),
                                      child: IconButton(
                                          onPressed: () async {
                                            if (famePlayIndex != index) {
                                              isPlay = false;
                                            }
                                            famePlayIndex = index;
                                            if (!isPlay) {
                                              setState(() {
                                                isPlay = !isPlay;
                                              });
                                              await audioPlayer.stop();
                                              int result = await audioPlayer.play(
                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.funlinksMusic}/${fameSongs[index].song}");
                                            } else {
                                              setState(() {
                                                isPlay = !isPlay;
                                              });
                                              await audioPlayer.stop();
                                            }
                                          },
                                          icon: Icon(
                                              isPlay && famePlayIndex == index
                                                  ? Icons.pause_sharp
                                                  : Icons.play_arrow_sharp,
                                              color: white,
                                              size: ScreenUtil().setSp(15))),
                                    ),
                                    alignment: Alignment.center,
                                  )
                                ],
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(15),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                                '${fameSongs[index].name}',
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: Colors.black),
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                        Expanded(
                                            child: Text(
                                                'by ${fameSongs[index].by}',
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: darkGray)))
                                      ],
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(5),
                                    ),
                                    Text("${fameSongs[index].duration}",
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(12),
                                            color: Colors.black)),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setSp(15),
                              ),
                              InkWell(
                                  child: Padding(
                                    child: SvgPicture.asset(
                                        "assets/icons/svg/${fameSongs[index].isSaved! ? "saved_song.svg" : "song_add.svg"}"),
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil().setSp(15),
                                        right: ScreenUtil().setSp(5)),
                                  ),
                                  onTap: () {
                                    Api.put.call(context,
                                        method:
                                            "users/songs/${fameSongs[index].id}/${fameSongs[index].isSaved! ? "unsave" : "save"}",
                                        param: {},
                                        onResponseSuccess: (Map object) {
                                      fameSongs[index].isSaved =
                                          !fameSongs[index].isSaved!;
                                      getSavedSongs(nameController.text);
                                    });
                                  })
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setSp(15),
                        )
                      ],
                    );
                  }),
              ListView.builder(
                  shrinkWrap: true,
                  controller: fameVoiceScrollController,
                  itemCount: fameVoiceSongs.length,
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(16),
                      right: ScreenUtil().setWidth(24)),
                  itemBuilder: (followersContext, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            downloadFile(fameVoiceSongs[index].song,
                                fameVoiceSongs[index]);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: ScreenUtil().setSp(20),
                                    backgroundImage: NetworkImage(
                                        "${ApiProvider.s3UrlPath}/${ApiProvider.funlinksMusic}/${fameVoiceSongs[index].thumbnail}"),
                                  ),
                                  Align(
                                    child: SizedBox(
                                      height: ScreenUtil().setSp(40),
                                      width: ScreenUtil().setSp(40),
                                      child: IconButton(
                                          onPressed: () async {
                                            if (fameVoicePlayIndex != index) {
                                              isPlay = false;
                                            }
                                            fameVoicePlayIndex = index;
                                            if (!isPlay) {
                                              setState(() {
                                                isPlay = !isPlay;
                                              });
                                              await audioPlayer.stop();
                                              int result = await audioPlayer.play(
                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.funlinksMusic}/${fameVoiceSongs[index].song}");
                                            } else {
                                              setState(() {
                                                isPlay = !isPlay;
                                              });
                                              await audioPlayer.stop();
                                            }
                                          },
                                          icon: Icon(
                                              isPlay &&
                                                      fameVoicePlayIndex ==
                                                          index
                                                  ? Icons.pause_sharp
                                                  : Icons.play_arrow_sharp,
                                              color: white,
                                              size: ScreenUtil().setSp(15))),
                                    ),
                                    alignment: Alignment.center,
                                  )
                                ],
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(15),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                                '${fameVoiceSongs[index].name}',
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: Colors.black),
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                        Expanded(
                                            child: Text(
                                                'by ${fameVoiceSongs[index].by}',
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: darkGray)))
                                      ],
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(5),
                                    ),
                                    Text("${fameVoiceSongs[index].duration}",
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(12),
                                            color: Colors.black)),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setSp(15),
                              ),
                              InkWell(
                                  child: Padding(
                                    child: SvgPicture.asset(
                                        "assets/icons/svg/${fameVoiceSongs[index].isSaved! ? "saved_song.svg" : "song_add.svg"}"),
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil().setSp(15),
                                        right: ScreenUtil().setSp(5)),
                                  ),
                                  onTap: () {
                                    Api.put.call(context,
                                        method:
                                            "users/songs/${fameVoiceSongs[index].id}/${fameVoiceSongs[index].isSaved! ? "unsave" : "save"}",
                                        param: {},
                                        onResponseSuccess: (Map object) {
                                      fameVoiceSongs[index].isSaved =
                                          !fameVoiceSongs[index].isSaved!;
                                      getSavedSongs(nameController.text);
                                    });
                                  })
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setSp(15),
                        )
                      ],
                    );
                  }),
              ListView.builder(
                  shrinkWrap: true,
                  controller: savedScrollController,
                  itemCount: savedSongs.length,
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(16),
                      right: ScreenUtil().setWidth(24)),
                  itemBuilder: (followersContext, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            downloadFile(
                                savedSongs[index].song, savedSongs[index]);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: ScreenUtil().setSp(20),
                                    backgroundImage: NetworkImage(
                                        "${ApiProvider.s3UrlPath}/${ApiProvider.funlinksMusic}/${savedSongs[index].thumbnail}"),
                                  ),
                                  Align(
                                    child: SizedBox(
                                      height: ScreenUtil().setSp(40),
                                      width: ScreenUtil().setSp(40),
                                      child: IconButton(
                                          onPressed: () async {
                                            if (savedPlayIndex != index) {
                                              isPlay = false;
                                            }
                                            savedPlayIndex = index;
                                            if (!isPlay) {
                                              setState(() {
                                                isPlay = !isPlay;
                                              });
                                              await audioPlayer.stop();
                                              int result = await audioPlayer.play(
                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.funlinksMusic}/${savedSongs[index].song}");
                                            } else {
                                              setState(() {
                                                isPlay = !isPlay;
                                              });
                                              await audioPlayer.stop();
                                            }
                                          },
                                          icon: Icon(
                                              isPlay && savedPlayIndex == index
                                                  ? Icons.pause_sharp
                                                  : Icons.play_arrow_sharp,
                                              color: white,
                                              size: ScreenUtil().setSp(15))),
                                    ),
                                    alignment: Alignment.center,
                                  )
                                ],
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(15),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                                '${savedSongs[index].name}',
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: Colors.black),
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                        Expanded(
                                            child: Text(
                                                'by ${savedSongs[index].by}',
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: darkGray)))
                                      ],
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(5),
                                    ),
                                    Text("${savedSongs[index].duration}",
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(12),
                                            color: Colors.black)),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setSp(15),
                              ),
                              InkWell(
                                  child: Padding(
                                    child: SvgPicture.asset(
                                        "assets/icons/svg/song_add.svg"),
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil().setSp(15),
                                        right: ScreenUtil().setSp(5)),
                                  ),
                                  onTap: () {
                                    Api.put.call(context,
                                        method:
                                            "users/songs/${savedSongs[index].id}/unsave",
                                        param: {},
                                        onResponseSuccess: (Map object) {
                                      getSavedSongs(nameController.text);
                                    });
                                  })
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setSp(15),
                        )
                      ],
                    );
                  })
            ], controller: tabController),
          ))
        ],
      ),
    );
  }

  Future<void> downloadFile(mediaPath, ResultSongs resultSongs) async {
    Constants.progressDialog(true, context);
    var dir = await getApplicationDocumentsDirectory();
    Dio dio = Dio();

    try {
      print("path ${dir.path}");
      await dio.download(
          "${ApiProvider.s3UrlPath}/${ApiProvider.funlinksMusic}/${mediaPath}",
          "${dir.path}/test.mp3", onReceiveProgress: (rec, total) {
        print("Rec: $rec , Total: $total");
        if (rec == total) {
          Constants.progressDialog(false, context);
          var map = {"path": "${dir.path}/test.mp3", "model": resultSongs};
          Navigator.pop(context, map);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
