import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../util/config/color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Container(
        child: Stack(
          children: [
            // Positioned(
            //   bottom: 84,
            //   right: 12,
            //   child: FloatingActionButton(
            //     backgroundColor: Colors.transparent,
            //     onPressed: () {
            //       // Perform action when button is pressed
            //     },
            //     child: InkWell(
            //       onTap: () {},
            //       child: Image.asset(
            //         'assets/icons/famelinks.png',
            //         height: 98,
            //         width: 98,
            //       ),
            //     ),
            //   ),
            // ),
            Positioned(
              top: 50,
              left: 0,
              child: Padding(
                padding: EdgeInsets.only(left: ScreenUtil().setSp(10)),
                child: InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'assets/icons/Challenges.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              right: 0,
              child: Padding(
                padding: EdgeInsets.only(right: ScreenUtil().setSp(18)),
                child: InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'assets/icons/plusIcon.png',
                    width: 33,
                    height: 33,
                  ),
                ),
              ),
            ),
            // Positioned(
            //     bottom: 95,
            //     child: InkWell(
            //       onTap: () {},
            //       child: Container(
            //         margin: EdgeInsets.only(
            //           bottom: ScreenUtil().setHeight(8),
            //         ),
            //         decoration: BoxDecoration(
            //             color: Colors.white.withOpacity(0.25),
            //             boxShadow: [
            //               BoxShadow(
            //                 blurRadius: 7.0,
            //                 color: black.withOpacity(0.2),
            //                 offset: Offset(2.0, 2.0),
            //               ),
            //             ],
            //             border: Border.all(
            //               color: Colors.white.withOpacity(0.25),
            //             ),
            //             borderRadius: BorderRadius.only(
            //                 topRight: Radius.circular(20),
            //                 bottomRight: Radius.circular(5))),
            //         child: Padding(
            //           padding: EdgeInsets.only(
            //               left: ScreenUtil().setWidth(8),
            //               right: ScreenUtil().setWidth(8),
            //               bottom: ScreenUtil().setHeight(8),
            //               top: ScreenUtil().setHeight(8)),
            //           child: SvgPicture.asset(
            //             "assets/icons/svg/search.svg",
            //             color: white,
            //           ),
            //         ),
            //       ),
            //     )),
            Positioned(
              top: 0,
              right: 0,
              child: Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setSp(91),
                    left: ScreenUtil().setSp(10),
                    right: ScreenUtil().setSp(11),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: DecoratedIcon(
                      Icons.more_vert,
                      color: white,
                      shadows: [
                        BoxShadow(
                          blurRadius: 5.0,
                          color: black.withOpacity(0.5),
                          offset: Offset(1.5, 1.5),
                        ),
                      ],
                    ),
                  )),
            ),
            Positioned(
              bottom: 10,
              left: 23,
              child: Padding(
                padding: EdgeInsets.only(bottom: ScreenUtil().setSp(16)),
                child: InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'assets/icons/message.png',
                    width: 21,
                    height: 21,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 70,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: ScreenUtil().setSp(16),
                ),
                child: InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'assets/icons/share.png',
                    color: Colors.white,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 19,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: ScreenUtil().setSp(16),
                    right: ScreenUtil().setSp(12)),
                child: InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'assets/icons/notifications.png',
                    height: 25,
                    width: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
