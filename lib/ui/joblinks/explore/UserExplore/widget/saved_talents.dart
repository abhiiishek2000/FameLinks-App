import 'package:famelink/manager/static_method.dart';
import 'package:famelink/util/opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../networking/config.dart';
import '../../../../../util/colors.dart';
import '../../../../../util/config/color.dart';
import '../../../../../util/dimens.dart';
import '../../../../../util/styles.dart';
import '../../../feedjobs/provider/feed_provider.dart';
import '../../../models/joblinkfeedmodel.dart';
import '../../../reportDialog.dart';

class SavedTalent extends StatelessWidget {
  final List<dynamic> list;

  SavedTalent(this.list);

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
        return itemLayout(context, list[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: Dim().d12.h,
        );
      },
    );
  }

  Widget itemLayout(context, v) {
    return Material(
      elevation: 1.5,
      borderRadius: BorderRadius.circular(Dim().d12.r),
      child: Container(
        padding: EdgeInsets.all(Dim().d12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dim().d12.r),
          border: Border.all(
            color: Colors.black.withAlpha(40),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            v.profileImageType == "avatar"
                ? Container(
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
                      '${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${v.masterProfile!.profileImage}',
                      width: Dim().d60.w,
                      height: Dim().d60.w,
                      name: v.name,
                    ),
                  )
                : STM().imageView(
                    '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${v.masterProfile!.profileImage}',
                    width: Dim().d60.w,
                    height: Dim().d60.w,
                  ),
            SizedBox(
              width: Dim().d12.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          '${(v.masterProfile!.name)}, ${v.masterProfile!.age} yrs',
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: lightGray,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: EdgeInsets.symmetric(
                            vertical: Dim().d4,
                            horizontal: Dim().d16,
                          ),
                        ),
                        onPressed: () async {
                          JobLinksFeedProvider provider =
                              Provider.of(context, listen: false);
                          provider.init();
                          await provider.getJobsForInvites('1', v.id);
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Consumer<JobLinksFeedProvider>(
                                  builder: (context, provider2, widget) {
                                return dialogInvite(context, v.id, provider2);
                              });
                            },
                          );
                        },
                        child: Text(
                          'Invite to job',
                          style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '@${v.masterProfile!.username}',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff0060FF),
                          fontSize: ScreenUtil().setSp(12),
                        ),
                      ),
                      SizedBox(
                        width: Dim().d12.w,
                      ),
                      Text(
                        "${v.masterProfile!.followersCount! > 1 ? '${v.masterProfile!.followersCount} Followers' : '${v.masterProfile!.followersCount} Follower'}",
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
                          showGeneralDialog(
                            context: context,
                            pageBuilder:
                                (buildContext, animation, secondaryAnimation) {
                              return ReportDialog(
                                  v.masterProfile!.id!, 'talent');
                            },
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(Dim().d4.h),
                          child: Icon(
                            Icons.more_vert,
                            color: lightGray,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (v.masterProfile!.achievements!.isNotEmpty)
                    Text(
                      v.masterProfile!.achievements!,
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w700,
                        color: orange,
                        fontSize: ScreenUtil().setSp(10),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dialogInvite(context, id, JobLinksFeedProvider provider) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Dim().d16.r),
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dim().d16.r),
                  topRight: Radius.circular(Dim().d16.r),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [lightRedWhite, lightRed],
                ),
              ),
              padding: EdgeInsets.all(Dim().d16.w),
              child: Text(
                'Your Open Jobs',
                style: GoogleFonts.nunitoSans(
                  fontSize: ScreenUtil().setSp(16),
                  color: white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(
                  Dim().d12.w,
                  Dim().d12.w,
                  Dim().d2.w,
                  Dim().d12.w,
                ),
                shrinkWrap: true,
                itemCount: provider.jobForInviteList.length,
                itemBuilder: (context, index) {
                  JobInvite v = provider.jobForInviteList[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${v.title}',
                        style: Sty().mediumBoldText.copyWith(
                          color: v.hired! || v.shortlisted! || v.applied!
                              ? Color(0xFF9B9B9B)
                              : Color(0xFF000000),
                          shadows: [],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                '${v.jobDetails!.isNotEmpty ? v.jobDetails![0].jobName : ''}',
                                style: Sty().smallText.copyWith(
                                  color:
                                      v.hired! || v.shortlisted! || v.applied!
                                          ? Color(0xFF9B9B9B)
                                          : Color(0xFF4B4E58),
                                  shadows: [],
                                ),
                              ),
                              SizedBox(
                                width: Dim().d8.w,
                              ),
                              SvgPicture.asset(
                                "assets/icons/svg/photoshoot.svg",
                                color: v.hired! || v.shortlisted! || v.applied!
                                    ? Color(0xFF9B9B9B)
                                    : orange,
                                height: Dim().d16.h,
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: v.hired! || v.shortlisted! || v.applied!
                                ? null
                                : () {
                                    if (!v.loader!) {
                                      provider.updateLoader(index);
                                      if (v.invitation!) {
                                        provider.inviteJobs(
                                            'withdraw', id, v.id, index);
                                      } else {
                                        provider.inviteJobs(
                                            'send', id, v.id, index);
                                      }
                                    }
                                  },
                            child: v.loader!
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: orange,
                                      strokeWidth: 0.8,
                                    ),
                                  )
                                : Text(
                                    v.hired!
                                        ? 'Hired'
                                        : v.shortlisted!
                                            ? 'Shortlisted'
                                            : v.applied!
                                                ? 'Applied'
                                                : v.invitation!
                                                    ? 'Invited'
                                                    : 'Invite',
                                    style: Sty().smallText.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                      color: v.hired! ||
                                              v.shortlisted! ||
                                              v.applied!
                                          ? Color(0xFF9B9B9B)
                                          : v.invitation!
                                              ? lightGray
                                              : Color(0xFF0060FF),
                                      shadows: [],
                                    ),
                                  ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 2,
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: lightGray,
                  ),
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                clipBehavior: Clip.none,
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.all(Dim().d12),
                  ),
                  backgroundColor: MaterialStateProperty.all(Clr().white),
                  overlayColor: MaterialStateProperty.all(
                      Colors.black.withOpacity(Opc().o10)),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(Dim().d16.r),
                        bottomRight: Radius.circular(Dim().d16.r),
                      ),
                    ),
                  ),
                ),
                child: Text(
                  'Done',
                  style: GoogleFonts.nunitoSans(
                    fontSize: ScreenUtil().setSp(16),
                    color: Clr().black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
