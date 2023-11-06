import 'dart:math' as math;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../common/common_image.dart';
import '../../main.dart';
import '../../networking/config.dart';
import '../../providers/UserProfileProvider/userProfile_provider.dart';
import '../../share/firebasedynamiclink.dart';
import '../../util/config/color.dart';
import '../../util/constants.dart';
import '../Famelinkprofile/function/famelinkFun.dart';
import '../Famelinkprofile/widget/circleButtonImage.dart';
import '../Famelinkprofile/widget/ProfilePicView.dart';
import '../otherUserProfile/OthersProfile.dart';
import '../profile_UI/PhotoImageScreen.dart';
import 'animationprovider.dart';

class AnimationPage extends StatefulWidget {
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with TickerProviderStateMixin {
  Animaruinprovider? pro;
  FameLinkFun? fameLinksProvider;

  @override
  void initState() {
    super.initState();

    pro = Provider.of<Animaruinprovider>(context, listen: false);
    fameLinksProvider = Provider.of<FameLinkFun>(context, listen: false);

    animationtime();

    pro!.intslize();
    if (fameLinksProvider!.selectPhase == 0) {
      pro!.a = 0;
      pro!.b = 1;
      pro!.d = 2;
      pro!.c = 3;
    } else if (fameLinksProvider!.selectPhase == 1) {
      pro!.a = 1;
      pro!.b = 2;
      pro!.d = 3;
      pro!.c = 0;
    } else if (fameLinksProvider!.selectPhase == 2) {
      pro!.a = 2;
      pro!.b = 3;
      pro!.d = 0;
      pro!.c = 1;
    } else if (fameLinksProvider!.selectPhase == 3) {
      pro!.a = 3;
      pro!.b = 0;
      pro!.d = 1;
      pro!.c = 2;
    }
  }

  animationtime() {
    pro!.animController = AnimationController(
      duration: Duration(milliseconds: pro!.antime),
      vsync: this,
    );
    pro!.animControllerbud0 = AnimationController(
      duration: Duration(milliseconds: pro!.antime),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height * 0.45.h,
      // width: MediaQuery.of(context).size.height,
      child: Center(
        child: Consumer3<FameLinkFun, UserProfileProvider, Animaruinprovider>(
          builder: (context, provider, userProfileData, animationpro, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                DottedBorder(
                  padding: EdgeInsets.all(0),
                  borderType: BorderType.Circle,
                  color: Colors.grey,
                  strokeWidth: 1.5,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: Constants.glassGradient,
                    ),
                    height: 248.h,
                    width: 248.w,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          if (provider.selectPhase == 0) {
                            if (provider
                                .profileFameLinksModelResult.result!.isEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhotoImageScreen(
                                    getRunScreen: 'editProfileImage',
                                    runtypes: provider.selectPhase.toString(),
                                  ),
                                ),
                              );
                            } else {
                              if (provider.profileFameLinksModelResult
                                      .result![0].profileImageType !=
                                  '') {
                                showDialog(
                                    context: context,
                                    barrierColor: Colors.black.withOpacity(0.5),
                                    // Background color
                                    // barrierDismissible: false,
                                    builder: (BuildContext buildContext) {
                                      return ProfilePicView(
                                        avatar:
                                            "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFameLinksModelResult.result![0].profileImage!.replaceAll('-xs', '')}",
                                        image:
                                            "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFameLinksModelResult.result![0].profileImage!.replaceAll('-xs', '')}",
                                        type: provider
                                            .profileFameLinksModelResult
                                            .result![0]
                                            .profileImageType
                                            .toString(),
                                        selectPhase: provider.selectPhase,
                                      );
                                    });
                              } else {
                                if (provider
                                        .profileFameLinksModelResult
                                        .result![0]
                                        .masterUser!
                                        .profileImageType ==
                                    '') {
                                } else {
                                  showDialog(
                                      context: context,
                                      barrierColor:
                                          Colors.black.withOpacity(0.5),
                                      // Background color
                                      // barrierDismissible: false,
                                      builder: (BuildContext buildContext) {
                                        return ProfilePicView(
                                          avatar:
                                              "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFameLinksModelResult.result![0].masterUser!.profileImage!.replaceAll('-xs', '')}",
                                          image:
                                              "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFameLinksModelResult.result![0].masterUser!.profileImage!.replaceAll('-xs', '')}",
                                          type: provider
                                              .profileFameLinksModelResult
                                              .result![0]
                                              .masterUser!
                                              .profileImageType
                                              .toString(),
                                          selectPhase: provider.selectPhase,
                                        );
                                      });
                                }
                              }
                            }
                          } else {
                            if (provider.selectPhase == 1) {
                              if (provider.profileFunLinksList.isEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PhotoImageScreen(
                                      getRunScreen: 'editProfileImage',
                                      runtypes: provider.selectPhase.toString(),
                                    ),
                                  ),
                                );
                              } else {
                                if (provider.profileFunLinksList[0]
                                        .profileImageType !=
                                    '') {
                                  showDialog(
                                      context: context,
                                      barrierColor:
                                          Colors.black.withOpacity(0.5),
                                      // Background color
                                      // barrierDismissible: false,
                                      builder: (BuildContext buildContext) {
                                        return ProfilePicView(
                                          avatar:
                                              "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFunLinksList[0].profileImage!.replaceAll('-xs', '')}",
                                          image:
                                              "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFunLinksList[0].profileImage!.replaceAll('-xs', '')}",
                                          type: provider.profileFunLinksList[0]
                                              .profileImageType
                                              .toString(),
                                          selectPhase: provider.selectPhase,
                                        );
                                      });
                                } else {
                                  if (provider.profileFunLinksList[0]
                                          .masterUser!.profileImageType ==
                                      '') {
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierColor:
                                            Colors.black.withOpacity(0.5),
                                        // Background color
                                        // barrierDismissible: false,
                                        builder: (BuildContext buildContext) {
                                          return ProfilePicView(
                                            avatar:
                                                "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFunLinksList[0].masterUser!.profileImage!.replaceAll('-xs', '')}",
                                            image:
                                                "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFunLinksList[0].masterUser!.profileImage!.replaceAll('-xs', '')}",
                                            type: provider
                                                .profileFunLinksList[0]
                                                .masterUser!
                                                .profileImageType
                                                .toString(),
                                            selectPhase: provider.selectPhase,
                                          );
                                        });
                                  }
                                }
                              }
                            } else {
                              if (provider.selectPhase == 2) {
                                if (provider.profileFollowLinksList.isEmpty) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PhotoImageScreen(
                                        getRunScreen: 'editProfileImage',
                                        runtypes:
                                            provider.selectPhase.toString(),
                                      ),
                                    ),
                                  );
                                } else {
                                  if (provider.profileFollowLinksList[0]
                                          .profileImageType !=
                                      '') {
                                    showDialog(
                                        context: context,
                                        barrierColor:
                                            Colors.black.withOpacity(0.5),
                                        // Background color
                                        // barrierDismissible: false,
                                        builder: (BuildContext buildContext) {
                                          return ProfilePicView(
                                            avatar:
                                                "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFollowLinksList[0].profileImage!.replaceAll('-xs', '')}",
                                            image:
                                                "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFollowLinksList[0].profileImage!.replaceAll('-xs', '')}",
                                            type: provider
                                                .profileFollowLinksList[0]
                                                .profileImageType
                                                .toString(),
                                            selectPhase: provider.selectPhase,
                                          );
                                        });
                                  } else {
                                    if (provider.profileFollowLinksList[0]
                                            .masterUser!.profileImageType ==
                                        '') {
                                    } else {
                                      showDialog(
                                          context: context,
                                          barrierColor:
                                              Colors.black.withOpacity(0.5),
                                          // Background color
                                          // barrierDismissible: false,
                                          builder: (BuildContext buildContext) {
                                            return ProfilePicView(
                                              avatar:
                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFollowLinksList[0].masterUser!.profileImage!.replaceAll('-xs', '')}",
                                              image:
                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFollowLinksList[0].masterUser!.profileImage!.replaceAll('-xs', '')}",
                                              type: provider
                                                  .profileFollowLinksList[0]
                                                  .masterUser!
                                                  .profileImageType
                                                  .toString(),
                                              selectPhase: provider.selectPhase,
                                            );
                                          });
                                    }
                                  }
                                }
                              }
                            }
                          }
                        },
                        child: Container(
                          height: 140.h,
                          width: 140.w,
                          decoration: BoxDecoration(
                              border: GradientBoxBorder(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFFF4944),
                                    Color(0xFF141070),
                                    Color(0xFF1C126E),
                                    Color(0xFFFF4944),
                                    Color(0xFF0060FF),
                                  ],
                                  stops: [
                                    0,
                                    0.260417,
                                    0.260517,
                                    0.619792,
                                    1,
                                  ],
                                  tileMode: TileMode.decal,
                                ),
                                width: 2,
                              ),
                              shape: BoxShape.circle),
                          child: provider.selectPhase == 0
                              ? ApiProvider.userType == 'brand' ||
                                      ApiProvider.userType == 'agency'
                                  ? provider.store.isEmpty
                                      ? Container()
                                      : provider.store[0].profileImageType != ''
                                          ? Container(
                                              child: provider
                                                          .store[0].profileImageType ==
                                                      "avatar"
                                                  ? CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.store[0].profileImage}"),
                                                      backgroundColor:
                                                          Color(0xFFCFB7E9),
                                                      radius: 50.r,
                                                    )
                                                  : CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.store[0].profileImage}"),
                                                      backgroundColor:
                                                          Color(0xFFCFB7E9),
                                                      radius: 50.r,
                                                    ),
                                            )
                                          : provider.store[0].masterUser!
                                                      .profileImageType ==
                                                  ''
                                              ? Container()
                                              : Container(
                                                  child: provider
                                                              .profileFameLinksModelResult
                                                              .result![0]
                                                              .masterUser!
                                                              .profileImageType ==
                                                          "avatar"
                                                      ? CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.store[0].masterUser!.profileImage}"),
                                                          backgroundColor:
                                                              Color(0xFFCFB7E9),
                                                          radius: 50.r,
                                                        )
                                                      : CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.store[0].masterUser!.profileImage}"),
                                                          radius: 50.r,
                                                        ),
                                                )
                                  : provider.profileFameLinksModelResult.result!
                                          .isEmpty
                                      ? Container()
                                      : provider
                                                  .profileFameLinksModelResult
                                                  .result![0]
                                                  .profileImageType !=
                                              ''
                                          ? Container(
                                              child: provider
                                                          .profileFameLinksModelResult
                                                          .result![0]
                                                          .profileImageType ==
                                                      "avatar"
                                                  ? CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFameLinksModelResult.result![0].profileImage}"),
                                                      backgroundColor:
                                                          Color(0xFFCFB7E9),
                                                      radius: 50.r,
                                                    )
                                                  : CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFameLinksModelResult.result![0].profileImage}"),
                                                      backgroundColor:
                                                          Color(0xFFCFB7E9),
                                                      radius: 50.r,
                                                    ),
                                            )
                                          : provider
                                                      .profileFameLinksModelResult
                                                      .result![0]
                                                      .masterUser!
                                                      .profileImageType ==
                                                  ''
                                              ? Container()
                                              : Container(
                                                  child: provider
                                                              .profileFameLinksModelResult
                                                              .result![0]
                                                              .masterUser!
                                                              .profileImageType ==
                                                          "avatar"
                                                      ? CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFameLinksModelResult.result![0].masterUser!.profileImage}"),
                                                          backgroundColor:
                                                              Color(0xFFCFB7E9),
                                                          radius: 50.r,
                                                        )
                                                      : CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFameLinksModelResult.result![0].masterUser!.profileImage}"),
                                                          radius: 50.r,
                                                        ),
                                                )
                              : provider.selectPhase == 1
                                  ? provider.profileFunLinksList.isEmpty
                                      ? Container()
                                      : provider.profileFunLinksList[0]
                                                  .profileImageType !=
                                              ''
                                          ? Container(
                                              child: provider
                                                          .profileFunLinksList[
                                                              0]
                                                          .profileImageType ==
                                                      "avatar"
                                                  ? CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFunLinksList[0].profileImage}"),
                                                      backgroundColor:
                                                          Color(0xFFCFB7E9),
                                                      radius: 50.r,
                                                    )
                                                  : CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFunLinksList[0].profileImage}"),
                                                      backgroundColor:
                                                          Color(0xFFCFB7E9),
                                                      radius: 50.r,
                                                    ),
                                            )
                                          : provider
                                                      .profileFunLinksList[0]
                                                      .masterUser!
                                                      .profileImageType ==
                                                  ''
                                              ? Container()
                                              : Container(
                                                  child: provider
                                                              .profileFunLinksList[
                                                                  0]
                                                              .masterUser!
                                                              .profileImageType ==
                                                          "avatar"
                                                      ? CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFunLinksList[0].masterUser!.profileImage}"),
                                                          backgroundColor:
                                                              Color(0xFFCFB7E9),
                                                          radius: 50.r,
                                                        )
                                                      : CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFunLinksList[0].masterUser!.profileImage}"),
                                                          radius: 50.r,
                                                        ),
                                                )
                                  : provider.selectPhase == 1
                                      ? provider.profileFunLinksList.isEmpty
                                          ? Container()
                                          : provider.profileFunLinksList[0]
                                                      .profileImageType !=
                                                  ''
                                              ? Container(
                                                  child: provider
                                                              .profileFunLinksList[
                                                                  0]
                                                              .profileImageType ==
                                                          "avatar"
                                                      ? CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFunLinksList[0].profileImage}"),
                                                          backgroundColor:
                                                              Color(0xFFCFB7E9),
                                                          radius: 50.r,
                                                        )
                                                      : CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFunLinksList[0].profileImage}"),
                                                          backgroundColor:
                                                              Color(0xFFCFB7E9),
                                                          radius: 50.r,
                                                        ),
                                                )
                                              : provider
                                                          .profileFunLinksList[0]
                                                          .masterUser!
                                                          .profileImageType ==
                                                      ''
                                                  ? Container()
                                                  : Container(
                                                      child: provider
                                                                  .profileFunLinksList[
                                                                      0]
                                                                  .masterUser!
                                                                  .profileImageType ==
                                                              "avatar"
                                                          ? CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFunLinksList[0].masterUser!.profileImage}"),
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFFCFB7E9),
                                                              radius: 50.r,
                                                            )
                                                          : CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFunLinksList[0].masterUser!.profileImage}"),
                                                              radius: 50.r,
                                                            ),
                                                    )
                                      : provider.selectPhase == 2
                                          ? provider.profileFollowLinksList.isEmpty
                                              ? Container()
                                              : provider.profileFollowLinksList[0].profileImageType != ''
                                                  ? Container(
                                                      child: provider
                                                                  .profileFollowLinksList[
                                                                      0]
                                                                  .profileImageType ==
                                                              "avatar"
                                                          ? CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFollowLinksList[0].profileImage}"),
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFFCFB7E9),
                                                              radius: 50.r,
                                                            )
                                                          : CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFollowLinksList[0].profileImage}"),
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFFCFB7E9),
                                                              radius: 50.r,
                                                            ),
                                                    )
                                                  : provider.profileFollowLinksList[0].masterUser!.profileImageType == ''
                                                      ? Container()
                                                      : Container(
                                                          child: provider
                                                                      .profileFollowLinksList[
                                                                          0]
                                                                      .masterUser!
                                                                      .profileImageType ==
                                                                  "avatar"
                                                              ? CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                          "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFollowLinksList[0].masterUser!.profileImage}"),
                                                                  backgroundColor:
                                                                      Color(
                                                                          0xFFCFB7E9),
                                                                  radius: 50.r,
                                                                )
                                                              : CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                          "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFollowLinksList[0].masterUser!.profileImage}"),
                                                                  radius: 50.r,
                                                                ),
                                                        )
                                          : Container(),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    left: 106.w,
                    right: 0.r,
                    bottom: 96.h,
                    child: Column(
                      children: [
                        provider.selectPhase == 0
                            ? ApiProvider.userType == 'brand' ||
                                    ApiProvider.userType == 'agency'
                                ? provider.store[0].masterUser!.isVerified ==
                                        false
                                    ? SizedBox()
                                    : SvgPicture.asset(
                                        CommonImage.ic_verified,
                                        width: 18,
                                        height: 18,
                                      )
                                : provider.selectPhase == 0
                                    ? provider
                                                .profileFameLinksModelResult
                                                .result![0]
                                                .masterUser!
                                                .isVerified ==
                                            false
                                        ? SizedBox()
                                        : SvgPicture.asset(
                                            CommonImage.ic_verified,
                                            width: 18,
                                            height: 18,
                                          )
                                    : provider.selectPhase == 1
                                        ? provider.profileFunLinksList[0]
                                                    .masterUser!.isVerified ==
                                                false
                                            ? SizedBox()
                                            : SvgPicture.asset(
                                                CommonImage.ic_verified,
                                                width: 18,
                                                height: 18,
                                              )
                                        : provider.selectPhase == 1
                                            ? provider
                                                        .profileFollowLinksList[
                                                            0]
                                                        .masterUser!
                                                        .isVerified ==
                                                    false
                                                ? SizedBox()
                                                : SvgPicture.asset(
                                                    CommonImage.ic_verified,
                                                    width: 18,
                                                    height: 18,
                                                  )
                                            : SizedBox()
                            : SizedBox()
                      ],
                    )),
                Positioned(
                    top: 120.r,
                    right: MediaQuery.of(context).size.width - 128.w,
                    // right: 200.r,
                    bottom: 2.r,
                    child: Container(
                      child: Column(
                        children: [
                          Spacer(),
                          SizedBox(
                            height: 40.h,
                            width: 40.w,
                            child: InkWell(
                              onTap: () {
                                print('FameLinks');
                                userProfileData.changeIsDrawerOpen(
                                    !userProfileData.getIsDrawerOpen);
                                if (userProfileData.isDrawerOpen == true) {
                                  provider.animacon.forward();
                                } else {
                                  print(false);
                                  provider.animacon.reverse();
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                    'assets/icons/svg/settings.svg',
                                    height: 22.h,
                                    width: 22.w,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    )),
                Positioned(
                    top: 20.r,
                    left: MediaQuery.of(context).size.width - 128.w,
                    // right: MediaQuery.of(context).size.width - 295.w,
                    bottom: 153.r,
                    child: Container(
                      child: Column(
                        children: [
                          Spacer(),
                          InkWell(
                            onTap: () async {
                              print("share click");
                              String? name;
                              if (provider.selectPhase == 0) {
                                name = "otherprofilefame";
                              } else if (provider.selectPhase == 1) {
                                name = "otherprofilefun";
                              } else {
                                name = "otherprofilefollow";
                              }
                              provider.sharedilog(true);
                              await Sharedynamic.shareprofile(
                                  provider.profileFameLinksModelResult
                                      .result![0].masterUser!.sId!,
                                  name,
                                  provider.profileFameLinksModelResult
                                      .result![0].name!
                                      .toString());
                              provider.sharedilog(false);
                            },
                            child: provider.shareshow
                                ? Container(width: 30, child: spinkit)
                                : Image.asset(
                                    'assets/icons/share.png',
                                    color: Colors.white,
                                    height: 22.h,
                                    width: 22.w,
                                  ),
                          ),
                          Spacer(),
                        ],
                      ),
                    )),
                Positioned(
                    top: 10.r,
                    left: 50.r,
                    right: 175.r,
                    bottom: 142.r,
                    child: Container(
                      // color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RotationTransition(
                              turns: new AlwaysStoppedAnimation(320 / 371),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OtherProfile(
                                          id: ApiProvider.userType == 'brand'
                                              ? provider
                                                  .store[0].masterUser!.sId!
                                              : provider
                                                  .profileFameLinksModelResult
                                                  .result![0]
                                                  .masterUser!
                                                  .sId!,
                                          selectPhase: provider.selectPhase,
                                          sayhi: "show"),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Compact View",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(12)),
                                ),
                              )),
                        ],
                      ),
                    )),
                Visibility(
                  visible: animationpro.showanimation ? false : true,
                  child: Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 282.h,
                      width: 308.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              circleButtonImage(
                                imgUrl: animationpro.budlist[animationpro.a],
                                onTaps: () {
                                  print("click1");
                                },
                                isButtonSelect: true,
                              ),
                              Container(
                                height: 23.h,
                                width: 1,
                                color: Colors.red,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  circleButtonImage(
                                    imgUrl:
                                        animationpro.budlist[animationpro.b],
                                    onTaps: () async {
                                      print("click2");
                                      //  print("left before $a $b $c $d");

                                      await animationpro.click2();
                                      animationpro.animationshow(true);
                                      animationpro.animControllerbud0.forward();

                                      animationpro.animation = Tween<double>(
                                        begin: 0,
                                        end: .5 * math.pi,
                                      ).animate(animationpro.animController);

                                      animationpro.animController.forward();

                                      Future.delayed(
                                          Duration(
                                              milliseconds:
                                                  animationpro.antime), () {
                                        animationpro.animController.reset();
                                        animationpro.animControllerbud0.reset();

                                        if (animationpro.a == 0) {
                                          animationpro.a = 1;
                                          animationpro.b = 2;
                                          animationpro.d = 3;
                                          animationpro.c = 0;
                                        } else if (animationpro.a == 1) {
                                          animationpro.a = 2;
                                          animationpro.b = 3;
                                          animationpro.d = 0;
                                          animationpro.c = 1;
                                        } else if (animationpro.a == 2) {
                                          animationpro.a = 3;
                                          animationpro.b = 0;
                                          animationpro.d = 1;
                                          animationpro.c = 2;
                                        } else if (animationpro.a == 3) {
                                          animationpro.a = 0;
                                          animationpro.b = 1;
                                          animationpro.d = 2;
                                          animationpro.c = 3;
                                        }
                                        //

                                        provider.selectphasefun(animationpro.a);

                                        animationpro.animationshow(false);
                                        // print("left after $a $b $c $d");
                                      });
                                    },
                                    isButtonSelect: false,
                                  ),
                                  Container(
                                    height: 1,
                                    width: 19.w,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 1,
                                    width: 19.w,
                                    color: Colors.white,
                                  ),
                                  circleButtonImage(
                                    imgUrl:
                                        animationpro.budlist[animationpro.c],
                                    onTaps: () async {
                                      print("click3");

                                      //    print("before after $a $b $c $d");
                                      await animationpro.click3();

                                      animationpro.animationshow(true);
                                      print(
                                          "objectfristtop ${animationpro.showanimation}");

                                      animationpro.animation = Tween<double>(
                                        begin: 0,
                                        end: -.5 * math.pi,
                                      ).animate(animationpro.animController);

                                      animationpro.animController.forward();
                                      animationpro.animControllerbud0.forward();

                                      Future.delayed(
                                          Duration(
                                              milliseconds:
                                                  animationpro.antime), () {
                                        animationpro.animController.reset();
                                        animationpro.animControllerbud0.reset();

                                        if (animationpro.a == 0) {
                                          animationpro.a = 3;
                                          animationpro.b = 0;
                                          animationpro.d = 1;
                                          animationpro.c = 2;
                                        } else if (animationpro.a == 1) {
                                          animationpro.a = 0;
                                          animationpro.b = 1;
                                          animationpro.d = 2;
                                          animationpro.c = 3;
                                        } else if (animationpro.a == 2) {
                                          animationpro.a = 1;
                                          animationpro.b = 2;
                                          animationpro.d = 3;
                                          animationpro.c = 0;
                                        } else if (animationpro.a == 3) {
                                          animationpro.a = 2;
                                          animationpro.b = 3;
                                          animationpro.d = 0;
                                          animationpro.c = 1;
                                        }
                                        Future.delayed(Duration(seconds: 1),
                                            () {
                                          print(
                                              "objectfrist ${animationpro.a}");
                                        });
                                        provider.selectphasefun(animationpro.a);

                                        animationpro.animationshow(false);

                                        //     print("left after $a $b $c $d");
                                      });
                                    },
                                    isButtonSelect: false,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 23.h,
                                width: 1,
                                color: Colors.red,
                              ),
                              circleButtonImage(
                                imgUrl: animationpro.budlist[animationpro.d],
                                onTaps: () async {
                                  print("click4");

                                  await animationpro.click4();
                                  animationpro.animationshow(true);
                                  animationpro.animation = Tween<double>(
                                    begin: 0,
                                    end: 1 * math.pi,
                                  ).animate(animationpro.animController);
                                  animationpro.animController.forward();
                                  animationpro.animControllerbud0.forward();
                                  Future.delayed(Duration(milliseconds: 500),
                                      () {
                                    animationpro.animController.reset();
                                    animationpro.animControllerbud0.reset();
                                    if (animationpro.a == 0) {
                                      animationpro.a = 2;
                                      animationpro.b = 3;
                                      animationpro.c = 1;
                                      animationpro.d = 0;
                                    } else if (animationpro.a == 1) {
                                      animationpro.a = 3;
                                      animationpro.b = 0;
                                      animationpro.c = 2;
                                      animationpro.d = 1;
                                    } else if (animationpro.a == 2) {
                                      animationpro.a = 0;
                                      animationpro.b = 1;
                                      animationpro.c = 3;
                                      animationpro.d = 2;
                                    } else if (animationpro.a == 3) {
                                      animationpro.a = 1;
                                      animationpro.b = 2;
                                      animationpro.c = 0;
                                      animationpro.d = 3;
                                    }
                                    provider.selectphasefun(animationpro.a);

                                    animationpro.animationshow(false);
                                  });
                                },
                                isButtonSelect: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: animationpro.showanimation,
                  child: Transform.rotate(
                    angle: animationpro.animation.value,
                    child: Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 282.h,
                        width: 308.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Transform.rotate(
                                  angle: animationpro.animationbud0.value,
                                  child: circleButtonImage(
                                    imgUrl:
                                        animationpro.budlist[animationpro.a],
                                    onTaps: () {},
                                    isButtonSelect: false,
                                  ),
                                ),
                                Container(
                                  height: 23.h,
                                  width: 1,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Transform.rotate(
                                      angle: animationpro.animationbud0.value,
                                      child: circleButtonImage(
                                        imgUrl: animationpro
                                            .budlist[animationpro.b],
                                        onTaps: () {},
                                        isButtonSelect: false,
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      width: 19.w,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 1,
                                      width: 19.w,
                                      color: Colors.white,
                                    ),
                                    Transform.rotate(
                                      angle: animationpro.animationbud0.value,
                                      child: circleButtonImage(
                                        imgUrl: animationpro
                                            .budlist[animationpro.c],
                                        onTaps: () {},
                                        isButtonSelect: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 23.h,
                                  width: 1,
                                  color: Colors.white,
                                ),
                                Transform.rotate(
                                  angle: animationpro.animationbud0.value,
                                  child: circleButtonImage(
                                    imgUrl:
                                        animationpro.budlist[animationpro.d],
                                    onTaps: () {},
                                    isButtonSelect: false,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    //   pro!.animController.dispose();
    super.dispose();
  }
}
