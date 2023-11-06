import 'package:famelink/util/widgets/dark_edit_button.dart';
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
import '../../homedial/ui/editUserProfile.dart';
import '../../profile/fame_coins_screen.dart';
import '../function/famelinkFun.dart';

class followLinksNameField extends StatelessWidget {
  const followLinksNameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FameLinkFun>(
      builder: (context, fameLinkFun, child) {
        return Container(
          width: ScreenUtil().screenWidth,
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: white.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(12),
            gradient: Constants.glassGradient,
          ),
          padding:
              EdgeInsets.only(top: 5.0, left: 3.0, right: 8.0, bottom: 8.0),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: [
                    SizedBox(
                      width: 8.0,
                    ),
                    fameLinkFun.profileFollowLinksList.length != 0
                        ? fameLinkFun.profileFollowLinksList[0]
                                    .profileImageType ==
                                ""
                            ? fameLinkFun!.avtarImage != null
                                ? Container(
                                    height: 30,
                                    width: 30,
                                    child: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(fameLinkFun!.avtarImage),
                                      backgroundColor: Colors.transparent,
                                      radius: 50,
                                    ),
                                  )
                                : fameLinkFun!.profileImage != null
                                    ? Container(
                                        height: 30,
                                        width: 30,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              fameLinkFun!.profileImage),
                                          backgroundColor: Colors.transparent,
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
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                lightRedWhite,
                                                lightRed
                                              ]),
                                          shape: BoxShape.circle,
                                        ),
                                      )
                            : Container(
                                height: 30,
                                width: 30,
                                child: fameLinkFun.profileFollowLinksList[0]
                                            .profileImageType ==
                                        "avatar"
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${fameLinkFun.profileFollowLinksList[0].profileImage}"),
                                        backgroundColor: Colors.transparent,
                                        radius: 50,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${fameLinkFun.profileFollowLinksList[0].profileImage}"),
                                        backgroundColor: Colors.transparent,
                                        radius: 50,
                                      ))
                        : Container(),
                    SizedBox(
                      width: 8.0,
                    ),
                    fameLinkFun.profileFollowLinksList.isNotEmpty &&
                            fameLinkFun.profileFollowLinksList[0].name !=
                                null &&
                            fameLinkFun.profileFollowLinksList[0].name != ""
                        ? Text(
                            fameLinkFun.profileFollowLinksList[0].name!,
                            style: GoogleFonts.nunitoSans(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        : Container(),
                  ]),
                  DarkEditButton(
                      onPressed: () {
                        //   setState(() {
                        EditUserProfileState.selectAvatar = "_";
                        EditUserProfileState.selectImageFilePath;
                        EditUserProfileState.selectAvatarType = "";
                        // });
                        String tempDate = fameLinkFun.profileFollowLinksList[0]
                                    .masterUser!.dob !=
                                'null'
                            ? DateFormat('dd-MM-yyyy').format(
                                DateFormat('yyyy-MM-dd').parse(fameLinkFun
                                    .profileFollowLinksList[0]
                                    .masterUser!
                                    .dob!))
                            : '';
                        print(tempDate);
                        gotoUserEditProfileScreen(
                          context,
                          runTypes: fameLinkFun!.selectPhase,
                          countrys: fameLinkFun
                              .profileFollowLinksList[0].masterUser!.country
                              .toString(),
                          districts: fameLinkFun
                              .profileFollowLinksList[0].masterUser!.district
                              .toString(),
                          states: fameLinkFun
                              .profileFollowLinksList[0].masterUser!.state
                              .toString(),
                          bios: fameLinkFun.profileFollowLinksList[0].bio
                              .toString(),
                          imagUrls: fameLinkFun
                              .profileFollowLinksList[0].profileImage
                              .toString(),
                          imageType: fameLinkFun
                              .profileFollowLinksList[0].profileImageType,
                          names: fameLinkFun.profileFollowLinksList[0].name
                              .toString(),
                          professions: fameLinkFun
                              .profileFollowLinksList[0].profession
                              .toString(),
                          userNames: fameLinkFun
                              .profileFollowLinksList[0].masterUser!.username
                              .toString(),
                          dobs: tempDate.toString(),
                          isProfileUpdate: false,
                        );
                      },
                      text: 'Edit Profile')
                ],
              ),
              const SizedBox(
                height: 4.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 9.0),
                child: Divider(
                  height: 1,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 7.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 9.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(children: [
                      SizedBox(
                        width: ScreenUtil().screenWidth * 0.50,
                        child: Text(
                          fameLinkFun.profileFollowLinksList.isNotEmpty
                              ? "${fameLinkFun.profileFollowLinksList[0].masterUser!.district ?? '---'},${fameLinkFun.profileFollowLinksList[0].masterUser!.state ?? '---'},${fameLinkFun.profileFollowLinksList[0].masterUser!.country ?? '---'}"
                              : "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunitoSans(
                              fontSize: 12, color: Colors.white),
                        ),
                      ),
/*                                          Text(
                                      '0',
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    SizedBox(
                                      height: 15.68,
                                      width: 21.33,
                                      child: Image.asset(
                                        CommonImage
                                            .funLinksStoreHosportIcon,
                                        height: 15.68,
                                        width: 21.33,
                                        fit: BoxFit.fill,
                                      ),
                                    ),*/
                    ]),
                    InkWell(
                      onTap: () {
                        if (fameLinkFun.profileFollowLinksList[0].masterUser!
                                .fameCoins !=
                            null) {
                          Constants.fameCoins = fameLinkFun
                              .profileFollowLinksList[0].masterUser!.fameCoins!;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FameCoinsScreen(fameLinkFun
                                  .profileFollowLinksList[0]
                                  .masterUser!
                                  .fameCoins)),
                        );
                      },
                      child: Row(children: [
                        SizedBox(
                          height: 16.0,
                          width: 16.0,
                          child: Image.asset(
                            CommonImage.funLinksStoreCoinsIcon,
                            height: 15.68,
                            width: 21.33,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          fameLinkFun.profileFollowLinksList.isNotEmpty
                              ? fameLinkFun.profileFollowLinksList[0]
                                  .masterUser!.fameCoins
                                  .toString()
                              : "",
                          style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ]),
                    ),

                    //
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
