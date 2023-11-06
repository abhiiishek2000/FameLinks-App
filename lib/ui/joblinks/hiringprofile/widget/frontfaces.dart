import 'package:famelink/util/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../util/config/color.dart';
import '../provider/hiring_profile_provider.dart';
import 'searchfields.dart';

class FrontFaces extends StatelessWidget {
  final String? id;

  const FrontFaces({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<HiringProfileProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(25),
            left: ScreenUtil().setWidth(35),
            right: ScreenUtil().setWidth(35),
          ),
          child: Form(
            key: provider.facesKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: provider.ftController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[1-8.]")),
                          ],
                          maxLength: 1,
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              counterText: '',
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
                              suffixIconConstraints: BoxConstraints(
                                minWidth: Dim().d24.w,
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(0)),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        //  setState(() {
                                        if (provider.ftCount < 8) {
                                          provider.ftCount++;
                                          provider.ftController.text =
                                              provider.ftCount.toString();
                                        }
                                        //  });
                                      },
                                      child: Container(
                                          height: 18,
                                          width: 20,
                                          child: Icon(
                                            Icons.arrow_drop_up_outlined,
                                            color: lightGray,
                                          )),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          //setState(() {
                                          if (provider.ftCount > 1) {
                                            provider.ftCount--;
                                            provider.ftController.text =
                                                provider.ftCount.toString();
                                          }
                                          //  });
                                        },
                                        child: Container(
                                            height: 18,
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
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: provider.inController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[1-8.]")),
                          ],
                          maxLength: 2,
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
                              counterText: '',
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.w),
                              ),
                              errorStyle: TextStyle(height: 0),
                              contentPadding: EdgeInsets.only(
                                  top: ScreenUtil().setWidth(10),
                                  left: ScreenUtil().setWidth(10)),
                              suffixIconConstraints: BoxConstraints(
                                minWidth: Dim().d24.w,
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(0)),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        //   setState(() {
                                        if (provider.inCount < 11) {
                                          provider.inCount++;
                                          provider.inController.text =
                                              provider.inCount.toString();
                                        }
                                        //  });
                                      },
                                      child: Container(
                                          height: 18,
                                          width: 20,
                                          child: Icon(
                                            Icons.arrow_drop_up_outlined,
                                            color: lightGray,
                                          )),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          // setState(() {
                                          if (provider.inCount > 1) {
                                            provider.inCount--;
                                            provider.inController.text =
                                                provider.inCount.toString();
                                          }
                                          //  });
                                        },
                                        child: Container(
                                            height: 18,
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
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: provider.weightController,
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
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setWidth(12)),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: provider.bustController,
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
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.w),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.w),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: lightGray, width: 1.w),
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
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: provider.waistController,
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
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.w),
                                ),
                                errorStyle: TextStyle(height: 0),
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
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: provider.hipController,
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
                                hintText: 'Hip (cm)',
                                hintStyle: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(14),
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400,
                                    color: lightGray)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setWidth(12)),
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      onChanged: (_) {},
                      controller: provider.eyeController,
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
                            borderSide:
                                BorderSide(color: Color(0xff9B9B9B), width: 1),
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
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setWidth(12)),
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    isDense: true,
                    value: provider.sComplexion,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.transparent,
                    ),
                    decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.red, width: 1.w),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.red, width: 1.w),
                        ),
                        isDense: true,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10),vertical: ScreenUtil().setWidth(8)),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xff9B9B9B), width: 1),
                        ),
                        errorStyle: TextStyle(height: 0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: lightRed, width: 1),
                        ),
                        suffixIcon:
                        Image.asset("assets/icons/complexion.png"),
                        suffixIconConstraints: BoxConstraints(
                          minWidth: Dim().d40.w,
                          minHeight: Dim().d20.h,
                        ),
                        hintText: 'Complexion',
                        hintStyle: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(14),
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            color: lightGray)),
                    hint: Text(
                      provider.sComplexion ?? 'Complexion',
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(14),
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                          color: lightGray),
                    ),
                    items: provider.complexionList.map((String s) {
                      return DropdownMenuItem<String>(
                        value: s,
                        child: Text(
                          s,
                          style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: Color(0xff9B9B9B),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      provider.updateDropdown(value!);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(12)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().radius(4)),
                      border: Border.all(color: Color(0xff9B9B9B)),
                      color: Colors.white,
                    ),
                    child: SearchLocation(type: "faces"),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
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
                        onChanged: (val) {
                          Future.delayed(Duration(milliseconds: 300), () {
                            provider.searchCategories(val, "faces");
                          });
                        },
                        onSubmitted: (_) {},
                        controller: provider.interestedController,
                        maxLines: 1,
                        keyboardType: TextInputType.multiline,
                        style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: Color(0xff9B9B9B)),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(top: ScreenUtil().setWidth(0)),
                          hintText: '',
                          hintStyle: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(14),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff9B9B9B)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: lightRed, width: 1)),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                  child: Container(
                    // height: 260.h,
                    padding: EdgeInsets.only(right: 8.w),
                    child: provider.loasface
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : GridView.builder(
                            padding: EdgeInsets.all(0.0),
                            primary: false,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.r, //1.6.r,
                              crossAxisSpacing: 8.r,
                              mainAxisSpacing: 15.r,
                            ),
                            itemCount: provider.categoryface!.length,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext ctx, index) {
                              return InkWell(
                                onTap: () {
                                  //   setState(() {
                                  if (provider.fameCategorySelected.contains(
                                      provider.categoryface![index].sId)) {
                                    provider.fameCategorySelected.remove(
                                        provider.categoryface![index].sId);
                                  } else {
                                    provider.fameCategorySelected.clear();
                                    provider.fameCategorySelected
                                        .add(provider.categoryface![index].sId);
                                  }
                                  print(provider.fameCategorySelected);
                                  provider.selectcategory(index);
                                  //  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().radius(17)),
                                    border: Border.all(color: black),
                                    color: white,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().radius(15)),
                                          border: Border.all(color: black),
                                          color: provider.fameCategorySelected
                                                  .contains(provider
                                                      .categoryface![index].sId)
                                              ? Color(0xff4B4E58)
                                              : Colors.white,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(6),
                                              bottom: ScreenUtil().setHeight(6),
                                              left: ScreenUtil().setWidth(10),
                                              right: ScreenUtil().setWidth(10)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                provider.categoryface![index]
                                                    .jobName
                                                    .toString(),
                                                style: GoogleFonts.nunitoSans(
                                                  fontSize:
                                                      ScreenUtil().setSp(12),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  color: provider
                                                          .fameCategorySelected
                                                          .contains(provider
                                                              .categoryface![
                                                                  index]
                                                              .sId)
                                                      ? Colors.white
                                                      : black,
                                                ),
                                              ),
                                              SvgPicture.asset(
                                                "assets/icons/svg/photoshoot.svg",
                                                height:
                                                    ScreenUtil().setHeight(20),
                                                width:
                                                    ScreenUtil().setWidth(20),
                                                color: orange,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(10.r),
                                          child: Text(
                                            provider.categoryface![index]
                                                .jobCategory
                                                .toString()
                                                .replaceAll(RegExp('[[]'), '')
                                                .replaceAll(RegExp(']'), ''),
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.nunitoSans(
                                                fontSize:
                                                    ScreenUtil().setSp(12),
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
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
                            fontWeight: provider.index == 0
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
                        width: MediaQuery.of(context).size.width - 130.w,
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
                            provider.createFF(context);
                          } else {
                            provider.updateFF(context);
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
        );
      },
    );
  }
}
