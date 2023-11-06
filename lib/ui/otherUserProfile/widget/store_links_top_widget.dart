import 'package:famelink/main.dart';
import 'package:famelink/ui/otherUserProfile/provder/OtherPofileprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../common/common_image.dart';
import '../../../util/config/color.dart';
import '../../otherUserProfile/component/OtherprofileContainer.dart';
import '../../otherUserProfile/component/drawerText.dart';


class OtherStoreLinksTopWidget extends StatelessWidget {
  const OtherStoreLinksTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OtherPofileprovider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 11),
          child: MyContainer(
            height: 74.h,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(top: 8.h, left: 8.w, right: 8.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      provider.store.isNotEmpty
                          ? ShadowText(
                          txt: provider.store[0].visits!.toString(),
                          size: ScreenUtil().setSp(14),
                          fontColor: Colors.black,
                          weight: FontWeight.bold)
                          : Text(
                        "",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 8.h, //2
                      ),
                      Row(children: [
                        SvgPicture.asset(
                          CommonImage.visit,
                          height: 14.h,
                          width: 14.w,
                        ),
                        SizedBox(width: 4.w),
                        provider.userDetails!.type == 'brand' ||
                            provider.userDetails!.type == 'agency'
                            ? ShadowText(
                          txt: provider.userDetails!.type == 'brand'
                              ? 'Visits'
                              : 'Collabs',
                          fontColor: white,
                          weight: FontWeight.w700,
                          size: ScreenUtil().setSp(12),
                        )
                            : Container(),
                      ]),
                    ],
                  ),
                  Container(
                      width: 1,
                      height: 32.h,
                      color: Colors.white.withOpacity(0.25)),
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          provider.store.isNotEmpty
                              ? ShadowText(
                              txt: provider.store[0].urlVisits!.toString(),
                              size: ScreenUtil().setSp(14),
                              fontColor: Colors.black,
                              weight: FontWeight.bold)
                              : Text(
                            "",
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          SizedBox(width: 4.w),
                          SvgPicture.asset(
                            CommonImage.url,
                            height: 14.h,
                            width: 14.w,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h, //2
                      ),
                      ShadowText(
                        txt: 'URL Visits',
                        fontColor: white,
                        weight: FontWeight.normal,
                        size: ScreenUtil().setSp(12),
                      )
                    ],
                  ),
                  Container(
                      width: 1,
                      height: 32.h,
                      color: Colors.white.withOpacity(0.25)),
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          provider.store.isNotEmpty
                              ? ShadowText(
                              txt: "0",
                              size: ScreenUtil().setSp(14),
                              fontColor: Colors.black,
                              weight: FontWeight.bold)
                              : Text(
                            "",
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          SizedBox(width: 4.w),
                          SvgPicture.asset(
                            CommonImage.ic_trend,
                            height: 14.h,
                            width: 14.w,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h, //2
                      ),
                      ShadowText(
                        txt: 'Trendz Sponsored',
                        fontColor: white,
                        weight: FontWeight.normal,
                        size: ScreenUtil().setSp(12),
                      ),
                      SizedBox(
                        height: 5.h, //2
                      ),
                      Icon(Icons.keyboard_arrow_down_outlined, color: white)
                    ],
                  ),
                  Container(
                      width: 1,
                      height: 32.h,
                      color: Colors.white.withOpacity(0.25)),
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      provider.store.isNotEmpty
                          ? ShadowText(
                          txt: provider.store[0].productCount!.toString(),
                          size: ScreenUtil().setSp(14),
                          fontColor: Colors.black,
                          weight: FontWeight.bold)
                          : Text(
                        "",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 8.h, //2
                      ),
                      ShadowText(
                        txt: 'Products',
                        fontColor: white,
                        weight: FontWeight.normal,
                        size: ScreenUtil().setSp(12),
                      ),
                      SizedBox(
                        height: 5.h, //2
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: white,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
