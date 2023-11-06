import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:famelink/dio/api/apimanager.dart';
import 'package:famelink/models/LocationResponse.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/joblinks/models/JobCategoriesModel.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/config/color.dart';

class HiringProfile extends StatefulWidget {
  @override
  State<HiringProfile> createState() => _HiringProfileState();
}

class _HiringProfileState extends State<HiringProfile> {
  int index = 0;
  int experienceIndex = 0;
  int ftCount = 0;
  int inCount = 0;
  static final crewKey = GlobalKey<FormState>();
  static final facesKey = GlobalKey<FormState>();

  final ApiProvider _api = ApiProvider();
  TextEditingController workController = TextEditingController();
  ScrollController workScrollController = ScrollController();
  TextEditingController awardsController = TextEditingController();
  ScrollController awardsScrollController = ScrollController();
  TextEditingController otherController = TextEditingController();

  TextEditingController locationController = TextEditingController();
  ScrollController locationScrollController = ScrollController();
  List<AddressLocation> locationList = <AddressLocation>[];
  List<AddressLocation> selectedLocationList = <AddressLocation>[];

  TextEditingController famelocationController = TextEditingController();
  ScrollController famelocationScrollController = ScrollController();
  List<AddressLocation> famelocationList = <AddressLocation>[];
  List<AddressLocation> fameselectedLocationList = <AddressLocation>[];

  List<JobCategories> categoryList = <JobCategories>[];
  List<JobCategories> searchCategoryList = <JobCategories>[];
  TextEditingController professionController = TextEditingController();
  List<JobCategories> categorySelected = <JobCategories>[];
  ScrollController categoryScrollController = ScrollController();

  List<JobCategories> fameCategoryList = <JobCategories>[];
  List<JobCategories> fameSearchCategoryList = <JobCategories>[];
  List<JobCategories> fameCategorySelected = <JobCategories>[];
  ScrollController fameCategoryScrollController = ScrollController();

  TextEditingController ftController = TextEditingController();
  TextEditingController inController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bustController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController hipController = TextEditingController();
  TextEditingController eyeController = TextEditingController();

  late String strComplexion;
  List complexion = ['Very Fair', 'fair', 'Light', 'Medium', 'Dark'];
  TextEditingController interestedController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategories();
    init();
  }

  init() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    Constants.userType = sharedPreferences.getString("type");
    if (Constants.userType == "agency") {
      setState(() {
        index = 1;
      });
    }
    setState(() {});
  }

  // Future<List<AddressLocation>?> _getAddressLocation(String query, isFrom) {
  //   List<AddressLocation> matches = <AddressLocation>[];
  //   setState(() async {
  //     if (query.length >= 3) {
  //       return await getLocation(query, isFrom);
  //     }
  //   });
  //   return
  //     Future.value(matches);
  // }
  //
  // Future<List<AddressLocation>> getLocation(String query, isFrom) {
  //   setState(() async {
  //     var result = await _api.getLocation(query);
  //     if (result != null) {
  //       if (result.success!) {
  //         setState(() {
  //           if(isFrom == 'crew'){
  //             locationList.addAll(result.result!);
  //             for (var item in locationList) {
  //               for (var selectedItem in selectedLocationList){
  //                 if (selectedItem.district == item.district) {
  //                   item.isSelected = selectedItem.isSelected;
  //                 }
  //               }
  //             }
  //           }else{
  //             famelocationList.addAll(result.result!);
  //             for (var item in famelocationList) {
  //               for (var selectedItem in fameselectedLocationList){
  //                 if (selectedItem.district!.contains(item.district!)){
  //                   item.isSelected = selectedItem.isSelected;
  //                 }
  //               }
  //             }
  //             return famelocationList;
  //           }
  //         });
  //       } else {
  //         Constants.toastMessage(msg: result.message!);
  //
  //       }
  //     }
  //   });
  //   return locationList;
  // }
  //
  // Future<List<JobCategories>?> searchCategories(String query) {
  //   setState(() async {
  //     if(query.isNotEmpty){
  //       categoryList.clear();
  //       for(var item in searchCategoryList){
  //         if(item.jobName!.toLowerCase().contains(query.toLowerCase())){
  //           setState(() {
  //             categoryList.add(item);
  //             for (var item in categoryList) {
  //               for (var selectedItem in categorySelected){
  //                 if (selectedItem.id!.contains(item.id!)){
  //                   item.isSelected = selectedItem.isSelected;
  //                 }
  //               }
  //             }
  //           });
  //         }
  //       }
  //     }else{
  //       getCategories();
  //     }
  //   });
  // }

  Future<List<JobCategories>?> getCategories() async {
    categoryList.clear();
    searchCategoryList.clear();
    var result = await _api.getCategories();
    if (result != null) {
      if (result.success!) {
        setState(() {
          for (var item in result.result!) {
            if (item.jobType == 'crew') {
              categoryList.add(item);
              searchCategoryList.add(item);
              if (categorySelected.isNotEmpty) {
                for (var item in categoryList) {
                  for (var selectedItem in categorySelected) {
                    if (selectedItem.id!.contains(item.id!)) {
                      item.isSelected = selectedItem.isSelected;
                    }
                  }
                }
              }
            } else {
              fameCategoryList.add(item);
              fameSearchCategoryList.add(item);
            }
          }
        });
      } else {
        Constants.toastMessage(msg: result.message!);
        return categoryList;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   systemNavigationBarColor: Colors.white, // navigation bar color
    //   statusBarColor: Colors.white, // status bar color
    //   statusBarIconBrightness: Brightness.dark, // status bar icons' color
    //   systemNavigationBarIconBrightness: Brightness.dark,
    // ));
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(16),
                right: ScreenUtil().setWidth(16),
                top: ScreenUtil().setHeight(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: black,
                      size: ScreenUtil().radius(20),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "Your Hiring ",
                          style: GoogleFonts.roboto(
                              fontSize: ScreenUtil().setSp(18),
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              height: 0.25,
                              color: black),
                        ),
                        TextSpan(
                          text: "Profile",
                          style: GoogleFonts.roboto(
                            fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            height: 0.25,
                            color: orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_back_ios_rounded,
                  color: white,
                  size: ScreenUtil().radius(20),
                )
              ],
            ),
          ),
          Constants.userType == "agency"
              ? Container()
              : Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(40),
                      right: ScreenUtil().setWidth(16),
                      top: ScreenUtil().setHeight(25)),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (index == 1) {
                            setState(() {
                              index = 0;
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              index == 0
                                  ? "assets/icons/selectedRadio.png"
                                  : "assets/icons/radioCircle.png",
                              height: ScreenUtil().setHeight(14),
                              width: ScreenUtil().setWidth(14),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(7.5),
                                  left: ScreenUtil().setWidth(6)),
                              child: Text(
                                "Front Faces",
                                style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: index == 0
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  height: 0.16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          if (index == 0) {
                            setState(() {
                              index = 1;
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              index == 1
                                  ? "assets/icons/selectedRadio.png"
                                  : "assets/icons/radioCircle.png",
                              height: ScreenUtil().setHeight(14),
                              width: ScreenUtil().setWidth(14),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(7.5),
                                  left: ScreenUtil().setWidth(6)),
                              child: Text(
                                "Behind the Scenes",
                                style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: index == 1
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  height: 0.16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
          index == 1
              ? Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: crewKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(24),
                                left: ScreenUtil().setWidth(40),
                                right: ScreenUtil().setWidth(40)),
                            child: Row(
                              children: [
                                Text(
                                  "Experience Level:",
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(14),
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    height: 0.19,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (experienceIndex == 1) {
                                      setState(() {
                                        experienceIndex = 0;
                                      });
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(7),
                                            left: ScreenUtil().setWidth(10)),
                                        child: Container(
                                          height: ScreenUtil().setHeight(14),
                                          width: ScreenUtil().setWidth(14),
                                          decoration: BoxDecoration(
                                              color: experienceIndex == 0
                                                  ? Color(0xff9B9B9B)
                                                  : white,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(color: black)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(6)),
                                        child: Text(
                                          "Fresher",
                                          style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(12),
                                              fontWeight: experienceIndex == 0
                                                  ? FontWeight.w700
                                                  : FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              height: 0.16,
                                              color: Color(0xff4B4E58)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    if (experienceIndex == 0) {
                                      setState(() {
                                        experienceIndex = 1;
                                      });
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(7),
                                            left: ScreenUtil().setWidth(8)),
                                        child: Container(
                                          height: ScreenUtil().setHeight(14),
                                          width: ScreenUtil().setWidth(14),
                                          decoration: BoxDecoration(
                                              color: experienceIndex == 1
                                                  ? Color(0xff9B9B9B)
                                                  : white,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(color: black)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(6)),
                                        child: Text(
                                          "Experienced",
                                          style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(12),
                                              fontWeight: experienceIndex == 1
                                                  ? FontWeight.w700
                                                  : FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              height: 0.16,
                                              color: Color(0xff4B4E58)),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(19),
                                left: ScreenUtil().setWidth(40),
                                right: ScreenUtil().setWidth(40)),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().radius(8)),
                                color: Colors.white,
                              ),
                              child: Scrollbar(
                                controller: workScrollController,
                                isAlwaysShown: true,
                                thickness: 3,
                                trackVisibility: true,
                                radius: Radius.circular(50),
                                child: Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                    controller: workController,
                                    scrollController: workScrollController,
                                    minLines: 5,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    cursorColor: black,
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(14),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xff9B9B9B)),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return '';
                                      } else {
                                        return null;
                                      }
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                        errorStyle: TextStyle(height: 0),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 1.w),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 1.w),
                                        ),
                                        contentPadding: EdgeInsets.all(
                                            ScreenUtil().setWidth(10)),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff9B9B9B),
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: lightRed, width: 1),
                                        ),
                                        hintText: 'Work Experience',
                                        hintStyle: GoogleFonts.nunitoSans(
                                            fontSize: ScreenUtil().setSp(14),
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400,
                                            color: lightGray)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(12),
                                left: ScreenUtil().setWidth(40),
                                right: ScreenUtil().setWidth(40)),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().radius(4)),
                                color: Colors.white,
                              ),
                              child: Scrollbar(
                                controller: awardsScrollController,
                                isAlwaysShown: true,
                                thickness: 3,
                                trackVisibility: true,
                                radius: Radius.circular(50),
                                child: Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                    scrollController: awardsScrollController,
                                    controller: awardsController,
                                    minLines: 2,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    cursorColor: black,
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(14),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xff9B9B9B)),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return '';
                                      } else {
                                        return null;
                                      }
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                        errorStyle: TextStyle(height: 0),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 1.w),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 1.w),
                                        ),
                                        contentPadding: EdgeInsets.all(
                                            ScreenUtil().setWidth(10)),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff9B9B9B),
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: lightRed, width: 1),
                                        ),
                                        hintText:
                                            'Awards Won / Special Achievements',
                                        hintStyle: GoogleFonts.nunitoSans(
                                            fontSize: ScreenUtil().setSp(14),
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff9B9B9B))),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(12),
                                left: ScreenUtil().setWidth(40),
                                right: ScreenUtil().setWidth(40)),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().radius(4)),
                                border: Border.all(color: Color(0xff9B9B9B)),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(10),
                                    right: ScreenUtil().setWidth(10)),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      // onChanged: (val) {
                                      //   setState(() async {
                                      //     locationList.clear();
                                      //     return await _getAddressLocation(val, 'crew');
                                      //   });
                                      // },
                                      controller: locationController,
                                      maxLines: 1,
                                      cursorColor: black,
                                      keyboardType: TextInputType.multiline,
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(14),
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.italic,
                                          color: Color(0xff9B9B9B)),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: ScreenUtil().setWidth(10)),
                                        hintText: 'Interested Location',
                                        hintStyle: GoogleFonts.nunitoSans(
                                            fontSize: ScreenUtil().setSp(14),
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff9B9B9B)),
                                        suffixIcon: Image.asset(
                                            "assets/icons/search.png",
                                            color: Color(0xff9B9B9B)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: locationList.length == 0
                                                    ? Colors.transparent
                                                    : darkGray,
                                                width: 1)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: locationList.length == 0
                                                    ? Colors.transparent
                                                    : lightRed,
                                                width: 1)),
                                      ),
                                    ),
                                    locationList.length == 0
                                        ? Container()
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(10),
                                                bottom:
                                                    ScreenUtil().setHeight(10)),
                                            child: Scrollbar(
                                              controller:
                                                  locationScrollController,
                                              isAlwaysShown: true,
                                              thickness: 3,
                                              trackVisibility: true,
                                              radius: Radius.circular(50),
                                              child: Flexible(
                                                child: ListView.builder(
                                                  controller:
                                                      locationScrollController,
                                                  itemCount:
                                                      locationList.length,
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          if (locationList[
                                                                      index]
                                                                  .isSelected ==
                                                              true) {
                                                            locationList[index]
                                                                    .isSelected =
                                                                false;
                                                            selectedLocationList
                                                                .remove(
                                                                    locationList[
                                                                        index]);
                                                          } else {
                                                            locationList[index]
                                                                    .isSelected =
                                                                true;
                                                            selectedLocationList
                                                                .add(
                                                                    locationList[
                                                                        index]);
                                                          }
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                top: ScreenUtil()
                                                                    .setHeight(
                                                                        3)),
                                                            child: Text(
                                                              "${locationList[index].district} ${locationList[index].state}, ${locationList[index].country}",
                                                              style: GoogleFonts.nunitoSans(
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              12),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  color: Color(
                                                                      0xff4B4E58)),
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          locationList[index]
                                                                      .isSelected ==
                                                                  true
                                                              ? Icon(
                                                                  Icons
                                                                      .check_circle_sharp,
                                                                  color: orange,
                                                                  size: 15.sp)
                                                              : Container()
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(24),
                                left: ScreenUtil().setWidth(17),
                                right: ScreenUtil().setWidth(17)),
                            child: Column(
                              children: [
                                // TextField(
                                //   onChanged: (val) {
                                //     searchCategories(val);
                                //   },
                                //   onSubmitted: (_) {},
                                //   controller: professionController,
                                //   maxLines: 1,
                                //   keyboardType: TextInputType.multiline,
                                //   cursorColor: black,
                                //   style: GoogleFonts.nunitoSans(
                                //     fontSize: ScreenUtil().setSp(14),
                                //     fontWeight: FontWeight.w400,
                                //     fontStyle: FontStyle.italic,
                                //     color: Color(0xff9B9B9B)
                                //   ),
                                //   decoration: InputDecoration(
                                //     contentPadding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                                //     hintText: 'Search Profession',
                                //     hintStyle: GoogleFonts.nunitoSans(
                                //       fontSize: ScreenUtil().setSp(14),
                                //       fontStyle: FontStyle.italic,
                                //       fontWeight: FontWeight.w400,
                                //       color: Color(0xff9B9B9B)
                                //     ),
                                //     suffixIcon: Image.asset("assets/icons/search.png", color: Color(0xff9B9B9B)),
                                //     focusedBorder: UnderlineInputBorder(
                                //       borderSide: BorderSide(color: lightRed, width: 1)
                                //     ),
                                //   ),
                                // ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(14)),
                                  child: Scrollbar(
                                    controller: categoryScrollController,
                                    isAlwaysShown: true,
                                    thickness: 3,
                                    trackVisibility: true,
                                    radius: Radius.circular(50),
                                    child: Flexible(
                                      child: Container(
                                        height: 260.h,
                                        padding: EdgeInsets.only(right: 8.w),
                                        child: GridView.builder(
                                          padding: EdgeInsets.all(0.0),
                                          primary: false,
                                          scrollDirection: Axis.vertical,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            childAspectRatio: 2.r,
                                            crossAxisSpacing: 10.r,
                                            mainAxisSpacing: 10.r,
                                          ),
                                          itemCount: categoryList.length,
                                          physics: ScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder:
                                              (BuildContext ctx, index) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (categoryList[index]
                                                          .isSelected ==
                                                      true) {
                                                    categoryList[index]
                                                        .isSelected = false;
                                                    categorySelected.remove(
                                                        categoryList[index]);
                                                  } else {
                                                    categoryList[index]
                                                        .isSelected = true;
                                                    categorySelected.add(
                                                        categoryList[index]);
                                                  }
                                                });
                                              },
                                              child: Container(
                                                height: 20.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          ScreenUtil()
                                                              .radius(15)),
                                                  border:
                                                      Border.all(color: black),
                                                  color: categoryList[index]
                                                              .isSelected ==
                                                          true
                                                      ? Color(0xff4B4E58)
                                                      : Colors.white,
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.r),
                                                    child: Text(
                                                      categoryList[index]
                                                          .jobName!,
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.nunitoSans(
                                                          fontSize: ScreenUtil()
                                                              .setSp(12),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          color: categoryList[
                                                                          index]
                                                                      .isSelected ==
                                                                  true
                                                              ? white
                                                              : black),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TextField(
                                  onChanged: (_) {},
                                  controller: otherController,
                                  maxLines: 2,
                                  minLines: 1,
                                  maxLength: 20,
                                  keyboardType: TextInputType.multiline,
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(14),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.italic,
                                      color: Color(0xff9B9B9B)),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: ScreenUtil().setWidth(10)),
                                    hintText:
                                        'Not in the above list? Type here...',
                                    hintStyle: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(14),
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff9B9B9B)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: lightRed, width: 1)),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: ScreenUtil().setHeight(24),
                                          bottom: ScreenUtil().setHeight(24),
                                          left: ScreenUtil().setWidth(10),
                                          right: ScreenUtil().setWidth(10)),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                100,
                                        child: Text(
                                          "The data you submit will be sent to Hiring Agencies whenever you apply for Collaborations.",
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(10),
                                              fontWeight: FontWeight.w300,
                                              fontStyle: FontStyle.italic,
                                              color: Color(0xff0060FF)),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () async {
                                          if (!crewKey.currentState!
                                              .validate()) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content: Text(
                                                    'Please fill the details'),
                                                duration:
                                                    const Duration(seconds: 2),
                                              ),
                                            );
                                            return;
                                          } else if (categorySelected.isEmpty &&
                                              otherController.text.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content: Text(
                                                    'Enter profession or select profession from above list'),
                                                duration:
                                                    const Duration(seconds: 2),
                                              ),
                                            );
                                            return;
                                          } else if (selectedLocationList
                                                  .length ==
                                              0) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content: Text(
                                                    'Select interested location'),
                                                duration:
                                                    const Duration(seconds: 2),
                                              ),
                                            );
                                            return;
                                          } else {
                                            List location = [];
                                            List category = [];

                                            for (int i = 0;
                                                i < selectedLocationList.length;
                                                i++) {
                                              location.add({
                                                '"district"':
                                                    '"${selectedLocationList[i].district}"',
                                                '"state"':
                                                    '"${selectedLocationList[i].state}"',
                                                '"country"':
                                                    '"${selectedLocationList[i].country}"'
                                              });
                                            }

                                            for (var item in categorySelected) {
                                              category.add('"${item.id}"');
                                            }

                                            dynamic body = {
                                              "experienceLevel":
                                                  experienceIndex == 0
                                                      ? 'fresher'
                                                      : 'experienced',
                                              "workExperience":
                                                  workController.text,
                                              "achievements":
                                                  awardsController.text,
                                              "interestCat": category,
                                              "interestedLoc": location,
                                            };

                                            await ApiManager.patch(
                                                    param: body,
                                                    url1:
                                                        "joblinks/profile/crew")
                                                .then((value) async {
                                              if (value.statusCode == 200) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    content: Text(
                                                        'Profile created successfuly'),
                                                    duration: const Duration(
                                                        seconds: 2),
                                                  ),
                                                );
                                                Navigator.pop(context);
                                              }
                                            });
                                          }
                                        },
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: orange,
                                          size: 30,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(25),
                          left: ScreenUtil().setWidth(35),
                          right: ScreenUtil().setWidth(35)),
                      child: Form(
                        key: facesKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: ftController,
                                    keyboardType: TextInputType.number,
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(14),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xff9B9B9B)),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return '';
                                      } else {
                                        return null;
                                      }
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 1.w),
                                        ),
                                        errorStyle: TextStyle(height: 0),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff9B9B9B),
                                              width: 1),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 1.w),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: lightRed, width: 1),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            top: ScreenUtil().setWidth(10),
                                            left: ScreenUtil().setWidth(10)),
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(3)),
                                          child: Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    ftCount++;
                                                    ftController.text =
                                                        ftCount.toString();
                                                  });
                                                },
                                                child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    child: Icon(
                                                      Icons
                                                          .arrow_drop_up_outlined,
                                                      color: lightGray,
                                                    )),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      if (ftCount != 1) {
                                                        ftCount--;
                                                        ftController.text =
                                                            ftCount.toString();
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                      height: 20,
                                                      width: 20,
                                                      child: Icon(
                                                        Icons
                                                            .arrow_drop_down_sharp,
                                                        color: lightGray,
                                                      ))),
                                            ],
                                          ),
                                        ),
                                        hintText: 'ft.',
                                        hintStyle: GoogleFonts.nunitoSans(
                                            fontSize: ScreenUtil().setSp(14),
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400,
                                            color: lightGray)),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: inController,
                                    keyboardType: TextInputType.number,
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(14),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xff9B9B9B)),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return '';
                                      } else {
                                        return null;
                                      }
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 1.w),
                                        ),
                                        errorStyle: TextStyle(height: 0),
                                        contentPadding: EdgeInsets.only(
                                            top: ScreenUtil().setWidth(10),
                                            left: ScreenUtil().setWidth(10)),
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(3)),
                                          child: Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    inCount++;
                                                    inController.text =
                                                        inCount.toString();
                                                  });
                                                },
                                                child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    child: Icon(
                                                      Icons
                                                          .arrow_drop_up_outlined,
                                                      color: lightGray,
                                                    )),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      if (inCount != 1) {
                                                        inCount--;
                                                        inController.text =
                                                            inCount.toString();
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                      height: 20,
                                                      width: 20,
                                                      child: Icon(
                                                        Icons
                                                            .arrow_drop_down_sharp,
                                                        color: lightGray,
                                                      ))),
                                            ],
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff9B9B9B),
                                              width: 1),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 1.w),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: lightRed, width: 1),
                                        ),
                                        hintText: 'in.',
                                        hintStyle: GoogleFonts.nunitoSans(
                                            fontSize: ScreenUtil().setSp(14),
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400,
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
                                    keyboardType: TextInputType.number,
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(14),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xff9B9B9B)),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return '';
                                      } else {
                                        return null;
                                      }
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 1.w),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 1.w),
                                        ),
                                        errorStyle: TextStyle(height: 0),
                                        contentPadding: EdgeInsets.all(
                                            ScreenUtil().setWidth(10)),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff9B9B9B),
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: lightRed, width: 1),
                                        ),
                                        hintText: 'Weight (kg)',
                                        hintStyle: GoogleFonts.nunitoSans(
                                            fontSize: ScreenUtil().setSp(14),
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400,
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
                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(14),
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.italic,
                                          color: Color(0xff9B9B9B)),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return '';
                                        } else {
                                          return null;
                                        }
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                          errorStyle: TextStyle(height: 0),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 1.w),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 1.w),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: lightGray, width: 1.w),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: lightRed, width: 1),
                                          ),
                                          contentPadding: EdgeInsets.all(
                                              ScreenUtil().setWidth(10)),
                                          hintText: 'Bust (cm)',
                                          hintStyle: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(14),
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w400,
                                              color: lightGray)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: waistController,
                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(14),
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.italic,
                                          color: Color(0xff9B9B9B)),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return '';
                                        } else {
                                          return null;
                                        }
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 1.w),
                                          ),
                                          errorStyle: TextStyle(height: 0),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 1.w),
                                          ),
                                          contentPadding: EdgeInsets.all(
                                              ScreenUtil().setWidth(10)),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff9B9B9B),
                                                width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: lightRed, width: 1),
                                          ),
                                          hintText: 'Waist (cm)',
                                          hintStyle: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(14),
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w400,
                                              color: lightGray)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: hipController,
                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(14),
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.italic,
                                          color: Color(0xff9B9B9B)),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return '';
                                        } else {
                                          return null;
                                        }
                                      },
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 1.w),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 1.w),
                                          ),
                                          errorStyle: TextStyle(height: 0),
                                          contentPadding: EdgeInsets.all(
                                              ScreenUtil().setWidth(10)),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff9B9B9B),
                                                width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: lightRed, width: 1),
                                          ),
                                          hintText: 'Hip (cm)',
                                          hintStyle: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(14),
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w400,
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
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return '';
                                  } else {
                                    return null;
                                  }
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.w),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.w),
                                    ),
                                    contentPadding: EdgeInsets.all(
                                        ScreenUtil().setWidth(10)),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xff9B9B9B), width: 1),
                                    ),
                                    errorStyle: TextStyle(height: 0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: lightRed, width: 1),
                                    ),
                                    suffixIcon: Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: Color(0xff0060FF),
                                    ),
                                    hintText: 'Eye Color',
                                    hintStyle: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(14),
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
                                  border: Border.all(color: Color(0xff9B9B9B)),
                                  borderRadius: BorderRadius.circular(7.r),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    value: strComplexion,
                                    hint: Text(
                                      "Complexion",
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(14),
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w400,
                                          color: lightGray),
                                    ),
                                    //  icon: Image.asset("assets/images/FameProfileTrendz.png"),
                                    //  isExpanded: true,
                                    // // customItemsHeights: [4.0],
                                    //  buttonHeight: 54.h,
                                    //  buttonWidth: double.infinity,
                                    //  buttonPadding: EdgeInsets.only(left: 14.w, right: 14.w),
                                    //  itemHeight: 42.h,
                                    //  itemPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    onChanged: (String? value) {
                                      setState(() {
                                        strComplexion = value!;
                                      });
                                    },
                                    items: complexion.map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value.toString(),
                                        child: Text(value.toString(),
                                            style: GoogleFonts.nunitoSans(
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                fontWeight: FontWeight.w400,
                                                color: lightGray)),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(12)),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      ScreenUtil().radius(4)),
                                  border: Border.all(color: Color(0xff9B9B9B)),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(10),
                                      right: ScreenUtil().setWidth(10)),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        // onChanged: (val) {
                                        //   setState(() async {
                                        //     famelocationList.clear();
                                        //     return await _getAddressLocation(val, 'faces');
                                        //   });
                                        // },
                                        controller: famelocationController,
                                        maxLines: 1,
                                        cursorColor: black,
                                        keyboardType: TextInputType.multiline,
                                        style: GoogleFonts.nunitoSans(
                                            fontSize: ScreenUtil().setSp(14),
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.italic,
                                            color: Color(0xff9B9B9B)),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: ScreenUtil().setWidth(10)),
                                          hintText: 'Interested Location',
                                          hintStyle: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(14),
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff9B9B9B)),
                                          suffixIcon: Image.asset(
                                              "assets/icons/search.png",
                                              color: Color(0xff9B9B9B)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      famelocationList.length ==
                                                              0
                                                          ? Colors.transparent
                                                          : darkGray,
                                                  width: 1)),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      famelocationList.length ==
                                                              0
                                                          ? Colors.transparent
                                                          : lightRed,
                                                  width: 1)),
                                        ),
                                      ),
                                      famelocationList.length == 0
                                          ? Container()
                                          : Padding(
                                              padding: EdgeInsets.only(
                                                  top: ScreenUtil()
                                                      .setHeight(10),
                                                  bottom: ScreenUtil()
                                                      .setHeight(10)),
                                              child: Scrollbar(
                                                controller:
                                                    famelocationScrollController,
                                                isAlwaysShown: true,
                                                thickness: 3,
                                                trackVisibility: true,
                                                radius: Radius.circular(50),
                                                child: Flexible(
                                                  child: ListView.builder(
                                                    controller:
                                                        famelocationScrollController,
                                                    itemCount:
                                                        famelocationList.length,
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,
                                                    primary: false,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            if (famelocationList[
                                                                        index]
                                                                    .isSelected ==
                                                                true) {
                                                              famelocationList[
                                                                          index]
                                                                      .isSelected =
                                                                  false;
                                                              fameselectedLocationList
                                                                  .remove(
                                                                      famelocationList[
                                                                          index]);
                                                            } else {
                                                              famelocationList[
                                                                          index]
                                                                      .isSelected =
                                                                  true;
                                                              fameselectedLocationList.add(
                                                                  famelocationList[
                                                                      index]);
                                                            }
                                                          });
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  top: ScreenUtil()
                                                                      .setHeight(
                                                                          3)),
                                                              child: Text(
                                                                "${famelocationList[index].district} ${famelocationList[index].state}, ${famelocationList[index].country}",
                                                                style: GoogleFonts.nunitoSans(
                                                                    fontSize: ScreenUtil()
                                                                        .setSp(
                                                                            12),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                    color: Color(
                                                                        0xff4B4E58)),
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            famelocationList[
                                                                            index]
                                                                        .isSelected ==
                                                                    true
                                                                ? Icon(
                                                                    Icons
                                                                        .check_circle_sharp,
                                                                    color:
                                                                        orange,
                                                                    size: 15.sp)
                                                                : Container()
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setWidth(10)),
                                  child: Text(
                                    "Interested In:   ",
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xff4B4E58)),
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    onChanged: (_) {},
                                    onSubmitted: (_) {},
                                    controller: interestedController,
                                    maxLines: 1,
                                    keyboardType: TextInputType.multiline,
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(14),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xff9B9B9B)),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: ScreenUtil().setWidth(0)),
                                      hintText: '',
                                      hintStyle: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(14),
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff9B9B9B)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: lightRed, width: 1)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(16)),
                              child: Scrollbar(
                                controller: fameCategoryScrollController,
                                isAlwaysShown: true,
                                thickness: 3,
                                trackVisibility: true,
                                radius: Radius.circular(50),
                                child: Flexible(
                                  child: Container(
                                    height: 260.h,
                                    padding: EdgeInsets.only(right: 8.w),
                                    child: GridView.builder(
                                      padding: EdgeInsets.all(0.0),
                                      primary: false,
                                      scrollDirection: Axis.vertical,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 2.r, //1.6.r,
                                        crossAxisSpacing: 8.r,
                                        mainAxisSpacing: 15.r,
                                      ),
                                      itemCount: fameCategoryList.length,
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (BuildContext ctx, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (fameCategorySelected.contains(
                                                  fameCategoryList[index])) {
                                                fameCategorySelected.remove(
                                                    fameCategoryList[index]);
                                              } else {
                                                fameCategorySelected.add(
                                                    fameCategoryList[index]);
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      ScreenUtil().radius(17)),
                                              border: Border.all(color: black),
                                              color: white,
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            ScreenUtil()
                                                                .radius(15)),
                                                    border: Border.all(
                                                        color: black),
                                                    color: fameCategorySelected
                                                            .contains(
                                                                fameCategoryList[
                                                                    index])
                                                        ? Color(0xff4B4E58)
                                                        : Colors.white,
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: ScreenUtil()
                                                            .setHeight(6),
                                                        bottom: ScreenUtil()
                                                            .setHeight(6),
                                                        left: ScreenUtil()
                                                            .setWidth(10),
                                                        right: ScreenUtil()
                                                            .setWidth(10)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          fameCategoryList[
                                                                  index]
                                                              .jobCategory,
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(12),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            color: fameCategorySelected
                                                                    .contains(
                                                                        fameCategoryList[
                                                                            index])
                                                                ? Colors.white
                                                                : black,
                                                          ),
                                                        ),
                                                        SvgPicture.asset(
                                                          "assets/icons/svg/photoshoot.svg",
                                                          height: ScreenUtil()
                                                              .setHeight(20),
                                                          width: ScreenUtil()
                                                              .setWidth(20),
                                                          color: orange,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(10.r),
                                                    child: Text(
                                                      fameCategoryList[index]
                                                          .jobCategory,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          12),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              color: black),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(10),
                                  bottom: ScreenUtil().setHeight(24)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    "assets/icons/selectedRadio.png",
                                    height: ScreenUtil().setHeight(14),
                                    width: ScreenUtil().setWidth(14),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(7.5),
                                        left: ScreenUtil().setWidth(6)),
                                    child: Text(
                                      "list your profile",
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: index == 0
                                            ? FontWeight.w700
                                            : FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        height: 0.16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: ScreenUtil().setHeight(24),
                                      left: ScreenUtil().setWidth(10),
                                      right: ScreenUtil().setWidth(10)),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width -
                                        130.w,
                                    child: Text(
                                      "The data you submit will be sent to Hiring Agencies whenever you apply for Collaborations.",
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(10),
                                          fontWeight: FontWeight.w300,
                                          fontStyle: FontStyle.italic,
                                          color: Color(0xff0060FF)),
                                    ),
                                  ),
                                ),
                                InkWell(
                                    onTap: () async {
                                      if (!facesKey.currentState!.validate()) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            content:
                                                Text('Please fill the details'),
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        );
                                        return;
                                      } else if (strComplexion.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            content: Text('select complexion'),
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        );
                                        return;
                                      } else if (fameCategorySelected.isEmpty &&
                                          interestedController.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                                'Enter or select interested category'),
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        );
                                        return;
                                      } else if (fameselectedLocationList
                                              .length ==
                                          0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                                'Select interested location'),
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        );
                                        return;
                                      } else {
                                        List location = [];
                                        List category = [];
                                        String complexions;

                                        dynamic height = {
                                          'foot': ftController.text,
                                          'inch': inController.text
                                        };
                                        print(jsonEncode(height));

                                        if (strComplexion == 'Very Fair') {
                                          complexions = 'veryFair';
                                        } else {
                                          complexions = strComplexion;
                                        }

                                        for (int i = 0;
                                            i < fameselectedLocationList.length;
                                            i++) {
                                          location.add({
                                            '"district"':
                                                '"${fameselectedLocationList[i].district}"',
                                            '"state"':
                                                '"${fameselectedLocationList[i].state}"',
                                            '"country"':
                                                '"${fameselectedLocationList[i].country}"'
                                          });
                                        }

                                        for (var item in fameCategorySelected) {
                                          category.add('"${item.id}"');
                                        }

                                        dynamic body = {
                                          "height": jsonEncode(height),
                                          "weight": weightController.text,
                                          "bust": bustController.text,
                                          "waist": waistController.text,
                                          "hip": hipController.text,
                                          "eyeColor": eyeController.text,
                                          "complexion":
                                              complexions == 'veryFair'
                                                  ? complexions
                                                  : complexions.toLowerCase(),
                                          "interestCat": category,
                                          "interestedLoc": location,
                                        };

                                        print(body);

                                        await ApiManager.patch(
                                                param: body,
                                                url1: "joblinks/profile/faces")
                                            .then((value) async {
                                          if (value.statusCode == 200) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content: Text(
                                                    'Profile created successfuly'),
                                                duration:
                                                    const Duration(seconds: 2),
                                              ),
                                            );
                                            Navigator.pop(context);
                                          }
                                        });
                                      }
                                    },
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: orange,
                                      size: 30,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
