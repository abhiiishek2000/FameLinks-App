import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/common_image.dart';
import '../../Famelinkprofile/function/famelinkFun.dart';

class circleButtonImageWhitemode extends StatelessWidget {
  circleButtonImageWhitemode(
      {Key? key, this.imgUrl, this.isButtonSelect, this.onTaps})
      : super(key: key);
  final String? imgUrl;
  final bool? isButtonSelect;
  void Function()? onTaps;
  @override
  Widget build(BuildContext context) {
    final fameLinkFun = Provider.of<FameLinkFun>(context, listen: false);

    return InkWell(
      key: key,
      onTap: onTaps,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: (isButtonSelect == true)
                ? AssetImage((isButtonSelect == true)
                    ? CommonImage.selected_circle_back
                    : CommonImage.unSelected_circle_back)
                : AssetImage(
                    (fameLinkFun!.isDarkMode == false)
                        ? CommonImage.dark_circle_avatar_back
                        : CommonImage.light_circle_avatar_back,
                  ),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0), //18
          child: SizedBox(
            key: key,
            width: 30,
            height: 28,
            child: Image.asset(
              imgUrl.toString(),
              width: 30,
              height: 28,
              color: Colors.grey,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
