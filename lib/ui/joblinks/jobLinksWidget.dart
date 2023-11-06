import 'package:famelink/common/common_image.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class JobsLinksWidget extends StatefulWidget {
  int? i;
  JobsLinksWidget({Key? key, this.i}) : super(key: key);

  @override
  State<JobsLinksWidget> createState() => _JobsLinksWidgetState();
}

class _JobsLinksWidgetState extends State<JobsLinksWidget> {
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.i != null){
      index = widget.i!;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
      child: Column(
        children: [
          Container(
            height: 80.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.white.withOpacity(0.25)
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 13.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 8),
                  Column(
                    children: [
                      Text(
                        "509 / 20",
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: black
                        ),
                      ),
                      SizedBox(height: index == 0 || index == 1 ? 0.h : 5.h),  
                      Text(
                        index == 0 || index == 1 ? "Applied /\nHired" : "Total Jobs",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 5.w),
                  Center(
                    child: Container(
                      width: 1.w,
                      height: 32.h,
                      color: Colors.white.withOpacity(0.25)
                    )
                  ),
                  SizedBox(width: 5.w),
                  Column(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: "590 ",
                              style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                                color: black,
                              ),
                            ),
                            TextSpan(
                              text: "/ 10 new",
                              style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 10.sp,
                                color: Color(0xff0060FF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Text(
                            index == 4 ? "Followers" : index == 5 ? "Hired" : "Chats",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: white,
                            ),
                          ),
                          SizedBox(width: 8.h),
                          index == 4 ? Container() : index == 5 ? Container() : Icon(Icons.send, color: white, size: 12.r,)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 5.w),
                  Center(
                    child: Container(
                      width: 1.w,
                      height: 32.h,
                      color: Colors.white.withOpacity(0.25)
                    )
                  ),
                  SizedBox(width: 5.w),
                  Column(
                    children: [
                      Text(
                        "40",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: black,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Text(
                            index == 4 ? "Titles Won" : index == 5 ? "Trendz Sponsored" : "Saved Jobs",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: white,
                            ),
                          ),
                          SizedBox(width: 8.h),
                          index == 4
                          ? Image.asset("assets/icons/darkFamelinkIcon.png", color: white, height: 13.h, width: 13.w)
                          : index == 5
                          ? Container()
                          : Padding(
                            padding: EdgeInsets.only(top: 3.h),
                            child: SvgPicture.asset("assets/icons/svg/bookmark.svg", color: white, height: 13.h, width: 13.w),
                          ),
                        ],
                      ),
                      index == 4 || index == 5
                      ? Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white.withOpacity(0.25),
                      ) : Container(),
                    ],
                  ),
                  SizedBox(width: 5.w),
                  Center(
                    child: Container(
                      width: 1.w,
                      height: 32.h,
                      color: Colors.white.withOpacity(0.25)
                    )
                  ),
                  SizedBox(width: 5.w),
                  Column(
                    children: [
                      Text(
                        "5",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 12.sp,
                          color: black,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        index == 0 || index == 1 ? "Shotlisted"
                        : index == 4 ? "Trendz Set" : "Open jobs",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: white,
                        ),
                      ),
                      index == 4 || index == 5
                      ? Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white.withOpacity(0.25),
                      ) : Container(),
                    ],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
