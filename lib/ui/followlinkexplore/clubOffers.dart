import 'package:famelink/ui/joblinks/applied.dart';
import 'package:famelink/ui/joblinks/appliedClubOffer.dart';
import 'package:famelink/ui/joblinks/completedClubOffers.dart';
import 'package:famelink/ui/joblinks/inprogressClubOffer.dart';
import 'package:famelink/ui/joblinks/jobController.dart';
import 'package:famelink/ui/joblinks/newClubOffer.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ClubOffers extends StatefulWidget {
  ClubOffers({Key? key}) : super(key: key);

  @override
  State<ClubOffers> createState() => _ClubOffersState();
}

class _ClubOffersState extends State<ClubOffers> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TextEditingController searchController = TextEditingController();
  JobController controller = Get.put(JobController());
  TabController? tabController1;
  

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      tabController1 = TabController(length: 4, vsync: this);
      tabController1!.addListener(() {});
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, top: controller.user.value == true ? 15.h 
          : 10.h, bottom: 8.h),
          child: controller.user.value == true
          ? Row(
            children: [
              Text('3',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w400,
                  color: darkGray,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(width: 6.w,),
              SvgPicture.asset('assets/icons/svg/Vector.svg', height: 18.h, width: 18.w),
              SizedBox(width: 10.w,),
              Text('#Makeup, #Beauty Product, #SkinCare',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w300,
                  color: darkGray,
                  fontSize: 10.sp,
                ),
              ),
            ],
          ) : Row(
            children: [
              IntrinsicWidth(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
                          child: Text('Rising Club',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              color: darkGray,
                              fontSize: ScreenUtil().setSp(14),
                              height: 0.19,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(5),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.h),
                          child: Icon(Icons.arrow_drop_down_sharp, size: 30.r,),
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        color: darkGray,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 2),
                            color: white,
                            blurRadius: 2.0,
                          ),
                        ]
                      ),
                    ),
                  ] 
                ),
              ),
              Padding(
              padding: EdgeInsets.only(top: 10.h, left: 8.w),
                child: Text('average cost per engagement (Rs. 100 - 150)',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w400,
                    color: Color(0xff0060FF),
                    fontSize: ScreenUtil().setSp(10),
                    height: 0.13,
                  )
                ),
              ),
            ],  
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: Row(
            children: [
              Expanded(
                flex: 12,
                child: Stack(
                  fit: StackFit.passthrough,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: lightGray, width: 2.0),
                        ),
                      ),
                    ),
                    TabBar(
                      tabs: [
                        Tab(
                          child: Text(
                            'New',
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Applied',
                          ),
                        ),
                        Tab(
                          child: Text(
                            'InProgress',
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Completed',
                          ),
                        ),
                      ],
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: black,
                      isScrollable: true,
                      unselectedLabelColor: darkGray,
                      labelColor: black,
                      labelStyle: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                      unselectedLabelStyle: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                      labelPadding: EdgeInsets.only(left: 4.w, right: 7.w),
                      controller: tabController1,
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: SvgPicture.asset(
                  "assets/icons/svg/search.svg",
                  height: 19.h,
                  width: 19.w,
                  color: lightGray,
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 15.w, top: 4.h),
                child: SvgPicture.asset(
                  "assets/icons/svg/jobfilter.svg",
                  height: 21.h,
                  width: 21.w,
                  color: darkGray,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: TabBarView(
              controller: tabController1,
              children: [
                NewClubOffers(user: controller.user.value),
                AppliedClubOffers(user: controller.user.value),
                InProgressClubOffers(user: controller.user.value),
                CompletedClubOffers(user: controller.user.value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}