import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../config/color.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          gradient: Constants.glassGradient,
          border: GradientBoxBorder(
            gradient: Constants.appThemeGradient,
          ),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.25),
              offset: Offset(0, 4),
              blurRadius: 4,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: Text(text,
              style: GoogleFonts.nunitoSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: white,
              )),
        ),
      ),
    );
  }
}
