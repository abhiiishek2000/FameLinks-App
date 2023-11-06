import 'dart:async';

import 'package:famelink/models/Profile_Model.dart';
import 'package:famelink/providers/AuthProvider/auth_provider.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  String? otpHash;

  OTPScreen({Key? key, this.otpHash}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpNumber = TextEditingController();

  //MyProfileResult? myProfileResult;

  String? token = "";

  Timer? _timer;
  int? _start = 30;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // margin:
        // EdgeInsets.only(top: (MediaQuery.of(context).size.height / 3) - 20),
        child: SingleChildScrollView(
          child: Column(
            //stack
            children: [
              // 48 se 63
              Container(
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        //height: 600,
                        //width: 700,
                        child: Image.asset(
                          "assets/images/model.png",
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: (MediaQuery.of(context).size.height / 2) - 50),
                        width: ScreenUtil().setSp(100),
                        height: ScreenUtil().setSp(100),
                        padding: EdgeInsets.all(ScreenUtil().setSp(18)),
                        decoration: new BoxDecoration(
                          border: Border.all(
                              color: Colors.white,
                              width: ScreenUtil().setSp(2)),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [lightRedWhite, lightRed]),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                            "assets/icons/svg/logo_splash.svg"),
                        //stack child end
                      ),
                    ),
                  ],
                ),
              ),
              //column start
              //child start
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: ScreenUtil().setWidth(350),
                    height: ScreenUtil().setHeight(50),
                    child: Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: "Fame",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w700,
                              fontSize: ScreenUtil().setSp(36),
                              color: lightRed,
                              shadows: [
                                Shadow(
                                  offset: Offset(0.0, 2.0), //position of shadow
                                  blurRadius: 2.0, //blur intensity of shadow
                                  color: Colors.black.withOpacity(
                                      0.6), //color of shadow with opacity
                                ),

                                //add more shadow with different position offset here
                              ])),
                      TextSpan(
                          text: "Links",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w700,
                              fontSize: ScreenUtil().setSp(36),
                              color: black,
                              shadows: [
                                Shadow(
                                  offset: Offset(0.0, 2.0), //position of shadow
                                  blurRadius: 2.0, //blur intensity of shadow
                                  color: Colors.black.withOpacity(
                                      0.6), //color of shadow with opacity
                                ),

                                //add more shadow with different position offset here
                              ]))
                    ])),
                  ),
                ],
              ),
              SizedBox(
                height: 1,
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(42),
                    ScreenUtil().setWidth(32), ScreenUtil().setWidth(42), 0),
                child: Column(
                  children: [
                    enterOTPNumber(),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _start! > 0
                            ? Text.rich(
                                TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: 'Resend OTP in ',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          color: darkGray,
                                          fontSize: ScreenUtil().setSp(12))),
                                  TextSpan(
                                      text: '${_start}',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: ScreenUtil().setSp(12),
                                          color: lightRed))
                                ]),
                                textAlign: TextAlign.end)
                            : InkWell(
                                onTap: () {
                                  _start = 30;
                                  startTimer();
                                },
                                child: Text('Resend OTP',
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        color: lightRed,
                                        fontSize: ScreenUtil().setSp(12))),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(96),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: buttonBlue)),
                  Text(
                    'Back',
                    style: GoogleFonts.nunitoSans(
                        fontSize: ScreenUtil().setSp(16), color: buttonBlue),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget enterOTPNumber() {
    return TextFormField(
      inputFormatters: [
        new LengthLimitingTextInputFormatter(6),
      ],
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      controller: otpNumber,
      autofocus: true,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color.fromARGB(255, 122, 131, 255)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: lightGray),
          ),
          contentPadding: EdgeInsets.only(left: ScreenUtil().setWidth(8)),
          hintText: 'Enter OTP',
          hintStyle: GoogleFonts.nunitoSans(
              fontSize: ScreenUtil().setSp(16),
              color: darkGray,
              fontWeight: FontWeight.w400),
          prefixIcon: IconButton(
            onPressed: () async {},
            padding: EdgeInsets.all(0),
            icon: SvgPicture.asset("assets/icons/svg/keyOtp.svg"),
          ),
          suffixIcon:
              Consumer<AuthenticationProvider>(builder: (context, auth, child) {
            return auth.isLoading == true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                        width: 20.h,
                        child: CircularProgressIndicator(
                          semanticsLabel: 'Verify....',
                          strokeWidth: 3,
                          color: orange,
                        ),
                      ),
                    ],
                  )
                : IconButton(
                    onPressed: () async {
                      Constants.firebaseMessaging.requestPermission(
                        sound: true,
                        badge: true,
                        alert: true,
                      );
                      Constants.firebaseMessaging
                          .getToken()
                          .then((token) async {
                        this.token = token!; // Print the Token in Console
                        if (otpNumber.text.length != 6) {
                          //_mobileVerify();
                          Constants.toastMessage(msg: "Enter 6-digit code!");
                        } else {
                          auth.otpVerification(
                              otp: otpNumber.text,
                              pushToken: token,
                              otpHash: widget.otpHash!,
                              context: context);
                        }
                      });
                    },
                    icon: Icon(
                      Icons.arrow_forward_rounded,
                      color: darkGray,
                    ),
                  );
          })),
    );
  }

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    } else {
      _timer = new Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) => setState(
          () {
            if (_start! < 1) {
              timer.cancel();
              _timer = null;
            } else {
              _start = _start! - 1;
            }
          },
        ),
      );
    }
  }
}
