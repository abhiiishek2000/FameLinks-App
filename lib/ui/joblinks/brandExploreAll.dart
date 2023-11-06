import 'package:cached_network_image/cached_network_image.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/joblinks/models/BrandAgencyExplore.dart';
import 'package:famelink/ui/joblinks/reportDialog.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BrandExploreAll extends StatefulWidget {
  dynamic profiles;
  dynamic savedTalents;
  BrandExploreAll({this.profiles, this.savedTalents});

  @override
  State<BrandExploreAll> createState() => _BrandExploreAllState();
}

class _BrandExploreAllState extends State<BrandExploreAll> {
  List<Profile> profileList = <Profile>[];
  List<SavedTalent> savedTalentList = <SavedTalent>[];

  String capitalize(val) {
    return val[0].toString().toUpperCase() + val.substring(1);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.profiles != null){
      profileList = widget.profiles;
    }

    if(widget.savedTalents != null){
      savedTalentList = widget.savedTalents;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profileList.isNotEmpty && savedTalentList.isNotEmpty
            ? Padding(
              padding: EdgeInsets.only(top: 15.h, left: 22.w, right: 22.w),
              child: Text(
                'Profiles',
                textAlign: TextAlign.left,
                style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  color: darkGray,
                  fontSize: ScreenUtil().setSp(12),
                  height: 0.16
                ),
              ),
            ) : Container(),
            SizedBox(height: 15.h,),
            profileList.isEmpty ? Container() :
            Padding(
              padding: EdgeInsets.only(left: 22.w, right: 22.w),
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.zero,
                itemCount: 5,
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
                              imageUrl: profileList[index].profileImageType == 'avatar' ? '${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${profileList[index].profileImage}'
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
                                return profileList[index].name!.isEmpty ? Icon(Icons.error_outline_rounded, color: black)
                                : Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                      color: darkBlue.withOpacity(0.8),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        profileList[index].name![0].toString().toUpperCase(),
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
                              progressIndicatorBuilder: (context, url, downloadProgress) => 
                              SvgPicture.asset(
                                "assets/icons/svg/icon.svg",
                                height: 40.h,
                                width: 40.w,
                              ),
                              fit: BoxFit.cover,
                              height: ScreenUtil().setHeight(40), width: ScreenUtil().setWidth(40),
                            ),
                            SizedBox(width: 12.w,),
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
                                  profileList[index].achievements!,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    color: lightGray,
                                    fontSize: ScreenUtil().setSp(10),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                              ]
                            ),
                            Spacer(),
                            Text(
                              profileList[index].invitation == true ? 'Invited' : 'Invite to Job',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w400,
                                color: Color(0xff0060FF),
                                fontSize: ScreenUtil().setSp(12),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        index == 4 ? Container() :
                        Container(
                          height: 1.h,
                          width: MediaQuery.of(context).size.width,
                          color: lightGray,
                        )
                      ],
                    ),
                  );
                }
              ),
            ),
            profileList.isNotEmpty && savedTalentList.isNotEmpty 
            ? SizedBox(height: 24.h,) : Container(),
            profileList.isNotEmpty && savedTalentList.isNotEmpty
            ? Padding(
              padding: EdgeInsets.only(left: 22.w, right: 22.w),
              child: Text(
                'Saved Talents:',
                textAlign: TextAlign.left,
                style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  color: darkGray,
                  fontSize: ScreenUtil().setSp(12),
                  height: 0.16
                ),
              ),
            ) : Container(),
            profileList.isNotEmpty && savedTalentList.isNotEmpty 
            ? SizedBox(height: 12.h,) : Container(),
            savedTalentList.isEmpty ? Container() : 
            Padding(
              padding: EdgeInsets.only(left: 22.w, right: 22.w),
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.zero,
                itemCount: savedTalentList.length,
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
                                 imageUrl: savedTalentList[index].profileImage != null
                                ? savedTalentList[index].profileImageType == 'avatar' ? '${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${savedTalentList[index].profileImage}'
                                : '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${savedTalentList[index].profileImage}'
                                : savedTalentList[index].masterProfile!.profileImageType == 'avatar' ? '${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${savedTalentList[index].masterProfile!.profileImage}'
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
                                  return savedTalentList[index].name!.isEmpty ? Icon(Icons.error_outline_rounded, color: black)
                                  : Container(
                                    height: 60.h,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                      color: darkBlue.withOpacity(0.8),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        savedTalentList[index].name![0].toString().toUpperCase(),
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
                                progressIndicatorBuilder: (context, url, downloadProgress) => 
                                SvgPicture.asset(
                                  "assets/icons/svg/icon.svg",
                                  height: 60.h,
                                  width: 60.w,
                                ),
                                fit: BoxFit.cover,
                                height: ScreenUtil().setHeight(60), width: ScreenUtil().setWidth(60),
                              ),
                              SizedBox(width: 10.w,),
                              Container(
                                width: MediaQuery.of(context).size.width - 185.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${capitalize(savedTalentList[index].name)}, ${savedTalentList[index].masterProfile!.age} yrs',
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w700,
                                        color: black,
                                        fontSize: ScreenUtil().setSp(14),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '@${savedTalentList[index].masterProfile!.username}',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff0060FF),
                                            fontSize: ScreenUtil().setSp(12),
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
                                        Spacer(),
                                        Spacer(),                               
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      savedTalentList[index].masterProfile!.achievements!,
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
                              Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '2 days ago',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      color: darkGray,
                                      fontSize: ScreenUtil().setSp(10),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  InkWell(
                                        onTap:() {
                                          setState(() {
                                            // showGeneralDialog(
                                            //   context: context,
                                            //   pageBuilder: (BuildContext buildContext,
                                            //       Animation animation, Animation secondaryAnimation) {
                                            //     return ReportDialog();
                                            //   });
                                            });                           
                                          },
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 2.5.h),
                                          child: Icon(Icons.more_vert, color: lightGray, size: 15.r),
                                        )
                                      )
                                ],
                              ),
                            ]
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
          ] 
        ),
      )
    );
  }
}