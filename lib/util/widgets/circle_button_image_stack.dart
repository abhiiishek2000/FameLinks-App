
import 'package:famelink/common/common_image.dart';
import 'package:flutter/material.dart';

import '../config/color.dart';

class CircleButtonImageStack extends StatelessWidget {
   CircleButtonImageStack({Key? key,this.imgUrl,this.isButtonSelect=false}) : super(key: key);
  String? imgUrl;
  bool isButtonSelect = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            // color: HexColor("#4B4E58"),
              color: (isButtonSelect == true) ? Color(0xffFF9D76) : black),
          /*(HomeDialState
                    .selectRegistration
                    .toString() ==
                    RegistrationType
                        .FAMELinks
                        .toString())*/
          image: DecorationImage(
            image: AssetImage(
              (isButtonSelect == true)
                  ? CommonImage.selected_circle_back
                  : CommonImage.lightButtonBackIcon,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: SizedBox(
            width: 18, //16
            height: 18, //16
            child: Image.asset(
              imgUrl.toString(),
              width: 18, //16
              height: 18, //16
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
