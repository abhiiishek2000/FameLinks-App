import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomDark extends StatelessWidget {
  const BottomDark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().setHeight(250),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.75),
                    ],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.clamp),
              ),
            ),
          )
        ]
      ),
    );
  }
}
