import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/my_followers_model.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/otherUserProfile/OthersProfile.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FollowingInfoScreen extends StatefulWidget {
  const FollowingInfoScreen({Key? key}) : super(key: key);

  @override
  _FollowingInfoScreenState createState() => _FollowingInfoScreenState();
}

class _FollowingInfoScreenState extends State<FollowingInfoScreen> {
  final ApiProvider _api = ApiProvider();

  List myFollowingResult = [];

  int followingPage = 1;
  ScrollController followingScrollController = ScrollController();

  @override
  void initState() {
    followingScrollController.addListener(() {
      if (followingScrollController.position.maxScrollExtent ==
          followingScrollController.position.pixels) {
        followingPage++;
        _following();
      }
    });
    _following();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //floatingActionButton: CustomFab(),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        //backwardsCompatibility: true,
        iconTheme: IconThemeData(color: black),
        toolbarHeight: ScreenUtil().setHeight(61),
        title: Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(
              text: "Following",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w400,
                  color: black,
                  fontSize: ScreenUtil().setSp(16))),
        ])),
        backgroundColor: appBackgroundColor,
        elevation: 0,
      ),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      child: myFollowingResult.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              controller: followingScrollController,
              itemCount: myFollowingResult.length,
              itemBuilder: (followersContext, index) {
                return Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OtherProfile(
                                        id: myFollowingResult[index].id,
                                        selectPhase: 0,
                                      )));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             ChattingScreen(
                          //                 myFollowingResult[index].name,
                          //                 myFollowingResult[index]
                          //                     .profileImage,
                          //                 myFollowingResult[index].id,
                          //                 myFollowingResult[index].type,
                          //                 myFollowingResult[index].id,
                          //                 false)));
                        },
                        child: myFollowingResult[index].profileImage != null
                            ? CircleAvatar(
                                backgroundColor: lightGray,
                                radius: ScreenUtil().radius(22),
                                backgroundImage: NetworkImage(
                                    "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${myFollowingResult[index].profileImage}"),
                              )
                            : CircleAvatar(
                                backgroundColor: lightGray,
                                radius: ScreenUtil().radius(22),
                              ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             ChattingScreen(
                            //                 myFollowingResult[index].name,
                            //                 myFollowingResult[index]
                            //                     .profileImage,
                            //                 myFollowingResult[index].id,
                            //                 myFollowingResult[index].type,
                            //                 myFollowingResult[index].chatId,
                            //                 false)));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OtherProfile(
                                          id: myFollowingResult[index].id,
                                          selectPhase: 0,
                                        )));
                          },
                          child: Column(
                            children: [
                              Text('${myFollowingResult[index].name}',
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      color: black,
                                      fontSize: ScreenUtil().setSp(14))),
                              Text(
                                  myFollowingResult[index].district != null
                                      ? '${myFollowingResult[index].district}, ${myFollowingResult[index].country}'
                                      : "",
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w300,
                                      color: lightGray,
                                      fontSize: ScreenUtil().setSp(12))),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })
          : Center(
              child: Text("No Following Found",
                  style: GoogleFonts.nunitoSans(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ),
    );
  }

  void _following() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("id").toString();
    Map<String, dynamic> param = {
      "page": followingPage.toString(),
    };
    Api.get.call(context, method: "users/${id}/followees", param: param,
        onResponseSuccess: (Map object) {
      var result = MyFollowersResponse.fromJson(object);
      if (result.result!.length > 0) {
        myFollowingResult.addAll(result.result!);
        setState(() {});
        print('RESPONSE ${result.result.toString()}');
      } else {
        followingPage--;
      }
    });
  }

// void _notification() async {
//   bool internet = await Constants.isInternetAvailable();
//   if (internet) {
//     Constants.progressDialog(true, context);
//     var result = await _api.getnotificationService();
//     if (result != null) {
//       Constants.progressDialog(false, context);
//       if (result.success.toString() == "true") {
//         myNotificationResult = result.result;
//         setState(() {});
//         print('RESPONSE ${result.result.toString()}');
//       } else
//         Constants.toastMessage(msg: result.message);
//     }
//   }
//
// }
}
