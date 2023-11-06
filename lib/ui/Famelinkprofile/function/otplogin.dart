import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../databse/AppDatabase.dart';
import '../../../dio/api/api.dart';
import '../../../models/login_model.dart';
import '../../../models/register_response.dart';
import '../../../providers/UserProfileProvider/userProfile_provider.dart';
import '../../../util/config/color.dart';
import '../../../util/constants.dart';
import '../../authentication/login_screen.dart';

class Otplogin extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpNumber = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController phoneCodeNumber = TextEditingController();
  TextEditingController plusCodeNumber = TextEditingController();

  bool isOTPEmailLogin = false;
  Timer? timer;
  int start = 30;
  bool isOTPLogin = false;
  String otpHash = "";

  setval(bool val) {
    isOTPEmailLogin = val;
    notifyListeners();
  }

  _emailLoginService(BuildContext context) async {
    Map<String, dynamic> map = {"email": emailController.text};
    Api.patch.call(context, method: "users/email", param: map,
        onResponseSuccess: (Map object) async {
      var result = LoginResponse.fromJson(object);
      this.otpHash = result.result!.otpHash!;
      // setStates(() {
      isOTPEmailLogin = true;
    });
    startTimer();
    //});
    notifyListeners();
  }

  void startTimer() {
    if (isOTPLogin) {
      if (timer != null) {
        timer!.cancel();
        timer = null;
      } else {
        timer = new Timer.periodic(
          const Duration(seconds: 1),
          (Timer timer) => () {
            if (start < 1) {
              timer.cancel();
              // timer = null;
            } else {
              start = start - 1;
            }
            notifyListeners();
          },
        );
      }
    }
  }

  loginService(BuildContext context) async {
    Map<String, dynamic> map = {
      "mobileNumber": phoneNumber.text,
      "code": phoneCodeNumber.text
    };
    Api.post.call(context, method: "users/contact", param: map,
        onResponseSuccess: (Map object) async {
      var result = LoginResponse.fromJson(object);
      this.otpHash = result.result!.otpHash!;
      // setStates(() {
      isOTPLogin = true;
      // });
      startTimer();
    });
    notifyListeners();
  }

  Future<void> handleOTPIn(BuildContext context) async {
    if (otpNumber.text.length != 6) {
      //_mobileVerify();
      Constants.toastMessage(msg: "Enter 6-digit code!");
    } else {
      Map<String, dynamic> map = {
        "otp": int.parse(otpNumber.text),
        "otpHash": otpHash
      };
      Api.post.call(context, method: "users/contact/verify", param: map,
          onResponseSuccess: (Map object) async {
        var result = RegisterResponse.fromJson(object);
        isOTPLogin = false;
        Navigator.pop(context);
        Constants.toastMessage(msg: result.message);
      });
    }
    notifyListeners();
  }

  Future<void> handleOTPEmailIn(BuildContext context) async {
    if (otpNumber.text.length != 6) {
      Constants.toastMessage(msg: "Enter 6-digit code!");
    } else {
      Map<String, dynamic> map = {
        "otp": int.parse(otpNumber.text),
        "otpHash": otpHash
      };
      Api.post.call(context, method: "users/email/verify", param: map,
          onResponseSuccess: (Map object) async {
        var result = RegisterResponse.fromJson(object);
        isOTPEmailLogin = false;
        Navigator.pop(context);
        Constants.toastMessage(msg: result.message);
      });
    }
    notifyListeners();
  }

  emailLoginService(BuildContext context) async {
    Map<String, dynamic> map = {"email": emailController.text};
    Api.patch.call(context, method: "users/email", param: map,
        onResponseSuccess: (Map object) async {
      var result = LoginResponse.fromJson(object);
      this.otpHash = result.result!.otpHash!;

      isOTPEmailLogin = true;

      startTimer();
      notifyListeners();
    });
  }

  Future<bool?> isLogout(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Are you sure you won't to logout this app?"),
          actions: [
            TextButton(
              child:
                  Text("Yes", style: GoogleFonts.nunitoSans(color: lightRed)),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                GoogleSignIn _googleSignIn = GoogleSignIn(
                  // Optional clientId
                  //'786730059051-7rb21ektitej7g81hcl5qfsp1ij7d03i.apps.googleusercontent.com'
                  clientId:
                      '786730059051-gobl798lj91j1jgt7de7q6o4i8r1iu2o.apps.googleusercontent.com',
                  scopes: <String>[
                    'email',
                    'https://www.googleapis.com/auth/contacts.readonly',
                  ],
                );
                prefs.clear();
                AppDatabase.database.deleteFameLink();
                AppDatabase.database.deleteFunLink();
                AppDatabase.database.deleteFollowLink();
                await _googleSignIn.signOut();
                Provider.of<UserProfileProvider>(context, listen: false)
                    .changeIsDrawerOpen(false);
                return Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => LoginScreen()),
                  ModalRoute.withName('/'),
                );
              },
            ),
            TextButton(
              child: Text("No", style: GoogleFonts.nunitoSans(color: lightRed)),
              onPressed: () async {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
        ;
      },
    );
  }
}
