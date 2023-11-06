import 'package:cached_network_image/cached_network_image.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/joblinks/brandExploreAll.dart';
import 'package:famelink/ui/joblinks/brandExploreProfiles.dart';
import 'package:famelink/ui/joblinks/brandExploreSaved.dart';
import 'package:famelink/ui/joblinks/jobController.dart';
import 'package:famelink/ui/joblinks/models/BrandAgencyExplore.dart';
import 'package:famelink/ui/joblinks/reportDialog.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BrandExplore extends StatefulWidget {
  BrandExplore({Key? key}) : super(key: key);

  @override
  State<BrandExplore> createState() => _BrandExploreState();
}

class _BrandExploreState extends State<BrandExplore> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TextEditingController searchController = TextEditingController();
  JobController controller = Get.put(JobController());
  TabController? tabController;
  List<Profile> profile = <Profile>[];
  List<SavedTalent> savedTalent = <SavedTalent>[];
  int page = 1;
  ScrollController fameScrollController = ScrollController();
  bool isLoading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.activeIndex.value = 0;
    setState(() {
      tabController = TabController(length: 3, vsync: this);
      tabController!.addListener(() {
       setState(() {
          controller.activeIndex.value = tabController!.index;
       });
      });
      fameScrollController.addListener(() {
        if (fameScrollController.position.maxScrollExtent == fameScrollController.position.pixels) {
          page++;
        }
      });
      getData('');
      isLoading = true;
    });
  }

  String capitalize(val) {
    return val[0].toString().toUpperCase() + val.substring(1);
  }

  void getData(val) async {
    profile.clear();
    savedTalent.clear();
    Map<String, dynamic> param = {
      "page": page.toString(),
      "search": val,
    };
    
    Api.get.call(context,
        method: "joblinks/explore/brandAgency",
        param: param, contentType: "application/x-www-form-urlencoded",
        isLoading: false, onResponseSuccess: (Map<dynamic,dynamic> object) {
      var result = BrandAgencyModel.fromJson(object);
      if (result.result!.profiles!.length > 0) {
        profile.addAll(result.result!.profiles!);
        setState(() {});
      } else {
        page == 1 ? page :page--;
      }
      
      if (result.result!.savedTalents!.length > 0) {
        savedTalent.addAll(result.result!.savedTalents!);
        setState(() {});
      } else {
        page == 1 ? page :page--;
      }
      isLoading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 40.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w, top: 10),
                  child: Icon(Icons.arrow_back_ios_new_rounded, color: black, size: 25),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(16),
                      left: ScreenUtil().setWidth(10),
                      right: ScreenUtil().setWidth(20)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(ScreenUtil().radius(8)),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      onChanged: (val){
                        page = 1;
                        if(val.length >= 3){
                          getData(val);
                        }else if(val.length == 0){
                          getData('');
                        }
                      },
                      controller: searchController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      cursorColor: black,
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                          color: Color(0xff9B9B9B)),
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.all(ScreenUtil().setWidth(10)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().radius(16)),
                            borderSide:
                                BorderSide(color: Color(0xff9B9B9B), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().radius(16)),
                            borderSide: BorderSide(color: lightRed, width: 1),
                          ),
                          suffixIcon: Image.asset("assets/icons/search.png", color: Color(0xff9B9B9B)),
                          hintText: 'Search',
                          hintStyle: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(14),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              color: lightGray)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
            child: Row(
              children: [
                Expanded(
                  child: TabBar(
                    tabs: [
                      Tab(
                        child: IntrinsicWidth(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'All',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w400,
                                  color: controller.activeIndex.value == 0 ? black : lightGray,
                                  fontSize: ScreenUtil().setSp(controller.activeIndex.value == 0 ? 14 : 12),
                                ),
                              ),
                              SizedBox(height: 3.h),
                              Container(
                                height: 1,
                                color: controller.activeIndex.value == 0 ? black : lightGray,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: IntrinsicWidth(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Profiles',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w400,
                                  color: controller.activeIndex.value == 1 ? black : lightGray,
                                  fontSize: ScreenUtil().setSp(controller.activeIndex.value == 1 ? 14 : 12),
                                ),
                              ),
                              SizedBox(height: 3.h),
                              Container(
                                height: 1,
                                color: controller.activeIndex.value == 1 ? black : lightGray,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: IntrinsicWidth(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Saved Talents',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      color: controller.activeIndex.value == 2 ? black : lightGray,
                                      fontSize: ScreenUtil().setSp(controller.activeIndex.value == 2 ? 14 : 12),
                                    ),
                                  ),
                                  SizedBox(width: 5.w,),
                                  SvgPicture.asset("assets/icons/svg/bookmark.svg", color: controller.activeIndex.value == 2 ? black : lightGray, height: 18.h, width: 18.w),
                                ],
                              ),
                              SizedBox(height: 3.h),
                              Container(
                                height: 1,
                                color: controller.activeIndex.value == 2 ? black : lightGray,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    indicatorColor: Colors.transparent,
                    isScrollable: true,
                    unselectedLabelColor: lightGray,
                    labelColor: black,
                    controller: tabController,
                  ),
                ),
              ],
            ),
          ),
          profile.isEmpty && savedTalent.isEmpty ? Expanded(child: Center(child: CircularProgressIndicator(color: black, strokeWidth: 3.w,)))
          : Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: TabBarView(
                controller: tabController,
                children: [
                  tabData(profileList: profile, savedTalentList: savedTalent),
                  tabData(profileList: profile),
                  tabData(savedTalentList: savedTalent),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  } 
  SingleChildScrollView tabData({List<Profile>? profileList, List<SavedTalent>? savedTalentList}) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          profileList != null && savedTalentList != null
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
          profileList == null ? Container() :
          Padding(
            padding: EdgeInsets.only(left: 22.w, right: 22.w),
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.zero,
              itemCount: profileList != null && savedTalentList != null ? profileList.length >= 5 ? 5 : profileList.length : profileList.length,
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
          profileList != null && savedTalentList != null 
          ? SizedBox(height: 24.h,) : Container(),
          profileList != null && savedTalentList != null
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
          profileList != null && savedTalentList != null 
          ? SizedBox(height: 12.h,) : Container(),
          savedTalentList == null ? Container() : 
          Padding(
            padding: EdgeInsets.only(left: 22.w, right: 22.w),
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.zero,
              itemCount: profileList != null && savedTalentList != null ? savedTalentList.length >= 5 ? 5 : savedTalentList.length : savedTalentList.length,
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
                                          showGeneralDialog(
                                            context: context,
                                            pageBuilder: (BuildContext buildContext,
                                                Animation animation, Animation secondaryAnimation) {
                                              return ReportDialog(savedTalentList[index].masterProfile!.id!, 'talent');
                                            });
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
    );
  }
}


