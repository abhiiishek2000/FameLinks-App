import 'dart:io';

import 'package:famelink/databse/AppDatabase.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/ChallengesResponse.dart';
import 'package:famelink/models/Profile_Model.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/settings/WebViewScreen.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_trimmer/video_trimmer.dart';

import '../../common/common_image.dart';
import '../../util/widgets/upload_button.dart';

class UploadScreenTwo extends StatefulWidget {
  final Map<String, File>? screenTwoData;
  ChallengesModelData? challengesModelData;

  UploadScreenTwo({this.screenTwoData, this.challengesModelData});

  @override
  _UploadScreenTwoState createState() => _UploadScreenTwoState();
}

class _UploadScreenTwoState extends State<UploadScreenTwo> {
  final ApiProvider _api = ApiProvider();
  int _value = -1;
  Trimmer _trimmer = Trimmer();
  TextEditingController commentController = new TextEditingController();
  TextEditingController challengesController = new TextEditingController();
  List<Challenges> challengesList = <Challenges>[];
  List<Challenges> selectedChallengesList = <Challenges>[];

  MyProfileResult? upperProfileData;

  String age = "";
  bool isFame = false;
  bool isAmassador = false;
  List<Challenges> _getChallenges(String query) {
    List<Challenges> matches = <Challenges>[];
    if (query.isNotEmpty) {
      matches.addAll(challengesList);
      setState(() {});
      matches.retainWhere(
          (s) => s.hashTag!.toLowerCase().contains(query.toLowerCase()));
      setState(() {});
    }
    return matches;
  }

  _getChallengesData() async {
    Api.get.call(context,
        method: "challenges/open/famelinks",
        param: {},
        isLoading: false, onResponseSuccess: (Map object) {
      var result = ChallengesResponse.fromJson(object);
      setState(() {
        challengesList = result.result!;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profile();

    if (widget.screenTwoData!['video'] != null) {
      _trimmer.loadVideo(videoFile: widget.screenTwoData!['video']!);
    }
    if (widget.challengesModelData != null) {
      Challenges challenges = Challenges();
      challenges.sId = widget.challengesModelData!.challengeId;
      challenges.name = widget.challengesModelData!.challengeName;
      this.selectedChallengesList.add(challenges);
      challengesController.text = widget.challengesModelData!.challengeName;
    }
    _getChallengesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        toolbarHeight: ScreenUtil().setHeight(61),
        backgroundColor: appBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(
              text: "Review & ",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  color: black,
                  fontSize: ScreenUtil().setSp(18))),
          TextSpan(
              text: "Upload",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(18),
                  color: lightRed)),
        ])),
      ),
      body: Container(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20),
            bottom: ScreenUtil().setWidth(20),
            right: ScreenUtil().setWidth(20)),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: ScreenUtil().setWidth(50),
                          height: ScreenUtil().setHeight(90),
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setSp(5),
                              right: ScreenUtil().setSp(5)),
                          child: widget.screenTwoData!['video'] != null
                              ? Stack(children: [
                                  SizedBox(
                                    height: ScreenUtil().setHeight(90),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: VideoViewer(trimmer: _trimmer),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      height: ScreenUtil().setHeight(24),
                                      width: ScreenUtil().setWidth(24),
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                            width: ScreenUtil().setSp(1),
                                            color: white,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenUtil().radius(3)))),
                                      child: Center(
                                        child: Icon(
                                          Icons.play_arrow,
                                          color: white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            right: ScreenUtil().setWidth(8.73),
                                            bottom:
                                                ScreenUtil().setHeight(8.73)),
                                        child: InkWell(
                                          onTap: () {
                                            widget.screenTwoData!['video'] =
                                                null!;
                                            Constants.video = null;
                                            setState(() {});
                                          },
                                          child: SvgPicture.asset(
                                              "assets/icons/svg/delete.svg",
                                              height: ScreenUtil().setSp(15),
                                              width: ScreenUtil().setSp(15)),
                                        )),
                                  )
                                ])
                              : Container(),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.only(
                                  topLeft:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  topRight:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  bottomLeft:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  bottomRight:
                                      Radius.circular(ScreenUtil().radius(5)))),
                        ),
                        //closeup
                        Container(
                          width: ScreenUtil().setWidth(50),
                          height: ScreenUtil().setHeight(90),
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setSp(5),
                              right: ScreenUtil().setSp(5)),
                          child: widget.screenTwoData!['closeUp'] != null &&
                                  widget.screenTwoData!['closeUp']!.path != ""
                              ? Stack(children: [
                                  SizedBox(
                                    height: ScreenUtil().setHeight(90),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.file(
                                          widget.screenTwoData!['closeUp']!,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            right: ScreenUtil().setWidth(8.73),
                                            bottom:
                                                ScreenUtil().setHeight(8.73)),
                                        child: InkWell(
                                          onTap: () {
                                            widget.screenTwoData!['closeUp'] =
                                                File("");
                                            Constants.closeUp = null;
                                            setState(() {});
                                          },
                                          child: SvgPicture.asset(
                                              "assets/icons/svg/delete.svg",
                                              height: ScreenUtil().setSp(15),
                                              width: ScreenUtil().setSp(15)),
                                        )),
                                  )
                                ])
                              : Container(),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.only(
                                  topLeft:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  topRight:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  bottomLeft:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  bottomRight:
                                      Radius.circular(ScreenUtil().radius(5)))),
                        ),
                        //medium
                        Container(
                          width: ScreenUtil().setWidth(50),
                          height: ScreenUtil().setHeight(90),
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setSp(5),
                              right: ScreenUtil().setSp(5)),
                          child: widget.screenTwoData!['medium'] != null &&
                                  widget.screenTwoData!['medium']!.path != ""
                              ? Stack(children: [
                                  SizedBox(
                                    height: ScreenUtil().setHeight(90),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.file(
                                          widget.screenTwoData!['medium']!,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            right: ScreenUtil().setWidth(8.73),
                                            bottom:
                                                ScreenUtil().setHeight(8.73)),
                                        child: InkWell(
                                          onTap: () {
                                            widget.screenTwoData!['medium'] =
                                                null!;
                                            Constants.medium = null;
                                            setState(() {});
                                          },
                                          child: SvgPicture.asset(
                                              "assets/icons/svg/delete.svg",
                                              height: ScreenUtil().setSp(15),
                                              width: ScreenUtil().setSp(15)),
                                        )),
                                  )
                                ])
                              : Container(),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.only(
                                  topLeft:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  topRight:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  bottomLeft:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  bottomRight:
                                      Radius.circular(ScreenUtil().radius(5)))),
                        ),

                        ///long
                        Container(
                          width: ScreenUtil().setWidth(50),
                          height: ScreenUtil().setHeight(90),
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setSp(5),
                              right: ScreenUtil().setSp(5)),
                          child: widget.screenTwoData!['long'] != null &&
                                  widget.screenTwoData!['long']!.path != ""
                              ? Stack(children: [
                                  SizedBox(
                                    height: ScreenUtil().setHeight(90),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.file(
                                          widget.screenTwoData!['long']!,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            right: ScreenUtil().setWidth(8.73),
                                            bottom:
                                                ScreenUtil().setHeight(8.73)),
                                        child: InkWell(
                                          onTap: () {
                                            widget.screenTwoData!['long'] =
                                                null!;
                                            Constants.long = null;
                                            setState(() {});
                                          },
                                          child: SvgPicture.asset(
                                              "assets/icons/svg/delete.svg",
                                              height: ScreenUtil().setSp(15),
                                              width: ScreenUtil().setSp(15)),
                                        )),
                                  )
                                ])
                              : Container(),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.only(
                                  topLeft:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  topRight:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  bottomLeft:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  bottomRight:
                                      Radius.circular(ScreenUtil().radius(5)))),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///poseOne
                        Container(
                          width: ScreenUtil().setWidth(50),
                          height: ScreenUtil().setHeight(90),
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setSp(5),
                              right: ScreenUtil().setSp(5)),
                          child: widget.screenTwoData!['pose1'] != null &&
                                  widget.screenTwoData!['pose1']!.path != ""
                              ? Stack(children: [
                                  SizedBox(
                                    height: ScreenUtil().setHeight(90),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.file(
                                          widget.screenTwoData!['pose1']!,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            right: ScreenUtil().setWidth(8.73),
                                            bottom:
                                                ScreenUtil().setHeight(8.73)),
                                        child: InkWell(
                                          onTap: () {
                                            widget.screenTwoData!['pose1'] =
                                                null!;
                                            Constants.pose1 = null;
                                            setState(() {});
                                          },
                                          child: SvgPicture.asset(
                                              "assets/icons/svg/delete.svg",
                                              height: ScreenUtil().setSp(15),
                                              width: ScreenUtil().setSp(15)),
                                        )),
                                  )
                                ])
                              : Container(),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.only(
                                  topLeft:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  topRight:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  bottomLeft:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  bottomRight:
                                      Radius.circular(ScreenUtil().radius(5)))),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(50),
                          height: ScreenUtil().setHeight(90),
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setSp(5),
                              right: ScreenUtil().setSp(5)),
                          child: widget.screenTwoData!['pose2'] != null &&
                                  widget.screenTwoData!['pose2']!.path != ""
                              ? Stack(children: [
                                  SizedBox(
                                    height: ScreenUtil().setHeight(90),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.file(
                                          widget.screenTwoData!['pose2']!,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            right: ScreenUtil().setWidth(8.73),
                                            bottom:
                                                ScreenUtil().setHeight(8.73)),
                                        child: InkWell(
                                          onTap: () {
                                            widget.screenTwoData!['pose2'] =
                                                null!;
                                            Constants.pose2 = null;
                                            setState(() {});
                                          },
                                          child: SvgPicture.asset(
                                              "assets/icons/svg/delete.svg",
                                              height: ScreenUtil().setSp(15),
                                              width: ScreenUtil().setSp(15)),
                                        )),
                                  )
                                ])
                              : Container(),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.only(
                                  topLeft:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  topRight:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  bottomLeft:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  bottomRight:
                                      Radius.circular(ScreenUtil().radius(5)))),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(50),
                          height: ScreenUtil().setHeight(90),
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setSp(5),
                              right: ScreenUtil().setSp(5)),
                          child: widget.screenTwoData!['additional'] != null &&
                                  widget.screenTwoData!['additional']!.path !=
                                      ""
                              ? Stack(children: [
                                  SizedBox(
                                    height: ScreenUtil().setHeight(90),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.file(
                                          widget.screenTwoData!['additional']!,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            right: ScreenUtil().setWidth(8.73),
                                            bottom:
                                                ScreenUtil().setHeight(8.73)),
                                        child: InkWell(
                                          onTap: () {
                                            widget.screenTwoData![
                                                'additional'] = null!;
                                            Constants.additional = null;
                                            setState(() {});
                                          },
                                          child: SvgPicture.asset(
                                              "assets/icons/svg/delete.svg",
                                              height: ScreenUtil().setSp(15),
                                              width: ScreenUtil().setSp(15)),
                                        )),
                                  )
                                ])
                              : Container(),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.only(
                                  topLeft:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  topRight:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  bottomLeft:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  bottomRight:
                                      Radius.circular(ScreenUtil().radius(5)))),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(50),
                          height: ScreenUtil().setHeight(90),
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setSp(5),
                              right: ScreenUtil().setSp(5)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(57.42)),
                    width: ScreenUtil().setWidth(299),
                    child: TextFormField(
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(150),
                      ],
                      controller: commentController,
                      minLines: 1,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Mind is Beautiful too',
                        labelStyle: GoogleFonts.nunitoSans(
                            color: black,
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(14)),
                        hintText: 'Say Something....',
                        hintStyle: GoogleFonts.nunitoSans(
                            color: Colors.black.withOpacity(0.49),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            fontSize: ScreenUtil().setSp(10)),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                              width: 1,
                              color: buttonBlue,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 1,
                              color: buttonBlue,
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                    child: TypeAheadFormField<Challenges>(
                      direction: AxisDirection.up,
                      textFieldConfiguration: TextFieldConfiguration(
                          controller: challengesController,
                          style: GoogleFonts.nunitoSans(
                              color: darkGray,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenUtil().setSp(12)),
                          decoration: InputDecoration(
                              labelText: "# Trendz Name",
                              labelStyle: GoogleFonts.nunitoSans(
                                  color: darkGray,
                                  fontWeight: FontWeight.w300,
                                  fontSize: ScreenUtil().setSp(12)))),
                      suggestionsCallback: (pattern) {
                        return _getChallenges(pattern);
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(
                            suggestion.hashTag!,
                            style: GoogleFonts.nunitoSans(
                                color: darkGray,
                                fontWeight: FontWeight.w300,
                                fontSize: ScreenUtil().setSp(12)),
                          ),
                        );
                      },
                      transitionBuilder: (context, suggestionsBox, controller) {
                        return suggestionsBox;
                      },
                      onSuggestionSelected: (suggestion) {
                        setState(() {
                          this.selectedChallengesList.clear();
                          this.selectedChallengesList.add(suggestion);
                          challengesController.text = suggestion.hashTag!;
                        });
                      },
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Know how it works?",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text.rich(TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Participate: ",
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w400,
                                color: lightRed,
                                fontSize: ScreenUtil().setSp(14))),
                        TextSpan(
                            text: " (Only one post per day is allowed in each)",
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(10),
                                color: Color(0xff4B4E58))),
                      ])),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(CommonImage.fameLinksIcon,
                                  width: 15,
                                  height: 10,
                                  color: Color(0xff9B9B9B)),
                              Text(
                                "FameLinksContests",
                                style: GoogleFonts.italiana(
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(12),
                                    color: Color(0xff9B9B9B)),
                              )
                            ],
                          ),
                          Text(
                            "(0 post left for today)",
                            style: GoogleFonts.italiana(
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(10),
                                color: Color(0xff9B9B9B)),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(CommonImage.starblack,
                                  width: 15,
                                  height: 10,
                                  color: Color(0xff9B9B9B)),
                              Text(
                                "AmbassadorTrendz",
                                style: GoogleFonts.italiana(
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(12),
                                    color: Color(0xff4B4E58)),
                              )
                            ],
                          ),
                          Text(
                            "(0 post left for today)",
                            style: GoogleFonts.italiana(
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(10),
                                color: Color(0xff4B4E58)),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height:24),
                  UploadButton(
                      text: "Upload",
                      onPressed: () async {
                        if (widget.screenTwoData!['video'] == null &&
                            Constants.closeUp == null &&
                            Constants.medium == null &&
                            Constants.long == null &&
                            Constants.pose1 == null &&
                            Constants.pose2 == null &&
                            Constants.additional == null) {
                          var snackBar = SnackBar(
                            content: Text('Select Photos & Video'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          await _uploadContestData();
                        }
                      }),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text("Your Contest Info -",
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    fontSize: ScreenUtil().setSp(12),
                                    color: black)),
                            Expanded(
                                child: Text("(Visit Edit Profile to update)",
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(10),
                                        color: darkGray,
                                        fontStyle: FontStyle.italic)))
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: ScreenUtil().setSp(3)),
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setSp(8),
                              bottom: ScreenUtil().setSp(8)),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: lightGray, width: ScreenUtil().setSp(1)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: ScreenUtil().setSp(8),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text("Category:",
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(12),
                                            color: darkGray)),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                          "${upperProfileData != null ? "${upperProfileData!.gender} (${age})" : ""}",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(12),
                                              color: black)))
                                ],
                              ),
                              SizedBox(
                                height: ScreenUtil().setSp(8),
                              ),
                              Divider(
                                height: 1,
                                color: lightGray,
                              ),
                              SizedBox(
                                height: ScreenUtil().setSp(8),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: ScreenUtil().setSp(8),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text("Winning Path:",
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(12),
                                            color: darkGray)),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: upperProfileData != null
                                        ? Text.rich(
                                            TextSpan(children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    "${upperProfileData!.contestPath!.district!.name} -> ",
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight:
                                                        upperProfileData!
                                                                .contestPath!
                                                                .district!
                                                                .isWinner!
                                                            ? FontWeight.w700
                                                            : FontWeight.w300,
                                                    color: black,
                                                    fontSize: ScreenUtil()
                                                        .setSp(12))),
                                            TextSpan(
                                                text:
                                                    "${upperProfileData!.contestPath!.state!.name} -> ",
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight:
                                                        upperProfileData!
                                                                .contestPath!
                                                                .state!
                                                                .isWinner!
                                                            ? FontWeight.w700
                                                            : FontWeight.w300,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: black)),
                                            TextSpan(
                                                text:
                                                    "${upperProfileData!.contestPath!.country!.name ?? ''} -> ",
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight:
                                                        upperProfileData!
                                                                .contestPath!
                                                                .country!
                                                                .isWinner!
                                                            ? FontWeight.w700
                                                            : FontWeight.w300,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: black)),
                                            TextSpan(
                                                text:
                                                    "${upperProfileData!.contestPath!.continent!.name} -> ",
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight:
                                                        upperProfileData!
                                                                .contestPath!
                                                                .continent!
                                                                .isWinner!
                                                            ? FontWeight.w700
                                                            : FontWeight.w300,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: black)),
                                            TextSpan(
                                                text:
                                                    "${upperProfileData!.contestPath!.world!.name}",
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight:
                                                        upperProfileData!
                                                                .contestPath!
                                                                .world!
                                                                .isWinner!
                                                            ? FontWeight.w700
                                                            : FontWeight.w300,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: black)),
                                          ]))
                                        : SizedBox(),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ontext) =>
                                        WebViewScreen("Stages of FameLinks")),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setSp(9),
                                  bottom: ScreenUtil().setSp(9)),
                              child: Text("Learn about Stages ?",
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w600,
                                      fontSize: ScreenUtil().setSp(12),
                                      color: buttonBlue)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _profile() async {
    Api.get.call(context, method: "users/me", param: {},
        onResponseSuccess: (Map object) async {
      var result = ProfileResponse.fromJson(object);
      upperProfileData = result.result;
      var ageGroup = upperProfileData!.ageGroup != null
          ? upperProfileData!.ageGroup
          : "groupD";
      if (ageGroup == "groupA") {
        age = "0-4";
      } else if (ageGroup == "groupB") {
        age = "4-12";
      } else if (ageGroup == "groupC") {
        age = "12-18";
      } else if (ageGroup == "groupD") {
        age = "18-28";
      } else if (ageGroup == "groupE") {
        age = "28-40";
      } else if (ageGroup == "groupF") {
        age = "40-50";
      } else if (ageGroup == "groupG") {
        age = "50-60";
      } else if (ageGroup == "groupH") {
        age = "60+";
      }
      setState(() {});
    });
  }

  Future<void> _uploadContestData() async {
    List<String> idList = [];
    for (Challenges challenges in selectedChallengesList) {
      idList.add(challenges.sId!);
    }
    Map map = {
      "challengeId": idList,
      "description": commentController.text,
      "closeUp": widget.screenTwoData!['closeUp'],
      "medium": widget.screenTwoData!['medium'],
      "long": widget.screenTwoData!['long'],
      "pose1": widget.screenTwoData!['pose1'],
      "pose2": widget.screenTwoData!['pose2'],
      "additional": widget.screenTwoData!['additional'],
      "video": widget.screenTwoData!['video'] != null
          ? widget.screenTwoData!['video']!
          : null,
      "video_tmb": widget.screenTwoData!['video_tmb'] != null
          ? widget.screenTwoData!['video_tmb']!
          : null,
      "ambassadorTrendz": isAmassador,
      "famelinksContest": isFame
    };

    Navigator.pop(context, map);
  }
}
