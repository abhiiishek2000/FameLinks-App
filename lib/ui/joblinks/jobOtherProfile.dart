import 'package:famelink/common/common_image.dart';
import 'package:famelink/common/common_routing.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/userUpdateResponse.dart';
import 'package:famelink/ui/FameChatScreen.dart';
import 'package:famelink/ui/joblinks/createJob.dart';
import 'package:famelink/ui/joblinks/jobLinkNameField.dart';
import 'package:famelink/ui/joblinks/jobLinksWidget.dart';
import 'package:famelink/ui/otherUserProfile/OthersProfile.dart';
import 'package:famelink/ui/otherUserProfile/model/OtherUserProfileFunLinksModel.dart';
import 'package:famelink/ui/upload/followlink_upload.dart';
import 'package:famelink/ui/upload/funlink_upload_one.dart';
import 'package:famelink/ui/upload/upload_screen_one.dart';
import 'package:famelink/util/ReadMoreText.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobOtherProfile extends StatefulWidget {
  @override
  State<JobOtherProfile> createState() => _JobOtherProfileState();
}

class _JobOtherProfileState extends State<JobOtherProfile> {
  TextEditingController fameCoinController = TextEditingController();
  int index = 3;
  int indx = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.25),
        elevation: 2,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Spacer(),
            // selectPhase == 0 &&
            //         profileFameLinksList != null &&
            //         profileFameLinksList.length != 0
            //     ? Text(
            //         "@${profileFameLinksList[0].masterUser.username}",
            //         style: GoogleFonts.nunitoSans(
            //             fontSize: 14,
            //             fontStyle: FontStyle.italic,
            //             color: Colors.white),
            //       )
            //     : selectPhase == 1 &&
            //             profileFunLinksList != null &&
            //             profileFunLinksList.length != 0
            //         ? Text(
            //             "@${profileFunLinksList[0].masterUser.username}",
            //             style: GoogleFonts.nunitoSans(
            //                 fontSize: 14,
            //                 fontStyle: FontStyle.italic,
            //                 color: Colors.white),
            //           )
            //         : selectPhase == 2 &&
            //                 profileFollowLinksList != null &&
            //                 profileFollowLinksList.length != 0
            //             ? Text(
            //                 "@${profileFollowLinksList[0].masterUser.username}",
            //                 style: GoogleFonts.nunitoSans(
            //                     fontSize: 14,
            //                     fontStyle: FontStyle.italic,
            //                     color: Colors.white),
            //               )
            //             :
            Text(
              "@pet_baby",
              style: GoogleFonts.nunitoSans(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
            ),
            Spacer(),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FameChatScreen()));
                },
                child: Image.asset(
                  'assets/icons/sendmessage.png',
                  height: 20,
                  width: 23,
                )),
            Spacer(),
            InkWell(
              onTap: () {
                setState(() {
                  if (index == 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UploadScreenOne()));
                  } else if (index == 1) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FunLinkUploadScreenOne()));
                  } else if (index == 2) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FollowLinkUploadScreen()));
                  } else if (index == 3) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CreateJob()));
                  }
                });
              },
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.white)),
                child: Image.asset("assets/icons/plusIcon.png"),
              ),
            )
          ],
        ),
        leading: InkWell(
          onTap: () => gotoFameLinksFeedScreen(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(CommonImage.dart_back_img),
            alignment: Alignment.center,
            fit: BoxFit.fill,
          ),
        ),
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: Expanded(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  JobsLinksWidget(i: 5),
                  Padding(
                    padding:
                    EdgeInsets.only(left: 20.w, right: 20.w, top: 16.h),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IntrinsicWidth(
                              child: Column(
                                children: [
                                  Text("Writer, Director: ",
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                      )),
                                  SizedBox(height: 2.h),
                                  Container(
                                    height: 1.h,
                                    color: Color(0xffFF5C28),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 5.w),
                            IntrinsicWidth(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child:
                                    Text("FameLinks Ambassador - Haryana",
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                          color: Colors.white,
                                        )),
                                  ),
                                  SizedBox(height: 2.5.h),
                                  Container(
                                    height: 1.h,
                                    color: Color(0xff0060FF),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3.h),
                        ReadMoreText(

                          'Amet nam etiam elit vestibulum sed lacus, fermentum sed fk d commodo etc Lorem ipsum dolor sit am, Amet nam etiam elit vestibulum sed lacus, fermentum sed fk d commodo etc Lorem ipsum dolor sit am',
                          trimLines: 2,
                          trimMode: TrimMode.Line,
                          trimExpandedText: '...less',
                          trimCollapsedText: '...more',
                          colorClickableText: white,
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(left: 10.w, right: 10.w, top: 16.h),
                    child: Container(
                      width: ScreenUtil().screenWidth,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(CommonImage.bottom_shape_container),
                          fit: BoxFit.fill,
                        ),
                      ),
                      padding: EdgeInsets.only(
                          top: 5.h, left: 3.w, right: 8.w, bottom: 8.h),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(children: [
                                SizedBox(width: 8.w),
                                Image.asset(
                                  "assets/icons/two.png",
                                  height: 30.h,
                                  width: 30.h,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Sejal Shailesh Patel',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: black,
                                  ),
                                ),
                              ]),
                              InkWell(
                                onTap: () {},
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(children: [
                                  SizedBox(
                                    width: ScreenUtil().screenWidth * 0.50.w,
                                    child: Text(
                                      "Ujjain, Madhya Pradesh, India",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '10',
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  SizedBox(
                                    height: 15.68.h,
                                    width: 21.33.w,
                                    child: Image.asset(
                                      CommonImage.funLinksStoreHosportIcon,
                                      height: 15.68.h,
                                      width: 21.33.w,
                                      fit: BoxFit.fill,
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
                                    '200k',
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
                  ),
                  // Name Field
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 50.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15, left: 62),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: InkWell(
                                      onTap: () {
                                        showReferralCodeDialog();
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/svg/gift.svg",
                                            width: 30,
                                            height: 30,
                                            color: Colors.white,
                                          ),
                                          SizedBox(height: 6),
                                          Text('Send Gift',
                                              style: TextStyle(
                                                  color: Colors.white))
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 50),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: InkWell(
                                      onTap: () async {
                                        SharedPreferences prefs =
                                        await SharedPreferences
                                            .getInstance();
                                        String? id = prefs.getString("id");
                                        //if(profileFameLinksList[0].profileImage == "image"){
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) => ChattingScreen(
                                        //             profileFameLinksList[0].name,
                                        //             "${profileFameLinksList[0].profileImage}",
                                        //             profileFameLinksList[0].masterUser.sId,
                                        //             "individual",
                                        //             profileFameLinksList[0].chatId,
                                        //             false)));
                                        // }
                                        // else{
                                        //   Navigator.push(
                                        //       context,
                                        //       MaterialPageRoute(
                                        //           builder: (context) => ChattingScreen(
                                        //               profileFameLinksList[
                                        //               0].name,
                                        //           "${ApiProvider.avtarBaseURL}/${profileFameLinksList[0].profileImage}",
                                        //               profileFameLinksList[
                                        //               0]
                                        //                   .masterUser
                                        //                   .sId,
                                        //               "individual",
                                        //               profileFameLinksList[
                                        //               0]
                                        //                   .chatId,
                                        //               false)));
                                        // }
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/svg/send.svg",
                                            width: 30,
                                            height: 30,
                                            color: Colors.white,
                                          ),
                                          SizedBox(height: 6),
                                          Text('Message',
                                              style: TextStyle(
                                                  color: Colors.white))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Stack(
                                clipBehavior: Clip.none,
                                fit: StackFit.loose,
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Positioned(
                                    right: -30.w,
                                    child: SizedBox(
                                      height: 185.h,
                                      width: 185.w,
                                      child: Image.asset(
                                        "assets/images/commonOuterCircle.png",
                                      ),
                                    ),
                                  ),
                                  Container(
                                      height: 180.h,
                                      width: 120.w,
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 25.w),
                                          child: Image.asset(
                                            "assets/images/commonInnerCircle.png",
                                            height: 120.h,
                                            width: 120.w,
                                          )
                                        // : Container(
                                        //     width:
                                        //         100,
                                        //     height:
                                        //         100,
                                        //     decoration:
                                        //         BoxDecoration(
                                        //       shape: BoxShape
                                        //           .circle,
                                        //       image: DecorationImage(
                                        //           image:
                                        //           profileFameLinksList[0].profileImageType=="image"?
                                        //           NetworkImage("${ApiProvider.imageBaseUrl}/${profileFameLinksList[0].profileImage}")
                                        //               :NetworkImage("${ApiProvider.avtarBaseURL}/${profileFameLinksList[0].profileImage}"),
                                        //           fit: BoxFit.fill),
                                        //     ),
                                        //   ),
                                      )

                                    // select Image From Avatar
                                    // Padding(
                                    //   padding: const EdgeInsets
                                    //       .only(
                                    //       left: 25,
                                    //       top:
                                    //       10.0),
                                    //   child: Stack(
                                    //     children: <
                                    //         Widget>[
                                    //       // Image
                                    //       //     .asset(
                                    //       //   (isDarkMode !=
                                    //       //       true)
                                    //       //       ? CommonImage.dark_inner_circle_icon
                                    //       //       : "assets/images/commonInnerCircle.png",
                                    //       // ),
                                    //       // (HomeDialState.selectAvatarStatus.toString() ==
                                    //       //     "localAvatar")
                                    //       //     ? CircleAvatar(
                                    //       //   backgroundImage: NetworkImage(
                                    //       //     "${ApiProvider.avtarBaseURL}/${HomeDialState.selectAvatar.toString()}",
                                    //       //   ),
                                    //       //   backgroundColor: Colors.transparent,
                                    //       //   radius: 50,
                                    //       // )
                                    //       //     : CircleAvatar(
                                    //       //   backgroundImage: NetworkImage(
                                    //       //     "${ApiProvider.imageBaseUrl}/${HomeDialState.selectAvatar.toString()}",
                                    //       //   ),
                                    //       //   backgroundColor: Colors.transparent,
                                    //       //   radius: 50,
                                    //       // )
                                    //     ],
                                    //   ),
                                    // ),
                                  ),
                                  Positioned(
                                    right: 50.w,
                                    bottom: 160.h,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          index = 0;
                                          print(
                                              "===============================");
                                        });
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          index != 0
                                              ? Container()
                                              : Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  CommonImage
                                                      .secondBundleIcon,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 6.w,
                                                  right: 6.w,
                                                  top: 2.h,
                                                  bottom: 2.h),
                                              child: Text(
                                                "FameLinks",
                                                style: GoogleFonts
                                                    .nunitoSans(
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  fontStyle:
                                                  FontStyle.normal,
                                                  color:
                                                  HexColor("#030C23"),
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 3.w),
                                          circleButtonImageStack(
                                            imgUrl:
                                            "assets/icons/darkFamelinkIcon.png",
                                            isButtonSelect:
                                            index == 0 ? true : false,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 100.w,
                                    bottom: 110.h,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          getOtherUserProfileFunLinks();
                                          index = 1;
                                        });
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          index != 1
                                              ? Container()
                                              : Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  CommonImage
                                                      .secondBundleIcon,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 6.w,
                                                  right: 6.w,
                                                  top: 2.h,
                                                  bottom: 2.h),
                                              child: Text(
                                                "FunLinks",
                                                style: GoogleFonts
                                                    .nunitoSans(
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  fontStyle:
                                                  FontStyle.normal,
                                                  color:
                                                  HexColor("#030C23"),
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 3.w),
                                          circleButtonImageStack(
                                            imgUrl:
                                            CommonImage.dark_videoLink_icon,
                                            isButtonSelect:
                                            index == 1 ? true : false,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 100.w,
                                    bottom: 40.h,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          index = 2;
                                        });
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          index != 2
                                              ? Container()
                                              : Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  CommonImage
                                                      .secondBundleIcon,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 6.w,
                                                  right: 6.w,
                                                  top: 2.h,
                                                  bottom: 2.h),
                                              child: Text(
                                                "FollowLinks",
                                                style: GoogleFonts
                                                    .nunitoSans(
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  fontStyle:
                                                  FontStyle.normal,
                                                  color:
                                                  HexColor("#030C23"),
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 3.w),
                                          circleButtonImageStack(
                                            imgUrl:
                                            CommonImage.dark_follower_icon,
                                            isButtonSelect:
                                            index == 2 ? true : false,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 50.w,
                                    bottom: -10.h,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          index = 3;
                                        });
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          index != 3
                                              ? Container()
                                              : Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  CommonImage
                                                      .secondBundleIcon,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 6.w,
                                                  right: 6.w,
                                                  top: 2.h,
                                                  bottom: 2.h),
                                              child: Text(
                                                "JobLinks",
                                                style: GoogleFonts
                                                    .nunitoSans(
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  fontStyle:
                                                  FontStyle.normal,
                                                  color:
                                                  HexColor("#030C23"),
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 3.w),
                                          circleButtonImageStack(
                                            imgUrl:
                                            CommonImage.dark_jobLink_icon,
                                            isButtonSelect:
                                            index == 3 ? true : false,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.only(left: 49.w, right: 10.w),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Hi...',
                        maxLines: 6,
                        style: GoogleFonts.nunitoSans(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 116.h,
                          width: 110.w,
                          child: Stack(
                            children: [
                              Image.asset("assets/icons/rect.png"),
                              Positioned(
                                top: 5.5.h,
                                left: 3.w,
                                child: Image.asset(
                                  "assets/icons/girl.png",
                                  height: 100.h,
                                  width: 100.w,
                                ),
                              ),
                              Center(
                                child: Container(
                                  height: 40.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: white.withOpacity(0.5),
                                          width: 2.w)),
                                  child: Icon(Icons.play_arrow,
                                      color: white.withOpacity(0.5)),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Container(
                          width: MediaQuery.of(context).size.width - 150.w,
                          child: Text(
                            'Hi...,\nThank you so much for visiting me out. Hope my profile would be suitable for your project requirement. Drop me a message and I Shall revert soon. Hope to work with you. -Sejal',
                            maxLines: 6,
                            style: GoogleFonts.nunitoSans(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  JobLinkNameField(i: 5)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget circleButtonImageStack({
    String? imgUrl,
    bool isButtonSelect = false,
  }) =>
      Container(
        width: 30.w,
        height: 30.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle, color: darkGray.withOpacity(0.8),
          border: Border.all(
              color: isButtonSelect == false
                  ? white.withOpacity(0.7)
                  : Color.fromARGB(255, 218, 127, 96)),
          // image: DecorationImage(
          //   image: (isButtonSelect == true)
          //       ? AssetImage((isButtonSelect == true)
          //       ? CommonImage.selected_circle_back
          //       : CommonImage.unSelected_circle_back)
          //       : AssetImage(
          //     (isDartMode == true)
          //         ? CommonImage.dark_circle_avatar_back
          //         : CommonImage.light_circle_avatar_back,
          //   ),
          //   fit: BoxFit.fill,
          // ),
        ),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Image.asset(
            imgUrl.toString(),
            width: 16,
            height: 16,
            fit: BoxFit.fill,
          ),
        ),
      );

  Future<List<OtherUserProfileFunLinksModel>?>
  getOtherUserProfileFunLinks() async {
    // var result = await _api.getFameLinkOtherAPIFunLinks(widget.id);
    // if (result != null) {
    //   setState(() {
    //     if (result.success) {
    //       otherUserProfileFunLinksModel.addAll(result.result);
    //       selectPhase = 1;
    //       return otherUserProfileFunLinksModel;
    //     } else {
    //       Constants.toastMessage(msg: result.message);
    //       return otherUserProfileFunLinksModel;
    //     }
    //   });
    // }
  }

  void showReferralCodeDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(
                      (ScreenUtil().screenWidth - ScreenUtil().setSp(315)) / 2),
                  right: ScreenUtil().setWidth(
                      (ScreenUtil().screenWidth - ScreenUtil().setSp(315)) /
                          2)),
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setStates) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setSp(16))),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              color: black25,
                              blurRadius: 4.0,
                            ),
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft:
                                    Radius.circular(ScreenUtil().setSp(16)),
                                    topRight:
                                    Radius.circular(ScreenUtil().setSp(16))),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [lightRedWhite, lightRed])),
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(21),
                                bottom: ScreenUtil().setHeight(12),
                                left: ScreenUtil().setWidth(5),
                                right: ScreenUtil().setWidth(5)),
                            child: Center(
                              child: Text(
                                'Send Gift type to your beloved person',
                                style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(16),
                                    color: white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft:
                                  Radius.circular(ScreenUtil().setSp(16)),
                                  bottomRight:
                                  Radius.circular(ScreenUtil().setSp(16))),
                              color: appBackgroundColor,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(14),
                                      left: ScreenUtil().setWidth(20),
                                      right: ScreenUtil().setWidth(20)),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Fame Coins: ',
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize:
                                                    ScreenUtil().setSp(12),
                                                    color: black,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                              Text(
                                                '${Constants.fameCoins} Coins Left',
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize:
                                                    ScreenUtil().setSp(12),
                                                    color: black,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '(Max 5 Coins per person per day allowed)',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: ScreenUtil().setSp(10),
                                                color: lightGray,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setSp(5),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          textAlign: TextAlign.start,
                                          textAlignVertical:
                                          TextAlignVertical.center,
                                          controller: fameCoinController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.digitsOnly
                                          ],
                                          textInputAction: TextInputAction.done,
                                          style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(12),
                                              color: darkGray,
                                              fontWeight: FontWeight.w400),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: buttonBlue,
                                                  width: ScreenUtil().radius(1)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      ScreenUtil().radius(2))),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: buttonBlue,
                                                  width: ScreenUtil().radius(1)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      ScreenUtil().radius(2))),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: buttonBlue,
                                                  width: ScreenUtil().radius(1)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      ScreenUtil().radius(2))),
                                            ),
                                            contentPadding: EdgeInsets.only(
                                                left: ScreenUtil().setWidth(5),
                                                top: 0,
                                                bottom: 0),
                                            hintStyle: GoogleFonts.nunitoSans(
                                                fontStyle: FontStyle.italic,
                                                fontSize: ScreenUtil().setSp(12),
                                                color: lightGray,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setSp(32),
                                      bottom: ScreenUtil().setSp(20)),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Center(
                                                child: InkWell(
                                                  onTap: () async {
                                                    // Navigator.pop(context);
                                                    // if (fameCoinController
                                                    //     .text.isNotEmpty) {
                                                    //   if (Constants.fameCoins >=
                                                    //       int.parse(
                                                    //           fameCoinController.text)) {
                                                    //     Map<String, dynamic> params = {
                                                    //       "fameCoins":
                                                    //           fameCoinController.text,
                                                    //       "toUserId": widget.id
                                                    //     };
                                                    //     Api.post.call(context,
                                                    //         method: "users/fameCoins",
                                                    //         param: params,
                                                    //         isLoading: false,
                                                    //         onResponseSuccess:
                                                    //             (Map object) {
                                                    //       var result =
                                                    //           UserUpdatedResponse.fromJson(
                                                    //               object);
                                                    //       Constants.toastMessage(
                                                    //           msg: result.message);

                                                    //       Constants.fameCoins = Constants
                                                    //               .fameCoins -
                                                    //           int.parse(
                                                    //               fameCoinController.text);
                                                    //       fameCoinController.text = "";
                                                    //     });
                                                    //   } else {
                                                    //     var snackBar = SnackBar(
                                                    //       content: Text(
                                                    //           'only for ${Constants.fameCoins} coins left'),
                                                    //     );
                                                    //     ScaffoldMessenger.of(context)
                                                    //         .showSnackBar(snackBar);
                                                    //   }
                                                    // }
                                                  },
                                                  child: Text("Send",
                                                      style: GoogleFonts.nunitoSans(
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: ScreenUtil().setSp(14),
                                                          color: black)),
                                                ))),
                                        Expanded(
                                            child: Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Cancel",
                                                      style: GoogleFonts.nunitoSans(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: ScreenUtil().setSp(14),
                                                          color: black)),
                                                ))),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }));
        });
  }
}
