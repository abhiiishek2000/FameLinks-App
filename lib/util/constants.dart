import 'dart:io';
import 'package:dio/dio.dart';
import 'package:famelink/util/AdHelper.dart';
import 'package:famelink/util/config/color.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Constants {
  //static final String baseUrl = 'http://famelinks.in/v2/';
  static const int NORMAL_VALIDATION = 1;
  static const int EMAIL_VALIDATION = 2;
  static const int PHONE_VALIDATION = 3;
  static const int PHONE_OR_EMAIL_VALIDATION = 4;
  static const int PASSWORD_VALIDATION = 5;
  static const int ZIP_VALIDATION = 6;
  static const int MIN_CHAR_VALIDATION = 7;
  static int page = 1;
  static String firstName = "";
  static String otp = "";
  static String otpHash = "";
  static String district = "";
  static String state = "";
  static String country = "";
  static int todayPosts = 0;
  static int fameCoins = 0;
  static bool isVerified = false;
  static String verificationStatus = "";
  static dynamic token;
  static dynamic userId;
  static dynamic userType;
  static dynamic profileUserId;
  static int retries = 0;
  static int registered = 0;
  static String appBarTitle = "";
  static String bearerToken = "";
  static int finalStatus = 0;
  static int type = 3;
  static bool following = false;
  static bool isRegisterdForContest = true;
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  static int re_tries = 0;

  static MultipartFile? profileImage;
  static MultipartFile? closeUp;
  static MultipartFile? medium;
  static MultipartFile? long;
  static MultipartFile? pose1;
  static MultipartFile? pose2;
  static MultipartFile? additional;
  static MultipartFile? video;
  static BuildContext? dialogContext;
  static bool initialized = false;
  static bool playing = true;
  static bool isReversed = false;
  static bool isClicked = false;
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    
  static toastMessage({String? msg}) {
    Fluttertoast.showToast(
        msg: msg!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.grey[600],
        textColor: Colors.white,
        fontSize: 15.0);
  }

  static Gradient glassGradient = LinearGradient(
    colors: [
      Color(0xFFFFFFFF).withOpacity(0.6),
      Color(0xFFFFFFFF).withOpacity(0.4771),
      Color(0xFFFFFFFF).withOpacity(0.2),
      Color(0xFFFFFFFF).withOpacity(0.2),
    ],
    stops: [0, 0.307292, 1, 1],
  );
  static Gradient appThemeGradient = LinearGradient(
    colors: [
      Color(0xFFFFA88C),
      Color(0xFFFF5C28),
    ],
    stops: [0.114583, 0.671875],
  );

  static Future<bool> isInternetAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static progressDialog(bool isLoading, BuildContext context) {
    if (!isLoading) {
      // if(dialogContext != null) {
      //   Navigator.of(dialogContext).pop();
      // }
      print("vv");
    } else {
      print("vv");
      // showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       dialogContext = context;
      //       return Dialog(
      //           elevation: 0,
      //           backgroundColor: Colors.transparent,
      //           insetPadding: EdgeInsets.only(
      //             top:ScreenUtil()
      //                 .setHeight((ScreenUtil().screenHeight - 70) / 2),
      //               bottom:ScreenUtil()
      //                 .setHeight((ScreenUtil().screenHeight - 70) / 2),
      //               left: ScreenUtil()
      //                   .setWidth((ScreenUtil().screenWidth - 70) / 2),
      //               right: ScreenUtil()
      //                   .setWidth((ScreenUtil().screenWidth - 70) / 2)),
      //           child: StatefulBuilder(
      //               builder: (BuildContext context, StateSetter setStates) {
      //                 return Container(
      //                   child: Center(
      //                       child: CircularProgressIndicator(
      //                           backgroundColor: Colors.white)),
      //                 );
      //           }));
      //     }).then((value) => dialogContext = null);
    }
  }

  static progressDialog1(bool isLoading, BuildContext context) {
    if (!isLoading) {
      if(dialogContext != null) {
        Navigator.of(dialogContext!).pop();
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            dialogContext = context;
            return Dialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.only(
                  top:ScreenUtil()
                      .setHeight((ScreenUtil().screenHeight - 70) / 2),
                    bottom:ScreenUtil()
                      .setHeight((ScreenUtil().screenHeight - 70) / 2),
                    left: ScreenUtil()
                        .setWidth((ScreenUtil().screenWidth - 70) / 2),
                    right: ScreenUtil()
                        .setWidth((ScreenUtil().screenWidth - 70) / 2)),
                child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setStates) {
                      return Container(
                        child: Center(
                            child: CircularProgressIndicator(
                                backgroundColor: Colors.white)),
                      );
                }));
          }).then((value) => dialogContext = null);
    }
  }
}
