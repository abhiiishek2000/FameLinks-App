import 'dart:io';

import 'package:dio/dio.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/ui/settings/WebViewScreen.dart';
import 'package:famelink/ui/settings/account_deletion.dart';
import 'package:famelink/ui/settings/faq_screen.dart';
import 'package:famelink/ui/settings/improvement_feedback_screen.dart';
import 'package:famelink/ui/settings/notification_settings_screen.dart';
import 'package:famelink/ui/settings/profile_verification_screen.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_compress/video_compress.dart';

import '../../Famelinkprofile/function/famelinkFun.dart';
import '../../Famelinkprofile/widget/showUpdateEmailDialog.dart';
import '../../Famelinkprofile/widget/showUpdateMobileDialog.dart';
import '../../profile/agency_other_profile_screen.dart';
import 'drawerDivider.dart';
import 'drawerText.dart';

class DrawerPage extends StatelessWidget {
  DrawerPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FameLinkFun>(
      builder: (context, provider, child) {
        return Container(
            decoration: provider.selfPrifilewhitemode
                ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Colors.black.withOpacity(0.5), width: 1),
                  )
                : BoxDecoration(
                    border: Border.all(color: white.withOpacity(0.5), width: 1),
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Color.fromRGBO(255, 255, 255, 0.6),
                          Color.fromRGBO(255, 255, 255, 0.477083),
                          Color.fromRGBO(255, 255, 255, 0.2),
                          Color.fromRGBO(255, 255, 255, 0.2),
                        ]),
                  ),
            width: ScreenUtil().setWidth(200),
            child: Column(
              children: [
                Container(
                  width: ScreenUtil().setWidth(200),
                  height: 49.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromRGBO(255, 168, 140, 1),
                        Color.fromRGBO(255, 92, 40, 1),
                      ],
                    ),
                    border: Border.all(
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0, 2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        height: 1.25,
                        color: Colors.white,
                        letterSpacing: 0.06,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 2),
                            blurRadius: 2,
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(32),
                      bottom: ScreenUtil().setHeight(40),
                      left: ScreenUtil().setWidth(12),
                      right: ScreenUtil().setWidth(4)),
                  children: <Widget>[
                    InkWell(
                      onTap: () async {
                        print('-2-2-22-2-2-${provider.upperProfileData!.name}');
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ontext) => NotificationSettingsScreen(
                                  provider.upperProfileData!.settings!
                                      .notification!)),
                        );
                      },
                      child: Row(
                        children: [
                          MyBullet(),
                          SizedBox(
                            width: ScreenUtil().setWidth(8),
                          ),
                          drawerText(txt: 'Notification Settings', size: 14),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                    InkWell(
                      onTap: () async {
                        print('-2-2-22-2-2-${provider.upperProfileData!.name}');
                      },
                      child: Row(
                        children: [
                          MyBullet(),
                          SizedBox(
                            width: ScreenUtil().setWidth(8),
                          ),
                          Row(
                            children: [
                              drawerText(txt: 'Mode', size: 14),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                provider.selfPrifilewhitemode
                                    ? "white"
                                    : "Dark",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                // decoration: BoxDecoration(
                                //   border:
                                //       Border.all(color: Colors.blueAccent, width: 1),
                                //   borderRadius: BorderRadius.circular(20.0),
                                // ),
                                child: CupertinoSwitch(
                                  value: provider.selfPrifilewhitemode,
                                  onChanged: (value) {
                                    provider.setselfprothame(value);
                                  },
                                  activeColor: Colors.grey,
                                  trackColor: Color(0xffFFA88C),
                                  thumbColor: provider.selfPrifilewhitemode
                                      ? Color(0xffFFA88C)
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                    InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ontext) => ImprovementFeedbackScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          MyBullet(),
                          SizedBox(
                            width: ScreenUtil().setWidth(8),
                          ),
                          drawerText(txt: 'Feedback', size: 14),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                    InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (ontext) => FAQScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          MyBullet(),
                          SizedBox(
                            width: ScreenUtil().setWidth(8),
                          ),
                          drawerText(txt: 'Support', size: 14),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(8),
                    ),
                    drawerDivider(),
                    SizedBox(
                      height: ScreenUtil().setHeight(24),
                    ),
                    InkWell(
                      onTap: () async {
                        var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ontext) =>
                                  ProfileVideoVerificationScreen()),
                        );
                        if (result != null) {
                          var snackBar = SnackBar(
                            content: Text('Compressing'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Constants.verificationStatus = "Submitted";
                          final MediaInfo? info =
                              await VideoCompress.compressVideo(
                            result,
                            quality: VideoQuality.MediumQuality,
                            deleteOrigin: false,
                            includeAudio: true,
                          );
                          Constants.video = await MultipartFile.fromFile(
                              info!.path!,
                              filename: "${File(result).path.split('/').last}");
                          var formData = FormData.fromMap({
                            "video": Constants.video,
                          });
                          Api.uploadPost.call(context,
                              method: "users/profile/verify",
                              param: formData, onResponseSuccess: (Map object) {
                            var snackBar = SnackBar(
                              content: Text('Uploaded'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        }
                      },
                      child: Row(
                        children: [
                          MyBullet(),
                          SizedBox(
                            width: ScreenUtil().setWidth(8),
                          ),
                          drawerText(txt: 'Verify your Profile', size: 14),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                    InkWell(
                      onTap: () async {
                        //Navigator.pop(context);
                        showUpdateEmailDialogs(
                            context, provider.upperProfileData!.email!);
                      },
                      child: Row(
                        children: [
                          MyBullet(),
                          SizedBox(
                            width: ScreenUtil().setWidth(8),
                          ),
                          drawerText(txt: 'Update Email ID', size: 14),
                          SizedBox(
                            width: ScreenUtil().setWidth(9),
                          ),
                          Text(
                            'Verify',
                            style: GoogleFonts.nunitoSans(
                                color: buttonBlue,
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                    InkWell(
                      onTap: () async {
                        //Navigator.pop(context);
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String? mobile = prefs.getString("mobileNumber");
                        showUpdateMobileDialogs(context, mobile.toString());
                      },
                      child: Row(
                        children: [
                          MyBullet(),
                          SizedBox(
                            width: ScreenUtil().setWidth(8),
                          ),
                          drawerText(txt: 'Update Contact Number', size: 14),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => AccountDeletion())));
                      },
                      child: Row(
                        children: [
                          MyBullet(),
                          SizedBox(
                            width: ScreenUtil().setWidth(8),
                          ),
                          drawerText(txt: 'Delete Account', size: 14),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(8),
                    ),
                    drawerDivider(),
                    SizedBox(
                      height: ScreenUtil().setHeight(24),
                    ),
                    InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ontext) =>
                                  WebViewScreen("Stages of FameLinks")),
                        );
                      },
                      child: Row(
                        children: [
                          MyBullet(),
                          SizedBox(
                            width: ScreenUtil().setWidth(8),
                          ),
                          drawerText(txt: 'Stages of FameLinks', size: 12),
                          SizedBox(
                            width: ScreenUtil().setWidth(8),
                          ),
                          SvgPicture.asset("assets/icons/svg/ic_link.svg",
                              color: lightGray)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                    InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ontext) =>
                                  WebViewScreen("Terms of Usage & Services")),
                        );
                      },
                      child: Row(
                        children: [
                          MyBullet(),
                          SizedBox(
                            width: ScreenUtil().setWidth(8),
                          ),
                          drawerText(
                              txt: 'Terms of Usage & Services', size: 12),
                          SizedBox(
                            width: ScreenUtil().setWidth(8),
                          ),
                          SvgPicture.asset("assets/icons/svg/ic_link.svg",
                              color: lightGray)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                    InkWell(
                      onTap: () async {
                        //Navigator.pop(context);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ontext) =>
                                  WebViewScreen("Privacy Policy")),
                        );
                      },
                      child: Row(
                        children: [
                          MyBullet(),
                          SizedBox(
                            width: ScreenUtil().setWidth(8),
                          ),
                          drawerText(txt: 'Privacy Policy', size: 12),
                          SizedBox(
                            width: ScreenUtil().setWidth(8),
                          ),
                          SvgPicture.asset(
                            "assets/icons/svg/ic_link.svg",
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                    InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ontext) =>
                                  WebViewScreen("Community Guidelines")),
                        );
                      },
                      child: Row(
                        children: [
                          MyBullet(),
                          SizedBox(
                            width: ScreenUtil().setWidth(8),
                          ),
                          drawerText(txt: 'Community Guidelines', size: 12),
                          SizedBox(
                            width: ScreenUtil().setWidth(8),
                          ),
                          SvgPicture.asset("assets/icons/svg/ic_link.svg",
                              color: lightGray)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(71),
                    ),
                    drawerDivider(),
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                    InkWell(
                      onTap: () async {
                        provider.logoutfun(context);
                        // Navigator.pop(context);
                        // isLogout();
                        // showLogOutAlertDialog(context);
                      },
                      child: Row(
                        children: [
                          MyBullet(),
                          SizedBox(
                            width: ScreenUtil().setWidth(8),
                          ),
                          drawerText(txt: 'Logout', size: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ));
      },
    );
  }

  showUpdateEmailDialogs(BuildContext context, String email) {
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: TextStyle(color: lightRed)),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setStates) {
          return showUpdateEmailDialog();
        });
      },
    );
  }

  showUpdateMobileDialogs(BuildContext context, String mobileString) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setStates) {
          return showUpdateMobileDialog(
            mobile: mobileString,
          );
        });
      },
    );
  }
}
