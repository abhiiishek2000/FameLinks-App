import 'package:famelink/ui/joblinks/createjob/widget/searchfieldsjob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../util/config/color.dart';
import '../../../../util/dimens.dart';
import '../../widget/searchprofession.dart';
import '../provider/jobcreateprovider.dart';

class FrontJob extends StatelessWidget {
  const FrontJob({super.key, this.id});

  final id;

  @override
  Widget build(BuildContext context) {
    return Consumer<JobCreateprovider>(
      builder: (context, provider, child) {
        return Form(
          key: JobCreateprovider.facesKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(24),
                  left: ScreenUtil().setWidth(40),
                  right: ScreenUtil().setWidth(40),
                ),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtil().radius(8)),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: provider.facetitleController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.w),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.w),
                        ),
                        contentPadding:
                            EdgeInsets.all(ScreenUtil().setWidth(10)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().radius(10)),
                          borderSide:
                              BorderSide(color: Color(0xff9B9B9B), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().radius(10)),
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
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(16), left: 40.w, right: 40.w),
                child: Container(
                  // height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtil().radius(8)),
                    border: Border.all(color: Color(0xff9B9B9B)),
                    color: Colors.white,
                  ),
                  child: SearchLocationjob(
                    locationcon: provider.famelocationController,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(16),
                    left: ScreenUtil().setWidth(40),
                    right: ScreenUtil().setWidth(40)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtil().radius(4)),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: provider.facedescriptionController,
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
                    validator: (val) {
                      if (val!.isEmpty) {
                        return '';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.w),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.w),
                        ),
                        contentPadding:
                            EdgeInsets.all(ScreenUtil().setWidth(10)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().radius(10)),
                          borderSide:
                              BorderSide(color: Color(0xff9B9B9B), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().radius(10)),
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
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(17),
                    left: ScreenUtil().setWidth(40),
                    right: ScreenUtil().setWidth(40)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onTap: () {
                          // setState(() {
                          provider.facesselectStartDate(context);
                          //  });
                        },
                        controller: provider.facesstartController,
                        keyboardType: TextInputType.number,
                        cursorColor: black,
                        readOnly: true,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                          color: Color(0xff9B9B9B),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return '';
                          } else {
                            return null;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            errorStyle: TextStyle(height: 0),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.w),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.w),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().radius(10)),
                              borderSide: BorderSide(
                                  color: Color(0xff9B9B9B), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().radius(10)),
                              borderSide: BorderSide(color: lightRed, width: 1),
                            ),
                            isCollapsed: true,
                            contentPadding:
                                EdgeInsets.all(ScreenUtil().setWidth(4)),
                            hintText: 'Start Date',
                            hintStyle: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                color: lightGray)),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(5)),
                    Expanded(
                      child: TextFormField(
                        onTap: () {
                          //setState(() {
                          if (provider.facesstartDate == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text('Select Start Date'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                            return;
                          } else {
                            provider.facesselectEndDate(context);
                          }
                          // });
                        },
                        controller: provider.facesendController,
                        cursorColor: black,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: Color(0xff9B9B9B)),
                        readOnly: true,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return '';
                          } else {
                            return null;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            errorStyle: TextStyle(height: 0),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.w),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.w),
                            ),
                            isCollapsed: true,
                            contentPadding:
                                EdgeInsets.all(ScreenUtil().setWidth(4)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().radius(10)),
                              borderSide: BorderSide(
                                  color: Color(0xff9B9B9B), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().radius(10)),
                              borderSide: BorderSide(color: lightRed, width: 1),
                            ),
                            hintText: 'End Date',
                            hintStyle: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
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
                        controller: provider.facestotalController,
                        keyboardType: TextInputType.number,
                        cursorColor: black,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: Color(0xff9B9B9B)),
                        readOnly: true,
                        decoration: InputDecoration(
                            isCollapsed: true,
                            contentPadding:
                                EdgeInsets.all(ScreenUtil().setWidth(4)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().radius(10)),
                              borderSide: BorderSide(
                                  color: Color(0xff9B9B9B), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().radius(10)),
                              borderSide: BorderSide(color: lightRed, width: 1),
                            ),
                            hintText: 'Total Days',
                            hintStyle: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
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
                    top: ScreenUtil().setHeight(17),
                    left: ScreenUtil().setWidth(40),
                    right: ScreenUtil().setWidth(40)),
                child: Row(
                  children: [
                    Text(
                      'Deadline:   ',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w600,
                          color: black,
                          fontSize: ScreenUtil().setSp(14),
                          letterSpacing: 0.6),
                    ),
                    IntrinsicWidth(
                      child: TextFormField(
                        onTap: () {
                          //setState(() {
                          provider.facesselectDeadlineDate(context);
                          //    });
                        },
                        controller: provider.facesdeadlineController,
                        keyboardType: TextInputType.number,
                        cursorColor: black,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: Color(0xff9B9B9B)),
                        readOnly: true,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return '';
                          } else {
                            return null;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            errorStyle: TextStyle(height: 0),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.w),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.w),
                            ),
                            isCollapsed: true,
                            contentPadding:
                                EdgeInsets.all(ScreenUtil().setWidth(4)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().radius(10)),
                              borderSide: BorderSide(
                                  color: Color(0xff9B9B9B), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().radius(10)),
                              borderSide: BorderSide(color: lightRed, width: 1),
                            ),
                            hintText: '13-Sept-21',
                            hintStyle: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
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
                    top: ScreenUtil().setHeight(24),
                    left: ScreenUtil().setWidth(21),
                    right: ScreenUtil().setWidth(21)),
                child: Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xff9B9B9B),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(24),
                    left: ScreenUtil().setWidth(21),
                    right: ScreenUtil().setWidth(21)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                          child: Text(
                            'Age  ',
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w600,
                                color: black,
                                fontSize: ScreenUtil().setSp(14),
                                letterSpacing: 0.6),
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
                            itemCount: provider.ageGroup.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext ctx, index) {
                              return InkWell(
                                onTap: () {
                                  //setState(() {
                                  print(provider.ageGroup[index]);
                                  provider.changeage(provider.ageGroup[index]);

                                  //    });
                                },
                                child: Wrap(
                                  children: [
                                    Container(
                                      width: 70,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().radius(15)),
                                        border: Border.all(color: black),
                                        color: provider.ageSelected ==
                                                provider.ageGroup[index]
                                            ? Color(0xff4B4E58)
                                            : Colors.white,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(2),
                                            bottom: ScreenUtil().setHeight(2)),
                                        child: Text(
                                          provider.ageGroup[index],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(12),
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              color: provider.ageSelected ==
                                                      provider.ageGroup[index]
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
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(20)),
                              child: Text(
                                'Gender  ',
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w600,
                                    color: black,
                                    fontSize: ScreenUtil().setSp(14),
                                    letterSpacing: 0.6),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                //setState(() {
                                if (provider.genderIndex == 1 ||
                                    provider.genderIndex == 2) {
                                  //    setState(() {
                                  provider.changegender(0);
                                  //  });
                                }
                                // });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: ScreenUtil().setHeight(30),
                                    width: ScreenUtil().setWidth(30),
                                    padding: EdgeInsets.zero,
                                    decoration: BoxDecoration(
                                        color: provider.genderIndex == 0
                                            ? darkGray
                                            : white,
                                        border: Border.all(
                                          color: provider.genderIndex == 0
                                              ? white
                                              : lightGray,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil().setSp(20)))),
                                    child: SvgPicture.asset(
                                        "assets/icons/svg/male.svg",
                                        color: provider.genderIndex == 0
                                            ? white
                                            : lightGray,
                                        fit: BoxFit.scaleDown),
                                  ),
                                  Text(
                                    'Male',
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w600,
                                        color: provider.genderIndex == 0
                                            ? black
                                            : lightGray,
                                        fontSize: ScreenUtil().setSp(12),
                                        letterSpacing: 0.6),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(5)),
                              child: InkWell(
                                onTap: () {
                                  //setState(() {
                                  if (provider.genderIndex == 0 ||
                                      provider.genderIndex == 2) {
                                    // setState(() {
                                    provider.changegender(1);

                                    //  });
                                  }
                                  //    });
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: ScreenUtil().setHeight(30),
                                      width: ScreenUtil().setWidth(30),
                                      padding: EdgeInsets.zero,
                                      decoration: BoxDecoration(
                                          color: provider.genderIndex == 1
                                              ? darkGray
                                              : white,
                                          border: Border.all(
                                            color: provider.genderIndex == 1
                                                ? white
                                                : lightGray,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenUtil().setSp(20)))),
                                      child: SvgPicture.asset(
                                          "assets/icons/svg/female.svg",
                                          color: provider.genderIndex == 1
                                              ? white
                                              : lightGray,
                                          fit: BoxFit.scaleDown),
                                    ),
                                    Text(
                                      'Female',
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w600,
                                          color: provider.genderIndex == 1
                                              ? black
                                              : lightGray,
                                          fontSize: ScreenUtil().setSp(12),
                                          letterSpacing: 0.6),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(5)),
                              child: InkWell(
                                onTap: () {
                                  // setState(() {
                                  if (provider.genderIndex == 0 ||
                                      provider.genderIndex == 1) {
                                    //setState(() {
                                    provider.changegender(2);

                                    // });
                                  }
                                  //});
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: ScreenUtil().setHeight(30),
                                      width: ScreenUtil().setWidth(30),
                                      padding: EdgeInsets.zero,
                                      decoration: BoxDecoration(
                                          color: provider.genderIndex == 2
                                              ? darkGray
                                              : white,
                                          border: Border.all(
                                            color: provider.genderIndex == 2
                                                ? white
                                                : lightGray,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenUtil().setSp(20)))),
                                      child: Image.asset(
                                          "assets/icons/line.png",
                                          color: provider.genderIndex == 2
                                              ? white
                                              : lightGray,
                                          fit: BoxFit.scaleDown),
                                    ),
                                    Text(
                                      'Other',
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w600,
                                          color: provider.genderIndex == 2
                                              ? black
                                              : lightGray,
                                          fontSize: ScreenUtil().setSp(12),
                                          letterSpacing: 0.6),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: ScreenUtil().setWidth(5)),
                          child: InkWell(
                            onTap: () {
                              // setState(() {
                              if (provider.genderIndex == 0 ||
                                  provider.genderIndex == 1) {
                                //setState(() {
                                provider.changegender(2);

                                // });
                              }
                              //});
                            },
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: Dim().d2.h,
                                        horizontal: Dim().d8.w,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xff9B9B9B),
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().radius(10)),
                                      ),
                                      child: DropdownButton<String>(
                                        isDense: true,
                                        hint: Text(
                                          "ft",
                                          style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(14),
                                            color: darkGray,
                                          ),
                                        ),
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w400,
                                          fontSize: ScreenUtil().setSp(14),
                                          color: darkGray,
                                        ),
                                        value: provider.sFoot,
                                        items: provider.footList
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                color: darkGray,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          provider.changeFoot(value!);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: Dim().d2.h,
                                        horizontal: Dim().d8.w,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xff9B9B9B),
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().radius(10)),
                                      ),
                                      child: DropdownButton<String>(
                                        isDense: true,
                                        hint: Text(
                                          "in",
                                          style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(14),
                                            color: darkGray,
                                          ),
                                        ),
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w400,
                                          fontSize: ScreenUtil().setSp(14),
                                          color: darkGray,
                                        ),
                                        value: provider.sInch,
                                        items: provider.inchList
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                color: darkGray,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          provider.changeInch(value!);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text(
                                  'Height',
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w600,
                                      color: black,
                                      fontSize: ScreenUtil().setSp(12),
                                      letterSpacing: 0.6),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
              Column(
                children: [
                  Profassion(
                    type: "faces",
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(15),
                        left: ScreenUtil().setWidth(21),
                        right: ScreenUtil().setWidth(21)),
                    child: TextField(
                      onChanged: (_) {},
                      onSubmitted: (_) {},
                      controller: provider.facesotherController,
                      maxLines: 1,
                      keyboardType: TextInputType.multiline,
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                          color: Color(0xff9B9B9B)),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                        hintText: 'Not in the above list? Type here...',
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
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(24),
                        bottom: ScreenUtil().setHeight(24)),
                    child: InkWell(
                      onTap: () {
                        if (id == null) {
                          if (provider.facesotherController.text.length == 0) {
                            provider.createFaces(context);
                          } else {
                            provider.addcotface(
                                provider.facesotherController.text,
                                context,
                                id.toString());
                          }
                        } else {
                          if (provider.facesotherController.text.length == 0) {
                            provider.updateFaces(context, id);
                          } else {
                            provider.addcotface(
                                provider.facesotherController.text,
                                context,
                                id.toString());
                          }
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
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setSp(25)))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              id == null ? "Create" : "Update",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(18),
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: orange),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(10)),
                              child: Icon(
                                Icons.arrow_forward,
                                color: orange,
                                size: 25,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
