import 'dart:convert';
import 'dart:io';

import 'package:famelink/databse/AppDatabase.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/ChallengesResponse.dart';
import 'package:famelink/models/Profile_Model.dart';
import 'package:famelink/models/tags.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_trimmer/video_trimmer.dart';

class BrandUploadScreenTwo extends StatefulWidget {
  final Map<String, File?>? screenTwoData;
  ChallengesModelData? challengesModelData;

  BrandUploadScreenTwo({this.screenTwoData, this.challengesModelData});

  @override
  _BrandUploadScreenTwoState createState() => _BrandUploadScreenTwoState();
}

class _BrandUploadScreenTwoState extends State<BrandUploadScreenTwo> {
  final ApiProvider _api = ApiProvider();
  int _value = -1;
  Trimmer _trimmer = Trimmer();
  TextEditingController commentController = new TextEditingController();
  TextEditingController productNameController = new TextEditingController();
  TextEditingController productPriceController = new TextEditingController();
  TextEditingController challengesController = new TextEditingController();
  TextEditingController urlController = new TextEditingController();
  TextEditingController buttonNameController = new TextEditingController();
  TextEditingController tagsController = new TextEditingController();
  TextEditingController allotedController = new TextEditingController();
  TextEditingController giftController = new TextEditingController();
  List<Challenges> challengesList = <Challenges>[];
  List<Challenges> selectedChallengesList = <Challenges>[];

  MyProfileResult? upperProfileData;

  String age = "";
  List<Tags> tags = <Tags>[];
  TextEditingController tagName = new TextEditingController();
  String? tagId;
  bool productAvailable = false;
  // List<Challenges> _getChallenges(String query) {
  //   List<Challenges> matches = <Challenges>[];
  //   if (query.isNotEmpty) {
  //     matches.addAll(challengesList);
  //     matches.retainWhere(
  //         (s) => s.name.toLowerCase().contains(query.toLowerCase()));
  //   }
  //   return matches;
  // }

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

  checkProduct() async {
    Map<String, dynamic> map = {
      "hashTag": tagName.text,
      "productName": productNameController.text,
    };
    await Future<void>.delayed(Duration(seconds: 1));
    Api.post.call(context,
        method: "users/check/product/hashTag",
        param: map,
        isLoading: false, onResponseSuccess: (Map object) {
      var result = object;
      productAvailable = result['result']['isAvailable'];
      if (productAvailable == false) {
        productNameController.text == '';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product name not available'),
          ),
        );
      }
    });
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

          // return tags;
        });
      }
    } else {
      // tags.clear();
      return tags;
    }
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
      challenges.hashTag = widget.challengesModelData!.challengeName;
      this.selectedChallengesList.add(challenges);
      challengesController.text = widget.challengesModelData!.challengeName;
    }
    _getChallengesData();
  }

  @override
  Widget build(BuildContext context) {
    print("arrow_forward ");
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
              text: "Product ",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w600,
                  color: black,
                  fontSize: ScreenUtil().setSp(18))),
          TextSpan(
              text: "Catalogue & ",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w400,
                  color: black,
                  fontSize: ScreenUtil().setSp(14))),
          TextSpan(
              text: "Description",
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(18),
                  color: lightRed)),
        ])),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /* Container(
                    width: ScreenUtil().setWidth(50),
                    height: ScreenUtil().setHeight(90),
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setSp(5),
                        right: ScreenUtil().setSp(5)),
                    child: widget.screenTwoData['video'] != null
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
                                      widget.screenTwoData['video'] =
                                          null;
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
                  ),*/
                  //closeup
                  Container(
                    width: ScreenUtil().setWidth(50),
                    height: ScreenUtil().setHeight(90),
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setSp(5),
                        right: ScreenUtil().setSp(5)),
                    child: widget.screenTwoData!['closeUp'] != null
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
                                      bottom: ScreenUtil().setHeight(8.73)),
                                  child: InkWell(
                                    onTap: () {
                                      widget.screenTwoData!['closeUp'] = null;
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
                            topLeft: Radius.circular(ScreenUtil().radius(5)),
                            topRight: Radius.circular(ScreenUtil().radius(5)),
                            bottomLeft: Radius.circular(ScreenUtil().radius(5)),
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
                    child: widget.screenTwoData!['medium'] != null
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
                                      bottom: ScreenUtil().setHeight(8.73)),
                                  child: InkWell(
                                    onTap: () {
                                      widget.screenTwoData!['medium'] = null;
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
                            topLeft: Radius.circular(ScreenUtil().radius(5)),
                            topRight: Radius.circular(ScreenUtil().radius(5)),
                            bottomLeft: Radius.circular(ScreenUtil().radius(5)),
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
                    child: widget.screenTwoData!['long'] != null
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
                                      bottom: ScreenUtil().setHeight(8.73)),
                                  child: InkWell(
                                    onTap: () {
                                      widget.screenTwoData!['long'] = null;
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
                            topLeft: Radius.circular(ScreenUtil().radius(5)),
                            topRight: Radius.circular(ScreenUtil().radius(5)),
                            bottomLeft: Radius.circular(ScreenUtil().radius(5)),
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
                    child: widget.screenTwoData!['pose1'] != null
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
                                      bottom: ScreenUtil().setHeight(8.73)),
                                  child: InkWell(
                                    onTap: () {
                                      widget.screenTwoData!['pose1'] = null;
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
                            topLeft: Radius.circular(ScreenUtil().radius(5)),
                            topRight: Radius.circular(ScreenUtil().radius(5)),
                            bottomLeft: Radius.circular(ScreenUtil().radius(5)),
                            bottomRight:
                                Radius.circular(ScreenUtil().radius(5)))),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(50),
                    height: ScreenUtil().setHeight(90),
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setSp(5),
                        right: ScreenUtil().setSp(5)),
                    child: widget.screenTwoData!['pose2'] != null
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
                                      bottom: ScreenUtil().setHeight(8.73)),
                                  child: InkWell(
                                    onTap: () {
                                      widget.screenTwoData!['pose2'] = null;
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
                            topLeft: Radius.circular(ScreenUtil().radius(5)),
                            topRight: Radius.circular(ScreenUtil().radius(5)),
                            bottomLeft: Radius.circular(ScreenUtil().radius(5)),
                            bottomRight:
                                Radius.circular(ScreenUtil().radius(5)))),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(50),
                    height: ScreenUtil().setHeight(90),
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setSp(5),
                        right: ScreenUtil().setSp(5)),
                    child: widget.screenTwoData!['additional'] != null
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
                                      bottom: ScreenUtil().setHeight(8.73)),
                                  child: InkWell(
                                    onTap: () {
                                      widget.screenTwoData!['additional'] =
                                          null;
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
                            topLeft: Radius.circular(ScreenUtil().radius(5)),
                            topRight: Radius.circular(ScreenUtil().radius(5)),
                            bottomLeft: Radius.circular(ScreenUtil().radius(5)),
                            bottomRight:
                                Radius.circular(ScreenUtil().radius(5)))),
                  ),
                  /*Container(
                    width: ScreenUtil().setWidth(50),
                    height: ScreenUtil().setHeight(90),
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setSp(5),
                        right: ScreenUtil().setSp(5)),
                  ),*/
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(12), left: 38.w, right: 38.w),
              child: TypeAheadFormField<Tags>(
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
                        labelText: "#Create or Add in Existing HashTag",
                        labelStyle: GoogleFonts.roboto(
                            color: lightGray,
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
            Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil().setSp(24),
                  left: ScreenUtil().setSp(38),
                  right: ScreenUtil().setSp(38)),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(50),
                      ],
                      controller: productNameController,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (v) {
                        setState(() {
                          if (tagName.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Enter tag name'),
                              ),
                            );
                          } else {
                            checkProduct();
                          }
                        });
                      },
                      onChanged: (v) {
                        if (tagName.text == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Enter tag name'),
                            ),
                          );
                        } else {
                          if (v.length >= 3) {
                            setState(() {
                              checkProduct();
                            });
                          }
                        }
                      },
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Product Name',
                          contentPadding: EdgeInsets.only(
                              top: ScreenUtil().setSp(12),
                              bottom: ScreenUtil().setSp(12),
                              left: ScreenUtil().setSp(12)),
                          hintStyle: GoogleFonts.nunitoSans(
                              color: lightGray,
                              fontWeight: FontWeight.w700,
                              fontSize: ScreenUtil().setSp(12)),
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
                          suffixIcon: Icon(Icons.check,
                              color: productAvailable
                                  ? Colors.green
                                  : Colors.transparent)),
                    ),
                    flex: 2,
                  ),
                  SizedBox(
                    width: ScreenUtil().setSp(8),
                  ),
                  Expanded(
                    child: TextFormField(
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(10),
                      ],
                      controller: productPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            top: ScreenUtil().setSp(12),
                            bottom: ScreenUtil().setSp(12),
                            left: ScreenUtil().setSp(12)),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixText: '₹',
                        prefixStyle: GoogleFonts.nunitoSans(
                            color: black,
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(14)),
                        hintText: 'Price',
                        hintStyle: GoogleFonts.nunitoSans(
                            color: lightGray,
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(12)),
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
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil().setSp(30),
                  left: ScreenUtil().setSp(38),
                  right: ScreenUtil().setSp(38)),
              child: TextFormField(
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(150),
                ],
                controller: commentController,
                minLines: 4,
                maxLines: 6,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Product Description',
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
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
            Container(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(38),
                  right: ScreenUtil().setWidth(38)),
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(0)),
              child: TextFormField(
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.done,
                style: GoogleFonts.nunitoSans(
                    fontSize: ScreenUtil().setSp(12),
                    color: buttonBlue,
                    fontWeight: FontWeight.w400),
                controller: urlController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      bottom: ScreenUtil().setHeight(2),
                      top: ScreenUtil().setHeight(0)),
                  hintText: 'Purchase URL',
                  hintStyle: GoogleFonts.nunitoSans(
                      color: lightGray,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300,
                      fontSize: ScreenUtil().setSp(12)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: lightGray),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: lightRed),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(38),
                  right: ScreenUtil().setWidth(38),
                  top: ScreenUtil().setHeight(30)),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      height: 25,
                      width: 74,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Color(0xff7AACFF), Color(0xff0060FF)],
                        ),
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        textInputAction: TextInputAction.done,
                        style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            color: white,
                            fontWeight: FontWeight.w400),
                        controller: buttonNameController,
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(8),
                        ],
                        cursorColor: white,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 19.h),
                          border: InputBorder.none,
                          // enabledBorder: UnderlineInputBorder(
                          //   borderSide: BorderSide(color: darkGray),
                          // ),
                          // focusedBorder: UnderlineInputBorder(
                          //   borderSide: BorderSide(color: lightRed),
                          // ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    'Enter Button Name (max 8 characters)',
                    style: GoogleFonts.nunitoSans(
                        color: lightGray,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w300,
                        fontSize: ScreenUtil().setSp(12)),
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(38),
                  right: ScreenUtil().setWidth(38),
                  top: ScreenUtil().setHeight(20)),
              child: Row(
                children: [
                  Text(
                    'Total Give Aways:  ',
                    style: GoogleFonts.nunitoSans(
                        color: darkGray,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: ScreenUtil().setSp(12)),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Container(
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.top,
                            textInputAction: TextInputAction.done,
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
                                color: black,
                                fontWeight: FontWeight.w400),
                            controller: allotedController,
                            cursorColor: black,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(2),
                                  top: ScreenUtil().setHeight(0)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Divider(color: lightGray, height: 1)
                      ],
                    ),
                  ),
                  Text(
                    '   Fame Coins  ',
                    style: GoogleFonts.nunitoSans(
                        color: darkGray,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(10)),
                  ),
                  Text(
                    ' per Tag:  ',
                    style: GoogleFonts.nunitoSans(
                        color: darkGray,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: ScreenUtil().setSp(12)),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Container(
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.top,
                            textInputAction: TextInputAction.done,
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
                                color: black,
                                fontWeight: FontWeight.w400),
                            controller: giftController,
                            cursorColor: black,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(2),
                                  top: ScreenUtil().setHeight(0)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Divider(color: lightGray, height: 1)
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Align(
            //   alignment: Alignment.centerRight,
            //   child: Padding(
            //     padding: EdgeInsets.only(right: ScreenUtil().setSp(38)),
            //     child: Text("[users will see this tag in FollowLinks & FunLinks]",style: GoogleFonts.nunitoSans(
            //         color: buttonBlue,
            //         fontWeight: FontWeight.w300,
            //         fontSize: ScreenUtil().setSp(10)),),
            //   ),
            // ),
            InkWell(
              onTap: () async {
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
                } else if (tagName.text.isEmpty) {
                  var snackBar = SnackBar(
                    content: Text('Create or add existing HashTag'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (productNameController.text.isEmpty) {
                  var snackBar = SnackBar(
                    content: Text('Enter Product Name'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (productAvailable == false) {
                  productNameController.text = '';
                  var snackBar = SnackBar(
                    content: Text('Product name not available'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (productPriceController.text.isEmpty) {
                  var snackBar = SnackBar(
                    content: Text('Enter Product Price'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (urlController.text.isNotEmpty &&
                    !RegExp(r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?",
                            caseSensitive: false)
                        .hasMatch(urlController.text)) {
                  var snackBar = SnackBar(
                    content: Text('Enter valid purchase url'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (allotedController.text.isEmpty) {
                  var snackBar = SnackBar(
                    content: Text('Enter total give aways coins'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (allotedController.text.isNotEmpty &&
                    Constants.fameCoins <
                        int.parse(allotedController.text.toString())) {
                  var snackBar = SnackBar(
                    content: Text("You don't have sufficient balance"),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (giftController.text.isEmpty) {
                  var snackBar = SnackBar(
                    content: Text('Enter per tag coins'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  await _uploadContestData();
                }
              },
              child: Container(
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(20),
                    bottom: ScreenUtil().setHeight(20)),
                width: ScreenUtil().setWidth(200),
                height: ScreenUtil().setHeight(40),
                decoration: new BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [lightRedWhite, lightRed]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    border: Border.all(color: lightRed, width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Upload',
                      style: GoogleFonts.nunitoSans(
                          color: white,
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtil().setSp(22)),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(27),
                    ),
                    Icon(Icons.arrow_upward, color: white)
                  ],
                ),
              ),
            ),

            // Container(
            //     margin: EdgeInsets.only(
            //         top: ScreenUtil().setHeight(20),
            //         bottom: ScreenUtil().setHeight(20)),
            //     width: ScreenUtil().setWidth(200),
            //     height: ScreenUtil().setHeight(40),
            //     decoration: new BoxDecoration(
            //         gradient: LinearGradient(
            //             begin: Alignment.topCenter,
            //             end: Alignment.bottomCenter,
            //             colors: [Color(0xff7AACFF), Color(0xff0060FF)]),
            //         borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(30),
            //           topRight: Radius.circular(30),
            //           bottomLeft: Radius.circular(30),
            //           bottomRight: Radius.circular(30),
            //         ),),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           'Promote',
            //           style: GoogleFonts.nunitoSans(
            //               color: white,
            //               fontWeight: FontWeight.w700,
            //               fontSize: ScreenUtil().setSp(22)),
            //         ),
            //       ],
            //     ),
            //   ),
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
    if (tagsController.text.isNotEmpty) {
      idList.add(tagsController.text);
    }
    Map map = {
      "tags": jsonEncode(idList),
      "description": commentController.text,
      "name": productNameController.text,
      "price": productPriceController.text,
      "purchaseUrl": urlController.text,
      "buttonName": buttonNameController.text,
      "closeUp": Constants.closeUp,
      "medium": Constants.medium,
      "long": Constants.long,
      "pose1": Constants.pose1,
      "pose2": Constants.pose2,
      "additional": Constants.additional,
      "video": widget.screenTwoData!['video'] != null
          ? widget.screenTwoData!['video']!.path
          : null,
    };

    Navigator.pop(context, map);
  }
}
