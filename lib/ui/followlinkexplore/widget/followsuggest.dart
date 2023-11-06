import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../networking/config.dart';
import '../../../util/config/color.dart';
import '../followexploreprovider.dart';

class followsuggest extends StatelessWidget {
  const followsuggest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Followexploreprovider>(
      builder: (context, provider, child) {
        return provider.loadfollow
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: provider.followsuggestionsmodel!.result!.length,
                scrollDirection: Axis.horizontal,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.w, top: 20.h),
                        child: Container(
                            height: ScreenUtil().setHeight(108),
                            width: ScreenUtil().setWidth(108),
                            child: Image.network(
                              "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider!.followsuggestionsmodel!.result![i].profileImage}",
                              fit: BoxFit.cover,
                            )),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      Text(
                        provider.followsuggestionsmodel!.result![i].name
                            .toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          color: darkGray,
                          fontSize: ScreenUtil().setSp(13),
                          height: 0.19,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: () {
                          provider.getFollowStatus(provider
                              .followsuggestionsmodel!.result![i].id
                              .toString());
                        },
                        child: Container(
                          height: 25.h,
                          width: 65.w,
                          decoration: BoxDecoration(
                            color: white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: lightGray),
                          ),
                          child: Center(
                            child: Text(
                              'Follow',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w400,
                                color: orange,
                                fontSize: ScreenUtil().setSp(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                });
      },
    );
  }
}
