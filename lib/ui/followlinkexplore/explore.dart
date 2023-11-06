import 'package:famelink/common/common_image.dart';
import 'package:famelink/ui/latest_profile/SayHiFirstVideo.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widget/followlinksayhi.dart';
import 'widget/followsuggest.dart';

class Followexplorepage extends StatelessWidget {
  const Followexplorepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SayHiFirstVideo(
                      links: "followlinks",
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Text(
                    "say Hi...",
                    style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  SizedBox(
                    height: 15.h,
                    width: 15.w,
                    child: Stack(
                      children: [
                        Image.asset(
                          CommonImage.funLinksStoreScanUI,
                          fit: BoxFit.fill,
                          color: black,
                        ),
                        Center(
                          child: Image.asset(
                            'assets/icons/circle.png',
                            height: 6.h,
                            width: 6.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(height: 150.h, child: followlinksayhi()),
          Padding(
            padding: EdgeInsets.only(right: 15.w, top: 10.h),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 1.h,
              color: lightGray,
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          Text(
            'Follow Suggestions',
            textAlign: TextAlign.center,
            style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.w700,
              color: darkGray,
              fontSize: ScreenUtil().setSp(14),
              height: 0.19,
            ),
          ),
          Container(height: 200.h, child: followsuggest()),
          Padding(
            padding: EdgeInsets.only(right: 15.w, top: 5.h),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 1.h,
              color: lightGray,
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          // Padding(
          //   padding: EdgeInsets.only(right: 15.w),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         'Invite Followers',
          //         style: GoogleFonts.nunitoSans(
          //           fontWeight: FontWeight.w700,
          //           color: darkGray,
          //           fontSize: ScreenUtil().setSp(14),
          //           height: 0.19,
          //         ),
          //       ),
          //       InkWell(
          //         onTap: () {
          //           show(context);
          //         },
          //         child: Container(
          //           height: 10.h,
          //           child: Text(
          //             'know the Rules',
          //             style: GoogleFonts.nunitoSans(
          //               fontWeight: FontWeight.w400,
          //               color: Color(0xff0060FF),
          //               fontSize: ScreenUtil().setSp(10),
          //               height: 0.13,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //     height: 180.h,
          //     child: ListView.builder(
          //         primary: false,
          //         shrinkWrap: true,
          //         itemCount: 5,
          //         scrollDirection: Axis.horizontal,
          //         physics: ClampingScrollPhysics(),
          //         padding: EdgeInsets.zero,
          //         itemBuilder: (context, i) {
          //           return Padding(
          //             padding: EdgeInsets.only(right: 18.w),
          //             child: Column(
          //               children: [
          //                 Padding(
          //                   padding: EdgeInsets.only(right: 8.w, top: 20.h),
          //                   child: Container(
          //                     height: ScreenUtil().setHeight(65),
          //                     width: ScreenUtil().setWidth(65),
          //                     decoration: BoxDecoration(shape: BoxShape.circle),
          //                     child: Image.asset("assets/icons/two.png"),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 18.h,
          //                 ),
          //                 Text(
          //                   'Sheema Kukria',
          //                   textAlign: TextAlign.center,
          //                   style: GoogleFonts.nunitoSans(
          //                     fontWeight: FontWeight.w700,
          //                     color: black,
          //                     fontSize: ScreenUtil().setSp(12),
          //                     height: 0.19,
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 18.h,
          //                 ),
          //                 Text(
          //                   'Jaipur',
          //                   textAlign: TextAlign.center,
          //                   style: GoogleFonts.nunitoSans(
          //                     fontWeight: FontWeight.w400,
          //                     color: darkGray,
          //                     fontSize: ScreenUtil().setSp(10),
          //                     height: 0.19,
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 10.h,
          //                 ),
          //                 Container(
          //                   height: 25.h,
          //                   width: 65.w,
          //                   decoration: BoxDecoration(
          //                     color: white.withOpacity(0.6),
          //                     borderRadius: BorderRadius.circular(4),
          //                     border: Border.all(color: lightGray),
          //                   ),
          //                   child: Center(
          //                     child: Text(
          //                       'Invite',
          //                       textAlign: TextAlign.left,
          //                       style: GoogleFonts.nunitoSans(
          //                         fontWeight: FontWeight.w400,
          //                         color: orange,
          //                         fontSize: ScreenUtil().setSp(12),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           );
          //         })),
          // Padding(
          //   padding: EdgeInsets.only(right: 15.w, top: 5.h),
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     height: 1.h,
          //     color: lightGray,
          //   ),
          // ),
          // SizedBox(
          //   height: 18.h,
          // ),
          // Padding(
          //   padding: EdgeInsets.only(right: 15.w),
          //   child: IntrinsicWidth(
          //     child: Column(
          //       children: [
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             SvgPicture.asset('assets/icons/svg/channel.svg'),
          //             SizedBox(
          //               width: 6.w,
          //             ),
          //             Text(
          //               'Channels',
          //               style: GoogleFonts.nunitoSans(
          //                 fontWeight: FontWeight.w600,
          //                 color: Color(0xff0060FF),
          //                 fontSize: ScreenUtil().setSp(14),
          //                 height: 1.2,
          //               ),
          //             ),
          //           ],
          //         ),
          //         SizedBox(height: 2.h),
          //         Container(color: lightGray, height: 2),
          //       ],
          //     ),
          //   ),
          // ),
          // SizedBox(height: 10.h),
          // Padding(
          //   padding: EdgeInsets.only(right: 15.w),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         '#Health & Fitness',
          //         style: GoogleFonts.nunitoSans(
          //           fontWeight: FontWeight.w700,
          //           color: darkGray,
          //           fontStyle: FontStyle.italic,
          //           fontSize: ScreenUtil().setSp(12),
          //         ),
          //       ),
          //       Container(
          //         height: 25.h,
          //         width: 65.w,
          //         decoration: BoxDecoration(
          //           color: white.withOpacity(0.6),
          //           borderRadius: BorderRadius.circular(4),
          //           border: Border.all(color: lightGray),
          //         ),
          //         child: Center(
          //           child: Text(
          //             'Follow',
          //             textAlign: TextAlign.left,
          //             style: GoogleFonts.nunitoSans(
          //               fontWeight: FontWeight.w400,
          //               color: orange,
          //               fontSize: ScreenUtil().setSp(12),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 10.h),
          // Container(
          //     height: 150.h,
          //     child: ListView.builder(
          //         primary: false,
          //         shrinkWrap: true,
          //         itemCount: 5,
          //         scrollDirection: Axis.horizontal,
          //         physics: ClampingScrollPhysics(),
          //         itemBuilder: (context, i) {
          //           return Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               Padding(
          //                 padding: EdgeInsets.only(right: 10.w),
          //                 child: Container(
          //                   height: ScreenUtil().setHeight(116),
          //                   width: ScreenUtil().setWidth(110),
          //                   child: Stack(
          //                     children: [
          //                       Image.asset("assets/icons/rect.png"),
          //                       Positioned(
          //                         top: 6.5.h,
          //                         left: 3.w,
          //                         child: Image.asset(
          //                           "assets/icons/girl.png",
          //                           height: ScreenUtil().setHeight(105),
          //                           width: ScreenUtil().setWidth(105),
          //                         ),
          //                       ),
          //                       Center(
          //                         child: Container(
          //                           height: 40.h,
          //                           width: 40.w,
          //                           decoration: BoxDecoration(
          //                               color: Colors.transparent,
          //                               shape: BoxShape.circle,
          //                               border: Border.all(
          //                                   color: white.withOpacity(0.5),
          //                                   width: 2.w)),
          //                           child: Icon(Icons.play_arrow,
          //                               color: white.withOpacity(0.5)),
          //                         ),
          //                       )
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //               SizedBox(
          //                 height: 5.h,
          //               ),
          //               Padding(
          //                 padding: EdgeInsets.only(right: 12.w),
          //                 child: Text(
          //                   'Sheema Kukria',
          //                   textAlign: TextAlign.center,
          //                   style: GoogleFonts.nunitoSans(
          //                     fontWeight: FontWeight.w400,
          //                     color: darkGray,
          //                     fontSize: ScreenUtil().setSp(13),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           );
          //         })),
          //
        ],
      ),
    );
  }

  void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.all(1.r),
              child: Container(
                  child: Material(
                type: MaterialType.transparency,
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Wrap(children: [
                            Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 60.h,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xffFFA88C),
                                              Color(0xffFF5C28)
                                            ],
                                            stops: [0.0, 1.0],
                                          ),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Rules to remember while inviting a user',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w700,
                                              color: white,
                                              fontSize: ScreenUtil().setSp(16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(height: 2.h, color: black),
                                    SizedBox(height: 30.h),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 15.w, right: 8.w),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 7.h),
                                            child: Container(
                                                height: 7.h,
                                                width: 7.w,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: black)),
                                          ),
                                          SizedBox(width: 8.w),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                80.w,
                                            child: Text(
                                              "You can send Follow Invite only once to any user.",
                                              maxLines: 3,
                                              style: GoogleFonts.nunitoSans(
                                                  fontSize:
                                                      ScreenUtil().setSp(14),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  // height: 0.16,
                                                  color: black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 15.w, right: 8.w),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 7.h),
                                            child: Container(
                                                height: 7.h,
                                                width: 7.w,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: black)),
                                          ),
                                          SizedBox(width: 8.w),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                80.w,
                                            child: Text(
                                              "You can cancel the Invite, but you won’t be able to send the invite to that user again",
                                              maxLines: 3,
                                              style: GoogleFonts.nunitoSans(
                                                  fontSize:
                                                      ScreenUtil().setSp(14),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  // height: 0.16,
                                                  color: black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 15.w, right: 8.w),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 7.h),
                                            child: Container(
                                                height: 7.h,
                                                width: 7.w,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: black)),
                                          ),
                                          SizedBox(width: 8.w),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                80.w,
                                            child: Text(
                                              "Once the invited user rejects your request, neither that person nor you can send/receive this request again.",
                                              maxLines: 3,
                                              style: GoogleFonts.nunitoSans(
                                                  fontSize:
                                                      ScreenUtil().setSp(14),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  // height: 0.16,
                                                  color: black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 15.w, right: 8.w),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 7.h),
                                            child: Container(
                                                height: 7.h,
                                                width: 7.w,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: black)),
                                          ),
                                          SizedBox(width: 8.w),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                80.w,
                                            child: Text(
                                              "However, they can search you and follow you as usual process.",
                                              maxLines: 3,
                                              style: GoogleFonts.nunitoSans(
                                                  fontSize:
                                                      ScreenUtil().setSp(14),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  // height: 0.16,
                                                  color: black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 15.w, right: 8.w),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 7.h),
                                            child: Container(
                                                height: 7.h,
                                                width: 7.w,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: black)),
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(
                                            "You can invite only 100 users per day.",
                                            style: GoogleFonts.nunitoSans(
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                // height: 0.16,
                                                color: black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 15.w, right: 8.w),
                                      child: Text(
                                        "Hence, please be sure to invite only those who you think would follow you basis your judgement.",
                                        style: GoogleFonts.nunitoSans(
                                            fontSize: ScreenUtil().setSp(14),
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            // height: 0.16,
                                            color: black),
                                      ),
                                    ),
                                    SizedBox(height: 30.h),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 30.h,
                                        width: 90.w,
                                        decoration: BoxDecoration(
                                          color: white.withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.blue),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'OK, Got it',
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w600,
                                              color: darkGray,
                                              fontSize: ScreenUtil().setSp(12),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30.h),
                                  ]),
                            )
                          ]))),
                ),
              )));
        });
  }
}
