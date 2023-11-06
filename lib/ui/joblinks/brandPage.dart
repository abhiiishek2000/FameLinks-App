// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:famelink/dio/api/api.dart';
// import 'package:famelink/dio/api/apimanager.dart';
// import 'package:famelink/networking/config.dart';
// import 'package:famelink/ui/joblinks/TalentFeedPost.dart';
// import 'package:famelink/ui/joblinks/brandDetailApplication.dart';
// import 'package:famelink/ui/joblinks/brandExplore.dart';
// import 'package:famelink/ui/joblinks/createJob.dart';
// import 'package:famelink/ui/joblinks/models/FeedModel.dart';
// import 'package:famelink/ui/joblinks/reportDialog.dart';
// import 'package:famelink/util/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:famelink/common/common_image.dart';
// import 'package:famelink/ui/homedial/ui/homeDial.dart';
// import 'package:famelink/ui/joblinks/hiringProfile.dart';
// import 'package:famelink/ui/Famelinkprofile/ProfileFameLink.dart';
// import 'package:famelink/ui/notification/notification_screen.dart';
// import 'package:famelink/ui/fameLinks/view/FameLinksFeed.dart';
// import 'package:famelink/ui/followLinks/ui/FollowLinksUserProfile.dart';
// import 'package:famelink/ui/funlinks/ui/FunLinksUserProfile.dart';
// import 'package:famelink/util/config/color.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:intl/intl.dart';
// import '../home_feed/component/home_feed.dart';
// import 'package:timeago/timeago.dart' as timeago;
// import 'package:video_player/video_player.dart';
//
// class BrandPage extends StatefulWidget {
//   final user;
//   BrandPage(this.user);
//
//   @override
//   State<BrandPage> createState() => _BrandPageState();
// }
//
// class _BrandPageState extends State<BrandPage> {
//   bool isDarkMode = false;
//   static bool isProfileUI = false;
//   bool isOnPageTurning = false;
//   bool isOnPageHorizontalTurning = false;
//   var avtarImage;
//   late String profileFameLinksImage;
//   var profileImage;
//   var noImage;
//   String getPostName = 'jobLinks';
//   final _scroll = ScrollController();
//   final _scroll1 = ScrollController();
//   List list = ['Explore Talents', 'Fame Jobs', 'Open Jobs', 'Past Jobs'];
//   List brandList = ['Explore Talents', '', 'Open Jobs', 'Past Jobs'];
//   int index1 = 0;
//   int imgIndex = 0;
//   bool isLoading = false;
//   bool isJobClicked = true;
//   int page = 1;
//   ScrollController fameScrollController = ScrollController();
//   List<Talents> talentList = <Talents>[];
//   List<Jobs> jobList = <Jobs>[];
//   List<OpenJobs> openJobList = <OpenJobs>[];
//   List<ClosedJobs> closedJobList = <ClosedJobs>[];
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
//   List<VideoPlayerController> _controller = [];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setState(() {
//       HomeFeedState.selectRunType =
//       "joblinks";
//     });
//     fameScrollController.addListener(() {
//       if (fameScrollController.position.maxScrollExtent ==
//           fameScrollController.position.pixels) {
//         page++;
//       }
//     });
//     getJobs();
//   }
//
//   void getJobs() async {
//     talentList.clear();
//     jobList.clear();
//     openJobList.clear();
//     closedJobList.clear();
//     Map<String, dynamic> param = {
//       "page": page.toString(),
//     };
//     isLoading = true;
//     Api.get.call(context,
//         method: "joblinks/feed",
//         param: param,
//         isLoading: false, onResponseSuccess: (Map object) {
//           var result = FeedModel.fromJson(object as Map<String,dynamic>);
//           if (result.result!.talents!.length > 0) {
//             talentList.addAll(result.result!.talents!);
//             for (var item in talentList) {
//               _controller.add(VideoPlayerController.network(
//                   '${ApiProvider.joblinks}${item.profile!.greetVideo}')
//                 ..addListener(() {
//                   for (var items in _controller) {
//                     if (items.value.position == items.value.duration) {
//                       print('video Ended');
//                       if (mounted) {
//                         setState(() {
//                           item.isPlaying = false;
//                         });
//                       }
//                     }
//                   }
//                 })
//                 ..initialize());
//             }
//             setState(() {});
//           } else {
//             page == 1 ? page : page--;
//           }
//
//           if (result.result!.jobs!.length > 0) {
//             jobList.addAll(result.result!.jobs!);
//             setState(() {});
//           } else {
//             page == 1 ? page : page--;
//           }
//
//           if (result.result!.openJobs!.length > 0) {
//             openJobList.addAll(result.result!.openJobs!);
//             setState(() {});
//           } else {
//             page == 1 ? page : page--;
//           }
//
//           if (result.result!.closedJobs!.length > 0) {
//             closedJobList.addAll(result.result!.closedJobs!);
//             setState(() {});
//           } else {
//             page == 1 ? page : page--;
//           }
//           isLoading = false;
//         }, onProgress: (double percentage) {  }, contentType: '');
//   }
//
//   Future<void> saveUnsaveJobs(action, id, index) async {
//     await ApiManager.post(
//         param: null, url1: "joblinks/saveUnsaveJob/$id?action=$action")
//         .then((value) async {
//       if (value.statusCode == 200) {
//         setState(() {
//           jobList[index].savedStatus = jobList[index].savedStatus!;
//         });
//       } else {
//         print(value);
//       }
//     });
//   }
//
//   Future<void> saveUnsaveTalents(action, id, index) async {
//     dynamic body = {
//       'userId': '"$id"',
//       'save': action,
//     };
//     await ApiManager.post(param: body, url1: "joblinks/saveTalent")
//         .then((value) async {
//       if (value.statusCode == 200) {
//         setState(() {
//           talentList[index].saved = talentList[index].saved!;
//         });
//       } else {
//         print(value);
//       }
//     });
//   }
//
//   Future<void> invite(id, index) async {
//     await ApiManager.post(param: {}, url1: "/joblinks/invitation/send/$id")
//         .then((value) async {
//       if (value.statusCode == 200) {
//         setState(() {
//           print(value);
//           talentList[index].invitationStatus = true;
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
//           jobList[index].isApplied = true;
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
//   Future<void> closeOpenJob(val, id) async {
//     dynamic param = {
//       'close': val.toString(),
//     };
//     await ApiManager.post(param: param, url1: "/joblinks/closeJob/$id")
//         .then((value) async {
//       if (value.statusCode == 200) {
//         setState(() {
//           getJobs();
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
//     return Scaffold(
//         body: Stack(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(CommonImage.dart_back_img),
//                   alignment: Alignment.center,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               height: ScreenUtil().screenHeight,
//               width: ScreenUtil().screenWidth,
//             ),
//             Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(
//                       top: ScreenUtil().setHeight(50),
//                       left: ScreenUtil().setWidth(12),
//                       right: ScreenUtil().setWidth(12),
//                       bottom: ScreenUtil().setHeight(12)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       isJobClicked == true ? Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 top: ScreenUtil().setHeight(100)),
//                             child: Text(
//                               "Coming Soon",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(fontSize: 30, color: orange),
//                             ),
//                           ),
//                         ],
//                       ) : Container(
//                         height: ScreenUtil().setHeight(28),
//                         width: ScreenUtil().setWidth(28),
//                         decoration: BoxDecoration(
//                             color: white.withOpacity(0.4),
//                             borderRadius: BorderRadius.circular(7),
//                             border:
//                             Border.all(color: Colors.white.withOpacity(0.8))),
//                         child: Padding(
//                           padding: EdgeInsets.only(top: ScreenUtil().setHeight(4)),
//                           child: SvgPicture.asset(
//                             "assets/icons/svg/jobfilter.svg",
//                             height: 20.21,
//                             width: 20.21,
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             height: 25,
//                             width: MediaQuery.of(context).size.width - 200,
//                             child: ListView.builder(
//                                 controller: _scroll,
//                                 itemCount: widget.user == 'brand'
//                                     ? brandList.length
//                                     : list.length,
//                                 shrinkWrap: true,
//                                 padding: EdgeInsets.zero,
//                                 primary: false,
//                                 scrollDirection: Axis.horizontal,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   return InkWell(
//                                     onTap: () {
//                                       setState(() {
//                                         index1 = index;
//                                         print(index1);
//                                       });
//                                     },
//                                     child: Padding(
//                                       padding: EdgeInsets.only(
//                                           top: ScreenUtil().setHeight(16),
//                                           left: ScreenUtil().setWidth(8)),
//                                       child: RichText(
//                                         text: TextSpan(
//                                           children: <TextSpan>[
//                                             TextSpan(
//                                               text: widget.user == 'brand'
//                                                   ? index == 1
//                                                   ? ""
//                                                   : brandList[index]
//                                                   .toString()
//                                                   .substring(
//                                                   0,
//                                                   brandList[index]
//                                                       .indexOf(" ", 0))
//                                                   : list[index]
//                                                   .toString()
//                                                   .substring(
//                                                   0,
//                                                   list[index]
//                                                       .indexOf(" ", 0)),
//                                               style: GoogleFonts.nunitoSans(
//                                                 fontSize: ScreenUtil().setSp(
//                                                     index1 == index ? 18 : 14),
//                                                 fontWeight: index1 == index
//                                                     ? FontWeight.w700
//                                                     : FontWeight.w400,
//                                                 fontStyle: FontStyle.normal,
//                                                 height: 0.25,
//                                                 color: index1 == index
//                                                     ? white
//                                                     : lightGray,
//                                                 shadows: <Shadow>[
//                                                   Shadow(
//                                                     offset: Offset(0.0, 2.0),
//                                                     blurRadius: 2.0,
//                                                     color: Color(0xff000000)
//                                                         .withOpacity(0.25),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             TextSpan(
//                                               text: widget.user == 'agency'
//                                                   ? index == 0
//                                                   ? 'Talents'
//                                                   : 'Jobs'
//                                                   : index == 1
//                                                   ? ""
//                                                   : index == 0
//                                                   ? 'Talents'
//                                                   : 'Jobs',
//                                               style: GoogleFonts.nunitoSans(
//                                                 fontSize: ScreenUtil().setSp(
//                                                     index1 == index ? 18 : 14),
//                                                 fontWeight: index1 == index
//                                                     ? FontWeight.w700
//                                                     : FontWeight.w400,
//                                                 fontStyle: FontStyle.normal,
//                                                 height: 0.25,
//                                                 color: index1 == index
//                                                     ? orange
//                                                     : lightGray,
//                                                 shadows: <Shadow>[
//                                                   Shadow(
//                                                     offset: Offset(0.0, 2.0),
//                                                     blurRadius: 2.0,
//                                                     color: Color(0xff000000)
//                                                         .withOpacity(0.25),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                           ),
//                           SizedBox(
//                             width: 20,
//                           ),
//                           InkWell(
//                             onTap: () {
//                               _scroll.animateTo(
//                                   MediaQuery.of(context).size.width * 3,
//                                   duration: const Duration(seconds: 1),
//                                   curve: Curves.easeIn);
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 3.0),
//                               child: Icon(Icons.arrow_forward_ios_rounded,
//                                   color: lightGray, size: 16),
//                             ),
//                           ),
//                         ],
//                       ),
//                       widget.user == 'agency' && index1 == 1
//                           ? InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => HiringProfile()),
//                           );
//                         },
//                         child: Container(
//                           height: ScreenUtil().setHeight(28),
//                           width: ScreenUtil().setWidth(28),
//                           decoration: BoxDecoration(
//                               color: white.withOpacity(0.4),
//                               borderRadius: BorderRadius.circular(7),
//                               border: Border.all(
//                                   color: Colors.white.withOpacity(0.8))),
//                           child: Padding(
//                             padding: EdgeInsets.only(
//                                 bottom: ScreenUtil().setHeight(4),
//                                 left: ScreenUtil().setWidth(5)),
//                             child: SvgPicture.asset(
//                               "assets/icons/svg/jobedit.svg",
//                               height: ScreenUtil().setHeight(16),
//                               width: ScreenUtil().setWidth(16),
//                             ),
//                           ),
//                         ),
//                       )
//                           : InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => CreateJob()),
//                           );
//                         },
//                         child: Container(
//                           height: ScreenUtil().setHeight(28),
//                           width: ScreenUtil().setWidth(28),
//                           decoration: BoxDecoration(
//                               color: white.withOpacity(0.4),
//                               borderRadius: BorderRadius.circular(7)),
//                           child: Image.asset(
//                             "assets/icons/plusIcon.png",
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 widget.user == 'agency' && index1 == 1
//                     ? Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                         top: ScreenUtil().setHeight(4),
//                         right: ScreenUtil().setWidth(12)),
//                     child: RichText(
//                       text: TextSpan(
//                         children: <TextSpan>[
//                           TextSpan(
//                             text: "1 ",
//                             style: GoogleFonts.nunitoSans(
//                               fontSize: ScreenUtil().setSp(15),
//                               fontWeight: FontWeight.w700,
//                               fontStyle: FontStyle.normal,
//                               height: 0.25,
//                               color: orange,
//                               shadows: <Shadow>[
//                                 Shadow(
//                                   offset: Offset(0.0, 2.0),
//                                   blurRadius: 2.0,
//                                   color: Color(0xff000000).withOpacity(0.25),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           TextSpan(
//                             text: "Profile",
//                             style: GoogleFonts.nunitoSans(
//                               fontSize: ScreenUtil().setSp(12),
//                               fontWeight: FontWeight.w400,
//                               fontStyle: FontStyle.normal,
//                               height: 0.25,
//                               shadows: <Shadow>[
//                                 Shadow(
//                                   offset: Offset(0.0, 2.0),
//                                   blurRadius: 2.0,
//                                   color: Color(0xff000000).withOpacity(0.25),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//                     : Container(),
//                 widget.user == 'agency' && index1 == 1
//                     ? Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                         top: ScreenUtil().setHeight(20),
//                         left: ScreenUtil().setWidth(12),
//                         right: ScreenUtil().setWidth(12)),
//                     child: ListView.builder(
//                       itemCount: jobList.length,
//                       shrinkWrap: true,
//                       padding: EdgeInsets.zero,
//                       primary: false,
//                       controller: fameScrollController,
//                       itemBuilder: (BuildContext context, int index) {
//                         for (var item in ageGroup) {
//                           for (var i in item.entries) {
//                             if (jobList[index].ageGroup == i.key) {
//                               jobList[index].ageGroup = i.value;
//                             }
//                           }
//                         }
//                         return Padding(
//                           padding: EdgeInsets.only(
//                               bottom: ScreenUtil().setHeight(16)),
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: white.withOpacity(0.2),
//                                 borderRadius: BorderRadius.circular(12),
//                                 border: Border.all(
//                                     color: Colors.white.withOpacity(0.2))),
//                             child: Column(
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                       top: ScreenUtil().setHeight(24),
//                                       left: ScreenUtil().setWidth(24)),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                         children: [
//                                           IntrinsicWidth(
//                                             child: Column(children: [
//                                               Padding(
//                                                 padding: EdgeInsets.only(
//                                                     right: 10.w),
//                                                 child: Row(
//                                                   children: [
//                                                     Padding(
//                                                       padding: EdgeInsets.only(
//                                                           top: ScreenUtil()
//                                                               .setHeight(5)),
//                                                       child: Text(
//                                                         jobList[index]
//                                                             .gender !=
//                                                             null
//                                                             ? capitalize(jobList[
//                                                         index]
//                                                             .gender) +
//                                                             ", " +
//                                                             jobList[index]
//                                                                 .ageGroup
//                                                                 .toString()
//                                                             : capitalize(jobList[
//                                                         index]
//                                                             .experienceLevel),
//                                                         textAlign:
//                                                         TextAlign.center,
//                                                         style: GoogleFonts
//                                                             .nunitoSans(
//                                                           fontWeight:
//                                                           FontWeight.w700,
//                                                           color: white,
//                                                           fontSize:
//                                                           ScreenUtil()
//                                                               .setSp(18),
//                                                           height: 0.22,
//                                                           shadows: <Shadow>[
//                                                             Shadow(
//                                                               offset: Offset(
//                                                                   0.0, 2.0),
//                                                               blurRadius: 2.0,
//                                                               color: Color(
//                                                                   0xff000000)
//                                                                   .withOpacity(
//                                                                   0.25),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     jobList[index].jobType ==
//                                                         'crew'
//                                                         ? Container()
//                                                         : SizedBox(
//                                                       width:
//                                                       ScreenUtil()
//                                                           .setWidth(
//                                                           12),
//                                                     ),
//                                                     jobList[index].jobType ==
//                                                         'crew'
//                                                         ? Container()
//                                                         : Padding(
//                                                       padding: EdgeInsets.only(
//                                                           top: ScreenUtil()
//                                                               .setHeight(
//                                                               5)),
//                                                       child: Text(
//                                                           jobList[index]
//                                                               .height!
//                                                               .foot
//                                                               .toString() +
//                                                               '’' +
//                                                               jobList[index]
//                                                                   .height!
//                                                                   .inch
//                                                                   .toString() +
//                                                               '”',
//                                                           textAlign:
//                                                           TextAlign
//                                                               .center,
//                                                           style: GoogleFonts
//                                                               .nunitoSans(
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .w500,
//                                                             color:
//                                                             black,
//                                                             fontSize: ScreenUtil()
//                                                                 .setSp(
//                                                                 16),
//                                                             height:
//                                                             0.22,
//                                                             shadows: <
//                                                                 Shadow>[
//                                                               Shadow(
//                                                                 offset: Offset(
//                                                                     0.0,
//                                                                     2.0),
//                                                                 blurRadius:
//                                                                 2.0,
//                                                                 color: Color(0xff000000)
//                                                                     .withOpacity(0.25),
//                                                               ),
//                                                             ],
//                                                           )),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding: EdgeInsets.only(
//                                                     top: 13.h),
//                                                 child: Container(
//                                                   height: 1,
//                                                   decoration: BoxDecoration(
//                                                       color: white,
//                                                       boxShadow: [
//                                                         BoxShadow(
//                                                           offset:
//                                                           Offset(0, 2),
//                                                           color: white,
//                                                           blurRadius: 2.0,
//                                                         ),
//                                                       ]),
//                                                 ),
//                                               ),
//                                             ]),
//                                           ),
//                                           Spacer(),
//                                           Padding(
//                                             padding: EdgeInsets.only(
//                                                 right: ScreenUtil()
//                                                     .setWidth(16)),
//                                             child: Column(
//                                               children: [
//                                                 SvgPicture.asset(
//                                                   "assets/icons/svg/photoshoot.svg",
//                                                   height: ScreenUtil()
//                                                       .setHeight(30),
//                                                   width: ScreenUtil()
//                                                       .setWidth(30),
//                                                   color: orange,
//                                                 ),
//                                                 SizedBox(
//                                                   height: ScreenUtil()
//                                                       .setHeight(8),
//                                                 ),
//                                                 Text(
//                                                     jobList[index]
//                                                         .jobDetails![0]
//                                                         .jobCategory ??
//                                                         'Print',
//                                                     textAlign:
//                                                     TextAlign.center,
//                                                     style: GoogleFonts
//                                                         .nunitoSans(
//                                                       fontWeight:
//                                                       FontWeight.w400,
//                                                       color: white,
//                                                       fontSize: ScreenUtil()
//                                                           .setSp(12),
//                                                       height: 0.16,
//                                                       shadows: <Shadow>[
//                                                         Shadow(
//                                                           offset: Offset(
//                                                               0.0, 2.0),
//                                                           blurRadius: 2.0,
//                                                           color: Color(
//                                                               0xff000000)
//                                                               .withOpacity(
//                                                               0.25),
//                                                         ),
//                                                       ],
//                                                     )),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Text(
//                                           jobList[index].jobLocation!.district!,
//                                           textAlign: TextAlign.center,
//                                           style: GoogleFonts.nunitoSans(
//                                             fontWeight: FontWeight.w700,
//                                             color: white,
//                                             fontSize: ScreenUtil().setSp(14),
//                                             shadows: <Shadow>[
//                                               Shadow(
//                                                 offset: Offset(0.0, 2.0),
//                                                 blurRadius: 2.0,
//                                                 color: Color(0xff000000)
//                                                     .withOpacity(0.25),
//                                               ),
//                                             ],
//                                           )),
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             top: ScreenUtil().setHeight(24),
//                                             left: ScreenUtil().setWidth(6),
//                                             right: ScreenUtil().setWidth(6)),
//                                         child: Container(
//                                           height: 100.h,
//                                           width: MediaQuery.of(context)
//                                               .size
//                                               .width,
//                                           child: ListView.builder(
//                                               primary: false,
//                                               shrinkWrap: true,
//                                               itemCount: 1,
//                                               scrollDirection:
//                                               Axis.horizontal,
//                                               controller: _scroll,
//                                               itemBuilder: (context, i) {
//                                                 return jobList[index]
//                                                     .isSwipe ==
//                                                     true
//                                                     ? Column(
//                                                   children: [
//                                                     Row(
//                                                       children: [
//                                                         Container(
//                                                           width: MediaQuery.of(
//                                                               context)
//                                                               .size
//                                                               .width -
//                                                               79.5.w,
//                                                           child: Text(
//                                                             jobList[index]
//                                                                 .title.toString(),
//                                                             textAlign:
//                                                             TextAlign
//                                                                 .center,
//                                                             maxLines: 2,
//                                                             style: GoogleFonts
//                                                                 .nunitoSans(
//                                                               fontWeight:
//                                                               FontWeight
//                                                                   .w700,
//                                                               color:
//                                                               white,
//                                                               fontSize:
//                                                               ScreenUtil()
//                                                                   .setSp(22),
//                                                               height:
//                                                               1.2,
//                                                               shadows: <
//                                                                   Shadow>[
//                                                                 Shadow(
//                                                                   offset: Offset(
//                                                                       0.0,
//                                                                       2.0),
//                                                                   blurRadius:
//                                                                   2.0,
//                                                                   color:
//                                                                   Color(0xff000000).withOpacity(0.25),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         // Spacer(),
//                                                         InkWell(
//                                                             onTap: () {
//                                                               setState(
//                                                                       () {
//                                                                     jobList[index].isSwipe =
//                                                                     false;
//                                                                   });
//                                                             },
//                                                             child: Icon(
//                                                               Icons
//                                                                   .arrow_forward_ios_rounded,
//                                                               color: white
//                                                                   .withOpacity(
//                                                                   0.8),
//                                                               size: ScreenUtil()
//                                                                   .radius(
//                                                                   15),
//                                                             ))
//                                                       ],
//                                                     ),
//                                                     SizedBox(
//                                                       height:
//                                                       ScreenUtil()
//                                                           .setHeight(
//                                                           20),
//                                                     ),
//                                                     Text(
//                                                       "From " +
//                                                           DateFormat(
//                                                               'dd-MMM-yy')
//                                                               .format(jobList[
//                                                           index]
//                                                               .startDate!) +
//                                                           " till " +
//                                                           DateFormat(
//                                                               'dd-MMM-yy')
//                                                               .format(jobList[
//                                                           index]
//                                                               .endDate!),
//                                                       textAlign:
//                                                       TextAlign
//                                                           .center,
//                                                       style: GoogleFonts
//                                                           .nunitoSans(
//                                                         fontWeight:
//                                                         FontWeight
//                                                             .w600,
//                                                         color: black,
//                                                         fontSize:
//                                                         ScreenUtil()
//                                                             .setSp(
//                                                             12),
//                                                         height: 0.16,
//                                                         shadows: <
//                                                             Shadow>[
//                                                           Shadow(
//                                                             offset:
//                                                             Offset(
//                                                                 0.0,
//                                                                 2.0),
//                                                             blurRadius:
//                                                             2.0,
//                                                             color: Color(
//                                                                 0xff000000)
//                                                                 .withOpacity(
//                                                                 0.25),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 )
//                                                     : Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment
//                                                       .start,
//                                                   mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .start,
//                                                   children: [
//                                                     Row(
//                                                       crossAxisAlignment:
//                                                       CrossAxisAlignment
//                                                           .start,
//                                                       mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .start,
//                                                       children: [
//                                                         InkWell(
//                                                           onTap: () {
//                                                             setState(
//                                                                     () {
//                                                                   jobList[index]
//                                                                       .isSwipe =
//                                                                   true;
//                                                                 });
//                                                           },
//                                                           child:
//                                                           Padding(
//                                                             padding: EdgeInsets.only(
//                                                                 top: ScreenUtil()
//                                                                     .setHeight(7.5)),
//                                                             child: Icon(
//                                                                 Icons
//                                                                     .arrow_back_ios_rounded,
//                                                                 color: white.withOpacity(
//                                                                     0.8),
//                                                                 size:
//                                                                 15),
//                                                           ),
//                                                         ),
//                                                         SizedBox(
//                                                           width: ScreenUtil()
//                                                               .setWidth(
//                                                               10),
//                                                         ),
//                                                         Container(
//                                                           width: MediaQuery.of(
//                                                               context)
//                                                               .size
//                                                               .width -
//                                                               88.w,
//                                                           child: Wrap(
//                                                             children: [
//                                                               Text(
//                                                                 // ReadMoreText(
//                                                                 jobList[index]
//                                                                     .description!,
//                                                                 // "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sapien volutpat massa quis feugiat consequat nisi mauris. Diam massa, sit aliquam amet, libero, auctor. Nulla facilisi lectus amet, magna in a tortor, consectetur eget.",
//                                                                 // trimLines: 4,
//                                                                 // trimMode: TrimMode.Line,
//                                                                 // colorClickableText: white,
//                                                                 style: GoogleFonts
//                                                                     .nunitoSans(
//                                                                   fontWeight:
//                                                                   FontWeight.w400,
//                                                                   color:
//                                                                   white,
//                                                                   fontSize:
//                                                                   ScreenUtil().setSp(14),
//                                                                   height:
//                                                                   1.2,
//                                                                   shadows: <
//                                                                       Shadow>[
//                                                                     Shadow(
//                                                                       offset: Offset(0.0, 2.0),
//                                                                       blurRadius: 2.0,
//                                                                       color: Color(0xff000000).withOpacity(0.25),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     SizedBox(
//                                                         height: ScreenUtil()
//                                                             .setHeight(
//                                                             20)),
//                                                     Padding(
//                                                       padding: EdgeInsets.only(
//                                                           left: ScreenUtil()
//                                                               .setWidth(
//                                                               24)),
//                                                       child: Text(
//                                                         "Deadline: " +
//                                                             DateFormat(
//                                                                 'dd-MMM-yy')
//                                                                 .format(
//                                                                 jobList[index].deadline!),
//                                                         textAlign:
//                                                         TextAlign
//                                                             .left,
//                                                         style: GoogleFonts
//                                                             .nunitoSans(
//                                                           fontWeight:
//                                                           FontWeight
//                                                               .w400,
//                                                           color: white,
//                                                           fontSize:
//                                                           ScreenUtil()
//                                                               .setSp(
//                                                               14),
//                                                           height: 0.16,
//                                                           shadows: <
//                                                               Shadow>[
//                                                             Shadow(
//                                                               offset: Offset(
//                                                                   0.0,
//                                                                   2.0),
//                                                               blurRadius:
//                                                               2.0,
//                                                               color: Color(
//                                                                   0xff000000)
//                                                                   .withOpacity(
//                                                                   0.25),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 );
//                                               }),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             top: ScreenUtil().setHeight(31)),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             jobList[index].savedStatus == true
//                                                 ? InkWell(
//                                                 onTap: () {
//                                                   saveUnsaveJobs(
//                                                       'unsave',
//                                                       jobList[index].sId,
//                                                       index);
//                                                 },
//                                                 child: Icon(
//                                                   Icons.bookmark,
//                                                   color: white,
//                                                   size: 23.r,
//                                                 ))
//                                                 : InkWell(
//                                                 onTap: () {
//                                                   saveUnsaveJobs(
//                                                       'save',
//                                                       jobList[index].sId,
//                                                       index);
//                                                 },
//                                                 child: Icon(
//                                                   Icons.bookmark_border,
//                                                   color: white,
//                                                   size: 23.r,
//                                                 )),
//                                             InkWell(
//                                                 onTap: () {},
//                                                 child: SvgPicture.asset(
//                                                     "assets/icons/svg/share.svg",
//                                                     color: white)),
//                                             InkWell(
//                                               onTap: () {
//                                                 if (jobList[index]
//                                                     .isApplied ==
//                                                     false) {
//                                                   applyJobs(
//                                                       jobList[index].sId,
//                                                       index);
//                                                 }
//                                               },
//                                               child: Container(
//                                                 height: 30.h,
//                                                 width: 90.w,
//                                                 decoration: BoxDecoration(
//                                                   color:
//                                                   white.withOpacity(0.6),
//                                                   borderRadius:
//                                                   BorderRadius.circular(
//                                                       10),
//                                                   border: Border.all(
//                                                       color: orange),
//                                                 ),
//                                                 child: Center(
//                                                   child: Text(
//                                                     jobList[index]
//                                                         .isApplied ==
//                                                         false
//                                                         ? 'Apply'
//                                                         : 'Applied',
//                                                     textAlign:
//                                                     TextAlign.center,
//                                                     style: GoogleFonts
//                                                         .nunitoSans(
//                                                       fontWeight:
//                                                       FontWeight.w600,
//                                                       color: white,
//                                                       fontSize: ScreenUtil()
//                                                           .setSp(12),
//                                                       shadows: <Shadow>[
//                                                         Shadow(
//                                                           offset: Offset(
//                                                               0.0, 2.0),
//                                                           blurRadius: 2.0,
//                                                           color: Color(
//                                                               0xff000000)
//                                                               .withOpacity(
//                                                               0.25),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: EdgeInsets.only(
//                                                   right: ScreenUtil()
//                                                       .setWidth(12)),
//                                               child: Text(
//                                                 timeago.format(
//                                                     jobList[index].createdAt!),
//                                                 textAlign: TextAlign.left,
//                                                 style: GoogleFonts.nunitoSans(
//                                                   fontWeight: FontWeight.w400,
//                                                   color: white,
//                                                   fontSize:
//                                                   ScreenUtil().setSp(10),
//                                                   height: 0.13,
//                                                   shadows: <Shadow>[
//                                                     Shadow(
//                                                       offset:
//                                                       Offset(0.0, 2.0),
//                                                       blurRadius: 2.0,
//                                                       color: Color(0xff000000)
//                                                           .withOpacity(0.25),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(
//                                           height: ScreenUtil().setHeight(8)),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       color: white.withOpacity(0.6),
//                                       borderRadius: BorderRadius.circular(12),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           offset: Offset(0.0, 8.0),
//                                           blurRadius: 30.0,
//                                           color: Color(0xff000000)
//                                               .withOpacity(0.40),
//                                         )
//                                       ]),
//                                   child: Padding(
//                                     padding: EdgeInsets.only(
//                                         left: ScreenUtil().setWidth(16),
//                                         right: ScreenUtil().setWidth(24),
//                                         top: ScreenUtil().setHeight(13),
//                                         bottom: ScreenUtil().setHeight(8)),
//                                     child: Row(
//                                       children: [
//                                         CachedNetworkImage(
//                                           imageUrl:
//                                           '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${jobList[index].createdBy![0].profileImage}',
//                                           imageBuilder:
//                                               (context, imageProvider) =>
//                                               Container(
//                                                 width: 60.h,
//                                                 height: 60.w,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                   BorderRadius.circular(16.r),
//                                                   image: DecorationImage(
//                                                       image: imageProvider,
//                                                       fit: BoxFit.cover),
//                                                 ),
//                                               ),
//                                           errorWidget: (context, url, error) {
//                                             print("ER::${error.toString()}");
//                                             return Icon(Icons.error,
//                                                 color: white);
//                                           },
//                                           fit: BoxFit.cover,
//                                           height: ScreenUtil().setHeight(60),
//                                           width: ScreenUtil().setWidth(60),
//                                         ),
//                                         SizedBox(
//                                           width: ScreenUtil().setWidth(12),
//                                         ),
//                                         Text(
//                                           jobList[index].createdBy![0].name!,
//                                           textAlign: TextAlign.left,
//                                           style: GoogleFonts.nunitoSans(
//                                             fontWeight: FontWeight.w700,
//                                             color: black,
//                                             fontSize: ScreenUtil().setSp(14),
//                                             height: 0.19,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 )
//                     : Expanded(
//                   child:
//                   // isLoading == true ? Expanded(child: Center(child: CircularProgressIndicator(color: white, strokeWidth: 3))) :
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: ScreenUtil().setHeight(20),
//                         left: ScreenUtil().setWidth(12),
//                         right: ScreenUtil().setWidth(12)),
//                     child: ListView.builder(
//                       itemCount: index1 == 0
//                           ? talentList.length
//                           : index1 == 2
//                           ? openJobList.length
//                           : index1 == 3
//                           ? closedJobList.length
//                           : 0,
//                       shrinkWrap: true,
//                       padding: EdgeInsets.zero,
//                       primary: false,
//                       itemBuilder: (BuildContext context, int index) {
//                         for (var item in ageGroup) {
//                           for (var i in item.entries) {
//                             if (index1 == 0) {
//                               if (talentList[index].masterProfile!.ageGroup ==
//                                   i.key) {
//                                 talentList[index].masterProfile!.ageGroup =
//                                     i.value;
//                               }
//                             } else if (index1 == 2) {
//                               if (openJobList[index].ageGroup == i.key) {
//                                 openJobList[index].ageGroup = i.value;
//                               }
//                             } else if (index1 == 3) {
//                               if (closedJobList[index].ageGroup == i.key) {
//                                 closedJobList[index].ageGroup = i.value;
//                               }
//                             }
//                           }
//                         }
//                         return Padding(
//                           padding: EdgeInsets.only(
//                               bottom: ScreenUtil().setHeight(16)),
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: white.withOpacity(0.2),
//                                 borderRadius: BorderRadius.circular(12),
//                                 border: Border.all(
//                                     color: Colors.white.withOpacity(0.2))),
//                             child: Column(
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                       top: ScreenUtil().setHeight(10),
//                                       left: ScreenUtil().setWidth(24)),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           IntrinsicWidth(
//                                             child: Column(children: [
//                                               Padding(
//                                                 padding: EdgeInsets.only(
//                                                     top: 14.5.h, right: 10.w),
//                                                 child: Row(
//                                                   children: [
//                                                     Padding(
//                                                       padding: EdgeInsets.only(
//                                                           top: ScreenUtil()
//                                                               .setHeight(15)),
//                                                       child: Text(
//                                                         index1 == 0
//                                                             ? talentList[index]
//                                                             .profile!
//                                                             .faces![
//                                                         0]
//                                                             .weight !=
//                                                             0
//                                                             ? capitalize(talentList[index]
//                                                             .masterProfile!
//                                                             .gender) +
//                                                             ", " +
//                                                             talentList[index]
//                                                                 .masterProfile!
//                                                                 .ageGroup
//                                                                 .toString()
//                                                             : capitalize(talentList[
//                                                         index]
//                                                             .profile!
//                                                             .crew![0]
//                                                             .experienceLevel)
//                                                             : index1 == 2
//                                                             ? openJobList[index]
//                                                             .jobType ==
//                                                             'faces'
//                                                             ? capitalize(openJobList[index].gender) +
//                                                             ", " +
//                                                             openJobList[index]
//                                                                 .ageGroup
//                                                                 .toString()
//                                                             : capitalize(
//                                                             openJobList[index]
//                                                                 .experienceLevel)
//                                                             : index1 == 3
//                                                             ? closedJobList[index].jobType ==
//                                                             'faces'
//                                                             ? capitalize(closedJobList[index].gender) +
//                                                             ", " +
//                                                             closedJobList[index].ageGroup.toString()
//                                                             : capitalize(closedJobList[index].experienceLevel)
//                                                             : '',
//                                                         textAlign:
//                                                         TextAlign.center,
//                                                         style: GoogleFonts
//                                                             .nunitoSans(
//                                                           fontWeight:
//                                                           index1 == 0
//                                                               ? FontWeight
//                                                               .w400
//                                                               : FontWeight
//                                                               .w700,
//                                                           color: white,
//                                                           fontSize: ScreenUtil()
//                                                               .setSp(
//                                                               index1 == 0
//                                                                   ? 16
//                                                                   : 18),
//                                                           height: 0.22,
//                                                           shadows: <Shadow>[
//                                                             Shadow(
//                                                               offset: Offset(
//                                                                   0.0, 2.0),
//                                                               blurRadius: 2.0,
//                                                               color: Color(
//                                                                   0xff000000)
//                                                                   .withOpacity(
//                                                                   0.25),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     index1 == 0
//                                                         ? Container()
//                                                         : SizedBox(
//                                                       width:
//                                                       ScreenUtil()
//                                                           .setWidth(
//                                                           12),
//                                                     ),
//                                                     index1 == 0
//                                                         ? Container()
//                                                         : Padding(
//                                                       padding: EdgeInsets.only(
//                                                           top: ScreenUtil()
//                                                               .setHeight(
//                                                               15)),
//                                                       child: Text(
//                                                           index1 == 0
//                                                               ? talentList[index].profile!.faces![0].weight !=
//                                                               0
//                                                               ? talentList[index].profile!.faces![0].height!.foot.toString() +
//                                                               '’' +
//                                                               talentList[index].profile!.faces![0].height!.inch.toString() +
//                                                               '”'
//                                                               : ''
//                                                               : index1 == 2
//                                                               ? openJobList[index].jobType == 'faces'
//                                                               ? openJobList[index1].height!.foot.toString() + '’' + openJobList[index1].height!.inch.toString() + '”'
//                                                               : ''
//                                                               : index1 == 3
//                                                               ? closedJobList[index].jobType == 'faces'
//                                                               ? closedJobList[index1].height!.foot.toString() + '’' + closedJobList[index1].height!.inch.toString() + '”'
//                                                               : ''
//                                                               : '',
//                                                           textAlign: TextAlign.center,
//                                                           style: GoogleFonts.nunitoSans(
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .w400,
//                                                             color:
//                                                             black,
//                                                             fontSize: ScreenUtil()
//                                                                 .setSp(
//                                                                 16),
//                                                             height:
//                                                             0.22,
//                                                             shadows: <
//                                                                 Shadow>[
//                                                               Shadow(
//                                                                 offset: Offset(
//                                                                     0.0,
//                                                                     2.0),
//                                                                 blurRadius:
//                                                                 2.0,
//                                                                 color: Color(0xff000000)
//                                                                     .withOpacity(0.25),
//                                                               ),
//                                                             ],
//                                                           )),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding: EdgeInsets.only(
//                                                     top: 13.h),
//                                                 child: Container(
//                                                   height: 1,
//                                                   decoration: BoxDecoration(
//                                                       color: white,
//                                                       boxShadow: [
//                                                         BoxShadow(
//                                                           offset:
//                                                           Offset(0, 2),
//                                                           color: white,
//                                                           blurRadius: 2.0,
//                                                         ),
//                                                       ]),
//                                                 ),
//                                               ),
//                                             ]),
//                                           ),
//                                           Spacer(),
//                                           IntrinsicWidth(
//                                             child: Padding(
//                                               padding: EdgeInsets.only(
//                                                   right: 10.w),
//                                               child: Column(
//                                                 children: [
//                                                   Container(
//                                                     height: 50.h,
//                                                     width: index1 == 0
//                                                         ? talentList[index]
//                                                         .profile!
//                                                         .faces![0]
//                                                         .weight !=
//                                                         0
//                                                         ? talentList[index]
//                                                         .profile!
//                                                         .faces![
//                                                     0]
//                                                         .interestCat!
//                                                         .length ==
//                                                         0
//                                                         ? 0.w
//                                                         : talentList[index]
//                                                         .profile!
//                                                         .faces![
//                                                     0]
//                                                         .interestCat!
//                                                         .length ==
//                                                         1
//                                                         ? 70.w
//                                                         : talentList[index].profile!.faces![0].interestCat!.length ==
//                                                         2
//                                                         ? 100
//                                                         .w
//                                                         : 150
//                                                         .w
//                                                         : talentList[index]
//                                                         .profile!
//                                                         .crew![
//                                                     0]
//                                                         .interestCat!
//                                                         .length ==
//                                                         0
//                                                         ? 0.w
//                                                         : talentList[index]
//                                                         .profile!
//                                                         .crew![
//                                                     0]
//                                                         .interestCat!
//                                                         .length ==
//                                                         1
//                                                         ? 70.w
//                                                         : talentList[index].profile!.crew![0].interestCat!.length ==
//                                                         2
//                                                         ? 100
//                                                         .w
//                                                         : 150
//                                                         .w
//                                                         : 150.w,
//                                                     child: Align(
//                                                       alignment:
//                                                       Alignment.topRight,
//                                                       child: ListView.builder(
//                                                           itemCount: index1 ==
//                                                               0
//                                                               ? talentList[index]
//                                                               .profile!
//                                                               .faces![
//                                                           0]
//                                                               .weight !=
//                                                               0
//                                                               ? talentList[
//                                                           index]
//                                                               .profile!
//                                                               .faces![
//                                                           0]
//                                                               .interestCat!
//                                                               .length
//                                                               : talentList[
//                                                           index]
//                                                               .profile!
//                                                               .crew![0]
//                                                               .interestCat!
//                                                               .length
//                                                               : index1 == 2
//                                                               ? openJobList[
//                                                           index]
//                                                               .jobDetails!
//                                                               .length
//                                                               : index1 ==
//                                                               3
//                                                               ? closedJobList[index]
//                                                               .jobDetails!
//                                                               .length
//                                                               : 0,
//                                                           shrinkWrap: true,
//                                                           padding:
//                                                           EdgeInsets.zero,
//                                                           primary: false,
//                                                           scrollDirection:
//                                                           Axis.horizontal,
//                                                           itemBuilder:
//                                                               (BuildContext
//                                                           context,
//                                                               int i) {
//                                                             return Padding(
//                                                               padding: EdgeInsets.only(
//                                                                   right: ScreenUtil()
//                                                                       .setWidth(
//                                                                       12),
//                                                                   top: ScreenUtil()
//                                                                       .setWidth(
//                                                                       10)),
//                                                               child: Column(
//                                                                 children: [
//                                                                   SvgPicture
//                                                                       .asset(
//                                                                     "assets/icons/svg/photoshoot.svg",
//                                                                     height: index1 ==
//                                                                         0
//                                                                         ? ScreenUtil()
//                                                                         .setHeight(16)
//                                                                         : 25.h,
//                                                                     width: index1 ==
//                                                                         0
//                                                                         ? ScreenUtil()
//                                                                         .setWidth(16)
//                                                                         : 24.w,
//                                                                     color:
//                                                                     orange,
//                                                                   ),
//                                                                   SizedBox(
//                                                                     height: ScreenUtil()
//                                                                         .setHeight(
//                                                                         10),
//                                                                   ),
//                                                                   Text(
//                                                                       index1 ==
//                                                                           0
//                                                                           ? talentList[index].profile!.faces![0].weight != 0
//                                                                           ? talentList[index].profile!.faces![0].interestCat![i].jobCategory ?? "Print Ad"
//                                                                           : talentList[index].profile!.crew![0].interestCat![i].jobCategory ?? "Print Ad"
//                                                                           : index1 == 2
//                                                                           ? openJobList[index].jobDetails![i].jobCategory ?? "Print Ad"
//                                                                           : index1 == 3
//                                                                           ? closedJobList[index].jobDetails![i].jobCategory ?? "Print Ad"
//                                                                           : '',
//                                                                       textAlign: TextAlign.center,
//                                                                       style: GoogleFonts.nunitoSans(
//                                                                         fontWeight:
//                                                                         FontWeight.w400,
//                                                                         color:
//                                                                         white,
//                                                                         fontSize:
//                                                                         ScreenUtil().setSp(12),
//                                                                         height:
//                                                                         0.16,
//                                                                         shadows: <
//                                                                             Shadow>[
//                                                                           Shadow(
//                                                                             offset: Offset(0.0, 2.0),
//                                                                             blurRadius: 2.0,
//                                                                             color: Color(0xff000000).withOpacity(0.25),
//                                                                           ),
//                                                                         ],
//                                                                       )),
//                                                                 ],
//                                                               ),
//                                                             );
//                                                           }),
//                                                     ),
//                                                   ),
//                                                   index1 != 0
//                                                       ? Container()
//                                                       : Container(
//                                                     height: 1,
//                                                     decoration:
//                                                     BoxDecoration(
//                                                         color:
//                                                         orange,
//                                                         boxShadow: [
//                                                           BoxShadow(
//                                                             offset:
//                                                             Offset(
//                                                                 0,
//                                                                 2),
//                                                             color:
//                                                             orange,
//                                                             blurRadius:
//                                                             2.0,
//                                                           ),
//                                                         ]),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Padding(
//                                           padding: EdgeInsets.only(
//                                               top: ScreenUtil().setHeight(20),
//                                               right:
//                                               ScreenUtil().setWidth(12)),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment
//                                                 .spaceBetween,
//                                             children: [
//                                               Text(
//                                                   index1 == 0
//                                                       ? talentList[index]
//                                                       .profile!
//                                                       .faces![0]
//                                                       .weight !=
//                                                       0
//                                                       ? talentList[index]
//                                                       .profile!
//                                                       .faces![
//                                                   0]
//                                                       .interestedLoc!
//                                                       .length ==
//                                                       0
//                                                       ? ""
//                                                       : capitalize(talentList[index]
//                                                       .profile!
//                                                       .faces![
//                                                   0]
//                                                       .interestedLoc![
//                                                   0]
//                                                       .district)
//                                                       : talentList[index]
//                                                       .profile!
//                                                       .crew![0]
//                                                       .interestedLoc!
//                                                       .length ==
//                                                       0
//                                                       ? ""
//                                                       : capitalize(talentList[index]
//                                                       .profile!
//                                                       .crew![0]
//                                                       .interestedLoc![
//                                                   0]
//                                                       .district)
//                                                       : index1 == 2
//                                                       ? capitalize(openJobList[index]
//                                                       .jobLocation!
//                                                       .district)
//                                                       : index1 == 3
//                                                       ? capitalize(closedJobList[index].jobLocation!.district ?? '')
//                                                       : '',
//                                                   textAlign: TextAlign.center,
//                                                   style: GoogleFonts.nunitoSans(
//                                                     fontWeight:
//                                                     FontWeight.w700,
//                                                     color: white,
//                                                     fontSize: ScreenUtil()
//                                                         .setSp(14),
//                                                     height: 0.19,
//                                                     shadows: <Shadow>[
//                                                       Shadow(
//                                                         offset:
//                                                         Offset(0.0, 2.0),
//                                                         blurRadius: 2.0,
//                                                         color:
//                                                         Color(0xff000000)
//                                                             .withOpacity(
//                                                             0.25),
//                                                       ),
//                                                     ],
//                                                   )),
//                                               index1 == 0
//                                                   ? Text('Available for',
//                                                   textAlign:
//                                                   TextAlign.center,
//                                                   style: GoogleFonts
//                                                       .nunitoSans(
//                                                     fontWeight:
//                                                     FontWeight.w400,
//                                                     color: white,
//                                                     fontSize: ScreenUtil()
//                                                         .setSp(12),
//                                                     height: 0.19,
//                                                     shadows: <Shadow>[
//                                                       Shadow(
//                                                         offset: Offset(
//                                                             0.0, 2.0),
//                                                         blurRadius: 2.0,
//                                                         color: Color(
//                                                             0xff000000)
//                                                             .withOpacity(
//                                                             0.25),
//                                                       ),
//                                                     ],
//                                                   ))
//                                                   : Container(),
//                                             ],
//                                           )),
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             top: ScreenUtil().setHeight(24),
//                                             right: ScreenUtil().setWidth(6)),
//                                         child: index1 == 0
//                                             ? Container(
//                                           height: 110.h,
//                                           child: ListView.builder(
//                                               primary: false,
//                                               shrinkWrap: true,
//                                               itemCount: 1,
//                                               scrollDirection:
//                                               Axis.horizontal,
//                                               controller: _scroll1,
//                                               itemBuilder:
//                                                   (context, imgIndex) {
//                                                 return talentList[index]
//                                                     .isSwipe ==
//                                                     true
//                                                     ? Container(
//                                                     height: 110.h,
//                                                     // width: talentList[index].posts.length != 0 ? MediaQuery.of(context).size.width * 2.w : 0,
//                                                     child: Row(
//                                                       children: [
//                                                         talentList[index].profile!.greetVideo ==
//                                                             '' ||
//                                                             talentList[index].profile!.greetVideo ==
//                                                                 null
//                                                             ? Container()
//                                                             : Padding(
//                                                           padding:
//                                                           EdgeInsets.only(right: 10.w),
//                                                           child:
//                                                           Container(
//                                                             height: ScreenUtil().setHeight(110),
//                                                             width: ScreenUtil().setWidth(110),
//                                                             child: Stack(
//                                                               children: [
//                                                                 Image.asset("assets/icons/rect.png"),
//                                                                 Positioned(
//                                                                   top: 9.h,
//                                                                   left: 7.w,
//                                                                   child: Container(
//                                                                     height: 91.h,
//                                                                     width: 91.w,
//                                                                     child: _controller[index].value.isInitialized ? VideoPlayer(_controller[index]) : Container(),
//                                                                   ),
//                                                                 ),
//                                                                 InkWell(
//                                                                   onTap: () {
//                                                                     setState(() {
//                                                                       showGeneralDialog(
//                                                                           context: context,
//                                                                           pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
//                                                                             return TalentFeedPost(index: index, index1: 0, talentList: talentList, controller: _controller);
//                                                                           });
//                                                                     });
//                                                                   },
//                                                                   child: Center(
//                                                                     child: Container(
//                                                                       height: 40.h,
//                                                                       width: 40.w,
//                                                                       decoration: BoxDecoration(color: Colors.transparent, shape: BoxShape.circle, border: Border.all(color: white.withOpacity(0.5), width: 2.w)),
//                                                                       child: Icon(Icons.play_arrow, color: white.withOpacity(0.5)),
//                                                                     ),
//                                                                   ),
//                                                                 )
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         ListView.builder(
//                                                             primary: false,
//                                                             shrinkWrap: true,
//                                                             itemCount: talentList[index].posts!.length,
//                                                             scrollDirection: Axis.horizontal,
//                                                             physics: ClampingScrollPhysics(),
//                                                             itemBuilder: (context, i) {
//                                                               return InkWell(
//                                                                 onTap:
//                                                                     () {
//                                                                   setState(() {
//                                                                     showGeneralDialog(
//                                                                         context: context,
//                                                                         pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
//                                                                           return TalentFeedPost(index: index, index1: i, talentList: talentList, controller: _controller);
//                                                                         });
//                                                                   });
//                                                                 },
//                                                                 child: talentList[index].posts!.length != 0
//                                                                     ? Padding(
//                                                                   padding: EdgeInsets.only(right: 10.w),
//                                                                   child: Container(
//                                                                     height: ScreenUtil().setHeight(116),
//                                                                     width: ScreenUtil().setWidth(100),
//                                                                     child: CachedNetworkImage(
//                                                                       imageUrl: talentList[index].posts![i].closeUp != null
//                                                                           ? '${ApiProvider.famelinks}/${talentList[index].posts![i].closeUp}'
//                                                                           : talentList[index].posts![i].medium != null
//                                                                           ? '${ApiProvider.famelinks}/${talentList[index].posts![i].medium}'
//                                                                           : talentList[index].posts![i].long != null
//                                                                           ? '${ApiProvider.famelinks}/${talentList[index].posts![i].long}'
//                                                                           : talentList[index].posts![i].pose1 != null
//                                                                           ? '${ApiProvider.famelinks}/${talentList[index].posts![i].pose1}'
//                                                                           : talentList[index].posts![i].pose2 != null
//                                                                           ? '${ApiProvider.famelinks}/${talentList[index].posts![i].pose2}'
//                                                                           : talentList[index].posts![i].additional != null
//                                                                           ? '${ApiProvider.famelinks}/${talentList[index].posts![i].additional}'
//                                                                           : '${ApiProvider.famelinks}/${talentList[index].posts![i].video}',
//                                                                       errorWidget: (context, url, error) {
//                                                                         print("ER::${error.toString()}");
//                                                                         return Icon(Icons.error, color: white);
//                                                                       },
//                                                                       fit: BoxFit.fill,
//                                                                       height: ScreenUtil().setHeight(116),
//                                                                       width: ScreenUtil().setWidth(100),
//                                                                     ),
//                                                                   ),
//                                                                 )
//                                                                     : Container(),
//                                                               );
//                                                             }),
//                                                       ],
//                                                     ))
//                                                     : Container(
//                                                   // width: MediaQuery.of(context).size.width,
//                                                   child: Padding(
//                                                     padding: EdgeInsets
//                                                         .only(
//                                                         top: 10
//                                                             .h),
//                                                     child: Row(
//                                                       children: [
//                                                         Column(
//                                                             crossAxisAlignment:
//                                                             CrossAxisAlignment.start,
//                                                             children: [
//                                                               Row(children: [
//                                                                 Text(
//                                                                   talentList[index].profile!.faces![0].weight != 0 ? 'Height: ' : 'Work Experience: ',
//                                                                   textAlign: TextAlign.center,
//                                                                   style: GoogleFonts.nunitoSans(
//                                                                     fontWeight: FontWeight.w500,
//                                                                     color: black,
//                                                                     fontSize: ScreenUtil().setSp(14),
//                                                                     height: 0.22,
//                                                                     shadows: <Shadow>[
//                                                                       Shadow(
//                                                                         offset: Offset(0.0, 2.0),
//                                                                         blurRadius: 2.0,
//                                                                         color: Color(0xff000000).withOpacity(0.25),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                                 Container(
//                                                                   width: MediaQuery.of(context).size.width * 0.14.w,
//                                                                   child: Text(
//                                                                     talentList[index].profile!.faces![0].weight != 0 ? talentList[index].profile!.faces![0].height!.foot.toString() + '’' + talentList[index].profile!.faces![0].height!.inch.toString() + '”' : talentList[index].profile!.crew![0].workExperience!,
//                                                                     textAlign: TextAlign.center,
//                                                                     maxLines: talentList[index].profile!.faces![0].weight != 0 ? 1 : 3,
//                                                                     overflow: TextOverflow.ellipsis,
//                                                                     style: GoogleFonts.nunitoSans(
//                                                                       fontWeight: FontWeight.w700,
//                                                                       color: black,
//                                                                       fontSize: ScreenUtil().setSp(14),
//                                                                       height: 0.22,
//                                                                       shadows: <Shadow>[
//                                                                         Shadow(
//                                                                           offset: Offset(0.0, 2.0),
//                                                                           blurRadius: 2.0,
//                                                                           color: Color(0xff000000).withOpacity(0.25),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                                 talentList[index].profile!.faces![0].weight != 0 ? SizedBox(width: 5.w) : Container(),
//                                                                 talentList[index].profile!.faces![0].weight != 0
//                                                                     ? Text(
//                                                                   'Weight: ',
//                                                                   textAlign: TextAlign.center,
//                                                                   style: GoogleFonts.nunitoSans(
//                                                                     fontWeight: FontWeight.w500,
//                                                                     color: black,
//                                                                     fontSize: ScreenUtil().setSp(14),
//                                                                     height: 0.22,
//                                                                     shadows: <Shadow>[
//                                                                       Shadow(
//                                                                         offset: Offset(0.0, 2.0),
//                                                                         blurRadius: 2.0,
//                                                                         color: Color(0xff000000).withOpacity(0.25),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 )
//                                                                     : Container(),
//                                                                 talentList[index].profile!.faces![0].weight != 0
//                                                                     ? Text(
//                                                                   talentList[index].profile!.faces![0].weight.toString() + "kg",
//                                                                   textAlign: TextAlign.center,
//                                                                   style: GoogleFonts.nunitoSans(
//                                                                     fontWeight: FontWeight.w700,
//                                                                     color: black,
//                                                                     fontSize: ScreenUtil().setSp(14),
//                                                                     height: 0.22,
//                                                                     shadows: <Shadow>[
//                                                                       Shadow(
//                                                                         offset: Offset(0.0, 2.0),
//                                                                         blurRadius: 2.0,
//                                                                         color: Color(0xff000000).withOpacity(0.25),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 )
//                                                                     : Container(),
//                                                               ]),
//                                                               talentList[index].profile!.faces![0].weight != 0
//                                                                   ? SizedBox(height: 20.h)
//                                                                   : Container(),
//                                                               talentList[index].profile!.faces![0].weight != 0
//                                                                   ? Row(children: [
//                                                                 Text(
//                                                                   'Vitals: ',
//                                                                   textAlign: TextAlign.center,
//                                                                   style: GoogleFonts.nunitoSans(
//                                                                     fontWeight: FontWeight.w500,
//                                                                     color: black,
//                                                                     fontSize: ScreenUtil().setSp(14),
//                                                                     height: 0.22,
//                                                                     shadows: <Shadow>[
//                                                                       Shadow(
//                                                                         offset: Offset(0.0, 2.0),
//                                                                         blurRadius: 2.0,
//                                                                         color: Color(0xff000000).withOpacity(0.25),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                                 Text(
//                                                                   'B ${talentList[index].profile!.faces![0].bust.toString()}, W ${talentList[index].profile!.faces![0].waist.toString()}, H ${talentList[index].profile!.faces![0].hip.toString()}',
//                                                                   textAlign: TextAlign.center,
//                                                                   style: GoogleFonts.nunitoSans(
//                                                                     fontWeight: FontWeight.w700,
//                                                                     color: black,
//                                                                     fontSize: ScreenUtil().setSp(14),
//                                                                     height: 0.22,
//                                                                     shadows: <Shadow>[
//                                                                       Shadow(
//                                                                         offset: Offset(0.0, 2.0),
//                                                                         blurRadius: 2.0,
//                                                                         color: Color(0xff000000).withOpacity(0.25),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ])
//                                                                   : Container(),
//                                                               SizedBox(height: 20.h),
//                                                               Row(children: [
//                                                                 Text(
//                                                                   talentList[index].profile!.faces![0].weight != 0 ? 'Eye Color: ' : 'Achievements: ',
//                                                                   textAlign: TextAlign.center,
//                                                                   style: GoogleFonts.nunitoSans(
//                                                                     fontWeight: FontWeight.w500,
//                                                                     color: black,
//                                                                     fontSize: ScreenUtil().setSp(14),
//                                                                     height: 0.22,
//                                                                     shadows: <Shadow>[
//                                                                       Shadow(
//                                                                         offset: Offset(0.0, 2.0),
//                                                                         blurRadius: 2.0,
//                                                                         color: Color(0xff000000).withOpacity(0.25),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                                 Container(
//                                                                   width: MediaQuery.of(context).size.width * 0.13.w,
//                                                                   child: Text(
//                                                                     talentList[index].profile!.faces![0].weight != 0 ? talentList[index].profile!.faces![0].eyeColor.toString() : talentList[index].profile!.crew![0].achievements!,
//                                                                     textAlign: TextAlign.center,
//                                                                     maxLines: talentList[index].profile!.faces![0].weight != 0 ? 1 : 3,
//                                                                     overflow: TextOverflow.ellipsis,
//                                                                     style: GoogleFonts.nunitoSans(
//                                                                       fontWeight: FontWeight.w700,
//                                                                       color: black,
//                                                                       fontSize: ScreenUtil().setSp(14),
//                                                                       height: 0.22,
//                                                                       shadows: <Shadow>[
//                                                                         Shadow(
//                                                                           offset: Offset(0.0, 2.0),
//                                                                           blurRadius: 2.0,
//                                                                           color: Color(0xff000000).withOpacity(0.25),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ]),
//                                                               talentList[index].profile!.faces![0].weight != 0
//                                                                   ? SizedBox(height: 20.h)
//                                                                   : Container(),
//                                                               talentList[index].profile!.faces![0].weight != 0
//                                                                   ? Row(children: [
//                                                                 Text(
//                                                                   'Complexion: ',
//                                                                   textAlign: TextAlign.center,
//                                                                   style: GoogleFonts.nunitoSans(
//                                                                     fontWeight: FontWeight.w500,
//                                                                     color: black,
//                                                                     fontSize: ScreenUtil().setSp(14),
//                                                                     height: 0.22,
//                                                                     shadows: <Shadow>[
//                                                                       Shadow(
//                                                                         offset: Offset(0.0, 2.0),
//                                                                         blurRadius: 2.0,
//                                                                         color: Color(0xff000000).withOpacity(0.25),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                                 Text(
//                                                                   talentList[index].profile!.faces![0].complexion!,
//                                                                   textAlign: TextAlign.center,
//                                                                   style: GoogleFonts.nunitoSans(
//                                                                     fontWeight: FontWeight.w700,
//                                                                     color: black,
//                                                                     fontSize: ScreenUtil().setSp(14),
//                                                                     height: 0.22,
//                                                                     shadows: <Shadow>[
//                                                                       Shadow(
//                                                                         offset: Offset(0.0, 2.0),
//                                                                         blurRadius: 2.0,
//                                                                         color: Color(0xff000000).withOpacity(0.25),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ])
//                                                                   : Container(),
//                                                             ]),
//                                                         SizedBox(
//                                                             width:
//                                                             15.w),
//                                                         Column(
//                                                           children: [
//                                                             Text(
//                                                               'Interested Locations:',
//                                                               textAlign:
//                                                               TextAlign.center,
//                                                               style:
//                                                               GoogleFonts.nunitoSans(
//                                                                 fontWeight: FontWeight.w700,
//                                                                 color: white,
//                                                                 fontSize: ScreenUtil().setSp(14),
//                                                                 height: 0.22,
//                                                                 shadows: <Shadow>[
//                                                                   Shadow(
//                                                                     offset: Offset(0.0, 2.0),
//                                                                     blurRadius: 2.0,
//                                                                     color: Color(0xff000000).withOpacity(0.25),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                             Container(
//                                                               height:
//                                                               95.h,
//                                                               width:
//                                                               130.w,
//                                                               child:
//                                                               Wrap(
//                                                                 children: [
//                                                                   ListView.builder(
//                                                                       shrinkWrap: true,
//                                                                       primary: false,
//                                                                       padding: EdgeInsets.zero,
//                                                                       itemCount: talentList[index].profile!.faces![0].weight != 0 ? talentList[index].profile!.faces![0].interestedLoc!.length : talentList[index].profile!.crew![0].interestedLoc!.length,
//                                                                       itemBuilder: (context, i4) {
//                                                                         return Padding(
//                                                                           padding: const EdgeInsets.only(top: 8.0),
//                                                                           child: Row(
//                                                                             mainAxisAlignment: MainAxisAlignment.start,
//                                                                             children: [
//                                                                               Container(height: 3.h, width: 3.h, color: white),
//                                                                               SizedBox(width: 8),
//                                                                               Text(
//                                                                                 talentList[index].profile!.faces![0].weight != 0 ? capitalize(talentList[index].profile!.faces![0].interestedLoc![i4].district) : capitalize(talentList[index].profile!.crew![0].interestedLoc![i4].district),
//                                                                                 textAlign: TextAlign.center,
//                                                                                 style: GoogleFonts.nunitoSans(
//                                                                                   fontWeight: FontWeight.w700,
//                                                                                   color: white,
//                                                                                   fontSize: ScreenUtil().setSp(14),
//                                                                                   height: 1,
//                                                                                   shadows: <Shadow>[
//                                                                                     Shadow(
//                                                                                       offset: Offset(0.0, 2.0),
//                                                                                       blurRadius: 2.0,
//                                                                                       color: Color(0xff000000).withOpacity(0.25),
//                                                                                     ),
//                                                                                   ],
//                                                                                 ),
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                         );
//                                                                       }),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 );
//                                               }),
//                                         )
//                                             : Container(
//                                           height: 100.h,
//                                           width: MediaQuery.of(context)
//                                               .size
//                                               .width,
//                                           child: ListView.builder(
//                                               primary: false,
//                                               shrinkWrap: true,
//                                               itemCount: 1,
//                                               scrollDirection:
//                                               Axis.horizontal,
//                                               controller: _scroll,
//                                               itemBuilder:
//                                                   (context, i1) {
//                                                 return index1 == 3
//                                                     ? closedJobList[index]
//                                                     .isSwipe ==
//                                                     true
//                                                     ? Padding(
//                                                   padding: const EdgeInsets
//                                                       .only(
//                                                       right:
//                                                       8.0),
//                                                   child:
//                                                   Column(
//                                                     children: [
//                                                       Row(
//                                                         children: [
//                                                           Container(
//                                                             width: MediaQuery.of(context).size.width - 80,
//                                                             child: Text(
//                                                               index1 == 2 ? capitalize(openJobList[index].title) : capitalize(closedJobList[index].title),
//                                                               textAlign: TextAlign.center,
//                                                               maxLines: 2,
//                                                               style: GoogleFonts.nunitoSans(
//                                                                 fontWeight: FontWeight.w700,
//                                                                 color: white,
//                                                                 fontSize: ScreenUtil().setSp(22),
//                                                                 height: 1.2,
//                                                                 shadows: <Shadow>[
//                                                                   Shadow(
//                                                                     offset: Offset(0.0, 2.0),
//                                                                     blurRadius: 2.0,
//                                                                     color: Color(0xff000000).withOpacity(0.25),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           // Spacer(),
//                                                           InkWell(
//                                                               onTap: () {
//                                                                 setState(() {
//                                                                   closedJobList[index].isSwipe = false;
//                                                                 });
//                                                               },
//                                                               child: Icon(
//                                                                 Icons.arrow_forward_ios_rounded,
//                                                                 color: white.withOpacity(0.8),
//                                                                 size: ScreenUtil().radius(15),
//                                                               ))
//                                                         ],
//                                                       ),
//                                                       SizedBox(
//                                                         height:
//                                                         ScreenUtil().setHeight(20),
//                                                       ),
//                                                       Text(
//                                                         index1 == 2
//                                                             ? "From " + DateFormat('dd-MMM-yy').format(openJobList[index].startDate!) + " till " + DateFormat('dd-MMM-yy').format(openJobList[index].endDate!)
//                                                             : "From " + DateFormat('dd-MMM-yy').format(closedJobList[index].startDate!) + " till " + DateFormat('dd-MMM-yy').format(closedJobList[index].endDate!),
//                                                         textAlign:
//                                                         TextAlign.center,
//                                                         style:
//                                                         GoogleFonts.nunitoSans(
//                                                           fontWeight:
//                                                           FontWeight.w600,
//                                                           color:
//                                                           black,
//                                                           fontSize:
//                                                           ScreenUtil().setSp(12),
//                                                           height:
//                                                           0.16,
//                                                           shadows: <Shadow>[
//                                                             Shadow(
//                                                               offset: Offset(0.0, 2.0),
//                                                               blurRadius: 2.0,
//                                                               color: Color(0xff000000).withOpacity(0.25),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 )
//                                                     : Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment
//                                                       .start,
//                                                   children: [
//                                                     Row(
//                                                       children: [
//                                                         InkWell(
//                                                           onTap:
//                                                               () {
//                                                             setState(() {
//                                                               closedJobList[index].isSwipe = true;
//                                                             });
//                                                           },
//                                                           child:
//                                                           Padding(
//                                                             padding: EdgeInsets.only(top: ScreenUtil().setHeight(7)),
//                                                             child: Icon(Icons.arrow_back_ios_rounded, color: white.withOpacity(0.8), size: 15),
//                                                           ),
//                                                         ),
//                                                         SizedBox(
//                                                           width:
//                                                           ScreenUtil().setWidth(10),
//                                                         ),
//                                                         Container(
//                                                           width:
//                                                           MediaQuery.of(context).size.width - 88,
//                                                           child:
//                                                           Text(
//                                                             index1 == 2 ? openJobList[index].description.toString() : closedJobList[index].description.toString(),
//                                                             // trimLines: 4,
//                                                             // trimMode: TrimMode.Line,
//                                                             // colorClickableText: white,
//                                                             maxLines: 4,
//                                                             overflow: TextOverflow.ellipsis,
//                                                             style: GoogleFonts.nunitoSans(
//                                                               fontWeight: FontWeight.w400,
//                                                               color: white,
//                                                               fontSize: ScreenUtil().setSp(14),
//                                                               height: 1.2,
//                                                               shadows: <Shadow>[
//                                                                 Shadow(
//                                                                   offset: Offset(0.0, 2.0),
//                                                                   blurRadius: 2.0,
//                                                                   color: Color(0xff000000).withOpacity(0.25),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     SizedBox(
//                                                         height:
//                                                         ScreenUtil().setHeight(20)),
//                                                     Padding(
//                                                       padding:
//                                                       EdgeInsets.only(left: ScreenUtil().setWidth(24)),
//                                                       child:
//                                                       Row(
//                                                         children: [
//                                                           Text(
//                                                             index1 == 2 ? "Deadline: " + DateFormat('dd-MMM-yy').format(openJobList[index].deadline!) : "Compleated On: " + DateFormat('dd-MMM-yy').format(closedJobList[index].deadline!),
//                                                             textAlign: TextAlign.left,
//                                                             style: GoogleFonts.nunitoSans(
//                                                               fontWeight: FontWeight.w400,
//                                                               color: white,
//                                                               fontSize: ScreenUtil().setSp(14),
//                                                               height: 0.16,
//                                                               shadows: <Shadow>[
//                                                                 Shadow(
//                                                                   offset: Offset(0.0, 2.0),
//                                                                   blurRadius: 2.0,
//                                                                   color: Color(0xff000000).withOpacity(0.25),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                           index1 == 2
//                                                               ? InkWell(
//                                                             onTap: () {
//                                                               setState(() {
//                                                                 closeOpenJob(true, openJobList[index].sId);
//                                                               });
//                                                             },
//                                                             child: Padding(
//                                                               padding: const EdgeInsets.only(left: 30.0),
//                                                               child: Text(
//                                                                 'Close',
//                                                                 textAlign: TextAlign.left,
//                                                                 style: GoogleFonts.nunitoSans(
//                                                                   fontWeight: FontWeight.w700,
//                                                                   color: white,
//                                                                   fontSize: ScreenUtil().setSp(14),
//                                                                   height: 0.16,
//                                                                   shadows: <Shadow>[
//                                                                     Shadow(
//                                                                       offset: Offset(0.0, 2.0),
//                                                                       blurRadius: 2.0,
//                                                                       color: Color(0xff000000).withOpacity(0.25),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           )
//                                                               : Container(),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 )
//                                                     : openJobList[index]
//                                                     .isSwipe ==
//                                                     true
//                                                     ? Padding(
//                                                   padding: const EdgeInsets
//                                                       .only(
//                                                       right:
//                                                       8.0),
//                                                   child:
//                                                   Column(
//                                                     children: [
//                                                       Row(
//                                                         children: [
//                                                           Container(
//                                                             width: MediaQuery.of(context).size.width - 80,
//                                                             child: Text(
//                                                               index1 == 2 ? capitalize(openJobList[index].title) : capitalize(closedJobList[index].title),
//                                                               textAlign: TextAlign.center,
//                                                               maxLines: 2,
//                                                               style: GoogleFonts.nunitoSans(
//                                                                 fontWeight: FontWeight.w700,
//                                                                 color: white,
//                                                                 fontSize: ScreenUtil().setSp(22),
//                                                                 height: 1.2,
//                                                                 shadows: <Shadow>[
//                                                                   Shadow(
//                                                                     offset: Offset(0.0, 2.0),
//                                                                     blurRadius: 2.0,
//                                                                     color: Color(0xff000000).withOpacity(0.25),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           // Spacer(),
//                                                           InkWell(
//                                                               onTap: () {
//                                                                 setState(() {
//                                                                   openJobList[index].isSwipe = false;
//                                                                 });
//                                                               },
//                                                               child: Icon(
//                                                                 Icons.arrow_forward_ios_rounded,
//                                                                 color: white.withOpacity(0.8),
//                                                                 size: ScreenUtil().radius(15),
//                                                               ))
//                                                         ],
//                                                       ),
//                                                       SizedBox(
//                                                         height:
//                                                         ScreenUtil().setHeight(20),
//                                                       ),
//                                                       Text(
//                                                         index1 == 2
//                                                             ? "From " + DateFormat('dd-MMM-yy').format(openJobList[index].startDate!) + " till " + DateFormat('dd-MMM-yy').format(openJobList[index].endDate!)
//                                                             : "From " + DateFormat('dd-MMM-yy').format(closedJobList[index].startDate!) + " till " + DateFormat('dd-MMM-yy').format(closedJobList[index].endDate!),
//                                                         textAlign:
//                                                         TextAlign.center,
//                                                         style:
//                                                         GoogleFonts.nunitoSans(
//                                                           fontWeight:
//                                                           FontWeight.w600,
//                                                           color:
//                                                           black,
//                                                           fontSize:
//                                                           ScreenUtil().setSp(12),
//                                                           height:
//                                                           0.16,
//                                                           shadows: <Shadow>[
//                                                             Shadow(
//                                                               offset: Offset(0.0, 2.0),
//                                                               blurRadius: 2.0,
//                                                               color: Color(0xff000000).withOpacity(0.25),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 )
//                                                     : Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment
//                                                       .start,
//                                                   children: [
//                                                     Row(
//                                                       children: [
//                                                         InkWell(
//                                                           onTap:
//                                                               () {
//                                                             setState(() {
//                                                               openJobList[index].isSwipe = true;
//                                                             });
//                                                           },
//                                                           child:
//                                                           Padding(
//                                                             padding: EdgeInsets.only(top: ScreenUtil().setHeight(7)),
//                                                             child: Icon(Icons.arrow_back_ios_rounded, color: white.withOpacity(0.8), size: 15),
//                                                           ),
//                                                         ),
//                                                         SizedBox(
//                                                           width:
//                                                           ScreenUtil().setWidth(10),
//                                                         ),
//                                                         Container(
//                                                           width:
//                                                           MediaQuery.of(context).size.width - 88,
//                                                           child:
//                                                           Text(
//                                                             index1 == 2 ? openJobList[index].description.toString() : closedJobList[index].description.toString(),
//                                                             // trimLines: 4,
//                                                             // trimMode: TrimMode.Line,
//                                                             // colorClickableText: white,
//                                                             maxLines: 4,
//                                                             overflow: TextOverflow.ellipsis,
//                                                             style: GoogleFonts.nunitoSans(
//                                                               fontWeight: FontWeight.w400,
//                                                               color: white,
//                                                               fontSize: ScreenUtil().setSp(14),
//                                                               height: 1.2,
//                                                               shadows: <Shadow>[
//                                                                 Shadow(
//                                                                   offset: Offset(0.0, 2.0),
//                                                                   blurRadius: 2.0,
//                                                                   color: Color(0xff000000).withOpacity(0.25),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     SizedBox(
//                                                         height:
//                                                         ScreenUtil().setHeight(20)),
//                                                     Padding(
//                                                       padding:
//                                                       EdgeInsets.only(left: ScreenUtil().setWidth(24)),
//                                                       child:
//                                                       Row(
//                                                         children: [
//                                                           Text(
//                                                             index1 == 2 ? "Deadline: " + DateFormat('dd-MMM-yy').format(openJobList[index].deadline!) : "Completed On: " + DateFormat('dd-MMM-yy').format(closedJobList[index].deadline!),
//                                                             textAlign: TextAlign.left,
//                                                             style: GoogleFonts.nunitoSans(
//                                                               fontWeight: FontWeight.w400,
//                                                               color: white,
//                                                               fontSize: ScreenUtil().setSp(14),
//                                                               height: 0.16,
//                                                               shadows: <Shadow>[
//                                                                 Shadow(
//                                                                   offset: Offset(0.0, 2.0),
//                                                                   blurRadius: 2.0,
//                                                                   color: Color(0xff000000).withOpacity(0.25),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                           index1 == 2
//                                                               ? InkWell(
//                                                             onTap: () {
//                                                               setState(() {
//                                                                 closeOpenJob(true, openJobList[index].sId);
//                                                               });
//                                                             },
//                                                             child: Padding(
//                                                               padding: const EdgeInsets.only(left: 30.0),
//                                                               child: Text(
//                                                                 'Close',
//                                                                 textAlign: TextAlign.left,
//                                                                 style: GoogleFonts.nunitoSans(
//                                                                   fontWeight: FontWeight.w700,
//                                                                   color: white,
//                                                                   fontSize: ScreenUtil().setSp(14),
//                                                                   height: 0.16,
//                                                                   shadows: <Shadow>[
//                                                                     Shadow(
//                                                                       offset: Offset(0.0, 2.0),
//                                                                       blurRadius: 2.0,
//                                                                       color: Color(0xff000000).withOpacity(0.25),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           )
//                                                               : Container(),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 );
//                                               }),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             top: ScreenUtil().setHeight(31)),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             index1 == 0
//                                                 ? talentList[index].saved ==
//                                                 true
//                                                 ? InkWell(
//                                                 onTap: () {
//                                                   saveUnsaveTalents(
//                                                       'false',
//                                                       talentList[
//                                                       index]
//                                                           .sId,
//                                                       index);
//                                                 },
//                                                 child: Icon(
//                                                   Icons.bookmark,
//                                                   color: white,
//                                                   size: 23.r,
//                                                 ))
//                                                 : InkWell(
//                                                 onTap: () {
//                                                   saveUnsaveTalents(
//                                                       'true',
//                                                       talentList[
//                                                       index]
//                                                           .sId,
//                                                       index);
//                                                 },
//                                                 child: Icon(
//                                                   Icons
//                                                       .bookmark_border,
//                                                   color: white,
//                                                   size: 23.r,
//                                                 ))
//                                                 : Padding(
//                                               padding:
//                                               const EdgeInsets.only(
//                                                   top: 4.0),
//                                               child: Text(
//                                                 index1 == 2
//                                                     ? capitalize(
//                                                     openJobList[
//                                                     index]
//                                                         .jobType)
//                                                     : capitalize(
//                                                     closedJobList[
//                                                     index]
//                                                         .jobType),
//                                                 textAlign:
//                                                 TextAlign.left,
//                                                 style: GoogleFonts
//                                                     .nunitoSans(
//                                                   fontWeight:
//                                                   FontWeight.w700,
//                                                   color: white,
//                                                   fontSize: ScreenUtil()
//                                                       .setSp(14),
//                                                   height: 0.16,
//                                                   shadows: <Shadow>[
//                                                     Shadow(
//                                                       offset: Offset(
//                                                           0.0, 2.0),
//                                                       blurRadius: 2.0,
//                                                       color: Color(
//                                                           0xff000000)
//                                                           .withOpacity(
//                                                           0.25),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                             Spacer(),
//                                             SvgPicture.asset(
//                                                 "assets/icons/svg/share.svg",
//                                                 color: white),
//                                             Spacer(),
//                                             InkWell(
//                                               onTap: () {
//                                                 if (index1 != 0) {
//                                                   if (index1 == 3 &&
//                                                       closedJobList[index]
//                                                           .selectedCandidates!
//                                                           .length ==
//                                                           0) {
//                                                     setState(() {
//                                                       closeOpenJob(
//                                                           false,
//                                                           closedJobList[index]
//                                                               .sId);
//                                                     });
//                                                   } else {
//                                                     Navigator.push(
//                                                       context,
//                                                       MaterialPageRoute(
//                                                           builder: (context) =>
//                                                               CreateJob()),
//                                                     );
//                                                   }
//                                                 } else {
//                                                   if (talentList[index]
//                                                       .invitationStatus ==
//                                                       false) {
//                                                     invite(
//                                                         talentList[index]
//                                                             .profile!
//                                                             .sId,
//                                                         index);
//                                                   }
//                                                 }
//                                               },
//                                               child: Container(
//                                                 height: 30.h,
//                                                 width: 90.w,
//                                                 decoration: BoxDecoration(
//                                                   color:
//                                                   white.withOpacity(0.6),
//                                                   borderRadius:
//                                                   BorderRadius.circular(
//                                                       10),
//                                                   border: Border.all(
//                                                       color: orange),
//                                                 ),
//                                                 child: Center(
//                                                   child: Text(
//                                                     index1 == 0
//                                                         ? talentList[index]
//                                                         .invitationStatus ==
//                                                         false
//                                                         ? 'Invite to Job'
//                                                         : 'Invited'
//                                                         : index1 == 2
//                                                         ? 'Edit Job'
//                                                         : index1 == 3 &&
//                                                         closedJobList[index]
//                                                             .selectedCandidates!
//                                                             .length ==
//                                                             0
//                                                         ? 'Re-open Job'
//                                                         : 'Create Similar',
//                                                     textAlign: TextAlign.left,
//                                                     style: GoogleFonts
//                                                         .nunitoSans(
//                                                       fontWeight:
//                                                       FontWeight.w600,
//                                                       color: white,
//                                                       fontSize: ScreenUtil()
//                                                           .setSp(12),
//                                                       shadows: <Shadow>[
//                                                         Shadow(
//                                                           offset: Offset(
//                                                               0.0, 2.0),
//                                                           blurRadius: 2.0,
//                                                           color: Color(
//                                                               0xff000000)
//                                                               .withOpacity(
//                                                               0.25),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             Spacer(),
//                                             Spacer(),
//                                             Padding(
//                                               padding: EdgeInsets.only(
//                                                   right: ScreenUtil()
//                                                       .setWidth(12)),
//                                               child: index1 == 0
//                                                   ? talentList[index]
//                                                   .isSwipe ==
//                                                   true
//                                                   ? InkWell(
//                                                   onTap: () {
//                                                     setState(() {
//                                                       talentList[index]
//                                                           .isSwipe =
//                                                       false;
//                                                     });
//                                                   },
//                                                   child: Icon(
//                                                     Icons
//                                                         .arrow_forward_ios_rounded,
//                                                     color: white
//                                                         .withOpacity(
//                                                         0.8),
//                                                   ))
//                                                   : InkWell(
//                                                   onTap: () {
//                                                     setState(() {
//                                                       talentList[index]
//                                                           .isSwipe =
//                                                       true;
//                                                     });
//                                                   },
//                                                   child: Icon(
//                                                     Icons
//                                                         .arrow_back_ios_new_rounded,
//                                                     color: white
//                                                         .withOpacity(
//                                                         0.8),
//                                                   ))
//                                                   : Padding(
//                                                 padding: EdgeInsets.only(
//                                                     top: ScreenUtil()
//                                                         .setHeight(3)),
//                                                 child: Text(
//                                                   index1 == 2
//                                                       ? timeago.format(
//                                                       openJobList[
//                                                       index]
//                                                           .createdAt!)
//                                                       : timeago.format(
//                                                       closedJobList[
//                                                       index]
//                                                           .createdAt!),
//                                                   textAlign:
//                                                   TextAlign.left,
//                                                   style: GoogleFonts
//                                                       .nunitoSans(
//                                                     fontWeight:
//                                                     FontWeight.w400,
//                                                     color: white,
//                                                     fontSize:
//                                                     ScreenUtil()
//                                                         .setSp(10),
//                                                     height: 0.13,
//                                                     shadows: <Shadow>[
//                                                       Shadow(
//                                                         offset: Offset(
//                                                             0.0, 2.0),
//                                                         blurRadius: 2.0,
//                                                         color: Color(
//                                                             0xff000000)
//                                                             .withOpacity(
//                                                             0.25),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(
//                                           height: ScreenUtil().setHeight(8)),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       color: white.withOpacity(0.6),
//                                       borderRadius: BorderRadius.circular(12),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           offset: Offset(0.0, 8.0),
//                                           blurRadius: 30.0,
//                                           color: Color(0xff000000)
//                                               .withOpacity(0.40),
//                                         )
//                                       ]),
//                                   child: Padding(
//                                     padding: EdgeInsets.only(
//                                         left: ScreenUtil().setWidth(16),
//                                         right: ScreenUtil().setWidth(15),
//                                         top: ScreenUtil().setHeight(13),
//                                         bottom: ScreenUtil().setHeight(8)),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       children: [
//                                         index1 != 0
//                                             ? Container()
//                                             : CachedNetworkImage(
//                                           imageUrl: talentList[index]
//                                               .masterProfile!
//                                               .profileImageType ==
//                                               'avatar'
//                                               ? '${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${talentList[index].masterProfile!.profileImage}'
//                                               : '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${talentList[index].masterProfile!.profileImage}',
//                                           imageBuilder: (context,
//                                               imageProvider) =>
//                                               Container(
//                                                 width: 60.h,
//                                                 height: 60.w,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                   BorderRadius.circular(
//                                                       16.r),
//                                                   image: DecorationImage(
//                                                       image: imageProvider,
//                                                       fit: BoxFit.cover),
//                                                 ),
//                                               ),
//                                           errorWidget:
//                                               (context, url, error) {
//                                             print(
//                                                 "ER::${error.toString()}");
//                                             return Icon(Icons.error,
//                                                 color: white);
//                                           },
//                                           fit: BoxFit.cover,
//                                           height: ScreenUtil()
//                                               .setHeight(60),
//                                           width:
//                                           ScreenUtil().setWidth(60),
//                                         ),
//                                         SizedBox(
//                                           width: ScreenUtil().setWidth(12),
//                                         ),
//                                         index1 == 0
//                                             ? Column(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               capitalize(
//                                                   talentList[index]
//                                                       .masterProfile!
//                                                       .username) +
//                                                   ", " +
//                                                   talentList[index]
//                                                       .masterProfile!
//                                                       .age
//                                                       .toString(),
//                                               textAlign: TextAlign.left,
//                                               style: GoogleFonts
//                                                   .nunitoSans(
//                                                 fontWeight:
//                                                 FontWeight.w700,
//                                                 color: black,
//                                                 fontSize: ScreenUtil()
//                                                     .setSp(16),
//                                               ),
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   '@ ${capitalize(talentList[index].masterProfile!.username)}   ',
//                                                   textAlign:
//                                                   TextAlign.left,
//                                                   style: GoogleFonts
//                                                       .nunitoSans(
//                                                     fontWeight:
//                                                     FontWeight.w400,
//                                                     color: Color(
//                                                         0xff0060FF),
//                                                     fontSize:
//                                                     ScreenUtil()
//                                                         .setSp(12),
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   '${talentList[index].masterProfile!.followersCount} Followers',
//                                                   textAlign:
//                                                   TextAlign.left,
//                                                   style: GoogleFonts
//                                                       .nunitoSans(
//                                                     fontWeight:
//                                                     FontWeight.w400,
//                                                     color: white,
//                                                     fontSize:
//                                                     ScreenUtil()
//                                                         .setSp(12),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             SizedBox(height: 4),
//                                             Text(
//                                               talentList[index]
//                                                   .masterProfile!
//                                                   .achievements!,
//                                               textAlign: TextAlign.left,
//                                               style: GoogleFonts
//                                                   .nunitoSans(
//                                                 fontWeight:
//                                                 FontWeight.w400,
//                                                 color: white,
//                                                 fontSize: ScreenUtil()
//                                                     .setSp(10),
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                             : InkWell(
//                                           onTap: () {
//                                             print(
//                                                 openJobList[index].sId);
//                                             if (index1 == 3) {
//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) => BrandDetailApplication(
//                                                         id: closedJobList[
//                                                         index]
//                                                             .sId,
//                                                         title:
//                                                         closedJobList[
//                                                         index]
//                                                             .title,
//                                                         type: 'closed',
//                                                         jobType: closedJobList[
//                                                         index]
//                                                             .jobType)),
//                                               );
//                                             } else {
//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) => BrandDetailApplication(
//                                                         id: openJobList[
//                                                         index]
//                                                             .sId,
//                                                         title:
//                                                         openJobList[
//                                                         index]
//                                                             .title,
//                                                         jobType: openJobList[
//                                                         index]
//                                                             .jobType)),
//                                               );
//                                             }
//                                           },
//                                           child: Column(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment
//                                                 .start,
//                                             children: [
//                                               Text(
//                                                 index1 == 3
//                                                     ? 'Selected Candidates'
//                                                     : 'Applications',
//                                                 textAlign:
//                                                 TextAlign.left,
//                                                 style: GoogleFonts
//                                                     .nunitoSans(
//                                                   fontWeight:
//                                                   FontWeight.w400,
//                                                   color: black,
//                                                   fontSize: ScreenUtil()
//                                                       .setSp(12),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 height: 15,
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Padding(
//                                                     padding:
//                                                     EdgeInsets.only(
//                                                         left: 20.w),
//                                                     child: Container(
//                                                       height: 50.h,
//                                                       width: MediaQuery.of(
//                                                           context)
//                                                           .size
//                                                           .width -
//                                                           120.w,
//                                                       child: index1 ==
//                                                           3 &&
//                                                           closedJobList[index]
//                                                               .selectedCandidates!
//                                                               .length ==
//                                                               0
//                                                           ? Container(
//                                                         child:
//                                                         Transform(
//                                                           alignment:
//                                                           FractionalOffset.center,
//                                                           transform: new Matrix4
//                                                               .identity()
//                                                             ..rotateZ(15 *
//                                                                 3.1415927 /
//                                                                 -180),
//                                                           child:
//                                                           Text(
//                                                             'Cancelled',
//                                                             style:
//                                                             GoogleFonts.nunitoSans(
//                                                               fontWeight:
//                                                               FontWeight.w700,
//                                                               color:
//                                                               Colors.blue,
//                                                               fontSize:
//                                                               ScreenUtil().setSp(16),
//                                                               height:
//                                                               0.13,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       )
//                                                           : ListView.builder(
//                                                           primary: false,
//                                                           shrinkWrap: true,
//                                                           itemCount: index1 == 2
//                                                               ? openJobList[index].applicants!.length >= 4
//                                                               ? 4
//                                                               : openJobList[index].applicants!.length
//                                                               : closedJobList[index].selectedCandidates!.length >= 4
//                                                               ? 4
//                                                               : closedJobList[index].selectedCandidates!.length,
//                                                           scrollDirection: Axis.horizontal,
//                                                           controller: _scroll,
//                                                           itemBuilder: (context, i2) {
//                                                             return Padding(
//                                                               padding:
//                                                               EdgeInsets.only(right: 15.w),
//                                                               child:
//                                                               Container(
//                                                                 decoration:
//                                                                 BoxDecoration(shape: BoxShape.circle, boxShadow: [
//                                                                   BoxShadow(
//                                                                     offset: Offset(0, 2),
//                                                                     color: black,
//                                                                     blurRadius: 2.r,
//                                                                   ),
//                                                                 ]),
//                                                                 child:
//                                                                 CachedNetworkImage(
//                                                                   imageUrl: index1 == 2
//                                                                       ? openJobList[index].applicants![i2].profileImageType == 'avatar'
//                                                                       ? '${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${openJobList[index].applicants![i2].profileImage}'
//                                                                       : '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${openJobList[index].applicants![i2].profileImage}'
//                                                                       : closedJobList[index].selectedCandidates![i2].profileImageType == 'avatar'
//                                                                       ? '${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${closedJobList[index].selectedCandidates![i2].profileImage}'
//                                                                       : '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${closedJobList[index].selectedCandidates![i2].profileImage}',
//                                                                   imageBuilder: (context, imageProvider) => Container(
//                                                                     width: 50.h,
//                                                                     height: 50.w,
//                                                                     decoration: BoxDecoration(
//                                                                       shape: BoxShape.circle,
//                                                                     ),
//                                                                   ),
//                                                                   errorWidget: (context, url, error) {
//                                                                     print("ER::${error.toString()}");
//                                                                     return Icon(Icons.error, color: white);
//                                                                   },
//                                                                   fit: BoxFit.cover,
//                                                                   height: ScreenUtil().setHeight(50),
//                                                                   width: ScreenUtil().setWidth(50),
//                                                                 ),
//                                                               ),
//                                                             );
//                                                           }),
//                                                     ),
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                     EdgeInsets.only(
//                                                         left: 5.w),
//                                                     child: Text(
//                                                       index1 == 2
//                                                           ? openJobList[index]
//                                                           .applicants!
//                                                           .length >
//                                                           4
//                                                           ? openJobList[index]
//                                                           .applicants!
//                                                           .length
//                                                           .toString() +
//                                                           " more"
//                                                           : ""
//                                                           : closedJobList[index]
//                                                           .selectedCandidates!
//                                                           .length >
//                                                           4
//                                                           ? closedJobList[index]
//                                                           .selectedCandidates!
//                                                           .length
//                                                           .toString() +
//                                                           " more"
//                                                           : "",
//                                                       textAlign:
//                                                       TextAlign
//                                                           .left,
//                                                       style: GoogleFonts
//                                                           .nunitoSans(
//                                                         fontWeight:
//                                                         FontWeight
//                                                             .w400,
//                                                         color: white,
//                                                         fontSize:
//                                                         ScreenUtil()
//                                                             .setSp(
//                                                             12),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: 15,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Spacer(),
//                                         index1 == 0
//                                             ? InkWell(
//                                             onTap: () {
//                                               setState(() {
//                                                 showGeneralDialog(
//                                                     context: context,
//                                                     pageBuilder: (BuildContext
//                                                     buildContext,
//                                                         Animation
//                                                         animation,
//                                                         Animation
//                                                         secondaryAnimation) {
//                                                       return ReportDialog(
//                                                           talentList[
//                                                           index]
//                                                               .masterProfile!
//                                                               .sId!,
//                                                           'talent');
//                                                     });
//                                               });
//                                             },
//                                             child: Icon(Icons.more_vert,
//                                                 color: white))
//                                             : Container()
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 )
//               ],
//             ),
//
//             isJobClicked == true ? Container() :Positioned(
//               bottom: 0.0,
//               right: 27.0,
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 24.0),
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (ontext) => NotificationScreen()),
//                     );
//                   },
//                   child: Image.asset(
//                     'assets/icons/notifications.png',
//                     height: 24,
//                     width: 24,
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               ),
//             ),
//             isJobClicked == true ? Container() : Positioned(
//               bottom: 130.0,
//               left: 0.0,
//               child: InkWell(
//                 onTap: () async {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => BrandExplore()),
//                   );
//                 },
//                 child: Container(
//                   margin: EdgeInsets.only(
//                     bottom: ScreenUtil().setHeight(8),
//                   ),
//                   decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.25),
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 7.0,
//                           color: black.withOpacity(0.2),
//                           offset: Offset(2.0, 2.0),
//                         ),
//                       ],
//                       border: Border.all(
//                         color: Colors.white.withOpacity(0.25),
//                       ),
//                       borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(20),
//                           bottomRight: Radius.circular(5))),
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                         left: ScreenUtil().setWidth(8),
//                         right: ScreenUtil().setWidth(8),
//                         bottom: ScreenUtil().setHeight(8),
//                         top: ScreenUtil().setHeight(8)),
//                     child: SvgPicture.asset(
//                       "assets/icons/svg/search.svg",
//                       color: white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//             isProfileUI == false
//                 ? Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding: EdgeInsets.only(bottom: 77.h),
//                 child: Row(
//                   mainAxisAlignment:
//                   MainAxisAlignment.end,
//                   children: <Widget>[
//                     circleButtonImage(
//                       imgUrl: (true)
//                           ? CommonImage
//                           .dark_jobLink_icon
//                           : (true)
//                           ? "assets/icons/darkFamelinkIcon.png"
//                           : "assets/icons/logo.png",
//                       onTaps: () {
//                         setState(() {
//                           // onClickPageImage = !onClickPageImage;
//                           isProfileUI = true;
//                         });
//                       },
//                       isButtonSelect: true,
//                     ),
//                     Container(
//                       height: 2.0,
//                       width: 10.0,
//                       color:
//                       Color(0xFF9B9B9B),
//                     )
//                   ],
//                 ),
//               ),
//             )
//                 : Container(),
//             Positioned(
//               child: Visibility(
//                 visible: (isProfileUI == true),
//                 child: InkWell(
//                   onTap: () {
//                     setState(() {
//                       isProfileUI = false;
//                     });
//                   },
//                   child: Container(
//                     height: ScreenUtil().screenHeight,
//                     width: ScreenUtil().screenWidth,
//                     color: Colors.black45,
//                   ),
//                 ),
//               ),
//             ),
//             //isProfileUI==true?SizedBox(height: 20,):Container(),
//             Visibility(
//               visible: (isProfileUI == true),
//               child: Positioned(
//                 bottom: -35,
//                 right: -40.0,
//                 child: Container(
//                   height:300,width:250,
//                   child: Stack(
//                     clipBehavior: Clip.none,
//                     fit: StackFit.loose,
//                     alignment: Alignment.center,
//                     children: <Widget>[
//                       Positioned(
//                         child: SizedBox(
//                           height: 164,
//                           width: 164,
//                           child: Image.asset(
//                             "assets/images/commonOuterCircle.png",
//                           ),
//                         ),
//                         right: 10,
//
//                       ),
//
//                       // top Fame Links
//                       Positioned(
//                         right: 25,
//                         child: InkWell(
//                           onTap: () {
//                             setState(() {
//                               isProfileUI = false;
//                             });
//                             Navigator.push<void>(
//                               context,
//                               MaterialPageRoute<void>(builder: (BuildContext context) =>  ProfileFameLink(runSelectPhase: 3,)),
//                               // ModalRoute.withName('/'),
//                             );
//                           },
//                           child: SizedBox(
//                               height: 120,
//                               width: 120,
//                               child:  Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 30,top: 13),
//                                 child: Stack(
//                                   children: [
//
//                                     Padding(
//                                         padding: EdgeInsets.only(
//                                             bottom: 12.h),
//                                         child:   profileFameLinksImage==null?
//                                         avtarImage!=null
//                                             ? Container(
//                                           height: 90,width: 90,
//                                           child: Center(
//                                             child: CircleAvatar(
//                                               backgroundImage:
//                                               NetworkImage(
//                                                   avtarImage
//                                               ),
//                                               backgroundColor:
//                                               Colors
//                                                   .transparent,
//                                               radius: 50,
//                                             ),
//                                           ),
//                                         )
//
//                                             :profileImage!=null?
//                                         Container(
//                                           height: 90,width: 90,
//                                           child: CircleAvatar(
//                                             backgroundImage:
//                                             NetworkImage(
//                                                 profileImage
//                                             ),
//                                             backgroundColor: Colors.transparent,
//                                             radius: 50,
//                                           ),
//                                         )
//                                             :
//                                         Container(
//                                           height: 95.h,
//                                           width: 95.w,
//                                           decoration: BoxDecoration(
//                                             gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
//                                               lightRedWhite,
//                                               lightRed
//                                             ]),
//                                             shape: BoxShape.circle,
//                                           ),
//                                         )
//                                         //Column(
//                                           // crossAxisAlignment:
//                                           // CrossAxisAlignment.center,
//                                           // mainAxisAlignment:
//                                           // MainAxisAlignment.center,
//                                           // children: [
//                                           //   Image.asset(
//                                           //       "assets/images/feather_upload.png"),
//                                           //   SizedBox(
//                                           //     height: 8,
//                                           //   ),
//                                           //   Text(
//                                           //     "Your Avatar",
//                                           //     style: TextStyle(
//                                           //       fontSize: 12,
//                                           //       color: Color(0xFF9B9B9B),
//                                           //     ),
//                                           //   )
//                                           // ],
//                                         //)
//                                             :Container(
//                                           height: 90,width: 90,
//                                           child: CircleAvatar(
//                                             backgroundImage:
//                                             NetworkImage(
//                                                 profileFameLinksImage
//                                             ),
//                                             backgroundColor: Colors.transparent,
//                                             radius: 50,
//                                           ),
//                                         )
//                                     ),
//                                     Image.asset(
//                                       (isDarkMode != true)
//                                           ? CommonImage
//                                           .dark_inner_circle_icon
//                                           : "assets/images/commonInnerCircle.png",
//                                     ),
//                                   ],
//                                 ),
//                               )
//
//
//
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         // top: -160.0,
//                         // left: -109.0,
//                         right: 85.0,
//                         bottom: 210.0,
//                         child: SizedBox(
//                           height: 30,
//                           width: 115,
//                           child: InkWell(
//                             onTap: () {
//                               debugPrint(
//                                   "******************* Follow Links Work");
//                               setState(() {
//                                 HomeDialState.selectRegistration =
//                                     RegistrationType.FAMELinks
//                                         .toString();
//
//                                 isProfileUI = false;
//                                 getPostName="fameLinks";
//                                 Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
//                                     FameLinksFeed()), (Route<dynamic> route) => false);
//
//                               });
//                             },
//                             child: Row(
//                               crossAxisAlignment:
//                               CrossAxisAlignment.center,
//                               mainAxisAlignment:
//                               MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   decoration: (HomeDialState
//                                       .selectRegistration
//                                       .toString() ==
//                                       RegistrationType.FAMELinks
//                                           .toString())
//                                       ? BoxDecoration(
//                                     image: DecorationImage(
//                                       image: AssetImage(
//                                         CommonImage
//                                             .darkButtonBackIcon,
//                                       ),
//                                       fit: BoxFit.fill,
//                                     ),
//                                   )
//                                       : BoxDecoration(
//                                     image: DecorationImage(
//                                       image: AssetImage(
//                                         CommonImage
//                                             .secondBundleIcon,
//                                       ),
//                                       fit: BoxFit.fill,
//                                     ),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 6.0,
//                                         right: 6.0,
//                                         top: 2.0,
//                                         bottom: 2.0),
//                                     child: Text(
//                                       "FameLinks",
//                                       style: GoogleFonts.nunitoSans(
//                                         fontWeight: FontWeight.w400,
//                                         fontStyle: FontStyle.normal,
//                                         color: (HomeDialState
//                                             .selectRegistration
//                                             .toString() ==
//                                             RegistrationType
//                                                 .FAMELinks
//                                                 .toString())
//                                             ? Colors.white
//                                             : HexColor("#030C23"),
//                                         fontSize: 14.0,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 3,
//                                 ),
//                                 (HomeDialState.selectRegistration
//                                     .toString() ==
//                                     RegistrationType.FAMELinks
//                                         .toString())
//                                     ? circleButtonImageStack(
//                                   isButtonSelect: true,
//                                   imgUrl: (true)
//                                       ? "assets/icons/darkFamelinkIcon.png"
//                                       : (isDarkMode == true)
//                                       ? "assets/icons/darkFamelinkIcon.png"
//                                       : "assets/icons/logo.png",
//                                 )
//                                     : circleButtonImageStack(
//                                   imgUrl: (isDarkMode == true)
//                                       ? "assets/icons/darkFamelinkIcon.png"
//                                       : "assets/icons/logo.png",
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       // left FunLinks
//                       Positioned(
//                         // top: -80.0,
//                         right: 125.0,
//                         // left: -170.0,
//                         bottom: 160.0,
//                         child: InkWell(
//                           onTap: () {
//                             debugPrint("*************** FunLinks");
//                             setState(() {
//                               getPostName="funLinks";
//                             });
//                           },
//                           child: SizedBox(
//                             height: 30,
//                             width: 110,
//                             child: InkWell(
//                               onTap: () {
//                                 debugPrint(
//                                     "*************** FunLinks");
//                                 setState(() {
//                                   getPostName="funLinks";
//                                   HomeDialState.selectRegistration =
//                                       RegistrationType.FUNLinks
//                                           .toString();
//
//                                   isProfileUI = false;
//                                   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
//                                       FunLinksUserProfile()), (Route<dynamic> route) => false);
//                                   // key = UniqueKey();
//                                 });
//                               },
//                               child: Row(
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.center,
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                     decoration: (HomeDialState
//                                         .selectRegistration
//                                         .toString() ==
//                                         RegistrationType
//                                             .FUNLinks
//                                             .toString())
//                                         ? BoxDecoration(
//                                       image: DecorationImage(
//                                         image: AssetImage(
//                                           CommonImage
//                                               .darkButtonBackIcon,
//                                         ),
//                                         fit: BoxFit.fill,
//                                       ),
//                                     )
//                                         : BoxDecoration(
//                                       image: DecorationImage(
//                                         image: AssetImage(
//                                           CommonImage
//                                               .secondBundleIcon,
//                                         ),
//                                         fit: BoxFit.fill,
//                                       ),
//                                     ),
//                                     child: Padding(
//                                       padding:
//                                       const EdgeInsets.only(
//                                           left: 6.0,
//                                           right: 6.0,
//                                           top: 2.0,
//                                           bottom: 2.0),
//                                       child: Text(
//                                         "FunLinks",
//                                         style:
//                                         GoogleFonts.nunitoSans(
//                                           fontWeight:
//                                           FontWeight.w400,
//                                           fontStyle:
//                                           FontStyle.normal,
//                                           color: (HomeDialState
//                                               .selectRegistration
//                                               .toString() ==
//                                               RegistrationType
//                                                   .FUNLinks
//                                                   .toString())
//                                               ? Colors.white
//                                               : HexColor("#030C23"),
//                                           fontSize: 14.0,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   (HomeDialState.selectRegistration
//                                       .toString() ==
//                                       RegistrationType.FUNLinks
//                                           .toString())
//                                       ? circleButtonImageStack(
//                                     isButtonSelect: true,
//                                     imgUrl: (true)
//                                         ? CommonImage
//                                         .dark_videoLink_icon
//                                         : (isDarkMode == true)
//                                         ? CommonImage
//                                         .dark_videoLink_icon
//                                         : "assets/icons/funLinks.png",
//                                   )
//                                       : circleButtonImageStack(
//                                     imgUrl: (isDarkMode ==
//                                         true)
//                                         ? CommonImage
//                                         .dark_videoLink_icon
//                                         : "assets/icons/funLinks.png",
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         // right: MediaQuery.of(context).size.width/2,
//                       ),
//                       // // right FollowLinks
//                       Positioned(
//                         child: SizedBox(
//                           height: 30,
//                           width: 145,
//                           child: InkWell(
//                             onTap: () {
//                               setState(() {
//                                 getPostName="followLinks";
//                                 HomeDialState.selectRegistration =
//                                     RegistrationType.FOLLOWLinks
//                                         .toString();
//                                 // key = UniqueKey();
//                                 isProfileUI = false;
//                                 Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
//                                     FollowLinksUserProfile()), (Route<dynamic> route) => false);
//
//                               });
//                             },
//                             child: Row(
//                               crossAxisAlignment:
//                               CrossAxisAlignment.center,
//                               mainAxisAlignment:
//                               MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   decoration: (HomeDialState
//                                       .selectRegistration
//                                       .toString() ==
//                                       RegistrationType
//                                           .FOLLOWLinks
//                                           .toString())
//                                       ? BoxDecoration(
//                                     image: DecorationImage(
//                                       image: AssetImage(
//                                         CommonImage
//                                             .darkButtonBackIcon,
//                                       ),
//                                       fit: BoxFit.fill,
//                                     ),
//                                   )
//                                       : BoxDecoration(
//                                     image: DecorationImage(
//                                       image: AssetImage(
//                                         CommonImage
//                                             .secondBundleIcon,
//                                       ),
//                                       fit: BoxFit.fill,
//                                     ),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 6.0,
//                                         right: 6.0,
//                                         top: 2.0,
//                                         bottom: 2.0),
//                                     child: Text(
//                                       "FollowLinks",
//                                       style: GoogleFonts.nunitoSans(
//                                         fontWeight: FontWeight.w400,
//                                         fontStyle: FontStyle.normal,
//                                         color: (HomeDialState
//                                             .selectRegistration
//                                             .toString() ==
//                                             RegistrationType
//                                                 .FOLLOWLinks
//                                                 .toString())
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
//                                 (HomeDialState.selectRegistration
//                                     .toString() ==
//                                     RegistrationType.FOLLOWLinks
//                                         .toString())
//                                     ? circleButtonImageStack(
//                                   isButtonSelect: true,
//                                   imgUrl: (true)
//                                       ? CommonImage
//                                       .dark_follower_icon
//                                       : (isDarkMode == true)
//                                       ? CommonImage
//                                       .dark_follower_icon
//                                       : "assets/icons/followLinks.png",
//                                 )
//                                     : circleButtonImageStack(
//                                   imgUrl: (isDarkMode == true)
//                                       ? CommonImage
//                                       .dark_follower_icon
//                                       : "assets/icons/followLinks.png",
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         // top: 40.0,
//                         // right: 0.0,
//                         // left: -200.0,
//                         right: 115.0,
//                         // left: -170.0,
//                         bottom: 105.0,
//                         // right: MediaQuery.of(context).size.width/2,
//                       ),
//                       // JobLinks
//                       Positioned(
//                         child: SizedBox(
//                           height: 30,
//                           width: 80,
//                           child: InkWell(
//                             onTap: () async {
//                               HomeDialState.selectRegistration = RegistrationType.JOBLinks.toString();
//                               setState(() {
//                                 isProfileUI = false;
//                               });
//                               // var sharedPreferences = await SharedPreferences.getInstance();
//                               // Constants.userType = sharedPreferences.getString("type");
//                               // Navigator.pushReplacement(
//                               //   context,
//                               //   MaterialPageRoute(builder: (context) => BrandPage(Constants.userType)),
//                               // );
//                             },
//                             child: Row(
//                               crossAxisAlignment:
//                               CrossAxisAlignment.center,
//                               mainAxisAlignment:
//                               MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   decoration: (HomeDialState
//                                       .selectRegistration
//                                       .toString() ==
//                                       RegistrationType.JOBLinks
//                                           .toString())
//                                       ? BoxDecoration(
//                                     image: DecorationImage(
//                                       image: AssetImage(
//                                         CommonImage
//                                             .darkButtonBackIcon,
//                                       ),
//                                       fit: BoxFit.fill,
//                                     ),
//                                   )
//                                       : BoxDecoration(
//                                     image: DecorationImage(
//                                       image: AssetImage(
//                                         CommonImage
//                                             .secondBundleIcon,
//                                       ),
//                                       fit: BoxFit.fill,
//                                     ),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 6.0,
//                                         right: 6.0,
//                                         top: 2.0,
//                                         bottom: 2.0),
//                                     child: Text(
//                                       "JobLinks",
//                                       style: GoogleFonts.nunitoSans(
//                                         fontWeight: FontWeight.w400,
//                                         fontStyle: FontStyle.normal,
//                                         color: (HomeDialState
//                                             .selectRegistration
//                                             .toString() ==
//                                             RegistrationType
//                                                 .JOBLinks
//                                                 .toString())
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
//                                 (HomeDialState.selectRegistration
//                                     .toString() ==
//                                     RegistrationType.JOBLinks
//                                         .toString())
//                                     ? circleButtonImageStack(
//                                   isButtonSelect: true,
//                                   imgUrl: (true)
//                                       ? CommonImage
//                                       .dark_jobLink_icon
//                                       : (isDarkMode == true)
//                                       ? CommonImage
//                                       .dark_jobLink_icon
//                                       : "assets/icons/vector.png",
//                                 ):Container()
//                                 //     : circleButtonImageStack(
//                                 //   imgUrl: (isDarkMode == true)
//                                 //       ? CommonImage
//                                 //       .dark_jobLink_icon
//                                 //       : "assets/icons/vector.png",
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         // top: 135.0,
//                         right: 0.0,
//                         left: -25.0,
//                         bottom: 60.0,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
//
//   show(BuildContext context, index, index1) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//               backgroundColor: Colors.transparent,
//               insetPadding: EdgeInsets.all(1.r),
//               child: Padding(
//                 padding: EdgeInsets.only(left: 15.w),
//                 child: Container(
//                     height: 300.h,
//                     width: MediaQuery.of(context).size.width,
//                     color: Colors.transparent,
//                     child: ListView.builder(
//                         primary: false,
//                         shrinkWrap: true,
//                         itemCount: 1,
//                         scrollDirection: Axis.horizontal,
//                         itemBuilder: (context, i) {
//                           return Container(
//                             height: 400.h,
//                             child: Row(
//                               children: [
//                                 talentList[index].profile!.greetVideo == null || talentList[index].profile!.greetVideo == '' ? Container() :
//                                 Padding(
//                                   padding: EdgeInsets.only(right: 15.w),
//                                   child: Container(
//                                     height: 400.h,
//                                     width: 300.w,
//                                     child: Stack(
//                                       children: [
//                                         Image.asset("assets/icons/rect.png", height: 291.h,
//                                           width: 291.w,),
//                                         Positioned(
//                                           top: 9.h,
//                                           left: 7.w,
//                                           child: Container(
//                                             height: 291.h,
//                                             width: 291.w,
//                                             child: _controller[index]
//                                                 .value
//                                                 .isInitialized
//                                                 ? VideoPlayer(
//                                                 _controller[index])
//                                                 : Container(),
//                                           ),
//                                         ),
//                                         InkWell(
//                                           onTap: () {
//                                             setState(() {
//                                               if (talentList[index].isPlaying ==
//                                                   true) {
//                                                 _controller[index].pause();
//                                                 talentList[index].isPlaying =
//                                                 false;
//                                               } else {
//                                                 _controller[index].play();
//                                                 talentList[index].isPlaying =
//                                                 true;
//                                               }
//                                             });
//                                           },
//                                           child: Center(
//                                             child: talentList[index]
//                                                 .isPlaying ==
//                                                 true
//                                                 ? Container(
//                                               height: 40.h,
//                                               width: 40.w,
//                                             )
//                                                 : Container(
//                                               height: 40.h,
//                                               width: 40.w,
//                                               decoration: BoxDecoration(
//                                                   color:
//                                                   Colors.transparent,
//                                                   shape: BoxShape.circle,
//                                                   border: Border.all(
//                                                       color: white
//                                                           .withOpacity(
//                                                           0.5),
//                                                       width: 2.w)),
//                                               child: Icon(
//                                                   Icons.play_arrow,
//                                                   color: white
//                                                       .withOpacity(0.5)),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 ListView.builder(
//                                     primary: false,
//                                     shrinkWrap: true,
//                                     itemCount: talentList[index].posts!.length,
//                                     scrollDirection: Axis.horizontal,
//                                     itemBuilder: (context, ind) {
//                                       if(ind == 0){
//                                         ind = index1;
//                                       }else if(index1 == ind){
//                                         ind = 0;
//                                       }
//                                       return Padding(
//                                         padding: EdgeInsets.only(right: 15.w),
//                                         child: Container(
//                                           height: 400.h,
//                                           width:
//                                           MediaQuery.of(context).size.width -
//                                               150.w,
//                                           child: CachedNetworkImage(
//                                             imageUrl: talentList[index]
//                                                 .posts![ind]
//                                                 .closeUp !=
//                                                 null
//                                                 ? '${ApiProvider.famelinks}/${talentList[index].posts![ind].closeUp}'
//                                                 : talentList[index]
//                                                 .posts![ind]
//                                                 .medium !=
//                                                 null
//                                                 ? '${ApiProvider.famelinks}/${talentList[index].posts![ind].medium}'
//                                                 : talentList[index]
//                                                 .posts![ind]
//                                                 .long !=
//                                                 null
//                                                 ? '${ApiProvider.famelinks}/${talentList[index].posts![ind].long}'
//                                                 : talentList[index]
//                                                 .posts![i]
//                                                 .pose1 !=
//                                                 null
//                                                 ? '${ApiProvider.famelinks}/${talentList[index].posts![ind].pose1}'
//                                                 : talentList[index]
//                                                 .posts![ind]
//                                                 .pose2 !=
//                                                 null
//                                                 ? '${ApiProvider.famelinks}/${talentList[index].posts![ind].pose2}'
//                                                 : talentList[index]
//                                                 .posts![
//                                             ind]
//                                                 .additional !=
//                                                 null
//                                                 ? '${ApiProvider.famelinks}/${talentList[index].posts![ind].additional}'
//                                                 : '${ApiProvider.famelinks}/${talentList[index].posts![ind].video}',
//                                             errorWidget: (context, url, error) {
//                                               print("ER::${error.toString()}");
//                                               return Icon(Icons.error,
//                                                   color: white);
//                                             },
//                                             fit: BoxFit.fill,
//                                             height: ScreenUtil().setHeight(116),
//                                             width: ScreenUtil().setWidth(116),
//                                           ),
//                                         ),
//                                       );
//                                     })
//                               ],
//                             ),
//                           );
//                         })),
//               ));
//         });
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
//                   ? CommonImage.selected_circle_back
//                   : CommonImage.unSelected_circle_back)
//                   : AssetImage(
//                 (isDarkMode == true)
//                     ? CommonImage.dark_circle_avatar_back
//                     : CommonImage.light_circle_avatar_back,
//               ),
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
//               border: Border.all(color: isButtonSelect == true
//                   ? Color(0xffFF9D76):black),
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
