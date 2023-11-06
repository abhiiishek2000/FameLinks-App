import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:hexcolor/hexcolor.dart';

class darkcircleButtonImageStack extends StatelessWidget {
  darkcircleButtonImageStack({Key? key, required this.imgUrl})
      : super(key: key);
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: HexColor('#4B4E58'),
        border: GradientBoxBorder(
            gradient: LinearGradient(colors: [
          HexColor('#FFA88C'),
          HexColor('#FF5C28'),
        ])),
      ),
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: SvgPicture.asset(
          imgUrl.toString(),
          width: 16,
          height: 16,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
