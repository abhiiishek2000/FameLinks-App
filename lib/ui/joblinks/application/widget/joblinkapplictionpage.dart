import 'package:cached_network_image/cached_network_image.dart';
import 'package:famelink/manager/static_method.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/joblinks/models/ApplicantsModel.dart';
import 'package:famelink/ui/joblinks/reportDialog.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/dimens.dart';
import 'package:famelink/util/opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';

import '../applicantsPost.dart';
import '../provider/job_appliction_provider.dart';

class JobLinksApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobLinksApplicationProvider>(
      builder: (context, provider, child) {
        return ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.all(Dim().d12.w),
          itemCount: provider.applicantsList[0].applicants!.length,
          itemBuilder: (context, index) {
            return itemLayout(context, provider, index);
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: Dim().d12,
            );
          },
        );
      },
    );
  }

  Widget itemLayout(context, provider, index) {
    Applicant v = provider.applicantsList[0].applicants![index];
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(Dim().d12.r),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dim().d12.r),
          border: Border.all(
            color: Colors.black.withAlpha(40),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerLayout(context, provider, index, v),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                return SizeTransition(sizeFactor: animation, child: child);
              },
              child: !v.isSwipe!
                  ? null
                  : Column(
                      children: [
                        contentLayout(v),
                        mediaLayout(provider, index, v),
                      ],
                    ),
            ),
            actionLayout(context, provider, index, v),
          ],
        ),
      ),
    );
  }

  Widget headerLayout(context, provider, index, Applicant v) {
    return Container(
      padding: EdgeInsets.all(
        Dim().d12.w,
      ),
      decoration: BoxDecoration(
        color: white.withOpacity(Opc().o60),
        borderRadius: BorderRadius.circular(Dim().d12.r),
        border: Border.all(
          color: Colors.black.withAlpha(40),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffFFA88C).withOpacity(Opc().o50),
            Color(0xffFF5C28).withOpacity(Opc().o60)
          ],
          stops: [0.0, 1.0],
        ),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              STM().imageView(
                v.profileImageType == 'avatar'
                    ? '${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${v.profileImage}'
                    : '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${v.profileImage}',
                height: Dim().d60.h,
                width: Dim().d60.w,
                name: v.name!,
              ),
              SizedBox(
                width: Dim().d12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '${(v.name)}, ${v.hiringProfile!.experienceLevel != null ? v.hiringProfile!.experienceLevel : '${v.masterProfile!.age} yrs'}',
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w700,
                              color: black,
                              fontSize: ScreenUtil().setSp(14),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Dim().d8.w,
                        ),
                        Text(
                          timeago.format(v.updatedAt!),
                          textAlign: TextAlign.left,
                          style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            color: darkGray,
                            fontSize: ScreenUtil().setSp(10),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dim().d4.h,
                    ),
                    Row(
                      children: [
                        Text(
                          '@${v.masterProfile!.username}',
                          style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            color: Color(0xff0060FF),
                            fontSize: ScreenUtil().setSp(12),
                          ),
                        ),
                        SizedBox(
                          width: Dim().d8.w,
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
                              pageBuilder: (buildContext, animation,
                                  secondaryAnimation) {
                                return ReportDialog(
                                    v.masterProfile!.id!, 'talent');
                              },
                            );
                          },
                          child: Icon(
                            Icons.more_vert,
                            color: lightGray,
                            size: Dim().d16.h,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: Dim().d4.h,
                      ),
                      child: Text(
                        '${v.hiringProfile!.experienceLevel != null ? v.hiringProfile!.achievements : v.masterProfile!.achievements}',
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w700,
                          color: orange,
                          fontSize: ScreenUtil().setSp(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: v.isSwipe == true
                ? InkWell(
                    onTap: () {
                      provider.singleSwipe(index, false);
                    },
                    child: Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: lightGray,
                    ),
                  )
                : InkWell(
                    onTap: () {
                      provider.singleSwipe(index, true);
                    },
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: lightGray,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget contentLayout(Applicant v) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dim().d20.h,
        left: Dim().d12.w,
        right: Dim().d12.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          v.hiringProfile!.height != null
              ? Row(
                  children: [
                    Text(
                      'Height: ',
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w500,
                        color: black,
                        fontSize: ScreenUtil().setSp(12),
                        height: 0.22,
                      ),
                    ),
                    Text(
                      '${v.hiringProfile!.height!.foot.toString()}’ ${v.hiringProfile!.height!.inch.toString()}”',
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w700,
                        color: black,
                        fontSize: ScreenUtil().setSp(12),
                        height: 0.22,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Weight: ',
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w500,
                        color: black,
                        fontSize: ScreenUtil().setSp(12),
                        height: 0.22,
                      ),
                    ),
                    Text(
                      '${v.hiringProfile!.weight.toString()}kg',
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w700,
                        color: black,
                        fontSize: ScreenUtil().setSp(12),
                        height: 0.22,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Vitals: ',
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w500,
                        color: black,
                        fontSize: ScreenUtil().setSp(12),
                        height: 0.22,
                      ),
                    ),
                    Text(
                      'B ${v.hiringProfile!.bust.toString()}, W ${v.hiringProfile!.waist.toString()}, H ${v.hiringProfile!.hip.toString()}',
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w700,
                        color: black,
                        fontSize: ScreenUtil().setSp(12),
                        height: 0.22,
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Work Experience: ',
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w500,
                        color: black,
                        fontSize: ScreenUtil().setSp(12),
                        height: 0.22,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Padding(
                      padding: EdgeInsets.only(left: 2.w),
                      child: Text(
                        '${v.hiringProfile!.workExperience!}',
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w700,
                          color: black,
                          fontSize: ScreenUtil().setSp(12),
                          height: 0.22,
                        ),
                      ),
                    ),
                  ],
                ),
          v.hiringProfile!.height != null
              ? SizedBox(height: 15.h)
              : Container(),
          v.hiringProfile!.height != null
              ? Row(
                  children: [
                    Text(
                      'Eye Color: ',
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w500,
                        color: black,
                        fontSize: ScreenUtil().setSp(12),
                        height: 0.22,
                      ),
                    ),
                    Text(
                      v.hiringProfile!.eyeColor ?? "",
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w700,
                        color: black,
                        fontSize: ScreenUtil().setSp(12),
                        height: 0.22,
                      ),
                    ),
                    SizedBox(
                      width: Dim().d28.w,
                    ),
                    Text(
                      'Complexion: ',
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w500,
                        color: black,
                        fontSize: ScreenUtil().setSp(12),
                        height: 0.22,
                      ),
                    ),
                    Text(
                      v.hiringProfile!.complexion ?? "",
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w700,
                        color: black,
                        fontSize: ScreenUtil().setSp(12),
                        height: 0.22,
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget mediaLayout(provider, index, Applicant v) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dim().d12.h,
        left: Dim().d12.w,
        right: Dim().d12.w,
      ),
      child: v.posts == null || v.posts!.length == 0
          ? Container()
          : Container(
              height: 110.h,
              child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: 1,
                  scrollDirection: Axis.horizontal,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, i) {
                    return Container(
                        height: 110.h,
                        child: Row(
                          children: [
                            v.greetVideo == '' || v.greetVideo == null
                                ? Container()
                                : Padding(
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: Container(
                                      height: ScreenUtil().setHeight(112),
                                      width: ScreenUtil().setWidth(110),
                                      child: Stack(
                                        children: [
                                          Image.asset("assets/icons/rect.png"),
                                          Positioned(
                                            top: 9.h,
                                            left: 7.w,
                                            child: Container(
                                              height: 91.h,
                                              width: 91.w,
                                              child: provider.controller[index]
                                                      .value.isInitialized
                                                  ? VideoPlayer(provider
                                                      .controller[index])
                                                  : Container(),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              //  setState(() {
                                              showGeneralDialog(
                                                  context: context,
                                                  pageBuilder: (BuildContext
                                                          buildContext,
                                                      Animation animation,
                                                      Animation
                                                          secondaryAnimation) {
                                                    return ApplicantsPost(
                                                        index: index,
                                                        index1: 0,
                                                        applicantsList: provider
                                                            .applicantsList,
                                                        controller: provider
                                                            .controller);
                                                  });
                                              //  });
                                            },
                                            child: Center(
                                              child: Container(
                                                height: 40.h,
                                                width: 40.w,
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: white
                                                            .withOpacity(0.5),
                                                        width: 2.w)),
                                                child: Icon(Icons.play_arrow,
                                                    color:
                                                        white.withOpacity(0.5)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                            ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: v.posts!.length,
                                scrollDirection: Axis.horizontal,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (context, i) {
                                  return InkWell(
                                    onTap: () {
                                      // setState(
                                      //     () {
                                      showGeneralDialog(
                                          context: context,
                                          pageBuilder: (BuildContext
                                                  buildContext,
                                              Animation animation,
                                              Animation secondaryAnimation) {
                                            return ApplicantsPost(
                                                index: index,
                                                index1: i,
                                                applicantsList:
                                                    provider.applicantsList,
                                                controller:
                                                    provider.controller);
                                          });
                                      //  });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.w),
                                      child: Container(
                                        height: ScreenUtil().setHeight(116),
                                        width: ScreenUtil().setWidth(116),
                                        child: CachedNetworkImage(
                                          imageUrl: provider
                                                      .applicantsList[0]
                                                      .applicants![index]
                                                      .posts![i]
                                                      .closeUp !=
                                                  null
                                              ? '${ApiProvider.famelinks}/${v.posts![i].closeUp}'
                                              : provider
                                                          .applicantsList[0]
                                                          .applicants![index]
                                                          .posts![i]
                                                          .medium !=
                                                      null
                                                  ? '${ApiProvider.famelinks}/${v.posts![i].medium}'
                                                  : provider
                                                              .applicantsList[0]
                                                              .applicants![
                                                                  index]
                                                              .posts![i]
                                                              .long !=
                                                          null
                                                      ? '${ApiProvider.famelinks}/${v.posts![i].long}'
                                                      : v.posts![i].pose1 !=
                                                              null
                                                          ? '${ApiProvider.famelinks}/${v.posts![i].pose1}'
                                                          : v.posts![i].pose2 !=
                                                                  null
                                                              ? '${ApiProvider.famelinks}/${v.posts![i].pose2}'
                                                              : v.posts![i]
                                                                          .additional !=
                                                                      null
                                                                  ? '${ApiProvider.famelinks}/${v.posts![i].additional}'
                                                                  : '${ApiProvider.famelinks}/${v.posts![i].video}',
                                          errorWidget: (context, url, error) {
                                            print("ER::${error.toString()}");
                                            return Icon(Icons.error,
                                                color: darkGray);
                                          },
                                          fit: BoxFit.fill,
                                          height: ScreenUtil().setHeight(116),
                                          width: ScreenUtil().setWidth(110),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ));
                  }),
            ),
    );
  }

  Widget actionLayout(context, provider, index, Applicant v) {
    return Padding(
      padding: EdgeInsets.all(
        Dim().d12.w,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              print(index);
              if (v.isShortlisted!) {
                provider.shortlist(
                    context, provider.applicantsList[0].id, v.id, false, index);
              } else {
                provider.shortlist(
                    context, provider.applicantsList[0].id, v.id, true, index);
              }
            },
            child: Icon(
              v.isShortlisted! ? Icons.bookmark : Icons.bookmark_border,
              color: darkGray,
              size: 24.r,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 5.w,
              top: 5.h,
            ),
            child: Text(
              'Shortlist',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w600,
                color: black,
                fontSize: ScreenUtil().setSp(12),
                height: 0.22,
              ),
            ),
          ),
          Spacer(),
          Container(
            height: 30.h,
            width: 85.w,
            decoration: BoxDecoration(
              color: white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xff7AACFF)),
            ),
            child: Center(
              child: Text(
                'Start Chat',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w600,
                  color: darkGray,
                  fontSize: ScreenUtil().setSp(12),
                ),
              ),
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              if (v.isHired == false) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: Container(
                        height: 200.h,
                        width: MediaQuery.of(context).size.width - 80.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r)),
                        child: Padding(
                          padding: EdgeInsets.all(15.r),
                          child: Column(
                            children: [
                              Text(
                                "Congrats! you got the required talent...!",
                                style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(14),
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    color: black),
                              ),
                              SizedBox(height: 30.h),
                              Text(
                                "Do you want to keep job open to hire more in the same job or close it",
                                style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(14),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                    color: black),
                              ),
                              SizedBox(height: 35.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // setState(() {
                                      provider.hire(
                                          provider.applicantsList[0].id,
                                          v.id,
                                          false,
                                          index,
                                          context);
                                      // });
                                    },
                                    child: Text(
                                      "Hire More",
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(14),
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          color: black),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      provider.hire(
                                          provider.applicantsList[0].id,
                                          v.id,
                                          true,
                                          index,
                                          context);
                                    },
                                    child: Text(
                                      "Close Job",
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(14),
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          color: darkGray),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                var snackBar = SnackBar(
                  content:
                      Text('Applicant has been already hired for this job'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: Container(
              height: 30.h,
              width: 85.w,
              decoration: BoxDecoration(
                color: white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: lightGray),
              ),
              child: Center(
                child: Text(
                  v.isHired == true ? 'Hired' : 'Hire',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w600,
                    color: darkGray,
                    fontSize: ScreenUtil().setSp(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
