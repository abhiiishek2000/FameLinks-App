import 'package:famelink/providers/JobLinks/ambassadors_provider.dart';
import 'package:famelink/ui/HallOfFameScreen.dart';
import 'package:famelink/ui/contestants/contestant_screen.dart';
import 'package:famelink/ui/joblinks/howitworks.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Ambassadors extends StatefulWidget {
  int? i;

  Ambassadors({Key? key, this.i}) : super(key: key);

  @override
  State<Ambassadors> createState() => _AmbassadorsState();
}

class _AmbassadorsState extends State<Ambassadors> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<GetAmbassadorsProvider>(context, listen: false).index = widget.i!;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetAmbassadorsProvider>(builder: (context, ambassadors, child) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 50.h, left: ambassadors.getIndex == 0 ? 0 : 16.w, right: ambassadors.getIndex == 0 ? 0 : 16.w),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: ambassadors.getIndex == 0 ? 16.w : 0, right: ambassadors.getIndex == 0 ? 16.w : 0),
                    child: IntrinsicHeight(
                      child: Row(children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        ambassadors.getIndex == 0
                            ? InkWell(
                                onTap: () {
                                  ambassadors.changeIndex(0);
                                },
                                child: Text(
                                  'Contestants',
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: orange,
                                    fontSize: ScreenUtil().setSp(24),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  ambassadors.changeIndex(0);
                                },
                                child: Image.asset('assets/icons/Contestants.png', height: 20.h, width: 25.w)),
                        Spacer(),
                        ambassadors.getIndex == 0 || ambassadors.getIndex == 1 ? VerticalDivider(color: lightGray) : Container(),
                        Spacer(),
                        ambassadors.getIndex == 1
                            ? InkWell(
                                onTap: () {
                                  ambassadors.changeIndex(1);
                                },
                                child: Text(
                                  'Hall of Fame',
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: orange,
                                    fontSize: ScreenUtil().setSp(24),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  ambassadors.changeIndex(1);
                                },
                                child: Image.asset("assets/icons/logo.png", height: 20.h, width: 25.w, color: lightGray)),
                        Spacer(),
                        ambassadors.getIndex == 1 || ambassadors.getIndex == 2 ? VerticalDivider(color: lightGray) : Container(),
                        Spacer(),
                        ambassadors.getIndex == 2
                            ? InkWell(
                                onTap: () {
                                  ambassadors.changeIndex(2);
                                },
                                child: Text(
                                  'Ambassadors',
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff0060FF),
                                    fontSize: ScreenUtil().setSp(24),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  ambassadors.changeIndex(2);
                                },
                                child: Icon(Icons.stars, size: 20.r, color: lightGray)),
                        Spacer(),
                        ambassadors.getIndex == 2 || ambassadors.getIndex == 3 ? VerticalDivider(color: lightGray) : Container(),
                        Spacer(),
                        ambassadors.getIndex == 3
                            ? InkWell(
                                onTap: () {
                                  ambassadors.changeIndex(3);
                                },
                                child: Text(
                                  'How it Works',
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: black,
                                    fontSize: ScreenUtil().setSp(24),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  ambassadors.changeIndex(3);
                                },
                                child: Image.asset('assets/icons/Help.png', height: 20.h, width: 25.w)),
                      ]),
                    ),
                  ),
                  Container(
                      height: 1.h,
                      width: MediaQuery.of(context).size.width - 50.w,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                        Color(0xff9B9B9B).withOpacity(0.0),
                        Color(0xff9B9B9B),
                        Color(0xff9B9B9B),
                        Color(0xff9B9B9B).withOpacity(0.0),
                      ])))
                ],
              ),
              ambassadors.getIndex == 0
                  ? Expanded(child: SingleChildScrollView(child: ContestantScreen()))
                  : ambassadors.getIndex == 1
                      ? Expanded(
                          child: Scaffold(
                              body: Padding(
                          padding: EdgeInsets.only(top: 40.h),
                          child: Text(
                              'FameLinks Contest have not yet started. Please check this page later once the Contest Winners are declared and the Winners are featured here',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              )),
                        )))
                      :
                      // child: SingleChildScrollView(child: HallOfFameScreen())) :
                      ambassadors.getIndex == 3
                          ? HowItWorks()
                          : Expanded(
                              child: Scaffold(
                                  body: Padding(
                              padding: EdgeInsets.only(top: 40.h),
                              child: Text(
                                  'FameLinks Ambassadors Trendz is in progress. Please check this page later once the Ambassadors are declared and the Winners are featured here.',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  )),
                            )))
              // : ambassadors(),
            ],
          ),
        ),
      );
    });
  }

  Expanded ambassadors() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(children: [
              IntrinsicWidth(
                  child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'India',
                        style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w400, color: darkGray, fontSize: ScreenUtil().setSp(16), height: 2.5),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(25),
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(height: 10, width: 10, child: Icon(Icons.arrow_drop_up_outlined)),
                          ),
                          InkWell(onTap: () {}, child: Container(height: 10, width: 10, child: Icon(Icons.arrow_drop_down_sharp))),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: darkGray,
                ),
              ])),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(top: 15.h, bottom: 2.h),
                child: SvgPicture.asset(
                  "assets/icons/svg/search.svg",
                  height: 19.h,
                  width: 19.w,
                  color: lightGray,
                ),
              ),
              SizedBox(width: 32.w),
              Padding(
                padding: EdgeInsets.only(right: 15.w, top: 17.h),
                child: SvgPicture.asset(
                  "assets/icons/svg/jobfilter.svg",
                  height: 21.h,
                  width: 21.w,
                  color: darkGray,
                ),
              ),
            ]),
            SizedBox(height: 16.h),
            Text(
              'To become our Brand Ambassador, please participate in Ambassador Trendz',
              style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w400,
                color: orange,
                fontStyle: FontStyle.italic,
                fontSize: ScreenUtil().setSp(10),
              ),
            ),
            SizedBox(height: 16.h),
            ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: 5,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Consumer<GetAmbassadorsProvider>(builder: (context, ambassadors, child) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: lightGray),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.r),
                            child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(
                                'Madhya Pradesh',
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700,
                                  color: black,
                                  fontSize: ScreenUtil().setSp(12),
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Container(
                                height: 1.h,
                                color: lightGray,
                              ),
                              SizedBox(height: 12.h),
                              GridView.builder(
                                padding: EdgeInsets.zero,
                                primary: false,
                                scrollDirection: Axis.vertical,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 0,
                                ),
                                itemCount: Provider.of<GetAmbassadorsProvider>(context).getIsClicked == true ? 6 : 3,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext ctx, index) {
                                  return Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/icons/two.png",
                                        height: 60.h,
                                        width: 60.h,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Text(
                                        'Kulwant Jatra',
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w700,
                                          color: black,
                                          fontSize: ScreenUtil().setSp(12),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        'Madhya Pradesh',
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w400,
                                          color: darkGray,
                                          fontSize: ScreenUtil().setSp(10),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              Provider.of<GetAmbassadorsProvider>(context).getIsClicked == true
                                  ? Align(
                                      alignment: Alignment.center,
                                      child: InkWell(
                                          onTap: () {
                                            Provider.of<GetAmbassadorsProvider>(context).changeIsClicked(false);
                                          },
                                          child: Icon(Icons.keyboard_arrow_up_rounded, color: darkGray)))
                                  : Align(
                                      alignment: Alignment.center,
                                      child: InkWell(
                                          onTap: () {
                                            Provider.of<GetAmbassadorsProvider>(context).changeIsClicked(true);
                                          },
                                          child: Icon(Icons.keyboard_arrow_down_rounded, color: darkGray)))
                            ]),
                          )),
                    );
                  });
                })
          ],
        ),
      ),
    );
  }
}
