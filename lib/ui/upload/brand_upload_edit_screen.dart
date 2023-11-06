import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:famelink/databse/AppDatabase.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/main.dart';
import 'package:famelink/models/ChallengesResponse.dart';
import 'package:famelink/models/Profile_Model.dart';
import 'package:famelink/models/store_model.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_trimmer/video_trimmer.dart';


class BrandUploadEditScreen extends StatefulWidget {
  Store? myFameResult;

  BrandUploadEditScreen({this.myFameResult});

  @override
  _BrandUploadEditScreenState createState() => _BrandUploadEditScreenState();
}

class _BrandUploadEditScreenState extends State<BrandUploadEditScreen> {
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

  MyProfileResult? upperProfileData;

  String age = "";

  bool isVideo = false;

  String closeUp = "";

  String medium = "";

  String long = "";

  String pose1 = "";

  String pose2 = "";

  String additional = "";

  String video = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _profile();
    if (widget.myFameResult != null) {
      if (widget.myFameResult!.images!.length > 0) {
        for (int i = 0; i < widget.myFameResult!.images!.length; i++) {
          Media media = widget.myFameResult!.images!.elementAt(i);
          if (media.type == "video") {
            isVideo = true;
            video = "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${media.path}-sm";
          }
          if (!isVideo && i == 0) {
            closeUp = "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${media.path}-sm";
          }
          if (i == 1) {
            medium = "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${media.path}-sm";
          }
          if (i == 2) {
            long = "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${media.path}-sm";
          }
          if (i == 3) {
            pose1 = "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${media.path}-sm";
          }
          if (i == 4) {
            pose2 = "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${media.path}-sm";
          }
          if (i == 5) {
            additional = "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${media.path}-sm";
          }
        }
      }
      productNameController.text = widget.myFameResult!.name!;
      productPriceController.text = widget.myFameResult!.price!.toString();
      commentController.text = widget.myFameResult!.description!;
      urlController.text = widget.myFameResult!.purchaseUrl!;
      buttonNameController.text = widget.myFameResult!.buttonName!;
      tagsController.text = widget.myFameResult!.hashTag != null &&
              widget.myFameResult!.hashTag.length > 0
          ? widget.myFameResult!.hashTag.elementAt(0).name
          : "";
      setState(() {});
    }
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
                    child: isVideo
                        ? Stack(children: [
                            SizedBox(
                              height: ScreenUtil().setHeight(90),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  imageUrl: video,
                                  fit: BoxFit.cover,
                                ),
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
                            */ /*Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(8.73),
                                      bottom: ScreenUtil().setHeight(8.73)),
                                  child: InkWell(
                                    onTap: () {
                                      widget.screenTwoData['video'] = null;
                                      Constants.video = null;
                                      setState(() {});
                                    },
                                    child: SvgPicture.asset(
                                        "assets/icons/svg/delete.svg",
                                        height: ScreenUtil().setSp(15),
                                        width: ScreenUtil().setSp(15)),
                                  )),
                            )*/ /*
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
                  ),*/
                  //closeup
                  Container(
                    width: ScreenUtil().setWidth(50),
                    height: ScreenUtil().setHeight(90),
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setSp(5),
                        right: ScreenUtil().setSp(5)),
                    child: closeUp.isNotEmpty
                        ? Stack(children: [
                            SizedBox(
                              height: ScreenUtil().setHeight(90),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child:
                                    Image.network(closeUp, fit: BoxFit.cover),
                              ),
                            ),
                            /*Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(8.73),
                                      bottom: ScreenUtil().setHeight(8.73)),
                                  child: InkWell(
                                    onTap: () {
                                      widget.screenTwoData['closeUp'] = null;
                                      Constants.closeUp = null;
                                      setState(() {});
                                    },
                                    child: SvgPicture.asset(
                                        "assets/icons/svg/delete.svg",
                                        height: ScreenUtil().setSp(15),
                                        width: ScreenUtil().setSp(15)),
                                  )),
                            )*/
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
                    child: medium.isNotEmpty
                        ? Stack(children: [
                            SizedBox(
                              height: ScreenUtil().setHeight(90),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(medium, fit: BoxFit.cover),
                              ),
                            ),
                            /*Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(8.73),
                                      bottom: ScreenUtil().setHeight(8.73)),
                                  child: InkWell(
                                    onTap: () {
                                      widget.screenTwoData['medium'] = null;
                                      Constants.medium = null;
                                      setState(() {});
                                    },
                                    child: SvgPicture.asset(
                                        "assets/icons/svg/delete.svg",
                                        height: ScreenUtil().setSp(15),
                                        width: ScreenUtil().setSp(15)),
                                  )),
                            )*/
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
                    child: long.isNotEmpty
                        ? Stack(children: [
                            SizedBox(
                              height: ScreenUtil().setHeight(90),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(long, fit: BoxFit.cover),
                              ),
                            ),
                            /*Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(8.73),
                                      bottom: ScreenUtil().setHeight(8.73)),
                                  child: InkWell(
                                    onTap: () {
                                      widget.screenTwoData['long'] = null;
                                      Constants.long = null;
                                      setState(() {});
                                    },
                                    child: SvgPicture.asset(
                                        "assets/icons/svg/delete.svg",
                                        height: ScreenUtil().setSp(15),
                                        width: ScreenUtil().setSp(15)),
                                  )),
                            )*/
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
                    child: pose1.isNotEmpty
                        ? Stack(children: [
                            SizedBox(
                              height: ScreenUtil().setHeight(90),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(pose1, fit: BoxFit.cover),
                              ),
                            ),
                            /*Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(8.73),
                                      bottom: ScreenUtil().setHeight(8.73)),
                                  child: InkWell(
                                    onTap: () {
                                      widget.screenTwoData['pose1'] = null;
                                      Constants.pose1 = null;
                                      setState(() {});
                                    },
                                    child: SvgPicture.asset(
                                        "assets/icons/svg/delete.svg",
                                        height: ScreenUtil().setSp(15),
                                        width: ScreenUtil().setSp(15)),
                                  )),
                            )*/
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
                    child: pose2.isNotEmpty
                        ? Stack(children: [
                            SizedBox(
                              height: ScreenUtil().setHeight(90),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(pose2, fit: BoxFit.cover),
                              ),
                            ),
                            /*Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(8.73),
                                      bottom: ScreenUtil().setHeight(8.73)),
                                  child: InkWell(
                                    onTap: () {
                                      widget.screenTwoData['pose2'] = null;
                                      Constants.pose2 = null;
                                      setState(() {});
                                    },
                                    child: SvgPicture.asset(
                                        "assets/icons/svg/delete.svg",
                                        height: ScreenUtil().setSp(15),
                                        width: ScreenUtil().setSp(15)),
                                  )),
                            )*/
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
                    child: additional.isNotEmpty
                        ? Stack(children: [
                            SizedBox(
                              height: ScreenUtil().setHeight(90),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(additional,
                                    fit: BoxFit.cover),
                              ),
                            ),
                            /*Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(8.73),
                                      bottom: ScreenUtil().setHeight(8.73)),
                                  child: InkWell(
                                    onTap: () {
                                      widget.screenTwoData['additional'] = null;
                                      Constants.additional = null;
                                      setState(() {});
                                    },
                                    child: SvgPicture.asset(
                                        "assets/icons/svg/delete.svg",
                                        height: ScreenUtil().setSp(15),
                                        width: ScreenUtil().setSp(15)),
                                  )),
                            )*/
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
                  /* Container(
                    width: ScreenUtil().setWidth(50),
                    height: ScreenUtil().setHeight(90),
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setSp(5),
                        right: ScreenUtil().setSp(5)),
                  ),*/
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil().setSp(38.42),
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
                      ),
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
                  top: ScreenUtil().setSp(26),
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
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
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
            ),
            Container(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(38),
                  right: ScreenUtil().setWidth(38)),
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
              child: TextFormField(
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.done,
                style: GoogleFonts.nunitoSans(
                    fontSize: ScreenUtil().setSp(12),
                    color: black,
                    fontWeight: FontWeight.w400),
                controller: buttonNameController,
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(10),
                ],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      bottom: ScreenUtil().setHeight(2),
                      top: ScreenUtil().setHeight(0)),
                  hintText: 'Button Name (max 10 characters including spaces)',
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
            ),
            Container(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(38),
                  right: ScreenUtil().setWidth(38)),
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
              child: TextFormField(
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.done,
                style: GoogleFonts.nunitoSans(
                    fontSize: ScreenUtil().setSp(12),
                    color: black,
                    fontWeight: FontWeight.w400),
                controller: tagsController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      bottom: ScreenUtil().setHeight(2),
                      top: ScreenUtil().setHeight(0)),
                  prefixText: '#',
                  hintText: 'TagName',
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
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: ScreenUtil().setSp(38)),
                child: Text(
                  "[users will see this tag in FollowLinks & FunLinks]",
                  style: GoogleFonts.nunitoSans(
                      color: buttonBlue,
                      fontWeight: FontWeight.w300,
                      fontSize: ScreenUtil().setSp(10)),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                if (productNameController.text.isEmpty) {
                  var snackBar = SnackBar(
                    content: Text('Enter Product Name'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (productPriceController.text.isEmpty) {
                  var snackBar = SnackBar(
                    content: Text('Enter Product Price'),
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
          ],
        ),
      ),
    );
  }

  _profile() async {
    Api.get.call(context, method: "users/me", param: {},
        onResponseSuccess: (Map<dynamic,dynamic> object) async {
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
      "tags": tagsController.text,
      "description": commentController.text,
      "name": productNameController.text,
      "price": productPriceController.text,
      "purchaseUrl": urlController.text,
      "buttonName": buttonNameController.text,
    };

    Navigator.pop(context, map);
  }
}
