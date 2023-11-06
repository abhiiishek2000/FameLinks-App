import 'package:famelink/manager/static_method.dart';
import 'package:famelink/ui/joblinks/feedjobs/provider/feed_provider.dart';
import 'package:famelink/ui/joblinks/models/joblinkfeedmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../networking/config.dart';
import '../../../util/colors.dart';
import '../../../util/config/color.dart';
import '../../../util/dimens.dart';
import '../../../util/styles.dart';
import '../createjob/createJob.dart';

class PastJobs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobLinksFeedProvider>(
      builder: (context, provider, child) {
        return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(
            ScreenUtil().setHeight(Dim().d12),
          ),
          itemCount: provider.pastJobList.length,
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
    PastJobsModel v = provider.pastJobList[index];
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
          bodyLayout(provider, v, index),
          SizedBox(
            height: Dim().d16.h,
          ),
          actionLayout(context, provider, v, index),
          SizedBox(
            height: Dim().d12.h,
          ),
          footerLayout(v),
        ],
      ),
    );
  }

  Widget headerLayout(provider, PastJobsModel v) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dim().d12.w,
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
                                  '${v.height != null ? '${v.height!.foot}’${v.height!.inch}"' : ''}',
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

  Widget bodyLayout(JobLinksFeedProvider provider, PastJobsModel v, index) {
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
                provider.updatePastSlider(index);
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
                    Text(
                      '${v.selectedCandidates!.isNotEmpty ? 'Completed' : 'Cancelled'} On: ${DateFormat.yMMMd().format(DateTime.parse(v.deadline.toString()))} ',
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w400,
                        color: white,
                        fontSize: ScreenUtil().setSp(12),
                        height: 0.16,
                        shadows: [Sty().textShadow],
                      ),
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

  Widget actionLayout(context, provider, PastJobsModel v, index) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dim().d12.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 10,
            ),
            child: Text(
              '${v.jobType}',
              textAlign: TextAlign.left,
              style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: ScreenUtil().setSp(12),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateJob()),
              );
            },
            child: Container(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(24),
                  right: ScreenUtil().setWidth(24),
                  top: ScreenUtil().setHeight(13),
                  bottom: ScreenUtil().setHeight(8)),
              decoration: BoxDecoration(
                color: white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: orange),
              ),
              child: Text(
                'Create Similar',
                style: GoogleFonts.nunitoSans(
                  fontSize: 12.sp,
                  height: 0.16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                  color: white,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              right: 10,
            ),
            child: Text(
              '${(DateTime.now().difference(DateTime.parse(v.startDate.toString())).inDays)} days ago',
              textAlign: TextAlign.left,
              style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: ScreenUtil().setSp(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget footerLayout(PastJobsModel v) {
    return Container(
      height: Dim().d84.h,
      decoration: Sty().footerDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          v.selectedCandidates!.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(Dim().d8),
                  scrollDirection: Axis.horizontal,
                  itemCount: v.selectedCandidates!.length,
                  itemBuilder: (context, index) {
                    var v2 = v.selectedCandidates![index];
                    return Column(
                      children: [
                        Text(
                          '${v2['name']}',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            color: white,
                            fontSize: ScreenUtil().setSp(12),
                          ),
                        ),
                        SizedBox(
                          height: Dim().d4.h,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xffffdfb2), Color(0xffffd49c)],
                              stops: [0.0, 1.0],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: STM().imageView(
                            v2['profileImageType'] == "image"
                                ? '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${v2['profileImage']}'
                                : '${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${v2['profileImage']}',
                            width: Dim().d40.h,
                            height: Dim().d40.h,
                          ),
                        ),
                      ],
                    );
                  },
                )
              : Text(
                  'Cancelled',
                ),
        ],
      ),
    );
  }
}
