import 'package:cached_network_image/cached_network_image.dart';
import 'package:famelink/manager/static_method.dart';
import 'package:famelink/ui/joblinks/feedjobs/provider/feed_provider.dart';
import 'package:famelink/ui/joblinks/models/joblinkfeedmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../networking/config.dart';
import '../../../share/firebasedynamiclink.dart';
import '../../../util/colors.dart';
import '../../../util/config/color.dart';
import '../../../util/dimens.dart';
import '../../../util/opacity.dart';
import '../../../util/styles.dart';
import '../../ChattingScreen.dart';
import '../reportDialog.dart';

class ExploreTalents extends StatelessWidget {
  final List<String> piclist = [
    "assets/icons/svg/photoshoot.svg",
    "assets/icons/svg/videoshot.svg",
    "assets/icons/svg/jobactivity.svg",
    "assets/icons/svg/filmshot.svg"
  ];

  final List<String> gridtext = ["Print", "Video", "Activity", "Film"];

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
          itemCount: provider.exploreTalentList.length,
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
    ExploreTalentsModel v = provider.exploreTalentList[index];
    return Container(
      decoration: Sty().feedCardDecoration,
      child: Column(
        children: [
          SizedBox(
            height: Dim().d12.h,
          ),
          headerLayout(provider, v),
          SizedBox(
            height: Dim().d12.h,
          ),
          bodyLayout(context, provider, v, index),
          SizedBox(
            height: Dim().d12.h,
          ),
          actionLayout(context, provider, v, index),
          SizedBox(
            height: Dim().d12.h,
          ),
          footerLayout(context, v),
        ],
      ),
    );
  }

  Widget headerLayout(JobLinksFeedProvider provider, ExploreTalentsModel v) {
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
                      child: v.type == "crew"
                          ? Text(
                              '${v.experienceLevel}',
                              style: Sty().mediumBoldText.copyWith(
                                    color: Clr().white,
                                  ),
                            )
                          : Row(
                              children: [
                                Text(
                                  "${v.masterProfile!.gender}, ${provider.ageGroup[0][v.masterProfile!.ageGroup.toString()]} yrs",
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
              if (v.interestCat!.isNotEmpty)
                IntrinsicWidth(
                  child: Column(
                    children: [
                      Container(
                        width: Dim().d100.w,
                        height: 36.h,
                        alignment: Alignment.center,
                        child: ListView.builder(
                          itemCount: v.interestCat!.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          primary: false,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int i) {
                            var v2 = v.interestCat![i];
                            return Padding(
                              padding: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(12),
                                  top: ScreenUtil().setWidth(0)),
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    piclist[i],
                                    height: ScreenUtil().setHeight(16),
                                    width: ScreenUtil().setWidth(16),
                                    color: orange,
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(10),
                                  ),
                                  Text(
                                    '${v2.jobName}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      color: white,
                                      fontSize: ScreenUtil().setSp(12),
                                      height: 0.16,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 1,
                        decoration: BoxDecoration(
                          color: white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 2),
                              color: white,
                              blurRadius: 2.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(
            height: Dim().d8.h,
          ),
          Text(
            '${v.interestedLoc != null && v.interestedLoc!.isNotEmpty ? v.interestedLoc![0].district : ''}',
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
      context, JobLinksFeedProvider provider, ExploreTalentsModel v, index) {
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
            height: Dim().d100.h,
            child: PageView(
              controller: v.pageCtrl,
              onPageChanged: (i) {
                provider.updateTalentSlider(index);
              },
              children: [
                ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: v.posts!.length,
                  scrollDirection: Axis.horizontal,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, i) {
                    return Stack(
                      children: [
                        Container(
                          height: ScreenUtil().setHeight(116),
                          width: ScreenUtil().setWidth(116),
                          child: CachedNetworkImage(
                            imageUrl:
                                "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${v.posts![i].video}-xs",
                            imageBuilder: (context, imageProvider) => Container(
                              width: 60.h,
                              height: 60.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            errorWidget: (context, url, error) {
                              print("ER::${error.toString()}");
                              return Icon(Icons.error, color: white);
                            },
                            fit: BoxFit.cover,
                            height: ScreenUtil().setHeight(60),
                            width: ScreenUtil().setWidth(60),
                          ),
                        ),
                        if (i == 0) ...[
                          Center(
                            child: Image.asset(
                              "assets/icons/rect.png",
                              height: 125.h,
                              width: 115.w,
                            ),
                          ),
                        ]
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: Dim().d8,
                    );
                  },
                ),
                Stack(
                  children: [
                    if (v.type == 'faces')
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Height: ',
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      color: black,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${v.height!.foot}’${v.height!.inch}"',
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      color: black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '\nWeight: ',
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      color: black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${v.weight} kg',
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      color: black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '\nVitals: ',
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      color: black,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'B ${v.bust}, W ${v.waist}, H ${v.hip}',
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      color: black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '\nEye Color: ',
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      color: black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${v.eyeColor}',
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      color: black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '\nComplexion: ',
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      color: black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${v.complexion}',
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      color: black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Dim().d12.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (v.interestedLoc != null &&
                                    v.interestedLoc!.isNotEmpty)
                                  Text(
                                    'Interested Locations:',
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w500,
                                      color: white,
                                      fontSize: ScreenUtil().setSp(12),
                                      shadows: [Sty().textShadow],
                                    ),
                                  ),
                                if (v.interestedLoc != null &&
                                    v.interestedLoc!.isNotEmpty)
                                  ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: v.interestedLoc!.length,
                                    itemBuilder: (context, index) {
                                      return Text(
                                        '• ${v.interestedLoc![index].district}',
                                        style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          color: white,
                                        ),
                                      );
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    if (v.type == "crew")
                      ListView(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        children: [
                          if (v.achievements != null &&
                              v.achievements!.isNotEmpty)
                            Text(
                              'Award Won: ',
                              style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: white,
                              ),
                            ),
                          if (v.achievements != null &&
                              v.achievements!.isNotEmpty)
                            Text(
                              '${v.achievements}',
                              style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                color: white,
                              ),
                            ),
                          if (v.workExperience != null &&
                              v.workExperience!.isNotEmpty)
                            Text(
                              '\nWork Experience:',
                              style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: white,
                              ),
                            ),
                          if (v.workExperience != null &&
                              v.workExperience!.isNotEmpty)
                            Text(
                              '${v.workExperience}',
                              style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                color: white,
                              ),
                            ),
                          if (v.interestedLoc != null &&
                              v.interestedLoc!.isNotEmpty)
                            Text(
                              '\nInterested Locations:',
                              style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: white,
                              ),
                            ),
                          if (v.interestedLoc != null &&
                              v.interestedLoc!.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: v.interestedLoc!.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  '• ${v.interestedLoc![index].district}',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(12),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    color: white,
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                  ],
                )
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
      context, JobLinksFeedProvider provider, ExploreTalentsModel v, index) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dim().d12.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          v.saved!
              ? InkWell(
                  onTap: () {
                    provider.saveUnsavetilent(
                        false, v.userId!.toString(), index);
                  },
                  child: Icon(
                    Icons.bookmark,
                    color: white,
                    size: 23.r,
                  ),
                )
              : InkWell(
                  onTap: () {
                    provider.saveUnsavetilent(
                        true, v.userId!.toString(), index);
                  },
                  child: Icon(
                    Icons.bookmark_border,
                    color: white,
                    size: 23.r,
                  ),
                ),
          InkWell(
            onTap: () async {
              await Sharedynamic.shareprofile(
                '${v.userId}',
                "joblinkfeed",
                '${v.achievements}',
              );
            },
            child: Image.asset(
              'assets/icons/share.png',
              color: Colors.white,
              height: 22.h,
              width: 22.w,
            ),
          ),
          InkWell(
            onTap: () async {
              await provider.getJobsForInvites(provider.page, v.userId!);
              showDialog(
                context: context,
                builder: (context) {
                  return Consumer<JobLinksFeedProvider>(
                      builder: (context, provider2, widget) {
                    return dialogInvite(context, v.userId!, provider2);
                  });
                },
              );
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
                  '${v.invitationStatus! ? 'Invited' : 'Invite to Job'}',
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
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChattingScreen(
                    v.masterProfile!.name!,
                    v.masterProfile!.profileImage.toString(),
                    v.masterProfile!.sId.toString(),
                    "joblinks",
                    v.userId! ?? "",
                    false,
                  ),
                ),
              );
            },
            child: SvgPicture.asset(
              "assets/icons/svg/Send1.svg",
              width: 27.78,
              height: 25,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              provider.updateTalentPage(index);
            },
            constraints: BoxConstraints(),
            padding: EdgeInsets.zero,
            splashRadius: Dim().d20.r,
            icon: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget footerLayout(context, ExploreTalentsModel v) {
    return Container(
      padding: EdgeInsets.all(
        ScreenUtil().setHeight(Dim().d12),
      ),
      decoration: Sty().footerDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          STM().imageView(
            v.masterProfile!.profileImageType == "image"
                ? '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${v.masterProfile!.profileImage}'
                : '${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${v.masterProfile!.profileImage}',
            width: Dim().d60.w,
            height: Dim().d60.h,
            name: v.masterProfile!.name,
          ),
          SizedBox(
            width: Dim().d12.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "${v.masterProfile!.name}, ${v.masterProfile!.age} yrs",
                        style: GoogleFonts.nunitoSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: black,
                        )),
                    InkWell(
                      onTap: () {
                        showGeneralDialog(
                          context: context,
                          pageBuilder:
                              (buildContext, animation, secondaryAnimation) {
                            return ReportDialog(v.userId!, 'user');
                          },
                        );
                      },
                      child: Icon(
                        Icons.more_vert,
                        color: white,
                        size: Dim().d16.h,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("@${v.masterProfile!.username}",
                        style: GoogleFonts.nunitoSans(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff0060FF),
                        )),
                    Text(
                      " ${v.masterProfile!.followersCount! > 1 ? '${v.masterProfile!.followersCount} Followers' : '${v.masterProfile!.followersCount} Follower'}",
                      style: GoogleFonts.nunitoSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: white,
                      ),
                    ),
                  ],
                ),
                if (v.masterProfile!.achievements!.isNotEmpty)
                  Text(
                    '${v.masterProfile!.achievements}',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: white,
                    ),
                  ),
              ],
            ),
          )
        ],
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
