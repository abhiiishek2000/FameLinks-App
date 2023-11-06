import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../common/common_image.dart';
import '../config/color.dart';

class InfoIcon extends StatelessWidget {
  const InfoIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        border: Border.all(color: white.withOpacity(0.50),width: 1),
        shape: BoxShape.circle,
        gradient: Constants.glassGradient,
      ),
      child: Center(child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: SvgPicture.asset(CommonImage.ic_info,height: 30,width:15),
      )),
    );
  }
}
