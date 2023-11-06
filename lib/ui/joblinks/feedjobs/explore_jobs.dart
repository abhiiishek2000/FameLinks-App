import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/joblinks/feedjobs/provider/feed_provider.dart';
import 'package:famelink/ui/joblinks/models/joblinkfeedmodel.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../manager/static_method.dart';
import '../../../share/firebasedynamiclink.dart';
import '../../../util/colors.dart';
import '../../../util/styles.dart';

class ExploreJobs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobLinksFeedProvider>(
      builder: (context, provider, widget) {
        return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(
            ScreenUtil().setHeight(Dim().d12),
          ),
          itemCount: provider.exploreJobList.length,
          itemBuilder: (context, index) {
            return itemLayout(context, provider, index);
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: ScreenUtil().setHeight(Dim().d12),
            );
          },
        );
      },
    );
  }

  Widget itemLayout(context, JobLinksFeedProvider provider, index) {
    ExploreJobsModel v = provider.exploreJobList[index];
    return Container(
      decoration: Sty().feedCardDecoration,
      child: Column(
        children: [
          SizedBox(
            height: Dim().d12.h,
          ),
          headerLayout(provider, v),
          SizedBox(
            height: Dim().d8.h,
          ),
          bodyLayout(context, provider, v, index),
          SizedBox(
            height: Dim().d16.h,
          ),
          actionLayout(context, provider, v, index),
          SizedBox(
            height: Dim().d12.h,
          ),
          if (v.createdBy != null && v.createdBy![0].name!.isNotEmpty)
            footerLayout(v),
        ],
      ),
    );
  }

  Widget headerLayout(provider, ExploreJobsModel v) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dim().d16.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IntrinsicWidth(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: Dim().d12.w),
                      child: v.jobType == "crew"
                          ? Text(
                              '${v.experienceLevel}',
                              style: Sty().mediumBoldText.copyWith(
                                    color: Clr().white,
                                  ),
                            )
                          : Row(
                              children: [
                                Text(
                                  "${v.gender}, ${provider.ageGroup[0][v.ageGroup.toString()]} yrs",
                                  style: Sty().mediumBoldText.copyWith(
                                        color: Clr().white,
                                      ),
                                ),
                                SizedBox(
                                  width: Dim().d12.w,
                                ),
                                Text(
                                  '${v.height!.foot}’${v.height!.inch}"',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w500,
                                    color: black,
                                    fontSize: ScreenUtil().setSp(16),
                                    shadows: [Sty().textShadow],
                                  ),
                                ),
                              ],
                            ),
                    ),
                    SizedBox(
                      height: Dim().d12.h,
                    ),
                    Container(
                      height: 1,
                      decoration: Sty().verticalLineDecoration,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: Dim().d4.h,
                  ),
                  SvgPicture.asset(
                    "assets/icons/svg/photoshoot.svg",
                    color: orange,
                  ),
                  SizedBox(
                    height: Dim().d8.h,
                  ),
                  Text(
                    '${v.jobDetails!.isNotEmpty ? v.jobDetails![0].jobName : ''}',
                    style: Sty().smallText.copyWith(
                          fontWeight: FontWeight.w400,
                          color: white,
                          height: 0.16,
                        ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: Dim().d8.h,
          ),
          Text(
            '${v.jobLocation!.district}',
            style: Sty().mediumBoldText.copyWith(
                  color: Clr().white,
                  fontSize: ScreenUtil().setSp(14),
                ),
          ),
        ],
      ),
    );
  }

  Widget bodyLayout(
      context, JobLinksFeedProvider provider, ExploreJobsModel v, index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
          visible: v.selectedPage == 1,
          maintainSize: true,
          maintainState: true,
          maintainAnimation: true,
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: white.withOpacity(0.8),
            size: Dim().d16.w,
          ),
        ),
        Expanded(
          child: SizedBox(
            height: Dim().d84.h,
            child: PageView(
              physics: BouncingScrollPhysics(),
              onPageChanged: (i) {
                provider.updateExploreSlider(index);
              },
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${v.title}',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: Sty().mediumBoldText.copyWith(
                            fontSize: ScreenUtil().setSp(22),
                            height: 1.2,
                            color: Clr().white,
                          ),
                    ),
                    SizedBox(
                      height: Dim().d16.h,
                    ),
                    Text(
                      '${DateFormat.yMMMMd().format(DateTime.parse(v.startDate.toString()))} till ${DateFormat.yMMMMd().format(DateTime.parse(v.endDate.toString()))} ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w600,
                        color: black,
                        fontSize: ScreenUtil().setSp(12),
                        height: 0.16,
                        shadows: [Sty().textShadow],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${v.description.toString()}",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w400,
                        color: white,
                        fontSize: ScreenUtil().setSp(12),
                        height: 1.2,
                        shadows: [Sty().textShadow],
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Deadline: ${DateFormat.yMMMMd().format(DateTime.parse(v.deadline.toString()))} ',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            color: white,
                            fontSize: ScreenUtil().setSp(14),
                            height: 0.16,
                            shadows: [Sty().textShadow],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // showDialog(
                            //   context: context,
                            //   builder: (context) {
                            //     return Dialog(
                            //       child: Column(),
                            //     );
                            //   },
                            // );
                          },
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.zero,
                          iconSize: Dim().d20.r,
                          splashRadius: Dim().d20.r,
                          icon: Icon(
                            Icons.info_outline,
                            color: Clr().white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: v.selectedPage == 0,
          maintainSize: true,
          maintainState: true,
          maintainAnimation: true,
          child: Icon(
            Icons.arrow_forward_ios_sharp,
            color: white.withOpacity(0.8),
            size: Dim().d16.w,
          ),
        ),
      ],
    );
  }

  Widget actionLayout(context, provider, ExploreJobsModel v, index) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dim().d12.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          v.savedStatus == true
              ? InkWell(
                  onTap: () {
                    provider.saveUnsaveJobs('unsave', v.id, index);
                  },
                  child: Icon(
                    Icons.bookmark,
                    color: white,
                    size: 23.r,
                  ))
              : InkWell(
                  onTap: () {
                    provider.saveUnsaveJobs('save', v.id, index);
                  },
                  child: Icon(
                    Icons.bookmark_border,
                    color: white,
                    size: 23.r,
                  )),
          InkWell(
            onTap: () async {
              await Sharedynamic.shareprofile(
                '${v.id}',
                "joblinkfeed",
                '${v.description}',
              );
            },
            child: SvgPicture.asset(
              "assets/icons/svg/share.svg",
              color: white,
            ),
          ),
          InkWell(
            onTap: () {
              provider.applyJobs(context, v.id, index);
            },
            child: Container(
              decoration: BoxDecoration(
                color: white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: orange),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(24),
                    right: ScreenUtil().setWidth(24),
                    top: ScreenUtil().setHeight(13),
                    bottom: ScreenUtil().setHeight(8)),
                child: Text(
                  v.isapplied! ? "Applied" : 'Apply',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w600,
                    color: white,
                    fontSize: ScreenUtil().setSp(12),
                    height: 0.16,
                    shadows: [Sty().textShadow],
                  ),
                ),
              ),
            ),
          ),
          Text(
            '${(DateTime.now().difference(DateTime.parse(v.createdAt.toString())).inDays)}  days ago',
            textAlign: TextAlign.left,
            style: Sty().microText.copyWith(
                  fontWeight: FontWeight.w400,
                  color: white,
                ),
          ),
        ],
      ),
    );
  }

  Widget footerLayout(ExploreJobsModel v) {
    return Container(
      padding: EdgeInsets.all(
        ScreenUtil().setHeight(Dim().d12),
      ),
      decoration: Sty().footerDecoration,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              Dim().d16,
            ),
            child: STM().imageView(
              '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${v.createdBy![0].profileImage}',
              width: Dim().d60.w,
              height: Dim().d60.w,
              name: v.createdBy![0].name,
              radius: Dim().d16.r,
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(12),
          ),
          Text(
            '${v.createdBy![0].name}',
            textAlign: TextAlign.left,
            style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.w700,
              color: black,
              fontSize: ScreenUtil().setSp(14),
            ),
          ),
        ],
      ),
    );
  }
}
