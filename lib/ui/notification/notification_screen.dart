import 'package:famelink/networking/config.dart';
import 'package:famelink/providers/NotificationProvider/famelink_notification_provider.dart';
import 'package:famelink/ui/followers/follower_info_screen.dart';
import 'package:famelink/ui/otherUserProfile/OthersProfile.dart';
import 'package:famelink/ui/profile/NotificationPostScreen.dart';
import 'package:famelink/ui/profile/agency_other_profile_screen.dart';
import 'package:famelink/ui/profile/agency_profile_screen.dart';
import 'package:famelink/ui/profile/brand_other_profile_screen.dart';
import 'package:famelink/ui/profile/brand_profile_screen.dart';
import 'package:famelink/ui/profile/other_profile_screen.dart';
import 'package:famelink/ui/profile/profile_screen.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../util/time_convert.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with TickerProviderStateMixin {

 final ScrollController controller = ScrollController();


  @override
  void initState() {
    Provider.of<GetNotificationProvider>(context,listen: false).getNotifications(context);
    controller.addListener(() {
      if(controller.position.maxScrollExtent ==
          controller.offset){
        Provider.of<GetNotificationProvider>(context,listen: false).getNotifications(context,isPaginate:true);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text('Notifications', style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w700, color: lightRed, fontSize: ScreenUtil().setSp(24))),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: body(),
    );
  }

  Widget body() {
    return  Consumer<GetNotificationProvider>(builder: (context, dataNotification, child) {
      return SafeArea(
        child: Container(
          color: appBackgroundColor,
          // padding: EdgeInsets.only(top: ScreenUtil().setSp(82)),
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async{
                    Provider.of<GetNotificationProvider>(context,listen: false).getNotifications(context);
                  },
                  child: ListView.builder(
                      controller: controller,
                      scrollDirection: Axis.vertical,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: dataNotification.getMyNotificationResult.length,
                      padding: EdgeInsets.only(left: ScreenUtil().setSp(25), right: ScreenUtil().setSp(37)),
                      itemBuilder: (listContext, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              child: Padding(
                                padding: EdgeInsets.only(top: ScreenUtil().setSp(12), bottom: ScreenUtil().setSp(7)),
                                child: Text(dataNotification.getMyNotificationResult[index].durationTime != null ? dataNotification.getMyNotificationResult[index].durationTime! : "",
                                    style: GoogleFonts.nunitoSans(fontSize: ScreenUtil().setSp(12), fontWeight: FontWeight.w400, color: lightGray)),
                              ),
                              visible: dataNotification.getMyNotificationResult[index].durationTime != null,
                            ),
                            InkWell(
                              onTap: () {
                                Constants.profileUserId = dataNotification.getMyNotificationResult[index].targetId;
                                if (dataNotification.getMyNotificationResult[index].type == "followUser") {
                                  if (Constants.userId == Constants.profileUserId) {
                                    if (dataNotification.getMyNotificationResult[index].sourceType == "individual") {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                                    } else if (dataNotification.getMyNotificationResult[index].sourceType == "agency") {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => AgencyProfileScreen()));
                                    } else if (dataNotification.getMyNotificationResult[index].sourceType == "brand") {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => BrandProfileScreen()));
                                    }
                                  } else {
                                    if (dataNotification.getMyNotificationResult[index].sourceType == "individual") {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => OtherProfileScreen()));
                                    } else if (dataNotification.getMyNotificationResult[index].sourceType == "agency") {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => AgencyOtherProfileScreen()));
                                    } else if (dataNotification.getMyNotificationResult[index].sourceType == "brand") {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => BrandOtherProfileScreen()));
                                    }
                                  }
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: ScreenUtil().setSp(12)),
                                child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                  InkWell(
                                    onTap: () {

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => OtherProfile(
                                                id: dataNotification.getMyNotificationResult[index].sourceId!,
                                                selectPhase: 0,
                                              )));
                                    },
                                    child: dataNotification.getMyNotificationResult[index].sourceMedia != null
                                        ? CircleAvatar(
                                      radius: ScreenUtil().radius(15),
                                      backgroundImage:
                                      NetworkImage("${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${dataNotification.getMyNotificationResult[index].sourceMedia}"),
                                    )
                                        : CircleAvatar(
                                      radius: ScreenUtil().radius(15),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setSp(6),
                                  ),
                                  Expanded(
                                      child: Column(
                                        children: [
                                          Text.rich(TextSpan(children: <TextSpan>[
                                            TextSpan(
                                                recognizer: new TapGestureRecognizer()
                                                  ..onTap = () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => OtherProfile(
                                                              id: dataNotification.getMyNotificationResult[index].sourceId!,
                                                              selectPhase: 0,
                                                            )));
                                                  },
                                                text: dataNotification.getMyNotificationResult[index].source!.contains("&")
                                                    ? dataNotification.getMyNotificationResult[index].source!.split("&")[0]
                                                    : dataNotification.getMyNotificationResult[index].source,
                                                style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w700, color: black, fontSize: ScreenUtil().setSp(12))),
                                            TextSpan(
                                                recognizer: new TapGestureRecognizer()
                                                  ..onTap = () {
                                                    Constants.profileUserId = dataNotification.getMyNotificationResult[index].sourceId;
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                FollowerInfoScreen(isFollowing: false, id: dataNotification.getMyNotificationResult[index].sourceId)));
                                                  },
                                                text: dataNotification.getMyNotificationResult[index].source!.contains("&")
                                                    ? ' & ${dataNotification.getMyNotificationResult[index].source!.split("&")[1]}'
                                                    : "",
                                                style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w700, color: black, fontSize: ScreenUtil().setSp(12))),
                                            TextSpan(
                                                text: dataNotification.getMyNotificationResult[index].action != null ? ' ${dataNotification.getMyNotificationResult[index].action}' : "",
                                                style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w400, fontSize: ScreenUtil().setSp(12), color: black)),
                                            TextSpan(
                                                text: dataNotification.getMyNotificationResult[index].data != null ? ' ${dataNotification.getMyNotificationResult[index].data}' : "",
                                                style:
                                                GoogleFonts.nunitoSans(fontWeight: FontWeight.w700, fontSize: ScreenUtil().setSp(12), color: buttonBlue)),
                                            TextSpan(
                                                text: dataNotification.getMyNotificationResult[index].body != null ? ' ${dataNotification.getMyNotificationResult[index].body}' : "",
                                                style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w400, fontSize: ScreenUtil().setSp(12), color: black))
                                          ])),
                                          Text(convertToAgo(DateTime.parse(dataNotification.getMyNotificationResult[index].updatedAt!)),
                                            style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w400, color: darkGray, fontSize: ScreenUtil().setSp(10)),
                                          )
                                        ],
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                      )),
                                  SizedBox(
                                    width: ScreenUtil().setSp(6),
                                  ),
                                  dataNotification.getMyNotificationResult[index].targetMedia != null
                                      ? InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NotificationPostScreen(dataNotification.getMyNotificationResult[index].targetId!,
                                                dataNotification.getMyNotificationResult[index].postType!, dataNotification.getMyNotificationResult[index].type!)),
                                      );
                                    },
                                    child: Container(
                                      child: Image.network(
                                        '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${dataNotification.getMyNotificationResult[index].targetMedia}-xs',
                                        fit: BoxFit.cover,
                                      ),
                                      height: ScreenUtil().radius(35),
                                      width: ScreenUtil().radius(35),
                                    ),
                                  )
                                      : Container()
                                ]),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      );
    });

  }
  
}
