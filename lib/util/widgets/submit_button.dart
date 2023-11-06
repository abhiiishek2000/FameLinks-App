import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/color.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.h),
        padding: EdgeInsets.only(right: 8.w),
        height: ScreenUtil().setHeight(34),
        width: ScreenUtil().setHeight(154),
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.1),
              offset: Offset(0, 2),
              blurRadius: 4,
            )
          ],
          border: GradientBoxBorder(
            gradient: Constants.appThemeGradient,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(),
            Row(
              children: [
                Text(text,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: orange,
                    )),
                SizedBox(width: 29.w),
                Icon(
                  Icons.arrow_forward,
                  color: orange,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
