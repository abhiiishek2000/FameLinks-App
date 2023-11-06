import 'package:famelink/common/common_image.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../share/firebasedynamiclink.dart';
import '../Famelinkprofile/function/famelinkFun.dart';
import 'component/drawer.dart';
import 'provder/OtherPofileprovider.dart';
import 'widget/PhaseOne.dart';
import 'widget/Phashethree.dart';
import 'widget/Phashetow.dart';
import 'widget/showReferralCodeDialog.dart';
import 'widgetwhitprofile/PhaseOne.dart';
import 'widgetwhitprofile/Phashethree.dart';
import 'widgetwhitprofile/Phashetow.dart';

class OtherProfile extends StatefulWidget {
  String? id;
  int? selectPhase;
  String? sayhi;

  OtherProfile({Key? key, this.id, this.selectPhase, this.sayhi})
      : super(key: key);

  @override
  _OtherProfileState createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile>
    with TickerProviderStateMixin {
  final GlobalKey _menuKey = GlobalKey();
  void onSelect(item) {
    switch (item) {
      case 'Home':
        print('Home clicked');
        break;
      case 'Profile':
        print('Profile clicked');
        break;
      case 'Setting':
        print('Setting clicked');
        break;
    }
  }

  OtherPofileprovider? otherPofileprovider;

  @override
  void initState() {
    // TODO: implement initState

    otherPofileprovider =
        Provider.of<OtherPofileprovider>(context, listen: false);
    otherPofileprovider!.isloading = false;
    Constants.playing = false;
    otherPofileprovider!.profile(context);
    otherPofileprovider!.selectPhase = widget.selectPhase;
    otherPofileprovider!.famePage = 0;

    otherPofileprovider!.getParticularUserProfileModel = null;
    otherPofileprovider!.getParticularUserProfileModelResultList.clear();
    otherPofileprovider!.videofameController.clear();
    otherPofileprovider!.funPage = 0;
    otherPofileprovider!.getParticularFunUserProfileModelResultList.clear();
    otherPofileprovider!.videoFunController.clear();

    otherPofileprovider!.followPage = 0;
    otherPofileprovider!.getParticularFollowUserProfileModelResultList.clear();
    otherPofileprovider!.videoFollowController.clear();
    otherPofileprovider!.getProfile(context, widget.id.toString());
    otherPofileprovider!.scrollController.addListener(() {
      if (otherPofileprovider!.scrollController.position.maxScrollExtent ==
          otherPofileprovider!.scrollController.offset) {
        //the bottom of the scrollbar is reached
        //adding more widgets
        // if (otherPofileprovider!.ispagination) {
        // print("function call $fai $fni $foi");
        if (otherPofileprovider!.selectPhase == 0) {
          if (otherPofileprovider!.isfame) {
            otherPofileprovider!.fai++;
            otherPofileprovider!.getOtherUserProfile(
                widget.id.toString(), otherPofileprovider!.fai);
          }
        } else if (otherPofileprovider!.selectPhase == 1) {
          if (otherPofileprovider!.isfun) {
            otherPofileprovider!.fni++;
            otherPofileprovider!.getOtherUserProfileFunLinks(
                widget.id.toString(), otherPofileprovider!.fni);
          }
        } else if (otherPofileprovider!.selectPhase == 2) {
          if (otherPofileprovider!.isfollow) {
            otherPofileprovider!.foi++;
            otherPofileprovider!.getOtherUserProfileFollowLinks(
                widget.id.toString(), otherPofileprovider!.foi);
          }
        }
        // }
        print(otherPofileprovider!.scrollController.position);
        //
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    otherPofileprovider!.alldataclear();

    print("alldata clear");
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Consumer2<OtherPofileprovider, FameLinkFun>(
      builder: (context, provider, fameLinkFun, child) {
        return WillPopScope(
          onWillPop: () async {
            print(fameLinkFun.isdrower);
            if (fameLinkFun.isdrower == true) {
            } else {
              Navigator.pop(context);
            }
            fameLinkFun.therprofiledrower(true);
            return fameLinkFun.isdrower;
          },
          child: provider!.isloading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: fameLinkFun.selfPrifilewhitemode
                        ? Colors.white
                        : Colors.black.withOpacity(0.25),
                    elevation: 2,
                    centerTitle: true,
                    title: Constants.userType == 'brand'
                        ? Text(
                            provider!.myStoreResult.length == 0
                                ? ""
                                : "@${otherPofileprovider!.myStoreResult[0].user![0].username ?? '---'}",
                            style: GoogleFonts.nunitoSans(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: fameLinkFun.selfPrifilewhitemode
                                    ? Colors.black
                                    : Colors.white),
                          )
                        : provider!.profileFameLinksList.length != 0
                            ? Text(
                                "${otherPofileprovider!.profileFameLinksList[0].masterUser!.username ?? "---"}",
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    color: fameLinkFun.selfPrifilewhitemode
                                        ? Colors.black
                                        : Colors.white),
                              )
                            : provider!.otherUserProfileFunLinksModel.length !=
                                    0
                                ? Text(
                                    "${provider!.otherUserProfileFunLinksModel[0].masterUser!.username ?? '----'}",
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                        color: fameLinkFun.selfPrifilewhitemode
                                            ? Colors.black
                                            : Colors.white),
                                  )
                                : provider!.otherUserProfileFollowLinksModelResult
                                            .length !=
                                        0
                                    ? Text(
                                        "${provider!.otherUserProfileFollowLinksModelResult[0].masterUser!.username ?? '----'}",
                                        style: GoogleFonts.nunitoSans(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic,
                                            color:
                                                fameLinkFun.selfPrifilewhitemode
                                                    ? Colors.black
                                                    : Colors.white),
                                      )
                                    : Text("Username"),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                String? name;
                                if (widget.selectPhase == 0) {
                                  name = "otherprofilefame";
                                } else if (widget.selectPhase == 1) {
                                  name = "otherprofilefun";
                                } else {
                                  name = "otherprofilefollow";
                                }
                                Sharedynamic.shareprofile(
                                    widget.id.toString(),
                                    name,
                                    provider!.otherUserProfileFunLinksModel[0]
                                        .masterUser!.username
                                        .toString());
                              },
                              child: Image.asset(
                                "assets/images/share.png",
                                height: 22,
                                width: 22,
                                color: fameLinkFun.selfPrifilewhitemode
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                    leading: InkWell(
                      onTap: () {
                        if (fameLinkFun.isdrower == true) {
                          fameLinkFun.therprofiledrower(true);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  body: RefreshIndicator(
                    onRefresh: () async {
                      otherPofileprovider!.alldataclear();
                      if (otherPofileprovider!.selectPhase == 0) {
                        return otherPofileprovider!
                            .getOtherUserProfile(widget.id.toString(), 1);
                      } else if (otherPofileprovider!.selectPhase == 1) {
                        otherPofileprovider!.getOtherUserProfileFunLinks(
                            widget.id.toString(), 1);
                      } else if (otherPofileprovider!.selectPhase == 2) {
                        otherPofileprovider!.getOtherUserProfileFollowLinks(
                            widget.id.toString(), 1);
                      }
                    },
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0.r,
                          left: fameLinkFun.posiondrlf,
                          right: fameLinkFun.posiondrri,
                          bottom: 0.r,
                          child: Container(
                              color: fameLinkFun.selfPrifilewhitemode
                                  ? Colors.white
                                  : Colors.black,
                              child: DrawerPage()),
                        ),
                        Positioned(
                          top: 0.r,
                          left: fameLinkFun.posionsclf,
                          right: fameLinkFun.posionscri,
                          bottom: 0.r,
                          child: SafeArea(
                              child: Container(
                            decoration: fameLinkFun.selfPrifilewhitemode
                                ? BoxDecoration()
                                : BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage(CommonImage.dart_back_img),
                                      alignment: Alignment.center,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                            height: ScreenUtil().screenHeight,
                            width: ScreenUtil().screenWidth,
                            child: SingleChildScrollView(
                                controller: provider!.scrollController,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: provider!.selectPhase == 0
                                      // TODO: FameLinksProfile
                                      ? fameLinkFun.selfPrifilewhitemode
                                          ? PhaseOnewhitemode(
                                              id: widget.id,
                                              isshow: widget.sayhi)
                                          : PhaseOne(
                                              id: widget.id,
                                              isshow: widget.sayhi)
                                      : provider!.selectPhase == 1
                                          // TODO: FunLinksProfile
                                          ? fameLinkFun.selfPrifilewhitemode
                                              ? Phashetowwhitemode(
                                                  id: widget.id.toString(),
                                                  isshow: widget.sayhi)
                                              : Phashetow(
                                                  id: widget.id.toString(),
                                                  isshow: widget.sayhi)
                                          : provider!.selectPhase == 2
                                              // TODO: FollowLinksProfile
                                              ? fameLinkFun.selfPrifilewhitemode
                                                  ? Phashethreewhitemode(
                                                      id: widget.id,
                                                      isshow: widget.sayhi)
                                                  : Phashethree(
                                                      id: widget.id,
                                                      isshow: widget.sayhi)
                                              : Container(),
                                )),
                          )),
                        ),
                      ],
                    ),
                  )),
        );
      },
    );
  }

  Widget jobLinksWidgetTop() => Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withOpacity(0.25)),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 13,
            ),
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 8,
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "21.2M",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 14.0,
                          width: 14.0,
                          child: Image.asset(
                            CommonImage.funLinksStoreLinksVisit,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          "Visits",
                          style: GoogleFonts.nunitoSans(
                              fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                Center(
                    child: Container(
                        width: 1,
                        height: 32,
                        color: Colors.white.withOpacity(0.25))),
                SizedBox(
                  width: 5,
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          "11.2 M",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        const SizedBox(width: 4.0),
                        SizedBox(
                          height: 14.0,
                          width: 14.0,
                          child: Image.asset(
                            CommonImage.funLinksStoreLinksLinks,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "URL Visits",
                      style: GoogleFonts.nunitoSans(
                          fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                Center(
                    child: Container(
                        width: 1,
                        height: 32,
                        color: Colors.white.withOpacity(0.25))),
                SizedBox(
                  width: 5,
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          "5",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        const SizedBox(width: 4.0),
                        SizedBox(
                          height: 14.0,
                          width: 14.0,
                          child: Image.asset(
                            CommonImage.funLinksStoreTrends,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Trendz Sponsored",
                      style: GoogleFonts.nunitoSans(
                          fontSize: 12, color: Colors.white),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white.withOpacity(0.25),
                    )
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                Center(
                    child: Container(
                        width: 1,
                        height: 32,
                        color: Colors.white.withOpacity(0.25))),
                SizedBox(
                  width: 5,
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "200",
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Products",
                      style: GoogleFonts.nunitoSans(
                          fontSize: 12, color: Colors.white),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white.withOpacity(0.25),
                    )
                  ],
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
        ),
      );

  Widget storeLinksWidget() => Container(
        child: Text("storeLinksWidget"),
      );

  Widget circleButtonImage({
    String? imgUrl,
    bool isButtonSelect = false,
    void Function()? onTaps,
  }) =>
      InkWell(
        key: otherPofileprovider!.key,
        onTap: onTaps,
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: SizedBox(
              key: otherPofileprovider!.key,
              width: 30,
              height: 28,
              child: Image.asset(
                imgUrl.toString(),
                width: 30,
                height: 28,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      );

  void showReferralCodeDialogs(int famecoins) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return showReferralCodeDialog(
            id: widget.id.toString(),
          );
        });
  }

  @override
  void onPlayingChange(bool isPlaying) {
    // TODO: implement onPlayingChange
  }

  @override
  void onProfileClick() {
    // TODO: implement onProfileClick
  }
}
