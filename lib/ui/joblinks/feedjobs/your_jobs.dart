import 'package:famelink/ui/joblinks/feedjobs/provider/feed_provider.dart';
import 'package:famelink/ui/joblinks/models/joblinkfeedmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../manager/static_method.dart';
import '../../../networking/config.dart';
import '../../../share/firebasedynamiclink.dart';
import '../../../util/colors.dart';
import '../../../util/config/color.dart';
import '../../../util/dimens.dart';
import '../../../util/styles.dart';
import '../application/brandDetailApplication.dart';
import '../createjob/createJob.dart';

class YourJobs extends StatelessWidget {
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
          itemCount: provider.yourJobList.length,
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
    YourJobsModel v = provider.yourJobList[index];
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
          if (v.applicants!.isNotEmpty) footerLayout(context, v),
        ],
      ),
    );
  }

  Widget headerLayout(JobLinksFeedProvider provider, YourJobsModel v) {
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
                    '${v.jobDetails!.isNotEmpty ? v.jobDetails![0]['jobName'] : ''}',
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
      context, JobLinksFeedProvider provider, YourJobsModel v, index) {
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
                provider.updateYourSlider(index);
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
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.w),
                                ),
                                title: Text(
                                  'Confirmation',
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: black,
                                    fontSize: ScreenUtil().setSp(14),
                                  ),
                                ),
                                content: Text(
                                  'Are you sure, you want to close job?',
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                    fontSize: ScreenUtil().setSp(12),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      STM().back2Previous(context);
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w700,
                                        color: black,
                                        fontSize: ScreenUtil().setSp(12),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      provider.closeJob(context, v.id, index);
                                      STM().back2Previous(context);
                                    },
                                    child: Text(
                                      'Yes',
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w700,
                                        color: black,
                                        fontSize: ScreenUtil().setSp(12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text(
                            'Close',
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w700,
                              color: white,
                              fontSize: ScreenUtil().setSp(14),
                              height: 0.16,
                              shadows: [Sty().textShadow],
                            ),
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

  Widget actionLayout(
      context, JobLinksFeedProvider provider, YourJobsModel v, index) {
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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CreateJob(alldata: provider.yourJobList[index])),
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
                'Edit Job',
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
          Container(
            padding: EdgeInsets.only(
              right: 10,
            ),
            child: Text(
              '${(DateTime.now().difference(DateTime.parse(provider.yourJobList[index].startDate.toString())).inDays)}  days ago',
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

  Widget footerLayout(context, YourJobsModel v) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BrandDetailApplication(
              id: v.id.toString(),
              title: v.title.toString(),
              jobType: v.jobType,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(
          ScreenUtil().setHeight(Dim().d8),
          ScreenUtil().setHeight(Dim().d4),
          ScreenUtil().setHeight(Dim().d8),
          ScreenUtil().setHeight(Dim().d16),
        ),
        decoration: Sty().footerDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                left: Dim().d8,
              ),
              child: Text(
                'Applications',
                textAlign: TextAlign.left,
                style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(12),
                ),
              ),
            ),
            SizedBox(
              height: Dim().d4.h,
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: Dim().d48.w,
                    child: ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          v.applicants!.length > 5 ? 5 : v.applicants!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var v2 = v.applicants![index];
                        return v2['profileImageType'] == "avatar"
                            ? Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xffffdfb2),
                                      Color(0xffffd49c)
                                    ],
                                    stops: [0.0, 1.0],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: STM().imageView(
                                  '${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${v2['profileImage']}',
                                  width: Dim().d48.w,
                                  height: Dim().d48.w,
                                ),
                              )
                            : STM().imageView(
                                '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${v2['profileImage']}',
                                width: Dim().d48.w,
                                height: Dim().d48.w,
                              );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: Dim().d8,
                        );
                      },
                    ),
                  ),
                ),
                if (v.applicants!.length > 5)
                  Text(
                    '${v.applicants!.length - 5} more',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w400,
                      color: white,
                      fontSize: ScreenUtil().setSp(12),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
