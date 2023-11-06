import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/common_image.dart';
import '../config/color.dart';
import '../constants.dart';

class ChallengeIconWidget extends StatelessWidget {
  const ChallengeIconWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left:12),
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          gradient: Constants.glassGradient,
          border: Border.all(color:white,width:1),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.10),
              offset: Offset(0,10),
              blurRadius: 30,
            )
          ],
        ),
        child: Center(child: SvgPicture.asset(CommonImage.ic_trend))
    );
  }
}
