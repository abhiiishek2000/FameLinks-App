import 'package:famelink/ui/otherUserProfile/component/OtherprofileContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';
import '../../util/config/color.dart';
import 'application/brandDetailApplication.dart';
import 'createjob/createJob.dart';

class Screentest extends StatelessWidget {
  const Screentest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: jobs()));
  }

  jobs() {
    return MyContainer(
      child: ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        primary: false,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(ScreenUtil().setHeight(12)),
            child: MyContainer(
              // decoration: BoxDecoration(
              //     color: white.withOpacity(0.2),
              //     borderRadius: BorderRadius.circular(12),
              //     border: Border.all(color: Colors.white.withOpacity(0.2))),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(10),
                        left: ScreenUtil().setWidth(24)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IntrinsicWidth(
                              child: Column(children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 14.5.h, right: 10.w),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Female, 18-28 yrs ',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w700,
                                          color: white,
                                          fontSize: ScreenUtil().setSp(16),
                                          height: 0.22,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(0.0, 2.0),
                                              blurRadius: 2.0,
                                              color: Color(0xff000000)
                                                  .withOpacity(0.25),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(
                                      //   width: ScreenUtil().setWidth(12),
                                      // ),
                                      Text('5’ 6”',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            color: black,
                                            fontSize: ScreenUtil().setSp(16),
                                            height: 0.22,
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 2.0),
                                                blurRadius: 2.0,
                                                color: Color(0xff000000)
                                                    .withOpacity(0.25),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 13.h),
                                  child: Container(
                                    height: 1,
                                    decoration:
                                        BoxDecoration(color: white, boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 2),
                                        color: white,
                                        blurRadius: 2.0,
                                      ),
                                    ]),
                                  ),
                                ),
                              ]),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: Container(
                                height: 50.h,
                                width: 105.w,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: ScreenUtil().setWidth(12),
                                        top: ScreenUtil().setWidth(10)),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/svg/photoshoot.svg",
                                          height: ScreenUtil().setHeight(25),
                                          width: ScreenUtil().setWidth(25),
                                          color: orange,
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(10),
                                        ),
                                        Text('Print',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: white,
                                              fontSize: ScreenUtil().setSp(12),
                                              height: 0.16,
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(0.0, 2.0),
                                                  blurRadius: 2.0,
                                                  color: Color(0xff000000)
                                                      .withOpacity(0.25),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(20),
                                right: ScreenUtil().setWidth(12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Mumbai',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      color: white,
                                      fontSize: ScreenUtil().setSp(14),
                                      height: 0.19,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 2.0,
                                          color: Color(0xff000000)
                                              .withOpacity(0.25),
                                        ),
                                      ],
                                    )),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(24),
                              right: ScreenUtil().setWidth(6)),
                          child: Container(
                            height: 100.h,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: 2,
                                scrollDirection: Axis.horizontal,
                                // controller: _scroll,
                                itemBuilder: (context, i1) {
                                  return i1 == 0
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 330.w,
                                                    child: Text(
                                                      'Models required for Ethenic Wear shoot',
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: white,
                                                        fontSize: ScreenUtil()
                                                            .setSp(22),
                                                        height: 1.2,
                                                        shadows: <Shadow>[
                                                          Shadow(
                                                            offset: Offset(
                                                                0.0, 2.0),
                                                            blurRadius: 2.0,
                                                            color: Color(
                                                                    0xff000000)
                                                                .withOpacity(
                                                                    0.25),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  // Spacer(),
                                                  InkWell(
                                                      onTap: () {
                                                        // setState(() {
                                                        //   // scr(1);
                                                        // });
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        color: white
                                                            .withOpacity(0.8),
                                                        size: ScreenUtil()
                                                            .radius(15),
                                                      ))
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(20),
                                              ),
                                              Text(
                                                'From 15-Sep-21 till 20-Sep-21',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w600,
                                                  color: black,
                                                  fontSize:
                                                      ScreenUtil().setSp(12),
                                                  height: 0.16,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 2.0),
                                                      blurRadius: 2.0,
                                                      color: Color(0xff000000)
                                                          .withOpacity(0.25),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    // setState(() {
                                                    //   // scr(0);
                                                    // });
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: ScreenUtil()
                                                            .setHeight(15)),
                                                    child: Icon(
                                                        Icons
                                                            .arrow_back_ios_rounded,
                                                        color: white
                                                            .withOpacity(0.8),
                                                        size: 15),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      ScreenUtil().setWidth(10),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      88,
                                                  child: Text(
                                                    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                                    // trimLines: 4,
                                                    // trimMode: TrimMode.Line,
                                                    // colorClickableText: white,
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: white,
                                                      fontSize: ScreenUtil()
                                                          .setSp(14),
                                                      height: 1.2,
                                                      shadows: <Shadow>[
                                                        Shadow(
                                                          offset:
                                                              Offset(0.0, 2.0),
                                                          blurRadius: 2.0,
                                                          color:
                                                              Color(0xff000000)
                                                                  .withOpacity(
                                                                      0.25),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(20)),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: ScreenUtil()
                                                      .setWidth(24)),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Deadline: 13-Sep-21',
                                                    textAlign: TextAlign.left,
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: white,
                                                      fontSize: ScreenUtil()
                                                          .setSp(14),
                                                      height: 0.16,
                                                      shadows: <Shadow>[
                                                        Shadow(
                                                          offset:
                                                              Offset(0.0, 2.0),
                                                          blurRadius: 2.0,
                                                          color:
                                                              Color(0xff000000)
                                                                  .withOpacity(
                                                                      0.25),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 30.0),
                                                    child: Text(
                                                      'Close',
                                                      textAlign: TextAlign.left,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: white,
                                                        fontSize: ScreenUtil()
                                                            .setSp(14),
                                                        height: 0.16,
                                                        shadows: <Shadow>[
                                                          Shadow(
                                                            offset: Offset(
                                                                0.0, 2.0),
                                                            blurRadius: 2.0,
                                                            color: Color(
                                                                    0xff000000)
                                                                .withOpacity(
                                                                    0.25),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                }),
                          ),
                        ),
                        // Padding(
                        //   padding:
                        //       EdgeInsets.only(top: ScreenUtil().setHeight(31)),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.only(top: 4.0),
                        //         child: Text(
                        //           'Faces',
                        //           textAlign: TextAlign.left,
                        //           style: GoogleFonts.nunitoSans(
                        //             fontWeight: FontWeight.w700,
                        //             color: white,
                        //             fontSize: ScreenUtil().setSp(14),
                        //             height: 0.16,
                        //             shadows: <Shadow>[
                        //               Shadow(
                        //                 offset: Offset(0.0, 2.0),
                        //                 blurRadius: 2.0,
                        //                 color:
                        //                     Color(0xff000000).withOpacity(0.25),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       Spacer(),
                        //       SvgPicture.asset("assets/icons/svg/share.svg",
                        //           color: white),
                        //       Spacer(),
                        //       InkWell(
                        //         onTap: () {
                        //           Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) => CreateJob()),
                        //           );
                        //         },
                        //         child: Container(
                        //           height: 30.h,
                        //           width: 90.w,
                        //           decoration: BoxDecoration(
                        //             color: white.withOpacity(0.6),
                        //             borderRadius: BorderRadius.circular(10),
                        //             border: Border.all(color: orange),
                        //           ),
                        //           child: Center(
                        //             child: Text(
                        //               'Edit Job',
                        //               textAlign: TextAlign.left,
                        //               style: GoogleFonts.nunitoSans(
                        //                 fontWeight: FontWeight.w600,
                        //                 color: white,
                        //                 fontSize: ScreenUtil().setSp(12),
                        //                 shadows: <Shadow>[
                        //                   Shadow(
                        //                     offset: Offset(0.0, 2.0),
                        //                     blurRadius: 2.0,
                        //                     color: Color(0xff000000)
                        //                         .withOpacity(0.25),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Spacer(),
                        //       Spacer(),
                        //       Padding(
                        //         padding: EdgeInsets.only(
                        //             right: ScreenUtil().setWidth(12)),
                        //         child: Padding(
                        //           padding: EdgeInsets.only(
                        //               top: ScreenUtil().setHeight(3)),
                        //           child: Text(
                        //             '3 days ago',
                        //             textAlign: TextAlign.left,
                        //             style: GoogleFonts.nunitoSans(
                        //               fontWeight: FontWeight.w400,
                        //               color: white,
                        //               fontSize: ScreenUtil().setSp(10),
                        //               height: 0.13,
                        //               shadows: <Shadow>[
                        //                 Shadow(
                        //                   offset: Offset(0.0, 2.0),
                        //                   blurRadius: 2.0,
                        //                   color: Color(0xff000000)
                        //                       .withOpacity(0.25),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            'Faces',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(12),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            // print("share click");
                            // String? name;
                            // if (provider.selectPhase == 0) {
                            //   name = "otherprofilefame";
                            // } else if (provider.selectPhase == 1) {
                            //   name = "otherprofilefun";
                            // } else {
                            //   name = "otherprofilefollow";
                            // }
                            // provider.sharedilog(true);
                            // await Sharedynamic.shareprofile(
                            //     provider.profileFameLinksModelResult
                            //         .result![0].masterUser!.sId!,
                            //     name,
                            //     provider.profileFameLinksModelResult
                            //         .result![0].name!
                            //         .toString());
                            // provider.sharedilog(false);
                          },
                          child:
                              //false ? Container(width: 30, child: spinkit):
                              Image.asset(
                            'assets/icons/share.png',
                            color: Colors.white,
                            height: 22.h,
                            width: 22.w,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                              padding: EdgeInsets.only(
                                  left: 6.w, right: 6.w, top: 2.h, bottom: 2.h),
                              decoration: BoxDecoration(
                                  border: Border.all(color: orange),
                                  borderRadius: BorderRadius.circular(4.r)),
                              alignment: Alignment.center,
                              child: Text(
                                'Edit Job',
                                style: GoogleFonts.nunitoSans(
                                  fontSize: 12.sp,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  color: white,
                                ),
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            right: 10,
                          ),
                          child: Text(
                            '3 days ago',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0.0, 8.0),
                            blurRadius: 30.0,
                            color: Color(0xff000000).withOpacity(0.40),
                          )
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(5),
                        right: ScreenUtil().setWidth(5),
                        // top: ScreenUtil().setHeight(5),
                        // bottom: ScreenUtil().setHeight(5)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BrandDetailApplication()),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10, top: 5),
                                  child: Text(
                                    'Applications',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(12),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 50.h,
                                      width: MediaQuery.of(context).size.width -
                                          100.w,
                                      child: ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: 5,
                                          scrollDirection: Axis.horizontal,
                                          // controller: _scroll,
                                          itemBuilder: (context, i2) {
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10.w),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: Offset(0, 2),
                                                          color: black,
                                                          blurRadius: 2.r,
                                                        ),
                                                      ]),
                                                  child: Image.asset(
                                                    "assets/icons/two.png",
                                                    height: 40.h,
                                                    width: 40.h,
                                                  )),
                                            );
                                          }),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.w),
                                      child: Text(
                                        '20 more',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w400,
                                          color: white,
                                          fontSize: ScreenUtil().setSp(12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
