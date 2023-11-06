import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class circleButtonImageStack extends StatelessWidget {
  circleButtonImageStack({Key? key, required this.imgUrl}) : super(key: key);
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: [
          HexColor('##FFFFFF').withOpacity(0.60),
          HexColor('##FFFFFF').withOpacity(0.47),
          HexColor('##FFFFFF').withOpacity(0.20),
          HexColor('##FFFFFF').withOpacity(0.20)
        ]),
        border: Border.all(color: HexColor("#FFFFFF").withOpacity(0.50)),
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
