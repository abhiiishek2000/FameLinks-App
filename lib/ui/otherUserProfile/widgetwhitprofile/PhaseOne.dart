import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:famelink/common/common_image.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/ChattingScreen.dart';
import 'package:famelink/ui/fameLinks/provider/FameLinksFeedProvider.dart';
import 'package:famelink/ui/latest_profile/collabs_click.dart';
import 'package:famelink/ui/otherUserProfile/ui/GetParticularUserProfile.dart';
import 'package:famelink/ui/profile/brand_details_screen.dart';
import 'package:famelink/util/ReadMoreText.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../share/firebasedynamiclink.dart';
import '../../Famelinkprofile/function/famelinkFun.dart';
import '../../latest_profile/SayHiFirstVideo.dart';
import '../provder/OtherPofileprovider.dart';
import 'circleButtonImageStack.dart';
import 'darkcircleButtonImageStack.dart';
import 'showReferralCodeDialog.dart';

class PhaseOnewhitemode extends StatelessWidget {
  PhaseOnewhitemode({Key? key, this.id, this.isshow}) : super(key: key);

  String? id;
  String? isshow;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Consumer3<OtherPofileprovider, FameLinksFeedProvider, FameLinkFun>(
      builder: (context, otherPofileprovider, fameLinksProvider, fameLinkFun,
          child) {
        return Column(
          children: <Widget>[
            Visibility(
                visible: (otherPofileprovider.selectPhase == 0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 1.0,
                        ),
                      ],
                    ),
                    height: h * 0.12,
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      shadowColor: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Constants.userType == 'agency' ? 3 : 8,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CollabClick(),
                                  ),
                                );
                              },
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    Constants.userType == 'brand'
                                        ? fameLinkFun.store.isNotEmpty
                                            ? fameLinkFun.store[0].visits
                                                .toString()
                                            : "" //before this ""
                                        : otherPofileprovider
                                                    .profileFameLinksList
                                                    .length !=
                                                0
                                            ? otherPofileprovider
                                                        .profileFameLinksList[0]
                                                        .hearts ==
                                                    null
                                                ? ""
                                                : otherPofileprovider
                                                        .profileFameLinksList[0]
                                                        .hearts
                                                        .toString() ??
                                                    ""
                                            : "",
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 8, //2
                                  ),
                                  Row(children: [
                                    Constants.userType == 'agency'
                                        ? SizedBox()
                                        : Image.asset(
                                            Constants.userType == 'brand'
                                                ? "assets/icons/visits.png"
                                                : "assets/images/frame.png",
                                            height: 30,
                                            width: 30,
                                          ),
                                    Constants.userType == 'brand' ||
                                            Constants.userType == 'agency'
                                        ? Text(
                                            Constants.userType == 'brand'
                                                ? 'Visits'
                                                : 'Collabs',
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.bold,
                                                fontSize: Constants.userType ==
                                                            'brand' ||
                                                        Constants.userType ==
                                                            'agency'
                                                    ? 12
                                                    : 14,
                                                color: Colors.black),
                                          )
                                        : Container(),
                                  ]),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Constants.userType == 'agency' ? 0 : 5,
                            ),
                            Center(
                                child: Container(
                                    width: 1,
                                    height: 32,
                                    color: Colors.black.withOpacity(0.25))),
                            SizedBox(
                              width: Constants.userType == 'agency' ? 0 : 5,
                            ),
                            Column(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      Constants.userType == 'brand'
                                          ? fameLinkFun.store.isNotEmpty
                                              ? fameLinkFun.store[0].urlVisits
                                                  .toString()
                                              : "" //before this ""
                                          : otherPofileprovider
                                                  .profileFameLinksList
                                                  .isNotEmpty
                                              ? otherPofileprovider
                                                  .profileFameLinksList[0].score
                                                  .toString()
                                              : "",
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: Constants.userType == 'brand' ||
                                              Constants.userType == 'agency'
                                          ? 8
                                          : 0,
                                    ),
                                    Constants.userType == 'brand'
                                        ? Image.asset(
                                            CommonImage.funLinksStoreLinksLinks,
                                            height: 14,
                                            width: 12,
                                          )
                                        : Container()
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      Constants.userType == 'brand'
                                          ? "URL Visits"
                                          : Constants.userType == 'agency'
                                              ? "Recommendations"
                                              : "Score",
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Constants.userType ==
                                                      'brand' ||
                                                  Constants.userType == 'agency'
                                              ? 12
                                              : 14,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: Constants.userType == 'agency'
                                          ? 0
                                          : 5,
                                    ),
                                    Constants.userType == 'brand' ||
                                            Constants.userType == 'agency'
                                        ? Container()
                                        : Image.asset(
                                            "assets/images/vector.png",
                                            height: 14,
                                            width: 12,
                                          )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              width: Constants.userType == 'brand' ||
                                      Constants.userType == 'agency'
                                  ? 0
                                  : 5,
                            ),
                            Center(
                                child: Container(
                                    width: 1,
                                    height: 25,
                                    color: Colors.black.withOpacity(0.25))),
                            SizedBox(
                              width: 5,
                            ),
                            Constants.userType == 'brand' ||
                                    Constants.userType == "agency"
                                ? Column(
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            Constants.userType == 'brand'
                                                ? fameLinkFun
                                                            .store.isNotEmpty &&
                                                        fameLinkFun.store[0]
                                                                .trendzsSponsored !=
                                                            null
                                                    ? fameLinkFun
                                                        .store[0]
                                                        .trendzsSponsored!
                                                        .length
                                                        .toString()
                                                    : ""
                                                : otherPofileprovider
                                                        .profileFameLinksList
                                                        .isNotEmpty
                                                    ? otherPofileprovider
                                                        .profileFameLinksList[0]
                                                        .trendzSet
                                                        .toString()
                                                    : "",
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                          Image.asset(
                                            "assets/images/trendz.png",
                                            height: 14,
                                            width: 14,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      otherPofileprovider.profileFameLinksList
                                                      .length !=
                                                  0 &&
                                              otherPofileprovider
                                                      .profileFameLinksList[0]
                                                      .trendzSet ==
                                                  0
                                          ? Text(
                                              Constants.userType == 'agency'
                                                  ? "Trendz Sponsored"
                                                  : "Trendz Participating",
                                              style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Constants
                                                                  .userType ==
                                                              'brand' ||
                                                          Constants.userType ==
                                                              'agency'
                                                      ? 12
                                                      : 14,
                                                  color: Colors.black),
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          : Text(
                                              Constants.userType == 'agency'
                                                  ? "Trendz Sponsored"
                                                  : "Trendz Set",
                                              style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Constants
                                                                  .userType ==
                                                              'brand' ||
                                                          Constants.userType ==
                                                              'agency'
                                                      ? 12
                                                      : 14,
                                                  color: Colors.black),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                      InkWell(
                                        onTap: () {
                                          //  setState(() {
                                          fameLinkFun.trendsSetClicked =
                                              !fameLinkFun.trendsSetClicked;
                                          if (fameLinkFun.trendsSetClicked ==
                                              true) {
                                            fameLinkFun.titleWonClicked = false;
                                            fameLinkFun.yourMusicClicked =
                                                false;
                                          }
                                          // });
                                        },
                                        child:
                                            fameLinkFun.trendsSetClicked == true
                                                ? Icon(
                                                    Icons.keyboard_arrow_up,
                                                    color: Colors.black
                                                        .withOpacity(0.25),
                                                  )
                                                : Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Colors.black
                                                        .withOpacity(0.25),
                                                  ),
                                      )
                                    ],
                                  )
                                : Column(
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      otherPofileprovider.profileFameLinksList
                                                  .length !=
                                              0
                                          ? Text(
                                              otherPofileprovider
                                                          .profileFameLinksList[
                                                              0]
                                                          .contesting !=
                                                      null
                                                  ? otherPofileprovider
                                                      .profileFameLinksList[0]
                                                      .contesting
                                                      .toString()!
                                                  : "0",
                                              style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            )
                                          : Text(
                                              fameLinkFun.titleWon != null
                                                  ? fameLinkFun.titleWon!
                                                  : "",
                                              style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      otherPofileprovider.profileFameLinksList
                                                      .length !=
                                                  0 &&
                                              otherPofileprovider
                                                      .profileFameLinksList[0]
                                                      .titlesWon!
                                                      .length !=
                                                  0
                                          ? Row(
                                              children: [
                                                Text(
                                                  "Titles Won",
                                                  style: GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),
                                                SvgPicture.asset(
                                                  "assets/icons/svg/logo_splash.svg",
                                                  width: 12,
                                                  height: 14,
                                                ),

                                                ///Image.asset("assets/images/logo_splash.svg",height: 14,width: 12,),
                                              ],
                                            )
                                          : Text(
                                              "Contesting",
                                              style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Colors.black),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                      InkWell(
                                        onTap: () {
                                          //  setState(() {
                                          fameLinkFun.titleWonClicked =
                                              !fameLinkFun.titleWonClicked;
                                          if (fameLinkFun.titleWonClicked ==
                                              true) {
                                            fameLinkFun.trendsSetClicked =
                                                false;
                                            fameLinkFun.yourMusicClicked =
                                                false;
                                          }
                                          // });
                                        },
                                        child:
                                            fameLinkFun.titleWonClicked == true
                                                ? Icon(
                                                    Icons.keyboard_arrow_up,
                                                    color: Colors.black
                                                        .withOpacity(0.25),
                                                  )
                                                : Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Colors.black
                                                        .withOpacity(0.25),
                                                  ),
                                      )
                                    ],
                                  ),
                            SizedBox(
                              width: 5,
                            ),
                            Center(
                                child: Container(
                                    width: 1,
                                    height: 32,
                                    color: Colors.black.withOpacity(0.25))),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      Constants.userType == 'brand'
                                          ? fameLinkFun.store.isNotEmpty
                                              ? fameLinkFun
                                                  .store[0].products!.length
                                                  .toString()
                                              : ""
                                          : otherPofileprovider
                                                  .profileFameLinksList
                                                  .isNotEmpty
                                              ? otherPofileprovider
                                                  .profileFameLinksList[0]
                                                  .trendzSet
                                                  .toString()
                                              : "",
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),
                                    SizedBox(width: 3),
                                    Constants.userType == 'brand' ||
                                            Constants.userType == 'agency'
                                        ? Container()
                                        : Image.asset(
                                            "assets/images/trendz.png",
                                            height: 14,
                                            width: 14,
                                          )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                otherPofileprovider
                                                .profileFameLinksList.length !=
                                            0 &&
                                        otherPofileprovider
                                                .profileFameLinksList[0]
                                                .trendzSet ==
                                            0
                                    ? SizedBox(
                                        width: 100,
                                        child: Text(
                                          Constants.userType == 'brand'
                                              ? 'products'
                                              : Constants.userType == 'agency'
                                                  ? "Posts"
                                                  : "Trendz Participating",
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: Constants.userType ==
                                                          'brand' ||
                                                      Constants.userType ==
                                                          'agency'
                                                  ? 12
                                                  : 14,
                                              color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    : Text(
                                        Constants.userType == 'brand'
                                            ? 'products'
                                            : Constants.userType == 'agency'
                                                ? "Collab Posts"
                                                : "Trendz Set",
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Constants.userType == 'brand' ||
                                                        Constants.userType ==
                                                            'agency'
                                                    ? 12
                                                    : 14,
                                            color: Colors.black),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                InkWell(
                                  onTap: () {
                                    // setState(() {
                                    // trendsSetClicked =
                                    //     !trendsSetClicked;
                                    fameLinkFun.trendsSetClicked = false;

                                    if (fameLinkFun.trendsSetClicked == true) {
                                      fameLinkFun.titleWonClicked = false;
                                      fameLinkFun.yourMusicClicked = false;
                                    }
                                    //  });
                                    if (Constants.userType == 'brand' ||
                                        Constants.userType == 'agency') {
                                      otherPofileprovider!.scrollController
                                          .animateTo(
                                        otherPofileprovider!.scrollController
                                            .position.maxScrollExtent,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.fastOutSlowIn,
                                      );
                                    }
                                  },
                                  child: fameLinkFun.trendsSetClicked == true
                                      ? Icon(
                                          Icons.keyboard_arrow_up,
                                          color: Colors.black.withOpacity(0.25),
                                        )
                                      : Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.black.withOpacity(0.25),
                                        ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                // : Container()
                ),
            // SingleChildScrollView(
            //       controller: _scrollController,
            //   child: Visibility(
            //     visible: (otherPofileprovider.selectPhase == 0),
            //     child: Constants.userType == 'brand' &&
            //                 fameLinkFun.store.length != 0 ||
            //             Constants.userType == 'individual' &&
            //                 otherPofileprovider.profileFameLinksList.length != 0
            //         ? Padding(
            //             padding: const EdgeInsets.only(
            //                 left: 10, right: 10, top: 20),
            //             child: Container(
            //               height: 80,
            //               width: double.infinity,
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(12),
            //                   color: Colors.black.withOpacity(0.25)),
            //               child: Padding(
            //                 padding: const EdgeInsets.only(top: 13),
            //                 child: Row(
            //                   //crossAxisAlignment: CrossAxisAlignment.start,
            //                   mainAxisAlignment:
            //                       MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     SizedBox(
            //                       width: 8,
            //                     ),
            //                     Column(
            //                       //mainAxisAlignment: MainAxisAlignment.center,
            //                       children: [
            //                         Text(
            //                           Constants.userType == 'brand'
            //                               ? fameLinkFun.store[0].visits ?? "0"
            //                               : otherPofileprovider.profileFameLinksList[0]
            //                                   .hearts
            //                                   .toString(),
            //                           style: GoogleFonts.nunitoSans(
            //                               fontWeight: FontWeight.bold,
            //                               fontSize: 14,
            //                               color: Colors.black),
            //                         ),
            //                         SizedBox(
            //                           height: 2,
            //                         ),
            //                         Row(
            //                           children: [
            //                             Image.asset(
            //                               Constants.userType == 'brand'
            //                                   ? "assets/icons/visits.png"
            //                                   : "assets/images/frame.png",
            //                               height: 30,
            //                               width: 30,
            //                             ),
            //                             Constants.userType == 'brand'
            //                                 ? Text(
            //                                     'Visits',
            //                                     style: GoogleFonts
            //                                         .nunitoSans(
            //                                             fontWeight:
            //                                                 FontWeight
            //                                                     .bold,
            //                                             fontSize: 14,
            //                                             color:
            //                                                 Colors.black),
            //                                   )
            //                                 : Container(),
            //                           ],
            //                         )
            //                       ],
            //                     ),
            //                     SizedBox(
            //                       width: 5,
            //                     ),
            //                     Center(
            //                         child: Container(
            //                             width: 1,
            //                             height: 32,
            //                             color: Colors.black
            //                                 .withOpacity(0.25))),
            //                     SizedBox(
            //                       width: 5,
            //                     ),
            //                     Column(
            //                       //mainAxisAlignment: MainAxisAlignment.center,
            //                       children: [
            //                         Text(
            //                           Constants.userType == 'brand'
            //                               ? fameLinkFun.store[0].urlVisits ?? ""
            //                               : otherPofileprovider.profileFameLinksList[0]
            //                                   .score
            //                                   .toString(),
            //                           style: GoogleFonts.nunitoSans(
            //                               fontWeight: FontWeight.bold,
            //                               fontSize: 14,
            //                               color: Colors.black),
            //                         ),
            //                         SizedBox(
            //                           height: 8,
            //                         ),
            //                         Row(
            //                           children: [
            //                             Text(
            //                               Constants.userType == 'brand'
            //                                   ? "URL Visits"
            //                                   : "Score",
            //                               style: GoogleFonts.nunitoSans(
            //                                   fontWeight: FontWeight.bold,
            //                                   fontSize: 14,
            //                                   color: Colors.black),
            //                             ),
            //                             SizedBox(
            //                               width: 5,
            //                             ),
            //                             Image.asset(
            //                               Constants.userType == 'brand'
            //                                   ? CommonImage
            //                                       .funLinksStoreLinksLinks
            //                                   : "assets/images/vector.png",
            //                               height: 14,
            //                               width: 12,
            //                             )
            //                           ],
            //                         )
            //                       ],
            //                     ),
            //                     Constants.userType == 'brand'
            //                         ? Container()
            //                         : SizedBox(
            //                             width: 5,
            //                           ),
            //                     Constants.userType == 'brand'
            //                         ? Container()
            //                         : Center(
            //                             child: Container(
            //                                 width: 1,
            //                                 height: 32,
            //                                 color: Colors.black
            //                                     .withOpacity(0.25))),
            //                     Constants.userType == 'brand'
            //                         ? Container()
            //                         : SizedBox(
            //                             width: 5,
            //                           ),
            //                     Constants.userType == 'brand'
            //                         ? Container()
            //                         : Column(
            //                             //mainAxisAlignment: MainAxisAlignment.center,
            //                             children: <Widget>[
            //                               Text(
            //                                 titleWon != null
            //                                     ? titleWon
            //                                     : "",
            //                                 style: GoogleFonts.nunitoSans(
            //                                     fontWeight:
            //                                         FontWeight.bold,
            //                                     fontSize: 14,
            //                                     color: Colors.black),
            //                               ),
            //                               SizedBox(
            //                                 height: 5,
            //                               ),
            //                               Row(
            //                                 children: [
            //                                   otherPofileprovider.profileFameLinksList[0]
            //                                               .titlesWon
            //                                               .length ==
            //                                           0
            //                                       ? Text(
            //                                           "Contesting",
            //                                           style: GoogleFonts
            //                                               .nunitoSans(
            //                                                   fontWeight:
            //                                                       FontWeight
            //                                                           .bold,
            //                                                   fontSize:
            //                                                       14,
            //                                                   color: Colors
            //                                                       .black),
            //                                         )
            //                                       : Text(
            //                                           "Titles Won",
            //                                           style: GoogleFonts
            //                                               .nunitoSans(
            //                                                   fontWeight:
            //                                                       FontWeight
            //                                                           .bold,
            //                                                   fontSize:
            //                                                       14,
            //                                                   color: Colors
            //                                                       .black),
            //                                         ),
            //                                   SvgPicture.asset(
            //                                     "assets/icons/svg/logo_splash.svg",
            //                                     width: 12,
            //                                     height: 14,
            //                                   ),

            //                                   ///Image.asset("assets/images/logo_splash.svg",height: 14,width: 12,),
            //                                 ],
            //                               ),
            //                               InkWell(
            //                                 onTap: () {
            //                                   setState(() {
            //                                     titleWonClicked =
            //                                         !titleWonClicked;
            //                                     if (titleWonClicked ==
            //                                         true) {
            //                                       trendsSetClicked =
            //                                           false;
            //                                       yourMusicClicked =
            //                                           false;
            //                                     }
            //                                   });
            //                                 },
            //                                 child: titleWonClicked == true
            //                                     ? Icon(
            //                                         Icons
            //                                             .keyboard_arrow_up,
            //                                         color: Colors.black
            //                                             .withOpacity(
            //                                                 0.25),
            //                                       )
            //                                     : Icon(
            //                                         Icons
            //                                             .keyboard_arrow_down,
            //                                         color: Colors.black
            //                                             .withOpacity(
            //                                                 0.25),
            //                                       ),
            //                               )
            //                             ],
            //                           ),
            //                     SizedBox(
            //                       width: 5,
            //                     ),
            //                     Center(
            //                         child: Container(
            //                             width: 1,
            //                             height: 32,
            //                             color: Colors.black
            //                                 .withOpacity(0.25))),
            //                     SizedBox(
            //                       width: 5,
            //                     ),
            //                     Column(
            //                       //mainAxisAlignment: MainAxisAlignment.center,
            //                       children: [
            //                         Row(
            //                           children: [
            //                             Text(
            //                               Constants.userType == 'brand'
            //                                   ? fameLinkFun.store[0]
            //                                           .trendzsSponsored ??
            //                                       ""
            //                                   : otherPofileprovider.profileFameLinksList[0]
            //                                       .trendzSet
            //                                       .toString(),
            //                               style: GoogleFonts.nunitoSans(
            //                                   fontWeight: FontWeight.bold,
            //                                   fontSize: 14,
            //                                   color: Colors.black),
            //                             ),
            //                             Image.asset(
            //                               "assets/images/trendz.png",
            //                               height: 14,
            //                               width: 14,
            //                             )
            //                           ],
            //                         ),
            //                         SizedBox(
            //                           height: 2,
            //                         ),
            //                         Text(
            //                           Constants.userType == 'brand'
            //                               ? 'Trendz Sponsored'
            //                               : "Trendz Set",
            //                           style: GoogleFonts.nunitoSans(
            //                               fontWeight: FontWeight.bold,
            //                               fontSize: 14,
            //                               color: Colors.black),
            //                           overflow: TextOverflow.ellipsis,
            //                         ),
            //                         InkWell(
            //                           onTap: () {
            //                             setState(() {
            //                               trendsSetClicked =
            //                                   !trendsSetClicked;
            //                               if (trendsSetClicked == true) {
            //                                 titleWonClicked = false;
            //                                 yourMusicClicked = false;
            //                               }
            //                             });
            //                           },
            //                           child: trendsSetClicked == true
            //                               ? Icon(
            //                                   Icons.keyboard_arrow_up,
            //                                   color: Colors.black
            //                                       .withOpacity(0.25),
            //                                 )
            //                               : Icon(
            //                                   Icons.keyboard_arrow_down,
            //                                   color: Colors.black
            //                                       .withOpacity(0.25),
            //                                 ),
            //                         )
            //                       ],
            //                     ),
            //                     Constants.userType != 'brand'
            //                         ? Container()
            //                         : SizedBox(
            //                             width: 5,
            //                           ),
            //                     Constants.userType != 'brand'
            //                         ? Container()
            //                         : Center(
            //                             child: Container(
            //                                 width: 1,
            //                                 height: 32,
            //                                 color: Colors.black
            //                                     .withOpacity(0.25))),
            //                     Constants.userType == 'brand'
            //                         ? Container()
            //                         : SizedBox(
            //                             width: 5,
            //                           ),
            //                     Column(
            //                       children: [
            //                         Text(
            //                           fameLinkFun.store.isNotEmpty
            //                               ? fameLinkFun.store[0]
            //                                   .products
            //                                   .length
            //                                   .toString()
            //                               : "",
            //                           style: GoogleFonts.nunitoSans(
            //                               fontWeight: FontWeight.bold,
            //                               fontSize: 14,
            //                               color: Colors.black),
            //                         ),
            //                         Text(
            //                           'products',
            //                           style: GoogleFonts.nunitoSans(
            //                               fontWeight: FontWeight.bold,
            //                               fontSize: Constants.userType ==
            //                                           'brand' ||
            //                                       Constants.userType ==
            //                                           'agency'
            //                                   ? 12
            //                                   : 14,
            //                               color: Colors.black),
            //                           overflow: TextOverflow.ellipsis,
            //                         ),
            //                         InkWell(
            //                           onTap: () {
            //                             setState(() {
            //                               _scrollController.animateTo(
            //                                 _scrollController
            //                                     .position.maxScrollExtent,
            //                                 duration: Duration(
            //                                     milliseconds: 500),
            //                                 curve: Curves.fastOutSlowIn,
            //                               );
            //                             });
            //                           },
            //                           child: trendsSetClicked == true
            //                               ? Icon(
            //                                   Icons.keyboard_arrow_up,
            //                                   color: Colors.black
            //                                       .withOpacity(0.25),
            //                                 )
            //                               : Icon(
            //                                   Icons.keyboard_arrow_down,
            //                                   color: Colors.black
            //                                       .withOpacity(0.25),
            //                                 ),
            //                         )
            //                       ],
            //                     ),
            //                     SizedBox(
            //                       width: 8,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           )
            //         : Container(
            //             height: 80,
            //           ),
            //   ),
            // ),
            otherPofileprovider.profileFameLinksList.length != 0 &&
                    fameLinkFun.titleWonClicked == true
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: otherPofileprovider
                        .profileFameLinksList[0].titlesWon!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${otherPofileprovider.profileFameLinksList[0].titlesWon![index].title} -",
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${otherPofileprovider.profileFameLinksList[0].titlesWon![index].season} -",
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${otherPofileprovider.profileFameLinksList[0].titlesWon![index].year} -",
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "[${otherPofileprovider.profileFameLinksList[0].titlesWon![index].title}]",
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Container(),
            otherPofileprovider.profileFameLinksList.length != 0 &&
                    fameLinkFun.trendsSetClicked == true
                ? ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: otherPofileprovider
                        .profileFameLinksList[0].trendsWon!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 66,
                                width: 66,
                                child: otherPofileprovider
                                            .profileFameLinksList[0]
                                            .trendsWon![index]
                                            .media!
                                            .length !=
                                        0
                                    ? Image.network(
                                        "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${otherPofileprovider.profileFameLinksList[0].trendsWon![index].media![0].closeUp}",
                                        fit: BoxFit.fill,
                                      )
                                    : Text("")),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${otherPofileprovider.profileFameLinksList[0].trendsWon![index].hashTag}",
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  height: 28,
                                  // width: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: HexColor("#FF5C28"))),
                                  padding: EdgeInsets.only(
                                      left: 6, right: 6, top: 2, bottom: 2),
                                  child: Text(
                                    "${otherPofileprovider.profileFameLinksList[0].trendsWon![index].position},${otherPofileprovider.profileFameLinksList[0].trendsWon![index].totalHearts}",
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Participated by${otherPofileprovider.profileFameLinksList[0].trendsWon![index].totalParticipants}, ${otherPofileprovider.profileFameLinksList[0].trendsWon![index].totalPost} posts",
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "${otherPofileprovider.profileFameLinksList[0].trendsWon![index].reward![0].giftName}",
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  )
                : Container(),
            SizedBox(
              height: (ScreenUtil().screenHeight * 0.02).ceilToDouble(),
            ),
            Visibility(
                visible: (otherPofileprovider.selectPhase == 0),
                child: Constants.userType == 'brand'
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          bottom: 8.0,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IntrinsicWidth(
                                  child: Column(
                                    children: [
                                      Text(
                                          otherPofileprovider!
                                                      .upperProfileData !=
                                                  null
                                              ? "${otherPofileprovider!.upperProfileData!.profession != null ? '${otherPofileprovider!.upperProfileData!.profession}' : ''}"
                                              : "",
                                          style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(14),
                                              fontWeight: FontWeight.w800,
                                              color: black)),
                                      SizedBox(height: 2.h),
                                      Container(
                                        height: 1.h,
                                        color: Color(0xffFF5C28),
                                      )
                                    ],
                                  ),
                                ),
                                Spacer(),
                                IntrinsicWidth(
                                  child: Column(
                                    children: [
                                      Visibility(
                                        visible: otherPofileprovider!
                                                        .upperProfileData !=
                                                    null &&
                                                otherPofileprovider!
                                                        .upperProfileData!
                                                        .brand !=
                                                    null
                                            ? otherPofileprovider!
                                                .upperProfileData!
                                                .brand!
                                                .websiteUrl!
                                                .isNotEmpty
                                            : false,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(4)),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  "assets/icons/svg/link_icon.svg",
                                                  color: Colors.blue),
                                              SizedBox(
                                                width: ScreenUtil().setSp(6),
                                              ),
                                              Text(
                                                  otherPofileprovider!
                                                                  .upperProfileData !=
                                                              null &&
                                                          otherPofileprovider!
                                                                  .upperProfileData!
                                                                  .brand !=
                                                              null
                                                      ? otherPofileprovider!
                                                          .upperProfileData!
                                                          .brand!
                                                          .websiteUrl!
                                                      : "",
                                                  style: GoogleFonts.nunitoSans(
                                                      fontSize: ScreenUtil()
                                                          .setSp(12),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: black)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Container(
                                        height: 1.h,
                                        color: Color(0xff0060FF),
                                      )
                                    ],
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Constants.userType == 'brand'
                                ? Container(
                                    child: ReadMoreText(
                                      '${otherPofileprovider!.upperProfileData != null ? otherPofileprovider!.upperProfileData!.bio : ""}',
                                      trimLines: 3,
                                      trimMode: TrimMode.Line,
                                      colorClickableText: lightGray,
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(14),
                                          fontWeight: FontWeight.w400,
                                          color: black),
                                    ),
                                  )
                                : Container(),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      )
                    :
                    // : otherPofileprovider.profileFameLinksList.length != 0
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                //            ?
                                IntrinsicWidth(
                                  child: Column(
                                    children: [
                                      Text(
                                          otherPofileprovider
                                                          .profileFameLinksList
                                                          .length !=
                                                      0 &&
                                                  otherPofileprovider
                                                          .profileFameLinksList[
                                                              0]
                                                          .profession !=
                                                      null
                                              ? otherPofileprovider
                                                          .profileFameLinksList[
                                                              0]
                                                          .profession ==
                                                      ""
                                                  ? ""
                                                  : "${otherPofileprovider.profileFameLinksList[0].profession![0].toUpperCase() + otherPofileprovider.profileFameLinksList[0].profession!.substring(1)}: "
                                              : "",
                                          style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 14,
                                            color: Colors.black,
                                          )),
                                      SizedBox(height: 2.h),
                                      Container(
                                        height: 1.h,
                                        color: Color(0xffFF5C28),
                                      )
                                    ],
                                  ),
                                )
                                //: Container()
                                ,
                                SizedBox(
                                  width: 5.w,
                                ),

                                //     ?
                                IntrinsicWidth(
                                  child: Column(
                                    children: [
                                      Visibility(
                                          child: Container(
                                        margin: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(2)),
                                        child: Text(
                                            otherPofileprovider
                                                        .profileFameLinksList
                                                        .isNotEmpty &&
                                                    otherPofileprovider
                                                            .profileFameLinksList[
                                                                0]
                                                            .ambassador!
                                                            .length !=
                                                        0
                                                ? "${otherPofileprovider.profileFameLinksList[0].ambassador![0].title}"
                                                : "",
                                            style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: Colors.black,
                                            )),
                                      )),
                                      SizedBox(height: 3.h),
                                      Container(
                                        height: 1.h,
                                        color: Color(0xff0060FF),
                                      )
                                    ],
                                  ),
                                )
                                //: Container()
                                ,
                              ],
                            ),
                            SizedBox(height: 5.h),
                            otherPofileprovider
                                        .profileFameLinksList.isNotEmpty &&
                                    otherPofileprovider
                                            .profileFameLinksList[0].bio ==
                                        null
                                ? Container()
                                : Container(
                                    child: ReadMoreText(
                                      otherPofileprovider
                                              .profileFameLinksList.isNotEmpty
                                          ? otherPofileprovider
                                              .profileFameLinksList[0].bio!
                                          : "",
                                      trimLines: 3,
                                      trimMode: TrimMode.Line,
                                      colorClickableText: lightGray,
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(14),
                                          fontWeight: FontWeight.w400,
                                          color: black),
                                    ),
                                  ),
                          ],
                        ),
                      )
                // : Container()
                ),
            Constants.userType == 'brand'
                ? (otherPofileprovider!.myStoreResult.length != 0)
                    ? Container(
                        color: Colors.transparent,
                        height: 100.h,
                        child: Column(
                          children: <Widget>[
                            // Name Field
                            Padding(
                              padding: EdgeInsets.only(left: 12.0, right: 12.0),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Stack(
                                        //overflow: Overflow.visible,
                                        children: <Widget>[
                                          Container(
                                            width: ScreenUtil().screenWidth,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(CommonImage
                                                    .bottom_shape_container),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            padding: EdgeInsets.only(
                                                top: 5.0,
                                                left: 3.0,
                                                right: 8.0,
                                                bottom: 8.0),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Row(children: [
                                                      SizedBox(
                                                        width: 8.0,
                                                      ),
                                                      otherPofileprovider!
                                                                  .myStoreResult
                                                                  .length !=
                                                              0
                                                          ? otherPofileprovider!
                                                                      .myStoreResult[
                                                                          0]
                                                                      .user![0]
                                                                      .profileImageType ==
                                                                  ""
                                                              ? otherPofileprovider!
                                                                          .avtarImage !=
                                                                      null
                                                                  ? Container(
                                                                      height:
                                                                          30,
                                                                      width: 30,
                                                                      child:
                                                                          CircleAvatar(
                                                                        backgroundImage:
                                                                            NetworkImage(otherPofileprovider!.avtarImage),
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        radius:
                                                                            50,
                                                                      ),
                                                                    )
                                                                  : otherPofileprovider!
                                                                              .profileImage !=
                                                                          null
                                                                      ? Container(
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              30,
                                                                          child:
                                                                              CircleAvatar(
                                                                            backgroundImage:
                                                                                NetworkImage(otherPofileprovider!.profileImage),
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            radius:
                                                                                50,
                                                                          ),
                                                                        )
                                                                      : otherPofileprovider!.myStoreResult[0].user![0].name ==
                                                                              null
                                                                          ? Container(
                                                                              height: 30.h,
                                                                              width: 30.w,
                                                                              decoration: BoxDecoration(
                                                                                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                                  lightRedWhite,
                                                                                  lightRed
                                                                                ]),
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                            )
                                                                          : Container(
                                                                              height: 30.h,
                                                                              width: 30.w,
                                                                              decoration: BoxDecoration(
                                                                                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                                  lightRedWhite,
                                                                                  lightRed
                                                                                ]),
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  otherPofileprovider!.myStoreResult[0].user![0].name![0].toString().toUpperCase(),
                                                                                  textAlign: TextAlign.center,
                                                                                  style: GoogleFonts.nunitoSans(
                                                                                    fontWeight: FontWeight.w700,
                                                                                    color: black,
                                                                                    fontSize: ScreenUtil().setSp(30),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                              : Container(
                                                                  height: 30,
                                                                  width: 30,
                                                                  child: otherPofileprovider!
                                                                              .myStoreResult[0]
                                                                              .user![0]
                                                                              .profileImageType ==
                                                                          "avatar"
                                                                      ? CircleAvatar(
                                                                          backgroundImage:
                                                                              NetworkImage("${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${otherPofileprovider!.myStoreResult[0].user![0].profileImage}"),
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          radius:
                                                                              50,
                                                                        )
                                                                      : CircleAvatar(
                                                                          backgroundImage:
                                                                              NetworkImage("${ApiProvider.profile}/${otherPofileprovider!.myStoreResult[0].user![0].profileImage}"),
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          radius:
                                                                              50,
                                                                        ))
                                                          : Container(),
                                                      SizedBox(
                                                        width: 8.0,
                                                      ),
                                                      otherPofileprovider!
                                                                  .myStoreResult[
                                                                      0]
                                                                  .user![0] !=
                                                              null
                                                          ? Text(
                                                              otherPofileprovider!
                                                                      .myStoreResult[
                                                                          0]
                                                                      .user![0]
                                                                      .name ??
                                                                  otherPofileprovider!
                                                                      .myStoreResult[
                                                                          0]
                                                                      .user![0]
                                                                      .username!,
                                                              style: GoogleFonts
                                                                  .nunitoSans(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: HexColor(
                                                                    "#030C23"),
                                                              ),
                                                            )
                                                          : Container(),
                                                    ]),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 4.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 9.0),
                                                  child: Divider(
                                                    height: 1,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 7.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 9.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Row(children: [
                                                        SizedBox(
                                                          width: ScreenUtil()
                                                                  .screenWidth *
                                                              0.50,
                                                          child: Text(
                                                            "${otherPofileprovider!.myStoreResult[0].district},${otherPofileprovider!.myStoreResult[0].state},${otherPofileprovider!.myStoreResult[0].country}",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        )
                                                      ]),

                                                      //
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 7.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: 110,
                      )
                :
                // : otherPofileprovider.profileFameLinksList.length != 0
                Container(
                    color: Colors.transparent,
                    height: 110,
                    child: Column(
                      children: <Widget>[
                        // Name Field
                        Padding(
                          padding: EdgeInsets.only(left: 12.0, right: 12.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Stack(
                                    //overflow: Overflow.visible,
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().screenWidth,
                                        decoration: new BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            new BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              blurRadius: 1.0,
                                            ),
                                          ],
                                        ),
                                        // padding: EdgeInsets.only(
                                        //     top: 5.0,
                                        //     left: 3.0,
                                        //     right: 8.0,
                                        //     bottom: 8.0),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          shadowColor: Colors.grey,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                left: 3.0,
                                                right: 8.0,
                                                bottom: 0.0),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Row(children: [
                                                      SizedBox(
                                                        width: 8.0,
                                                      ),
                                                      otherPofileprovider
                                                                  .profileFameLinksList
                                                                  .isNotEmpty &&
                                                              otherPofileprovider
                                                                      .profileFameLinksList[
                                                                          0]
                                                                      .profileImageType ==
                                                                  "image"
                                                          ? CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${otherPofileprovider.profileFameLinksList[0].profileImage}"),
                                                              radius: 15,
                                                            )
                                                          : CircleAvatar(
                                                              // backgroundImage:
                                                              //     NetworkImage("${ApiProvider.s3UrlPath}${ApiProvider.avatar}/${otherPofileprovider.profileFameLinksList[0].profileImage}"),
                                                              radius: 15,
                                                            ),
                                                      SizedBox(
                                                        width: 8.0,
                                                      ),
                                                      otherPofileprovider
                                                                  .profileFameLinksList
                                                                  .length ==
                                                              0
                                                          ? Container()
                                                          : Text(
                                                              otherPofileprovider
                                                                      .profileFameLinksList[
                                                                          0]
                                                                      .name ??
                                                                  "UserName",
                                                              style: GoogleFonts
                                                                  .nunitoSans(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                    ]),
                                                    otherPofileprovider
                                                                .profileFameLinksList
                                                                .isNotEmpty &&
                                                            otherPofileprovider!
                                                                    .followStatus ==
                                                                "Following"
                                                        ? InkWell(
                                                            onTap: () {
                                                              otherPofileprovider!
                                                                  .getUnFollowFameStatus(
                                                                      id!)
                                                                  .then((value) =>
                                                                      fameLinksProvider
                                                                          .getUnFollowStatus(
                                                                              id!));
                                                            },
                                                            child: Container(
                                                                height: ScreenUtil()
                                                                    .setHeight(
                                                                        23),
                                                                width:
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            81),
                                                                padding:
                                                                    EdgeInsets.only(
                                                                        left:
                                                                            6.0,
                                                                        right:
                                                                            6.0,
                                                                        top:
                                                                            2.0,
                                                                        bottom:
                                                                            2.0),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        border:
                                                                            GradientBoxBorder(
                                                                                gradient: LinearGradient(
                                                                                    colors: [
                                                                              HexColor('#FFA88C'),
                                                                              HexColor('#FF5c28'),
                                                                            ])),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                4),
                                                                        color: Colors
                                                                            .transparent),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  'Following',
                                                                  //Following
                                                                  style: GoogleFonts
                                                                      .nunitoSans(
                                                                    fontSize:
                                                                        14,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                )),
                                                          )
                                                        : InkWell(
                                                            onTap: () {
                                                              otherPofileprovider!
                                                                  .getFollowFameStatus(
                                                                      id!)
                                                                  .then((value) =>
                                                                      fameLinksProvider
                                                                          .getFollowStatus(
                                                                              id!));
                                                            },
                                                            child: Container(
                                                                height: ScreenUtil()
                                                                    .setHeight(
                                                                        23),
                                                                width:
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            81),
                                                                padding:
                                                                    EdgeInsets.only(
                                                                        left:
                                                                            6.0,
                                                                        right:
                                                                            6.0,
                                                                        top:
                                                                            2.0,
                                                                        bottom:
                                                                            2.0),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        border:
                                                                            GradientBoxBorder(
                                                                                gradient: LinearGradient(
                                                                                    colors: [
                                                                              HexColor('#FFA88C'),
                                                                              HexColor('#FF5c28'),
                                                                            ])),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                4),
                                                                        color: Colors
                                                                            .transparent),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  'Follow',
                                                                  //followStatus  Follow
                                                                  style: GoogleFonts
                                                                      .nunitoSans(
                                                                    fontSize:
                                                                        14,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                )),
                                                          )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 4.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 9.0),
                                                  child: Divider(
                                                    height: 1,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 7.0,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 9.0,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Row(children: [
                                                        SizedBox(
                                                          width: ScreenUtil()
                                                                  .screenWidth *
                                                              0.50,
                                                          child: Text(
                                                            otherPofileprovider
                                                                    .profileFameLinksList
                                                                    .isNotEmpty
                                                                ? "${otherPofileprovider.profileFameLinksList[0].masterUser!.district ?? '---'},${otherPofileprovider.profileFameLinksList[0].masterUser!.state ?? '---'},${otherPofileprovider.profileFameLinksList[0].masterUser!.country ?? '---'}"
                                                                : "",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        ),
                                                      ]),
                                                      Row(children: [
                                                        SizedBox(
                                                          height: 16.0,
                                                          width: 16.0,
                                                          child: Image.asset(
                                                            CommonImage
                                                                .funLinksStoreCoinsIcon,
                                                            height: 15.68,
                                                            width: 21.33,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        Text(
                                                          otherPofileprovider
                                                                  .profileFameLinksList
                                                                  .isNotEmpty
                                                              ? otherPofileprovider
                                                                  .profileFameLinksList[
                                                                      0]
                                                                  .masterUser!
                                                                  .fameCoins
                                                                  .toString()
                                                              : "",
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ]),

                                                      //
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 7.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
            // : Container()
            ,
            Container(
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  // Name Field
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                isshow != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, left: 62),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: InkWell(
                                                onTap: () async {
                                                  print("Open drower");
                                                  final fameLinkFun =
                                                      Provider.of<FameLinkFun>(
                                                          context,
                                                          listen: false);
                                                  fameLinkFun.therprofiledrower(
                                                      fameLinkFun.isdrower);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/svg/settings.svg",
                                                      width: 27.78,
                                                      height: 25,
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(width: 6),
                                                    Text('Settings',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            SizedBox(height: 20),

                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: InkWell(
                                                onTap: () {
                                                  String? name =
                                                      "otherprofilefame";

                                                  Sharedynamic.shareprofile(
                                                      otherPofileprovider
                                                          .profileFameLinksList[
                                                              0]
                                                          .masterUser!
                                                          .sId!,
                                                      name,
                                                      otherPofileprovider
                                                          .profileFameLinksList[
                                                              0]
                                                          .name!
                                                          .toString());
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        "assets/icons/svg/share.svg",
                                                        width: 23.78,
                                                        height: 23,
                                                        color: Colors.black),
                                                    SizedBox(width: 6),
                                                    Text('Share',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            //SizedBox(height: 20),

                                            SizedBox(height: 20),

                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      var valu;

                                                      if (fameLinkFun
                                                              .selectPhase ==
                                                          0) {
                                                        valu = "contest";
                                                      }
                                                      if (fameLinkFun
                                                              .selectPhase ==
                                                          1) {
                                                        valu = "funlinks";
                                                      } else if (fameLinkFun
                                                              .selectPhase ==
                                                          2) {
                                                        valu = "followlinks";
                                                      }
                                                      print(
                                                          "say hi video  $valu");
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              SayHiFirstVideo(
                                                            links: valu,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                            CommonImage.scan,
                                                            fit: BoxFit.fill,
                                                            color:
                                                                Colors.black),
                                                        SizedBox(width: 6),
                                                        Text(
                                                          "Say Hi...  ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, left: 62),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: InkWell(
                                                onTap: () {
                                                  showReferralCodeDialogs(
                                                      otherPofileprovider
                                                          .profileFameLinksList[
                                                              0]
                                                          .masterUser!
                                                          .fameCoins!,
                                                      context);
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        "assets/icons/svg/gift1.svg",
                                                        width: 25,
                                                        height: 25,
                                                        color: Colors.black),
                                                    SizedBox(height: 6),
                                                    Text('Send Gift',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 50),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: InkWell(
                                                onTap: () async {
                                                  // sdadsad
                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  String? id =
                                                      prefs.getString("id");
                                                  // print(otherPofileprovider.profileFameLinksList[0]
                                                  //     .masterUser!
                                                  //     .sId);
                                                  //if(otherPofileprovider.profileFameLinksList[0].profileImage == "image"){
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => ChattingScreen(
                                                              otherPofileprovider
                                                                  .profileFameLinksList[
                                                                      0]
                                                                  .name!,
                                                              "${otherPofileprovider.profileFameLinksList[0].profileImage}",
                                                              otherPofileprovider
                                                                  .profileFameLinksList[
                                                                      0]
                                                                  .masterUser!
                                                                  .sId!,
                                                              "individual",
                                                              otherPofileprovider
                                                                      .profileFameLinksList[
                                                                          0]
                                                                      .sId ??
                                                                  "",
                                                              false)));
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/svg/Send1.svg",
                                                      width: 27.78,
                                                      height: 25,
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(height: 6),
                                                    Text('Message',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                InkWell(
                                  onTap: () async {
                                    if (Constants.userType == 'brand') {
                                      if (otherPofileprovider!
                                              .myStoreResult.length !=
                                          0) {
                                        if (otherPofileprovider!
                                                .myStoreResult[0]
                                                .user![0]
                                                .profileImageType ==
                                            '') {
                                          if (otherPofileprovider!.avtarImage !=
                                                  null &&
                                              otherPofileprovider!
                                                      .profileImage !=
                                                  null) {
                                            showDialog(
                                                context: context,
                                                barrierColor: Colors.black
                                                    .withOpacity(0.5),
                                                // Background color
                                                // barrierDismissible: false,
                                                builder: (BuildContext
                                                    buildContext) {
                                                  return Container(
                                                      // height: MediaQuery.of(context).size.height,
                                                      // width: MediaQuery.of(context).size.width,
                                                      child: Center(
                                                    child: Container(
                                                      height: 296.h,
                                                      width: 296.w,
                                                      margin: EdgeInsets.only(
                                                          top: 29.h,
                                                          right: 10.w,
                                                          left: 10.w),
                                                      decoration: BoxDecoration(
                                                          color: otherPofileprovider!
                                                                      .avtarImage !=
                                                                  null
                                                              ? Colors.black
                                                              : Colors
                                                                  .transparent,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.r)),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.r),
                                                        child: otherPofileprovider!
                                                                    .avtarImage !=
                                                                null
                                                            ? Image.network(
                                                                otherPofileprovider!
                                                                    .avtarImage,
                                                                fit: BoxFit
                                                                    .cover)
                                                            : otherPofileprovider!
                                                                        .profileImage !=
                                                                    null
                                                                ? Image.network(
                                                                    otherPofileprovider!
                                                                        .profileImage,
                                                                    fit: BoxFit
                                                                        .cover)
                                                                : Container(),
                                                      ),
                                                    ),
                                                  ));
                                                });
                                          }
                                        } else {
                                          if (otherPofileprovider!
                                                      .myStoreResult[0]
                                                      .user![0]
                                                      .profileImageType ==
                                                  'avatar' ||
                                              otherPofileprovider!
                                                      .myStoreResult[0]
                                                      .user![0]
                                                      .profileImageType ==
                                                  'image') {
                                            showDialog(
                                                context: context,
                                                barrierColor: Colors.black
                                                    .withOpacity(0.5),
                                                // Background color
                                                // barrierDismissible: false,
                                                builder: (BuildContext
                                                    buildContext) {
                                                  return Container(
                                                    // height: MediaQuery.of(context).size.height,
                                                    // width: MediaQuery.of(context).size.width,
                                                    child: Center(
                                                      child: Container(
                                                        height: 296.h,
                                                        width: 296.w,
                                                        margin: EdgeInsets.only(
                                                            top: 29.h,
                                                            right: 10.w,
                                                            left: 10.w),
                                                        decoration: BoxDecoration(
                                                            color: otherPofileprovider!
                                                                        .myStoreResult[
                                                                            0]
                                                                        .user![
                                                                            0]
                                                                        .profileImageType ==
                                                                    "avatar"
                                                                ? Colors.black
                                                                : Colors
                                                                    .transparent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.r)),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.r),
                                                          child: otherPofileprovider!.profileImage !=
                                                                  null
                                                              ? Image.network(
                                                                  otherPofileprovider!
                                                                      .profileImage,
                                                                  fit: BoxFit
                                                                      .cover)
                                                              : otherPofileprovider
                                                                          .profileFameLinksList[
                                                                              0]
                                                                          .profileImageType ==
                                                                      "avatar"
                                                                  ? Image.network(
                                                                      "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${otherPofileprovider.profileFameLinksList[0].profileImage}",
                                                                      fit: BoxFit
                                                                          .cover)
                                                                  : otherPofileprovider.profileFameLinksList[0].profileImageType ==
                                                                          "image"
                                                                      ? Image.network(
                                                                          "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${otherPofileprovider.profileFameLinksList[0].profileImage}",
                                                                          fit: BoxFit
                                                                              .cover)
                                                                      : Container(),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          }
                                        }
                                      }
                                    } else {
                                      otherPofileprovider
                                                  .profileFameLinksList[0]
                                                  .profileImage ==
                                              null
                                          ? Container()
                                          : showDialog(
                                              context: context,
                                              barrierColor:
                                                  Colors.black.withOpacity(0.5),
                                              // Background color
                                              builder:
                                                  (BuildContext buildContext) {
                                                return Container(
                                                    child: Center(
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        height: 296.h,
                                                        width: 296.w,
                                                        margin: EdgeInsets.only(
                                                            top: 29.h,
                                                            right: 10.w,
                                                            left: 10.w),
                                                        decoration: BoxDecoration(
                                                            color: otherPofileprovider
                                                                        .profileFameLinksList[
                                                                            0]
                                                                        .profileImageType !=
                                                                    "image"
                                                                ? Colors.black
                                                                : Colors
                                                                    .transparent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.r)),
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.r),
                                                            child: otherPofileprovider
                                                                        .profileFameLinksList[
                                                                            0]
                                                                        .profileImageType !=
                                                                    "image"
                                                                ? Image.network(
                                                                    "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${otherPofileprovider.profileFameLinksList[0].profileImage}",
                                                                    fit: BoxFit
                                                                        .cover)
                                                                : Image.network(
                                                                    "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${otherPofileprovider.profileFameLinksList[0].profileImage}",
                                                                    fit: BoxFit
                                                                        .cover)),
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                              });
                                    }
                                  },
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Visibility(
                                        visible: true,
                                        child: Container(
                                          height: h * 0.2,
                                          width: w * 0.5,
                                          child: Stack(
                                            // overflow:
                                            // Overflow.visible,
                                            fit: StackFit.loose,
                                            alignment: Alignment.center,
                                            children: <Widget>[
                                              Positioned(
                                                right: -w * 0.09,
                                                child: SizedBox(
                                                  height: h * 0.2,
                                                  width: w * 0.44,
                                                  child: SvgPicture.asset(
                                                    "assets/icons/svg/Outer Circle.svg",
                                                  ),
                                                ),
                                              ),
                                              // top Fame Links
                                              Positioned(
                                                right: -w * 0.05,
                                                top: h * 0.025,
                                                child: Container(
                                                  height: h * 0.15,
                                                  width: w * 0.25,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: GradientBoxBorder(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Color(0xFFFF4944),
                                                          Color(0xFF141070),
                                                          Color(0xFF1C126E),
                                                          Color(0xFFFF4944),
                                                          Color(0xFF0060FF),
                                                        ],
                                                        tileMode:
                                                            TileMode.decal,
                                                      ),
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: Constants.userType ==
                                                          'brand'
                                                      ? fameLinkFun.store
                                                                  .length ==
                                                              0
                                                          ? Container()
                                                          : fameLinkFun.store[0]
                                                                          .masterUser!.profileImageType !=
                                                                      null ||
                                                                  fameLinkFun
                                                                          .store[
                                                                              0]
                                                                          .masterUser!
                                                                          .profileImageType !=
                                                                      ''
                                                              ? Container(
                                                                  height:
                                                                      h * 0.5,
                                                                  width:
                                                                      w * 0.5,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    image: DecorationImage(
                                                                        image: fameLinkFun.store[0].masterUser!.profileImageType ==
                                                                                "image"
                                                                            ? NetworkImage("${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${fameLinkFun.store[0].masterUser!.profileImage}")
                                                                            : NetworkImage("${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${fameLinkFun.store[0].masterUser!.profileImage}")),
                                                                    //   backgroundColor: Colors.transparent,
                                                                    //   radius: 50.r,
                                                                  ),
                                                                )
                                                              : otherPofileprovider!.myStoreResult[0].name ==
                                                                      null
                                                                  ? Container(
                                                                      height: h *
                                                                          0.5,
                                                                      width: w *
                                                                          0.5,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        gradient: LinearGradient(
                                                                            begin:
                                                                                Alignment.topCenter,
                                                                            end: Alignment.bottomCenter,
                                                                            colors: [
                                                                              lightRedWhite,
                                                                              lightRed
                                                                            ]),
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      height: h *
                                                                          0.5,
                                                                      width: w *
                                                                          0.5,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        gradient: LinearGradient(
                                                                            begin:
                                                                                Alignment.topCenter,
                                                                            end: Alignment.bottomCenter,
                                                                            colors: [
                                                                              lightRedWhite,
                                                                              lightRed
                                                                            ]),
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          otherPofileprovider!
                                                                              .myStoreResult[0]
                                                                              .name![0]
                                                                              .toString()
                                                                              .toUpperCase(),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              GoogleFonts.nunitoSans(
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            color:
                                                                                black,
                                                                            fontSize:
                                                                                ScreenUtil().setSp(30),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                      : otherPofileprovider
                                                                  .profileFameLinksList
                                                                  .length ==
                                                              0
                                                          ? Container()
                                                          : otherPofileprovider
                                                                      .profileFameLinksList[0]
                                                                      .profileImageType !=
                                                                  null
                                                              ? Container(
                                                                  height:
                                                                      h * 0.5,
                                                                  width:
                                                                      w * 0.5,
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              3),
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundImage: otherPofileprovider.profileFameLinksList[0].profileImageType ==
                                                                            "image"
                                                                        ? NetworkImage(
                                                                            "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${otherPofileprovider.profileFameLinksList[0].profileImage}",
                                                                          )
                                                                        : NetworkImage(
                                                                            "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${otherPofileprovider.profileFameLinksList[0].profileImage}"),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    radius: 50,
                                                                  ),
                                                                )
                                                              // Container(
                                                              //                 height: 85.h,
                                                              //                 width: 85.w,
                                                              //                 decoration: BoxDecoration(
                                                              //                   shape: BoxShape.circle,
                                                              //                   image: DecorationImage(
                                                              //                       image: otherPofileprovider.profileFameLinksList[0].profileImageType == "image"
                                                              //                           ? NetworkImage(
                                                              //                               "${ApiProvider.s3UrlPath}${ApiProvider.profile}/${otherPofileprovider.profileFameLinksList[0].profileImage}",
                                                              //                             )
                                                              //                           : NetworkImage("${ApiProvider.s3UrlPath}${ApiProvider.avatar}/${otherPofileprovider.profileFameLinksList[0].profileImage}")),
                                                              //                   //   backgroundColor: Colors.transparent,
                                                              //                   //   radius: 50.r,
                                                              //                 ),
                                                              //               )
                                                              : otherPofileprovider.profileFameLinksList[0].name == null
                                                                  ? Container(
                                                                      height: h *
                                                                          0.5,
                                                                      width: w *
                                                                          0.5,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        gradient: LinearGradient(
                                                                            begin:
                                                                                Alignment.topCenter,
                                                                            end: Alignment.bottomCenter,
                                                                            colors: [
                                                                              lightRedWhite,
                                                                              lightRed
                                                                            ]),
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      height: h *
                                                                          0.125,
                                                                      width: w *
                                                                          0.23,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        gradient: LinearGradient(
                                                                            begin:
                                                                                Alignment.topCenter,
                                                                            end: Alignment.bottomCenter,
                                                                            colors: [
                                                                              lightRedWhite,
                                                                              lightRed
                                                                            ]),
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          otherPofileprovider
                                                                              .profileFameLinksList[0]
                                                                              .name![0]
                                                                              .toString()
                                                                              .toUpperCase(),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style:
                                                                              GoogleFonts.nunitoSans(
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            color:
                                                                                black,
                                                                            fontSize:
                                                                                ScreenUtil().setSp(30),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                ),
                                              ),
                                              Positioned(
                                                  top: w * 0.13,
                                                  left: w * 0.26,
                                                  bottom: w * 0.010,
                                                  right: w * 0.010,
                                                  child: Image.asset(
                                                    CommonImage.fourother,
                                                    width: 100,
                                                    height: 100,
                                                  )),
//              child: SvgPicture.asset(CommonImage.fouricon,width: 70,height: 70,color: Colors.red,)),

                                              Positioned(
                                                // top: -160.0,
                                                // left: -109.0,
                                                right: w * 0.075,
                                                top: 0,
                                                child: SizedBox(
                                                  height: 30,
                                                  width: w * 0.35,
                                                  child: InkWell(
                                                    onTap: () {
                                                      debugPrint(
                                                          "******************* Follow Links Work");
                                                      //setState(() {
                                                      otherPofileprovider
                                                          .selectPhase = 0;
                                                      //FameLinksFeedState.selectRunType = "famelinks";
                                                      //      });
                                                      // Navigator.pop(context);
                                                      // gotoProfileFameLinkScreen(context);
                                                    },
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 6.0,
                                                                    right: 6.0,
                                                                    top: 2.0,
                                                                    bottom:
                                                                        2.0),
                                                            child: Text(
                                                              Constants.userType ==
                                                                      'brand'
                                                                  ? "fameLinkFun.store"
                                                                  : "FAME",
                                                              style: GoogleFonts
                                                                  .nunitoSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5, //3
                                                        ),
                                                        darkcircleButtonImageStackwhitemode(
                                                          imgUrl: Constants
                                                                      .userType ==
                                                                  'brand'
                                                              ? "assets/icons/fameLinkFun.store.svg"
                                                              : "assets/icons/Logo.svg",
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // right: MediaQuery.of(context).size.width/2,
                                              ),

                                              // left FunLinks
                                              Positioned(
                                                right: w * 0.22, //90
                                                bottom: h * 0.085,
                                                child: SizedBox(
                                                  height: 30,
                                                  width: 40,
                                                  child: InkWell(
                                                    onTap: () {
                                                      otherPofileprovider!
                                                          .alldataclear();
                                                      // setState(() {
                                                      debugPrint(
                                                          "*************** FunLinks");
                                                      otherPofileprovider
                                                          .selectPhase = 1;
                                                      otherPofileprovider!
                                                          .getOtherUserProfileFunLinks(
                                                              id.toString(), 1);
                                                      // });
                                                    },
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 7, //5
                                                        ),
                                                        circleButtonImageStackwhitemode(
                                                          imgUrl:
                                                              "assets/icons/FunLinks2.svg",
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // right: MediaQuery.of(context).size.width/2,
                                              ),
                                              // // right FollowLinks
                                              Positioned(
                                                right: w * 0.14,
                                                //left: 20.0,
                                                bottom: h * 0.01,
                                                child: SizedBox(
                                                  height: 30,
                                                  width: 50,
                                                  child: InkWell(
                                                    onTap: () {
                                                      otherPofileprovider!
                                                          .alldataclear();

                                                      //    setState(() {
                                                      debugPrint(
                                                          "*************** FollowLink *************");
                                                      otherPofileprovider
                                                          .selectPhase = 2;
                                                      otherPofileprovider!
                                                          .getOtherUserProfileFollowLinks(
                                                              id.toString(), 1);
                                                      //  });
                                                    },
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            otherPofileprovider!
                                                                .alldataclear();
                                                            // setState(() {
                                                            debugPrint(
                                                                "*************** FollowLink-1-1--1-1-");
                                                            otherPofileprovider
                                                                .selectPhase = 2;
                                                            otherPofileprovider!
                                                                .getOtherUserProfileFollowLinks(
                                                                    id.toString(),
                                                                    1);
                                                            // });
                                                          },
                                                          child:
                                                              circleButtonImageStackwhitemode(
                                                            imgUrl:
                                                                "assets/icons/FollowLinks2.svg",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Constants.userType == 'brand'
                                ? otherPofileprovider!.myStoreResult.isNotEmpty
                                    ? Column(
                                        children: [
                                          fameLinkFun.store != null &&
                                                  fameLinkFun.store[0]
                                                          .bannerMedia!.length >
                                                      0
                                              ? SizedBox(
                                                  height: 185.h,
                                                  width: 352.w,
                                                  child: CarouselSlider(
                                                      // itemCount: otherPofileprovider!.upperProfileData
                                                      //     .brand.bannerMedia.length,
                                                      items: fameLinkFun
                                                          .store[0].bannerMedia!
                                                          .map((item) {
                                                        return Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color:
                                                                        appBackgroundColor),
                                                            child:
                                                                Image.network(
                                                              "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/$item",
                                                              fit: BoxFit.cover,
                                                            ));
                                                      }).toList(),
                                                      options: CarouselOptions(
                                                        height: ScreenUtil()
                                                            .setSp(250),
                                                        aspectRatio: 16 / 9,
                                                        viewportFraction: 1,
                                                        initialPage: 0,
                                                        enableInfiniteScroll:
                                                            false,
                                                        reverse: false,
                                                        autoPlay: false,
                                                        autoPlayInterval:
                                                            Duration(
                                                                seconds: 3),
                                                        autoPlayAnimationDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    800),
                                                        autoPlayCurve: Curves
                                                            .fastOutSlowIn,
                                                        enlargeCenterPage: true,
                                                        onPageChanged:
                                                            (index, reason) {
                                                          // setState(() {
                                                          //   // pageController = PageController(
                                                          //   //     keepPage: true,
                                                          //   //     initialPage: index);
                                                          // });
                                                        },
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                      )),
                                                )
                                              : Container(),
                                          GridView.count(
                                            crossAxisCount: 3,
                                            shrinkWrap: true,
                                            childAspectRatio:
                                                ((MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        3) /
                                                    (MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3 +
                                                        30)),
                                            padding: EdgeInsets.only(
                                                top: ScreenUtil().setSp(5),
                                                left: ScreenUtil().setSp(2.5),
                                                right: ScreenUtil().setSp(2.5)),
                                            children: List.generate(
                                                otherPofileprovider!
                                                    .myStoreResult
                                                    .length, (index) {
                                              // if(otherPofileprovider!.myStoreResult[index].images[0].type == "video"){
                                              //   print("VIDEO:::${otherPofileprovider!.myStoreResult[index].images[0].type}");
                                              //   downloadFile(otherPofileprovider!.myStoreResult[index].images[0].path);
                                              // }
                                              var size =
                                                  MediaQuery.of(context).size;
                                              final double itemWidth =
                                                  size.width / 3;
                                              final double itemHeight =
                                                  itemWidth + 30;
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (ontext) =>
                                                            BrandDetailsScreen(
                                                                otherPofileprovider!
                                                                    .myStoreResult
                                                                    .elementAt(
                                                                        index),
                                                                index,
                                                                otherPofileprovider!
                                                                    .page,
                                                                "",
                                                                "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}",
                                                                true)),
                                                  );
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom:
                                                          ScreenUtil().setSp(5),
                                                      left: ScreenUtil()
                                                          .setSp(2.5),
                                                      right: ScreenUtil()
                                                          .setSp(2.5)),
                                                  child: Stack(
                                                    children: [
                                                      SizedBox(
                                                        child: otherPofileprovider!
                                                                        .myStoreResult[
                                                                            index]
                                                                        .images !=
                                                                    null &&
                                                                otherPofileprovider!
                                                                        .myStoreResult[
                                                                            index]
                                                                        .images!
                                                                        .length >
                                                                    0
                                                            ? otherPofileprovider!
                                                                        .myStoreResult[
                                                                            index]
                                                                        .images![
                                                                            0]
                                                                        .type ==
                                                                    "video"
                                                                ? Stack(
                                                                    children: [
                                                                      Container(
                                                                          color:
                                                                              lightGray,
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            imageUrl:
                                                                                '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${otherPofileprovider!.myStoreResult[index].images![0].path}-sm',
                                                                            errorWidget: (context, url, error) =>
                                                                                Icon(Icons.error, color: white),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            width:
                                                                                itemWidth,
                                                                            height:
                                                                                itemHeight,
                                                                          )),
                                                                      Center(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              ScreenUtil().setHeight(32.94),
                                                                          width:
                                                                              ScreenUtil().setWidth(40),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white.withOpacity(0.5),
                                                                              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().radius(5)))),
                                                                          child:
                                                                              Icon(
                                                                            Icons.play_arrow,
                                                                            color:
                                                                                black,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                : Container(
                                                                    color:
                                                                        lightGray,
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      imageUrl:
                                                                          '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${otherPofileprovider!.myStoreResult[index].images![0].path}-sm',
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          Icon(
                                                                              Icons.error,
                                                                              color: white),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      width:
                                                                          itemWidth,
                                                                      height:
                                                                          itemHeight,
                                                                    ),
                                                                  )
                                                            : Container(
                                                                color:
                                                                    lightGray,
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl:
                                                                      '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/sm',
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Icon(
                                                                          Icons
                                                                              .error,
                                                                          color:
                                                                              white),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  width:
                                                                      itemWidth,
                                                                  height:
                                                                      itemHeight,
                                                                ),
                                                              ),
                                                      ),
                                                      Padding(
                                                        child: Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                  otherPofileprovider!
                                                                      .myStoreResult[
                                                                          index]
                                                                      .images!
                                                                      .length
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          11)),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Image.asset(
                                                                  "assets/images/multiple_img.png",
                                                                  color: Colors
                                                                      .white),
                                                            ],
                                                          ),
                                                        ),
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 7,
                                                                bottom: 3),
                                                      )
                                                    ],
                                                  ),
                                                  color: Colors.blue,
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      )
                                    : Center(
                                        child: Text("No FameLinks Found",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500)),
                                      )
                                : otherPofileprovider
                                            .profileFameLinksList.length !=
                                        0
                                    ? Visibility(
                                        visible: true,
                                        child: SizedBox(
                                            width: ScreenUtil().screenWidth,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10, top: 10),
                                              child: GridView.builder(
                                                padding: EdgeInsets.all(0.0),
                                                primary: false,
                                                scrollDirection: Axis.vertical,
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  crossAxisSpacing: 8,
                                                  mainAxisSpacing: 8,
                                                ),
                                                itemCount: otherPofileprovider
                                                    .userPosts.length,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext ctx, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              GetParticularUserProfile(
                                                                  id: otherPofileprovider
                                                                      .profileFameLinksList[
                                                                          0]
                                                                      .sId,
                                                                  index: index),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      // height: double.infinity,
                                                      // alignment: Alignment.center,
                                                      child: otherPofileprovider
                                                                  .userPosts![
                                                                      index]
                                                                  .video !=
                                                              null
                                                          ? Stack(children: [
                                                              Container(
                                                                width: 240,
                                                                height: 110,
                                                                child: Image
                                                                    .network(
                                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${otherPofileprovider.userPosts![index].video!}",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  // height: 150.h,
                                                                  // width: 100.w,
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    Container(
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: SvgPicture
                                                                        .asset(
                                                                      'assets/icons/svg/other_profile_video_play.svg',
                                                                      height:
                                                                          40,
                                                                      width: 40,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ])
                                                          : otherPofileprovider
                                                                      .userPosts![
                                                                          index]
                                                                      .closeUp ==
                                                                  null
                                                              ? Stack(
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          240,
                                                                      height:
                                                                          110,
                                                                      child: Image
                                                                          .network(
                                                                        otherPofileprovider.userPosts![index].additional !=
                                                                                null
                                                                            ? "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${otherPofileprovider.userPosts![index].additional!}"
                                                                            : otherPofileprovider.userPosts![index].long != null
                                                                                ? "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${otherPofileprovider.userPosts![index].long!}"
                                                                                : otherPofileprovider.userPosts![index].medium != null
                                                                                    ? "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${otherPofileprovider.userPosts![index].medium!}"
                                                                                    : otherPofileprovider.userPosts![index].pose1 != null
                                                                                        ? "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${otherPofileprovider.userPosts![index].pose1!}"
                                                                                        : otherPofileprovider.userPosts![index].pose2 != null
                                                                                            ? "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${otherPofileprovider.userPosts![index].pose2!}"
                                                                                            : otherPofileprovider.userPosts![index].video != null
                                                                                                ? "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${otherPofileprovider.userPosts![index].video!}"
                                                                                                : "https://imgix.bustle.com/uploads/image/2020/8/5/23905b9c-6b8c-47fa-bc0f-434de1d7e9bf-avengers-5.jpg",
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        // height: 150.h,
                                                                        // width: 100.w,
                                                                      ),
                                                                    ),
                                                                    Visibility(
                                                                      visible: otherPofileprovider
                                                                              .userPosts![index]
                                                                              .video !=
                                                                          null,
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child: SvgPicture
                                                                            .asset(
                                                                          'assets/icons/svg/other_profile_video_play.svg',
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              40,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Image.network(
                                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${otherPofileprovider.userPosts![index].closeUp}",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  // height: 150.h,
                                                                  // width: 100.w,
                                                                ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )),
                                      )
                                    : Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void showReferralCodeDialogs(int famecoins, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return showReferralCodeDialogwhitemode(
            id: id.toString(),
          );
        });
  }
}
