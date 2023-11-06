import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../common/common_image.dart';
import '../../../common/common_routing.dart';
import '../../../networking/config.dart';
import '../../../util/config/color.dart';
import '../../../util/constants.dart';
import '../../Famelinkprofile/function/famelinkFun.dart';
import '../../homedial/ui/editUserProfile.dart';
import '../../profile/fame_coins_screen.dart';

class funLinksNameFieldWhitemode extends StatelessWidget {
  const funLinksNameFieldWhitemode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FameLinkFun>(
      builder: (context, fameLinkFun, child) {
        return Container(
          color: Colors.white,
          height: 120,
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
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                shadowColor: Colors.grey,
                                child: Padding(
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
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(children: [
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            fameLinkFun.profileFunLinksList
                                                        .length !=
                                                    0
                                                ? fameLinkFun
                                                            .profileFunLinksList[
                                                                0]
                                                            .profileImageType ==
                                                        ""
                                                    ? fameLinkFun!.avtarImage !=
                                                            null
                                                        ? Container(
                                                            height: 30,
                                                            width: 30,
                                                            child: CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      fameLinkFun!
                                                                          .avtarImage),
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              radius: 50,
                                                            ),
                                                          )
                                                        : fameLinkFun!
                                                                    .profileImage !=
                                                                null
                                                            ? Container(
                                                                height: 30,
                                                                width: 30,
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                          fameLinkFun!
                                                                              .profileImage),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  radius: 50,
                                                                ),
                                                              )
                                                            : /*Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Image.asset(
                                                                      "assets/images/feather_upload.png"),
                                                                  SizedBox(
                                                                    height: 8,
                                                                  ),
                                                                  Text(
                                                                    "Your Avatar",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize: 12,
                                                                      color: Color(
                                                                          0xFF9B9B9B),
                                                                    ),
                                                                  )
                                                                ],
                                                              )*/
                                                            Container(
                                                                height: 30.h,
                                                                width: 30.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  gradient: LinearGradient(
                                                                      begin: Alignment
                                                                          .topCenter,
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
                                                        height: 30,
                                                        width: 30,
                                                        child: fameLinkFun
                                                                    .profileFunLinksList[
                                                                        0]
                                                                    .profileImageType ==
                                                                "avatar"
                                                            ? CircleAvatar(
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${fameLinkFun.profileFunLinksList[0].profileImage}"),
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                radius: 50,
                                                              )
                                                            : CircleAvatar(
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${fameLinkFun.profileFunLinksList[0].profileImage}"),
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                radius: 50,
                                                              ))
                                                : Container(),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            fameLinkFun.profileFunLinksList
                                                        .isNotEmpty &&
                                                    fameLinkFun
                                                            .profileFunLinksList[
                                                                0]
                                                            .name !=
                                                        null &&
                                                    fameLinkFun
                                                            .profileFunLinksList[
                                                                0]
                                                            .name !=
                                                        ""
                                                ? Text(
                                                    fameLinkFun
                                                        .profileFunLinksList[0]
                                                        .name!,
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                : Container(),
                                            // Text(
                                            //   fameLinkFun.profileFunLinksList[0].name,
                                            //   style: GoogleFonts.nunitoSans(
                                            //     fontSize: 18,
                                            //     fontWeight: FontWeight.bold,
                                            //     color: HexColor("#030C23"),
                                            //   ),
                                            // ),
                                          ]),
                                          InkWell(
                                            onTap: () {
                                              // setState(() {
                                              EditUserProfileState
                                                  .selectAvatar = "_";
                                              EditUserProfileState
                                                  .selectImageFilePath;
                                              EditUserProfileState
                                                  .selectAvatarType = "";
                                              // });
                                              String tempDate = fameLinkFun
                                                          .profileFunLinksList[
                                                              0]
                                                          .masterUser!
                                                          .dob !=
                                                      'null'
                                                  ? DateFormat('dd-MM-yyyy')
                                                      .format(DateFormat(
                                                              'yyyy-MM-dd')
                                                          .parse(fameLinkFun
                                                              .profileFunLinksList[
                                                                  0]
                                                              .masterUser!
                                                              .dob!))
                                                  : '';
                                              print("tempDate");
                                              gotoUserEditProfileScreen(
                                                context,
                                                runTypes:
                                                    fameLinkFun.selectPhase,
                                                countrys: fameLinkFun
                                                    .profileFunLinksList[0]
                                                    .masterUser!
                                                    .country
                                                    .toString(),
                                                districts: fameLinkFun
                                                    .profileFunLinksList[0]
                                                    .masterUser!
                                                    .district
                                                    .toString(),
                                                states: fameLinkFun
                                                    .profileFunLinksList[0]
                                                    .masterUser!
                                                    .state
                                                    .toString(),
                                                bios: fameLinkFun
                                                    .profileFunLinksList[0].bio
                                                    .toString(),
                                                imagUrls: fameLinkFun
                                                    .profileFunLinksList[0]
                                                    .profileImage
                                                    .toString(),
                                                imageType: fameLinkFun
                                                    .profileFunLinksList[0]
                                                    .profileImageType,
                                                names: fameLinkFun
                                                    .profileFunLinksList[0].name
                                                    .toString(),
                                                professions: fameLinkFun
                                                    .profileFunLinksList[0]
                                                    .profession
                                                    .toString(),
                                                userNames: fameLinkFun
                                                    .profileFunLinksList[0]
                                                    .masterUser!
                                                    .username
                                                    .toString(),
                                                dobs: tempDate.toString(),
                                                isProfileUpdate: false,
                                              );
                                            },
                                            child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 6.0,
                                                    right: 6.0,
                                                    top: 2.0,
                                                    bottom: 2.0),
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(CommonImage
                                                        .funLinksStoreEditButton),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Edit Profile2',
                                                  style: GoogleFonts.nunitoSans(
                                                    fontSize: 14,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black
                                                        .withOpacity(0.75),
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4.0,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 9.0),
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
                                            const EdgeInsets.only(left: 9.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(children: [
                                              SizedBox(
                                                width:
                                                    ScreenUtil().screenWidth *
                                                        0.50,
                                                child: Text(
                                                  fameLinkFun
                                                          .profileFunLinksList
                                                          .isNotEmpty
                                                      ? "${fameLinkFun.profileFunLinksList[0].masterUser!.district ?? '---'},${fameLinkFun.profileFunLinksList[0].masterUser!.state ?? '---'},${fameLinkFun.profileFunLinksList[0].masterUser!.country ?? '---'}"
                                                      : "",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.nunitoSans(
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              // Text(
                                              //   '0',
                                              //   style: GoogleFonts.nunitoSans(
                                              //     fontSize: 14,
                                              //     color: Colors.black,
                                              //   ),
                                              // ),
                                              // const SizedBox(
                                              //   width: 5.0,
                                              // ),
                                              // SizedBox(
                                              //   height: 15.68,
                                              //   width: 21.33,
                                              //   child: Image.asset(
                                              //     CommonImage
                                              //         .funLinksStoreHosportIcon,
                                              //     height: 15.68,
                                              //     width: 21.33,
                                              //     fit: BoxFit.fill,
                                              //   ),
                                              // ),
                                            ]),
                                            InkWell(
                                              onTap: () {
                                                if (fameLinkFun
                                                        .profileFunLinksList[0]
                                                        .masterUser!
                                                        .fameCoins !=
                                                    null) {
                                                  Constants.fameCoins =
                                                      fameLinkFun
                                                          .profileFunLinksList[
                                                              0]
                                                          .masterUser!
                                                          .fameCoins!;
                                                }
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FameCoinsScreen(
                                                              fameLinkFun
                                                                  .profileFunLinksList[
                                                                      0]
                                                                  .masterUser!
                                                                  .fameCoins)),
                                                );
                                              },
                                              child: Row(children: [
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
                                                  fameLinkFun
                                                          .profileFunLinksList
                                                          .isNotEmpty
                                                      ? fameLinkFun
                                                          .profileFunLinksList[
                                                              0]
                                                          .masterUser!
                                                          .fameCoins
                                                          .toString()
                                                      : "",
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ]),
                                            ),

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
        );
      },
    );
  }
}
