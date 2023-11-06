import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CompletedClubOffers extends StatefulWidget {
  final user;
  CompletedClubOffers({Key? key, this.user}) : super(key: key);

  @override
  State<CompletedClubOffers> createState() => _CompletedClubOffersState();
}

class _CompletedClubOffersState extends State<CompletedClubOffers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w),
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: 5,
            padding: EdgeInsets.zero,
            itemBuilder: (context, i) {
              return Padding(
                padding: EdgeInsets.only(bottom: 15.h),
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
                                    Text('Completed on 23-Jun-22',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w700,
                                        color: black,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    Text('Posted on 20-May-22',
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
                                  ],
                                ),                                
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
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset("assets/icons/two.png", height: 35.h, width: 35.h,),
                                    SizedBox(width: 8.w,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Mumbai Casting Agency',
                                          style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w700,
                                            color: black,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        SizedBox(height: 8.h,),
                                        Row(
                                          children: [
                                            Text('12.1k Likes',
                                              style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w500,
                                                color: black,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                            SizedBox(width: 6.w,),
                                            Text('-',
                                              style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                color: black,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                            SizedBox(width: 6.w,),
                                            Text('12.1K Comments',
                                              style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w500,
                                                color: black,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.h,),
                                        Row(
                                          children: [
                                            Text('12.1k Reach',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                color: widget.user == true ? lightGray : Colors.blue,
                                                fontSize: 12.sp,
                                                fontStyle: FontStyle.italic
                                              ),
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(widget.user == true ? 'You Earned Rs 200' : '10.2k shares',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                color: widget.user == true ? Colors.blue : lightGray,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                            widget.user == true ? Container() :
                                            SizedBox(width: 5.w),
                                            widget.user == true ? Container() :
                                            Text('Offer Again',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                color: lightGray,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Stack(
                                      children: [
                                        Image.asset("assets/icons/Rectangle 495.png", height: 80.h, width: 80.h,),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            height: 75.h, width: 80.h, 
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text('4',
                                                  textAlign: TextAlign.right,
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    color: white,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                SizedBox(width: 5.w),
                                                Padding(
                                                  padding: EdgeInsets.only(bottom: 2.h),
                                                  child: SvgPicture.asset("assets/icons/svg/bm.svg", color: white, height: 12.h, width: 12.w),
                                                ),
                                                SizedBox(width: 8.w),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                ),
              );
            }
          ),
        ),
      )
    );
  }
}