// import 'package:famelink/ui/upload/upload_screen_one.dart';
// import 'package:famelink/util/Validator.dart';
// import 'package:famelink/util/appStrings.dart';
// import 'package:famelink/util/config/color.dart';
// import 'package:famelink/util/config/text.dart';
// import 'package:famelink/util/constants.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:famelink/util/config/image.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class RegisterToContestScreen extends StatefulWidget {
//   @override
//   _RegisterToContestScreenState createState() =>
//       _RegisterToContestScreenState();
// }
//
// class _RegisterToContestScreenState extends State<RegisterToContestScreen> {
//   TextEditingController screenNameController = TextEditingController();
//   TextEditingController careerInterestController = TextEditingController();
//   TextEditingController heightController = TextEditingController();
//   TextEditingController eyeColorController = TextEditingController();
//   TextEditingController skinColorController = TextEditingController();
//   TextEditingController vitalsController = TextEditingController();
//   TextEditingController ethnicBackgroundController = TextEditingController();
//
//   final GlobalKey<FormState> _contestFormKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         appBar: AppBar(
//           iconTheme: IconThemeData(color: black),
//           toolbarHeight: ScreenUtil().setHeight(61),
//           backgroundColor: appBackgroundColor,
//           elevation: 0,
//           centerTitle: true,
//           title: Text.rich(TextSpan(children: <TextSpan>[
//             TextSpan(
//                 text: registerFor,
//                 style: GoogleFonts.kanit(
//                     fontWeight: FontWeight.w700,
//                     color: black,
//                     fontSize: ScreenUtil().setSp(18))),
//             TextSpan(
//                 text: contest,
//                 style: GoogleFonts.kanit(
//                     fontWeight: FontWeight.w700,
//                     fontSize: ScreenUtil().setSp(18),
//                     color: lightRed))
//           ])),
//         ),
//         body: Form(
//           key: _contestFormKey,
//           child: Container(
//             padding: EdgeInsets.only(
//                 left: ScreenUtil().setWidth(20),
//                 right: ScreenUtil().setWidth(20)),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                       height: ScreenUtil().setHeight(140),
//                       child: Card(
//                         elevation: 4,
//                         child: Container(
//                           padding: EdgeInsets.only(
//                               left: ScreenUtil().setWidth(12),
//                               right: ScreenUtil().setWidth(12)),
//                           child: Column(
//                             children: [
//                               Container(
//                                 child: TextFormField(
//                                   decoration: InputDecoration(
//                                       hintText: 'Enter your district',
//                                       suffixIcon: Icon(Icons.search)),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     top: ScreenUtil().setHeight(30)),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Your contest path:',
//                                       style: TextStyle(
//                                           fontSize: ScreenUtil().setSp(14),
//                                           fontWeight: FontWeight.w400,
//                                           color: lightRed),
//                                     ),
//                                     Text(
//                                       'Female(18-24)',
//                                       style: TextStyle(
//                                           fontSize: ScreenUtil().setSp(14),
//                                           fontWeight: FontWeight.w700,
//                                           color: Colors.blue),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               Text('Places'),
//                             ],
//                           ),
//                         ),
//                       )),
//
//                   Container(
//                     margin: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
//                     alignment: Alignment.topRight,
//                     child: Text(
//                       'Learn about stages?',
//                       style: TextStyle(
//                           fontSize: ScreenUtil().setSp(14),
//                           fontWeight: FontWeight.w500,
//                           color: lightRed),
//                     ),
//                   ),
//
//                   ///screen name
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: ScreenUtil().setHeight(20),
//                         left: ScreenUtil().setWidth(44),
//                         right: ScreenUtil().setWidth(44)),
//                     child: TextFormField(
//                       textAlign: TextAlign.start,
//                       textAlignVertical: TextAlignVertical.center,
//                       controller: screenNameController,
//                       textInputAction: TextInputAction.done,
//                       validator: (value) {
//                         return Validator.validateFormField(
//                             value,
//                             strErrorEmptyScreenName,
//                             strInvalidScreenName,
//                             Constants.NORMAL_VALIDATION);
//                       },
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: lightRed, width: ScreenUtil().radius(1)),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(ScreenUtil().radius(8))),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: lightRed, width: ScreenUtil().radius(1)),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(ScreenUtil().radius(8))),
//                         ),
//                         contentPadding:
//                             EdgeInsets.only(left: ScreenUtil().setWidth(10)),
//                         hintText: 'Screen Name',
//                         hintStyle: GoogleFonts.poppins(
//                             fontSize: ScreenUtil().setSp(12),
//                             color: darkGray,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                   ),
//
//                   ///career interest
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: ScreenUtil().setHeight(16),
//                         left: ScreenUtil().setWidth(44),
//                         right: ScreenUtil().setWidth(44)),
//                     child: TextFormField(
//                       textAlign: TextAlign.start,
//                       textAlignVertical: TextAlignVertical.center,
//                       controller: careerInterestController,
//                       keyboardType: TextInputType.text,
//                       textInputAction: TextInputAction.done,
//                       validator: (value) {
//                         return Validator.validateFormField(
//                             value,
//                             strErrorEmptyCareerInterest,
//                             strInvalidCareerInterest,
//                             Constants.NORMAL_VALIDATION);
//                       },
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: lightRed, width: ScreenUtil().radius(1)),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(ScreenUtil().radius(8))),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: lightRed, width: ScreenUtil().radius(1)),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(ScreenUtil().radius(8))),
//                         ),
//                         contentPadding:
//                             EdgeInsets.only(left: ScreenUtil().setWidth(10)),
//                         hintText: 'Career Interest',
//                         hintStyle: GoogleFonts.poppins(
//                             fontSize: ScreenUtil().setSp(12),
//                             color: darkGray,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                   ),
//
//                   /// height
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: ScreenUtil().setHeight(16),
//                         left: ScreenUtil().setWidth(44),
//                         right: ScreenUtil().setWidth(44)),
//                     child: TextFormField(
//                       textAlign: TextAlign.start,
//                       textAlignVertical: TextAlignVertical.center,
//                       controller: heightController,
//                       keyboardType: TextInputType.number,
//                       textInputAction: TextInputAction.done,
//                       validator: (value) {
//                         return Validator.validateFormField(
//                             value,
//                             strErrorEmptyHeight,
//                             strInvalidHeight,
//                             Constants.NORMAL_VALIDATION);
//                       },
//                       decoration: InputDecoration(
//                         suffixIcon: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SvgPicture.asset(
//                             heighticon,
//                             width: ScreenUtil().setWidth(20),
//                             height: ScreenUtil().setHeight(20),
//                           ),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: lightRed, width: ScreenUtil().radius(1)),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(ScreenUtil().radius(8))),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: lightRed, width: ScreenUtil().radius(1)),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(ScreenUtil().radius(8))),
//                         ),
//                         contentPadding:
//                             EdgeInsets.only(left: ScreenUtil().setWidth(10)),
//                         hintText: 'Height',
//                         hintStyle: GoogleFonts.poppins(
//                             fontSize: ScreenUtil().setSp(12),
//                             color: darkGray,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                   ),
//
//                   ///eye color
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: ScreenUtil().setHeight(16),
//                         left: ScreenUtil().setWidth(44),
//                         right: ScreenUtil().setWidth(44)),
//                     child: TextFormField(
//                       textAlign: TextAlign.start,
//                       textAlignVertical: TextAlignVertical.center,
//                       controller: eyeColorController,
//                       keyboardType: TextInputType.text,
//                       textInputAction: TextInputAction.done,
//                       validator: (value) {
//                         return Validator.validateFormField(
//                             value,
//                             strErrorEmptyEyeColor,
//                             strInvalidEyeColor,
//                             Constants.NORMAL_VALIDATION);
//                       },
//                       decoration: InputDecoration(
//                         suffixIcon: Image.asset(
//                           eyecoloricon,
//                           color: Colors.grey,
//                           width: ScreenUtil().setWidth(20),
//                           height: ScreenUtil().setHeight(20),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: lightRed, width: ScreenUtil().radius(1)),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(ScreenUtil().radius(8))),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: lightRed, width: ScreenUtil().radius(1)),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(ScreenUtil().radius(8))),
//                         ),
//                         contentPadding:
//                             EdgeInsets.only(left: ScreenUtil().setWidth(10)),
//                         hintText: 'Eye Color',
//                         hintStyle: GoogleFonts.poppins(
//                             fontSize: ScreenUtil().setSp(12),
//                             color: darkGray,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                   ),
//
//                   ///skin color
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: ScreenUtil().setHeight(16),
//                         left: ScreenUtil().setWidth(44),
//                         right: ScreenUtil().setWidth(44)),
//                     child: TextFormField(
//                       textAlign: TextAlign.start,
//                       textAlignVertical: TextAlignVertical.center,
//                       controller: skinColorController,
//                       keyboardType: TextInputType.text,
//                       textInputAction: TextInputAction.done,
//                       validator: (value) {
//                         return Validator.validateFormField(
//                             value,
//                             strErrorEmptySkinColor,
//                             strInvalidSkinColor,
//                             Constants.NORMAL_VALIDATION);
//                       },
//                       decoration: InputDecoration(
//                         suffixIcon: Image.asset(
//                           skincoloricon,
//                           width: ScreenUtil().setWidth(20),
//                           height: ScreenUtil().setHeight(20),
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: lightRed, width: ScreenUtil().radius(1)),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(ScreenUtil().radius(8))),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: lightRed, width: ScreenUtil().radius(1)),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(ScreenUtil().radius(8))),
//                         ),
//                         contentPadding:
//                             EdgeInsets.only(left: ScreenUtil().setWidth(10)),
//                         hintText: 'Skin Color',
//                         hintStyle: GoogleFonts.poppins(
//                             fontSize: ScreenUtil().setSp(12),
//                             color: darkGray,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                   ),
//
//                   ///vitals
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: ScreenUtil().setHeight(16),
//                         left: ScreenUtil().setWidth(44),
//                         right: ScreenUtil().setWidth(44)),
//                     child: TextFormField(
//                       textAlign: TextAlign.start,
//                       textAlignVertical: TextAlignVertical.center,
//                       controller: vitalsController,
//                       keyboardType: TextInputType.text,
//                       textInputAction: TextInputAction.done,
//                       validator: (value) {
//                         return Validator.validateFormField(
//                             value,
//                             strErrorEmptyVitals,
//                             strInvalidVitals,
//                             Constants.NORMAL_VALIDATION);
//                       },
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: lightRed, width: ScreenUtil().radius(1)),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(ScreenUtil().radius(8))),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: lightRed, width: ScreenUtil().radius(1)),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(ScreenUtil().radius(8))),
//                         ),
//                         contentPadding:
//                             EdgeInsets.only(left: ScreenUtil().setWidth(10)),
//                         hintText: 'Vitals',
//                         hintStyle: GoogleFonts.poppins(
//                             fontSize: ScreenUtil().setSp(12),
//                             color: darkGray,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                   ),
//
//                   ///ethnic background
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: ScreenUtil().setHeight(16),
//                         left: ScreenUtil().setWidth(44),
//                         right: ScreenUtil().setWidth(44)),
//                     child: TextFormField(
//                       textAlign: TextAlign.start,
//                       textAlignVertical: TextAlignVertical.center,
//                       controller: ethnicBackgroundController,
//                       keyboardType: TextInputType.text,
//                       textInputAction: TextInputAction.done,
//                       validator: (value) {
//                         return Validator.validateFormField(
//                             value,
//                             strErrorEthnicBackground,
//                             strInvalidEthnicBackground,
//                             Constants.NORMAL_VALIDATION);
//                       },
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: lightRed, width: ScreenUtil().radius(1)),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(ScreenUtil().radius(8))),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: lightRed, width: ScreenUtil().radius(1)),
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(ScreenUtil().radius(8))),
//                         ),
//                         contentPadding:
//                             EdgeInsets.only(left: ScreenUtil().setWidth(10)),
//                         hintText: 'Ethnic Background',
//                         hintStyle: GoogleFonts.poppins(
//                             fontSize: ScreenUtil().setSp(12),
//                             color: darkGray,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: ScreenUtil().setWidth(200),
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all<Color>(lightRed),
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                                   RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(30),
//                                         topRight: Radius.circular(00),
//                                         bottomLeft: Radius.circular(30),
//                                         bottomRight: Radius.circular(30),
//                                       ),
//                                       side: BorderSide(color: lightRed)))),
//                       onPressed: () async {
//                           SharedPreferences prefs = await SharedPreferences.getInstance();
//                          if(_contestFormKey.currentState.validate()){
//                            prefs.setString("screenName", screenNameController.text);
//                            prefs.setString("careerInterest",careerInterestController.text);
//                            prefs.setString("height",heightController.text);
//                            prefs.setString("eyeColor",eyeColorController.text);
//                            prefs.setString("skinColor",skinColorController.text);
//                            prefs.setString("vitals",vitalsController.text);
//                            prefs.setString("ethnicBackground",ethnicBackgroundController.text);
//                            await Navigator.pushReplacement(
//                                context,
//                                MaterialPageRoute(
//                                    builder: (context) => UploadScreenOne( )));
//                          }
//                          else{
//                            Constants.toastMessage(msg: 'All fields needs to be filled');
//                          }
//
//                       },
//                       child: Text(
//                         'Submit',
//                         style: TextStyle(
//                             color: white,
//                             fontWeight: FontWeight.w700,
//                             fontSize: ScreenUtil().setSp(16)),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
