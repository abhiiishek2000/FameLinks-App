import 'package:flutter/material.dart';

class drawerText extends StatelessWidget {
  drawerText({Key? key, required this.txt, required this.size})
      : super(key: key);
  final String txt;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      txt ?? '',
      style: TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: size ?? 12.0,
        height: 1.25,
        color: Colors.black,
        letterSpacing: 0.06,
        shadows: [
          Shadow(
            offset: Offset(0, 2),
            blurRadius: 2,
            color: Color.fromRGBO(0, 0, 0, 0.25),
          ),
        ],
      ),
      textAlign: TextAlign.center,
      softWrap: true,
    );
  }
}
