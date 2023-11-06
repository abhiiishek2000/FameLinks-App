import 'package:famelink/ui/joblinks/reportDialog.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BrandExploreSaved extends StatefulWidget {
  BrandExploreSaved({Key? key}) : super(key: key);

  @override
  State<BrandExploreSaved> createState() => _BrandExploreSavedState();
}

class _BrandExploreSavedState extends State<BrandExploreSaved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 22.w, right: 22.w),
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.zero,
          itemCount: 8,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h, top: 12.h),
              child: Material(
                elevation: 1.5,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withAlpha(40)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/svg/icon.svg", height: ScreenUtil().setHeight(60), width: ScreenUtil().setWidth(60), color: darkBlue),
                        SizedBox(width: 10.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sabrina Carpenter, 23 yrs',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: black,
                                    fontSize: ScreenUtil().setSp(14),
                                  ),
                                ),
                                SizedBox(width: 25.w),
                                Text(
                                  '2 days ago',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    color: darkGray,
                                    fontSize: ScreenUtil().setSp(10),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '@sabrina_carpenter',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff0060FF),
                                    fontSize: ScreenUtil().setSp(12),
                                  ),
                                ),
                                SizedBox(width: 7.w,),
                                Text(
                                  '30.2K Followers',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                    fontSize: ScreenUtil().setSp(12),
                                  ),
                                ),
                                SizedBox(width: 24.w),
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
                                    padding: EdgeInsets.only(top: 2.5.h),
                                    child: Icon(Icons.more_vert, color: lightGray, size: 15.r),
                                  )
                                )
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Miss Madhya Pradesh, Ambassador, Trend Setter',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w700,
                                color: orange,
                                fontSize: ScreenUtil().setSp(10),
                              ),
                            ),
                          ],
                        )
                      ]
                    ),
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}