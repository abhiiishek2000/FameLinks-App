import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridHeader extends StatelessWidget {
  const GridHeader({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.50), width: 1),
        gradient: LinearGradient(
          colors: [
            Color(0xFF8700B7).withOpacity(0.40),
            Color(0xFF288BFF).withOpacity(0.60),
          ],
          tileMode: TileMode.clamp,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      height: 25,
      child: Center(
          child: Text(
        title,
        style: GoogleFonts.nunitoSans(
          color: Colors.white,
          fontSize: 14,
        ),
        overflow: TextOverflow.ellipsis,
      )),
    );
  }
}
