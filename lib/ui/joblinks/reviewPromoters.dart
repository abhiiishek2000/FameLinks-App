import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewPromoters extends StatefulWidget {
  ReviewPromoters({Key? key}) : super(key: key);

  @override
  State<ReviewPromoters> createState() => _ReviewPromotersState();
}

class _ReviewPromotersState extends State<ReviewPromoters> {
  TextEditingController msgController = TextEditingController();
  double reach = 170.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(16), right: ScreenUtil().setWidth(25), top: ScreenUtil().setHeight(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios_rounded, color: black, size: ScreenUtil().radius(20),)
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "Review ",
                          style: GoogleFonts.roboto(
                            fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            height: 0.25,
                            color: black
                          ),
                        ),
                        TextSpan(
                          text: "Promoters",
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
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(16), right: ScreenUtil().setWidth(16), top: 20.h),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xffFF5C2840).withOpacity(0.1),
                            white,
                            white,
                            white,
                            white,
                            Color(0xff0060FF40).withOpacity(0.25),
                          ])),
                  child: Padding(
                    padding: EdgeInsets.all(0.5.r),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 166, 164, 164),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6.r),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Posting',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w700,
                                        color: black,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    Text('Makeup, Beauty Product',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w300,
                                        color: black,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    Text('FollowLinks',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xffFF5C28),
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    Text('Rs. 200',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w600,
                                        color: black,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('10K Reach',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w600,
                                        color: black,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    Text('-',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w400,
                                        color: darkGray,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    Text('10 days',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w300,
                                        color: black,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    Text('-',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w400,
                                        color: darkGray,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    Text('Start By  23-Jun-22',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w300,
                                        color: black,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    Text('Rising Club',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w300,
                                        color: darkGray,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6.r),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Created on: 23-Jun-22',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w400,
                                        color: darkGray,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                    Spacer(),
                                    Text('Applied by: 102',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w400,
                                        color: darkGray,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                    Spacer(),
                                    Text('Sort by',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w400,
                                        color: darkGray,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                    SvgPicture.asset("assets/icons/svg/bookmark.svg", color: lightGray, height: 16.h, width: 12.w),
                                    Spacer(),
                                    Text('Edit Offer',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w400,
                                        color: darkGray,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6.h),
                                Text('Promoters:',
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    color: darkGray,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  padding: EdgeInsets.zero,
                                  itemCount: 10,
                                  itemBuilder: (context, index){
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 12.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Image.asset("assets/icons/two.png", height: 40.h, width: 40.w,),
                                          SizedBox(width: 10.w),
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.h),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('@Kalzy_Guy',
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    color: darkGray,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                SizedBox(height: 6.w),
                                                Text('10.2K Followers',
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    color: darkGray,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 10.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.h),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text('Grant Offer',
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w700,
                                                    color: darkGray,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                SizedBox(height: 6.w),
                                                Text('20 Offers Completed',
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    color: darkGray,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 10.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.h),
                                            child: SvgPicture.asset("assets/icons/svg/bookmark.svg", color: lightGray, height: 16.h, width: 12.w),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}