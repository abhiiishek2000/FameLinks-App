import 'package:cached_network_image/cached_network_image.dart';
import 'package:famelink/ui/joblinks/reportDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../networking/config.dart';
import '../../../../../util/config/color.dart';
import '../../../models/BrandAgencyExplore.dart';
import '../provider/brand_explore_provider.dart';

class SavedTalents2 extends StatelessWidget {
  const SavedTalents2({super.key, this.profileList, required this.savedTalentList});

  final List<ProfileModel>? profileList;
  final List<SavedModel> savedTalentList;

  @override
  Widget build(BuildContext context) {
    final brandexprovider =
        Provider.of<BrandExploreProvider>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.zero,
          itemCount: profileList != null && savedTalentList != null
              ? savedTalentList.length >= 5
                  ? 5
                  : savedTalentList.length
              : savedTalentList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h, top: 12.h),
              child: Material(
                elevation: 1.5,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withAlpha(40)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            imageUrl: savedTalentList[index].profileImage !=
                                    null
                                ? savedTalentList[index].profileImageType ==
                                        'avatar'
                                    ? '${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${savedTalentList[index].profileImage}'
                                    : '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${savedTalentList[index].profileImage}'
                                : savedTalentList[index]
                                            .masterProfile!
                                            .profileImageType ==
                                        'avatar'
                                    ? '${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${savedTalentList[index].masterProfile!.profileImage}'
                                    : '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${savedTalentList[index].masterProfile!.profileImage}',
                            imageBuilder: (context, imageProvider) => Container(
                              width: 60.h,
                              height: 60.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                            ),
                            errorWidget: (context, url, error) {
                              print("ER::${error.toString()}");
                              return savedTalentList[index].name!.isEmpty
                                  ? Icon(Icons.error_outline_rounded,
                                      color: black)
                                  : Container(
                                      height: 60.h,
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                        color: darkBlue.withOpacity(0.8),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          savedTalentList[index]
                                              .name![0]
                                              .toString()
                                              .toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w800,
                                            color: white,
                                            fontSize: ScreenUtil().setSp(25),
                                          ),
                                        ),
                                      ),
                                    );
                            },
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    SvgPicture.asset(
                              "assets/icons/svg/icon.svg",
                              height: 60.h,
                              width: 60.w,
                            ),
                            fit: BoxFit.cover,
                            height: ScreenUtil().setHeight(60),
                            width: ScreenUtil().setWidth(60),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 140.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        '${brandexprovider.capitalize(savedTalentList[index].name)}, ${savedTalentList[index].masterProfile!.age} yrs',
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w700,
                                          color: black,
                                          fontSize: ScreenUtil().setSp(14),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ', ${savedTalentList[index].masterProfile!.age} yrs',
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w700,
                                        color: black,
                                        fontSize: ScreenUtil().setSp(14),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xff9B9B9B33)),
                                        child: Text(
                                          'Invite to Job',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            color: darkGray,
                                            fontSize: ScreenUtil().setSp(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 87,
                                      child: Text(
                                        '@${savedTalentList[index].masterProfile!.username}',
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff0060FF),
                                          fontSize: ScreenUtil().setSp(12),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      '${savedTalentList[index].masterProfile!.followersCount}K Followers',
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w400,
                                        color: black,
                                        fontSize: ScreenUtil().setSp(12),
                                      ),
                                    ),
                                    Spacer(),
                                    InkWell(
                                        onTap: () {
                                          //  setState(() {
                                          showGeneralDialog(
                                              context: context,
                                              pageBuilder:
                                                  (BuildContext buildContext,
                                                      Animation animation,
                                                      Animation
                                                          secondaryAnimation) {
                                                return ReportDialog(
                                                    savedTalentList[index]
                                                        .masterProfile!
                                                        .id!,
                                                    'talent');
                                              });
                                          // });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 2.5.h),
                                          child: Icon(Icons.more_vert,
                                              color: lightGray, size: 15.r),
                                        ))
                                  ],
                                ),
                                Text(
                                  savedTalentList[index]
                                      .masterProfile!
                                      .achievements!,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: orange,
                                    fontSize: ScreenUtil().setSp(10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
