import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BrandExploreProfiles extends StatefulWidget {
  BrandExploreProfiles({Key? key}) : super(key: key);

  @override
  State<BrandExploreProfiles> createState() => _BrandExploreProfilesState();
}

class _BrandExploreProfilesState extends State<BrandExploreProfiles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 22.w, right: 22.w),
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.zero,
          itemCount: 15,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h, top: 12.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset("assets/icons/svg/icon.svg", height: ScreenUtil().setHeight(40), width: ScreenUtil().setWidth(40), color: darkBlue),
                      SizedBox(width: 12.w,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sukhvinder Singh Bhalla',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              color: black,
                              fontSize: ScreenUtil().setSp(12),
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            'Mister Chandigarh District, Chandigarh, Punjab',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              color: lightGray,
                              fontSize: ScreenUtil().setSp(10),
                            ),
                          ),
                          SizedBox(height: 8.h),
                        ]
                      ),
                      Text(
                        'Invite to Job',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff0060FF),
                          fontSize: ScreenUtil().setSp(12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  index == 14 ? Container() :
                  Container(
                    height: 1.h,
                    width: MediaQuery.of(context).size.width,
                    color: lightGray,
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}