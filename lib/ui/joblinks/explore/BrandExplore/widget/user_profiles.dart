import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../networking/config.dart';
import '../../../../../util/config/color.dart';
import '../../../models/BrandAgencyExplore.dart';

class UserProfiles extends StatelessWidget {
  const UserProfiles({super.key, required this.profileList, this.savedTalentList});
  final List<ProfileModel> profileList;
  final List<SavedModel>? savedTalentList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 22.w, right: 22.w),
      child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.zero,
          itemCount: profileList != null && savedTalentList != null
              ? profileList.length >= 5
                  ? 5
                  : profileList.length
              : profileList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // profileList[index].profileImage == null ? Container() :
                      CachedNetworkImage(
                        imageUrl: profileList[index].profileImageType ==
                                'avatar'
                            ? '${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${profileList[index].profileImage}'
                            : '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${profileList[index].profileImage}',
                        imageBuilder: (context, imageProvider) => Container(
                          width: 40.h,
                          height: 40.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                        ),
                        errorWidget: (context, url, error) {
                          print("ER::${error.toString()}");
                          return profileList[index].name!.isEmpty
                              ? Icon(Icons.error_outline_rounded, color: black)
                              : Container(
                                  height: 40.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                    color: darkBlue.withOpacity(0.8),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      profileList[index]
                                          .name![0]
                                          .toString()
                                          .toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w700,
                                        color: white,
                                        fontSize: ScreenUtil().setSp(20),
                                      ),
                                    ),
                                  ),
                                );
                        },
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                SvgPicture.asset(
                          "assets/icons/svg/icon.svg",
                          height: 40.h,
                          width: 40.w,
                        ),
                        fit: BoxFit.cover,
                        height: ScreenUtil().setHeight(40),
                        width: ScreenUtil().setWidth(40),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profileList[index].name!,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w400,
                                color: black,
                                fontSize: ScreenUtil().setSp(12),
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              '${profileList[index].achievements}',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w400,
                                color: lightGray,
                                fontSize: ScreenUtil().setSp(10),
                              ),
                            ),
                            SizedBox(height: 8.h),
                          ]),
                      Spacer(),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          profileList[index].invitation == true
                              ? 'Invited'
                              : 'Invite to Job',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            color: Color(0xff0060FF),
                            fontSize: ScreenUtil().setSp(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 1.h,
                    width: MediaQuery.of(context).size.width,
                    color: lightGray,
                  )
                ],
              ),
            );
          }),
    );
  }
}
