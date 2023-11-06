import 'package:famelink/util/opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'config/color.dart';
import 'dimens.dart';

class Sty {
  TextStyle microText = GoogleFonts.nunitoSans(
    color: lightGray,
    fontSize: ScreenUtil().setSp(10),
    fontWeight: FontWeight.w300,
    shadows: [
      Shadow(
        offset: Offset(Dim().d0.w, Dim().d2.h),
        blurRadius: Dim().d2.r,
        color: black.withOpacity(Opc().o25),
      )
    ],
  );

  TextStyle smallText = GoogleFonts.nunitoSans(
    color: lightGray,
    fontSize: ScreenUtil().setSp(12),
    fontWeight: FontWeight.w300,
    shadows: [
      Shadow(
        offset: Offset(Dim().d0.w, Dim().d2.h),
        blurRadius: Dim().d2.r,
        color: black.withOpacity(Opc().o25),
      )
    ],
  );

  TextStyle mediumText = GoogleFonts.nunitoSans(
    color: lightGray,
    fontSize: ScreenUtil().setSp(14),
    fontWeight: FontWeight.w400,
    shadows: [
      Shadow(
        offset: Offset(Dim().d0.w, Dim().d2.h),
        blurRadius: Dim().d2.r,
        color: black.withOpacity(Opc().o25),
      )
    ],
  );

  TextStyle mediumBoldText = GoogleFonts.nunitoSans(
    color: lightGray,
    fontSize: ScreenUtil().setSp(16),
    fontWeight: FontWeight.w700,
    shadows: [
      Shadow(
        offset: Offset(0.0, 2.0),
        blurRadius: 2.0,
        color: black.withOpacity(Opc().o25),
      )
    ],
  );

  TextStyle largeText = GoogleFonts.nunitoSans(
    color: lightGray,
    fontSize: ScreenUtil().setSp(18),
    fontWeight: FontWeight.w400,
    shadows: [
      Shadow(
        offset: Offset(Dim().d0.w, Dim().d2.h),
        blurRadius: Dim().d2.r,
        color: black.withOpacity(Opc().o25),
      )
    ],
  );

  TextStyle extraLargeText = GoogleFonts.nunitoSans(
    color: lightGray,
    fontSize: ScreenUtil().setSp(22),
    fontWeight: FontWeight.w700,
    shadows: [
      Shadow(
        offset: Offset(Dim().d0.w, Dim().d2.h),
        blurRadius: Dim().d2.r,
        color: black.withOpacity(Opc().o25),
      )
    ],
  );

  TextStyle toolbarText = GoogleFonts.nunitoSans(
    fontSize: ScreenUtil().setSp(14),
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: lightGray,
    shadows: [
      Shadow(
        offset: Offset(0, 2),
        blurRadius: 2.0,
        color: Clr().black.withOpacity(Opc().o25),
      )
    ],
  );

  Shadow textShadow = Shadow(
    offset: Offset(0, 2),
    blurRadius: 2.0,
    color: Clr().black.withOpacity(Opc().o25),
  );

  BoxDecoration feedCardDecoration = BoxDecoration(
    color: white.withOpacity(Opc().o20),
    borderRadius: BorderRadius.circular(
      Dim().d12,
    ),
    border: Border.all(
      color: white.withOpacity(Opc().o20),
    ),
  );

  BoxDecoration verticalLineDecoration = BoxDecoration(
    color: white,
    boxShadow: [
      BoxShadow(
        offset: Offset(Dim().d0, Dim().d2),
        color: white,
        blurRadius: Dim().d2.r,
      ),
    ],
  );

  BoxDecoration footerDecoration = BoxDecoration(
    color: white.withOpacity(Opc().o60),
    borderRadius: BorderRadius.circular(Dim().d12),
    boxShadow: [
      BoxShadow(
        offset: Offset(Dim().d0, Dim().d8),
        blurRadius: Dim().d32.r,
        color: black.withOpacity(Opc().o40),
      ),
    ],
  );

  Container footerBoxLayout({required child}) {
    return Container(
      padding: EdgeInsets.all(
        ScreenUtil().setHeight(Dim().d12),
      ),
      decoration: BoxDecoration(
        color: white.withOpacity(Opc().o60),
        borderRadius: BorderRadius.circular(Dim().d12),
        boxShadow: [
          BoxShadow(
            offset: Offset(Dim().d0, Dim().d8),
            blurRadius: Dim().d32,
            color: black.withOpacity(Opc().o40),
          ),
        ],
      ),
      child: child,
    );
  }
}
