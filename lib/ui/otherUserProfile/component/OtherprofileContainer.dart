import 'package:flutter/material.dart';

import '../../../util/config/color.dart';

class MyContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;

  MyContainer({this.width, this.height, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: white.withOpacity(0.5), width: 1),
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color.fromRGBO(255, 255, 255, 0.6),
              Color.fromRGBO(255, 255, 255, 0.477083),
              Color.fromRGBO(255, 255, 255, 0.2),
              Color.fromRGBO(255, 255, 255, 0.2),
            ]),
      ),
      child: child,
    );
  }
}
