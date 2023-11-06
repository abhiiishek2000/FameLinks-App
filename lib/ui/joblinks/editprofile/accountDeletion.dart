import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountDeletion extends StatefulWidget {
  AccountDeletion({Key? key}) : super(key: key);

  @override
  State<AccountDeletion> createState() => _AccountDeletionState();
}

class _AccountDeletionState extends State<AccountDeletion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(16),
                right: ScreenUtil().setWidth(25),
                top: ScreenUtil().setHeight(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: black,
                      size: ScreenUtil().radius(20),
                    )),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "Account ",
                          style: GoogleFonts.roboto(
                              fontSize: ScreenUtil().setSp(18),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              height: 0.25,
                              color: black),
                        ),
                        TextSpan(
                          text: "Deletion",
                          style: GoogleFonts.roboto(
                            fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            height: 0.25,
                            color: orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.h),
                    Text(
                      "Dear User,\nOnce you delete your account, you will not be able\nto recover you information again.\n\nInstead, you can suspend your account untill next\nlogin attempt.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: black),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Suspend",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: orange),
                    ),
                    SizedBox(height: 44.h),
                    Text(
                      "Or you can hide your account from the public untill\nyou choose to make it public again.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: black),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Make Account Private",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff0060FF)),
                    ),
                    SizedBox(height: 44.h),
                    Text(
                      "If you still wish to delete you account, you will have option to recover the same back within the next 30 days for the date of deletion.\n\nAre you sure you want to delete you account?",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: black),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Yes, Delete my account",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                          color: black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
