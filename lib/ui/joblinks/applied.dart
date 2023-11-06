import 'package:cached_network_image/cached_network_image.dart';
import 'package:famelink/dio/api/apimanager.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/FameChatScreen.dart';
import 'package:famelink/ui/joblinks/models/UserExploreModel.dart';
import 'package:famelink/ui/joblinks/reportDialog.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class Applied extends StatefulWidget {
  final int index;
  final dynamic exploreList;
  Applied(this.index, this.exploreList);

  @override
  State<Applied> createState() => _AppliedState();
}

class _AppliedState extends State<Applied> {
  int index = 1;
  List<UserExplore> exploreList = <UserExplore>[];
  List<Map<String, String>> ageGroup = [{'groupA':'0-4', 'groupB':'4-12', 'groupC':'12-18', 'groupD':'18-28', 'groupE':'18-28', 'groupF':'28-40', 'groupG':'40-50', 'groupH':'50 -60', 'groupI':'60+'}];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState((){
      index = widget.index;
      exploreList = widget.exploreList;
    });
  }

  String capitalize(val) {
    return val[0].toString().toUpperCase() + val.substring(1);
  }

  Future<void> withdrawJob(id, index) async {
    await ApiManager.post(param: null, url1: "/joblinks/applyJob/$id").then((value) async {
      if (value.statusCode == 200) {
        setState((){
          
        });
      } else{
        print(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.zero,
        itemCount: index == 1 ? exploreList[0].applied!.length :
                   index == 2 ? exploreList[0].savedJobs!.length :
                   index == 3 ? exploreList[0].shortlisted!.length :
                   exploreList[0].hired!.length,
        itemBuilder: (context, index1) {
          for(var item in ageGroup){
            for(var i in item.entries){
              if(index == 1){
                if(exploreList[0].applied![index1].ageGroup == i.key){
                  exploreList[0].applied![index1].ageGroup = i.value;
                }
              } else if(index == 2){
                if(exploreList[0].savedJobs![index1].ageGroup == i.key){
                  exploreList[0].savedJobs![index1].ageGroup = i.value;
                }
              } else if(index == 3){
                if(exploreList[0].shortlisted![index1].ageGroup == i.key){
                  exploreList[0].shortlisted![index1].ageGroup = i.value;
                }
              } else{
                if(exploreList[0].hired![index1].ageGroup == i.key){
                  exploreList[0].hired![index1].ageGroup = i.value;
                }
              }
            }
          }
          return Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black.withAlpha(40)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: index == 1 ? '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${exploreList[0].applied![index1].createdBy![0].profileImage}' :
                                  index == 2 ? '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${exploreList[0].savedJobs![index1].createdBy![0].profileImage}' :
                                  index == 3 ? '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${exploreList[0].shortlisted![index1].createdBy![0].profileImage}' :
                                  '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${exploreList[0].hired![index1].createdBy![0].profileImage}',
                            imageBuilder: (context, imageProvider) => Container(
                              width: 65.h,
                              height: 65.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.fill),
                              ),
                            ),
                            errorWidget: (context, url, error) {
                              print("ER::${error.toString()}");
                              return Icon(Icons.error, color: white);
                            },
                            fit: BoxFit.fill,
                            height: ScreenUtil().setHeight(65), width: ScreenUtil().setWidth(65),
                          ),
                          SizedBox(width: 8.w,),
                          Container(
                            width: MediaQuery.of(context).size.width - 95.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      index == 1 ? exploreList[0].applied![index1].createdBy![0].name! :
                                      index == 2 ? exploreList[0].savedJobs![index1].createdBy![0].name! :
                                      index == 3 ? exploreList[0].shortlisted![index1].createdBy![0].name! :
                                      exploreList[0].hired![index1].createdBy![0].name!,
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(18),
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        height: 0.25,
                                        color: black
                                      ),
                                    ),
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
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: Icon(Icons.more_vert, color: darkGray, size: 12.r),
                                      )
                                    )
                                  ],
                                ),
                                SizedBox(height: 12.w,),
                                Text(
                                  index == 1 ? exploreList[0].applied![index1].title! :
                                  index == 2 ? exploreList[0].savedJobs![index1].title! :
                                  index == 3 ? exploreList[0].shortlisted![index1].title! :
                                  exploreList[0].hired![index1].title!,
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(14),
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    height: 0.19,
                                    color: black
                                  ),
                                ),
                                SizedBox(height: 14.w,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      index == 1 ? "From " + DateFormat('dd-MMM-yy').format(exploreList[0].applied![index1].startDate!) + " till " + DateFormat('dd-MMM-yy').format(exploreList[0].applied![index1].endDate!) :
                                      index == 2 ? "From " + DateFormat('dd-MMM-yy').format(exploreList[0].savedJobs![index1].startDate!) + " till " + DateFormat('dd-MMM-yy').format(exploreList[0].savedJobs![index1].endDate!) :
                                      index == 3 ? "From " + DateFormat('dd-MMM-yy').format(exploreList[0].shortlisted![index1].startDate!) + " till " + DateFormat('dd-MMM-yy').format(exploreList[0].shortlisted![index1].endDate!) :
                                      "From " + DateFormat('dd-MMM-yy').format(exploreList[0].hired![index1].startDate!) + " till " + DateFormat('dd-MMM-yy').format(exploreList[0].hired![index1].endDate!),
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        height: 0.16,
                                        color: black
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 2.5.h),
                                      child: Text(
                                        index == 1 ? timeago.format(exploreList[0].applied![index1].createdAt!) :
                                        index == 2 ? timeago.format(exploreList[0].savedJobs![index1].createdAt!) :
                                        index == 3 ? timeago.format(exploreList[0].shortlisted![index1].createdAt!) :
                                        timeago.format(exploreList[0].hired![index1].createdAt!),
                                        style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(10),
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          height: 0.13,
                                          color: black
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
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.r, right: 8.r, top: 8.r),
                    child: Row(
                      children: [
                        Text(
                          index == 1 ? capitalize(exploreList[0].applied![index1].jobLocation!.district) :
                          index == 2 ? capitalize(exploreList[0].savedJobs![index1].jobLocation!.district) :
                          index == 3 ? capitalize(exploreList[0].shortlisted![index1].jobLocation!.district) :
                          capitalize(exploreList[0].hired![index1].jobLocation!.district),
                          style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            height: 0.16,
                            color: black
                          ),
                        ),
                        Spacer(),
                        Text(
                          index == 1 ? exploreList[0].applied![index1].gender != null ? capitalize(exploreList[0].applied![index1].gender) + ", " + exploreList[0].applied![index1].ageGroup.toString() : capitalize(exploreList[0].applied![index1].experienceLevel) :
                          index == 2 ? exploreList[0].savedJobs![index1].gender != null ? capitalize(exploreList[0].savedJobs![index1].gender) + ", " + exploreList[0].savedJobs![index1].ageGroup.toString() : capitalize(exploreList[0].savedJobs![index1].experienceLevel) :
                          index == 3 ? exploreList[0].shortlisted![index1].gender != null ? capitalize(exploreList[0].shortlisted![index1].gender) + ", " + exploreList[0].shortlisted![index1].ageGroup.toString() : capitalize(exploreList[0].shortlisted![index1].experienceLevel) :
                          exploreList[0].hired![index1].gender != null ? capitalize(exploreList[0].hired![index1].gender) + ", " + exploreList[0].hired![index1].ageGroup.toString() : capitalize(exploreList[0].hired![index1].experienceLevel),
                          style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            height: 0.16,
                            color: black
                          ),
                        ),
                        Spacer(),
                        Text(
                          index == 1 ? exploreList[0].applied![index1].gender != null ? exploreList[0].applied![index1].height!.foot.toString() + '’' + exploreList[0].applied![index1].height!.inch.toString() + '”' : '' :
                          index == 2 ? exploreList[0].savedJobs![index1].gender != null ? exploreList[0].savedJobs![index1].height!.foot.toString() + '’' + exploreList[0].savedJobs![index1].height!.inch.toString() + '”' : '' :
                          index == 3 ? exploreList[0].shortlisted![index1].gender != null ? exploreList[0].shortlisted![index1].height!.foot.toString() + '’' + exploreList[0].shortlisted![index1].height!.inch.toString() + '”' : '' :
                          exploreList[0].hired![index1].gender != null ? exploreList[0].hired![index1].height!.foot.toString() + '’' + exploreList[0].hired![index1].height!.inch.toString() + '”' : '',
                          style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            height: 0.16,
                            color: black
                          ),
                        ),
                        Spacer(),
                        Spacer(),
                        Text(
                          index == 1 ? exploreList[0].applied![index1].jobDetails![0].jobCategory ?? "Print Ad" :
                          index == 2 ? exploreList[0].savedJobs![index1].jobDetails![0].jobCategory ?? "Print Ad" :
                          index == 3 ? exploreList[0].shortlisted![index1].jobDetails![0].jobCategory ?? "Print Ad" :
                          exploreList[0].hired![index1].jobDetails![0].jobCategory ?? "Print Ad" ,
                          style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            height: 0.16,
                            color: darkGray
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Padding(
                          padding: EdgeInsets.only(bottom: 6.h),
                          child: SvgPicture.asset(
                            "assets/icons/svg/photoshoot.svg",
                            height: 20.h,
                            width: 20.w,
                            color: orange,
                          ),
                        ),
                        Spacer(),
                      ]
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.r, right: 8.r),
                    child: Text(
                      index == 1 ? exploreList[0].applied![index1].description! :
                      index == 2 ? exploreList[0].savedJobs![index1].description! :
                      index == 3 ? exploreList[0].shortlisted![index1].description! :
                      exploreList[0].hired![index1].description!,
                      style: GoogleFonts.nunitoSans(
                        fontSize: ScreenUtil().setSp(10),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: black
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h,),
                  Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black.withAlpha(40)),
                        boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: white,
                              blurRadius: 10.0,
                            ),
                          ]
                      ),     
                      // "Applied on: " + DateFormat('dd-MMM-yy').format(exploreList[0].applied[index]),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 10.h, bottom: 10.h),
                        child: Row(
                          children: [
                            Text(
                              index == 1 ? "Applied on: " + DateFormat('dd-MMM-yy').format(exploreList[0].applied![index1].appliedOn!) :
                              index == 2 ? "Deadline : " + DateFormat('dd-MMM-yy').format(exploreList[0].savedJobs![index1].deadline!) :
                              index == 3 ? "Applied on: " + DateFormat('dd-MMM-yy').format(exploreList[0].shortlisted![index1].appliedOn!) :
                              "Applied on: " + DateFormat('dd-MMM-yy').format(exploreList[0].hired![index1].appliedOn!),
                              style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                color: black
                              ),
                            ),
                            SizedBox(width: 22.w,),
                            InkWell(
                              onTap: (){
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
                                          borderRadius: BorderRadius.circular(12.r)
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(15.r),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Once you withdraw your application, you will not be able to apply to this job again?\n\nAre you sure you want to withdraw your application?",
                                                style: GoogleFonts.nunitoSans(
                                                  fontSize: ScreenUtil().setSp(14),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  color: black
                                                ),
                                              ),
                                              SizedBox(height: 35.h),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Yes",
                                                    style: GoogleFonts.nunitoSans(
                                                      fontSize: ScreenUtil().setSp(14),
                                                      fontWeight: FontWeight.w700,
                                                      fontStyle: FontStyle.normal,
                                                      color: black
                                                    ),
                                                  ),
                                                  SizedBox(width: 40.w,),
                                                  Text(
                                                    "No",
                                                    style: GoogleFonts.nunitoSans(
                                                      fontSize: ScreenUtil().setSp(14),
                                                      fontWeight: FontWeight.w400,
                                                      fontStyle: FontStyle.normal,
                                                      color: darkGray
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ]
                                          ),
                                        )
                                      )
                                    );
                                  }
                                );
                              },
                              child: Text(
                                "Withdraw",
                                style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  color: black
                                ),
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => FameChatScreen()),
                                );
                              },
                              child: Text(
                                "Chat",
                                style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  color: darkGray
                                ),
                              ),
                            ),
                          ]
                        ),
                      )
                    ),
                  ),
                ]
              ),
            ),
          );
        }
      ),
    );
  }
}