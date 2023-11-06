import 'dart:io';

import 'package:famelink/databse/AppDatabase.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/media_compression_provider.dart';
import 'package:famelink/models/ChallengesResponse.dart';
import 'package:famelink/models/funlinks_songs_model.dart';
import 'package:famelink/models/tags.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/upload/modelClass/FunlinksMusicModel.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/custom_snack_bar.dart';
import 'package:famelink/util/widgets/upload_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:video_trimmer/video_trimmer.dart';

class FunLinkUploadScreenTwo extends StatefulWidget {
  String? videoPath;
  String? musicPath;
  ResultSongs? musicId;
  ChallengesModelData? challengesModelData;
  bool? userProfile;

  FunLinkUploadScreenTwo(
      {this.videoPath,
      this.musicPath,
      this.musicId,
      this.challengesModelData,
      this.userProfile});

  @override
  _FunLinkUploadScreenTwoState createState() => _FunLinkUploadScreenTwoState();
}

class _FunLinkUploadScreenTwoState extends State<FunLinkUploadScreenTwo> {
  final ApiProvider _api = ApiProvider();
  int _value = -1;
  Trimmer _trimmer = Trimmer();
  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  ValueNotifier<double> _counter = ValueNotifier<double>(0);
  TextEditingController commentController = new TextEditingController();
  TextEditingController songNameController = new TextEditingController();
  TextEditingController challengeController = new TextEditingController();
  List<Challenges> challengesList = <Challenges>[];
  List<FunlinksMusicModelResult> funlinksMusicModelResult =
      <FunlinksMusicModelResult>[];
  List<Challenges> selectedChallengesList = <Challenges>[];
  List<FunlinksMusicModelResult> funlinksMusicModelResultList =
      <FunlinksMusicModelResult>[];
  List<Tags> tags = <Tags>[];
  TextEditingController tagName = new TextEditingController();
  TextEditingController clubcodeOfferController = new TextEditingController();
  String? tagId;
  String? songId;
  List<Map> talentGroup = [
    {'name': 'Singing', 'isSelected': false},
    {'name': 'Dancing', 'isSelected': false},
    {'name': 'Sports', 'isSelected': false},
    {'name': 'Athlete', 'isSelected': false},
    {'name': 'Pranks', 'isSelected': false},
    {'name': 'Acting', 'isSelected': false},
    {'name': 'Music', 'isSelected': false}
  ];
  List<String> talentSelected = [];
  TextEditingController otherController = new TextEditingController();

  // Subscription _subscription;

  Future<List<Challenges>> _getChallengesData(String query) async {
    await Future<void>.delayed(Duration(seconds: 1));
    if (query.isNotEmpty) {
      Api.get.call(context,
          method: "challenges/search/$query/funlinks",
          param: {},
          isLoading: false,
          onResponseSuccess: (Map<dynamic, dynamic> object) async {
        challengesList.clear();
        var result = ChallengesResponse.fromJson(object);
        challengesList = result.result!;
      });
      return challengesList;
    } else {
      challengesList.clear();
      return challengesList;
    }
  }

  Future<List<FunlinksMusicModelResult>?> getMusicData(String query) async {
    await Future<void>.delayed(Duration(seconds: 1));
    if (query != '' && query != null) {
      var result = await _api.getFunlinksSongsAPI(query);

      if (result != null) {
        setState(() {
          //if (result.success == true) {
          print(result.result);
          setState(() {
            funlinksMusicModelResult.addAll(result.result!);
          });

          //return funlinksMusicModelResult!;
          // } else {
          //   Constants.toastMessage(msg: result.message);
          //   return funlinksMusicModelResult;
          // }
        });
      }
    } else {
      // funlinksMusicModelResult.clear();
      return funlinksMusicModelResult;
    }
  }

  Future<List<Tags>?> getTagsData(String query) async {
    await Future<void>.delayed(Duration(seconds: 1));
    if (query != '' && query != null) {
      var result = await _api.getTagsAPI(query);
      if (result != null) {
        tags.clear();
        setState(() {
          print(result);
          setState(() {
            tags.addAll(result.result!);
          });

          //return tags;
        });
      }
    } else {
      tags.clear();
      return tags;
    }
  }

  // Future<List<FunlinksMusicModelResult>> getMusicData(String query) async {
  //   var result = await _api.getFunlinksSongsAPI(query);
  //
  //   if (result != null) {
  //     setState(() {
  //       if (result.toString() == 'true') {
  //         print(result.result);
  //         setState(() {
  //           funlinksMusicModelResult.addAll(result.result);
  //         });
  //
  //         return funlinksMusicModelResult;
  //       } else {
  //         Constants.toastMessage(msg: result.message);
  //         return funlinksMusicModelResult;
  //       }
  //     });
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    // _subscription.unsubscribe();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('==============-----------${widget.userProfile}');
    _trimmer.loadVideo(videoFile: File(widget.videoPath!));
    // _subscription = VideoCompress.compressProgress$.subscribe((progress) {
    //   debugPrint('progress: $progress');
    //   _counter.value = progress;
    //   if (progress >= 100) {
    //     progressDialog(false, context);
    //   }
    // });
    if (widget.challengesModelData != null) {
      Challenges challenges = Challenges();
      challenges.sId = widget.challengesModelData!.challengeId;
      challenges.hashTag = widget.challengesModelData!.challengeName;
      //this.selectedChallengesList.add(challenges);
      challengeController.text = widget.challengesModelData!.challengeName;
    }
    if (widget.musicId != null) {
      songNameController.text = widget.musicId!.name!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        toolbarHeight: ScreenUtil().setHeight(61),
        backgroundColor: appBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(
              text: "Review",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w600,
                  color: black,
                  fontSize: ScreenUtil().setSp(18))),
          TextSpan(
              text: ' & ',
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenUtil().setSp(18),
                  color: black)),
          TextSpan(
              text: "Upload",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w400,
                  color: lightRed,
                  fontSize: ScreenUtil().setSp(18))),
        ])),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<MediaCompressionProvider>(
                  builder: (context, provider, child) {
                return Container(
                  height: ScreenUtil().setSp(430),
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(38),
                            right: ScreenUtil().setWidth(38)),
                        height: ScreenUtil().setSp(422),
                        child: Stack(
                          children: [
                            VideoViewer(trimmer: _trimmer),
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                child: _isPlaying
                                    ? const Icon(
                                        Icons.pause,
                                        size: 30.0,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.play_arrow,
                                        size: 30.0,
                                        color: Colors.white,
                                      ),
                                onPressed: () async {
                                  bool playbackState =
                                      await _trimmer.videPlaybackControl(
                                    startValue: _startValue,
                                    endValue: _endValue,
                                  );
                                  setState(() {
                                    _isPlaying = playbackState;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      provider.isLoading
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: LinearProgressIndicator(
                                color: Colors.orange,
                              ),
                            )
                          : Container()
                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: TrimEditor(
                      //     trimmer: _trimmer,
                      //     viewerHeight: 50.0,
                      //     borderWidth: 4,
                      //     scrubberWidth: 2,
                      //     circleSizeOnDrag: 10,
                      //     circlePaintColor: lightRed,
                      //     borderPaintColor: lightRed,
                      //     scrubberPaintColor: lightRed,
                      //     durationTextStyle: GoogleFonts.nunitoSans(
                      //         color: lightRed, fontWeight: FontWeight.w400),
                      //     viewerWidth: (MediaQuery.of(context).size.width),
                      //     maxVideoLength: const Duration(seconds: 30),
                      //     onChangeStart: (value) {
                      //       _startValue = value;
                      //     },
                      //     onChangeEnd: (value) {
                      //       _endValue = value;
                      //     },
                      //     onChangePlaybackState: (value) {
                      //       setState(() {
                      //         _isPlaying = value;
                      //       });
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                );
              }),
              Container(
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(38),
                    right: ScreenUtil().setWidth(38)),
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(34)),
                child: TextFormField(
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(150),
                  ],
                  controller: commentController,
                  minLines: 1,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Fun Words',
                    labelStyle: GoogleFonts.nunitoSans(
                        color: black,
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(14)),
                    hintText: 'Say Something....',
                    hintStyle: GoogleFonts.nunitoSans(
                        color: lightGray,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(10)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(24),
                    left: ScreenUtil().setWidth(38),
                    right: ScreenUtil().setWidth(38)),
                child: TypeAheadFormField<Challenges>(
                  direction: AxisDirection.up,
                  textFieldConfiguration: TextFieldConfiguration(
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(20),
                      ],
                      textAlign: TextAlign.start,
                      controller: challengeController,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () {},
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(12),
                          color: buttonBlue,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(2),
                              top: ScreenUtil().setHeight(0)),
                          labelText: "# Challenge Name",
                          labelStyle: GoogleFonts.roboto(
                              color: darkGray,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenUtil().setSp(12)))),
                  suggestionsCallback: (pattern) async {
                    return await _getChallengesData(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(
                        suggestion.hashTag!,
                        style: GoogleFonts.roboto(
                            color: darkGray,
                            fontWeight: FontWeight.w300,
                            fontSize: ScreenUtil().setSp(12)),
                      ),
                    );
                  },
                  // transitionBuilder: (context, suggestionsBox, controller) {
                  //   // return suggestionsBox;
                  //   return
                  // },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      this.selectedChallengesList.clear();
                      this.selectedChallengesList.add(suggestion);
                      challengeController.text = suggestion.hashTag!;
                    });
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(24),
                    left: ScreenUtil().setWidth(38),
                    right: ScreenUtil().setWidth(38),
                    bottom: 20),
                child: TypeAheadFormField<FunlinksMusicModelResult>(
                  direction: AxisDirection.up,
                  textFieldConfiguration: TextFieldConfiguration(
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(20),
                    ],
                    textAlign: TextAlign.start,
                    controller: songNameController,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () {},
                    style: GoogleFonts.nunitoSans(
                        fontSize: ScreenUtil().setSp(12),
                        color: buttonBlue,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          bottom: ScreenUtil().setHeight(2),
                          top: ScreenUtil().setHeight(0)),
                      hintText: 'Audio / Song Name (Fame Voice)',
                      hintStyle: GoogleFonts.nunitoSans(
                          color: darkGray,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w300,
                          fontSize: ScreenUtil().setSp(12)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: darkGray),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightRed),
                      ),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    await getMusicData(pattern);
                    return funlinksMusicModelResult;
                  },
                  itemBuilder: (context, suggestion) {
                    // suggestion.result.map((e) => ListTile(
                    //   title: Text(
                    //     e.name,
                    //     style: GoogleFonts.roboto(
                    //         color: darkGray,
                    //         fontWeight: FontWeight.w300,
                    //         fontSize: ScreenUtil().setSp(12)),
                    //   ),
                    // ));
                    // suggestion.result
                    //     .where(
                    //         (i) => i.name.toLowerCase().contains(value.toLowerCase()) && i.code != '7788').toList();
                    return ListTile(
                      title: Text(
                        suggestion.name!,
                        style: GoogleFonts.roboto(
                            color: darkGray,
                            fontWeight: FontWeight.w300,
                            fontSize: ScreenUtil().setSp(12)),
                      ),
                    );
                  },
                  // transitionBuilder: (context, suggestionsBox, controller) {
                  //   return suggestionsBox;
                  // },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      this.funlinksMusicModelResultList.clear();
                      this.funlinksMusicModelResultList.add(suggestion);
                      songNameController.text = suggestion.name!;
                      songId = suggestion.sId;
                    });
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(8),
                    left: ScreenUtil().setWidth(38),
                    right: ScreenUtil().setWidth(38)),
                child: TypeAheadFormField<Tags>(
                  direction: AxisDirection.up,
                  textFieldConfiguration: TextFieldConfiguration(
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(20),
                      ],
                      textAlign: TextAlign.start,
                      controller: tagName,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () {},
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(12),
                          color: buttonBlue,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(2),
                              top: ScreenUtil().setHeight(0)),
                          labelText: "@ Agency Collabs / Brands / Users",
                          labelStyle: GoogleFonts.roboto(
                              color: darkGray,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenUtil().setSp(12)))),
                  suggestionsCallback: (pattern) async {
                    // return await getTagsData(pattern);
                    await getTagsData(pattern);
                    return tags;
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(
                        suggestion.username!,
                        style: GoogleFonts.roboto(
                            color: darkGray,
                            fontWeight: FontWeight.w300,
                            fontSize: ScreenUtil().setSp(12)),
                      ),
                    );
                  },
                  // transitionBuilder: (context, suggestionsBox, controller) {
                  //   // return suggestionsBox;
                  // },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      this.tags.clear();
                      this.tags.add(suggestion);
                      tagName.text = suggestion.username!;
                      tagId = suggestion.sId;
                    });
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(24),
                    left: ScreenUtil().setWidth(38),
                    right: ScreenUtil().setWidth(38),
                    bottom: 20),
                child: TypeAheadFormField<FunlinksMusicModelResult>(
                  direction: AxisDirection.up,
                  textFieldConfiguration: TextFieldConfiguration(
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(20),
                    ],
                    textAlign: TextAlign.start,
                    controller: clubcodeOfferController,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () {},
                    style: GoogleFonts.nunitoSans(
                        fontSize: ScreenUtil().setSp(12),
                        color: buttonBlue,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          bottom: ScreenUtil().setHeight(2),
                          top: ScreenUtil().setHeight(0)),
                      hintText: 'Club Offer Code',
                      hintStyle: GoogleFonts.nunitoSans(
                          color: darkGray,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w300,
                          fontSize: ScreenUtil().setSp(12)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: darkGray),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightRed),
                      ),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    await getMusicData(pattern);
                    return funlinksMusicModelResult;
                  },
                  itemBuilder: (context, suggestion) {
                    // suggestion.result.map((e) => ListTile(
                    //   title: Text(
                    //     e.name,
                    //     style: GoogleFonts.roboto(
                    //         color: darkGray,
                    //         fontWeight: FontWeight.w300,
                    //         fontSize: ScreenUtil().setSp(12)),
                    //   ),
                    // ));
                    // suggestion.result
                    //     .where(
                    //         (i) => i.name.toLowerCase().contains(value.toLowerCase()) && i.code != '7788').toList();
                    return ListTile(
                      title: Text(
                        suggestion.name!,
                        style: GoogleFonts.roboto(
                            color: darkGray,
                            fontWeight: FontWeight.w300,
                            fontSize: ScreenUtil().setSp(12)),
                      ),
                    );
                  },
                  // transitionBuilder: (context, suggestionsBox, controller) {
                  //   return suggestionsBox;
                  // },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      this.funlinksMusicModelResultList.clear();
                      this.funlinksMusicModelResultList.add(suggestion);
                      songNameController.text = suggestion.name!;
                      songId = suggestion.sId;
                    });
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(30),
                    left: ScreenUtil().setWidth(38),
                    right: ScreenUtil().setWidth(38)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Talent Category:",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        color: lightGray,
                        fontWeight: FontWeight.w300,
                        fontSize: ScreenUtil().setSp(14)),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(12),
                    left: ScreenUtil().setWidth(38),
                    right: ScreenUtil().setWidth(38)),
                child: GridView.builder(
                  padding: EdgeInsets.all(0.0),
                  primary: false,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                  ),
                  itemCount: talentGroup.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (talentGroup[index]['isSelected'] == false) {
                            talentSelected.add(talentGroup[index]['name']);
                            talentGroup[index]['isSelected'] = true;
                          } else {
                            talentSelected.remove(talentGroup[index]);
                            talentGroup[index]['isSelected'] = false;
                          }
                        });
                      },
                      child: Wrap(
                        children: [
                          Container(
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().radius(15)),
                              border: Border.all(color: black),
                              color: talentGroup[index]['isSelected'] == true
                                  ? Color(0xff4B4E58)
                                  : Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(6),
                                  bottom: ScreenUtil().setHeight(6)),
                              child: Text(
                                talentGroup[index]['name'],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(12),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    color:
                                        talentGroup[index]['isSelected'] == true
                                            ? white
                                            : black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(38),
                    right: ScreenUtil().setWidth(38)),
                child: TextField(
                  onChanged: (_) {},
                  onSubmitted: (_) {},
                  controller: otherController,
                  maxLines: 1,
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.multiline,
                  style: GoogleFonts.nunitoSans(
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                      color: black),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                    hintText:
                        'Not in the above list, type your own (max 10 char)',
                    hintStyle: GoogleFonts.nunitoSans(
                        fontSize: ScreenUtil().setSp(14),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9B9B9B)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: lightRed, width: 1)),
                  ),
                ),
              ),

              // Container(
              //   padding: EdgeInsets.only(
              //       left: ScreenUtil().setWidth(38), right: ScreenUtil().setWidth(38)),
              //   margin: EdgeInsets.only(top: ScreenUtil().setHeight(18)),
              //   child: TextFormField(
              //     textAlign: TextAlign.start,
              //     focusNode: songNameController.text.isNotEmpty ? AlwaysDisabledFocusNode():AlwaysEnabledFocusNode(),
              //     textAlignVertical: TextAlignVertical.center,
              //     textInputAction: TextInputAction.done,
              //
              //     style: GoogleFonts.nunitoSans(
              //         fontSize: ScreenUtil().setSp(12),
              //         color: buttonBlue,
              //         fontWeight: FontWeight.w400),
              //     controller: songNameController,
              //     decoration: InputDecoration(
              //       contentPadding: EdgeInsets.only(
              //           bottom: ScreenUtil().setHeight(2),
              //           top: ScreenUtil().setHeight(0)),
              //       hintText: 'Audio / Song Name (Fame Voice)',
              //       hintStyle: GoogleFonts.nunitoSans(
              //           color: darkGray,
              //           fontStyle: FontStyle.normal,
              //           fontWeight: FontWeight.w300,
              //           fontSize: ScreenUtil().setSp(12)),
              //       enabledBorder: UnderlineInputBorder(
              //         borderSide: BorderSide(color: darkGray),
              //       ),
              //       focusedBorder: UnderlineInputBorder(
              //         borderSide: BorderSide(color: lightRed),
              //       ),
              //     ),
              //   ),
              // ),
              Consumer<MediaCompressionProvider>(
                  builder: (context, provider, child) {
                return provider.isLoading
                    ? Center(
                        child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: CircularProgressIndicator(),
                      ))
                    : UploadButton(
                        text: 'Upload',
                        onPressed: () async {
                          showSnackBar(
                              context: context,
                              message: "Compressing...",
                              isError: false);
                          final mediapro =
                              await Provider.of<MediaCompressionProvider>(
                                  context,
                                  listen: false);
                          mediapro
                              .compressVideo(context, File(widget.videoPath!),
                                  onSave: (String? path) async {
                            if (path != null) {
                              mediapro.compressAudio(context, File(path!),
                                  onSave: (String? outputPath) async {
                                File thumbnail =
                                    await Provider.of<MediaCompressionProvider>(
                                            context,
                                            listen: false)
                                        .getVideoThumbnail(File(path));
                                showSnackBar(
                                    context: context,
                                    message: "Compressing Done",
                                    isError: false);
                                await _uploadContestData(
                                    path, thumbnail, outputPath!);
                              });
                            }
                          });
                        });
              }),
            ],
          ),
        ),
      ),
    );
  }

  void progressDialog(bool isLoading, BuildContext context) {
    AlertDialog dialog = AlertDialog(
      backgroundColor: Colors.black,
      content: Container(
          color: Colors.black,
          height: 60.0,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Compressing",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                SizedBox(height: 8),
                ValueListenableBuilder<double>(
                  builder:
                      (BuildContext? context, double? value, Widget? child) {
                    // This builder will only get called when the _counter
                    // is updated.
                    return LinearPercentIndicator(
                      lineHeight: 10.0,
                      percent: value! >= 100 ? 1 : value / 100,
                      backgroundColor: Colors.white,
                      progressColor: Colors.black26,
                    );
                  },
                  valueListenable: _counter,
                  // The child parameter is most helpful if the child is
                  // expensive to build and does not depend on the value from
                  // the notifier.
                ),
                SizedBox(height: 15),
              ],
            ),
          )),
      contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
    );
    if (!isLoading) {
      Navigator.of(context).pop();
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return dialog;
          });
    }
  }

  Future<String?> _saveVideo() async {
    var snackBar = SnackBar(
      content: Text('Compressing'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    var _value;

    await _trimmer
        .saveTrimmedVideo(
            startValue: _startValue,
            endValue: _endValue,
            storageDir: StorageDir.externalStorageDirectory,
            videoFileName: "${File(widget.videoPath!).path.split('/').last}"
                .replaceFirst(".mp4", ""),
            onSave: (String? outputPath) {
              print("output$outputPath");
              _value = outputPath;
              return outputPath;
            })
        .then((value) {
      setState(() {
        print("==> funlink _video value :- $_value");
      });
    });
    print("==> funlink video value :- $_value");
    print("==> funlink video value :- ${_trimmer.currentVideoFile}");
    return _value;
  }

  Future _uploadContestData(
      String compressedPath, File videoThumbnail, String audiopath) async {
    List<String> idList = [];

    setState(() {
      if (challengeController.text.isNotEmpty) {
        idList.add(challengeController.text);
      }
    });

    List<String> tagList = [];
    if (tagId != null) {
      tagList.add(tagId ?? "");
    }
    if (otherController.text != '') {
      talentSelected.add(otherController.text);
    }
    Map map = {
      "description": commentController.text,
      "cluboffercode": clubcodeOfferController.text,
      "challengeId": idList,
      "song": songId,
      "musicName":
          songNameController.text.isEmpty ? null : songNameController.text,
      "video": File(compressedPath),
      "audio": File(audiopath),
      'thumbnail': videoThumbnail,
      "context": context,
      "profile": widget.userProfile,
      "tags": tagList,
      'talentCategory': talentSelected
    };
    print('${map}');
    Navigator.pop(context, map);

    // var result= _api.uploadFunLink(commentController.text,idList, songId,File(widget.videoPath),context,widget.userProfile);

    // if (result.toString() == "1") {
    //   print("============------------------success${result}");
    //   var snackBar = SnackBar(
    //     content: Text('Uploaded'),
    //   );
    //   ScaffoldMessenger.of(
    //       context).showSnackBar(
    //       snackBar);
    //   if(widget.userProfile == true){
    //     return Navigator.pushAndRemoveUntil<void>(
    //       context,
    //       MaterialPageRoute<void>(builder: (BuildContext context) =>  ProfileFameLink(runSelectPhase: 1,)),
    //       ModalRoute.withName('/'),
    //     );
    //   }else{
    //     return  Navigator.pushAndRemoveUntil<void>(
    //       context,
    //       MaterialPageRoute<void>(builder: (BuildContext context) =>  FunLinksUserProfile()),
    //       ModalRoute.withName('/'),
    //     );

    //   }

    // }
    // else{
    //   print('1-1-1-1-1-1-1-1-11-1-1');
    // }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class AlwaysEnabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => true;
}
