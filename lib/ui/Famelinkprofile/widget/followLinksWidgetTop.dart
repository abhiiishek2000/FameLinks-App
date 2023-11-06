import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../common/common_image.dart';
import '../../../providers/UserProfileProvider/userProfile_provider.dart';
import '../../../util/config/color.dart';
import '../../../util/constants.dart';
import '../../followers/follower_info_screen.dart';
import '../function/famelinkFun.dart';

class followLinksWidgetTop extends StatelessWidget {
  followLinksWidgetTop({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return Consumer2<FameLinkFun, UserProfileProvider>(
      builder: (context, fameLinkFun, userProfileData, child) {
        print(
            "othertop  ${userProfileData.otherUserProfileFollowLinksModelResult.length}");
        return Column(
          children: [
            Padding(
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FollowerInfoScreen(
                                      isFollowing: false,
                                      id: fameLinkFun
                                          .profileFollowLinksList[0]
                                          .masterUser!
                                          .id))).then((value) async {
                            if (Constants.userType == 'brand') {
                              await fameLinkFun!.getStoreLinkProfile(context);
                            } else {
                              fameLinkFun!.famePage = 0;
                              fameLinkFun!.getParticularUserProfileModel = null;
                              fameLinkFun!
                                  .getParticularUserProfileModelResultList
                                  .clear();
                              fameLinkFun!.videofameController.clear();
                              await fameLinkFun!.getFameLinkProfile(
                                  id ?? fameLinkFun!.id.toString(), context);
                              fameLinkFun!.getFameLinksFeed(
                                  fameLinkFun!.profileFameLinksModelResult
                                      .result![0].sId!,
                                  context,
                                  isPaginate: false);
                            }

                            fameLinkFun!.funPage = 0;
                            fameLinkFun!
                                .getParticularFunUserProfileModelResultList
                                .clear();
                            fameLinkFun!.videoFunController.clear();
                            await fameLinkFun!.getFunLinkProfile(
                                id ?? fameLinkFun!.id, context, 1);
                            fameLinkFun!.getFunLinkFeed(
                                fameLinkFun!.profileFunLinksList[0].sId!,
                                isPaginate: false);
                            fameLinkFun!.followPage = 0;
                            fameLinkFun!
                                .getParticularFollowUserProfileModelResultList
                                .clear();
                            fameLinkFun!.videoFollowController.clear();
                            await fameLinkFun!.getFollowLinkProfile(
                                id ?? fameLinkFun!.id, context, 1);
                            fameLinkFun!.getFollowLinkFeed(
                                fameLinkFun.profileFollowLinksList[0].sId!,
                                context,
                                isPaginate: false);
                          });
                        },
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              fameLinkFun.profileFollowLinksList.isNotEmpty
                                  ? fameLinkFun
                                      .profileFollowLinksList[0].followers
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
                            Text(
                              "Followers",
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FollowerInfoScreen(
                                      isFollowing: true,
                                      id: fameLinkFun
                                          .profileFollowLinksList[0]
                                          .masterUser!
                                          .id))).then((value) async {
                            if (Constants.userType == 'brand') {
                              await fameLinkFun!.getStoreLinkProfile(context);
                            } else {
                              fameLinkFun!.famePage = 0;
                              fameLinkFun!.getParticularUserProfileModel = null;
                              fameLinkFun!
                                  .getParticularUserProfileModelResultList
                                  .clear();
                              fameLinkFun!.videofameController.clear();
                              fameLinkFun!.getFameLinksFeed(
                                  fameLinkFun!.profileFameLinksModelResult
                                      .result![0].sId!,
                                  context,
                                  isPaginate: false);
                              await fameLinkFun!.getFameLinkProfile(
                                  id ?? fameLinkFun!.id.toString(), context);
                            }

                            fameLinkFun!.funPage = 0;
                            fameLinkFun!
                                .getParticularFunUserProfileModelResultList
                                .clear();
                            fameLinkFun!.videoFunController.clear();
                            await fameLinkFun!.getFunLinkProfile(
                                id ?? fameLinkFun!.id, context, 1);
                            fameLinkFun!.getFunLinkFeed(
                                fameLinkFun!.profileFunLinksList[0].sId!,
                                isPaginate: false);

                            fameLinkFun!.followPage = 0;
                            fameLinkFun!
                                .getParticularFollowUserProfileModelResultList
                                .clear();
                            fameLinkFun!.videoFollowController.clear();
                            await fameLinkFun!.getFollowLinkProfile(
                                id ?? fameLinkFun!.id, context, 1);
                            fameLinkFun!.getFollowLinkFeed(
                                fameLinkFun.profileFollowLinksList[0].sId!,
                                context,
                                isPaginate: false);
                          });

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => FollowingInfoScreen()));
                        },
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              fameLinkFun.profileFollowLinksList.isNotEmpty
                                  ? fameLinkFun
                                      .profileFollowLinksList[0].following
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
                            Text(
                              "Following",
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
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
                            fameLinkFun.profileFollowLinksList.isNotEmpty
                                ? fameLinkFun
                                    .profileFollowLinksList[0].requests!.length
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
                          Text(
                            "Requests",
                            style: GoogleFonts.nunitoSans(
                                fontSize: 12, color: Colors.white),
                          ),
                          InkWell(
                            onTap: () {
                              //  setState(() {
                              userProfileData.changeYourMusicClicked(
                                  !userProfileData.getYourMusicClicked);
                              fameLinkFun!.requestClicked =
                                  !fameLinkFun!.requestClicked;
                              userProfileData.changeTrendsSetClicked(false);
                              userProfileData.changeTitleWonClicked(false);
                              fameLinkFun!.yourVideoClicked = false;
                              // });
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
                      InkWell(
                        onTap: () {
                          fameLinkFun.showClub();
                        },
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              fameLinkFun.profileFollowLinksList.isNotEmpty
                                  ? fameLinkFun.profileFollowLinksList[0].club
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
                            Text(
                              "Club",
                              style: GoogleFonts.nunitoSans(
                                  fontSize: 12, color: Colors.white),
                            ),
                            fameLinkFun.clubshow
                                ? Icon(
                                    Icons.keyboard_arrow_up,
                                    color: Colors.white.withOpacity(0.25),
                                  )
                                : Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white.withOpacity(0.25),
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
                visible: fameLinkFun.clubshow,
                child: userProfileData
                            .otherUserProfileFollowLinksModelResult.length ==
                        0
                    ? Container(
                        child: Text(
                          "Not found club data",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Offers Completed:${userProfileData.otherUserProfileFollowLinksModelResult[0].offersCompleted}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(CommonImage.clubcup),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Row(
                                      children: [
                                        for (int i = 0;
                                            i <
                                                userProfileData
                                                    .otherUserProfileFollowLinksModelResult[
                                                        0]
                                                    .club!
                                                    .length;
                                            i++) ...[
                                          Text(
                                            "#${userProfileData.otherUserProfileFollowLinksModelResult[0].club![i]}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ]
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "You have 5 offers from the Rising Club.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Grab them now. ",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              SvgPicture.asset(
                                CommonImage.clubgraf,
                                width: 350.w,
                              ),
                              Positioned(
                                top: 21.w,
                                left: 28.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${userProfileData.otherUserProfileFollowLinksModelResult[0].clubDetails![0].clubName}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: userProfileData
                                                          .otherUserProfileFollowLinksModelResult[
                                                              0]
                                                          .club ==
                                                      "Bud"
                                                  ? 15
                                                  : 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 26.w,
                                        ),
                                        Text(
                                          "${userProfileData.otherUserProfileFollowLinksModelResult[0].clubDetails![1].clubName}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: userProfileData
                                                          .otherUserProfileFollowLinksModelResult[
                                                              0]
                                                          .club ==
                                                      "Rising"
                                                  ? 15
                                                  : 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Text(
                                          "${userProfileData.otherUserProfileFollowLinksModelResult[0].clubDetails![2].clubName}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: userProfileData
                                                          .otherUserProfileFollowLinksModelResult[
                                                              0]
                                                          .club ==
                                                      "Known"
                                                  ? 15
                                                  : 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          "${userProfileData.otherUserProfileFollowLinksModelResult[0].clubDetails![3].clubName}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: userProfileData
                                                          .otherUserProfileFollowLinksModelResult[
                                                              0]
                                                          .club ==
                                                      "Celebrity"
                                                  ? 15
                                                  : 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "${userProfileData.otherUserProfileFollowLinksModelResult[0].clubDetails![4].clubName}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: userProfileData
                                                          .otherUserProfileFollowLinksModelResult[
                                                              0]
                                                          .club ==
                                                      "Star"
                                                  ? 15
                                                  : 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Text(
                                          "${userProfileData.otherUserProfileFollowLinksModelResult[0].clubDetails![5].clubName}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: userProfileData
                                                          .otherUserProfileFollowLinksModelResult[
                                                              0]
                                                          .club ==
                                                      "Super Star"
                                                  ? 15
                                                  : 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
//CLubofferS
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${userProfileData.otherUserProfileFollowLinksModelResult[0].clubDetails![0].clubOffer}",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 25.w,
                                        ),
                                        Text(
                                          "${userProfileData.otherUserProfileFollowLinksModelResult[0].clubDetails![1].clubOffer}",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 19.w,
                                        ),
                                        Text(
                                          "${userProfileData.otherUserProfileFollowLinksModelResult[0].clubDetails![2].clubOffer}",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Text(
                                          "${userProfileData.otherUserProfileFollowLinksModelResult[0].clubDetails![3].clubOffer}",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "${userProfileData.otherUserProfileFollowLinksModelResult[0].clubDetails![4].clubOffer}",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        Text(
                                          "${userProfileData.otherUserProfileFollowLinksModelResult[0].clubDetails![5].clubOffer}",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 45,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 73.h,
                                left: 16.w,
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.topRight,
                                      width: double.tryParse(userProfileData
                                              .otherUserProfileFollowLinksModelResult[
                                                  0]
                                              .offersCompleted
                                              .toString()) ??
                                          0 / 15,
                                      //  height: ScreenUtil().setSp(16),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil().setSp(3))),
                                        child: LinearProgressIndicator(
                                          value: 1,
                                          minHeight: 18,
                                          //(parti)
                                          color: Colors.blue,
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.green),
                                          backgroundColor: Colors.white,
                                        ),
                                        // child: LinearPercentIndicator(
                                        //   percent: openChallenges.percentCompleted/100,
                                        //   progressColor: openChallenges.percentCompleted >=80 ?lightRed:Colors.green,
                                        //   backgroundColor: Colors.white,
                                        // ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30.0, top: 5),
                                      child: Align(
                                        child: userProfileData
                                                    .otherUserProfileFollowLinksModelResult
                                                    .length ==
                                                0
                                            ? Text("")
                                            : Text(
                                                "${userProfileData.otherUserProfileFollowLinksModelResult[0].offersCompleted.toString()}k",
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(8),
                                                    color: white)),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ))
          ],
        );
      },
    );
  }
}
