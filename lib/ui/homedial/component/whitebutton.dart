import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:hexcolor/hexcolor.dart';

class WhiteButton extends StatelessWidget {
  final Widget? children;
  final String? text;
  WhiteButton({this.children, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(34),
      width: ScreenUtil().setWidth(164),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: GradientBoxBorder(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                HexColor('#FFA88C'),
                HexColor('#FF5C28'),
              ])),
          gradient: LinearGradient(colors: [
            HexColor('#FFFFFF').withOpacity(0.60),
            HexColor('#FFFFFF').withOpacity(0.4771),
            HexColor('#FFFFFF').withOpacity(0.20),
            HexColor('#FFFFFF').withOpacity(0.20),
          ])),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$text',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: HexColor('#FF5C28'),
              ),
            ),
            children!,
          ]),
    );
  }
}
