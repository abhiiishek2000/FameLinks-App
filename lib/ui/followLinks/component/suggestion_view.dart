import 'package:dio/dio.dart';
import 'package:famelink/ui/followLinks/component/report_dialogs.dart';
import 'package:famelink/ui/followLinks/provider/FollowLinksFeedProvider.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../dio/api/api.dart';
import '../../../networking/config.dart';
import '../../../util/registerDialog.dart';
import '../../home_feed/view/main_feed_screen.dart';
import '../../otherUserProfile/OthersProfile.dart';
import '../../upload/followlink_upload.dart';

class SuggestionView extends StatefulWidget {
  SuggestionView({Key? key, required this.isRegistered}) : super(key: key);
  bool isRegistered;

  @override
  State<SuggestionView> createState() => _SuggestionViewState();
}

class _SuggestionViewState extends State<SuggestionView> {
  ScrollController suggestionsScrollController = ScrollController();

  @override
  void initState() {
    Provider.of<FollowLinksFeedProvider>(context, listen: false)
        .getSuggestions(isPaginate: false);
    suggestionsScrollController.addListener(() {
      if (suggestionsScrollController.position.maxScrollExtent ==
          suggestionsScrollController.position.pixels) {
        Provider.of<FollowLinksFeedProvider>(context, listen: false)
            .getSuggestions(isPaginate: true);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FollowLinksFeedProvider>(
        builder: (context, provider, child) {
      return Stack(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: provider.myInfoResponse != null &&
                            provider.myInfoResponse!.result!.referredBy == null,
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: ScreenUtil().setWidth(18)),
                          child: InkWell(
                            onTap: () {
                              showReferralCodeDialog(context);
                            },
                            child: Text(
                              "Referral\nCode",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: ScreenUtil().setSp(10),
                                  color: white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenUtil().setSp(20),
                            left: ScreenUtil().setSp(5)),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: white, width: ScreenUtil().setSp(1.5)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          height: ScreenUtil().setSp(30),
                          width: ScreenUtil().setSp(30),
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                // onClickPageImage = !onClickPageImage;
                                provider.changeOnPageTurning(true);
                                provider.changeOnPageHorizontalTurning(true);
                              });
                              if (widget.isRegistered == false) {
                                registerDialog(context);
                              } else {
                                provider.changeOnPageTurning(true);
                                provider.changeOnPageHorizontalTurning(true);

                                final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FollowLinkUploadScreen()));
                                if (result != null) {
                                  Map map = result;
                                  FormData formData = FormData.fromMap({
                                    "challenges": map['challenges'],
                                    "description": map['description'],
                                    "tags": map['tags'],
                                  });
                                  for (int i = 0; i < (map.length - 2); i++) {
                                    formData.files.addAll([
                                      MapEntry("media",
                                          await map['media${i.toString()}']),
                                    ]);
                                  }
                                  Api.uploadPost.call(context,
                                      method: "media/followlinks",
                                      param: formData,
                                      isLoading: false,
                                      onResponseSuccess: (Map object) {
                                    var snackBar = SnackBar(
                                      content: Text('Uploaded'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  });
                                }
                              }
                            },
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: lightRed,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setSp(20),
                    left: ScreenUtil().setSp(20),
                    right: ScreenUtil().setSp(20)),
                child: Text(
                  "You see those people's post whom you follow. Please follow someone to see their posts.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(color: white),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    controller: suggestionsScrollController,
                    itemCount: provider.mySuggestionsResult.length,
                    padding: EdgeInsets.only(bottom: ScreenUtil().setSp(100)),
                    itemBuilder: (followersContext, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setSp(20),
                            right: ScreenUtil().setSp(20),
                            top: ScreenUtil().setSp(15)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                Constants.profileUserId =
                                    provider.mySuggestionsResult[index].id;
                                setState(() {
                                  // onClickPageImage = !onClickPageImage;
                                  provider.changeOnPageHorizontalTurning(true);
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OtherProfile(
                                              id: provider
                                                  .mySuggestionsResult[index]
                                                  .id,
                                              selectPhase: 2,
                                            )));
                              },
                              child: provider.mySuggestionsResult[index]
                                          .profileImage !=
                                      null
                                  ? CircleAvatar(
                                      radius: ScreenUtil().radius(17),
                                      backgroundImage: NetworkImage(
                                          "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${provider.mySuggestionsResult[index].profileImage}"),
                                    )
                                  : CircleAvatar(
                                      radius: ScreenUtil().radius(17),
                                    ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Constants.profileUserId =
                                      provider.mySuggestionsResult[index].id;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OtherProfile(
                                                id: provider
                                                    .mySuggestionsResult[index]
                                                    .id,
                                                selectPhase: 2,
                                              )));
                                },
                                child: Column(
                                  children: [
                                    Text(
                                        '${provider.mySuggestionsResult[index].name}',
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(14),
                                            color: white)),
                                    Text(
                                        provider.mySuggestionsResult[index]
                                                    .district !=
                                                null
                                            ? '${provider.mySuggestionsResult[index].district}, ${provider.mySuggestionsResult[index].country}'
                                            : "",
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w300,
                                            fontSize: ScreenUtil().setSp(12),
                                            color: lightGray)),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              appBackgroundColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5),
                                                bottomLeft: Radius.circular(5),
                                                bottomRight: Radius.circular(5),
                                              ),
                                              side: BorderSide(
                                                  color: buttonBlue)))),
                                  onPressed: () async {
                                    var result = await ApiProvider()
                                        .getFoloowStatusAPI(provider
                                            .mySuggestionsResult[index].id!);
                                    if (result != null) {
                                      setState(() {
                                        provider.mySuggestionsResult[index]
                                                .suggestionfollowStatus =
                                            result["message"];
                                      });
                                    }
                                  },
                                  child: provider.mySuggestionsResult[index]
                                                  .suggestionfollowStatus !=
                                              "" &&
                                          provider.mySuggestionsResult[index]
                                                  .suggestionfollowStatus !=
                                              null
                                      ? Text(
                                          '${provider.mySuggestionsResult[index].suggestionfollowStatus}',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: ScreenUtil().setSp(12),
                                              color: buttonBlue),
                                        )
                                      : Text(
                                          'Follow',
                                          style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: ScreenUtil().setSp(12),
                                              color: buttonBlue),
                                        )),
                              height: ScreenUtil().setHeight(30),
                            ),
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
          Visibility(
            visible: provider.mySuggestionsResult.length > 1,
            child: Align(
                child: Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(25)),
                  width: ScreenUtil().setWidth(150),
                  height: ScreenUtil().setHeight(40),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    side: BorderSide(color: lightRed)))),
                    onPressed: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainFeedScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Done',
                          style: GoogleFonts.nunitoSans(
                              color: lightRed,
                              fontWeight: FontWeight.w700,
                              fontSize: ScreenUtil().setSp(22)),
                        ),
                      ],
                    ),
                  ),
                ),
                alignment: Alignment.bottomCenter),
          ),
        ],
      );
    });
  }
}
