// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import '../../../../util/config/color.dart';

// class ExpLevel extends StatelessWidget {
//   const ExpLevel({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<JobCreateprovider>(
//       builder: (context, provider, child) {
//         return Padding(
//           padding: EdgeInsets.only(
//               top: ScreenUtil().setHeight(16),
//               left: ScreenUtil().setWidth(40),
//               right: ScreenUtil().setWidth(40)),
//           child: Row(
//             children: [
//               Text(
//                 "Exp Level:",
//                 style: GoogleFonts.nunitoSans(
//                   fontSize: ScreenUtil().setSp(14),
//                   fontWeight: FontWeight.w600,
//                   fontStyle: FontStyle.normal,
//                   height: 0.19,
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   if (provider.experienceIndex == 1 ||
//                       provider.experienceIndex == 2) {
//                     //  setState(() {
//                     provider.changeexperienceIndex(0);
//                     // provider.experienceIndex = 0;
//                     //  });
//                   }
//                 },
//                 child: Row(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(
//                           bottom: ScreenUtil().setHeight(7),
//                           left: ScreenUtil().setWidth(5)),
//                       child: Container(
//                         height: ScreenUtil().setHeight(14),
//                         width: ScreenUtil().setWidth(14),
//                         decoration: BoxDecoration(
//                             color:
//                                 provider.experienceIndex == 0 ? orange : white,
//                             borderRadius: BorderRadius.circular(50),
//                             border: Border.all(color: black)),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: ScreenUtil().setWidth(6)),
//                       child: Text(
//                         "Fresher",
//                         style: GoogleFonts.nunitoSans(
//                             fontSize: ScreenUtil().setSp(12),
//                             fontWeight: provider.experienceIndex == 0
//                                 ? FontWeight.w700
//                                 : FontWeight.w400,
//                             fontStyle: FontStyle.normal,
//                             height: 0.16,
//                             color: Color(0xff4B4E58)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Spacer(),
//               InkWell(
//                 onTap: () {
//                   if (provider.experienceIndex == 0 ||
//                       provider.experienceIndex == 2) {
//                     // setState(() {
//                     // provider.experienceIndex = 1;
//                     provider.changeexperienceIndex(1);

//                     //  });
//                   }
//                 },
//                 child: Row(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(
//                           bottom: ScreenUtil().setHeight(7),
//                           left: ScreenUtil().setWidth(5)),
//                       child: Container(
//                         height: ScreenUtil().setHeight(14),
//                         width: ScreenUtil().setWidth(14),
//                         decoration: BoxDecoration(
//                             color:
//                                 provider.experienceIndex == 1 ? orange : white,
//                             borderRadius: BorderRadius.circular(50),
//                             border: Border.all(color: black)),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: ScreenUtil().setWidth(6)),
//                       child: Text(
//                         "Experienced",
//                         style: GoogleFonts.nunitoSans(
//                             fontSize: ScreenUtil().setSp(12),
//                             fontWeight: provider.experienceIndex == 1
//                                 ? FontWeight.w700
//                                 : FontWeight.w400,
//                             fontStyle: FontStyle.normal,
//                             height: 0.16,
//                             color: Color(0xff4B4E58)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Spacer(),
//               InkWell(
//                 onTap: () {
//                   if (provider.experienceIndex == 0 ||
//                       provider.experienceIndex == 1) {
//                     //setState(() {
//                     // provider.experienceIndex = 2;
//                     // });
//                     provider.changeexperienceIndex(2);
//                   }
//                 },
//                 child: Row(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(
//                           bottom: ScreenUtil().setHeight(7),
//                           left: ScreenUtil().setWidth(5)),
//                       child: Container(
//                         height: ScreenUtil().setHeight(14),
//                         width: ScreenUtil().setWidth(14),
//                         decoration: BoxDecoration(
//                             color:
//                                 provider.experienceIndex == 2 ? orange : white,
//                             borderRadius: BorderRadius.circular(50),
//                             border: Border.all(color: black)),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: ScreenUtil().setWidth(6)),
//                       child: Text(
//                         "Any",
//                         style: GoogleFonts.nunitoSans(
//                             fontSize: ScreenUtil().setSp(12),
//                             fontWeight: provider.experienceIndex == 2
//                                 ? FontWeight.w700
//                                 : FontWeight.w400,
//                             fontStyle: FontStyle.normal,
//                             height: 0.16,
//                             color: Color(0xff4B4E58)),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
