import 'dart:convert';

import 'package:famelink/dio/api/apimanager.dart';
import 'package:famelink/models/LocationResponse.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/joblinks/models/JobCategoriesModel.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../util/config/color.dart';

class CreateJob extends StatefulWidget {

  @override
  State<CreateJob> createState() => _CreateJobState();
}

class _CreateJobState extends State<CreateJob> {
  int index = 0;
  int experienceIndex = 0;
  int genderIndex = 0;
  static final crewKey = GlobalKey<FormState>();
  static final facesKey = GlobalKey<FormState>();
  TextEditingController facetitleController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController facedescriptionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController facesstartController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController facesendController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController facestotalController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController facesdeadlineController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  TextEditingController facesotherController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  TextEditingController ftController = TextEditingController();
  TextEditingController inController = TextEditingController();
  List selectedIndex = [];
  List ageGroup = ['0 - 4', '4 - 12', '12 - 18', '18 - 28', '28 - 40', '40 - 60',  '50 - 60', '60+'];
  late String ageSelected;
  int ftCount = 0;
  int inCount = 0;

  final ApiProvider _api = ApiProvider();
  TextEditingController locationController = TextEditingController();
  ScrollController locationScrollController = ScrollController();
  List<AddressLocation> locationList = <AddressLocation>[];
  dynamic selectedLocation;

  TextEditingController famelocationController = TextEditingController();
  ScrollController famelocationScrollController = ScrollController();
  List<AddressLocation> famelocationList = <AddressLocation>[];
  dynamic facesselectedLocation;

  List<JobCategories> categoryList = <JobCategories>[];
  List<JobCategories> searchCategoryList = <JobCategories>[];
  TextEditingController professionController = TextEditingController();
  List<JobCategories> categorySelected = <JobCategories>[];
  ScrollController categoryScrollController = ScrollController();

  List<JobCategories> facesCategoryList = <JobCategories>[];
  List<JobCategories> facesSearchCategoryList = <JobCategories>[];
  TextEditingController facesprofessionController = TextEditingController();
  List<JobCategories> facesCategorySelected = <JobCategories>[];
  ScrollController facesCategoryScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  // Future<List<AddressLocation>?>
  _getAddressLocation(String query, isFrom) {
    setState(() async {
      // List<AddressLocation> matches = <AddressLocation>[];
      if (query.length >= 3) {
        return await getLocation(query, isFrom);
      } else {
        // return matches;
      }
    });
  }

  // Future<List<AddressLocation>?>
  getLocation(String query, isFrom) {
    setState(() async {
      var result = await _api.getLocation(query);
      if (result != null) {
        if (result.success!) {
          setState(() {
            if(isFrom == 'crew'){
              locationList.addAll(result.result!);
              // return locationList;
            }else{
              famelocationList.addAll(result.result!);
              // return famelocationList;
            }
          });
        } else {
          Constants.toastMessage(msg: result.message!);
          // return locationList;
        }
      }
    });
  }
  //
  // Future<List<JobCategories>>
  searchCategories(String query, type) {
    setState(() async {
      if(query.isNotEmpty){
        if(type == 'crew'){
          categoryList.clear();
          for(var item in searchCategoryList){
            if(item.jobName!.toLowerCase().contains(query.toLowerCase())){
              setState(() {
                categoryList.add(item);
                for (var item in categoryList) {
                  for (var selectedItem in categorySelected){
                    if (selectedItem.id!.contains(item.id!)){
                      item.isSelected = selectedItem.isSelected;
                    }
                  }
                }
              });
            }
          }
        }else{
          facesCategoryList.clear();
          for(var item in facesSearchCategoryList){
            if(item.jobName!.toLowerCase().contains(query.toLowerCase())){
              setState(() {
                facesCategoryList.add(item);
                for (var item in facesCategoryList) {
                  for (var selectedItem in facesCategorySelected){
                    if (selectedItem.id!.contains(item.id!)){
                      item.isSelected = selectedItem.isSelected;
                    }
                  }
                }
              });
            }
          }
        }
      }else{
        getCategories();
      }
    });
  }

  // Future<List<JobCategories>>
  getCategories() async {
    categoryList.clear();
    searchCategoryList.clear();
    var result = await _api.getCategories();
    if (result != null) {
      if (result.success!) {
        setState(() {
          for(var item in result.result!){
            if(item.jobType == 'crew'){
              categoryList.add(item);
              searchCategoryList.add(item);
              if(categorySelected.isNotEmpty){
                for (var item in categoryList) {
                  for (var selectedItem in categorySelected){
                    if (selectedItem.id!.contains(item.id!)){
                      item.isSelected = selectedItem.isSelected;
                    }
                  }
                }
              }
            }else{
              facesCategoryList.add(item);
              facesSearchCategoryList.add(item);
              if(facesCategorySelected.isNotEmpty){
                for (var item in facesCategoryList) {
                  for (var selectedItem in facesCategorySelected){
                    if (selectedItem.id!.contains(item.id!)){
                      item.isSelected = selectedItem.isSelected;
                    }
                  }
                }
              }
            }
          }
        });
      } else {
        Constants.toastMessage(msg: result.message!);
        // return categoryList;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(16), right: ScreenUtil().setWidth(16), top: ScreenUtil().setHeight(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_rounded, color: black, size: ScreenUtil().radius(20),)
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "Create ",
                          style: GoogleFonts.roboto(
                              fontSize: ScreenUtil().setSp(18),
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              height: 0.25,
                              color: black
                          ),
                        ),
                        TextSpan(
                          text: "Job",
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
                Icon(Icons.arrow_back_ios_rounded, color: white, size: ScreenUtil().radius(20),)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(16), top: ScreenUtil().setHeight(25)),
            child: Row(
              children: [
                InkWell(
                  onTap: (){
                    if(index == 1){
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
                        padding: EdgeInsets.only(top: ScreenUtil().setHeight(7.5), left: ScreenUtil().setWidth(6)),
                        child: Text(
                          "Front Faces",
                          style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: index == 0 ? FontWeight.w700 : FontWeight.w400,
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
                  onTap: (){
                    if(index == 0){
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
                        padding: EdgeInsets.only(top: ScreenUtil().setHeight(7.5), left: ScreenUtil().setWidth(6)),
                        child: Text(
                          "Behind the Scenes",
                          style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: index == 1 ? FontWeight.w700 : FontWeight.w400,
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
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(24), left: ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(40)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(ScreenUtil().radius(8)),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: titleController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          cursorColor: black,
                          style: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              color: Color(0xff9B9B9B)),
                          validator: (val){
                            if(val!.isEmpty){
                              return '';
                            } else{
                              return null;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              errorStyle: TextStyle(height:0),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 1.w),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 1.w),
                              ),
                              contentPadding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                borderSide: BorderSide(
                                    color: Color(0xff9B9B9B), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                borderSide: BorderSide(color: lightRed, width: 1),
                              ),
                              hintText: 'Enter Job Title',
                              hintStyle: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  color: lightGray
                              )
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(16), left: ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(40)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(ScreenUtil().radius(8)),
                          border: Border.all(color: Color(0xff9B9B9B)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: ScreenUtil().setWidth(10), right: ScreenUtil().setWidth(10)),
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
                                    color: Color(0xff9B9B9B)
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: ScreenUtil().setWidth(15)),
                                  hintText: 'Interested Location',
                                  hintStyle: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(14),
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff9B9B9B)
                                  ),
                                  suffixIcon: Image.asset("assets/icons/search.png", color: Color(0xff9B9B9B)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: locationList.length == 0 ? Colors.transparent : darkGray, width: 1)
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: locationList.length == 0 ? Colors.transparent : lightRed, width: 1)
                                  ),
                                ),
                              ),
                              locationList.length == 0 ? Container() :
                              Padding(
                                padding: EdgeInsets.only(top: ScreenUtil().setHeight(10), bottom: ScreenUtil().setHeight(10)),
                                child: Scrollbar(
                                  controller: locationScrollController,
                                  isAlwaysShown: true,
                                  thickness: 3,
                                  trackVisibility: true,
                                  radius: Radius.circular(50),
                                  child: Flexible(
                                    child: ListView.builder(
                                      controller: locationScrollController,
                                      itemCount: locationList.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      itemBuilder: (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: (){
                                            setState(() {
                                              locationController.text = '${locationList[index].district} ${locationList[index].state}, ${locationList[index].country}';
                                              selectedLocation = {'district':'${locationList[index].district}','state':'${locationList[index].state}','country':'${locationList[index].country}'};
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: ScreenUtil().setHeight(3)),
                                                child: Text(
                                                  "${locationList[index].district} ${locationList[index].state}, ${locationList[index].country}",
                                                  style: GoogleFonts.nunitoSans(
                                                      fontSize: ScreenUtil().setSp(12),
                                                      fontWeight: FontWeight.w400,
                                                      fontStyle: FontStyle.italic,
                                                      color: Color(0xff4B4E58)
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              locationList[index].isSelected == true ?
                                              Icon(Icons.check_circle_sharp, color: orange, size: 15.sp) : Container()
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
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(16), left: ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(40)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(ScreenUtil().radius(4)),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: descriptionController,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.next,
                          minLines: 5,
                          maxLines: null,
                          cursorColor: black,
                          style: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              color: Color(0xff9B9B9B)),
                          validator: (val){
                            if(val!.isEmpty){
                              return '';
                            } else{
                              return null;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              errorStyle: TextStyle(height:0),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 1.w),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 1.w),
                              ),
                              contentPadding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                borderSide: BorderSide(
                                    color: Color(0xff9B9B9B), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                borderSide: BorderSide(color: lightRed, width: 1),
                              ),
                              hintText: 'Enter Job Description',
                              hintStyle: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(16), left: ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(40)),
                      child: Row(
                        children: [
                          Text(
                            "Exp Level:",
                            style: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              height: 0.19,
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              if(experienceIndex == 1 || experienceIndex == 2){
                                setState(() {
                                  experienceIndex = 0;
                                });
                              }
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(7), left: ScreenUtil().setWidth(10)),
                                  child: Container(
                                    height: ScreenUtil().setHeight(14),
                                    width: ScreenUtil().setWidth(14),
                                    decoration: BoxDecoration(
                                        color: experienceIndex == 0 ? orange : white,
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(color: black)
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(6)),
                                  child: Text(
                                    "Fresher",
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: experienceIndex == 0 ? FontWeight.w700 : FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        height: 0.16,
                                        color: Color(0xff4B4E58)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: (){
                              if(experienceIndex == 0 || experienceIndex == 2){
                                setState(() {
                                  experienceIndex = 1;
                                });
                              }
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(7), left: ScreenUtil().setWidth(8)),
                                  child: Container(
                                    height: ScreenUtil().setHeight(14),
                                    width: ScreenUtil().setWidth(14),
                                    decoration: BoxDecoration(
                                        color: experienceIndex == 1 ? orange : white,
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(color: black)
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(6)),
                                  child: Text(
                                    "Experienced",
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: experienceIndex == 1 ? FontWeight.w700 : FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        height: 0.16,
                                        color: Color(0xff4B4E58)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: (){
                              if(experienceIndex == 0 || experienceIndex == 1){
                                setState(() {
                                  experienceIndex = 2;
                                });
                              }
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(7), left: ScreenUtil().setWidth(8)),
                                  child: Container(
                                    height: ScreenUtil().setHeight(14),
                                    width: ScreenUtil().setWidth(14),
                                    decoration: BoxDecoration(
                                        color: experienceIndex == 2 ? orange : white,
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(color: black)
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(6)),
                                  child: Text(
                                    "Any",
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: experienceIndex == 2 ? FontWeight.w700 : FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        height: 0.16,
                                        color: Color(0xff4B4E58)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(17), left: ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(40)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              onTap: () {
                                setState(() {
                                  selectStartDate(context);
                                });
                              },
                              controller: startController,
                              keyboardType: TextInputType.number,
                              cursorColor: black,
                              readOnly: true,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xff9B9B9B)),
                              validator: (val){
                                if(val!.isEmpty){
                                  return '';
                                } else{
                                  return null;
                                }
                              },
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(height:0),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 1.w),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 1.w),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                    borderSide: BorderSide(
                                        color: Color(0xff9B9B9B), width: 1
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                    borderSide: BorderSide(color: lightRed, width: 1),
                                  ),
                                  contentPadding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                                  hintText: 'Start Date',
                                  hintStyle: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(14),
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                      color: lightGray)
                              ),
                            ),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(5)),
                          Expanded(
                            child: TextFormField(
                              onTap: () {
                                setState(() {
                                  if(startDate == null){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        content: Text('Select Start Date'),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                    return;
                                  }else{
                                    selectEndDate(context);
                                  }
                                });
                              },
                              controller: endController,
                              cursorColor: black,
                              keyboardType: TextInputType.number,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xff9B9B9B)),
                              readOnly: true,
                              validator: (val){
                                if(val!.isEmpty){
                                  return '';
                                } else{
                                  return null;
                                }
                              },
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(height:0),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 1.w),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 1.w),
                                  ),
                                  contentPadding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                    borderSide: BorderSide(
                                        color: Color(0xff9B9B9B), width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                    borderSide: BorderSide(color: lightRed, width: 1),
                                  ),
                                  hintText: 'End Date',
                                  hintStyle: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(14),
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                      color: lightGray)),
                            ),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(5)),
                          Text(
                            '=',
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              color: black,
                              fontSize: ScreenUtil().setSp(12),
                            ),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(5)),
                          Expanded(
                            child: TextFormField(
                              controller: totalController,
                              keyboardType: TextInputType.number,
                              cursorColor: black,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xff9B9B9B)),
                              readOnly: true,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                    borderSide: BorderSide(
                                        color: Color(0xff9B9B9B), width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                    borderSide: BorderSide(color: lightRed, width: 1),
                                  ),
                                  hintText: 'Total Days',
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
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(17), left: ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(40)),
                      child: Row(
                        children: [
                          Text(
                            'Deadline:   ',
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w600,
                                color: black,
                                fontSize: ScreenUtil().setSp(14),
                                letterSpacing: 0.6
                            ),
                          ),
                          Container(
                            width: ScreenUtil().setWidth(100),
                            child: TextFormField(
                              onTap: () {
                                setState(() {
                                  selectDeadlineDate(context);
                                });
                              },
                              controller: deadlineController,
                              keyboardType: TextInputType.number,
                              cursorColor: black,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xff9B9B9B)),
                              readOnly: true,
                              validator: (val){
                                if(val!.isEmpty){
                                  return '';
                                } else{
                                  return null;
                                }
                              },
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(height:0),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 1.w),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 1.w),
                                  ),
                                  contentPadding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                    borderSide: BorderSide(
                                        color: Color(0xff9B9B9B), width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                    borderSide: BorderSide(color: lightRed, width: 1),
                                  ),
                                  hintText: '13-Sept-21',
                                  hintStyle: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(14),
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                      color: lightGray
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(24), left: ScreenUtil().setWidth(21), right: ScreenUtil().setWidth(21)),
                      child: Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xff9B9B9B),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(15), left: ScreenUtil().setWidth(21), right: ScreenUtil().setWidth(21)),
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (val) {
                              searchCategories(val, 'crew');
                            },
                            onSubmitted: (_) {},
                            controller: professionController,
                            maxLines: 1,
                            keyboardType: TextInputType.multiline,
                            cursorColor: black,
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                color: Color(0xff9B9B9B)
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                              hintText: 'Search Profession',
                              hintStyle: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B)
                              ),
                              suffixIcon: Image.asset("assets/icons/search.png", color: Color(0xff9B9B9B)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: lightRed, width: 1)
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: ScreenUtil().setHeight(14)),
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
                                    itemBuilder: (BuildContext ctx, index) {
                                      return InkWell(
                                        onTap: (){
                                          setState(() {
                                            if(categoryList[index].isSelected == true){
                                              categoryList[index].isSelected = false;
                                              categorySelected.remove(categoryList[index]);
                                            }else{
                                              categoryList[index].isSelected = true;
                                              categorySelected.add(categoryList[index]);
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 20.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(ScreenUtil().radius(15)),
                                            border: Border.all(color: black),
                                            color: categoryList[index].isSelected == true ? Color(0xff4B4E58) : Colors.white,
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.r),
                                              child: Text(
                                                categoryList[index].jobName!,
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize: ScreenUtil().setSp(12),
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    color: categoryList[index].isSelected == true ? white : black
                                                ),
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
                            onSubmitted: (_) {},
                            controller: otherController,
                            maxLines: 1,
                            keyboardType: TextInputType.multiline,
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                color: Color(0xff9B9B9B)
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                              hintText: 'Not in the above list? Type here...',
                              hintStyle: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B)
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: lightRed, width: 1)
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: ScreenUtil().setHeight(24), bottom: ScreenUtil().setHeight(24)),
                            child: InkWell(
                              onTap: () async {
                                if(!crewKey.currentState!.validate()){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text('Please fill the details'),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                  return;
                                } else if(categorySelected.isEmpty && otherController.text.isEmpty){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text('Enter or select your profession'),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                  return;
                                } else if(selectedLocation == null){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text('Select interested location'),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                  return;
                                } else{
                                  List category = [];
                                  for(var item in categorySelected){
                                    category.add('"${item.id}"');
                                  }

                                  dynamic body = {
                                    "jobType" : 'crew',
                                    "title": titleController.text,
                                    "description": descriptionController.text,
                                    "experienceLevel": experienceIndex == 0 ? 'fresher' : experienceIndex == 1 ? 'experienced' : 'any',
                                    "startDate": startController.text,
                                    "endDate": endController.text,
                                    "deadline": deadlineController.text,
                                    "jobLocation": jsonEncode(selectedLocation),
                                    "jobCategory": category.toString(),
                                  };

                                  print(body);

                                  await ApiManager.post(param: body, url1: "joblinks/createJob/crew").then((value) async {
                                    if (value.statusCode == 200) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text('Job created successfuly'),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                      Navigator.pop(context);
                                    }
                                  });
                                }
                              },
                              child: Container(
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: white,
                                    border: Border.all(
                                      color: orange,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(25)))
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Create",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(18),
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          color: orange
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                                      child: Icon(Icons.arrow_forward, color: orange, size: 25,),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ) : Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: facesKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(24), left: ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(40)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(ScreenUtil().radius(8)),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: facetitleController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          cursorColor: black,
                          style: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              color: Color(0xff9B9B9B)),
                          validator: (val){
                            if(val!.isEmpty){
                              return '';
                            } else{
                              return null;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              errorStyle: TextStyle(height:0),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 1.w),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 1.w),
                              ),
                              contentPadding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                borderSide: BorderSide(
                                    color: Color(0xff9B9B9B), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                borderSide: BorderSide(color: lightRed, width: 1),
                              ),
                              hintText: 'Enter Job Title',
                              hintStyle: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  color: lightGray)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(16), left: 40.w, right: 40.w),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(ScreenUtil().radius(8)),
                          border: Border.all(color: Color(0xff9B9B9B)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: ScreenUtil().setWidth(10), right: ScreenUtil().setWidth(10)),
                          child: Column(
                            children: [
                              TextFormField(
                                onChanged: (val) {
                                  setState(() async {
                                    famelocationList.clear();
                                    await _getAddressLocation(val, 'faces');
                                  });
                                },
                                controller: famelocationController,
                                maxLines: 1,
                                cursorColor: black,
                                keyboardType: TextInputType.multiline,
                                style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(14),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xff9B9B9B)
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: ScreenUtil().setWidth(15)),
                                  hintText: 'Enter Job Location',
                                  hintStyle: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(14),
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff9B9B9B)
                                  ),
                                  suffixIcon: Image.asset("assets/icons/search.png", color: Color(0xff9B9B9B)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: famelocationList.length == 0 ? Colors.transparent : darkGray, width: 1)
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: famelocationList.length == 0 ? Colors.transparent : lightRed, width: 1)
                                  ),
                                ),
                              ),
                              famelocationList.length == 0 ? Container() :
                              Padding(
                                padding: EdgeInsets.only(top: ScreenUtil().setHeight(10), bottom: ScreenUtil().setHeight(10)),
                                child: Scrollbar(
                                  controller: famelocationScrollController,
                                  isAlwaysShown: true,
                                  thickness: 3,
                                  trackVisibility: true,
                                  radius: Radius.circular(50),
                                  child: Flexible(
                                    child: ListView.builder(
                                      controller: famelocationScrollController,
                                      itemCount: famelocationList.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      itemBuilder: (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: (){
                                            setState(() {
                                              famelocationController.text = "${famelocationList[index].district} ${famelocationList[index].state}, ${famelocationList[index].country}";
                                              facesselectedLocation = {'district':'${famelocationList[index].district}','state':'${famelocationList[index].state}','country':'${famelocationList[index].country}'};
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: ScreenUtil().setHeight(3)),
                                                child: Text(
                                                  "${famelocationList[index].district} ${famelocationList[index].state}, ${famelocationList[index].country}",
                                                  style: GoogleFonts.nunitoSans(
                                                      fontSize: ScreenUtil().setSp(12),
                                                      fontWeight: FontWeight.w400,
                                                      fontStyle: FontStyle.italic,
                                                      color: Color(0xff4B4E58)
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              famelocationList[index].isSelected == true ?
                                              Icon(Icons.check_circle_sharp, color: orange, size: 15.sp) : Container()
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
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(16), left: ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(40)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(ScreenUtil().radius(4)),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: facedescriptionController,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.next,
                          minLines: 5,
                          maxLines: null,
                          cursorColor: black,
                          style: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              color: Color(0xff9B9B9B)),
                          validator: (val){
                            if(val!.isEmpty){
                              return '';
                            } else{
                              return null;
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              errorStyle: TextStyle(height:0),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 1.w),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 1.w),
                              ),
                              contentPadding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                borderSide: BorderSide(
                                    color: Color(0xff9B9B9B), width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                borderSide: BorderSide(color: lightRed, width: 1),
                              ),
                              hintText: 'Enter Job Description',
                              hintStyle: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(17), left: ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(40)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              onTap: () {
                                setState(() {
                                  facesselectStartDate(context);
                                });
                              },
                              controller: facesstartController,
                              keyboardType: TextInputType.number,
                              cursorColor: black,
                              readOnly: true,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xff9B9B9B)),
                              validator: (val){
                                if(val!.isEmpty){
                                  return '';
                                } else{
                                  return null;
                                }
                              },
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(height:0),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 1.w),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 1.w),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                    borderSide: BorderSide(
                                        color: Color(0xff9B9B9B), width: 1
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                    borderSide: BorderSide(color: lightRed, width: 1),
                                  ),
                                  contentPadding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                                  hintText: 'Start Date',
                                  hintStyle: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(14),
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                      color: lightGray)
                              ),
                            ),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(5)),
                          Expanded(
                            child: TextFormField(
                              onTap: () {
                                setState(() {
                                  if(facesstartDate == null){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        content: Text('Select Start Date'),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                    return;
                                  }else{
                                    facesselectEndDate(context);
                                  }
                                });
                              },
                              controller: facesendController,
                              cursorColor: black,
                              keyboardType: TextInputType.number,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xff9B9B9B)),
                              readOnly: true,
                              validator: (val){
                                if(val!.isEmpty){
                                  return '';
                                } else{
                                  return null;
                                }
                              },
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(height:0),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 1.w),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 1.w),
                                  ),
                                  contentPadding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                    borderSide: BorderSide(
                                        color: Color(0xff9B9B9B), width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                    borderSide: BorderSide(color: lightRed, width: 1),
                                  ),
                                  hintText: 'End Date',
                                  hintStyle: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(14),
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                      color: lightGray)),
                            ),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(5)),
                          Text(
                            '=',
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              color: black,
                              fontSize: ScreenUtil().setSp(12),
                            ),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(5)),
                          Expanded(
                            child: TextFormField(
                              controller: facestotalController,
                              keyboardType: TextInputType.number,
                              cursorColor: black,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xff9B9B9B)),
                              readOnly: true,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                    borderSide: BorderSide(
                                        color: Color(0xff9B9B9B), width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                    borderSide: BorderSide(color: lightRed, width: 1),
                                  ),
                                  hintText: 'Total Days',
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
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(17), left: ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(40)),
                      child: Row(
                        children: [
                          Text(
                            'Deadline:   ',
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w600,
                                color: black,
                                fontSize: ScreenUtil().setSp(14),
                                letterSpacing: 0.6
                            ),
                          ),
                          Container(
                            width: ScreenUtil().setWidth(100),
                            child: TextFormField(
                              onTap: () {
                                setState(() {
                                  facesselectDeadlineDate(context);
                                });
                              },
                              controller: facesdeadlineController,
                              keyboardType: TextInputType.number,
                              cursorColor: black,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xff9B9B9B)),
                              readOnly: true,
                              validator: (val){
                                if(val!.isEmpty){
                                  return '';
                                } else{
                                  return null;
                                }
                              },
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(height:0),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 1.w),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 1.w),
                                  ),
                                  contentPadding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                    borderSide: BorderSide(
                                        color: Color(0xff9B9B9B), width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                    borderSide: BorderSide(color: lightRed, width: 1),
                                  ),
                                  hintText: '13-Sept-21',
                                  hintStyle: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(14),
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                      color: lightGray
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(24), left: ScreenUtil().setWidth(21), right: ScreenUtil().setWidth(21)),
                      child: Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xff9B9B9B),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(24), left: ScreenUtil().setWidth(21), right: ScreenUtil().setWidth(21)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                                child: Text(
                                  'Age  ',
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w600,
                                      color: black,
                                      fontSize: ScreenUtil().setSp(14),
                                      letterSpacing: 0.6
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GridView.builder(
                                  padding: EdgeInsets.all(0.0),
                                  primary: false,
                                  scrollDirection: Axis.vertical,
                                  gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    childAspectRatio: 2,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                  ),
                                  itemCount: ageGroup.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return InkWell(
                                      onTap: (){
                                        setState(() {
                                          ageSelected = ageGroup[index];
                                        });
                                      },
                                      child: Wrap(
                                        children: [
                                          Container(
                                            width: 70,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(ScreenUtil().radius(15)),
                                              border: Border.all(color: black),
                                              color: ageSelected == ageGroup[index] ? Color(0xff4B4E58) : Colors.white,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(top: ScreenUtil().setHeight(6), bottom: ScreenUtil().setHeight(6)),
                                              child: Text(
                                                ageGroup[index],
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize: ScreenUtil().setSp(12),
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    color: ageSelected == ageGroup[index] ? white : black
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                                  child: Text(
                                    'Gender  ',
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w600,
                                        color: black,
                                        fontSize: ScreenUtil().setSp(14),
                                        letterSpacing: 0.6
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      if(genderIndex == 1 || genderIndex == 2){
                                        setState(() {
                                          genderIndex = 0;
                                        });
                                      }
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: ScreenUtil().setHeight(40),
                                        width: ScreenUtil().setWidth(40),
                                        padding: EdgeInsets.zero,
                                        decoration: BoxDecoration(
                                            color: genderIndex == 0 ? darkGray : white,
                                            border: Border.all(
                                              color:  genderIndex == 0 ? white : lightGray,
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(20)))),
                                        child: SvgPicture.asset(
                                            "assets/icons/svg/male.svg",
                                            color:  genderIndex == 0
                                                ? white
                                                : lightGray,
                                            fit: BoxFit.scaleDown
                                        ),
                                      ),
                                      Text(
                                        'Male',
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w600,
                                            color: genderIndex == 0
                                                ? black
                                                : lightGray,
                                            fontSize: ScreenUtil().setSp(12),
                                            letterSpacing: 0.6
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(genderIndex == 0 || genderIndex == 2){
                                          setState(() {
                                            genderIndex = 1;
                                          });
                                        }
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: ScreenUtil().setHeight(40),
                                          width: ScreenUtil().setWidth(40),
                                          padding: EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                              color: genderIndex == 1 ? darkGray : white,
                                              border: Border.all(
                                                color:  genderIndex == 1 ? white : lightGray,
                                              ),
                                              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(20)))),
                                          child: SvgPicture.asset(
                                              "assets/icons/svg/female.svg",
                                              color:  genderIndex == 1
                                                  ? white
                                                  : lightGray,
                                              fit: BoxFit.scaleDown
                                          ),
                                        ),
                                        Text(
                                          'Female',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w600,
                                              color: genderIndex == 1
                                                  ? black
                                                  : lightGray,
                                              fontSize: ScreenUtil().setSp(12),
                                              letterSpacing: 0.6
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(genderIndex == 0 || genderIndex == 1){
                                          setState(() {
                                            genderIndex = 2;
                                          });
                                        }
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: ScreenUtil().setHeight(40),
                                          width: ScreenUtil().setWidth(40),
                                          padding: EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                              color: genderIndex == 2 ? darkGray : white,
                                              border: Border.all(
                                                color:  genderIndex == 2 ? white : lightGray,
                                              ),
                                              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(20)))),
                                          child: Image.asset(
                                              "assets/icons/line.png",
                                              color: genderIndex == 2
                                                  ? white
                                                  : lightGray,
                                              fit: BoxFit.scaleDown
                                          ),
                                        ),
                                        Text(
                                          'Other',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w600,
                                              color: genderIndex == 2
                                                  ? black
                                                  : lightGray,
                                              fontSize: ScreenUtil().setSp(12),
                                              letterSpacing: 0.6
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                            child: Row(
                                children: [
                                  Text(
                                    'Height  ',
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w600,
                                        color: black,
                                        fontSize: ScreenUtil().setSp(14),
                                        letterSpacing: 0.6
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      onChanged: (_) {},
                                      controller: ftController,
                                      keyboardType: TextInputType.number,
                                      cursorColor: black,
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(14),
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.italic,
                                          color: Color(0xff9B9B9B)),
                                      readOnly: true,
                                      validator: (val){
                                        if(val!.isEmpty){
                                          return '';
                                        } else{
                                          return null;
                                        }
                                      },
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                          errorStyle: TextStyle(height:0),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red, width: 1.w),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red, width: 1.w),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                            borderSide: BorderSide(
                                                color: Color(0xff9B9B9B), width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                            borderSide: BorderSide(color: lightRed, width: 1),
                                          ),
                                          contentPadding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                                          suffixIcon: Padding(
                                            padding: EdgeInsets.only(top: ScreenUtil().setHeight(3)),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    setState(() {
                                                      ftCount++;
                                                      ftController.text = ftCount.toString();
                                                      print(ftController);
                                                    });
                                                  },
                                                  child: Container(height: 20, width: 20,
                                                      child: Icon(Icons.arrow_drop_up_outlined, color: lightGray,)),
                                                ),
                                                InkWell(
                                                    onTap: (){
                                                      setState(() {
                                                        if(ftCount != 1){
                                                          ftCount--;
                                                          ftController.text = ftCount.toString();
                                                        }
                                                      });
                                                    },
                                                    child: Container(height: 20, width: 20,child: Icon(Icons.arrow_drop_down_sharp, color: lightGray,))
                                                ),
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
                                  SizedBox(width: 8,),
                                  Expanded(
                                    child: TextFormField(
                                      onChanged: (_) {},
                                      controller: inController,
                                      cursorColor: black,
                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(14),
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.italic,
                                          color: Color(0xff9B9B9B)),
                                      readOnly: true,
                                      validator: (val){
                                        if(val!.isEmpty){
                                          return '';
                                        } else{
                                          return null;
                                        }
                                      },
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                          errorStyle: TextStyle(height:0),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red, width: 1.w),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red, width: 1.w),
                                          ),
                                          contentPadding: EdgeInsets.only(top: ScreenUtil().setWidth(10), left: ScreenUtil().setWidth(10)),
                                          suffixIcon: Padding(
                                            padding: EdgeInsets.only(top: ScreenUtil().setHeight(3)),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    setState(() {
                                                      inCount++;
                                                      inController.text = inCount.toString();
                                                    });
                                                  },
                                                  child: Container(height: 20, width: 20,
                                                      child: Icon(Icons.arrow_drop_up_outlined, color: lightGray,)),
                                                ),
                                                InkWell(
                                                    onTap: (){
                                                      setState(() {
                                                        if(inCount != 1){
                                                          inCount--;
                                                          inController.text = inCount.toString();
                                                        }
                                                      });
                                                    },
                                                    child: Container(height: 20, width: 20,child: Icon(Icons.arrow_drop_down_sharp, color: lightGray,))
                                                ),
                                              ],
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                            borderSide: BorderSide(
                                                color: Color(0xff9B9B9B), width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                                            borderSide: BorderSide(color: lightRed, width: 1),
                                          ),
                                          hintText: 'in.',
                                          hintStyle: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(14),
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w400,
                                              color: lightGray)),
                                    ),
                                  ),
                                ]),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                            child: Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: Color(0xff9B9B9B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(15), left: ScreenUtil().setWidth(21), right: ScreenUtil().setWidth(21)),
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (val) {
                              searchCategories(val, 'faces');
                            },
                            onSubmitted: (_) {},
                            controller: facesprofessionController,
                            maxLines: 1,
                            keyboardType: TextInputType.multiline,
                            cursorColor: black,
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                color: Color(0xff9B9B9B)
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                              hintText: 'Search Profession',
                              hintStyle: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B)
                              ),
                              suffixIcon: Image.asset("assets/icons/search.png", color: Color(0xff9B9B9B)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: lightRed, width: 1)
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: ScreenUtil().setHeight(14)),
                            child: Scrollbar(
                              controller: facesCategoryScrollController,
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
                                    itemCount: facesCategoryList.length,
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return InkWell(
                                        onTap: (){
                                          setState(() {
                                            if(facesCategoryList[index].isSelected == true){
                                              facesCategoryList[index].isSelected = false;
                                              facesCategorySelected.remove(facesCategoryList[index]);
                                            }else{
                                              facesCategoryList[index].isSelected = true;
                                              facesCategorySelected.add(facesCategoryList[index]);
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 20.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(ScreenUtil().radius(15)),
                                            border: Border.all(color: black),
                                            color: facesCategoryList[index].isSelected == true ? Color(0xff4B4E58) : Colors.white,
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.r),
                                              child: Text(
                                                facesCategoryList[index].jobName!,
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize: ScreenUtil().setSp(12),
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    color: facesCategoryList[index].isSelected == true ? white : black
                                                ),
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
                            onSubmitted: (_) {},
                            controller: facesotherController,
                            maxLines: 1,
                            keyboardType: TextInputType.multiline,
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                color: Color(0xff9B9B9B)
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                              hintText: 'Not in the above list? Type here...',
                              hintStyle: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B)
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: lightRed, width: 1)
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: ScreenUtil().setHeight(24), bottom: ScreenUtil().setHeight(24)),
                            child: InkWell(
                              onTap: () async {
                                if(!facesKey.currentState!.validate()){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text('Please fill the details'),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                  return;
                                } else if(ageSelected == null){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text('Select age group'),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                  return;
                                } else if(facesCategorySelected.isEmpty && facesotherController.text.isEmpty){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text('Enter or select your profession'),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                  return;
                                } else if(facesselectedLocation == null){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text('Select interested location'),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                  return;
                                } else{
                                  List category = [];
                                  List<Map<String, String>> age = [{'groupA':'0 - 4', 'groupB':'4 - 12', 'groupC':'12 - 18', 'groupD':'18 - 28', 'groupE':'18 - 28', 'groupF':'28 - 40', 'groupG':'40 - 50', 'groupH':'50 - 60', 'groupI':'60+'}];
                                  String age1;

                                  for(var item in age){
                                    for(var i in item.entries){
                                      if(ageSelected == i.value){
                                        age1 = i.key;
                                      }
                                    }
                                  }

                                  dynamic height = {'foot':ftController.text,'inch':inController.text};
                                  print(jsonEncode(height));

                                  for(var item in facesCategorySelected){
                                    category.add('"${item.id}"');
                                  }

                                  dynamic body = {
                                    "jobType" : 'faces',
                                    "title": facetitleController.text,
                                    "jobLocation": jsonEncode(facesselectedLocation),
                                    "description": facedescriptionController.text,
                                    "startDate": facesstartController.text,
                                    "endDate": facesendController.text,
                                    "deadline": facesdeadlineController.text,
                                    "ageGroup": age,
                                    'height': jsonEncode(height),
                                    'gender': genderIndex == 0 ? 'male' : genderIndex == 1 ? 'female' : 'other',
                                    "jobCategory": category.toString(),
                                  };

                                  print(body);

                                  await ApiManager.post(param: body, url1: "joblinks/createJob/faces").then((value) async {
                                    if (value.statusCode == 200) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text('Job created successfuly'),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                      Navigator.pop(context);
                                    } else{
                                      print(value.body);
                                    }
                                  });
                                }
                              },
                              child: Container(
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: white,
                                    border: Border.all(
                                      color: orange,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(25)))
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Create",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(18),
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          color: orange
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                                      child: Icon(Icons.arrow_forward, color: orange, size: 25,),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DateTime? startDate;
  DateTime? facesstartDate;

  selectStartDate(BuildContext context) async {
    startDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (startDate != null) {
      setState(() {
        startController
          ..text = DateFormat("dd-MM-yyyy").format(startDate!)
          ..selection = TextSelection.fromPosition(
              TextPosition(
                  offset: startController.text.length,
                  affinity: TextAffinity.upstream
              )
          );
      });
    }
  }

  selectEndDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: startDate!,
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (newSelectedDate != null) {
      setState(() {
        endController
          ..text = DateFormat("dd-MM-yyyy").format(newSelectedDate)
          ..selection = TextSelection.fromPosition(
              TextPosition(
                  offset: endController.text.length,
                  affinity: TextAffinity.upstream
              )
          );

        totalController.text = newSelectedDate.difference(startDate!).inDays.toString();
      });
    }
  }

  selectDeadlineDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (newSelectedDate != null) {
      setState(() {
        deadlineController
          ..text = DateFormat("dd-MM-yyyy").format(newSelectedDate)
          ..selection = TextSelection.fromPosition(
              TextPosition(
                  offset: deadlineController.text.length,
                  affinity: TextAffinity.upstream
              )
          );
      });
    }
  }


  facesselectStartDate(BuildContext context) async {
    facesstartDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (facesstartDate != null) {
      setState(() {
        facesstartController
          ..text = DateFormat("dd-MM-yyyy").format(facesstartDate!)
          ..selection = TextSelection.fromPosition(
              TextPosition(
                  offset: facesstartController.text.length,
                  affinity: TextAffinity.upstream
              )
          );
      });
    }
  }

  facesselectEndDate(BuildContext context) async {
    DateTime? newSelectedDate1 = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: facesstartDate!,
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (newSelectedDate1 != null) {
      setState(() {
        facesendController
          ..text = DateFormat("dd-MM-yyyy").format(newSelectedDate1)
          ..selection = TextSelection.fromPosition(
              TextPosition(
                  offset: facesendController.text.length,
                  affinity: TextAffinity.upstream
              )
          );

        facestotalController.text = newSelectedDate1.difference(facesstartDate!).inDays.toString();
      });
    }
  }

  facesselectDeadlineDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (newSelectedDate != null) {
      setState(() {
        facesdeadlineController
          ..text = DateFormat("dd-MM-yyyy").format(newSelectedDate)
          ..selection = TextSelection.fromPosition(
              TextPosition(
                  offset: facesdeadlineController.text.length,
                  affinity: TextAffinity.upstream
              )
          );
      });
    }
  }
}