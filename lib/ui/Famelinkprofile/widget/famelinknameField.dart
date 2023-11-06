import 'package:famelink/util/widgets/dark_edit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../common/common_image.dart';
import '../../../common/common_routing.dart';
import '../../../networking/config.dart';
import '../../../providers/UserProfileProvider/userProfile_provider.dart';
import '../../../util/config/color.dart';
import '../../../util/constants.dart';
import '../../homedial/ui/editUserProfile.dart';
import '../../profile/brand_edit_profile_screen.dart';
import '../../profile/fame_coins_screen.dart';
import '../function/famelinkFun.dart';

class fameLinksNameField extends StatelessWidget {
  fameLinksNameField(
      {Key? key,
      required this.provider,
      required this.id,
      required this.status,
      // required this.callback,
      required this.profileImage,
      required this.avtarImage,
      required this.selectPhase})
      : super(key: key);
  UserProfileProvider provider;

  var id, status, profileImage, avtarImage;
  final int selectPhase;

//  final Future<dynamic> callback;
  @override
  Widget build(BuildContext context) {
    return Consumer<FameLinkFun>(
      builder: (context, provider, child) {
        return Container(
          width: ScreenUtil().screenWidth,
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
              border: Border.all(color: white.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(12),
              gradient: Constants.glassGradient),
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
                    provider.profileFameLinksModelResult.result!.length != 0
                        ? provider.profileFameLinksModelResult.result![0]
                                    .profileImageType ==
                                ""
                            ? avtarImage != null
                                ? Container(
                                    height: 30,
                                    width: 30,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(avtarImage),
                                      backgroundColor: Colors.transparent,
                                      radius: 50,
                                    ),
                                  )
                                : profileImage != null
                                    ? Container(
                                        height: 30,
                                        width: 30,
                                        child: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(profileImage),
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
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                          Color(0xff1109aa),
                                          Color(0xff2e1765),
                                          Color(0xff431651),
                                          Color(0xff7b0247),
                                          Color(0xffba4243),
                                          Color(0xffe0a176)
                                        ])),
                                      )
                            : Container(
                                height: 30,
                                width: 30,
                                child: provider.profileFameLinksModelResult
                                            .result![0].profileImageType ==
                                        "avatar"
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.profileFameLinksModelResult.result![0].profileImage}"),
                                        backgroundColor: Colors.transparent,
                                        radius: 50,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.profileFameLinksModelResult.result![0].profileImage}"),
                                        backgroundColor: Colors.transparent,
                                        radius: 50,
                                      ))
                        : Container(),
                    SizedBox(
                      width: 8.0,
                    ),
                    provider.profileFameLinksModelResult.result!.isNotEmpty &&
                            provider.profileFameLinksModelResult.result![0]
                                    .name !=
                                null &&
                            provider.profileFameLinksModelResult.result![0]
                                    .name !=
                                ""
                        ? Text(
                            provider
                                .profileFameLinksModelResult.result![0].name!,
                            style: GoogleFonts.nunitoSans(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        : Container(),
                  ]),
                  DarkEditButton(
                      onPressed: () async {
                        if (Constants.userType == 'brand' ||
                            Constants.userType == 'agency') {
                          var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ontext) => BrandEditProfileScreen(
                                    provider!.upperProfileData!, false)),
                          );
                          if (result != null && result == true) {
                            provider.profile(context);
                          }
                        } else {
                          EditUserProfileState.selectAvatar = "_";
                          EditUserProfileState.selectAvatarType = "";

                          print(provider.profileFameLinksModelResult.result![0]
                              .masterUser!.dob);

                          String tempDate = provider.profileFameLinksModelResult
                                      .result![0].masterUser!.dob !=
                                  "null"
                              ? DateFormat('dd-MM-yyyy').format(
                                  DateFormat('yyyy-MM-dd').parse(provider
                                      .profileFameLinksModelResult
                                      .result![0]
                                      .masterUser!
                                      .dob!))
                              : "";
                          print(tempDate);

                          gotoUserEditProfileScreen(
                            context,
                            runTypes: selectPhase,
                            countrys: provider.profileFameLinksModelResult
                                .result![0].masterUser!.country
                                .toString(),
                            districts: provider.profileFameLinksModelResult
                                .result![0].masterUser!.district
                                .toString(),
                            states: provider.profileFameLinksModelResult
                                .result![0].masterUser!.state
                                .toString(),
                            bios: provider
                                .profileFameLinksModelResult.result![0].bio
                                .toString(),
                            imagUrls: provider.profileFameLinksModelResult
                                .result![0].profileImage
                                .toString(),
                            imageType: provider.profileFameLinksModelResult
                                .result![0].profileImageType,
                            names: provider
                                .profileFameLinksModelResult.result![0].name
                                .toString(),
                            professions: provider.profileFameLinksModelResult
                                .result![0].profession
                                .toString(),
                            userNames: provider.profileFameLinksModelResult
                                .result![0].masterUser!.username
                                .toString(),
                            dobs: tempDate.toString(),
                            isProfileUpdate: false,
                          );
                        }
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
                          provider.profileFameLinksModelResult.result!
                                  .isNotEmpty
                              ? "${provider.profileFameLinksModelResult.result![0].masterUser!.district ?? '---'},${provider.profileFameLinksModelResult.result![0].masterUser!.state ?? '---'},${provider.profileFameLinksModelResult.result![0].masterUser!.country ?? '---'}"
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
                        if (id != null) {
                        } else {
                          if (provider.profileFameLinksModelResult.result![0]
                                  .masterUser!.fameCoins !=
                              null) {
                            Constants.fameCoins = provider
                                .profileFameLinksModelResult
                                .result![0]
                                .masterUser!
                                .fameCoins!;
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FameCoinsScreen(provider
                                    .profileFameLinksModelResult
                                    .result![0]
                                    .masterUser!
                                    .fameCoins)),
                          );
                        }
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
                          provider.profileFameLinksModelResult.result!
                                  .isNotEmpty
                              ? provider.profileFameLinksModelResult.result![0]
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
