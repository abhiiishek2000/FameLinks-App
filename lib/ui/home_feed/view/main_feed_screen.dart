import 'package:dotted_border/dotted_border.dart';
import 'package:famelink/common/common_image.dart';
import 'package:famelink/ui/fameLinks/provider/FameLinksFeedProvider.dart';
import 'package:famelink/ui/followLinks/provider/FollowLinksFeedProvider.dart';
import 'package:famelink/ui/followLinks/ui/FollowLinksUserProfile.dart';
import 'package:famelink/ui/funlinks/provider/FunLinksFeedProvider.dart';
import 'package:famelink/ui/home_feed/component/bud_widget.dart';
import 'package:famelink/ui/home_feed/component/explore_icon_widget.dart';
import 'package:famelink/ui/home_feed/provider/home_feed_provider.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/widgets/circle_button_image_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/routscontroll.dart';
import '../../../providers/UserProfileProvider/userProfile_provider.dart';
import '../../../share/firebasedynamiclink.dart';
import '../../../util/tour_service.dart';
import '../../../util/widgets/circle_button_image.dart';
import '../../FamelinkprofileWhitemode/ProfileFameLink.dart';
import '../../fameLinks/view/FameLinksFeed.dart';
import '../../funlinks/ui/FunLinksUserProfile.dart';
import '../component/home_feed.dart';

class MainFeedScreen extends StatefulWidget {
  MainFeedScreen({Key? key, this.initialSelect, this.id}) : super(key: key);
  ProfileType? initialSelect;
  final String? id;

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final homelinkpro = Provider.of<HomeFeedProvider>(context, listen: false);
    feedapicall();
    if (widget.initialSelect != null) {
      if (widget.initialSelect == ProfileType.FAMELinks) {
        homelinkpro.changeProfileType(ProfileType.FAMELinks);
        homelinkpro.userlocalMe();
      } else if (widget.initialSelect == ProfileType.FUNLinks) {
        homelinkpro.changeProfileType(ProfileType.FUNLinks);
        homelinkpro.userlocalMe();
      } else if (widget.initialSelect == ProfileType.FOLLOWLinks) {
        homelinkpro.changeProfileType(ProfileType.FOLLOWLinks);
        homelinkpro.userlocalMe();
      }
    } else {
      Sharedynamic().onInitDynamicLinks(context);
    }
  }

  feedapicall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("fameFeedPage");
    prefs.remove("funFeedPage");
    prefs.remove("followFeedPage");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer6<
            HomeFeedProvider,
            FameLinksFeedProvider,
            FunLinksFeedProvider,
            FollowLinksFeedProvider,
            TourService,
            UserProfileProvider>(
        builder: (context, provider, provider1, provider2, provider3, provider4,
            provider5, child) {
      return Scaffold(
        body: Stack(
          children: [
            Container(
              height: ScreenUtil().screenHeight,
              width: ScreenUtil().screenWidth,
              color: black,
              child: provider.selectedProfileType.toString() ==
                      ProfileType.FAMELinks.toString()
                  ? FameLinksFeed(id: widget.id)
                  : provider.selectedProfileType.toString() ==
                          ProfileType.FUNLinks.toString()
                      ? FunLinksUserProfile(id: widget.id)
                      : provider.selectedProfileType.toString() ==
                              ProfileType.FOLLOWLinks.toString()
                          ? FollowLinksUserProfile(id: widget.id)
                          : HomeFeed(),
            ),
            Positioned(
              bottom: 81.r,
              right: -2.0,
              child: Visibility(
                visible: (provider.isProfileUI == false),
                // visible: true,
                child: InkWell(
                  onTap: () {
                    provider.changeDialerView(true);
                  },
                  child: Row(
                    children: <Widget>[
                      CircleImageButton(
                        imgUrl: (true)
                            ? (provider.selectedProfileType.toString() ==
                                    ProfileType.FAMELinks.toString())
                                ? "assets/icons/darkFamelinkIcon.png"
                                : (provider.selectedProfileType.toString() ==
                                        ProfileType.JOBLinks.toString())
                                    ? CommonImage.dark_jobLink_icon
                                    : (provider.selectedProfileType
                                                .toString() ==
                                            ProfileType.FUNLinks.toString())
                                        ? CommonImage.dark_videoLink_icon
                                        : (provider.selectedProfileType
                                                    .toString() ==
                                                ProfileType.FOLLOWLinks
                                                    .toString())
                                            ? CommonImage.dark_follower_icon
                                            : "assets/icons/darkFamelinkIcon.png"
                            : (provider.isDarkMode == true)
                                ? "assets/icons/darkFamelinkIcon.png"
                                : "assets/icons/logo.png",
                        onTaps: () {
                          provider.changeDialerView(true);
                        },
                        isButtonSelect: true,
                      ),
                      Container(
                        height: 2.0,
                        width: 18.0,
                        color: Color(0xFF9B9B9B),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              child: Visibility(
                visible: (provider.isProfileUI == true),
                child: InkWell(
                  onTap: () {
                    provider.changeDialerView(false);
                  },
                  child: Container(
                    height: ScreenUtil().screenHeight,
                    width: ScreenUtil().screenWidth,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: (provider.isProfileUI == true),
              child: Positioned(
                bottom: 5.h,
                right: 0,
                child: Container(
                  height: 200.h,
                  width: 250.w,
                  child: Stack(
                    //overflow: Overflow.visible,
                    fit: StackFit.loose,
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        right: -50.w,
                        child: DottedBorder(
                          borderType: BorderType.Circle,
                          color: white,
                          strokeWidth: 1,
                          child: Container(
                            height: 150.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (provider.selectedProfileType ==
                                        ProfileType.FAMELinks) {
                                      provider4
                                          .checkTourShown(
                                              context, false, false, false)
                                          .then((value) {
                                        if (value) {
                                          Navigator.of(context).push(rauts()
                                              .createRoute(
                                                  ProfileFameLinkWhitemode(
                                            runSelectPhase: 0,
                                          )));
                                        }
                                      });
                                      provider.changeDialerView(false);
                                    } else if (provider.selectedProfileType ==
                                        ProfileType.JOBLinks) {
                                      Navigator.of(context).push(rauts()
                                          .createRoute(ProfileFameLinkWhitemode(
                                        runSelectPhase: 3,
                                      )));
                                      provider.changeDialerView(false);
                                    } else if (provider.selectedProfileType ==
                                        ProfileType.FUNLinks) {
                                      provider4
                                          .checkTourShown(
                                              context, false, false, false)
                                          .then((value) {
                                        if (value) {
                                          Navigator.of(context).push(rauts()
                                              .createRoute(
                                                  ProfileFameLinkWhitemode(
                                            runSelectPhase: 1,
                                          )));
                                        }
                                      });
                                      provider.changeDialerView(false);
                                    } else if (provider.selectedProfileType ==
                                        ProfileType.FOLLOWLinks) {
                                      provider4
                                          .checkTourShown(
                                              context, false, false, false)
                                          .then((value) {
                                        if (value) {
                                          Navigator.of(context).push(rauts()
                                              .createRoute(
                                                  ProfileFameLinkWhitemode(
                                            runSelectPhase: 2,
                                          )));
                                        }
                                      });

                                      provider.changeDialerView(false);
                                    } else {
                                      provider4
                                          .checkTourShown(
                                              context, false, false, false)
                                          .then((value) {
                                        if (value) {
                                          Navigator.of(context).push(rauts()
                                              .createRoute(
                                                  ProfileFameLinkWhitemode(
                                            runSelectPhase: 0,
                                          )));
                                        }
                                      });
                                      provider.changeDialerView(false);
                                    }
                                  },
                                  child: provider.selectedProfileType ==
                                          ProfileType.FAMELinks
                                      ? BudWidget(
                                          linkProfileImage:
                                              provider1.profileFameLinksImage,
                                          avtarImage: provider1.avtarImage,
                                          profileImage: provider1.profileImage,
                                          provider: provider,
                                        )
                                      : provider.selectedProfileType ==
                                              ProfileType.FUNLinks
                                          ? BudWidget(
                                              linkProfileImage: provider2
                                                  .profileFunLinksImage,
                                              avtarImage: provider2.avtarImage,
                                              provider: provider,
                                              profileImage:
                                                  provider2.profileImage,
                                            )
                                          : provider.selectedProfileType ==
                                                  ProfileType.FOLLOWLinks
                                              ? BudWidget(
                                                  linkProfileImage: provider3
                                                      .profileFollowLinksImage,
                                                  provider: provider,
                                                  avtarImage:
                                                      provider3.avtarImage,
                                                  profileImage:
                                                      provider3.profileImage,
                                                )
                                              : BudWidget(
                                                  provider: provider,
                                                  linkProfileImage: provider
                                                      .profileFameLinksImage,
                                                  avtarImage:
                                                      provider.avtarImage,
                                                  profileImage:
                                                      provider.profileImage,
                                                ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        right: 44.w,
                        top: 20.h,
                        child: InkWell(
                          onTap: () {
                            provider4
                                .checkTourShown(context, true, false, false)
                                .then((value) {
                              if (value) {
                                provider
                                    .changeProfileType(ProfileType.FAMELinks);
                                provider.changeDialerView(false);
                                provider1.getFameLinksProfileDetails();
                              }
                            });
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: (provider.selectedProfileType ==
                                        ProfileType.FAMELinks)
                                    ? BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            CommonImage.darkButtonBackIcon,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            CommonImage.secondBundleIcon,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6.0,
                                      right: 6.0,
                                      top: 2.0,
                                      bottom: 2.0),
                                  child: Text(
                                    "FameLinks",
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      color: (provider.selectedProfileType ==
                                              ProfileType.FAMELinks)
                                          ? Colors.white
                                          : HexColor("#030C23"),
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              (provider.selectedProfileType ==
                                      ProfileType.FAMELinks)
                                  ? CircleButtonImageStack(
                                      isButtonSelect: true,
                                      imgUrl: (true)
                                          ? "assets/icons/darkFamelinkIcon.png"
                                          // ignore: dead_code
                                          : (provider.isDarkMode == true)
                                              ? "assets/icons/darkFamelinkIcon.png"
                                              : "assets/icons/logo.png",
                                    )
                                  : CircleButtonImageStack(
                                      imgUrl: (provider.isDarkMode == true)
                                          ? "assets/icons/darkFamelinkIcon.png"
                                          : "assets/icons/logo.png",
                                    ),
                            ],
                          ),
                        ),
                      ),
                      // left FunLinks
                      Positioned(
                        // top: -80.0,
                        right: 82.w,
                        // left: -170.0,
                        top: 64.h,
                        child: InkWell(
                          onTap: () {
                            provider4
                                .checkTourShown(context, false, true, false)
                                .then((value) {
                              if (value) {
                                provider
                                    .changeProfileType(ProfileType.FUNLinks);
                                provider.changeDialerView(false);
                                provider2.getFunLinksProfileDetails();
                              }
                            });
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: (provider.selectedProfileType ==
                                        ProfileType.FUNLinks)
                                    ? BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            CommonImage.darkButtonBackIcon,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            CommonImage.secondBundleIcon,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6.0,
                                      right: 6.0,
                                      top: 2.0,
                                      bottom: 2.0),
                                  child: Text(
                                    "FunLinks",
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      color: (provider.selectedProfileType ==
                                              ProfileType.FUNLinks)
                                          ? Colors.white
                                          : HexColor("#030C23"),
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              (provider.selectedProfileType ==
                                      ProfileType.FUNLinks)
                                  ? CircleButtonImageStack(
                                      isButtonSelect: true,
                                      imgUrl: (true)
                                          ? CommonImage.dark_videoLink_icon
                                          // ignore: dead_code
                                          : (provider.isDarkMode == true)
                                              ? CommonImage.dark_videoLink_icon
                                              : "assets/icons/funLinks.png",
                                    )
                                  : CircleButtonImageStack(
                                      imgUrl: (provider.isDarkMode == true)
                                          ? CommonImage.dark_videoLink_icon
                                          : "assets/icons/funLinks.png",
                                    ),
                            ],
                          ),
                        ),
                        // right: MediaQuery.of(context).size.width/2,
                      ),
                      // // right FollowLinks
                      Positioned(
                        child: InkWell(
                          onTap: () {
                            provider4
                                .checkTourShown(context, false, false, true)
                                .then((value) {
                              if (value) {
                                provider
                                    .changeProfileType(ProfileType.FOLLOWLinks);
                                provider.changeDialerView(false);
                                provider3.getFollowLinksProfileDetails();
                              }
                            });
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: (provider.selectedProfileType ==
                                        ProfileType.FOLLOWLinks)
                                    ? BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            CommonImage.darkButtonBackIcon,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            CommonImage.secondBundleIcon,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6.0,
                                      right: 6.0,
                                      top: 2.0,
                                      bottom: 2.0),
                                  child: Text(
                                    "FollowLinks",
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      color: (provider.selectedProfileType ==
                                              ProfileType.FOLLOWLinks)
                                          ? Colors.white
                                          : HexColor("#030C23"),
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              (provider.selectedProfileType ==
                                      ProfileType.FOLLOWLinks)
                                  ? CircleButtonImageStack(
                                      isButtonSelect: true,
                                      imgUrl: (true)
                                          ? CommonImage.dark_follower_icon
                                          // ignore: dead_code
                                          : (provider.isDarkMode == true)
                                              ? CommonImage.dark_follower_icon
                                              : "assets/icons/followLinks.png",
                                    )
                                  : CircleButtonImageStack(
                                      imgUrl: (provider.isDarkMode == true)
                                          ? CommonImage.dark_follower_icon
                                          : "assets/icons/followLinks.png",
                                    ),
                            ],
                          ),
                        ),
                        right: 82.w,
                        // left: -170.0,
                        top: 112.h,
                      ),
                      // JobLinks
                      Positioned(
                        child: InkWell(
                          onTap: () async {
                            provider.changeProfileType(ProfileType.JOBLinks);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => BrandPage(
                            //             Constants.userType == 'agency'
                            //                 ? 'agency'
                            //                 : 'brand')));
                            provider.changeDialerView(false);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: (provider.selectedProfileType ==
                                        ProfileType.JOBLinks)
                                    ? BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            CommonImage.darkButtonBackIcon,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            CommonImage.secondBundleIcon,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6.0,
                                      right: 6.0,
                                      top: 2.0,
                                      bottom: 2.0),
                                  child: Text(
                                    "JobLinks",
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      color: (provider.selectedProfileType ==
                                              ProfileType.JOBLinks)
                                          ? Colors.white
                                          : HexColor("#030C23"),
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              (provider.selectedProfileType ==
                                      ProfileType.JOBLinks)
                                  ? CircleButtonImageStack(
                                      isButtonSelect: true,
                                      imgUrl: (true)
                                          ? CommonImage.dark_jobLink_icon
                                          // ignore: dead_code
                                          : (provider.isDarkMode == true)
                                              ? CommonImage.dark_jobLink_icon
                                              : "assets/icons/vector.png",
                                    )
                                  : CircleButtonImageStack(
                                      imgUrl: (provider.isDarkMode == true)
                                          ? CommonImage.dark_jobLink_icon
                                          : "assets/icons/vector.png",
                                    ),
                            ],
                          ),
                        ),
                        // top: 135.0,
                        right: 44.w,
                        bottom: 24.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: provider1.detailShow ||
                      provider2.detailShow ||
                      provider3.detailShow
                  ? 160.0
                  : 110.0,
              // right: 0.0,
              left: -1,
              child: provider.selectedProfileType.toString() ==
                          ProfileType.FAMELinks.toString() &&
                      provider1.feedList.isNotEmpty
                  ? provider1.feedList[provider1.getIndex].media![0].type
                              .toString() ==
                          "ads"
                      ? Container()
                      : ExploreIconWidget()
                  : provider.selectedProfileType.toString() ==
                              ProfileType.FUNLinks.toString() &&
                          provider2.funLinksList.isNotEmpty
                      ? provider2.funLinksList[provider2.getIndex].media![0]
                                  .type
                                  .toString() ==
                              "ads"
                          ? Container()
                          : ExploreIconWidget()
                      : provider.selectedProfileType.toString() ==
                                  ProfileType.FOLLOWLinks.toString() &&
                              provider3.followLinkList.isNotEmpty
                          ? provider3.followLinkList[provider3.getIndex]
                                      .media![0].type
                                      .toString() ==
                                  "ads"
                              ? Container()
                              : ExploreIconWidget()
                          : Container(),
              //
            ),
          ],
        ),
      );
    });
  }
}
