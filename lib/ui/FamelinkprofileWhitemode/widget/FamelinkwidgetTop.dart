import 'package:famelink/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/common_image.dart';
import '../../../providers/UserProfileProvider/userProfile_provider.dart';
import '../../../util/constants.dart';
import '../../Famelinkprofile/function/famelinkFun.dart';
import '../../latest_profile/agency_recommendation.dart';
import '../../latest_profile/collabs_click.dart';

class FamelinkwidgetTopWhitemode extends StatelessWidget {
  const FamelinkwidgetTopWhitemode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<FameLinkFun, UserProfileProvider>(
      builder: (context, provider, userProfileData, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 11),
          child: Container(
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: .50,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              shadowColor: Colors.grey,
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.grey),
              //   borderRadius: BorderRadius.circular(10),
              // ),
              // height: 80,
              // width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 13),
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Constants.userType == 'agency' ? 3 : 8,
                    ),
                    InkWell(
                      onTap: () {
                        if (Constants.userType == 'agency' &&
                            provider.collabCount != 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CollabClick(),
                            ),
                          );
                        }
                      },
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          provider.profileFameLinksModelResult.result != null
                              ? Text(
                                  provider.profileFameLinksModelResult.result!
                                              .length !=
                                          0
                                      ? provider.profileFameLinksModelResult
                                          .result![0].hearts!
                                          .toString()
                                      : "",
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black),
                                )
                              : Text(
                                  "",
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
                                    //    color: Colors.black,
                                    //    color: Colors.black,
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
                                                Constants.userType == 'agency'
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
                    InkWell(
                      onTap: () async {
                        if (Constants.userType == 'agency' &&
                            provider.collabRecommendationCount != 0) {
                          prefs = await SharedPreferences.getInstance();
                          String? _id = prefs!.getString('id');
                          await provider.getAgencyRecommendations(_id!);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AgencyRecommendation(),
                            ),
                          );
                        }
                      },
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                // provider
                                //     .profileFameLinksModelResult
                                //     .result!
                                //     .length !=
                                //     0
                                //     ? provider
                                //     .profileFameLinksModelResult
                                //     .result![0]
                                //     .score!
                                //     .toString()
                                //     : "",
                                provider.profileFameLinksList.isNotEmpty
                                    ? provider.profileFameLinksList[0].score
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
                                      color: Colors.black,
                                    )
                                  : Container()
                            ],
                          ),
                          SizedBox(
                            height: 5,
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
                                    fontSize: Constants.userType == 'brand' ||
                                            Constants.userType == 'agency'
                                        ? 12
                                        : 14,
                                    color: Colors.grey),
                              ),
                              SizedBox(
                                width: Constants.userType == 'agency' ? 0 : 5,
                              ),
                              Constants.userType == 'brand' ||
                                      Constants.userType == 'agency'
                                  ? Container()
                                  : Image.asset(
                                      "assets/images/vector.png",
                                      height: 14,
                                      width: 12,
                                      color: Colors.black,
                                    )
                            ],
                          ),
                          SizedBox(
                            height: 26,
                          ),
                        ],
                      ),
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
                            height: 32,
                            color: Colors.black.withOpacity(0.25))),
                    SizedBox(
                      width: 5,
                    ),
                    Constants.userType == 'brand' ||
                            Constants.userType == "agency"
                        ? Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 2,
                              ),
                              Row(
                                children: [
                                  Text(
                                    Constants.userType == 'brand'
                                        ? provider.store.isNotEmpty
                                            ? provider.store[0]
                                                .trendzsSponsored!.length
                                                .toString()
                                            : ""
                                        : provider.profileFameLinksModelResult
                                                .result!.isNotEmpty
                                            ? provider
                                                .profileFameLinksModelResult
                                                .result![0]
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
                                    color: Colors.black,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              provider.profileFameLinksModelResult.result!
                                              .length !=
                                          0 &&
                                      provider.profileFameLinksModelResult
                                              .result![0].trendzSet ==
                                          0
                                  ? Text(
                                      Constants.userType == 'agency'
                                          ? "Trendz Sponsored"
                                          : "Trendz Partcipating",
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Constants.userType ==
                                                      'brand' ||
                                                  Constants.userType == 'agency'
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
                                          fontSize: Constants.userType ==
                                                      'brand' ||
                                                  Constants.userType == 'agency'
                                              ? 12
                                              : 14,
                                          color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                              InkWell(
                                onTap: () {
                                  userProfileData.changeTrendsSetClicked(
                                      !userProfileData.getTrendsSetClicked);
                                  if (userProfileData.getTrendsSetClicked ==
                                      true) {
                                    userProfileData
                                        .changeTitleWonClicked(false);
                                    userProfileData
                                        .changeYourMusicClicked(false);
                                  }
                                },
                                child: userProfileData.getTrendsSetClicked ==
                                        true
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
                          )
                        : Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                provider.profileFameLinksModelResult.result !=
                                        null
                                    ? provider.profileFameLinksModelResult
                                        .result![0]!.masterUser!.continent
                                        .toString()
                                    : "",
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              provider.profileFameLinksModelResult.result!
                                              .length !=
                                          0 &&
                                      provider.profileFameLinksModelResult
                                              .result![0].titlesWon!.length !=
                                          0
                                  ? Row(
                                      children: [
                                        Text(
                                          "Titles Won",
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.grey),
                                        ),
                                        SvgPicture.asset(
                                          "assets/icons/svg/logo_splash.svg",
                                          width: 12,
                                          height: 14,
                                          // color: Colors.black,
                                        ),

                                        ///Image.asset("assets/images/logo_splash.svg",height: 14,width: 12,),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          "Titles Won",
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.grey),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Image.asset(
                                          CommonImage.dark_fameLink_icon,
                                          width: 20,
                                          height: 18,
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                              InkWell(
                                onTap: () {
                                  userProfileData.changeTitleWonClicked(
                                      !userProfileData.getTitleWonClicked);
                                  if (userProfileData.getTitleWonClicked ==
                                      true) {
                                    userProfileData
                                        .changeTrendsSetClicked(false);
                                    userProfileData
                                        .changeYourMusicClicked(false);
                                  }
                                },
                                child: userProfileData.getTitleWonClicked ==
                                        true
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
                      width: 5,
                    ),
                    Center(
                        child: Container(
                            width: 1,
                            height: 30,
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
                                  ? provider.store.isNotEmpty
                                      ? provider.store[0].products!.length
                                          .toString()
                                      : ""
                                  : provider.profileFameLinksModelResult.result!
                                          .isNotEmpty
                                      ? provider.profileFameLinksModelResult
                                          .result![0].trendzSet
                                          .toString()
                                      : "",
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Constants.userType == 'brand' ||
                                    Constants.userType == 'agency'
                                ? Container()
                                : Image.asset(
                                    "assets/images/trendz.png",
                                    height: 15,
                                    width: 14,
                                    // color: Colors.black,
                                  )
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        provider.profileFameLinksModelResult.result!.length !=
                                    0 &&
                                provider.profileFameLinksModelResult.result![0]
                                        .trendzSet ==
                                    0
                            ? Text(
                                Constants.userType == 'brand'
                                    ? 'products'
                                    : Constants.userType == 'agency'
                                        ? "Collab Posts"
                                        : "Trendz set",
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Constants.userType == 'brand' ||
                                            Constants.userType == 'agency'
                                        ? 12
                                        : 14,
                                    color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              )
                            : Text(
                                Constants.userType == 'brand'
                                    ? 'products'
                                    : Constants.userType == 'agency'
                                        ? "Collab Posts"
                                        : "Trendz Set",
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Constants.userType == 'brand' ||
                                            Constants.userType == 'agency'
                                        ? 12
                                        : 14,
                                    color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                        InkWell(
                          onTap: () {
                            //  setState(() {
                            // trendsSetClicked =
                            //     !trendsSetClicked;
                            userProfileData.changeTrendsSetClicked(false);

                            if (userProfileData.getTrendsSetClicked == true) {
                              userProfileData.changeTitleWonClicked(false);
                              userProfileData.changeYourMusicClicked(false);
                            }
                            //   });
                            if (Constants.userType == 'brand' ||
                                Constants.userType == 'agency') {
                              provider.scrollController.animateTo(
                                provider
                                    .scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn,
                              );
                            }
                          },
                          child: userProfileData.getTrendsSetClicked == true
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
        );
      },
    );
  }
}
