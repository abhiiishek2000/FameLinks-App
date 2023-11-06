import 'package:flutter/material.dart';

import '../../common/common_image.dart';

class CircleImageButton extends StatelessWidget {
   CircleImageButton({Key? key,this.imgUrl,this.isButtonSelect=false,this.onTaps}) : super(key: key);
  String? imgUrl;
  bool isDarkMode = false;
  bool isButtonSelect = false;
  void Function()? onTaps;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTaps,
      child: Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: (isButtonSelect == true)
                ? AssetImage((isButtonSelect == true)
                ? CommonImage.selected_circle_back
                : CommonImage.unSelected_circle_back)
                : AssetImage(
              (isDarkMode == true)
                  ? CommonImage.dark_circle_avatar_back
                  : CommonImage.light_circle_avatar_back,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: 12.0, right: 12.0, top: 15.0, bottom: 15.0),
          child: SizedBox(
            width: 25.63,
            height: 20,
            child: Image.asset(
              imgUrl.toString(),
              width: 25.63,
              height: 20,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
