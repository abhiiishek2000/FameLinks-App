import 'package:famelink/common/common_image.dart';
import 'package:famelink/ui/Famelinkprofile/function/famelinkFun.dart';
import 'package:famelink/ui/joblinks/createjob/createJob.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../common/common_routing.dart';
import '../../../networking/config.dart';
import '../../homedial/ui/editUserProfile.dart';
import '../../joblinks/application/brandDetailApplication.dart';
import '../../joblinks/hiringprofile/hiringProfile.dart';

class JobLinkNameField extends StatefulWidget {
  int? i;

  JobLinkNameField({this.i});

  @override
  State<JobLinkNameField> createState() => _JobLinkNameFieldState();
}

class _JobLinkNameFieldState extends State<JobLinkNameField> {
  int index = 1;
  int tabIndex = 0;
  TextEditingController descController = TextEditingController();
  final _scroll = ScrollController();

  List<String> piclist = [
    "assets/icons/svg/photoshoot.svg",
    "assets/icons/svg/videoshot.svg",
    "assets/icons/svg/jobactivity.svg",
    "assets/icons/svg/filmshot.svg"
  ];

  List<String> gridtext = ["Print", "Video", "Activity", "Film"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if (index == 2) {
        tabIndex = 1;
      }
      if (widget.i != null) {
        index = widget.i!;
        tabIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FameLinkFun>(
      builder: (context, provider, child) {
        if (provider.otherUserProfileJobLinksModelResult.length != 0) {
          descController.text = provider
              .otherUserProfileJobLinksModelResult[0].greetText
              .toString();
        }
        return provider.otherUserProfileJobLinksModelResult.length != 0
            ? Padding(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                child: Column(
                  children: <Widget>[
                    index == 4 || index == 5
                        ? Container()
                        : Container(
                            width: ScreenUtil().screenWidth,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    CommonImage.bottom_shape_container),
                                fit: BoxFit.fill,
                              ),
                            ),
                            padding: EdgeInsets.only(
                                top: 5.h, left: 3.w, right: 8.w, bottom: 8.h),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(children: [
                                      SizedBox(width: 8.w),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundImage: provider
                                                      .otherUserProfileJobLinksModelResult[
                                                          0]
                                                      .profileImageType ==
                                                  "image"
                                              ? NetworkImage(
                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.otherUserProfileJobLinksModelResult[0].profileImage}",
                                                )
                                              : NetworkImage(
                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.otherUserProfileJobLinksModelResult[0].profileImage}",
                                                ),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        provider
                                            .otherUserProfileJobLinksModelResult[
                                                0]
                                            .name
                                            .toString(),
                                        style: GoogleFonts.nunitoSans(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color: black,
                                        ),
                                      ),
                                    ]),
                                    InkWell(
                                      onTap: () {
                                        EditUserProfileState.selectAvatar = "_";
                                        EditUserProfileState
                                            .selectImageFilePath;
                                        EditUserProfileState.selectAvatarType =
                                            "";
                                        // });
                                        String tempDate = provider
                                                    .otherUserProfileJobLinksModelResult[
                                                        0]
                                                    .masterUser!
                                                    .dob !=
                                                'null'
                                            ? DateFormat('dd-MM-yyyy').format(
                                                DateFormat('yyyy-MM-dd').parse(
                                                    provider
                                                        .otherUserProfileJobLinksModelResult[
                                                            0]
                                                        .masterUser!
                                                        .dob
                                                        .toString()))
                                            : "";

                                        gotoUserEditProfileScreen(
                                          context,
                                          isProfileUpdate: false,
                                          dobs: tempDate,
                                          runTypes: 3,
                                          names: provider
                                              .otherUserProfileJobLinksModelResult[
                                                  0]
                                              .name
                                              .toString(),
                                          userNames: provider
                                              .otherUserProfileJobLinksModelResult[
                                                  0]
                                              .masterUser!
                                              .username
                                              .toString(),
                                          imagUrls: provider
                                              .otherUserProfileJobLinksModelResult[
                                                  0]
                                              .profileImage
                                              .toString(),
                                          districts:
                                              "${provider.otherUserProfileJobLinksModelResult[0].masterUser!.district}",
                                          states: provider
                                              .otherUserProfileJobLinksModelResult[
                                                  0]
                                              .masterUser!
                                              .state,
                                          countrys: provider
                                              .otherUserProfileJobLinksModelResult[
                                                  0]
                                              .masterUser!
                                              .country,
                                          bios: provider
                                              .otherUserProfileJobLinksModelResult[
                                                  0]
                                              .bio
                                              .toString(),
                                          professions: provider
                                              .otherUserProfileJobLinksModelResult[
                                                  0]
                                              .profession
                                              .toString(),
                                          imageType: provider
                                              .otherUserProfileJobLinksModelResult[
                                                  0]
                                              .profileImageType
                                              .toString(),
                                        );
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              left: 6.w,
                                              right: 6.w,
                                              top: 2.h,
                                              bottom: 2.h),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(CommonImage
                                                  .funLinksStoreEditButton),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Edit Profile',
                                            style: GoogleFonts.nunitoSans(
                                              fontSize: 14.sp,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w400,
                                              color: white.withOpacity(0.75),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Padding(
                                  padding: EdgeInsets.only(left: 9.w),
                                  child: Divider(
                                    height: 1.h,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 7.h),
                                Padding(
                                  padding: EdgeInsets.only(left: 9.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(children: [
                                        SizedBox(
                                          width:
                                              ScreenUtil().screenWidth * 0.50.w,
                                          child: Text(
                                            "${provider.otherUserProfileJobLinksModelResult[0].masterUser!.district} ${provider.otherUserProfileJobLinksModelResult[0].masterUser!.state} ${provider.otherUserProfileJobLinksModelResult[0].masterUser!.country}",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.nunitoSans(
                                              fontSize: 12.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ]),
                                      Row(children: [
                                        SizedBox(
                                          height: 16.h,
                                          width: 16.w,
                                          child: Image.asset(
                                            CommonImage.funLinksStoreCoinsIcon,
                                            height: 15.h,
                                            width: 21.w,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        SizedBox(width: 5.w),
                                        Text(
                                          " ${provider.otherUserProfileJobLinksModelResult[0].masterUser!.fameCoins}",
                                          style: GoogleFonts.nunitoSans(
                                            fontSize: 14.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 7.h),
                              ],
                            ),
                          ),
                    index == 4 || index == 5
                        ? Container()
                        : SizedBox(height: 16.h),
                    index == 3 || index == 4 || index == 5
                        ? Container()
                        : ApiProvider.userType != 'brand'
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                          "assets/icons/rect.png",
                                          height: 125.h,
                                          width: 115.w,
                                        ),
                                        Positioned(
                                          top: 20.h,
                                          left: 10.w,
                                          child: Image.network(
                                            "${ApiProvider.s3UrlPath}/joblinks/${provider.otherUserProfileJobLinksModelResult![0].greetVideo}-xs",
                                            fit: BoxFit.cover,
                                            height: 90.h,
                                            width: 90.w,
                                          ),
                                        ),
                                        Positioned(
                                          top: 50,
                                          left: 40,
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
                                  SizedBox(width: 16.w),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Greeting message:',
                                              style: GoogleFonts.nunitoSans(
                                                fontSize: 12.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: 6.w,
                                                      right: 6.w,
                                                      top: 2.h,
                                                      bottom: 2.h),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: orange),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.r)),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Edit Message',
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                      fontSize: 12.sp,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: white,
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                        Container(
                                          height: 91.h,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              155.w,
                                          child: TextFormField(
                                            controller: descController,
                                            keyboardType: TextInputType.name,
                                            textInputAction:
                                                TextInputAction.next,
                                            cursorColor: black,
                                            maxLines: 5,
                                            style: GoogleFonts.nunitoSans(
                                                fontSize:
                                                    ScreenUtil().setSp(12),
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                color: white),
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5.r),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          ScreenUtil()
                                                              .radius(1.r)),
                                                  borderSide: BorderSide(
                                                      color: white
                                                          .withOpacity(0.6),
                                                      width: 1),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          ScreenUtil()
                                                              .radius(1.r)),
                                                  borderSide: BorderSide(
                                                      color: white
                                                          .withOpacity(0.6),
                                                      width: 1),
                                                ),
                                                hintText:
                                                    'Hi <<Name>>,Thank you so much for reaching me out and finding my profile suitable for your project requirement. Shall revert soon and hope to work with you. -Sejal',
                                                hintStyle:
                                                    GoogleFonts.nunitoSans(
                                                        fontSize: ScreenUtil()
                                                            .setSp(12),
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: white)),
                                          ),
                                        ),
                                      ]),
                                ],
                              )
                            : Container(),
                    index == 3 || index == 4 || index == 5
                        ? Container()
                        : SizedBox(height: 20.h),
                    index == 3
                        ? Row(
                            children: [
                              Text(
                                'Job Created: ',
                                style: GoogleFonts.nunitoSans(
                                  fontSize: 12.sp,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  color: white,
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 28.h,
                                    width: 28.w,
                                    decoration: BoxDecoration(
                                        color: white,
                                        border: Border.all(color: lightGray),
                                        borderRadius:
                                            BorderRadius.circular(6.r)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: ScreenUtil().setHeight(4),
                                          left: ScreenUtil().setWidth(5)),
                                      child: SvgPicture.asset(
                                        "assets/icons/svg/jobedit.svg",
                                        height: ScreenUtil().setHeight(16),
                                        width: ScreenUtil().setWidth(16),
                                      ),
                                    ),
                                  )),
                            ],
                          )
                        : ApiProvider.userType != 'brand'
                            ? Row(
                                children: [
                                  Text(
                                    'Job Profiles: ',
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: 12.sp,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                      color: white,
                                    ),
                                  ),
                                  SizedBox(width: 17.w),
                                  index == 2
                                      ? Container()
                                      : InkWell(
                                          onTap: () {
                                            setState(() {
                                              tabIndex = 0;
                                            });
                                          },
                                          child: IntrinsicWidth(
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Front Faces',
                                                  style: GoogleFonts.nunitoSans(
                                                      fontSize: 12.sp,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight: tabIndex == 0
                                                          ? FontWeight.w700
                                                          : FontWeight.w400,
                                                      color: tabIndex == 0
                                                          ? white
                                                          : white.withOpacity(
                                                              0.6)),
                                                ),
                                                SizedBox(height: 2.h),
                                                Container(
                                                    height: 1,
                                                    color: tabIndex == 0
                                                        ? orange
                                                        : Colors.transparent)
                                              ],
                                            ),
                                          ),
                                        ),
                                  index == 2
                                      ? Container()
                                      : SizedBox(width: 24.w),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        tabIndex = 1;
                                      });
                                    },
                                    child: IntrinsicWidth(
                                      child: Column(
                                        children: [
                                          Text(
                                            'Behind the Scenes',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 12.sp,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: tabIndex == 1
                                                    ? FontWeight.w700
                                                    : FontWeight.w400,
                                                color: tabIndex == 1
                                                    ? white
                                                    : white.withOpacity(0.6)),
                                          ),
                                          SizedBox(height: 2.h),
                                          Container(
                                              height: 1,
                                              color: tabIndex == 1
                                                  ? orange
                                                  : Colors.transparent)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  index == 5
                                      ? Container()
                                      : InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HiringProfile(
                                                    tabIndex: tabIndex,
                                                    // faces: provider
                                                    //             .otherUserProfileJobLinksModelResult[
                                                    //                 0]
                                                    //             .faces ==
                                                    //         null
                                                    //     ? null
                                                    //     : "2234",
                                                    // crew: provider
                                                    //             .otherUserProfileJobLinksModelResult[
                                                    //                 0]
                                                    //             .crew ==
                                                    //         null
                                                    //     ? null
                                                    //     : "2234",
                                                  ),
                                                ));
                                          },
                                          child: Container(
                                            height: 28.h,
                                            width: 28.w,
                                            decoration: BoxDecoration(
                                                color: white,
                                                border: Border.all(
                                                    color: lightGray),
                                                borderRadius:
                                                    BorderRadius.circular(6.r)),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom:
                                                      ScreenUtil().setHeight(4),
                                                  left:
                                                      ScreenUtil().setWidth(5)),
                                              child: SvgPicture.asset(
                                                "assets/icons/svg/jobedit.svg",
                                                height:
                                                    ScreenUtil().setHeight(16),
                                                width:
                                                    ScreenUtil().setWidth(16),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              )
                            : Container(),
                    SizedBox(height: 12.h),
                    index == 3
                        ? Expanded(
                            child: Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(20),
                                left: ScreenUtil().setWidth(12),
                                right: ScreenUtil().setWidth(12)),
                            child: jobs(),
                          ))
                        : index == 5
                            ? tabIndex == 0
                                ? jobs()
                                : jobs()
                            : tabIndex == 0
                                ? provider
                                            .otherUserProfileJobLinksModelResult[
                                                0]
                                            .faces ==
                                        null
                                    ? Container()
                                    : Column(children: [
                                        Row(children: [
                                          Text(
                                            'Available for:',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 12.sp,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                                color: white),
                                          ),
                                          SizedBox(width: 12.w),
                                          Container(
                                            height: 50.h,
                                            width: 160.w,
                                            child: ListView.builder(
                                                itemCount: provider.otherUserProfileJobLinksModelResult[0].faces!.interestCat!.length,
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int i) {
                                                  var v = provider.otherUserProfileJobLinksModelResult[0].faces!.interestCat![i];
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        right: ScreenUtil()
                                                            .setWidth(12),
                                                        top: ScreenUtil()
                                                            .setWidth(10)),
                                                    child: Column(
                                                      children: [
                                                        SvgPicture.asset(
                                                          piclist[i],
                                                          height: ScreenUtil()
                                                              .setHeight(16),
                                                          width: ScreenUtil()
                                                              .setWidth(16),
                                                          color: orange,
                                                        ),
                                                        SizedBox(
                                                          height: ScreenUtil()
                                                              .setHeight(10),
                                                        ),
                                                        Text('${v.jobName}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: white,
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          12),
                                                              height: 0.16,
                                                            )),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ]),
                                        SizedBox(height: 16.h),
                                        Row(
                                          children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(children: [
                                                    Text(
                                                      'Height: ',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: white,
                                                        fontSize: ScreenUtil()
                                                            .setSp(12),
                                                        height: 0.22,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${provider.otherUserProfileJobLinksModelResult[0].faces!.height!.foot}' ${provider.otherUserProfileJobLinksModelResult[0].faces!.height!.inch} ",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: white,
                                                        fontSize: ScreenUtil()
                                                            .setSp(12),
                                                        height: 0.22,
                                                      ),
                                                    ),
                                                    SizedBox(width: 12.w),
                                                    Text(
                                                      'Weight: ',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: white,
                                                        fontSize: ScreenUtil()
                                                            .setSp(12),
                                                        height: 0.22,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${provider.otherUserProfileJobLinksModelResult[0].faces!.weight} kg',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: white,
                                                        fontSize: ScreenUtil()
                                                            .setSp(12),
                                                        height: 0.22,
                                                      ),
                                                    ),
                                                    SizedBox(width: 12.w),
                                                    Text(
                                                      'Vitals: ',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: white,
                                                        fontSize: ScreenUtil()
                                                            .setSp(12),
                                                        height: 0.22,
                                                      ),
                                                    ),
                                                    Text(
                                                      'B ${provider.otherUserProfileJobLinksModelResult[0].faces!.bust}, W ${provider.otherUserProfileJobLinksModelResult[0].faces!.waist}, H ${provider.otherUserProfileJobLinksModelResult[0].faces!.hip}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: white,
                                                        fontSize: ScreenUtil()
                                                            .setSp(12),
                                                        height: 0.22,
                                                      ),
                                                    ),
                                                  ]),
                                                  SizedBox(height: 20.h),
                                                  Row(children: [
                                                    Text(
                                                      'Eye Color: ',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: white,
                                                        fontSize: ScreenUtil()
                                                            .setSp(12),
                                                        height: 0.22,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${provider.otherUserProfileJobLinksModelResult[0].faces!.eyeColor}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: white,
                                                        fontSize: ScreenUtil()
                                                            .setSp(12),
                                                        height: 0.22,
                                                      ),
                                                    ),
                                                    SizedBox(width: 12.w),
                                                    Text(
                                                      'Complexion: ',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: white,
                                                        fontSize: ScreenUtil()
                                                            .setSp(12),
                                                        height: 0.22,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${provider.otherUserProfileJobLinksModelResult[0].faces!.complexion}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: white,
                                                        fontSize: ScreenUtil()
                                                            .setSp(12),
                                                        height: 0.22,
                                                      ),
                                                    ),
                                                  ]),
                                                  SizedBox(height: 13.h),
                                                ]),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Interested Locations:',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w700,
                                                color: white,
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            Container(
                                              height: 70.h,
                                              width: 130.w,
                                              child: Wrap(
                                                children: [
                                                  ListView.builder(
                                                      shrinkWrap: true,
                                                      primary: false,
                                                      padding: EdgeInsets.zero,
                                                      itemCount: provider
                                                          .otherUserProfileJobLinksModelResult[
                                                              0]
                                                          .faces!
                                                          .interestedLoc!
                                                          .length,
                                                      itemBuilder:
                                                          (context, i) {
                                                        return Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 5.h),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                height: 5.h,
                                                                width: 5.w,
                                                                decoration: BoxDecoration(
                                                                    color:
                                                                        white,
                                                                    shape: BoxShape
                                                                        .circle),
                                                              ),
                                                              SizedBox(
                                                                  width: 5.w),
                                                              Text(
                                                                '${provider.otherUserProfileJobLinksModelResult[0].faces!.interestedLoc![i].district}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts
                                                                    .nunitoSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: white,
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              12),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        //   SizedBox(height: 5.h),
                                        Container(
                                            height: 110.h,
                                            child: ListView.builder(
                                                primary: false,
                                                shrinkWrap: true,
                                                itemCount: provider
                                                    .userPostsjob.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    ClampingScrollPhysics(),
                                                itemBuilder: (context, i) {
                                                  print(
                                                      "videolink  ${provider.userPostsjob[i].video}");
                                                  return InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        show(context);
                                                      });
                                                    },
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          height: ScreenUtil()
                                                              .setHeight(116),
                                                          width: ScreenUtil()
                                                              .setWidth(116),
                                                          child: Image.network(
                                                            "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.userPostsjob[i].video}-xs",
                                                            height: 116.h,
                                                            width: 116.h,
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
                                                    ),
                                                  );
                                                })),
                                        SizedBox(height: 16.h),
                                      ])
                                : provider
                                            .otherUserProfileJobLinksModelResult[
                                                0]
                                            .crew ==
                                        null
                                    ? Container()
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                            Row(children: [
                                              Text(
                                                'Available for:',
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize: 12.sp,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                    color: white),
                                              ),
                                              SizedBox(width: 12.w),
                                              Container(
                                                height: 50.h,
                                                width: 160.w,
                                                child: ListView.builder(
                                                    itemCount: provider.otherUserProfileJobLinksModelResult[0].crew!.interestCat!.length,
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,
                                                    primary: false,
                                                    scrollDirection:
                                                    Axis.horizontal,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                        int i) {
                                                      var v = provider.otherUserProfileJobLinksModelResult[0].crew!.interestCat![i];
                                                      return Padding(
                                                        padding: EdgeInsets.only(
                                                            right: ScreenUtil()
                                                                .setWidth(12),
                                                            top: ScreenUtil()
                                                                .setWidth(10)),
                                                        child: Column(
                                                          children: [
                                                            SvgPicture.asset(
                                                              piclist[i],
                                                              height: ScreenUtil()
                                                                  .setHeight(16),
                                                              width: ScreenUtil()
                                                                  .setWidth(16),
                                                              color: orange,
                                                            ),
                                                            SizedBox(
                                                              height: ScreenUtil()
                                                                  .setHeight(10),
                                                            ),
                                                            Text('${v.jobName}',
                                                                textAlign: TextAlign
                                                                    .center,
                                                                style: GoogleFonts
                                                                    .nunitoSans(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                                  color: white,
                                                                  fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                      12),
                                                                  height: 0.16,
                                                                )),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ]),
                                            SizedBox(height: 16.h),
                                            Text(
                                              'Awards Won: ',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w700,
                                                color: white,
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 5.w),
                                              child: Text(
                                                "${provider.otherUserProfileJobLinksModelResult[0].crew!.achievements}",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w400,
                                                  color: white,
                                                  fontSize:
                                                      ScreenUtil().setSp(12),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 8.h),
                                            Text(
                                              'Work Experience: ',
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w700,
                                                color: white,
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                              ),
                                            ),
                                            Text(
                                              "${provider.otherUserProfileJobLinksModelResult[0].crew!.workExperience}",
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                color: white,
                                                fontSize:
                                                    ScreenUtil().setSp(12),
                                              ),
                                            ),
                                            SizedBox(height: 16.h),
                                            Text(
                                              'Interested Locations:',
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w700,
                                                color: white,
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 5.w, top: 5.h),
                                              child: Container(
                                                height: 70.h,
                                                width: 130.w,
                                                child: Wrap(
                                                  children: [
                                                    ListView.builder(
                                                        shrinkWrap: true,
                                                        primary: false,
                                                        padding:
                                                            EdgeInsets.zero,
                                                        itemCount: provider
                                                            .otherUserProfileJobLinksModelResult[
                                                                0]
                                                            .crew!
                                                            .interestedLoc!
                                                            .length,
                                                        itemBuilder:
                                                            (context, i) {
                                                          return Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        5.h),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  height: 5.h,
                                                                  width: 5.w,
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          white,
                                                                      shape: BoxShape
                                                                          .circle),
                                                                ),
                                                                SizedBox(
                                                                    width: 5.w),
                                                                Text(
                                                                  '${provider.otherUserProfileJobLinksModelResult[0].crew!.interestedLoc![i].district}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: GoogleFonts
                                                                      .nunitoSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        white,
                                                                    fontSize: ScreenUtil()
                                                                        .setSp(
                                                                            12),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            //  SizedBox(height: 10.h),
                                            Container(
                                                height: 110.h,
                                                child: ListView.builder(
                                                    primary: false,
                                                    shrinkWrap: true,
                                                    itemCount: provider
                                                        .userPostsjob.length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    itemBuilder: (context, i) {
                                                      return InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            show(context);
                                                          });
                                                        },
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              height:
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          116),
                                                              width:
                                                                  ScreenUtil()
                                                                      .setWidth(
                                                                          116),
                                                              child:
                                                                  Image.network(
                                                                "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.userPostsjob[i].video}-xs",
                                                                height: 116.h,
                                                                width: 116.h,
                                                              ),
                                                            ),
                                                            if (i == 0) ...[
                                                              Center(
                                                                child:
                                                                    Image.asset(
                                                                  "assets/icons/rect.png",
                                                                  height: 125.h,
                                                                  width: 115.w,
                                                                ),
                                                              ),
                                                            ]
                                                          ],
                                                        ),
                                                      );
                                                    })),
                                            SizedBox(height: 16.h),
                                          ]),
                  ],
                ),
              )
            : Container();
      },
    );
  }

  Container jobs() {
    return Container(
      child: ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        primary: false,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(16)),
            child: Container(
              decoration: BoxDecoration(
                  color: white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.2))),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(10),
                        left: ScreenUtil().setWidth(24)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IntrinsicWidth(
                              child: Column(children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 14.5.h, right: 10.w),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(15)),
                                        child: Text(
                                          'Female, 18-28 yrs',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w700,
                                            color: white,
                                            fontSize: ScreenUtil().setSp(16),
                                            height: 0.22,
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 2.0),
                                                blurRadius: 2.0,
                                                color: Color(0xff000000)
                                                    .withOpacity(0.25),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(12),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(15)),
                                        child: Text('5’ 6”',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize: ScreenUtil().setSp(16),
                                              height: 0.22,
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(0.0, 2.0),
                                                  blurRadius: 2.0,
                                                  color: Color(0xff000000)
                                                      .withOpacity(0.25),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 13.h),
                                  child: Container(
                                    height: 1,
                                    decoration:
                                        BoxDecoration(color: white, boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 2),
                                        color: white,
                                        blurRadius: 2.0,
                                      ),
                                    ]),
                                  ),
                                ),
                              ]),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: Container(
                                height: 50.h,
                                width: 105.w,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: ListView.builder(
                                      itemCount: 1,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              right: ScreenUtil().setWidth(12),
                                              top: ScreenUtil().setWidth(10)),
                                          child: Column(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/svg/photoshoot.svg",
                                                height:
                                                    ScreenUtil().setHeight(25),
                                                width:
                                                    ScreenUtil().setWidth(25),
                                                color: orange,
                                              ),
                                              SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(10),
                                              ),
                                              Text('Print',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    color: white,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    height: 0.16,
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                        offset:
                                                            Offset(0.0, 2.0),
                                                        blurRadius: 2.0,
                                                        color: Color(0xff000000)
                                                            .withOpacity(0.25),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(20),
                                right: ScreenUtil().setWidth(12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Mumbai',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      color: white,
                                      fontSize: ScreenUtil().setSp(14),
                                      height: 0.19,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 2.0,
                                          color: Color(0xff000000)
                                              .withOpacity(0.25),
                                        ),
                                      ],
                                    )),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(24),
                              right: ScreenUtil().setWidth(6)),
                          child: Container(
                            height: 100.h,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: 2,
                                scrollDirection: Axis.horizontal,
                                controller: _scroll,
                                itemBuilder: (context, i1) {
                                  return i1 == 0
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    child: Text(
                                                      'Models required for Ethenic Wear shoot',
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: white,
                                                        fontSize: ScreenUtil()
                                                            .setSp(22),
                                                        height: 1.2,
                                                        shadows: <Shadow>[
                                                          Shadow(
                                                            offset: Offset(
                                                                0.0, 2.0),
                                                            blurRadius: 2.0,
                                                            color: Color(
                                                                    0xff000000)
                                                                .withOpacity(
                                                                    0.25),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  // Spacer(),
                                                  InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          // scr(1);
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        color: white
                                                            .withOpacity(0.8),
                                                        size: ScreenUtil()
                                                            .radius(15),
                                                      ))
                                                ],
                                              ),
                                              SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(20),
                                              ),
                                              Text(
                                                'From 15-Sep-21 till 20-Sep-21',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w600,
                                                  color: black,
                                                  fontSize:
                                                      ScreenUtil().setSp(12),
                                                  height: 0.16,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 2.0),
                                                      blurRadius: 2.0,
                                                      color: Color(0xff000000)
                                                          .withOpacity(0.25),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      // scr(0);
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: ScreenUtil()
                                                            .setHeight(15)),
                                                    child: Icon(
                                                        Icons
                                                            .arrow_back_ios_rounded,
                                                        color: white
                                                            .withOpacity(0.8),
                                                        size: 15),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      ScreenUtil().setWidth(10),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      88,
                                                  child: Text(
                                                    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                                    // trimLines: 4,
                                                    // trimMode: TrimMode.Line,
                                                    // colorClickableText: white,
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: white,
                                                      fontSize: ScreenUtil()
                                                          .setSp(14),
                                                      height: 1.2,
                                                      shadows: <Shadow>[
                                                        Shadow(
                                                          offset:
                                                              Offset(0.0, 2.0),
                                                          blurRadius: 2.0,
                                                          color:
                                                              Color(0xff000000)
                                                                  .withOpacity(
                                                                      0.25),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(20)),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: ScreenUtil()
                                                      .setWidth(24)),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Deadline: 13-Sep-21',
                                                    textAlign: TextAlign.left,
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: white,
                                                      fontSize: ScreenUtil()
                                                          .setSp(14),
                                                      height: 0.16,
                                                      shadows: <Shadow>[
                                                        Shadow(
                                                          offset:
                                                              Offset(0.0, 2.0),
                                                          blurRadius: 2.0,
                                                          color:
                                                              Color(0xff000000)
                                                                  .withOpacity(
                                                                      0.25),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 30.0),
                                                    child: Text(
                                                      'Close',
                                                      textAlign: TextAlign.left,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: white,
                                                        fontSize: ScreenUtil()
                                                            .setSp(14),
                                                        height: 0.16,
                                                        shadows: <Shadow>[
                                                          Shadow(
                                                            offset: Offset(
                                                                0.0, 2.0),
                                                            blurRadius: 2.0,
                                                            color: Color(
                                                                    0xff000000)
                                                                .withOpacity(
                                                                    0.25),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                }),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: ScreenUtil().setHeight(31)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  'Faces',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: white,
                                    fontSize: ScreenUtil().setSp(14),
                                    height: 0.16,
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 2.0),
                                        blurRadius: 2.0,
                                        color:
                                            Color(0xff000000).withOpacity(0.25),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              SvgPicture.asset("assets/icons/svg/share.svg",
                                  color: white),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreateJob()),
                                  );
                                },
                                child: Container(
                                  height: 30.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                    color: white.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: orange),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Edit Job',
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w600,
                                        color: white,
                                        fontSize: ScreenUtil().setSp(12),
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 2.0),
                                            blurRadius: 2.0,
                                            color: Color(0xff000000)
                                                .withOpacity(0.25),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(12)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(3)),
                                  child: Text(
                                    '3 days ago',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      color: white,
                                      fontSize: ScreenUtil().setSp(10),
                                      height: 0.13,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 2.0,
                                          color: Color(0xff000000)
                                              .withOpacity(0.25),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(8)),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0.0, 8.0),
                            blurRadius: 30.0,
                            color: Color(0xff000000).withOpacity(0.40),
                          )
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(16),
                          right: ScreenUtil().setWidth(15),
                          top: ScreenUtil().setHeight(13),
                          bottom: ScreenUtil().setHeight(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BrandDetailApplication()),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Applications',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                    fontSize: ScreenUtil().setSp(12),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 60.h,
                                      width: MediaQuery.of(context).size.width -
                                          120.w,
                                      child: ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: 4,
                                          scrollDirection: Axis.horizontal,
                                          controller: _scroll,
                                          itemBuilder: (context, i2) {
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(right: 15.w),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: Offset(0, 2),
                                                          color: black,
                                                          blurRadius: 2.r,
                                                        ),
                                                      ]),
                                                  child: Image.asset(
                                                    "assets/icons/two.png",
                                                    height: 50.h,
                                                    width: 50.h,
                                                  )),
                                            );
                                          }),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.w),
                                      child: Text(
                                        '20 more',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w400,
                                          color: white,
                                          fontSize: ScreenUtil().setSp(12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
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
            ),
          );
        },
      ),
    );
  }

  void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.all(1.r),
              child: Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Container(
                    height: 300.h,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: EdgeInsets.only(right: 15.w),
                            child: Container(
                              height: 300.h,
                              width: MediaQuery.of(context).size.width - 100.w,
                              child: SvgPicture.asset(
                                "assets/icons/svg/icon.svg",
                              ),
                            ),
                          );
                        })),
              ));
        });
  }
}
