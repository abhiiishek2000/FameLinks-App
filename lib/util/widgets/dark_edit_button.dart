import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DarkEditButton extends StatelessWidget {
  const DarkEditButton({Key? key,required this.onPressed,required this.text}) : super(key: key);
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6,vertical: 2),
        decoration: BoxDecoration(
            border: Border.all(color: white.withOpacity(0.50), width: 1),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                  color: black.withOpacity(0.10),
                  offset: Offset(0, 4),
                  blurRadius: 2)
            ]),
        child: Text(text, style: GoogleFonts.nunitoSans(
          fontSize: ScreenUtil().setSp(15),
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.normal,
          color: Colors.white.withOpacity(0.75),
        ),),
      ),
    );
  }
}
