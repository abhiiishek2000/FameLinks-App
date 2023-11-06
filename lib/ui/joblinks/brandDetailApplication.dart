import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/dio/api/apimanager.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/joblinks/applicantsPost.dart';
import 'package:famelink/ui/joblinks/models/ApplicantsModel.dart';
import 'package:famelink/ui/joblinks/reportDialog.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';

class BrandDetailApplication extends StatefulWidget {
  dynamic id;
  String? title;
  String? type;
  String? jobType;
  BrandDetailApplication({this.id, this.title, this.type, this.jobType});

  @override
  State<BrandDetailApplication> createState() => _BrandDetailApplicationState();
}

class _BrandDetailApplicationState extends State<BrandDetailApplication> {
  int page = 1;
  ScrollController fameScrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  List<Applicants> applicantsList = <Applicants>[];
  bool isSearch = false;
  bool isFilter = false;
  bool isExpanded = true;
  int ftCount = 0;
  int inCount = 0;
  TextEditingController ftController = TextEditingController();
  TextEditingController inController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bustController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController hipController = TextEditingController();
  TextEditingController eyeController = TextEditingController();
  String? strWorkExp;
  List exp = ['Fresher', 'Experienced'];
  String? strComplexion;
  List complexion = ['Very Fair', 'fair', 'Light', 'Medium', 'Dark'];
  List<VideoPlayerController> _controller = [];

  @override
  void initState() {
    super.initState();
    fameScrollController.addListener(() {
      if (fameScrollController.position.maxScrollExtent ==
          fameScrollController.position.pixels) {
        page++;
      }
    });
    getApplicants(widget.id);
  }

  getApplicants(id) async {
    Map<String, dynamic> param = {
      "page": page.toString(),
    };
    Api.get.call(context,
        method: "joblinks/applicants/$id",
        param: param,
        isLoading: false, onResponseSuccess: (Map<dynamic, dynamic> object) {
      var result = ApplicantsModel.fromJson(object);
      if (result.result!.length > 0) {
        applicantsList.addAll(result.result!);
        for (var item in applicantsList[0].applicants!) {
          if (item.status == 'shortlisted') {
            item.isShortlisted = true;
            item.isHired = false;
          } else if (item.status == 'hired') {
            item.isHired = true;
            item.isShortlisted = false;
          } else {
            item.isShortlisted = false;
            item.isHired = false;
          }

          _controller.add(VideoPlayerController.network(
              '${ApiProvider.joblinks}${item.greetVideo}')
            ..addListener(() {
              for (var items in _controller) {
                if (items.value.position == items.value.duration) {
                  print('video Ended');
                  if (mounted) {
                    setState(() {
                      item.isPlaying = false;
                    });
                  }
                }
              }
            })
            ..initialize());
        }
        setState(() {});
      } else {
        page == 1 ? page : page--;
      }
    });
  }

  Future<void> shortlist(jobId, userId, bool val, index) async {
    Map<String, dynamic> param = {
      "jobId": '"$jobId"',
      "userId": '"$userId"',
      "shortlist": val.toString(),
    };

    await ApiManager.post(param: param, url1: "joblinks/shortlist")
        .then((value) async {
      if (value.statusCode == 200) {
        setState(() {
          applicantsList[0].applicants![index].isShortlisted = val;
        });
      } else {
        print(value);
      }
    });
  }

  Future<void> hire(jobId, userId, bool val, index) async {
    Map<String, dynamic> param = {
      "jobId": '"$jobId"',
      "userId": '"$userId"',
      "closeJob": val.toString(),
    };

    await ApiManager.post(param: param, url1: "joblinks/hire")
        .then((value) async {
      if (value.statusCode == 200) {
        setState(() {
          Navigator.pop(context);
          applicantsList[0].applicants![index].isHired = val;
        });
      } else {
        print(value);
      }
    });
  }

  String capitalize(val) {
    return val[0].toString().toUpperCase() + val.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: applicantsList.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                color: black,
                strokeWidth: 3,
              ))
            : Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 12.w, top: 10.h),
                          child: Icon(Icons.arrow_back_ios_new_rounded,
                              color: black, size: 25),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 78.w,
                          child: Text(
                            "${capitalize(widget.title)}",
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                // height: 0.19,
                                color: black),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            color: white, size: 25),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  widget.type == 'closed'
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(left: 12.w, right: 12.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "(0 Hired)",
                                style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(10),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                    height: 0.13,
                                    color: white),
                              ),
                              Spacer(),
                              Text(
                                "(${applicantsList[0].newApplicants} new / total ${applicantsList[0].totalApplicants})",
                                style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(10),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                    height: 0.13,
                                    color: Color(0xff0060FF)),
                              ),
                              Spacer(),
                              Text(
                                "(${applicantsList[0].hired} Hired)",
                                style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(10),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                    height: 0.13,
                                    color: black),
                              ),
                            ],
                          ),
                        ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 18.w, right: 12.w, bottom: 15.h),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/svg/bookmark.svg",
                            color: darkGray),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(bottom: 3.h),
                          child:
                              SvgPicture.asset("assets/icons/svg/filter1.svg"),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isFilter = false;
                              isSearch = !isSearch;
                              if (isSearch == false) {
                                getApplicants(widget.id);
                              }
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 3.h),
                            child: SvgPicture.asset(
                                "assets/icons/svg/search.svg",
                                color: Color.fromARGB(255, 113, 115, 129),
                                height: 16.5.h,
                                width: 16.5.w),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                            onTap: () {
                              setState(() {
                                isFilter = !isFilter;
                                isSearch = false;
                                if (isFilter == false) {
                                  getApplicants(widget.id);
                                }
                              });
                            },
                            child: SvgPicture.asset(
                                "assets/icons/svg/jobfilter.svg",
                                color: darkGray,
                                height: 20.h,
                                width: 20.w)),
                        Spacer(),
                        Spacer(),
                        Spacer(),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isExpanded = false;
                              for (var item in applicantsList[0].applicants!) {
                                item.isSwipe = true;
                              }
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 3.h),
                            child: isExpanded == true
                                ? SvgPicture.asset(
                                    "assets/icons/svg/expand.svg",
                                    color: darkGray)
                                : SvgPicture.asset(
                                    "assets/icons/svg/selectedExpand.svg",
                                    color: darkGray),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isExpanded = true;
                              for (var item in applicantsList[0].applicants!) {
                                item.isSwipe = false;
                              }
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 3.h),
                            child: isExpanded == false
                                ? SvgPicture.asset(
                                    "assets/icons/svg/collaspe.svg",
                                    color: darkGray)
                                : SvgPicture.asset(
                                    "assets/icons/svg/selectedCollapsed.svg",
                                    color: darkGray),
                          ),
                        ),
                      ],
                    ),
                  ),
                  isSearch == false && isFilter == false
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(
                              top: 10.h, bottom: 10.h, right: 12.w, left: 12.w),
                          child: isSearch == true
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().radius(8)),
                                    color: Colors.white,
                                  ),
                                  child: TextFormField(
                                    onChanged: (val) {
                                      page = 1;
                                      if (val.length >= 3) {
                                        // getData(val);
                                      } else if (val.length == 0) {
                                        // getData('');
                                      }
                                    },
                                    controller: searchController,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    cursorColor: black,
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(14),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xff9B9B9B)),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(
                                            ScreenUtil().setWidth(10)),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().radius(10)),
                                          borderSide: BorderSide(
                                              color: Color(0xff9B9B9B),
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().radius(10)),
                                          borderSide: BorderSide(
                                              color: lightRed, width: 1),
                                        ),
                                        suffixIcon: Image.asset(
                                            "assets/icons/search.png",
                                            color: Color(0xff9B9B9B)),
                                        hintText: 'Search',
                                        hintStyle: GoogleFonts.nunitoSans(
                                            fontSize: ScreenUtil().setSp(14),
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400,
                                            color: lightGray)),
                                  ),
                                )
                              : widget.jobType == 'crew'
                                  ? Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xff9B9B9B)),
                                        borderRadius:
                                            BorderRadius.circular(7.r),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          value: strWorkExp,
                                          hint: Text(
                                            "Work Experience",
                                            style: GoogleFonts.nunitoSans(
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w400,
                                                color: lightGray),
                                          ),
                                          isExpanded: true,
                                          //customItemsHeight: 4,
                                          // buttonHeight: 54.h,
                                          // buttonWidth: double.infinity,
                                          // buttonPadding: EdgeInsets.only(
                                          //     left: 14.w, right: 14.w),
                                          // itemHeight: 42.h,
                                          // itemPadding:
                                          //     const EdgeInsets.symmetric(
                                          //         horizontal: 15.0),
                                          onChanged: (String? value) {
                                            setState(() {
                                              strWorkExp = value;
                                            });
                                          },
                                          items: exp.map((value) {
                                            return DropdownMenuItem<String>(
                                              value: value.toString(),
                                              child: Text(value.toString(),
                                                  style: GoogleFonts.nunitoSans(
                                                      fontSize: ScreenUtil()
                                                          .setSp(14),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: lightGray)),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    )
                                  : Column(children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: ftController,
                                              keyboardType:
                                                  TextInputType.number,
                                              style: GoogleFonts.nunitoSans(
                                                  fontSize:
                                                      ScreenUtil().setSp(14),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.italic,
                                                  color: Color(0xff9B9B9B)),
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              decoration: InputDecoration(
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 1.w),
                                                  ),
                                                  errorStyle: TextStyle(
                                                      height: 0),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xff9B9B9B),
                                                        width: 1),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 1.w),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: lightRed,
                                                        width: 1),
                                                  ),
                                                  contentPadding: EdgeInsets
                                                      .only(
                                                          top: ScreenUtil()
                                                              .setWidth(10),
                                                          left: ScreenUtil()
                                                              .setWidth(10)),
                                                  suffixIcon: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: ScreenUtil()
                                                            .setHeight(3)),
                                                    child: Column(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              ftCount++;
                                                              ftController
                                                                      .text =
                                                                  ftCount
                                                                      .toString();
                                                            });
                                                          },
                                                          child: Container(
                                                              height: 20,
                                                              width: 20,
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_drop_up_outlined,
                                                                color:
                                                                    lightGray,
                                                              )),
                                                        ),
                                                        InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                if (ftCount !=
                                                                    1) {
                                                                  ftCount--;
                                                                  ftController
                                                                          .text =
                                                                      ftCount
                                                                          .toString();
                                                                }
                                                              });
                                                            },
                                                            child: Container(
                                                                height: 20,
                                                                width: 20,
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_drop_down_sharp,
                                                                  color:
                                                                      lightGray,
                                                                ))),
                                                      ],
                                                    ),
                                                  ),
                                                  hintText: 'ft.',
                                                  hintStyle:
                                                      GoogleFonts.nunitoSans(
                                                          fontSize:
                                                              ScreenUtil()
                                                                  .setSp(14),
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: lightGray)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              controller: inController,
                                              keyboardType:
                                                  TextInputType.number,
                                              style: GoogleFonts.nunitoSans(
                                                  fontSize:
                                                      ScreenUtil().setSp(14),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.italic,
                                                  color: Color(0xff9B9B9B)),
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              decoration: InputDecoration(
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 1.w),
                                                  ),
                                                  errorStyle: TextStyle(
                                                      height: 0),
                                                  contentPadding: EdgeInsets
                                                      .only(
                                                          top: ScreenUtil()
                                                              .setWidth(10),
                                                          left:
                                                              ScreenUtil()
                                                                  .setWidth(
                                                                      10)),
                                                  suffixIcon: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: ScreenUtil()
                                                            .setHeight(3)),
                                                    child: Column(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              inCount++;
                                                              inController
                                                                      .text =
                                                                  inCount
                                                                      .toString();
                                                            });
                                                          },
                                                          child: Container(
                                                              height: 20,
                                                              width: 20,
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_drop_up_outlined,
                                                                color:
                                                                    lightGray,
                                                              )),
                                                        ),
                                                        InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                if (inCount !=
                                                                    1) {
                                                                  inCount--;
                                                                  inController
                                                                          .text =
                                                                      inCount
                                                                          .toString();
                                                                }
                                                              });
                                                            },
                                                            child: Container(
                                                                height: 20,
                                                                width: 20,
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_drop_down_sharp,
                                                                  color:
                                                                      lightGray,
                                                                ))),
                                                      ],
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xff9B9B9B),
                                                        width: 1),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 1.w),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: lightRed,
                                                        width: 1),
                                                  ),
                                                  hintText: 'in.',
                                                  hintStyle:
                                                      GoogleFonts.nunitoSans(
                                                          fontSize: ScreenUtil()
                                                              .setSp(14),
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: lightGray)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: TextFormField(
                                              controller: weightController,
                                              keyboardType:
                                                  TextInputType.number,
                                              style: GoogleFonts.nunitoSans(
                                                  fontSize:
                                                      ScreenUtil().setSp(14),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.italic,
                                                  color: Color(0xff9B9B9B)),
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              decoration: InputDecoration(
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 1.w),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 1.w),
                                                  ),
                                                  errorStyle: TextStyle(
                                                      height: 0),
                                                  contentPadding: EdgeInsets
                                                      .all(ScreenUtil()
                                                          .setWidth(10)),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xff9B9B9B),
                                                        width: 1),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: lightRed,
                                                        width: 1),
                                                  ),
                                                  hintText: 'Weight (kg)',
                                                  hintStyle:
                                                      GoogleFonts.nunitoSans(
                                                          fontSize:
                                                              ScreenUtil()
                                                                  .setSp(14),
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: lightGray)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: ScreenUtil().setWidth(12)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller: bustController,
                                                keyboardType:
                                                    TextInputType.number,
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize:
                                                        ScreenUtil().setSp(14),
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.italic,
                                                    color: Color(0xff9B9B9B)),
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                decoration: InputDecoration(
                                                    errorStyle: TextStyle(
                                                        height: 0),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.red,
                                                          width: 1.w),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.red,
                                                          width: 1.w),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: lightGray,
                                                          width: 1.w),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: lightRed,
                                                          width: 1),
                                                    ),
                                                    contentPadding: EdgeInsets
                                                        .all(
                                                            ScreenUtil()
                                                                .setWidth(10)),
                                                    hintText: 'Bust (cm)',
                                                    hintStyle:
                                                        GoogleFonts.nunitoSans(
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(14),
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: lightGray)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: TextFormField(
                                                controller: waistController,
                                                keyboardType:
                                                    TextInputType.number,
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize:
                                                        ScreenUtil().setSp(14),
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.italic,
                                                    color: Color(0xff9B9B9B)),
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                decoration: InputDecoration(
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.red,
                                                          width: 1.w),
                                                    ),
                                                    errorStyle: TextStyle(
                                                        height: 0),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.red,
                                                          width: 1.w),
                                                    ),
                                                    contentPadding: EdgeInsets
                                                        .all(
                                                            ScreenUtil()
                                                                .setWidth(10)),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xff9B9B9B),
                                                          width: 1),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: lightRed,
                                                          width: 1),
                                                    ),
                                                    hintText: 'Waist (cm)',
                                                    hintStyle:
                                                        GoogleFonts.nunitoSans(
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(14),
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: lightGray)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: TextFormField(
                                                controller: hipController,
                                                keyboardType:
                                                    TextInputType.number,
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize:
                                                        ScreenUtil().setSp(14),
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.italic,
                                                    color: Color(0xff9B9B9B)),
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                decoration: InputDecoration(
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.red,
                                                          width: 1.w),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.red,
                                                          width: 1.w),
                                                    ),
                                                    errorStyle: TextStyle(
                                                        height: 0),
                                                    contentPadding: EdgeInsets
                                                        .all(
                                                            ScreenUtil()
                                                                .setWidth(10)),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xff9B9B9B),
                                                          width: 1),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: lightRed,
                                                          width: 1),
                                                    ),
                                                    hintText: 'Hip (cm)',
                                                    hintStyle:
                                                        GoogleFonts.nunitoSans(
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(14),
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: lightGray)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: ScreenUtil().setWidth(12)),
                                        child: TextFormField(
                                          onChanged: (_) {},
                                          controller: eyeController,
                                          keyboardType: TextInputType.name,
                                          style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(14),
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.italic,
                                              color: Color(0xff9B9B9B)),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          decoration: InputDecoration(
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red,
                                                    width: 1.w),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red,
                                                    width: 1.w),
                                              ),
                                              contentPadding: EdgeInsets.all(
                                                  ScreenUtil().setWidth(10)),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xff9B9B9B),
                                                    width: 1),
                                              ),
                                              errorStyle: TextStyle(height: 0),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: lightRed, width: 1),
                                              ),
                                              suffixIcon: Icon(
                                                Icons.remove_red_eye_outlined,
                                                color: Color(0xff0060FF),
                                              ),
                                              hintText: 'Eye Color',
                                              hintStyle: GoogleFonts.nunitoSans(
                                                  fontSize:
                                                      ScreenUtil().setSp(14),
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.w400,
                                                  color: lightGray)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: ScreenUtil().setWidth(12)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xff9B9B9B)),
                                            borderRadius:
                                                BorderRadius.circular(7.r),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              value: strComplexion,
                                              hint: Text(
                                                "Complexion",
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize:
                                                        ScreenUtil().setSp(14),
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.w400,
                                                    color: lightGray),
                                              ),
                                              // icon: Image.asset(
                                              //     "assets/images/FameProfileTrendz.png"),
                                              isExpanded: true,
                                              //customItemsHeight: 4,
                                              // buttonHeight: 54.h,
                                              // buttonWidth: double.infinity,
                                              // buttonPadding: EdgeInsets.only(
                                              //     left: 14.w, right: 14.w),
                                              // itemHeight: 42.h,
                                              // itemPadding:
                                              //     const EdgeInsets.symmetric(
                                              //         horizontal: 15.0),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  strComplexion = value;
                                                });
                                              },
                                              items: complexion.map((value) {
                                                return DropdownMenuItem<String>(
                                                  value: value.toString(),
                                                  child: Text(value.toString(),
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          14),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  lightGray)),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20.h),
                                      InkWell(
                                        onTap: () {
                                          if (ftController.text != '' ||
                                              inController.text != '' ||
                                              weightController.text != '' ||
                                              bustController.text != '' ||
                                              waistController.text != '' ||
                                              hipController.text != '' ||
                                              eyeController.text != '' ||
                                              strComplexion != null) {
                                            setState(() {
                                              isFilter = false;
                                            });
                                          } else {
                                            setState(() {
                                              var snackBar = SnackBar(
                                                content:
                                                    Text('Please add details'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: 40.h,
                                          width: 130.w,
                                          decoration: BoxDecoration(
                                            color: white.withOpacity(0.6),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border:
                                                Border.all(color: lightGray),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Apply Filter',
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w600,
                                                color: black,
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                        ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 12.w, right: 12.w, top: 15.h),
                        child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            padding: EdgeInsets.zero,
                            itemCount: applicantsList[0].applicants!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 15.h),
                                child: Material(
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.black.withAlpha(40)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: white.withOpacity(0.6),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color:
                                                    Colors.black.withAlpha(40)),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color(0xffFFA88C)
                                                    .withOpacity(0.5),
                                                Color(0xffFF5C28)
                                                    .withOpacity(0.6)
                                              ],
                                              stops: [0.0, 1.0],
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: ScreenUtil().setWidth(15),
                                                right:
                                                    ScreenUtil().setWidth(15),
                                                top: ScreenUtil().setHeight(13),
                                                bottom:
                                                    ScreenUtil().setHeight(5)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CachedNetworkImage(
                                                        imageUrl: applicantsList[
                                                                        0]
                                                                    .applicants![
                                                                        index]
                                                                    .profileImageType ==
                                                                'avatar'
                                                            ? '${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${applicantsList[0].applicants![index].profileImage}'
                                                            : '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${applicantsList[0].applicants![index].profileImage}',
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          width: 60.h,
                                                          height: 60.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                        errorWidget: (context,
                                                            url, error) {
                                                          print(
                                                              "ER::${error.toString()}");
                                                          return applicantsList[
                                                                      0]
                                                                  .applicants![
                                                                      index]
                                                                  .name!
                                                                  .isEmpty
                                                              ? Icon(
                                                                  Icons
                                                                      .error_outline_rounded,
                                                                  color: black)
                                                              : Container(
                                                                  height: 60.h,
                                                                  width: 60.w,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: darkBlue
                                                                        .withOpacity(
                                                                            0.8),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      applicantsList[0]
                                                                          .applicants![
                                                                              index]
                                                                          .name![
                                                                              0]
                                                                          .toString()
                                                                          .toUpperCase(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts
                                                                          .nunitoSans(
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        color:
                                                                            white,
                                                                        fontSize:
                                                                            ScreenUtil().setSp(20),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                        },
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    downloadProgress) =>
                                                                SvgPicture
                                                                    .asset(
                                                          "assets/icons/svg/icon.svg",
                                                          height: 60.h,
                                                          width: 60.w,
                                                        ),
                                                        fit: BoxFit.cover,
                                                        height: ScreenUtil()
                                                            .setHeight(60),
                                                        width: ScreenUtil()
                                                            .setWidth(60),
                                                      ),
                                                      SizedBox(
                                                        width: ScreenUtil()
                                                            .setWidth(12),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '${capitalize(applicantsList[0].applicants![index].name)}, ${applicantsList[0].applicants![index].masterProfile!.age} yrs',
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: black,
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          14),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                capitalize(applicantsList[
                                                                        0]
                                                                    .applicants![
                                                                        index]
                                                                    .masterProfile!
                                                                    .username),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: GoogleFonts
                                                                    .nunitoSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                      0xff0060FF),
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              12),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 8.w,
                                                              ),
                                                              Text(
                                                                "${applicantsList[0].applicants![index].masterProfile!.followersCount} k Followers",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: GoogleFonts
                                                                    .nunitoSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: black,
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              12),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 4),
                                                          Text(
                                                            applicantsList[0]
                                                                    .applicants![
                                                                        index]
                                                                    .masterProfile!
                                                                    .achievements ??
                                                                "",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: orange,
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          10),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacer(),
                                                      Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            SizedBox(
                                                                height: 4.h),
                                                            Text(
                                                              timeago.format(
                                                                  applicantsList[
                                                                          0]
                                                                      .applicants![
                                                                          index]
                                                                      .updatedAt!),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: GoogleFonts
                                                                  .nunitoSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: darkGray,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            10),
                                                              ),
                                                            ),
                                                            InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    showGeneralDialog(
                                                                        context:
                                                                            context,
                                                                        pageBuilder: (BuildContext buildContext,
                                                                            Animation
                                                                                animation,
                                                                            Animation
                                                                                secondaryAnimation) {
                                                                          return ReportDialog(
                                                                              applicantsList[0].applicants![index].masterProfile!.id!,
                                                                              'talent');
                                                                        });
                                                                  });
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          top: 2.5
                                                                              .h),
                                                                  child: Icon(
                                                                      Icons
                                                                          .more_vert,
                                                                      color:
                                                                          lightGray,
                                                                      size:
                                                                          15.r),
                                                                ))
                                                          ])
                                                    ]),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      applicantsList[0]
                                                                  .applicants![
                                                                      index]
                                                                  .isSwipe ==
                                                              true
                                                          ? InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  applicantsList[
                                                                          0]
                                                                      .applicants![
                                                                          index]
                                                                      .isSwipe = false;
                                                                });
                                                              },
                                                              child: Icon(
                                                                  Icons
                                                                      .keyboard_arrow_up_rounded,
                                                                  color:
                                                                      lightGray))
                                                          : InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  applicantsList[
                                                                          0]
                                                                      .applicants![
                                                                          index]
                                                                      .isSwipe = true;
                                                                });
                                                              },
                                                              child: Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down_rounded,
                                                                  color:
                                                                      lightGray)),
                                                    ])
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 25.h),
                                        applicantsList[0]
                                                    .applicants![index]
                                                    .isSwipe ==
                                                false
                                            ? Container()
                                            : applicantsList[0]
                                                        .applicants![index]
                                                        .hiringProfile!
                                                        .height !=
                                                    null
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 12.w,
                                                        right: 12.w),
                                                    child: Row(children: [
                                                      Text(
                                                        'Height: ',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: black,
                                                          fontSize: ScreenUtil()
                                                              .setSp(12),
                                                          height: 0.22,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${applicantsList[0].applicants![index].hiringProfile!.height!.foot.toString()}’ ${applicantsList[0].applicants![index].hiringProfile!.height!.inch.toString()}”',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: black,
                                                          fontSize: ScreenUtil()
                                                              .setSp(12),
                                                          height: 0.22,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        'Weight: ',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: black,
                                                          fontSize: ScreenUtil()
                                                              .setSp(12),
                                                          height: 0.22,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${applicantsList[0].applicants![index].hiringProfile!.weight.toString()}kg',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: black,
                                                          fontSize: ScreenUtil()
                                                              .setSp(12),
                                                          height: 0.22,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        'Vitals: ',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: black,
                                                          fontSize: ScreenUtil()
                                                              .setSp(12),
                                                          height: 0.22,
                                                        ),
                                                      ),
                                                      Text(
                                                        'B ${applicantsList[0].applicants![index].hiringProfile!.bust.toString()}, W ${applicantsList[0].applicants![index].hiringProfile!.waist.toString()}, H ${applicantsList[0].applicants![index].hiringProfile!.hip.toString()}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: black,
                                                          fontSize: ScreenUtil()
                                                              .setSp(12),
                                                          height: 0.22,
                                                        ),
                                                      ),
                                                    ]),
                                                  )
                                                : Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 12.w,
                                                        right: 12.w),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Work Experience: ',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: black,
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          12),
                                                              height: 0.22,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: 12.h),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 2.w),
                                                            child: Text(
                                                              applicantsList[0]
                                                                  .applicants![
                                                                      index]
                                                                  .hiringProfile!
                                                                  .workExperience!,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts
                                                                  .nunitoSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: black,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            12),
                                                                height: 0.22,
                                                              ),
                                                            ),
                                                          ),
                                                        ]),
                                                  ),
                                        applicantsList[0]
                                                    .applicants![index]
                                                    .isSwipe ==
                                                false
                                            ? Container()
                                            : applicantsList[0]
                                                        .applicants![index]
                                                        .hiringProfile!
                                                        .height !=
                                                    null
                                                ? SizedBox(height: 15.h)
                                                : Container(),
                                        applicantsList[0]
                                                    .applicants![index]
                                                    .isSwipe ==
                                                false
                                            ? Container()
                                            : applicantsList[0]
                                                        .applicants![index]
                                                        .hiringProfile!
                                                        .height !=
                                                    null
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 12.w,
                                                        right: 12.w),
                                                    child: Row(children: [
                                                      Text(
                                                        'Eye Color: ',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: black,
                                                          fontSize: ScreenUtil()
                                                              .setSp(12),
                                                          height: 0.22,
                                                        ),
                                                      ),
                                                      Text(
                                                        applicantsList[0]
                                                                .applicants![
                                                                    index]
                                                                .hiringProfile!
                                                                .eyeColor ??
                                                            "",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: black,
                                                          fontSize: ScreenUtil()
                                                              .setSp(12),
                                                          height: 0.22,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        'Complexion: ',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: black,
                                                          fontSize: ScreenUtil()
                                                              .setSp(12),
                                                          height: 0.22,
                                                        ),
                                                      ),
                                                      Text(
                                                        applicantsList[0]
                                                                .applicants![
                                                                    index]
                                                                .hiringProfile!
                                                                .complexion ??
                                                            "",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: black,
                                                          fontSize: ScreenUtil()
                                                              .setSp(12),
                                                          height: 0.22,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                    ]),
                                                  )
                                                : Container(),
                                        applicantsList[0]
                                                    .applicants![index]
                                                    .isSwipe ==
                                                false
                                            ? Container()
                                            : Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10.w,
                                                    right: 12.w,
                                                    top: 20.h,
                                                    bottom: 20.h),
                                                child: applicantsList[0]
                                                                .applicants![
                                                                    index]
                                                                .posts ==
                                                            null ||
                                                        applicantsList[0]
                                                                .applicants![
                                                                    index]
                                                                .posts!
                                                                .length ==
                                                            0
                                                    ? Container()
                                                    : Container(
                                                        height: 110.h,
                                                        child: ListView.builder(
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            itemCount: 1,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            physics:
                                                                ClampingScrollPhysics(),
                                                            itemBuilder:
                                                                (context, i) {
                                                              return Container(
                                                                  height: 110.h,
                                                                  child: Row(
                                                                    children: [
                                                                      applicantsList[0].applicants![index].greetVideo == '' ||
                                                                              applicantsList[0].applicants![index].greetVideo == null
                                                                          ? Container()
                                                                          : Padding(
                                                                              padding: EdgeInsets.only(right: 10.w),
                                                                              child: Container(
                                                                                height: ScreenUtil().setHeight(112),
                                                                                width: ScreenUtil().setWidth(110),
                                                                                child: Stack(
                                                                                  children: [
                                                                                    Image.asset("assets/icons/rect.png"),
                                                                                    Positioned(
                                                                                      top: 9.h,
                                                                                      left: 7.w,
                                                                                      child: Container(
                                                                                        height: 91.h,
                                                                                        width: 91.w,
                                                                                        child: _controller[index].value.isInitialized ? VideoPlayer(_controller[index]) : Container(),
                                                                                      ),
                                                                                    ),
                                                                                    InkWell(
                                                                                      onTap: () {
                                                                                        setState(() {
                                                                                          showGeneralDialog(
                                                                                              context: context,
                                                                                              pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
                                                                                                return ApplicantsPost(index: index, index1: 0, applicantsList: applicantsList, controller: _controller);
                                                                                              });
                                                                                        });
                                                                                      },
                                                                                      child: Center(
                                                                                        child: Container(
                                                                                          height: 40.h,
                                                                                          width: 40.w,
                                                                                          decoration: BoxDecoration(color: Colors.transparent, shape: BoxShape.circle, border: Border.all(color: white.withOpacity(0.5), width: 2.w)),
                                                                                          child: Icon(Icons.play_arrow, color: white.withOpacity(0.5)),
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                      ListView.builder(
                                                                          primary: false,
                                                                          shrinkWrap: true,
                                                                          itemCount: applicantsList[0].applicants![index].posts!.length,
                                                                          scrollDirection: Axis.horizontal,
                                                                          physics: ClampingScrollPhysics(),
                                                                          itemBuilder: (context, i) {
                                                                            return InkWell(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  showGeneralDialog(
                                                                                      context: context,
                                                                                      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
                                                                                        return ApplicantsPost(index: index, index1: i, applicantsList: applicantsList, controller: _controller);
                                                                                      });
                                                                                });
                                                                              },
                                                                              child: Padding(
                                                                                padding: EdgeInsets.only(right: 10.w),
                                                                                child: Container(
                                                                                  height: ScreenUtil().setHeight(116),
                                                                                  width: ScreenUtil().setWidth(116),
                                                                                  child: CachedNetworkImage(
                                                                                    imageUrl: applicantsList[0].applicants![index].posts![i].closeUp != null
                                                                                        ? '${ApiProvider.famelinks}/${applicantsList[0].applicants![index].posts![i].closeUp}'
                                                                                        : applicantsList[0].applicants![index].posts![i].medium != null
                                                                                            ? '${ApiProvider.famelinks}/${applicantsList[0].applicants![index].posts![i].medium}'
                                                                                            : applicantsList[0].applicants![index].posts![i].long != null
                                                                                                ? '${ApiProvider.famelinks}/${applicantsList[0].applicants![index].posts![i].long}'
                                                                                                : applicantsList[0].applicants![index].posts![i].pose1 != null
                                                                                                    ? '${ApiProvider.famelinks}/${applicantsList[0].applicants![index].posts![i].pose1}'
                                                                                                    : applicantsList[0].applicants![index].posts![i].pose2 != null
                                                                                                        ? '${ApiProvider.famelinks}/${applicantsList[0].applicants![index].posts![i].pose2}'
                                                                                                        : applicantsList[0].applicants![index].posts![i].additional != null
                                                                                                            ? '${ApiProvider.famelinks}/${applicantsList[0].applicants![index].posts![i].additional}'
                                                                                                            : '${ApiProvider.famelinks}/${applicantsList[0].applicants![index].posts![i].video}',
                                                                                    errorWidget: (context, url, error) {
                                                                                      print("ER::${error.toString()}");
                                                                                      return Icon(Icons.error, color: white);
                                                                                    },
                                                                                    fit: BoxFit.fill,
                                                                                    height: ScreenUtil().setHeight(116),
                                                                                    width: ScreenUtil().setWidth(110),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }),
                                                                    ],
                                                                  ));
                                                            }),
                                                      ),
                                              ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 12.w,
                                              right: 12.w,
                                              bottom: 20.h),
                                          child: Row(children: [
                                            widget.type == 'closed'
                                                ? Container()
                                                : InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        if (applicantsList[0]
                                                                .applicants![
                                                                    index]
                                                                .isShortlisted ==
                                                            true) {
                                                          shortlist(
                                                              applicantsList[0]
                                                                  .id,
                                                              applicantsList[0]
                                                                  .applicants![
                                                                      index]
                                                                  .id,
                                                              false,
                                                              index);
                                                        } else {
                                                          shortlist(
                                                              applicantsList[0]
                                                                  .id,
                                                              applicantsList[0]
                                                                  .applicants![
                                                                      index]
                                                                  .id,
                                                              true,
                                                              index);
                                                        }
                                                      });
                                                    },
                                                    child: applicantsList[0]
                                                                .applicants![
                                                                    index]
                                                                .isShortlisted ==
                                                            true
                                                        ? Icon(
                                                            Icons.bookmark,
                                                            color: darkGray,
                                                            size: 23.r,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .bookmark_border,
                                                            color: darkGray,
                                                            size: 23.r,
                                                          )),
                                            widget.type == 'closed'
                                                ? Container()
                                                : Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.w, top: 5.h),
                                                    child: Text(
                                                      'Shortlist',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: black,
                                                        fontSize: ScreenUtil()
                                                            .setSp(12),
                                                        height: 0.22,
                                                      ),
                                                    ),
                                                  ),
                                            Spacer(),
                                            Container(
                                              height: 30.h,
                                              width: 85.w,
                                              decoration: BoxDecoration(
                                                color: white.withOpacity(0.6),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Color(0xff7AACFF)),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Start Chat',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w600,
                                                    color: darkGray,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            widget.type == 'closed'
                                                ? Container()
                                                : InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        if (applicantsList[0]
                                                                .applicants![
                                                                    index]
                                                                .isHired ==
                                                            false) {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return Dialog(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    child: Container(
                                                                        height: 200.h,
                                                                        width: MediaQuery.of(context).size.width - 80.w,
                                                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.r)),
                                                                        child: Padding(
                                                                          padding:
                                                                              EdgeInsets.all(15.r),
                                                                          child:
                                                                              Column(children: [
                                                                            Text(
                                                                              "Congrats! you got the required talent...!",
                                                                              style: GoogleFonts.nunitoSans(fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, color: black),
                                                                            ),
                                                                            SizedBox(height: 30.h),
                                                                            Text(
                                                                              "Do you want to keep job open to hire more in the same job or close it",
                                                                              style: GoogleFonts.nunitoSans(fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w400, fontStyle: FontStyle.italic, color: black),
                                                                            ),
                                                                            SizedBox(height: 35.h),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      hire(applicantsList[0].id, applicantsList[0].applicants![index].id, false, index);
                                                                                    });
                                                                                  },
                                                                                  child: Text(
                                                                                    "Hire More",
                                                                                    style: GoogleFonts.nunitoSans(fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, color: black),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 40.w,
                                                                                ),
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    hire(applicantsList[0].id, applicantsList[0].applicants![index].id, true, index);
                                                                                  },
                                                                                  child: Text(
                                                                                    "Close Job",
                                                                                    style: GoogleFonts.nunitoSans(fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, color: darkGray),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ]),
                                                                        )));
                                                              });
                                                        } else {
                                                          var snackBar =
                                                              SnackBar(
                                                            content: Text(
                                                                'Applicant has been already hired for this job'),
                                                          );
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                        }
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 30.h,
                                                      width: 85.w,
                                                      decoration: BoxDecoration(
                                                        color: white
                                                            .withOpacity(0.6),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: lightGray),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          applicantsList[0]
                                                                      .applicants![
                                                                          index]
                                                                      .isHired ==
                                                                  true
                                                              ? 'Hired'
                                                              : 'Hire',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: darkGray,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(12),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                          ]),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  )
                ],
              ));
  }
}
