import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/profile/NotificationPostScreen.dart';
import 'package:famelink/ui/profile/agency_other_profile_screen.dart';
import 'package:famelink/ui/profile/agency_profile_screen.dart';
import 'package:famelink/ui/profile/brand_other_profile_screen.dart';
import 'package:famelink/ui/profile/brand_profile_screen.dart';
import 'package:famelink/ui/profile/other_profile_screen.dart';
import 'package:famelink/ui/profile/profile_screen.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/message.dart';

class MessagesItem extends StatelessWidget {
  final String profileImage;
  final Message _message;

  final bool isUserMassage;

  const MessagesItem(this.profileImage, this._message, this.isUserMassage);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(12), right: ScreenUtil().setWidth(18)),
      child: Column(
        children: <Widget>[
          Visibility(child: Text(_message.timeStamp != null ? _message.timeStamp!:"",style: GoogleFonts.nunitoSans(color: lightGray)),visible: _message.isHeader!),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            textDirection:
                isUserMassage ? TextDirection.rtl : TextDirection.ltr,
            children: <Widget>[
              isUserMassage
                  ? SizedBox()
                  : Card(
                      elevation: 2,
                      color: isUserMassage ? lightGray : appBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(ScreenUtil().radius(20)),
                        ),
                      ),
                      child: profileImage != null
                          ? CircleAvatar(
                        backgroundColor: buttonBlue.withOpacity(0.7),
                              radius: ScreenUtil().radius(20),
                              backgroundImage: NetworkImage(
                                  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${profileImage}"),
                            )
                          : CircleAvatar(
                          backgroundColor: buttonBlue.withOpacity(0.7),
                              radius: ScreenUtil().radius(20),
                              child: Text(
                                _message.senderName!
                                    .substring(0, 1)
                                    .toUpperCase(),
                                style: GoogleFonts.nunitoSans(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            )),
              Column(
                crossAxisAlignment: isUserMassage
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * .75,
                    child: Align(
                      alignment: isUserMassage
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(ScreenUtil().radius(8)),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [isUserMassage ? lightRedWhite.withOpacity(0.1):lightGray.withOpacity(0.1),isUserMassage ? lightRed.withOpacity(0.1) : lightGray.withOpacity(0.1)]),
                            borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().radius(8)),
                            ),
                          ),
                          padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(7),
                              right: ScreenUtil().setWidth(7),
                              top: ScreenUtil().setHeight(4),
                              bottom: ScreenUtil().setHeight(4)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              InkWell(
                                onTap: ()async{
                                  if(_message.content!.contains("https://userapi.budlinks.in/")){
                                    if (_message.content!.contains("/post/famelinks/")) {
                                      List<String> array = _message.content!.split("/");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ontext) =>
                                                NotificationPostScreen(
                                                    array.elementAt(array.length - 1), "famelinks", "")),
                                      );
                                    } else if (_message.content!.contains("/post/funlinks/")) {
                                      List<String> array = _message.content!.split("/");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ontext) =>
                                                NotificationPostScreen(
                                                    array.elementAt(array.length - 1), "funlinks", "")),
                                      );
                                    } else if (_message.content!.contains("/post/followlinks/")) {
                                      List<String> array = _message.content!.split("/");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ontext) =>
                                                NotificationPostScreen(
                                                    array.elementAt(array.length - 1), "followlinks", "")),
                                      );
                                    }else {
                                      List<String> array = _message.content!.split("/");
                                      var sharedPreferences = await SharedPreferences.getInstance();
                                      Constants.token = sharedPreferences.getString("token");
                                      Constants.profileUserId = array.elementAt(array.length - 1);
                                      String userType = array.elementAt(array.length - 2);
                                      if (sharedPreferences.getString("id") == Constants.profileUserId) {
                                        if (userType == "individual") {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => ProfileScreen()));
                                        } else if (userType == "agency") {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => AgencyProfileScreen()));
                                        } else if (userType == "brand") {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => BrandProfileScreen()));
                                        }
                                      } else {
                                        if (userType == "individual") {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => OtherProfileScreen()));
                                        } else if (userType == "agency") {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => AgencyOtherProfileScreen()));
                                        } else if (userType == "brand") {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => BrandOtherProfileScreen()));
                                        }
                                      }
                                    }
                                  }
                                },
                                child: Text(
                                  _message.content!,
                                  style: GoogleFonts.nunitoSans(
                                    color: _message.content!.contains("https://userapi.budlinks.in/")?buttonBlue:Colors.black,
                                    fontSize: ScreenUtil().setSp(12),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
        ],
      ),
    );
  }
}
