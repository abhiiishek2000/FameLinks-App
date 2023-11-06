import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class drawerDivider extends StatelessWidget {
  const drawerDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.h,
      decoration: BoxDecoration(
        color: Color(0xff9B9B9B),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 2,
            color: Color.fromRGBO(0, 0, 0, 0.25),
          ),
        ],
      ),
    );
  }
}
