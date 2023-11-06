import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../networking/config.dart';
import '../../../util/config/color.dart';
import '../../otherUserProfile/ui/GetParticularUserProfile.dart';
import '../followexploreprovider.dart';

class followlinksayhi extends StatelessWidget {
  const followlinksayhi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Followexploreprovider>(
      builder: (context, provider, child) {
        return provider.loadsayhi
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: provider.followlinkExploresayhi!.result!.length,
                scrollDirection: Axis.horizontal,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      Widget? myrput;
                      if (provider.followlinkExploresayhi!.result![i].type ==
                          "famelinks") {
                        myrput = GetParticularUserProfile();
                      } else if (provider
                              .followlinkExploresayhi!.result![i].type ==
                          "funlinks") {
                        myrput = GetParticularUserProfile();
                      } else if (provider
                              .followlinkExploresayhi!.result![i].type ==
                          "followlinks") {
                        myrput = GetParticularUserProfile();
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => myrput!),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Container(
                            height: ScreenUtil().setHeight(116),
                            width: ScreenUtil().setWidth(110),
                            child: Stack(
                              children: [
                                Image.asset("assets/icons/rect.png"),
                                Positioned(
                                  top: 6.5.h,
                                  left: 3.w,
                                  child: Image.network(
                                    "${ApiProvider.s3UrlPath}/${provider!.followlinkExploresayhi!.result![i].type}-posts/${provider!.followlinkExploresayhi!.result![i].path}-xs",
                                    height: ScreenUtil().setHeight(105),
                                    width: ScreenUtil().setWidth(105),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: ScreenUtil().setHeight(105),
                                    width: ScreenUtil().setWidth(105),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: white.withOpacity(0.5),
                                            width: 2.w)),
                                    child: Icon(Icons.play_arrow,
                                        color: white.withOpacity(0.5)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: Text(
                            provider.followlinkExploresayhi!.result![i].name
                                .toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              color: darkGray,
                              fontSize: ScreenUtil().setSp(13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
      },
    );
  }
}
