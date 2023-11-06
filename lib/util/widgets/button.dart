// import 'package:famelink/networking/config.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../config/color.dart';
//
//
// class MyButton extends StatefulWidget {
//   final String? label;
//   final double? topLeft, topRight, bottomRight, bottomLeft;
//   final Color? labelColor, borderColor, backgroundColor;
//
//   final Function? onPressed;
//
//   MyButton(
//       {this.label,
//       this.labelColor,
//       this.topLeft,
//       this.topRight,
//       this.bottomRight,
//       this.bottomLeft,
//       this.borderColor,
//       this.backgroundColor,
//       this.onPressed});
//
//   @override
//   _MyButtonState createState() => _MyButtonState();
// }
//
// class _MyButtonState extends State<MyButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: ScreenUtil().setWidth(250),
//       child: ElevatedButton(
//         onPressed: (){
//           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LetsBeginScreen()));
//         },
//         child: Padding(
//           padding:EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
//           child: Text(
//             widget.label!,
//             style: GoogleFonts.poppins(
//                 color: widget.labelColor,
//                 fontSize: ScreenUtil().setSp(18),
//                 fontWeight: FontWeight.w600),
//           ),
//         ),
//         style: ButtonStyle(
//             backgroundColor:
//                 MaterialStateProperty.all<Color>(widget.backgroundColor!),
//             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(widget.topLeft!),
//                       topRight: Radius.circular(widget.topRight!),
//                       bottomLeft: Radius.circular(widget.bottomLeft!),
//                       bottomRight: Radius.circular(widget.bottomRight!),
//                     ),
//                     side: BorderSide(color: widget.borderColor!)))),
//       ),
//     );
//     // return Container(
//     //   padding: EdgeInsets.all(10),
//     //   decoration: BoxDecoration(
//     //     borderRadius: BorderRadius.only(
//     //       topLeft: Radius.circular(widget.topLeft),
//     //       topRight: Radius.circular(widget.topRight),
//     //       bottomLeft: Radius.circular(widget.bottomLeft),
//     //       bottomRight: Radius.circular(widget.bottomRight),
//     //     ),
//     //   ),
//     //   child: Text(widget.label),
//     // );
//   }
// }
//
// class MyPrefixButton extends StatefulWidget {
//   final String? label;
//   final String? prefixLabel;
//   final double? topLeft, topRight, bottomRight, bottomLeft;
//   final Color? labelColor, borderColor, foregroundColor, backgroundColor;
//
//   MyPrefixButton(
//       {this.label,
//       this.prefixLabel,
//       this.labelColor,
//       this.topLeft,
//       this.topRight,
//       this.bottomRight,
//       this.bottomLeft,
//       this.borderColor,
//       this.foregroundColor,
//      this.backgroundColor});
//
//   @override
//   _MyPrefixButtonState createState() => _MyPrefixButtonState();
// }
//
// class _MyPrefixButtonState extends State<MyPrefixButton> {
//   final ApiProvider _api = ApiProvider();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: ScreenUtil().setWidth(250),
//       child: ElevatedButton(
//         onPressed: (){
//
//         },
//         child: Padding(
//           padding: EdgeInsets.only(left: ScreenUtil().setWidth(8)),
//           child: Row(
//             children: [
//               Text(
//                 widget.prefixLabel!,
//                 style: GoogleFonts.poppins(
//                     fontWeight: FontWeight.w600,
//                     fontStyle: FontStyle.normal,
//                     fontSize: ScreenUtil().setSp(30),
//                     color: widget.labelColor),
//               ),
//               Text(
//                 widget.label!,
//                 style: GoogleFonts.poppins(
//                     color: widget.labelColor,
//                     fontWeight: FontWeight.w600,
//                     fontStyle: FontStyle.normal,
//                     fontSize: ScreenUtil().setSp(18)),
//               ),
//             ],
//           ),
//         ),
//         style: ButtonStyle(
//             backgroundColor:
//                 MaterialStateProperty.all<Color>(widget.backgroundColor!),
//             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(widget.topLeft!),
//                       topRight: Radius.circular(widget.topRight!),
//                       bottomLeft: Radius.circular(widget.bottomLeft!),
//                       bottomRight: Radius.circular(widget.bottomRight!),
//                     ),
//                     side: BorderSide(color: widget.borderColor!)))),
//       ),
//     );
//     // return Container(
//     //   padding: EdgeInsets.all(10),
//     //   decoration: BoxDecoration(
//     //     borderRadius: BorderRadius.only(
//     //       topLeft: Radius.circular(widget.topLeft),
//     //       topRight: Radius.circular(widget.topRight),
//     //       bottomLeft: Radius.circular(widget.bottomLeft),
//     //       bottomRight: Radius.circular(widget.bottomRight),
//     //     ),
//     //   ),
//     //   child: Text(widget.label),
//     // );
//   }
//
//
//
// }
//
//
// class EditButton extends StatefulWidget {
//   final String? label;
//   final double? topLeft, topRight, bottomRight, bottomLeft;
//   final Color? labelColor, borderColor, backgroundColor;
//
//   final Function? onPressed;
//
//   EditButton(
//       {this.label,
//         this.labelColor,
//         this.topLeft,
//         this.topRight,
//         this.bottomRight,
//         this.bottomLeft,
//         this.borderColor,
//        this.backgroundColor,
//         this.onPressed});
//
//   @override
//   _EditButtonState createState() => _EditButtonState();
// }
//
// class _EditButtonState extends State<EditButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: ScreenUtil().setHeight(25),
//       width: ScreenUtil().setWidth(108),
//       child: ElevatedButton(
//         onPressed: (){
//           //Navigator.push(context, MaterialPageRoute(builder: (context) => LetsBeginScreen()));
//         },
//         child: Text(
//           widget.label!,
//           style: GoogleFonts.poppins(
//               color: white,
//               fontSize: ScreenUtil().setSp(14),
//               fontWeight: FontWeight.w500),
//         ),
//         style: ButtonStyle(
//             backgroundColor:
//             MaterialStateProperty.all<Color>(widget.backgroundColor!),
//             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(widget.topLeft!),
//                       topRight: Radius.circular(widget.topRight!),
//                       bottomLeft: Radius.circular(widget.bottomLeft!),
//                       bottomRight: Radius.circular(widget.bottomRight!),
//                     ),
//                     side: BorderSide(color: widget.borderColor!)))),
//       ),
//     );
//
//   }
// }
