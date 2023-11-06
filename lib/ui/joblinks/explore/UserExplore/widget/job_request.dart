import 'package:famelink/manager/static_method.dart';
import 'package:famelink/ui/FameChatScreen.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../networking/config.dart';
import '../../../models/exploretalentapplied.dart' as talentapplied;
import '../../../reportDialog.dart';
import '../provider/user_explore_provider.dart';

class JobRequest extends StatelessWidget {
  final List<talentapplied.Result> list;

  JobRequest(this.list, {super.key});

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
            height: Dim().d12.h,
          ),
          headerLayout(context, v),
          SizedBox(
            height: Dim().d8.h,
          ),
          bodyLayout(v),
          SizedBox(
            height: Dim().d8.h,
          ),
          footerLayout(context, v),
        ],
      ),
    );
  }

  Widget headerLayout(context, talentapplied.Result v) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dim().d8.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                            TextSpan(
                              text: "${v.createdBy![0].name}: ",
                              style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(16),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: black,
                              ),
                            ),
                            TextSpan(
                              text: "\n",
                              style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                color: black,
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
                        softWrap: true,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showGeneralDialog(
                          context: context,
                          pageBuilder:
                              (buildContext, animation, secondaryAnimation) {
                            return ReportDialog(v.createdBy![0].id!, 'user');
                          },
                        );
                      },
                      child: Icon(
                        Icons.more_vert,
                        color: darkGray,
                        size: Dim().d16.h,
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

  Widget bodyLayout(talentapplied.Result v) {
    return Padding(
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
                "Print Ad",
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
    );
  }

  Widget footerLayout(context, v) {
    return Consumer<UserExploreProvider>(
      builder: (context, provider, widget) {
        return Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(
            Dim().d12.r,
          ),
          child: Container(
            padding: EdgeInsets.all(
              Dim().d8.w,
            ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${provider.sRequestType} On: ${DateFormat.yMMMd().format(DateTime.parse(v.deadline.toString()))} ",
                  style: GoogleFonts.nunitoSans(
                    fontSize: ScreenUtil().setSp(12),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: black,
                  ),
                ),
                if (provider.sRequestType == 'Applied')
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(Dim().d16.r),
                            ),
                            content: Text(
                              'Once you withdraw your application, you will not be able to apply to this job again?\n\nAre you sure you want to withdraw your application?',
                              style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                color: black,
                              ),
                            ),
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              TextButton(
                                onPressed: () {
                                  provider
                                      .withdrawJob(context, v.id)
                                      .whenComplete(
                                          () => Navigator.of(context).pop());
                                },
                                child: Text(
                                  'Yes',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(14),
                                    fontWeight: FontWeight.w700,
                                    color: black,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'No',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(14),
                                    fontWeight: FontWeight.w700,
                                    color: black,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "Withdraw",
                      style: GoogleFonts.nunitoSans(
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: black,
                      ),
                    ),
                  ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FameChatScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Chat",
                    style: GoogleFonts.nunitoSans(
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: darkGray,
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
