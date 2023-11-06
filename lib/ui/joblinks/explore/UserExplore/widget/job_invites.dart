import 'package:famelink/manager/static_method.dart';
import 'package:famelink/ui/joblinks/explore/UserExplore/model/user_explore_model.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../networking/config.dart';
import '../../../../../util/opacity.dart';
import '../../../reportDialog.dart';
import '../provider/user_explore_provider.dart';

class JobInvites extends StatelessWidget {
  final List<JobInvitesModel> list;

  JobInvites(this.list, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(
        Dim().d8.h,
      ),
      shrinkWrap: true,
      primary: false,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return itemLayout(context, list, index);
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: Dim().d12.h,
        );
      },
    );
  }

  Widget itemLayout(context, list, index) {
    var v = list[index];
    var v2 = list[index].jobDetails![0];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dim().d12.r),
        border: Border.all(
          color: Colors.black.withAlpha(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Dim().d8.h,
          ),
          headerLayout(context, v2),
          if (v.expanded!)
            SizedBox(
              height: Dim().d8.h,
            ),
          bodyLayout(v, v2),
          SizedBox(
            height: Dim().d8.h,
          ),
          footerLayout(context, v, index),
        ],
      ),
    );
  }

  Widget headerLayout(context, JobDetails v) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dim().d8.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          v.createdBy![0].profileImageType == "avatar"
              ? Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xffffdfb2), Color(0xffffd49c)],
                      stops: [0.0, 1.0],
                    ),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(
                      Dim().d16.r,
                    ),
                  ),
                  child: STM().imageView(
                    '${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${v.createdBy![0].profileImage}',
                    width: Dim().d60.w,
                    height: Dim().d60.w,
                    radius: Dim().d16.r,
                    name: v.createdBy![0].name,
                  ),
                )
              : STM().imageView(
                  '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${v.createdBy![0].profileImage}',
                  width: Dim().d60.w,
                  height: Dim().d60.w,
                  radius: Dim().d16.r,
                ),
          SizedBox(
            width: Dim().d8.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${v.createdBy![0].name}",
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(16),
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        color: black,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showGeneralDialog(
                                        context: context,
                                        pageBuilder: (buildContext, animation,
                                            secondaryAnimation) {
                                          return ReportDialog(
                                              v.createdBy![0].sId!, 'user');
                                        },
                                      );
                                    },
                                    constraints: BoxConstraints(),
                                    padding: EdgeInsets.zero,
                                    iconSize: Dim().d16.r,
                                    splashRadius: Dim().d16.r,
                                    icon: Icon(Icons.more_vert),
                                  ),
                                ],
                              ),
                            ),
                            WidgetSpan(
                              child: Text(
                                "${v.title}",
                                maxLines: 2,
                                style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: black,
                                ),
                              ),
                            ),
                            WidgetSpan(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'From ${DateFormat.yMMMd().format(DateTime.parse(v.startDate.toString()))} till ${DateFormat.yMd().format(DateTime.parse(v.endDate.toString()))} ',
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        color: black,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${(DateTime.now().difference(DateTime.parse(v.startDate.toString())).inDays)}  days ago",
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(10),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      color: black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bodyLayout(v1, JobDetails v) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        return SizeTransition(sizeFactor: animation, child: child);
      },
      child: !v1.expanded!
          ? null
          : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dim().d8.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${v.jobLocation!.district}',
                        style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: black,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '${v.jobType == "crew" ? v.experienceLevel : "${v.gender}, ${UserExploreProvider().ageGroup[0][v.ageGroup]} yrs"}',
                        style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: black,
                        ),
                      ),
                      if (v.jobType != "crew") Spacer(),
                      if (v.jobType != "crew")
                        Text(
                          '${v.height!.foot}’${v.height!.inch}"',
                          style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: black,
                          ),
                        ),
                      Spacer(),
                      Text(
                        '${v.jobCategory!.isNotEmpty ? v.jobCategory![0].jobName: ''}',
                        // "Print Ad",
                        style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: darkGray,
                        ),
                      ),
                      SizedBox(
                        width: Dim().d4.w,
                      ),
                      SvgPicture.asset(
                        "assets/icons/svg/photoshoot.svg",
                        width: Dim().d24,
                        color: orange,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dim().d8.h,
                  ),
                  Text(
                    "${v.description}",
                    style: GoogleFonts.nunitoSans(
                      fontSize: ScreenUtil().setSp(10),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: black,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget footerLayout(context, JobInvitesModel v, index) {
    return Consumer<UserExploreProvider>(
      builder: (context, provider, widget) {
        return Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(
            Dim().d12.r,
          ),
          child: Container(
            padding: EdgeInsets.all(Dim().d8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Dim().d12.r,
              ),
              border: Border.all(
                color: Colors.black.withAlpha(40),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: white,
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    provider.inviteAction(context, 'accept', v.jobId);
                  },
                  style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(
                        vertical: Dim().d4.h,
                        horizontal: Dim().d20.w,
                      ),
                    ),
                    minimumSize: MaterialStatePropertyAll(Size.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        side: BorderSide(color: orange),
                        borderRadius: BorderRadius.circular(Dim().d12),
                      ),
                    ),
                    overlayColor: MaterialStateProperty.all(
                      orange.withOpacity(Opc().o20),
                    ),
                  ),
                  child: Text(
                    "Accept",
                    style: GoogleFonts.nunitoSans(
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: darkGray,
                    ),
                  ),
                ),
                SizedBox(
                  width: Dim().d16.w,
                ),
                TextButton(
                  onPressed: () {
                    provider.inviteAction(context, 'reject', v.jobId);
                  },
                  style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(
                        vertical: Dim().d4.h,
                        horizontal: Dim().d20.w,
                      ),
                    ),
                    minimumSize: MaterialStatePropertyAll(Size.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        side: BorderSide(color: lightGray),
                        borderRadius: BorderRadius.circular(Dim().d12),
                      ),
                    ),
                    overlayColor: MaterialStateProperty.all(
                      Colors.grey.withOpacity(Opc().o20),
                    ),
                  ),
                  child: Text(
                    "Reject",
                    style: GoogleFonts.nunitoSans(
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: darkGray,
                    ),
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    provider.updateExpanded(index);
                  },
                  style: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(
                        vertical: Dim().d4.h,
                        horizontal: Dim().d20.w,
                      ),
                    ),
                    minimumSize: MaterialStatePropertyAll(Size.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dim().d12),
                      ),
                    ),
                  ),
                  child: Text(
                    "view ${v.expanded! ? 'less' : 'more'}",
                    style: GoogleFonts.nunitoSans(
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
