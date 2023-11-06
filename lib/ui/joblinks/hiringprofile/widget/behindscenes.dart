import 'package:famelink/ui/joblinks/hiringprofile/widget/searchfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../dio/api/apimanager.dart';
import '../../../../util/config/color.dart';
import '../provider/hiring_profile_provider.dart';

class Behindscenes extends StatelessWidget {
  const Behindscenes({super.key, this.id});
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Consumer<HiringProfileProvider>(
      builder: (context, provider, child) {
        return Form(
          key: provider.crewKey,
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
                        if (provider.experienceIndex == 1) {
                          // setState(() {
                          provider.expselsect(0);
                          //    provider.experienceIndex = 0;
                          //});
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
                                  color: provider.experienceIndex == 0
                                      ? Color(0xff9B9B9B)
                                      : white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: black)),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: ScreenUtil().setWidth(6)),
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
                        if (provider.experienceIndex == 0) {
                          //   setState(() {
                          provider.expselsect(1);
                          //  });
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
                                  color: provider.experienceIndex == 1
                                      ? Color(0xff9B9B9B)
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
                    borderRadius: BorderRadius.circular(ScreenUtil().radius(8)),
                    color: Colors.white,
                  ),
                  child: Scrollbar(
                    controller: provider.workScrollController,
                    isAlwaysShown: true,
                    thickness: 3,
                    trackVisibility: true,
                    radius: Radius.circular(50),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: provider.workController,
                        scrollController: provider.workScrollController,
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
                            contentPadding:
                                EdgeInsets.all(ScreenUtil().setWidth(10)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff9B9B9B), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: lightRed, width: 1),
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
                    borderRadius: BorderRadius.circular(ScreenUtil().radius(4)),
                    color: Colors.white,
                  ),
                  child: Scrollbar(
                    controller: provider.awardsScrollController,
                    isAlwaysShown: true,
                    thickness: 3,
                    trackVisibility: true,
                    radius: Radius.circular(50),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        scrollController: provider.awardsScrollController,
                        controller: provider.awardsController,
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
                            contentPadding:
                                EdgeInsets.all(ScreenUtil().setWidth(10)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff9B9B9B), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: lightRed, width: 1),
                            ),
                            hintText: 'Awards Won / Special Achievements',
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
                    borderRadius: BorderRadius.circular(ScreenUtil().radius(4)),
                    border: Border.all(color: Color(0xff9B9B9B)),
                    color: Colors.white,
                  ),
                  child: SearchLocation(type: "crew"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(15),
                    left: ScreenUtil().setWidth(17),
                    right: ScreenUtil().setWidth(17)),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (val) {
                        Future.delayed(Duration(milliseconds: 300), () {
                          provider.searchCategories(val, "crew");
                        });
                      },
                      onSubmitted: (_) {},
                      //  controller: professionController,
                      maxLines: 1,
                      keyboardType: TextInputType.multiline,
                      cursorColor: black,
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                          color: Color(0xff9B9B9B)),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                        hintText: 'Search Profession',
                        hintStyle: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(14),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff9B9B9B)),
                        suffixIcon: Image.asset("assets/icons/search.png",
                            color: Color(0xff9B9B9B)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: lightRed, width: 1)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(14)),
                      child: Container(
                        // height: 260.h,
                        padding: EdgeInsets.only(right: 3.w),
                        child: GridView.builder(
                          padding: EdgeInsets.all(3.0),
                          primary: false,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 4.r,
                            crossAxisSpacing: 7,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: provider.categorybehind!.length,
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext ctx, index) {
                            return InkWell(
                              onTap: () {
                                //  setState(() {
                                if (provider.categorySelected.contains(
                                    provider.categorybehind![index].sId)) {
                                  provider.categorySelected.remove(
                                      provider.categorybehind![index].sId);
                                } else {
                                  provider.categorySelected.clear();
                                  provider.categorySelected
                                      .add(provider.categorybehind![index].sId);
                                }
                                provider.selectcategory(index);
                                // });
                              },
                              child: Container(
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      ScreenUtil().radius(15)),
                                  border: Border.all(color: black),
                                  color: provider.categorySelected.contains(
                                          provider.categorybehind![index].sId)
                                      ? Color(0xff4B4E58)
                                      : Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    provider.categorybehind![index].jobName!,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        color: provider.categorySelected
                                                .contains(provider
                                                    .categorybehind![index].sId)
                                            ? white
                                            : black),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    TextField(
                      onChanged: (_) {},
                      controller: provider.otherController,
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
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(24),
                              bottom: ScreenUtil().setHeight(24),
                              left: ScreenUtil().setWidth(10),
                              right: ScreenUtil().setWidth(10)),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 100,
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
                              if (id == null) {
                                if (provider.otherController.text.length == 0) {
                                  provider.createBTS(context);
                                } else {
                                  provider.addcot(provider.otherController.text,
                                      context, id);
                                }
                              } else {
                                if (provider.otherController.text.length == 0) {
                                  provider.updateBTS(context, id);
                                } else {
                                  provider.addcot(provider.otherController.text,
                                      context, id);
                                }
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
        );
      },
    );
  }
}
