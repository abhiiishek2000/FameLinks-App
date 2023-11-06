import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/common_image.dart';
import '../../../providers/UserProfileProvider/userProfile_provider.dart';
import '../../../util/config/color.dart';
import '../function/famelinkFun.dart';

class funLinksWidgetTop extends StatelessWidget {
  const funLinksWidgetTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProfileData =
        Provider.of<UserProfileProvider>(context, listen: false);
    final fameLinkFun = Provider.of<FameLinkFun>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 11),
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: white.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color.fromRGBO(255, 255, 255, 0.6),
                  Color.fromRGBO(255, 255, 255, 0.477083),
                  Color.fromRGBO(255, 255, 255, 0.2),
                  Color.fromRGBO(255, 255, 255, 0.2),
                ])
            // color: Colors.white
            //     .withOpacity(0.25)
            ),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(12),
        //     color: Colors.white.withOpacity(0.25)),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 13,
          ),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 8,
              ),
              Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    fameLinkFun.profileFunLinksList.isNotEmpty
                        ? fameLinkFun.profileFunLinksList[0].totalLikes
                            .toString()
                        : "",
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Image.asset(
                    CommonImage.funLinksHeart,
                    height: 30,
                    width: 30,
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
                      color: Colors.white.withOpacity(0.25))),
              SizedBox(
                width: 5,
              ),
              Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    fameLinkFun.profileFunLinksList.isNotEmpty
                        ? fameLinkFun.profileFunLinksList[0].totalViews
                            .toString()
                        : "",
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        "Views",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        CommonImage.funLinksViews,
                        height: 14,
                        width: 12,
                      )
                    ],
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
                      color: Colors.white.withOpacity(0.25))),
              SizedBox(
                width: 5,
              ),
              Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    fameLinkFun.profileFunLinksList.isNotEmpty
                        ? fameLinkFun.profileFunLinksList[0].savedMusic!.length
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
                  Row(
                    children: [
                      Text(
                        "Music",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                      const SizedBox(width: 5.0),
                      Image.asset(
                        CommonImage.musicIcon,
                        height: 12,
                        width: 12,
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      //  setState(() {
                      userProfileData.changeYourMusicClicked(
                          userProfileData.getYourMusicClicked);
                      userProfileData.changeTrendsSetClicked(false);
                      userProfileData.changeTitleWonClicked(false);
                      fameLinkFun!.yourVideoClicked = false;
                      fameLinkFun!.requestClicked = false;
                      //  });
                    },
                    child: userProfileData.getYourMusicClicked == true
                        ? Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.white.withOpacity(0.25),
                          )
                        : Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white.withOpacity(0.25),
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
                      color: Colors.white.withOpacity(0.25))),
              SizedBox(
                width: 5,
              ),
              Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        fameLinkFun.profileFunLinksList.isNotEmpty
                            ? fameLinkFun.profileFunLinksList[0].posts!.length
                                .toString()
                            : "",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      const SizedBox(width: 5.0),
                      Image.asset(
                        CommonImage.funLinksVideo,
                        height: 20,
                        width: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Videos",
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  InkWell(
                    onTap: () {
                      //  setState(() {
                      fameLinkFun!.yourVideoClicked =
                          !fameLinkFun!.yourVideoClicked;
                      userProfileData.changeTrendsSetClicked(false);
                      userProfileData.changeTitleWonClicked(false);
                      userProfileData.changeYourMusicClicked(false);
                      fameLinkFun!.requestClicked = false;
                      //  });
                    },
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white.withOpacity(0.25),
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
    );
  }
}
