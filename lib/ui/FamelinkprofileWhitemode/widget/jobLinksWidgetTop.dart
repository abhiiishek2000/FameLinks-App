import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../util/config/color.dart';

class jobLinksWidgetTopWhitemode extends StatelessWidget {
  const jobLinksWidgetTopWhitemode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.only(top: 60.h, bottom: 18.h),
      child: Container(
          child: Text("Coming Soon",
              style: TextStyle(
                  color: orange,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500))),
    ));
  }
}
