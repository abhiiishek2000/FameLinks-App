import 'package:famelink/common/common_image.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../common/common_textformfield.dart';

class FunLinksDial extends StatefulWidget {
  const FunLinksDial({Key? key}) : super(key: key);

  @override
  State<FunLinksDial> createState() => _FunLinksDialState();
}

class _FunLinksDialState extends State<FunLinksDial> {
  bool status1 = false;

  Key key = UniqueKey();
  bool isDartMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          decoration: (isDartMode == true)
              ? BoxDecoration(
            image: DecorationImage(
              image: AssetImage(CommonImage.dart_back_img),
              alignment: Alignment.center,
              fit: BoxFit.fill,
            ),
          )
              : BoxDecoration(
            color: HexColor("#FDFCFA"),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // welcome
                SizedBox(
                  height: 15,
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "Welcome to ",
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              color: HexColor("#030C23"),
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0.8, 0.8),
                                  blurRadius: 0.2,
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                ),
                                Shadow(
                                  offset: Offset(0.8, 0.8),
                                  blurRadius: 0.2,
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                ),
                              ],
                              fontSize: 26,
                            ),
                          ),
                          TextSpan(
                            text: "BUDLINKS",
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 26,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0.8, 0.8),
                                  blurRadius: 0.2,
                                  color: HexColor("#FF5C28").withOpacity(0.25),
                                ),
                                Shadow(
                                  offset: Offset(0.8, 0.8),
                                  blurRadius: 0.2,
                                  color: HexColor("#FF5C28").withOpacity(0.25),
                                ),
                              ],
                              color: HexColor("#FF5C28"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "Fun",
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              color: HexColor("FF5C28"),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: "Links",
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: (isDartMode == true)
                                  ? HexColor("#FFFFFF")
                                  : HexColor("#030C23"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      " is a channel for ",
                      style: GoogleFonts.nunitoSans(
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: (isDartMode == true)
                            ? HexColor("#FFFFFF")
                            : HexColor("#030C23"),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: (isDartMode == true)
                              ? AssetImage(CommonImage.dark_funLinks_shortVideo)
                              : AssetImage(CommonImage.light_funLinks_shortVideo),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 2, top: 5, bottom: 5, right: 2),
                        child: Text(
                          "Short Videos",
                          style: GoogleFonts.nunitoSans(
                            color: (isDartMode == true)
                                ? HexColor("#FFFFFF")
                                : HexColor("#FF5C28"),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 60,
                ),

                Stack(
                  ///overflow: Overflow.visible,
                  fit: StackFit.loose,
                  children: <Widget>[
                    // upper shape
                    Positioned(
                      bottom: (-ScreenUtil().screenHeight * 0.17).ceilToDouble(),
                      left: (ScreenUtil().screenWidth / 2.8).ceilToDouble(),
                      // right: 0.0,
                      child: Container(
                        padding: EdgeInsets.only(right: 20.0),
                        height: (ScreenUtil().screenHeight * 0.23).ceilToDouble(),
                        width: (ScreenUtil().screenWidth * 0.60).ceilToDouble(),
                        margin: EdgeInsets.only(right: 24.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: (isDartMode == false)
                                ? AssetImage(
                                    CommonImage.light_funLinks_first_icon)
                                : AssetImage(
                                    CommonImage.dark_funLinks_first_icon),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, top: 16.0, right: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 18.0,
                                    width: 16.2,
                                    child: Image.asset(
                                      (isDartMode == true)
                                          ? CommonImage.dark_funLinks_first_shape
                                          : CommonImage
                                              .light_funLinks_first_shape,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15.0,
                                  ),
                                  Text(
                                    "Watch Talented &\nBeautiful\npeople making\nVideos",
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.bold,
                                      color: (isDartMode == true)
                                          ? HexColor("#FFFFFF")
                                          : HexColor("#030C23"),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: SizedBox(
                                  height: (ScreenUtil().screenHeight * 0.08)
                                      .ceilToDouble(),
                                  width: 54,
                                  child: Image.asset(
                                    (isDartMode == true)
                                        ? CommonImage.dark_talent_icon
                                        : CommonImage.light_talent_icon,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // down Shape
                    Positioned(
                      bottom: (-ScreenUtil().screenHeight * 0.49).ceilToDouble(),
                      left: (ScreenUtil().screenWidth / 2.8).ceilToDouble(),
                      // right: 0.0,
                      child: Container(
                        padding: EdgeInsets.only(right: 20.0),
                        height: (ScreenUtil().screenHeight * 0.25).ceilToDouble(),
                        width: (ScreenUtil().screenWidth * 0.60).ceilToDouble(),
                        margin: EdgeInsets.only(right: 24.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: (isDartMode == true)
                                ? AssetImage(
                                    CommonImage.dark_funLinks_second_icon)
                                : AssetImage(
                                    CommonImage.light_funLinks_second_icon),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, top: 16.0, right: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 25.0,
                                    width: 25.0,
                                    child: Image.asset(
                                      (isDartMode == true)
                                          ? CommonImage.dark_play_icon
                                          : CommonImage.light_play_icon,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 0.0,
                                  ),
                                  Text(
                                    "Pick or\nupload\nnew music",
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.bold,
                                      color: (isDartMode == true)
                                          ? HexColor("#FFFFFF")
                                          : HexColor("#030C23"),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: (ScreenUtil().screenHeight * 0.01)
                                  .ceilToDouble(),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: EdgeInsets.only(right: 16.0),
                                padding: EdgeInsets.only(
                                    left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        (isDartMode == true)
                                            ? CommonImage.dark_Funzone_shape
                                            : CommonImage.light_Funzone_shape,
                                      ),
                                      fit: BoxFit.fill),
                                ),
                                child: Text(
                                  'Enter Funzone',
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold,
                                    color: (isDartMode == true)
                                        ? HexColor("#FFFFFF")
                                        : HexColor("#FF4944"),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 50.0, top: 8.0),
                                child: SizedBox(
                                  height: 30,
                                  width: 36.77,
                                  child: Image.asset(
                                    (isDartMode == true)
                                        ? CommonImage.dark_player_icon
                                        : CommonImage.light_player_icon,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // circle
                    Positioned(
                      left: (-ScreenUtil().screenWidth * 0.42).ceilToDouble(),
                      child: SizedBox(
                        // height: ScreenUtil().screenHeight * 0.469,
                        height: ScreenUtil().screenHeight * 0.440,
                        width: ScreenUtil().screenWidth,
                        child: Stack(
                          ///overflow: Overflow.visible,
                          fit: StackFit.loose,
                          alignment: Alignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: (ScreenUtil().screenHeight * 0.34)
                                  .ceilToDouble(),
                              width: (ScreenUtil().screenWidth * 0.73)
                                  .ceilToDouble(),
                              child: Image.asset(
                                (isDartMode == true)
                                    ? CommonImage.dark_outer_circle_icon
                                    : "assets/images/home_outer_circle.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                            // top
                            Positioned(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  circleButtonImage(
                                    imgUrl: (isDartMode == true)
                                        ? "assets/icons/darkFamelinkIcon.png"
                                        : "assets/icons/logo.png",
                                    onTaps: () {},
                                  ),
                                  Container(
                                    height: 20.0,
                                    width: 2.0,
                                    color: Color(0xFF9B9B9B),
                                  ),
                                ],
                              ),
                              top: 0.0,
                              left: 0.0,
                              right: 0.0,
                              bottom: (ScreenUtil().screenHeight * 0.30)
                                  .ceilToDouble(),
                            ),
                            // left
                            Positioned(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  circleButtonImage(
                                    imgUrl: (isDartMode == true)
                                        ? CommonImage.dark_follower_icon
                                        : "assets/icons/followLinks.png",
                                    onTaps: () {},
                                  ),
                                  Container(
                                    width: 22.0,
                                    height: 2.0,
                                    color: Color(0xFF9B9B9B),
                                  )
                                ],
                              ),
                              top: 0.0,
                              right: 216.0,
                              left: 0.0,
                              bottom: 0.0,
                              // right: MediaQuery.of(context).size.width/2,
                            ),
                            // right
                            Positioned(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 22.0,
                                    height: 2.0,
                                    color: Color(0xFF9B9B9B),
                                  ),
                                  circleButtonImage(
                                    imgUrl: (true)
                                        ? CommonImage.dark_videoLink_icon
                                        : (isDartMode == true)
                                            ? CommonImage.dark_videoLink_icon
                                            : "assets/icons/funLinks.png",
                                    isButtonSelect: true,
                                    onTaps: () {},
                                  ),
                                ],
                              ),
                              top: 0.0,
                              right: 0.0,
                              left: (ScreenUtil().screenWidth * 0.61)
                                  .ceilToDouble(),
                              bottom: 0.0,
                            ),
                            // bottom
                            Positioned(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 20.0,
                                    width: 2.0,
                                    color: Color(0xFF9B9B9B),
                                  ),
                                  circleButtonImage(
                                    onTaps: () {},
                                    imgUrl: (isDartMode == true)
                                        ? CommonImage.dark_jobLink_icon
                                        : "assets/icons/vector.png",
                                  ),
                                ],
                              ),
                              top: (ScreenUtil().screenHeight * 0.30)
                                  .ceilToDouble(),
                              left: 0.0,
                              right: 0.0,
                              bottom: 0.0,
                              // right: MediaQuery.of(context).size.width/2,
                            ),

                            Stack(
                              //overflow: Overflow.visible,
                              fit: StackFit.loose,
                              alignment: Alignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: (ScreenUtil().screenHeight * 0.22)
                                      .ceilToDouble(),
                                  width: (ScreenUtil().screenWidth * 0.43)
                                      .ceilToDouble(),
                                  child: Image.asset(
                                    (isDartMode == true)
                                        ? CommonImage.dark_inner_circle_icon
                                        : "assets/images/home_inner_circle.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        "assets/images/feather_upload.png"),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Your Avatar",
                                      style: TextStyle(
                                          fontSize: 12, color: Color(0xFF9B9B9B)),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Text(''),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: ScreenUtil().screenHeight * 0.469,
                //   width: ScreenUtil().screenWidth,
                //   child: Stack(
                //     overflow: Overflow.visible,
                //     fit: StackFit.loose,
                //     alignment: Alignment.center,
                //     children: [
                //       Container(
                //         height: ScreenUtil().screenHeight,
                //         width: ScreenUtil().screenWidth,
                //         child: Image.asset(
                //           (isDartMode == true)
                //               ? CommonImage.dark_outer_circle_icon
                //               : "assets/images/home_outer_circle.png",
                //         ),
                //       ),
                //       // top
                //       Positioned(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             circleButtonImage(
                //               imgUrl: (true)
                //                   ? "assets/icons/darkFamelinkIcon.png"
                //                   : (isDartMode == true)
                //                       ? "assets/icons/darkFamelinkIcon.png"
                //                       : "assets/icons/logo.png",
                //               onTaps: () {},
                //               isButtonSelect: true,
                //             ),
                //             Container(
                //               height: 20.0,
                //               width: 2.0,
                //               color: Color(0xFF9B9B9B),
                //             ),
                //           ],
                //         ),
                //         top: 0.0,
                //         left: 0.0,
                //         right: 0.0,
                //         bottom: 220.0,
                //       ),
                //       // left
                //       Positioned(
                //         child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             circleButtonImage(
                //               imgUrl: (isDartMode == true)
                //                   ? CommonImage.dark_follower_icon
                //                   : "assets/icons/followLinks.png",
                //               onTaps: () {},
                //             ),
                //             Container(
                //               width: 22.0,
                //               height: 2.0,
                //               color: Color(0xFF9B9B9B),
                //             )
                //           ],
                //         ),
                //         top: 0.0,
                //         right: 220.0,
                //         left: 0.0,
                //         bottom: 0.0,
                //         // right: MediaQuery.of(context).size.width/2,
                //       ),
                //       // right
                //       Positioned(
                //         child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Container(
                //               width: 22.0,
                //               height: 2.0,
                //               color: Color(0xFF9B9B9B),
                //             ),
                //             circleButtonImage(
                //               imgUrl: (isDartMode == true)
                //                   ? CommonImage.dark_videoLink_icon
                //                   : "assets/icons/funLinks.png",
                //               onTaps: () {},
                //             ),
                //           ],
                //         ),
                //         top: 0.0,
                //         right: 0.0,
                //         left: 220.0,
                //         bottom: 0.0,
                //       ),
                //       // bottom
                //       Positioned(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Container(
                //               height: 20.0,
                //               width: 2.0,
                //               color: Color(0xFF9B9B9B),
                //             ),
                //             circleButtonImage(
                //               onTaps: () {},
                //               imgUrl: (isDartMode == true)
                //                   ? CommonImage.dark_jobLink_icon
                //                   : "assets/icons/vector.png",
                //             ),
                //           ],
                //         ),
                //         top: 220.0,
                //         left: 0.0,
                //         right: 0.0,
                //         bottom: 0.0,
                //         // right: MediaQuery.of(context).size.width/2,
                //       ),
                //
                //       Stack(
                //         overflow: Overflow.visible,
                //         fit: StackFit.loose,
                //         alignment: Alignment.center,
                //         children: [
                //           Container(
                //               height: 144,
                //               width: 144,
                //               child: Image.asset((isDartMode == true)
                //                   ? CommonImage.dark_inner_circle_icon
                //                   : "assets/images/home_inner_circle.png")),
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Image.asset("assets/images/feather_upload.png"),
                //               SizedBox(
                //                 height: 8,
                //               ),
                //               Text(
                //                 "Your Avatar",
                //                 style: TextStyle(
                //                     fontSize: 12, color: Color(0xFF9B9B9B)),
                //               )
                //             ],
                //           )
                //         ],
                //       )
                //     ],
                //   ),
                // ),

                // Container(
                //   height: ScreenUtil().screenHeight * 0.24,
                //   child: Column(
                //     children: <Widget>[
                //       // Individual  design
                //
                //       // Name Field
                //       Padding(
                //         padding: EdgeInsets.only(left: 12.0, right: 12.0),
                //         child: Column(
                //           children: <Widget>[
                //             Card(
                //               elevation: 2.0,
                //               shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(12.0)),
                //               child: Container(
                //                 width: ScreenUtil().screenWidth,
                //                 decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(12.0),
                //                   color: Colors.white,
                //                   border: Border.all(
                //                     color: Color.fromRGBO(255, 255, 255, 0.5),
                //                     width: 1.0,
                //                   ),
                //                   boxShadow: [
                //                     BoxShadow(
                //                       color: Colors.grey.withOpacity(0.35),
                //                       blurRadius: 0.25,
                //                       offset: Offset(-0, 5), // Shadow position
                //                     ),
                //                   ],
                //                 ),
                //                 padding: EdgeInsets.all(8.0),
                //                 child: Column(
                //                   children: <Widget>[
                //                     Row(
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.center,
                //                       mainAxisAlignment: MainAxisAlignment.center,
                //                       children: <Widget>[
                //                         SizedBox(
                //                           height: 30.0,
                //                           width: 30.0,
                //                           child: CircleAvatar(
                //                             radius: 0,
                //                             backgroundColor: HexColor("#FF5C28"),
                //                             child: CircleAvatar(
                //                               backgroundImage: NetworkImage(
                //                                   "https://ui-avatars.com/api/?name=GA"),
                //                               radius: 13,
                //                             ),
                //                           ),
                //                         ),
                //                         SizedBox(
                //                           width: 8.0,
                //                         ),
                //                         Expanded(
                //                           child: SizedBox(
                //                             child: CommonTextFormField(
                //                               bottomPadding: 7.0,
                //                               hintText: 'Enter your Name',
                //                               hintStyle: GoogleFonts.nunitoSans(
                //                                 fontWeight: FontWeight.w400,
                //                                 fontStyle: FontStyle.italic,
                //                                 color: HexColor("#9B9B9B"),
                //                                 fontSize: 18.0,
                //                               ),
                //                             ),
                //                             height: 25.0,
                //                           ),
                //                         ),
                //                         Text(
                //                           'Date of Birth',
                //                           style: GoogleFonts.nunitoSans(
                //                             fontWeight: FontWeight.w400,
                //                             fontStyle: FontStyle.italic,
                //                             color: HexColor("#9B9B9B"),
                //                             fontSize: 18.0,
                //                           ),
                //                         )
                //                       ],
                //                     ),
                //                     const SizedBox(
                //                       height: 7.0,
                //                     ),
                //                     Divider(
                //                       height: 1,
                //                       color: HexColor("#9B9B9B"),
                //                     ),
                //                     const SizedBox(
                //                       height: 7.0,
                //                     ),
                //                     Row(
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.center,
                //                       children: <Widget>[
                //                         Expanded(
                //                           child: SizedBox(
                //                             child: CommonTextFormField(
                //                               bottomPadding: 12.0,
                //                               hintText:
                //                                   'Enter your District Name (first 3 char)',
                //                               hintStyle: GoogleFonts.nunitoSans(
                //                                 fontWeight: FontWeight.w400,
                //                                 fontStyle: FontStyle.italic,
                //                                 color: HexColor("#9B9B9B"),
                //                                 fontSize: 12.0,
                //                               ),
                //                             ),
                //                             height: 16,
                //                           ),
                //                         ),
                //                         Text(
                //                           '@@',
                //                           style: GoogleFonts.nunitoSans(
                //                             fontWeight: FontWeight.w600,
                //                             fontStyle: FontStyle.italic,
                //                             color: HexColor("#FF5C28"),
                //                             fontSize: 14.0,
                //                           ),
                //                         )
                //                       ],
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //             SizedBox(
                //               height: (ScreenUtil().screenHeight * 0.03)
                //                   .ceilToDouble(),
                //             ),
                //             Align(
                //               alignment: Alignment.centerRight,
                //               child: Text(
                //                 'Skip & Enter ->',
                //                 style: GoogleFonts.nunitoSans(
                //                   fontWeight: FontWeight.w400,
                //                   fontStyle: FontStyle.normal,
                //                   color: HexColor("#4B4E58"),
                //                   fontSize: 12.0,
                //                 ),
                //               ),
                //             )
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget circleButtonImage({
    String? imgUrl,
    bool isButtonSelect = false,
    void Function()? onTaps,
  }) =>
      InkWell(
        key: key,
        onTap: onTaps,
        child: Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: (isButtonSelect == true)
                  ? AssetImage((isButtonSelect == true)
                      ? CommonImage.selected_circle_back
                      : CommonImage.unSelected_circle_back)
                  : AssetImage(
                      (isDartMode == true)
                          ? CommonImage.dark_circle_avatar_back
                          : CommonImage.light_circle_avatar_back,
                    ),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: SizedBox(
              key: key,
              width: 30,
              height: 28,
              child: Image.asset(
                imgUrl.toString(),
                width: 30,
                height: 28,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      );
}
