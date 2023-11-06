import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../util/config/color.dart';
import '../../widget/searchprofession.dart';
import '../provider/jobcreateprovider.dart';
import 'searchfieldsjob.dart';

class BehindJob extends StatelessWidget {
  const BehindJob({super.key, this.id});

  final id;

  @override
  Widget build(BuildContext context) {
    return Consumer<JobCreateprovider>(
      builder: (context, provider, child) {
        return Form(
          key: JobCreateprovider.crewKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(24),
                    left: ScreenUtil().setWidth(40),
                    right: ScreenUtil().setWidth(40)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtil().radius(8)),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: provider.titleController,
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
                    top: ScreenUtil().setHeight(16),
                    left: ScreenUtil().setWidth(40),
                    right: ScreenUtil().setWidth(40)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtil().radius(8)),
                    border: Border.all(color: Color(0xff9B9B9B)),
                    color: Colors.white,
                  ),
                  child: SearchLocationjob(
                    locationcon: provider.locationController,
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
                    controller: provider.descriptionController,
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
                    top: ScreenUtil().setHeight(16),
                    left: ScreenUtil().setWidth(40),
                    right: ScreenUtil().setWidth(40)),
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
                      onTap: () {
                        if (provider.experienceIndex == 1 ||
                            provider.experienceIndex == 2) {
                          provider.changeexperienceIndex(0);
                        }
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: ScreenUtil().setHeight(7),
                                left: ScreenUtil().setWidth(5)),
                            child: Container(
                              height: ScreenUtil().setHeight(14),
                              width: ScreenUtil().setWidth(14),
                              decoration: BoxDecoration(
                                  color: provider.experienceIndex == 0
                                      ? orange
                                      : white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: black)),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: ScreenUtil().setWidth(5)),
                            child: Text(
                              "Fresher",
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: provider.experienceIndex == 0
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
                        if (provider.experienceIndex == 0 ||
                            provider.experienceIndex == 2) {
                          // setState(() {
                          provider.changeexperienceIndex(1);

                          // });
                        }
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: ScreenUtil().setHeight(7),
                                left: ScreenUtil().setWidth(5)),
                            child: Container(
                              height: ScreenUtil().setHeight(14),
                              width: ScreenUtil().setWidth(14),
                              decoration: BoxDecoration(
                                  color: provider.experienceIndex == 1
                                      ? orange
                                      : white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: black)),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: ScreenUtil().setWidth(6)),
                            child: Text(
                              "Experienced",
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: provider.experienceIndex == 1
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
                        if (provider.experienceIndex == 0 ||
                            provider.experienceIndex == 1) {
                          //  setState(() {
                          provider.changeexperienceIndex(2);

                          //  });
                        }
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: ScreenUtil().setHeight(7),
                                left: ScreenUtil().setWidth(5)),
                            child: Container(
                              height: ScreenUtil().setHeight(14),
                              width: ScreenUtil().setWidth(14),
                              decoration: BoxDecoration(
                                  color: provider.experienceIndex == 2
                                      ? orange
                                      : white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: black)),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: ScreenUtil().setWidth(6)),
                            child: Text(
                              "Any",
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: provider.experienceIndex == 2
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
                    top: ScreenUtil().setHeight(17),
                    left: ScreenUtil().setWidth(40),
                    right: ScreenUtil().setWidth(40)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onTap: () {
                          // setState(() {
                          provider.selectStartDate(context);
                          // });
                        },
                        controller: provider.startController,
                        keyboardType: TextInputType.number,
                        cursorColor: black,
                        readOnly: true,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
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
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.w),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1.w),
                          ),
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
                          isCollapsed: true,
                          contentPadding:
                              EdgeInsets.all(ScreenUtil().setWidth(4)),
                          hintText: 'Start Date',
                          hintStyle: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            color: lightGray,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(5)),
                    Expanded(
                      child: TextFormField(
                        onTap: () {
                          //  setState(() {
                          if (provider.startDate == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text('Select Start Date'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                            return;
                          } else {
                            provider.selectEndDate(context);
                          }
                          // });
                        },
                        controller: provider.endController,
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
                        controller: provider.totalController,
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
                          //  setState(() {
                          provider.selectDeadlineDate(context);
                          // });
                        },
                        controller: provider.deadlineController,
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
                    top: ScreenUtil().setHeight(15),
                    left: ScreenUtil().setWidth(40),
                    right: ScreenUtil().setWidth(40)),
                child: Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xff9B9B9B),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(10),
                    left: ScreenUtil().setWidth(21),
                    right: ScreenUtil().setWidth(21)),
                child: Column(
                  children: [
                    Profassion(
                      type: "crew",
                    ),
                    TextField(
                      onChanged: (_) {},
                      onSubmitted: (_) {},
                      controller: provider.otherController,
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
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(24),
                          bottom: ScreenUtil().setHeight(24)),
                      child: InkWell(
                        onTap: () {
                          if (id == null) {
                            if (provider.otherController.text.length == 0) {
                              provider.createCrew(context);
                            } else {
                              provider.addcotcrew(provider.otherController.text,
                                  context, id.toString());
                            }
                          } else {
                            if (provider.otherController.text.length == 0) {
                              provider.updateCrew(context, id);
                            } else {
                              provider.addcotcrew(provider.otherController.text,
                                  context, id.toString());
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
              ),
            ],
          ),
        );
      },
    );
  }
}
