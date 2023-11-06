import 'package:famelink/ui/FameChatScreen.dart';
import 'package:famelink/ui/joblinks/reportDialog.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Saved extends StatefulWidget {
  Saved({Key? key}) : super(key: key);

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.zero,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black.withAlpha(40)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/icons/svg/icon.svg", color: darkBlue, height: 65.h, width: 65.w,),
                          SizedBox(width: 8.w,),
                          Container(
                            width: MediaQuery.of(context).size.width - 95.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Zara Clothings: ",
                                            style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(18),
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              height: 0.25,
                                              color: black
                                            ),
                                          ),
                                          TextSpan(
                                            text: "(Clothes)",
                                            style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(14),
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              height: 0.19,
                                              color: black
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap:() {
                                        setState(() {
                                          // showGeneralDialog(
                                          //   context: context,
                                          //   pageBuilder: (BuildContext buildContext,
                                          //       Animation animation, Animation secondaryAnimation) {
                                          //     return ReportDialog();
                                          //   });
                                          });                          
                                        },
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 8.h),
                                        child: Icon(Icons.more_vert, color: darkGray, size: 12.r),
                                      )
                                    )
                                  ],
                                ),
                                SizedBox(height: 12.w,),
                                Text(
                                  "Models required for Ethenic Wear shoot",
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(14),
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    height: 0.19,
                                    color: black
                                  ),
                                ),
                                SizedBox(height: 14.w,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "From 15-Sep-21 till 20-Sep-21",
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        height: 0.16,
                                        color: black
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 2.5.h),
                                      child: Text(
                                        "3 days ago",
                                        style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(10),
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          height: 0.13,
                                          color: black
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
                    child: Row(
                      children: [
                        Text(
                          "Mumbai",
                          style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            height: 0.16,
                            color: black
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Female, 18-28 yrs",
                          style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            height: 0.16,
                            color: black
                          ),
                        ),
                        Spacer(),
                        Text(
                          "5’ 6”",
                          style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            height: 0.16,
                            color: black
                          ),
                        ),
                        Spacer(),
                        Spacer(),
                        Text(
                          "Print Ad",
                          style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            height: 0.16,
                            color: darkGray
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Padding(
                          padding: EdgeInsets.only(bottom: 6.h),
                          child: SvgPicture.asset(
                            "assets/icons/svg/photoshoot.svg",
                            height: 20.h,
                            width: 20.w,
                            color: orange,
                          ),
                        ),
                        Spacer(),
                      ]
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.r, right: 8.r),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sapien volutpat massa quis feugiat consequat ni mauris. Diam massa, sit aliquam amet, libero, auctor. Nulla facilisi lectus amet, magna in a tortor, consectetur eget.",
                      style: GoogleFonts.nunitoSans(
                        fontSize: ScreenUtil().setSp(10),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        // height: 0.13,
                        color: black
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h,),
                  Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black.withAlpha(40)),
                        boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: white,
                              blurRadius: 10.0,
                            ),
                          ]
                      ),     
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 10.h, bottom: 10.h),
                        child: Row(
                          children: [
                            Text(
                              "Applied on: 13-Sep-21",
                              style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                color: black
                              ),
                            ),
                            SizedBox(width: 22.w,),
                            InkWell(
                              onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                  return Dialog(
                                    backgroundColor: Colors.transparent,
                                      child: Container(
                                        height: 200,
                                        width: MediaQuery.of(context).size.width - 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12.r)
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(15.r),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Once you withdraw your application, you will not be able to apply to this job again?\n\nAre you sure you want to withdraw your application?",
                                                style: GoogleFonts.nunitoSans(
                                                  fontSize: ScreenUtil().setSp(14),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  color: black
                                                ),
                                              ),
                                              SizedBox(height: 35.h),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Yes",
                                                    style: GoogleFonts.nunitoSans(
                                                      fontSize: ScreenUtil().setSp(14),
                                                      fontWeight: FontWeight.w700,
                                                      fontStyle: FontStyle.normal,
                                                      color: black
                                                    ),
                                                  ),
                                                  SizedBox(width: 40.w,),
                                                  Text(
                                                    "No",
                                                    style: GoogleFonts.nunitoSans(
                                                      fontSize: ScreenUtil().setSp(14),
                                                      fontWeight: FontWeight.w400,
                                                      fontStyle: FontStyle.normal,
                                                      color: darkGray
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ]
                                          ),
                                        )
                                      )
                                    );
                                  }
                                );
                              },
                              child: Text(
                                "Unsave",
                                style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  color: black
                                ),
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => FameChatScreen()),
                                );
                              },
                              child: Text(
                                "Chat",
                                style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  color: darkGray
                                ),
                              ),
                            ),
                          ]
                        ),
                      )
                    ),
                  ),
                ]
              ),
            ),
          );
        }
      ),
    );
  }
}