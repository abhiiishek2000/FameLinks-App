// import 'dart:ui';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:famelink/common/common_image.dart';
// import 'package:famelink/dio/api/api.dart';
// import 'package:famelink/dio/api/apimanager.dart';
// import 'package:famelink/networking/config.dart';
// import 'package:famelink/ui/homedial/ui/homeDial.dart';
// import 'package:famelink/ui/joblinks/brandPage.dart';
// import 'package:famelink/ui/joblinks/hiringProfile.dart';
// import 'package:famelink/ui/joblinks/jobexplore.dart';
// import 'package:famelink/ui/joblinks/models/FameJobsModel.dart';
// import 'package:famelink/ui/Famelinkprofile/ProfileFameLink.dart';
// import 'package:famelink/ui/notification/notification_screen.dart';
// import 'package:famelink/ui/fameLinks/view/FameLinksFeed.dart';
// import 'package:famelink/ui/followLinks/ui/FollowLinksUserProfile.dart';
// import 'package:famelink/ui/funlinks/ui/FunLinksUserProfile.dart';
// import 'package:famelink/util/constants.dart';
// import 'package:famelink/util/config/color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:famelink/util/ReadMoreText.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:timeago/timeago.dart' as timeago;
//
// class FameJobs extends StatefulWidget {
//   String? value;
//   FameJobs({this.value});
//
//   @override
//   State<FameJobs> createState() => _FameJobsState();
// }
//
// class _FameJobsState extends State<FameJobs> {
//   Key keys = UniqueKey();
//   int index1 = 0;
//   bool isDarkMode = false;
//   static bool isProfileUI = false;
//   bool isOnPageTurning = false;
//   bool isOnPageHorizontalTurning = false;
//   var avtarImage;
//   String? profileFameLinksImage;
//   var profileImage;
//   var noImage;
//   String getPostName = 'jobLinks';
//
//   int page = 1;
//   int searchPage = 1;
//   ScrollController fameScrollController = ScrollController();
//   List<jobs> jobList = <jobs>[];
//   List<Map<String, String>> ageGroup = [
//     {
//       'groupA': '0-4',
//       'groupB': '4-12',
//       'groupC': '12-18',
//       'groupD': '18-28',
//       'groupE': '18-28',
//       'groupF': '28-40',
//       'groupG': '40-50',
//       'groupH': '50 -60',
//       'groupI': '60+'
//     }
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     init();
//     fameScrollController.addListener(() {
//       if (fameScrollController.position.maxScrollExtent ==
//           fameScrollController.position.pixels) {
//         page++;
//       }
//     });
//     if (widget.value != null) {
//       getSearch(widget.value);
//     } else {
//       getJobs();
//     }
//   }
//
//   init() async {
//     var sharedPreferences = await SharedPreferences.getInstance();
//     Constants.token = sharedPreferences.getString("token");
//     Constants.userType = sharedPreferences.getString("type");
//     Constants.userId = sharedPreferences.getString("id");
//     setState(() {});
//   }
//
//   void getJobs({pg}) async {
//     jobList.clear();
//     if (pg != null) {
//       page = pg;
//     }
//     Map<String, dynamic> param = {
//       "page": page.toString(),
//     };
//     Api.get.call(context,
//         method: "joblinks/feed",
//         param: param,
//         isLoading: false, onResponseSuccess: (Map object) {
//       var result = FameJobsModel.fromJson(object as Map<String, dynamic>);
//       if (result.result!.length > 0) {
//         jobList.addAll(result.result!);
//         setState(() {});
//         if (jobList != null) {
//           for (var item in jobList) {
//             if (item.applicationsStatus == null) {
//               item.applicationsStatus = 'apply';
//             }
//           }
//         }
//         print(jobList.length);
//       } else {
//         page == 1 ? page : page--;
//       }
//     }, onProgress: (double percentage) {}, contentType: '');
//   }
//
//   void getSearch(val) async {
//     jobList.clear();
//     Map<String, dynamic> param = {
//       "page": searchPage.toString(),
//     };
//     try {
//       Api.get.call(context,
//           method: "joblinks/searchJobs/$val",
//           param: param,
//           isLoading: false, onResponseSuccess: (Map object) {
//         var result = FameJobsModel.fromJson(object as Map<String, dynamic>);
//         if (result.result!.length > 0) {
//           jobList.addAll(result.result!);
//           setState(() {});
//           if (jobList != null) {
//             for (var item in jobList) {
//               if (item.applicationsStatus == null) {
//                 item.applicationsStatus = 'apply';
//               }
//             }
//           }
//           print(jobList.length);
//         } else {
//           searchPage == 1 ? searchPage : searchPage--;
//         }
//       }, onProgress: (double percentage) {}, contentType: '');
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<void> saveUnsaveJobs(action, id, index) async {
//     await ApiManager.post(
//             param: null, url1: "joblinks/saveUnsaveJob/$id?action=$action")
//         .then((value) async {
//       if (value.statusCode == 200) {
//         setState(() {
//           jobList[index].savedStatus = !jobList[index].savedStatus!;
//         });
//       } else {
//         print(value);
//       }
//     });
//   }
//
//   Future<void> applyJobs(id, index) async {
//     await ApiManager.post(param: null, url1: "/joblinks/applyJob/$id")
//         .then((value) async {
//       if (value.statusCode == 200) {
//         setState(() {
//           jobList[index].applicationsStatus = 'withdraw';
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               behavior: SnackBarBehavior.floating,
//               content: Text('Job applied successfuly'),
//               duration: const Duration(seconds: 2),
//             ),
//           );
//         });
//       } else {
//         print(value);
//       }
//     });
//   }
//
//   Future<void> withdrawJob(id, index) async {
//     await ApiManager.post(param: null, url1: "/joblinks/withdrawJob/$id")
//         .then((value) async {
//       if (value.statusCode == 200) {
//         setState(() {
//           jobList[index].applicationsStatus = 'apply';
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               behavior: SnackBarBehavior.floating,
//               content: Text('Job withdrawn successfuly'),
//               duration: const Duration(seconds: 2),
//             ),
//           );
//         });
//       } else {
//         print(value);
//       }
//     });
//   }
//
//   String capitalize(val) {
//     return val[0].toString().toUpperCase() + val.substring(1);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return KeyedSubtree(
//       key: keys,
//       child: Scaffold(
//           body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(CommonImage.dart_back_img),
//                 alignment: Alignment.center,
//                 fit: BoxFit.fill,
//               ),
//             ),
//             height: ScreenUtil().screenHeight,
//             width: ScreenUtil().screenWidth,
//           ),
//           jobList.length == 0
//               ? Center(
//                   child:
//                       CircularProgressIndicator(color: white, strokeWidth: 3))
//               : Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(
//                           top: ScreenUtil().setHeight(50),
//                           left: ScreenUtil().setWidth(12),
//                           right: ScreenUtil().setWidth(12),
//                           bottom: ScreenUtil().setHeight(12)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             height: ScreenUtil().setHeight(28),
//                             width: ScreenUtil().setWidth(28),
//                             decoration: BoxDecoration(
//                                 color: white.withOpacity(0.4),
//                                 borderRadius: BorderRadius.circular(7),
//                                 border: Border.all(
//                                     color: Colors.white.withOpacity(0.8))),
//                             child: Padding(
//                               padding: EdgeInsets.only(
//                                   top: ScreenUtil().setHeight(4)),
//                               child: SvgPicture.asset(
//                                 "assets/icons/svg/jobfilter.svg",
//                                 height: 20.21,
//                                 width: 20.21,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 top: ScreenUtil().setHeight(16)),
//                             child: RichText(
//                               text: TextSpan(
//                                 children: <TextSpan>[
//                                   TextSpan(
//                                     text: "Fame ",
//                                     style: GoogleFonts.nunitoSans(
//                                       fontSize: ScreenUtil().setSp(18),
//                                       fontWeight: FontWeight.w400,
//                                       fontStyle: FontStyle.normal,
//                                       height: 0.25,
//                                       shadows: <Shadow>[
//                                         Shadow(
//                                           offset: Offset(0.0, 2.0),
//                                           blurRadius: 2.0,
//                                           color: Color(0xff000000)
//                                               .withOpacity(0.25),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: "Jobs",
//                                     style: GoogleFonts.nunitoSans(
//                                       fontSize: ScreenUtil().setSp(18),
//                                       fontWeight: FontWeight.w700,
//                                       fontStyle: FontStyle.normal,
//                                       height: 0.25,
//                                       color: orange,
//                                       shadows: <Shadow>[
//                                         Shadow(
//                                           offset: Offset(0.0, 2.0),
//                                           blurRadius: 2.0,
//                                           color: Color(0xff000000)
//                                               .withOpacity(0.25),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => HiringProfile()),
//                               );
//                             },
//                             child: Container(
//                               height: ScreenUtil().setHeight(28),
//                               width: ScreenUtil().setWidth(28),
//                               decoration: BoxDecoration(
//                                   color: white.withOpacity(0.4),
//                                   borderRadius: BorderRadius.circular(7),
//                                   border: Border.all(
//                                       color: Colors.white.withOpacity(0.8))),
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                     bottom: ScreenUtil().setHeight(4),
//                                     left: ScreenUtil().setWidth(5)),
//                                 child: SvgPicture.asset(
//                                   "assets/icons/svg/jobedit.svg",
//                                   height: ScreenUtil().setHeight(16),
//                                   width: ScreenUtil().setWidth(16),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: Padding(
//                         padding: EdgeInsets.only(
//                             top: ScreenUtil().setHeight(4),
//                             right: ScreenUtil().setWidth(12)),
//                         child: RichText(
//                           text: TextSpan(
//                             children: <TextSpan>[
//                               TextSpan(
//                                 text: "2 ",
//                                 style: GoogleFonts.nunitoSans(
//                                   fontSize: ScreenUtil().setSp(15),
//                                   fontWeight: FontWeight.w700,
//                                   fontStyle: FontStyle.normal,
//                                   height: 0.25,
//                                   color: orange,
//                                   shadows: <Shadow>[
//                                     Shadow(
//                                       offset: Offset(0.0, 2.0),
//                                       blurRadius: 2.0,
//                                       color:
//                                           Color(0xff000000).withOpacity(0.25),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: "Profile",
//                                 style: GoogleFonts.nunitoSans(
//                                   fontSize: ScreenUtil().setSp(12),
//                                   fontWeight: FontWeight.w400,
//                                   fontStyle: FontStyle.normal,
//                                   height: 0.25,
//                                   shadows: <Shadow>[
//                                     Shadow(
//                                       offset: Offset(0.0, 2.0),
//                                       blurRadius: 2.0,
//                                       color:
//                                           Color(0xff000000).withOpacity(0.25),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: EdgeInsets.only(
//                             top: ScreenUtil().setHeight(20),
//                             left: ScreenUtil().setWidth(12),
//                             right: ScreenUtil().setWidth(12)),
//                         child: ListView.builder(
//                           itemCount: jobList.length,
//                           shrinkWrap: true,
//                           padding: EdgeInsets.zero,
//                           primary: false,
//                           controller: fameScrollController,
//                           itemBuilder: (BuildContext context, int index) {
//                             for (var item in ageGroup) {
//                               for (var i in item.entries) {
//                                 if (jobList[index].ageGroup == i.key) {
//                                   jobList[index].ageGroup = i.value;
//                                 }
//                               }
//                             }
//                             return Padding(
//                               padding: EdgeInsets.only(
//                                   bottom: ScreenUtil().setHeight(16)),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: white.withOpacity(0.2),
//                                     borderRadius: BorderRadius.circular(12),
//                                     border: Border.all(
//                                         color: Colors.white.withOpacity(0.2))),
//                                 child: Column(
//                                   children: [
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                           top: ScreenUtil().setHeight(24),
//                                           left: ScreenUtil().setWidth(24)),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               IntrinsicWidth(
//                                                 child: Column(children: [
//                                                   Padding(
//                                                     padding: EdgeInsets.only(
//                                                         right: 10.w),
//                                                     child: Row(
//                                                       children: [
//                                                         Padding(
//                                                           padding: EdgeInsets.only(
//                                                               top: ScreenUtil()
//                                                                   .setHeight(
//                                                                       5)),
//                                                           child: Text(
//                                                             jobList[index]
//                                                                         .gender !=
//                                                                     null
//                                                                 ? capitalize(jobList[
//                                                                             index]
//                                                                         .gender) +
//                                                                     ", " +
//                                                                     jobList[index]
//                                                                         .ageGroup
//                                                                         .toString()
//                                                                 : capitalize(jobList[
//                                                                         index]
//                                                                     .experienceLevel),
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                             style: GoogleFonts
//                                                                 .nunitoSans(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w700,
//                                                               color: white,
//                                                               fontSize:
//                                                                   ScreenUtil()
//                                                                       .setSp(
//                                                                           18),
//                                                               height: 0.22,
//                                                               shadows: <Shadow>[
//                                                                 Shadow(
//                                                                   offset:
//                                                                       Offset(
//                                                                           0.0,
//                                                                           2.0),
//                                                                   blurRadius:
//                                                                       2.0,
//                                                                   color: Color(
//                                                                           0xff000000)
//                                                                       .withOpacity(
//                                                                           0.25),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         jobList[index]
//                                                                     .jobType ==
//                                                                 'crew'
//                                                             ? Container()
//                                                             : SizedBox(
//                                                                 width:
//                                                                     ScreenUtil()
//                                                                         .setWidth(
//                                                                             12),
//                                                               ),
//                                                         jobList[index]
//                                                                     .jobType ==
//                                                                 'crew'
//                                                             ? Container()
//                                                             : Padding(
//                                                                 padding: EdgeInsets.only(
//                                                                     top: ScreenUtil()
//                                                                         .setHeight(
//                                                                             5)),
//                                                                 child: Text(
//                                                                     jobList[index]
//                                                                             .height!
//                                                                             .foot
//                                                                             .toString() +
//                                                                         '’' +
//                                                                         jobList[index]
//                                                                             .height!
//                                                                             .inch
//                                                                             .toString() +
//                                                                         '”',
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .center,
//                                                                     style: GoogleFonts
//                                                                         .nunitoSans(
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w500,
//                                                                       color:
//                                                                           black,
//                                                                       fontSize:
//                                                                           ScreenUtil()
//                                                                               .setSp(16),
//                                                                       height:
//                                                                           0.22,
//                                                                       shadows: <
//                                                                           Shadow>[
//                                                                         Shadow(
//                                                                           offset: Offset(
//                                                                               0.0,
//                                                                               2.0),
//                                                                           blurRadius:
//                                                                               2.0,
//                                                                           color:
//                                                                               Color(0xff000000).withOpacity(0.25),
//                                                                         ),
//                                                                       ],
//                                                                     )),
//                                                               ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Padding(
//                                                     padding: EdgeInsets.only(
//                                                         top: 13.h),
//                                                     child: Container(
//                                                       height: 1,
//                                                       decoration: BoxDecoration(
//                                                           color: white,
//                                                           boxShadow: [
//                                                             BoxShadow(
//                                                               offset:
//                                                                   Offset(0, 2),
//                                                               color: white,
//                                                               blurRadius: 2.0,
//                                                             ),
//                                                           ]),
//                                                     ),
//                                                   ),
//                                                 ]),
//                                               ),
//                                               Spacer(),
//                                               Padding(
//                                                 padding: EdgeInsets.only(
//                                                     right: ScreenUtil()
//                                                         .setWidth(16)),
//                                                 child: Column(
//                                                   children: [
//                                                     SvgPicture.asset(
//                                                       "assets/icons/svg/photoshoot.svg",
//                                                       height: ScreenUtil()
//                                                           .setHeight(30),
//                                                       width: ScreenUtil()
//                                                           .setWidth(30),
//                                                       color: orange,
//                                                     ),
//                                                     SizedBox(
//                                                       height: ScreenUtil()
//                                                           .setHeight(8),
//                                                     ),
//                                                     Text(
//                                                         jobList[index]
//                                                                 .jobDetails![0]
//                                                                 .jobCategory ??
//                                                             'Print',
//                                                         textAlign:
//                                                             TextAlign.center,
//                                                         style: GoogleFonts
//                                                             .nunitoSans(
//                                                           fontWeight:
//                                                               FontWeight.w400,
//                                                           color: white,
//                                                           fontSize: ScreenUtil()
//                                                               .setSp(12),
//                                                           height: 0.16,
//                                                           shadows: <Shadow>[
//                                                             Shadow(
//                                                               offset: Offset(
//                                                                   0.0, 2.0),
//                                                               blurRadius: 2.0,
//                                                               color: Color(
//                                                                       0xff000000)
//                                                                   .withOpacity(
//                                                                       0.25),
//                                                             ),
//                                                           ],
//                                                         )),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Text(
//                                               jobList[index]
//                                                   .jobLocation!
//                                                   .district
//                                                   .toString(),
//                                               textAlign: TextAlign.center,
//                                               style: GoogleFonts.nunitoSans(
//                                                 fontWeight: FontWeight.w700,
//                                                 color: white,
//                                                 fontSize:
//                                                     ScreenUtil().setSp(14),
//                                                 shadows: <Shadow>[
//                                                   Shadow(
//                                                     offset: Offset(0.0, 2.0),
//                                                     blurRadius: 2.0,
//                                                     color: Color(0xff000000)
//                                                         .withOpacity(0.25),
//                                                   ),
//                                                 ],
//                                               )),
//                                           Padding(
//                                             padding: EdgeInsets.only(
//                                                 top: ScreenUtil().setHeight(24),
//                                                 left: ScreenUtil().setWidth(6),
//                                                 right:
//                                                     ScreenUtil().setWidth(6)),
//                                             child: Container(
//                                               height: 100.h,
//                                               width: MediaQuery.of(context)
//                                                   .size
//                                                   .width,
//                                               child: ListView.builder(
//                                                   primary: false,
//                                                   shrinkWrap: true,
//                                                   itemCount: 1,
//                                                   scrollDirection:
//                                                       Axis.horizontal,
//                                                   itemBuilder: (context, i) {
//                                                     return jobList[index]
//                                                                 .isSwipe ==
//                                                             true
//                                                         ? Column(
//                                                             children: [
//                                                               Row(
//                                                                 children: [
//                                                                   Container(
//                                                                     width: MediaQuery.of(context)
//                                                                             .size
//                                                                             .width -
//                                                                         79.5.w,
//                                                                     child: Text(
//                                                                       jobList[index]
//                                                                           .title
//                                                                           .toString(),
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .center,
//                                                                       maxLines:
//                                                                           2,
//                                                                       style: GoogleFonts
//                                                                           .nunitoSans(
//                                                                         fontWeight:
//                                                                             FontWeight.w700,
//                                                                         color:
//                                                                             white,
//                                                                         fontSize:
//                                                                             ScreenUtil().setSp(22),
//                                                                         height:
//                                                                             1.2,
//                                                                         shadows: <
//                                                                             Shadow>[
//                                                                           Shadow(
//                                                                             offset:
//                                                                                 Offset(0.0, 2.0),
//                                                                             blurRadius:
//                                                                                 2.0,
//                                                                             color:
//                                                                                 Color(0xff000000).withOpacity(0.25),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   // Spacer(),
//                                                                   InkWell(
//                                                                       onTap:
//                                                                           () {
//                                                                         setState(
//                                                                             () {
//                                                                           jobList[index].isSwipe =
//                                                                               false;
//                                                                         });
//                                                                       },
//                                                                       child:
//                                                                           Icon(
//                                                                         Icons
//                                                                             .arrow_forward_ios_rounded,
//                                                                         color: white
//                                                                             .withOpacity(0.8),
//                                                                         size: ScreenUtil()
//                                                                             .radius(15),
//                                                                       ))
//                                                                 ],
//                                                               ),
//                                                               SizedBox(
//                                                                 height:
//                                                                     ScreenUtil()
//                                                                         .setHeight(
//                                                                             20),
//                                                               ),
//                                                               Text(
//                                                                 "From " +
//                                                                     DateFormat(
//                                                                             'dd-MMM-yy')
//                                                                         .format(jobList[index]
//                                                                             .startDate!) +
//                                                                     " till " +
//                                                                     DateFormat(
//                                                                             'dd-MMM-yy')
//                                                                         .format(
//                                                                             jobList[index].endDate!),
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .center,
//                                                                 style: GoogleFonts
//                                                                     .nunitoSans(
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w600,
//                                                                   color: black,
//                                                                   fontSize:
//                                                                       ScreenUtil()
//                                                                           .setSp(
//                                                                               12),
//                                                                   height: 0.16,
//                                                                   shadows: <
//                                                                       Shadow>[
//                                                                     Shadow(
//                                                                       offset: Offset(
//                                                                           0.0,
//                                                                           2.0),
//                                                                       blurRadius:
//                                                                           2.0,
//                                                                       color: Color(
//                                                                               0xff000000)
//                                                                           .withOpacity(
//                                                                               0.25),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           )
//                                                         : Column(
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .start,
//                                                             children: [
//                                                               Row(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .start,
//                                                                 children: [
//                                                                   InkWell(
//                                                                     onTap: () {
//                                                                       setState(
//                                                                           () {
//                                                                         jobList[index].isSwipe =
//                                                                             true;
//                                                                       });
//                                                                     },
//                                                                     child:
//                                                                         Padding(
//                                                                       padding: EdgeInsets.only(
//                                                                           top: ScreenUtil()
//                                                                               .setHeight(7.5)),
//                                                                       child: Icon(
//                                                                           Icons
//                                                                               .arrow_back_ios_rounded,
//                                                                           color: white.withOpacity(
//                                                                               0.8),
//                                                                           size:
//                                                                               15),
//                                                                     ),
//                                                                   ),
//                                                                   SizedBox(
//                                                                     width: ScreenUtil()
//                                                                         .setWidth(
//                                                                             10),
//                                                                   ),
//                                                                   Container(
//                                                                     width: MediaQuery.of(context)
//                                                                             .size
//                                                                             .width -
//                                                                         88.w,
//                                                                     child: Wrap(
//                                                                       children: [
//                                                                         Text(
//                                                                           // ReadMoreText(
//                                                                           jobList[index]
//                                                                               .description
//                                                                               .toString(),
//                                                                           // "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sapien volutpat massa quis feugiat consequat nisi mauris. Diam massa, sit aliquam amet, libero, auctor. Nulla facilisi lectus amet, magna in a tortor, consectetur eget.",
//                                                                           // trimLines: 4,
//                                                                           // trimMode: TrimMode.Line,
//                                                                           // colorClickableText: white,
//                                                                           style:
//                                                                               GoogleFonts.nunitoSans(
//                                                                             fontWeight:
//                                                                                 FontWeight.w400,
//                                                                             color:
//                                                                                 white,
//                                                                             fontSize:
//                                                                                 ScreenUtil().setSp(14),
//                                                                             height:
//                                                                                 1.2,
//                                                                             shadows: <Shadow>[
//                                                                               Shadow(
//                                                                                 offset: Offset(0.0, 2.0),
//                                                                                 blurRadius: 2.0,
//                                                                                 color: Color(0xff000000).withOpacity(0.25),
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                               SizedBox(
//                                                                   height: ScreenUtil()
//                                                                       .setHeight(
//                                                                           20)),
//                                                               Padding(
//                                                                 padding: EdgeInsets.only(
//                                                                     left: ScreenUtil()
//                                                                         .setWidth(
//                                                                             24)),
//                                                                 child: Text(
//                                                                   "Deadline: " +
//                                                                       DateFormat(
//                                                                               'dd-MMM-yy')
//                                                                           .format(
//                                                                               jobList[index].deadline!),
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .left,
//                                                                   style: GoogleFonts
//                                                                       .nunitoSans(
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w400,
//                                                                     color:
//                                                                         white,
//                                                                     fontSize: ScreenUtil()
//                                                                         .setSp(
//                                                                             14),
//                                                                     height:
//                                                                         0.16,
//                                                                     shadows: <
//                                                                         Shadow>[
//                                                                       Shadow(
//                                                                         offset: Offset(
//                                                                             0.0,
//                                                                             2.0),
//                                                                         blurRadius:
//                                                                             2.0,
//                                                                         color: Color(0xff000000)
//                                                                             .withOpacity(0.25),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           );
//                                                   }),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: EdgeInsets.only(
//                                                 top:
//                                                     ScreenUtil().setHeight(31)),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 jobList[index].savedStatus ==
//                                                         true
//                                                     ? InkWell(
//                                                         onTap: () {
//                                                           saveUnsaveJobs(
//                                                               'unsave',
//                                                               jobList[index].id,
//                                                               index);
//                                                         },
//                                                         child: Icon(
//                                                           Icons.bookmark,
//                                                           color: white,
//                                                           size: 23.r,
//                                                         ))
//                                                     : InkWell(
//                                                         onTap: () {
//                                                           saveUnsaveJobs(
//                                                               'save',
//                                                               jobList[index].id,
//                                                               index);
//                                                         },
//                                                         child: Icon(
//                                                           Icons.bookmark_border,
//                                                           color: white,
//                                                           size: 23.r,
//                                                         )),
//                                                 InkWell(
//                                                     onTap: () {
//                                                       // applyJobs(jobList[index].id, index);
//                                                     },
//                                                     child: SvgPicture.asset(
//                                                         "assets/icons/svg/share.svg",
//                                                         color: white)),
//                                                 InkWell(
//                                                   onTap: () {
//                                                     if (jobList[index]
//                                                             .applicationsStatus ==
//                                                         'apply') {
//                                                       applyJobs(
//                                                           jobList[index].id,
//                                                           index);
//                                                     } else if (jobList[index]
//                                                             .applicationsStatus !=
//                                                         'hired') {
//                                                       setState(() {
//                                                         showDialog(
//                                                             context: context,
//                                                             builder:
//                                                                 (BuildContext
//                                                                     context) {
//                                                               return Dialog(
//                                                                   backgroundColor:
//                                                                       Colors
//                                                                           .transparent,
//                                                                   child: Container(
//                                                                       height: 200.h,
//                                                                       width: MediaQuery.of(context).size.width - 80.w,
//                                                                       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.r)),
//                                                                       child: Padding(
//                                                                         padding:
//                                                                             EdgeInsets.all(15.r),
//                                                                         child: Column(
//                                                                             children: [
//                                                                               Text(
//                                                                                 "Once you withdraw your application, you will not be able to apply to this job again?\n\nAre you sure you want to withdraw your application?",
//                                                                                 style: GoogleFonts.nunitoSans(fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, color: black),
//                                                                               ),
//                                                                               SizedBox(height: 35.h),
//                                                                               Row(
//                                                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                                                                 children: [
//                                                                                   InkWell(
//                                                                                     onTap: () {
//                                                                                       setState(() {
//                                                                                         Navigator.pop(context);
//                                                                                         withdrawJob(jobList[index].id, index);
//                                                                                       });
//                                                                                     },
//                                                                                     child: Text(
//                                                                                       "Yes",
//                                                                                       style: GoogleFonts.nunitoSans(fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, color: black),
//                                                                                     ),
//                                                                                   ),
//                                                                                   SizedBox(
//                                                                                     width: 40.w,
//                                                                                   ),
//                                                                                   InkWell(
//                                                                                     onTap: () {
//                                                                                       Navigator.pop(context);
//                                                                                     },
//                                                                                     child: Text(
//                                                                                       "No",
//                                                                                       style: GoogleFonts.nunitoSans(fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, color: darkGray),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ],
//                                                                               ),
//                                                                             ]),
//                                                                       )));
//                                                             });
//                                                       });
//                                                     }
//                                                   },
//                                                   child: jobList[index]
//                                                               .applicationsStatus ==
//                                                           'hired'
//                                                       ? Container()
//                                                       : Container(
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             color: white
//                                                                 .withOpacity(
//                                                                     0.6),
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         10),
//                                                             border: Border.all(
//                                                                 color: orange),
//                                                           ),
//                                                           child: Padding(
//                                                             padding: EdgeInsets.only(
//                                                                 left: ScreenUtil()
//                                                                     .setWidth(
//                                                                         24),
//                                                                 right:
//                                                                     ScreenUtil()
//                                                                         .setWidth(
//                                                                             24),
//                                                                 top: ScreenUtil()
//                                                                     .setHeight(
//                                                                         13),
//                                                                 bottom:
//                                                                     ScreenUtil()
//                                                                         .setHeight(
//                                                                             8)),
//                                                             child: Text(
//                                                               jobList[index]
//                                                                           .applicationsStatus ==
//                                                                       'apply'
//                                                                   ? 'Apply'
//                                                                   : 'Withdraw',
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: GoogleFonts
//                                                                   .nunitoSans(
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w600,
//                                                                 color: white,
//                                                                 fontSize:
//                                                                     ScreenUtil()
//                                                                         .setSp(
//                                                                             12),
//                                                                 height: 0.16,
//                                                                 shadows: <
//                                                                     Shadow>[
//                                                                   Shadow(
//                                                                     offset:
//                                                                         Offset(
//                                                                             0.0,
//                                                                             2.0),
//                                                                     blurRadius:
//                                                                         2.0,
//                                                                     color: Color(
//                                                                             0xff000000)
//                                                                         .withOpacity(
//                                                                             0.25),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(
//                                                       right: ScreenUtil()
//                                                           .setWidth(12)),
//                                                   child: Text(
//                                                     jobList[index].createdAt ==
//                                                             null
//                                                         ? ''
//                                                         : timeago.format(
//                                                             jobList[index]
//                                                                 .createdAt!),
//                                                     textAlign: TextAlign.left,
//                                                     style:
//                                                         GoogleFonts.nunitoSans(
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                       color: white,
//                                                       fontSize: ScreenUtil()
//                                                           .setSp(10),
//                                                       height: 0.13,
//                                                       shadows: <Shadow>[
//                                                         Shadow(
//                                                           offset:
//                                                               Offset(0.0, 2.0),
//                                                           blurRadius: 2.0,
//                                                           color:
//                                                               Color(0xff000000)
//                                                                   .withOpacity(
//                                                                       0.25),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           SizedBox(
//                                               height:
//                                                   ScreenUtil().setHeight(8)),
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                           color: white.withOpacity(0.6),
//                                           borderRadius:
//                                               BorderRadius.circular(12),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               offset: Offset(0.0, 8.0),
//                                               blurRadius: 30.0,
//                                               color: Color(0xff000000)
//                                                   .withOpacity(0.40),
//                                             )
//                                           ]),
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                             left: ScreenUtil().setWidth(16),
//                                             right: ScreenUtil().setWidth(24),
//                                             top: ScreenUtil().setHeight(13),
//                                             bottom: ScreenUtil().setHeight(8)),
//                                         child: Row(
//                                           children: [
//                                             jobList[index].createdBy == null
//                                                 ? Container()
//                                                 : CachedNetworkImage(
//                                                     imageUrl:
//                                                         '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${jobList[index].createdBy![0].profileImage}',
//                                                     imageBuilder: (context,
//                                                             imageProvider) =>
//                                                         Container(
//                                                       width: 60.h,
//                                                       height: 60.w,
//                                                       decoration: BoxDecoration(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(16.r),
//                                                         image: DecorationImage(
//                                                             image:
//                                                                 imageProvider,
//                                                             fit: BoxFit.cover),
//                                                       ),
//                                                     ),
//                                                     errorWidget:
//                                                         (context, url, error) {
//                                                       print(
//                                                           "ER::${error.toString()}");
//                                                       return Icon(Icons.error,
//                                                           color: white);
//                                                     },
//                                                     fit: BoxFit.cover,
//                                                     height: ScreenUtil()
//                                                         .setHeight(60),
//                                                     width: ScreenUtil()
//                                                         .setWidth(60),
//                                                   ),
//                                             SizedBox(
//                                               width: ScreenUtil().setWidth(12),
//                                             ),
//                                             Text(
//                                               jobList[index].createdBy == null
//                                                   ? ''
//                                                   : jobList[index]
//                                                       .createdBy![0]
//                                                       .name
//                                                       .toString(),
//                                               textAlign: TextAlign.left,
//                                               style: GoogleFonts.nunitoSans(
//                                                 fontWeight: FontWeight.w700,
//                                                 color: black,
//                                                 fontSize:
//                                                     ScreenUtil().setSp(14),
//                                                 height: 0.19,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     // CircularProgressIndicator(color: white, strokeWidth: 2)
//                   ],
//                 ),
//
//           Positioned(
//             bottom: 0.0,
//             right: 27.0,
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 24.0),
//               child: InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (ontext) => NotificationScreen()),
//                   );
//                 },
//                 child: Image.asset(
//                   'assets/icons/notifications.png',
//                   height: 24,
//                   width: 24,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//           ),
//
//           Positioned(
//             bottom: 130.0,
//             left: 0.0,
//             child: InkWell(
//               onTap: () async {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => JobExplore()),
//                 ).then((value) => getJobs(pg: 1));
//               },
//               child: Container(
//                 margin: EdgeInsets.only(
//                   bottom: ScreenUtil().setHeight(8),
//                 ),
//                 decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.25),
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 7.0,
//                         color: black.withOpacity(0.2),
//                         offset: Offset(2.0, 2.0),
//                       ),
//                     ],
//                     border: Border.all(
//                       color: Colors.white.withOpacity(0.25),
//                     ),
//                     borderRadius: BorderRadius.only(
//                         topRight: Radius.circular(20),
//                         bottomRight: Radius.circular(5))),
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                       left: ScreenUtil().setWidth(8),
//                       right: ScreenUtil().setWidth(8),
//                       bottom: ScreenUtil().setHeight(8),
//                       top: ScreenUtil().setHeight(8)),
//                   child: SvgPicture.asset(
//                     "assets/icons/svg/search.svg",
//                     color: white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           isProfileUI == false
//               ? Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Padding(
//                     padding: EdgeInsets.only(bottom: 77.h),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: <Widget>[
//                         circleButtonImage(
//                           imgUrl: (true)
//                               ? CommonImage.dark_jobLink_icon
//                               : (true)
//                                   ? "assets/icons/darkFamelinkIcon.png"
//                                   : "assets/icons/logo.png",
//                           onTaps: () {
//                             setState(() {
//                               // onClickPageImage = !onClickPageImage;
//                               isProfileUI = true;
//                             });
//                           },
//                           isButtonSelect: true,
//                         ),
//                         Container(
//                           height: 2.0,
//                           width: 10.0,
//                           color: Color(0xFF9B9B9B),
//                         )
//                       ],
//                     ),
//                   ),
//                 )
//               : Container(),
//           Positioned(
//             child: Visibility(
//               visible: (isProfileUI == true),
//               child: InkWell(
//                 onTap: () {
//                   setState(() {
//                     isProfileUI = false;
//                   });
//                 },
//                 child: Container(
//                   height: ScreenUtil().screenHeight,
//                   width: ScreenUtil().screenWidth,
//                   color: Colors.black45,
//                 ),
//               ),
//             ),
//           ),
//           //isProfileUI==true?SizedBox(height: 20,):Container(),
//           Visibility(
//             visible: (isProfileUI == true),
//             child: Positioned(
//               bottom: -35,
//               right: -40.0,
//               child: Container(
//                 height: 300,
//                 width: 250,
//                 child: Stack(
//                   clipBehavior: Clip.none,
//                   fit: StackFit.loose,
//                   alignment: Alignment.center,
//                   children: <Widget>[
//                     Positioned(
//                       child: SizedBox(
//                         height: 164,
//                         width: 164,
//                         child: Image.asset(
//                           "assets/images/commonOuterCircle.png",
//                         ),
//                       ),
//                       right: 10,
//                     ),
//
//                     // top Fame Links
//                     Positioned(
//                       right: 25,
//                       child: InkWell(
//                         onTap: () {
//                           setState(() {
//                             isProfileUI = false;
//                           });
//                           Navigator.push<void>(
//                             context,
//                             MaterialPageRoute<void>(
//                                 builder: (BuildContext context) =>
//                                     ProfileFameLink(
//                                       runSelectPhase: 3,
//                                     )),
//                             // ModalRoute.withName('/'),
//                           );
//                         },
//                         child: SizedBox(
//                             height: 120,
//                             width: 120,
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 30, top: 13),
//                               child: Stack(
//                                 children: [
//                                   Padding(
//                                       padding: EdgeInsets.only(bottom: 12.h),
//                                       child: profileFameLinksImage == null
//                                           ? avtarImage != null
//                                               ? Container(
//                                                   height: 90,
//                                                   width: 90,
//                                                   child: Center(
//                                                     child: CircleAvatar(
//                                                       backgroundImage:
//                                                           NetworkImage(
//                                                               avtarImage),
//                                                       backgroundColor:
//                                                           Colors.transparent,
//                                                       radius: 50,
//                                                     ),
//                                                   ),
//                                                 )
//                                               : profileImage != null
//                                                   ? Container(
//                                                       height: 90,
//                                                       width: 90,
//                                                       child: CircleAvatar(
//                                                         backgroundImage:
//                                                             NetworkImage(
//                                                                 profileImage),
//                                                         backgroundColor:
//                                                             Colors.transparent,
//                                                         radius: 50,
//                                                       ),
//                                                     )
//                                       : Container(
//                                         height: 95.h,
//                                         width: 95.w,
//                                         decoration: BoxDecoration(
//                                           gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
//                                             lightRedWhite,
//                                             lightRed
//                                           ]),
//                                           shape: BoxShape.circle,
//                                         ),
//                                       )
//                                                   // : Column(
//                                                   //     crossAxisAlignment:
//                                                   //         CrossAxisAlignment
//                                                   //             .center,
//                                                   //     mainAxisAlignment:
//                                                   //         MainAxisAlignment
//                                                   //             .center,
//                                                   //     children: [
//                                                   //       Image.asset(
//                                                   //           "assets/images/feather_upload.png"),
//                                                   //       SizedBox(
//                                                   //         height: 8,
//                                                   //       ),
//                                                   //       Text(
//                                                   //         "Your Avatar",
//                                                   //         style: TextStyle(
//                                                   //           fontSize: 12,
//                                                   //           color: Color(
//                                                   //               0xFF9B9B9B),
//                                                   //         ),
//                                                   //       )
//                                                   //     ],
//                                                   //   )
//                                           : Container(
//                                               height: 90,
//                                               width: 90,
//                                               child: CircleAvatar(
//                                                 backgroundImage: NetworkImage(
//                                                     profileFameLinksImage!),
//                                                 backgroundColor:
//                                                     Colors.transparent,
//                                                 radius: 50,
//                                               ),
//                                             )),
//                                   Image.asset(
//                                     (isDarkMode != true)
//                                         ? CommonImage.dark_inner_circle_icon
//                                         : "assets/images/commonInnerCircle.png",
//                                   ),
//                                 ],
//                               ),
//                             )),
//                       ),
//                     ),
//                     Positioned(
//                       // top: -160.0,
//                       // left: -109.0,
//                       right: 85.0,
//                       bottom: 210.0,
//                       child: SizedBox(
//                         height: 30,
//                         width: 115,
//                         child: InkWell(
//                           onTap: () {
//                             debugPrint("******************* Follow Links Work");
//                             setState(() {
//                               HomeDialState.selectRegistration =
//                                   RegistrationType.FAMELinks.toString();
//
//                               isProfileUI = false;
//                               getPostName = "fameLinks";
//                               Navigator.of(context).pushAndRemoveUntil(
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           FameLinksFeed()),
//                                   (Route<dynamic> route) => false);
//                             });
//                           },
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 decoration: (HomeDialState.selectRegistration
//                                             .toString() ==
//                                         RegistrationType.FAMELinks.toString())
//                                     ? BoxDecoration(
//                                         image: DecorationImage(
//                                           image: AssetImage(
//                                             CommonImage.darkButtonBackIcon,
//                                           ),
//                                           fit: BoxFit.fill,
//                                         ),
//                                       )
//                                     : BoxDecoration(
//                                         image: DecorationImage(
//                                           image: AssetImage(
//                                             CommonImage.secondBundleIcon,
//                                           ),
//                                           fit: BoxFit.fill,
//                                         ),
//                                       ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 6.0,
//                                       right: 6.0,
//                                       top: 2.0,
//                                       bottom: 2.0),
//                                   child: Text(
//                                     "FameLinks",
//                                     style: GoogleFonts.nunitoSans(
//                                       fontWeight: FontWeight.w400,
//                                       fontStyle: FontStyle.normal,
//                                       color: (HomeDialState.selectRegistration
//                                                   .toString() ==
//                                               RegistrationType.FAMELinks
//                                                   .toString())
//                                           ? Colors.white
//                                           : HexColor("#030C23"),
//                                       fontSize: 14.0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 3,
//                               ),
//                               (HomeDialState.selectRegistration.toString() ==
//                                       RegistrationType.FAMELinks.toString())
//                                   ? circleButtonImageStack(
//                                       isButtonSelect: true,
//                                       imgUrl: (true)
//                                           ? "assets/icons/darkFamelinkIcon.png"
//                                           : (isDarkMode == true)
//                                               ? "assets/icons/darkFamelinkIcon.png"
//                                               : "assets/icons/logo.png",
//                                     )
//                                   : circleButtonImageStack(
//                                       imgUrl: (isDarkMode == true)
//                                           ? "assets/icons/darkFamelinkIcon.png"
//                                           : "assets/icons/logo.png",
//                                     ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     // left FunLinks
//                     Positioned(
//                       // top: -80.0,
//                       right: 125.0,
//                       // left: -170.0,
//                       bottom: 160.0,
//                       child: InkWell(
//                         onTap: () {
//                           debugPrint("*************** FunLinks");
//                           setState(() {
//                             getPostName = "funLinks";
//                           });
//                         },
//                         child: SizedBox(
//                           height: 30,
//                           width: 110,
//                           child: InkWell(
//                             onTap: () {
//                               debugPrint("*************** FunLinks");
//                               setState(() {
//                                 getPostName = "funLinks";
//                                 HomeDialState.selectRegistration =
//                                     RegistrationType.FUNLinks.toString();
//
//                                 isProfileUI = false;
//                                 Navigator.of(context).pushAndRemoveUntil(
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             FunLinksUserProfile()),
//                                     (Route<dynamic> route) => false);
//                                 // key = UniqueKey();
//                               });
//                             },
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   decoration: (HomeDialState.selectRegistration
//                                               .toString() ==
//                                           RegistrationType.FUNLinks.toString())
//                                       ? BoxDecoration(
//                                           image: DecorationImage(
//                                             image: AssetImage(
//                                               CommonImage.darkButtonBackIcon,
//                                             ),
//                                             fit: BoxFit.fill,
//                                           ),
//                                         )
//                                       : BoxDecoration(
//                                           image: DecorationImage(
//                                             image: AssetImage(
//                                               CommonImage.secondBundleIcon,
//                                             ),
//                                             fit: BoxFit.fill,
//                                           ),
//                                         ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 6.0,
//                                         right: 6.0,
//                                         top: 2.0,
//                                         bottom: 2.0),
//                                     child: Text(
//                                       "FunLinks",
//                                       style: GoogleFonts.nunitoSans(
//                                         fontWeight: FontWeight.w400,
//                                         fontStyle: FontStyle.normal,
//                                         color: (HomeDialState.selectRegistration
//                                                     .toString() ==
//                                                 RegistrationType.FUNLinks
//                                                     .toString())
//                                             ? Colors.white
//                                             : HexColor("#030C23"),
//                                         fontSize: 14.0,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 (HomeDialState.selectRegistration.toString() ==
//                                         RegistrationType.FUNLinks.toString())
//                                     ? circleButtonImageStack(
//                                         isButtonSelect: true,
//                                         imgUrl: (true)
//                                             ? CommonImage.dark_videoLink_icon
//                                             : (isDarkMode == true)
//                                                 ? CommonImage
//                                                     .dark_videoLink_icon
//                                                 : "assets/icons/funLinks.png",
//                                       )
//                                     : circleButtonImageStack(
//                                         imgUrl: (isDarkMode == true)
//                                             ? CommonImage.dark_videoLink_icon
//                                             : "assets/icons/funLinks.png",
//                                       ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       // right: MediaQuery.of(context).size.width/2,
//                     ),
//                     // // right FollowLinks
//                     Positioned(
//                       child: SizedBox(
//                         height: 30,
//                         width: 145,
//                         child: InkWell(
//                           onTap: () {
//                             setState(() {
//                               getPostName = "followLinks";
//                               HomeDialState.selectRegistration =
//                                   RegistrationType.FOLLOWLinks.toString();
//                               // key = UniqueKey();
//                               isProfileUI = false;
//                               Navigator.of(context).pushAndRemoveUntil(
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           FollowLinksUserProfile()),
//                                   (Route<dynamic> route) => false);
//                             });
//                           },
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 decoration: (HomeDialState.selectRegistration
//                                             .toString() ==
//                                         RegistrationType.FOLLOWLinks.toString())
//                                     ? BoxDecoration(
//                                         image: DecorationImage(
//                                           image: AssetImage(
//                                             CommonImage.darkButtonBackIcon,
//                                           ),
//                                           fit: BoxFit.fill,
//                                         ),
//                                       )
//                                     : BoxDecoration(
//                                         image: DecorationImage(
//                                           image: AssetImage(
//                                             CommonImage.secondBundleIcon,
//                                           ),
//                                           fit: BoxFit.fill,
//                                         ),
//                                       ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 6.0,
//                                       right: 6.0,
//                                       top: 2.0,
//                                       bottom: 2.0),
//                                   child: Text(
//                                     "FollowLinks",
//                                     style: GoogleFonts.nunitoSans(
//                                       fontWeight: FontWeight.w400,
//                                       fontStyle: FontStyle.normal,
//                                       color: (HomeDialState.selectRegistration
//                                                   .toString() ==
//                                               RegistrationType.FOLLOWLinks
//                                                   .toString())
//                                           ? Colors.white
//                                           : HexColor("#030C23"),
//                                       fontSize: 14.0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               (HomeDialState.selectRegistration.toString() ==
//                                       RegistrationType.FOLLOWLinks.toString())
//                                   ? circleButtonImageStack(
//                                       isButtonSelect: true,
//                                       imgUrl: (true)
//                                           ? CommonImage.dark_follower_icon
//                                           : (isDarkMode == true)
//                                               ? CommonImage.dark_follower_icon
//                                               : "assets/icons/followLinks.png",
//                                     )
//                                   : circleButtonImageStack(
//                                       imgUrl: (isDarkMode == true)
//                                           ? CommonImage.dark_follower_icon
//                                           : "assets/icons/followLinks.png",
//                                     ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       // top: 40.0,
//                       // right: 0.0,
//                       // left: -200.0,
//                       right: 115.0,
//                       // left: -170.0,
//                       bottom: 105.0,
//                       // right: MediaQuery.of(context).size.width/2,
//                     ),
//                     // JobLinks
//                     Positioned(
//                       child: SizedBox(
//                         height: 30,
//                         width: 80,
//                         child: InkWell(
//                           onTap: () async {
//                             HomeDialState.selectRegistration =
//                                 RegistrationType.JOBLinks.toString();
//                             setState(() {
//                               isProfileUI = false;
//                             });
//                             // var sharedPreferences = await SharedPreferences.getInstance();
//                             // Constants.userType = sharedPreferences.getString("type");
//                             // Navigator.pushReplacement(
//                             //   context,
//                             //   MaterialPageRoute(builder: (context) => FameJobs()),
//                             // );
//                           },
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 decoration: (HomeDialState.selectRegistration
//                                             .toString() ==
//                                         RegistrationType.JOBLinks.toString())
//                                     ? BoxDecoration(
//                                         image: DecorationImage(
//                                           image: AssetImage(
//                                             CommonImage.darkButtonBackIcon,
//                                           ),
//                                           fit: BoxFit.fill,
//                                         ),
//                                       )
//                                     : BoxDecoration(
//                                         image: DecorationImage(
//                                           image: AssetImage(
//                                             CommonImage.secondBundleIcon,
//                                           ),
//                                           fit: BoxFit.fill,
//                                         ),
//                                       ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 6.0,
//                                       right: 6.0,
//                                       top: 2.0,
//                                       bottom: 2.0),
//                                   child: Text(
//                                     "JobLinks",
//                                     style: GoogleFonts.nunitoSans(
//                                       fontWeight: FontWeight.w400,
//                                       fontStyle: FontStyle.normal,
//                                       color: (HomeDialState.selectRegistration
//                                                   .toString() ==
//                                               RegistrationType.JOBLinks
//                                                   .toString())
//                                           ? Colors.white
//                                           : HexColor("#030C23"),
//                                       fontSize: 14.0,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               (HomeDialState.selectRegistration.toString() ==
//                                       RegistrationType.JOBLinks.toString())
//                                   ? circleButtonImageStack(
//                                       isButtonSelect: true,
//                                       imgUrl: (true)
//                                           ? CommonImage.dark_jobLink_icon
//                                           : (isDarkMode == true)
//                                               ? CommonImage.dark_jobLink_icon
//                                               : "assets/icons/vector.png",
//                                     )
//                                   : circleButtonImageStack(
//                                       imgUrl: (isDarkMode == true)
//                                           ? CommonImage.dark_jobLink_icon
//                                           : "assets/icons/vector.png",
//                                     ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       // top: 135.0,
//                       right: 0.0,
//                       left: -25.0,
//                       bottom: 60.0,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       )),
//     );
//   }
//
//   Widget circleButtonImage({
//     String? imgUrl,
//     bool isButtonSelect = false,
//     void Function()? onTaps,
//   }) =>
//       InkWell(
//         onTap: onTaps,
//         child: Container(
//           width: 60,
//           height: 60,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: (isButtonSelect == true)
//                   ? AssetImage((isButtonSelect == true)
//                       ? CommonImage.selected_circle_back
//                       : CommonImage.unSelected_circle_back)
//                   : AssetImage(
//                       (isDarkMode == true)
//                           ? CommonImage.dark_circle_avatar_back
//                           : CommonImage.light_circle_avatar_back,
//                     ),
//               fit: BoxFit.fill,
//             ),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(18.0),
//             child: SizedBox(
//               width: 30,
//               height: 28,
//               child: Image.asset(
//                 imgUrl.toString(),
//                 width: 30,
//                 height: 28,
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//         ),
//       );
//
//   Widget circleButtonImageStack({
//     String? imgUrl,
//     bool isButtonSelect = false,
//   }) =>
//       InkWell(
//         child: Container(
//           width: 30,
//           height: 30,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.white,
//             border: Border.all(
//                 color:(isButtonSelect == true)
//                     ? Color(0xffFF9D76)
//                     : black
//             ),
//             image: DecorationImage(
//               image: AssetImage(
//                 (isButtonSelect == true)
//                     ? CommonImage.selected_circle_back
//                     : CommonImage.lightButtonBackIcon,
//               ),
//               fit: BoxFit.fill,
//             ),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(8.0),
//             child: SizedBox(
//               width: 18,
//               height: 18,
//               child: Image.asset(
//                 imgUrl.toString(),
//                 width: 18,
//                 height: 18,
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//         ),
//       );
// }
