import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../networking/config.dart';

class EditProfile extends StatefulWidget {
  EditProfile(
      {Key? key,
      this.id,
      this.name,
      this.username,
      this.bio,
      this.profetion,
      this.image,
      this.location,
      this.dateofbirth,
      this.profiletype})
      : super(key: key);
  final String? id;
  final String? name;
  final String? username;
  final String? bio;
  final String? profetion;
  final String? profiletype;
  final String? image;
  final String? location;
  final String? dateofbirth;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.name.toString();
    professionController.text = widget.profetion.toString();
    descController.text = widget.bio.toString();
    locationController.text = widget.location.toString();
    valController.text = widget.username.toString();
    // valController.text=widget.username.toString();
    //print(widget.data);
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController valController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(16),
                right: ScreenUtil().setWidth(25),
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
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "Edit ",
                          style: GoogleFonts.roboto(
                              fontSize: ScreenUtil().setSp(18),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              height: 0.25,
                              color: black),
                        ),
                        TextSpan(
                          text: "Profile",
                          style: GoogleFonts.roboto(
                            fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            height: 0.25,
                            color: orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(45),
                    right: ScreenUtil().setWidth(45),
                    top: 24.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "JobLinks data",
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: orange),
                    ),
                    SizedBox(height: 12.h),
                    Center(
                        child: Stack(
                      children: [
                        Container(
                          height: 144,
                          width: 144,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: widget.profiletype == "image"
                                ? NetworkImage(
                                    "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${widget.image}",
                                  )
                                : NetworkImage(
                                    "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${widget.image}",
                                  ),
                          ),
                        ),
                        Positioned(
                          right: 10.w,
                          bottom: 10.h,
                          child: Container(
                              height: 30.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                color: white,
                                shape: BoxShape.circle,
                              ),
                              child:
                                  Icon(Icons.camera_alt_outlined, size: 15.r)),
                        )
                      ],
                    )),
                    SizedBox(height: 12.h),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      cursorColor: black,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Enter name';
                        } else {
                          return null;
                        }
                      },
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: black),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 12.w, right: 12.w, top: 9.h, bottom: 9.h),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().radius(5.r)),
                            borderSide: BorderSide(color: lightGray, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().radius(5.r)),
                            borderSide:
                                BorderSide(color: Color(0xff7AACFF), width: 1),
                          ),
                          hintText: 'Enter Name',
                          hintStyle: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(14),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: darkGray)),
                    ),
                    SizedBox(height: 12.h),
                    TextFormField(
                      controller: professionController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      cursorColor: black,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Enter Profession';
                        } else {
                          return null;
                        }
                      },
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: black),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 12.w, right: 12.w, top: 9.h, bottom: 9.h),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().radius(5.r)),
                            borderSide: BorderSide(color: lightGray, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().radius(5.r)),
                            borderSide:
                                BorderSide(color: Color(0xff7AACFF), width: 1),
                          ),
                          hintText: 'Enter Profession',
                          hintStyle: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(14),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: darkGray)),
                    ),
                    SizedBox(height: 12.h),
                    TextFormField(
                      controller: descController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      cursorColor: black,
                      maxLines: 5,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Enter Description';
                        } else {
                          return null;
                        }
                      },
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: black),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 12.w, right: 12.w, top: 9.h, bottom: 9.h),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().radius(5.r)),
                            borderSide: BorderSide(color: lightGray, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().radius(5.r)),
                            borderSide:
                                BorderSide(color: Color(0xff7AACFF), width: 1),
                          ),
                          hintText: 'Enter Description',
                          hintStyle: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(14),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: darkGray)),
                    ),
                    // SizedBox(height: 12.h),
                    // TextFormField(
                    //   controller: websiteController,
                    //   keyboardType: TextInputType.name,
                    //   textInputAction: TextInputAction.next,
                    //   cursorColor: black,
                    //   validator: (v) {
                    //     if (v!.isEmpty) {
                    //       return 'Enter Website URL';
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    //   style: GoogleFonts.nunitoSans(
                    //       fontSize: ScreenUtil().setSp(14),
                    //       fontWeight: FontWeight.w400,
                    //       fontStyle: FontStyle.normal,
                    //       color: black),
                    //   decoration: InputDecoration(
                    //       contentPadding: EdgeInsets.only(
                    //           left: 12.w, right: 12.w, top: 9.h, bottom: 9.h),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderRadius:
                    //             BorderRadius.circular(ScreenUtil().radius(5.r)),
                    //         borderSide: BorderSide(color: lightGray, width: 1),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius:
                    //             BorderRadius.circular(ScreenUtil().radius(5.r)),
                    //         borderSide:
                    //             BorderSide(color: Color(0xff7AACFF), width: 1),
                    //       ),
                    //       hintText: 'Website URL',
                    //       hintStyle: GoogleFonts.nunitoSans(
                    //           fontSize: ScreenUtil().setSp(14),
                    //           fontStyle: FontStyle.normal,
                    //           fontWeight: FontWeight.w400,
                    //           color: darkGray)),
                    // ),
                    SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Master data",
                          style: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              color: orange),
                        ),
                        Container(
                          height: 1.h,
                          width: MediaQuery.of(context).size.width - 170.w,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                Color(0xffFFA88C),
                                Color(0xffFF5C28),
                              ])),
                        )
                      ],
                    ),
                    SizedBox(height: 22.h),
                    Container(
                      height: 25.h,
                      child: TextFormField(
                        controller: valController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        cursorColor: black,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Enter no. of days';
                          } else {
                            return null;
                          }
                        },
                        style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(12),
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff0060FF),
                          height: 1.7,
                        ),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: lightGray, width: 1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: lightGray, width: 1),
                            ),
                            hintText: '@pat_baby',
                            hintStyle: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(12),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff0060FF),
                              height: 1.7,
                            ),
                            suffixIcon: Icon(
                              Icons.check_circle,
                              color: Color(0xff0060FF).withOpacity(0.66),
                              size: 16.r,
                            )),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    TextFormField(
                      controller: locationController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      cursorColor: black,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Enter Location';
                        } else {
                          return null;
                        }
                      },
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: black),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 12.w, right: 12.w, top: 9.h, bottom: 9.h),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().radius(5.r)),
                            borderSide: BorderSide(color: lightGray, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().radius(5.r)),
                            borderSide:
                                BorderSide(color: Color(0xff7AACFF), width: 1),
                          ),
                          hintText: 'Enter Location',
                          hintStyle: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(14),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: darkGray)),
                    ),
                    SizedBox(height: 12.h),
                    TextFormField(
                      controller: dobController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      cursorColor: black,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Enter Date of Birth';
                        } else {
                          return null;
                        }
                      },
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: black),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 12.w, right: 12.w, top: 9.h, bottom: 9.h),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().radius(5.r)),
                            borderSide: BorderSide(color: lightGray, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().radius(5.r)),
                            borderSide:
                                BorderSide(color: Color(0xff7AACFF), width: 1),
                          ),
                          hintText: 'Enter Date of Birth',
                          hintStyle: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(14),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: darkGray)),
                    ),
                    SizedBox(height: 32.h),
                    Center(
                      child: Container(
                        height: 45.h,
                        width: 158.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().radius(20.r)),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xffFFA88C),
                                  Color(0xffFF5C28),
                                ])),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Submit",
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(22),
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: white),
                            ),
                            SizedBox(width: 5.h),
                            Icon(Icons.arrow_forward_rounded,
                                color: white, size: 20.r)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
