import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:famelink/util/colors.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../util/constants.dart';
import '../../../util/dimens.dart';
import 'provider/job_appliction_provider.dart';
import 'widget/joblinkapplictionpage.dart';

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
  @override
  void initState() {
    super.initState();
    final pro =
        Provider.of<JobLinksApplicationProvider>(context, listen: false);
    pro.fameScrollController.addListener(() {
      if (pro.fameScrollController.position.maxScrollExtent ==
          pro.fameScrollController.position.pixels) {
        pro.page++;
      }
    });
    pro.getApplicants(widget.id, context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobLinksApplicationProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: appBarLayout(provider),
          body: provider.applicantsList.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                    color: black,
                    strokeWidth: 3,
                  ),
                )
              : Column(
                  children: [
                    actionLayout(provider),
                    Expanded(
                      child: JobLinksApplication(),
                    )
                  ],
                ),
        );
      },
    );
  }

  PreferredSizeWidget appBarLayout(JobLinksApplicationProvider provider) {
    return AppBar(
      elevation: 0,
      backgroundColor: Clr().white,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: black,
          size: 25,
        ),
      ),
      centerTitle: true,
      title: Text(
        "${widget.title}",
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.nunitoSans(
          fontSize: ScreenUtil().setSp(14),
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          color: black,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size(0, 0),
        child: provider.applicantsList.isEmpty
            ? Container()
            : Stack(
                fit: StackFit.loose,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "(${provider.applicantsList[0].newApplicants} new / total ${provider.applicantsList[0].totalApplicants})",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(10),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                          height: 0.13,
                          color: Color(0xff0060FF),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: Dim().d12.w,
                    child: Text(
                      "(${provider.applicantsList[0].hired} Hired)",
                      style: GoogleFonts.nunitoSans(
                        fontSize: ScreenUtil().setSp(10),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        height: 0.13,
                        color: black,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget actionLayout(JobLinksApplicationProvider provider) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                provider.updateList('bookmark');
              },
              splashRadius: Dim().d20.r,
              icon: SvgPicture.asset(
                "assets/icons/svg/bookmark.svg",
                color: darkGray,
              ),
            ),
            IconButton(
              onPressed: () {
                provider.updateList('sort');
              },
              splashRadius: Dim().d20.r,
              icon: SvgPicture.asset(
                "assets/icons/svg/filter1.svg",
                color: darkGray,
              ),
            ),
            IconButton(
              onPressed: () {
                provider.updateList('search');
              },
              splashRadius: Dim().d20.r,
              icon: SvgPicture.asset(
                "assets/icons/svg/search.svg",
                color: darkGray,
              ),
            ),
            IconButton(
              onPressed: () {
                provider.updateList('filter');
              },
              splashRadius: Dim().d20.r,
              icon: Padding(
                padding: EdgeInsets.only(
                  top: 6.h,
                ),
                child: SvgPicture.asset(
                  '${Constants().filterSvg}',
                  color: darkGray,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                provider.showMore(provider.isExpanded);
              },
              splashRadius: Dim().d20.r,
              icon: SvgPicture.asset(
                "assets/icons/svg/expand.svg",
                color: provider.isExpanded ? black : darkGray,
              ),
            ),
          ],
        ),
        if (provider.isSearch) searchLayout(provider),
        if (provider.isFilter) filterLayout(provider),
      ],
    );
  }

  Widget searchLayout(JobLinksApplicationProvider provider) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dim().d12.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil().radius(8)),
        color: Colors.white,
      ),
      child: TextFormField(
        cursorColor: black,
        controller: provider.searchController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.search,
        style: GoogleFonts.nunitoSans(
          fontSize: ScreenUtil().setSp(14),
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
          color: Color(0xff9B9B9B),
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(
            ScreenUtil().setWidth(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              ScreenUtil().radius(10),
            ),
            borderSide: BorderSide(
              color: Color(0xff9B9B9B),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
            borderSide: BorderSide(
              color: lightRed,
              width: 1,
            ),
          ),
          suffixIcon: Image.asset(
            "assets/icons/search.png",
            color: Color(
              0xff9B9B9B,
            ),
          ),
          hintText: 'Search',
          hintStyle: GoogleFonts.nunitoSans(
            fontSize: ScreenUtil().setSp(14),
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
            color: lightGray,
          ),
        ),
        onChanged: (v) {
          provider.updateList('search', value: v);
        },
        onFieldSubmitted: (v) {
          provider.updateList('search', value: v);
        },
      ),
    );
  }

  Widget filterLayout(JobLinksApplicationProvider provider) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dim().d12.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.jobType == 'crew'
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff9B9B9B)),
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      value: provider.strWorkExp,
                      hint: Text(
                        "Work Experience",
                        style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(14),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            color: lightGray),
                      ),
                      isExpanded: true,
                      onChanged: (String? value) {
                        setState(() {
                          provider.strWorkExp = value;
                          provider.updateList('filter', value: 'Updated');
                        });
                      },
                      items: provider.exp.map((value) {
                        return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(
                            value.toString(),
                            style: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w400,
                              color: lightGray,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: provider.ftController,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                color: Color(0xff9B9B9B)),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.w),
                                ),
                                errorStyle: TextStyle(height: 0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff9B9B9B), width: 1),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.w),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: lightRed, width: 1),
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
                                            provider.ftCount++;
                                            provider.ftController.text =
                                                provider.ftCount.toString();
                                          });
                                        },
                                        child: Container(
                                            height: 20,
                                            width: 20,
                                            child: Icon(
                                              Icons.arrow_drop_up_outlined,
                                              color: lightGray,
                                            )),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (provider.ftCount != 1) {
                                                provider.ftCount--;
                                                provider.ftController.text =
                                                    provider.ftCount.toString();
                                              }
                                            });
                                          },
                                          child: Container(
                                              height: 20,
                                              width: 20,
                                              child: Icon(
                                                Icons.arrow_drop_down_sharp,
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
                            controller: provider.inController,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                color: Color(0xff9B9B9B)),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.w),
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
                                            provider.inCount++;
                                            provider.inController.text =
                                                provider.inCount.toString();
                                          });
                                        },
                                        child: Container(
                                            height: 20,
                                            width: 20,
                                            child: Icon(
                                              Icons.arrow_drop_up_outlined,
                                              color: lightGray,
                                            )),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (provider.inCount != 1) {
                                                provider.inCount--;
                                                provider.inController.text =
                                                    provider.inCount.toString();
                                              }
                                            });
                                          },
                                          child: Container(
                                              height: 20,
                                              width: 20,
                                              child: Icon(
                                                Icons.arrow_drop_down_sharp,
                                                color: lightGray,
                                              ))),
                                    ],
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff9B9B9B), width: 1),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.w),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: lightRed, width: 1),
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
                            controller: provider.weightController,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                color: Color(0xff9B9B9B)),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.w),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.w),
                                ),
                                errorStyle: TextStyle(height: 0),
                                contentPadding:
                                    EdgeInsets.all(ScreenUtil().setWidth(10)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff9B9B9B), width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: lightRed, width: 1),
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
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(12)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: provider.bustController,
                              keyboardType: TextInputType.number,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xff9B9B9B)),
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
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: lightGray, width: 1.w),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: lightRed, width: 1),
                                  ),
                                  contentPadding:
                                      EdgeInsets.all(ScreenUtil().setWidth(10)),
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
                              controller: provider.waistController,
                              keyboardType: TextInputType.number,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xff9B9B9B)),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1.w),
                                  ),
                                  errorStyle: TextStyle(height: 0),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1.w),
                                  ),
                                  contentPadding:
                                      EdgeInsets.all(ScreenUtil().setWidth(10)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff9B9B9B), width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: lightRed, width: 1),
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
                              controller: provider.hipController,
                              keyboardType: TextInputType.number,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xff9B9B9B)),
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
                                  contentPadding:
                                      EdgeInsets.all(ScreenUtil().setWidth(10)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff9B9B9B), width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: lightRed, width: 1),
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
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(12)),
                      child: TextFormField(
                        onChanged: (_) {},
                        controller: provider.eyeController,
                        keyboardType: TextInputType.name,
                        style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: Color(0xff9B9B9B)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.w),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.w),
                            ),
                            contentPadding:
                                EdgeInsets.all(ScreenUtil().setWidth(10)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff9B9B9B), width: 1),
                            ),
                            errorStyle: TextStyle(height: 0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: lightRed, width: 1),
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
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(12)),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff9B9B9B)),
                          borderRadius: BorderRadius.circular(7.r),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            value: provider.strComplexion,
                            hint: Text(
                              "Complexion",
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
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
                                provider.strComplexion = value;
                              });
                            },
                            items: provider.complexion.map((value) {
                              return DropdownMenuItem<String>(
                                value: value.toString(),
                                child: Text(value.toString(),
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(14),
                                        fontWeight: FontWeight.w400,
                                        color: lightGray)),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: () {
                        if (provider.ftController.text != '' ||
                            provider.inController.text != '' ||
                            provider.weightController.text != '' ||
                            provider.bustController.text != '' ||
                            provider.waistController.text != '' ||
                            provider.hipController.text != '' ||
                            provider.eyeController.text != '' ||
                            provider.strComplexion != null) {
                          provider.updateList('filter', value: 'Updated');
                        } else {
                          setState(() {
                            var snackBar =
                                SnackBar(content: Text('Please add details'));
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
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: lightGray),
                        ),
                        child: Center(
                          child: Text(
                            'Apply Filter',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w600,
                              color: black,
                              fontSize: ScreenUtil().setSp(14),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
