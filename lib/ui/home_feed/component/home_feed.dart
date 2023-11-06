import 'package:famelink/check_app_update.dart';
import 'package:famelink/databse/db_provider.dart';
import 'package:famelink/ui/challenge/challenge_screen.dart';
import 'package:famelink/ui/fameLinks/view/FameLinksFeed.dart';
import 'package:famelink/ui/followLinks/ui/FollowLinksUserProfile.dart';
import 'package:famelink/ui/funlinks/ui/FunLinksUserProfile.dart';
import 'package:famelink/ui/home_feed/component/trendz_grid_widget.dart';
import 'package:famelink/ui/home_feed/component/user_grid_widget.dart';
import 'package:famelink/ui/home_feed/provider/home_feed_provider.dart';
import 'package:famelink/ui/homedial/model/HomeScreenModel.dart';
import 'package:famelink/ui/latest_profile/ProfileFameLinksModel.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/gradient_text.dart';
import 'package:famelink/util/widgets/challenge_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../../databse/localdata.dart';
import '../../../util/constants.dart';
import '../../Famelinkprofile/function/famelinkFun.dart';
import 'posts_grid_widget.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({Key? key}) : super(key: key);

  @override
  State<HomeFeed> createState() => HomeFeedState();
}

class HomeFeedState extends State<HomeFeed> with TickerProviderStateMixin {
  static String? selectRunType;
  String? id;
  List<ProfileFameLinksModelResult> profileFameLinksList =
      <ProfileFameLinksModelResult>[];

  @override
  void initState() {
    getMe();
    init();
    // TODO: implement initState
    Provider.of<CheckAppUpdateProvider>(context, listen: false)
        .checkForUpdate();
    super.initState();
  }

  getMe() async {
    final provider = Provider.of<HomeFeedProvider>(context, listen: false);
    provider.getfeedlink();
    provider.getPostData();
    provider.userlocalMe();
    await provider.userMe();
    Localdata().sethivedata(
        {'isShown': true, 'date': '${DateTime.now().toString()}'},
        "homeFeedLoginData");
  }

  init() async {
    final fameLinkFun = Provider.of<FameLinkFun>(context, listen: false);
    id = await DatabaseProvider().getUserId();
    if (Constants.userType == 'brand') {
      await fameLinkFun.getStoreLinkProfile(context);
      await fameLinkFun.getStoreLink(id!);
    } else if (Constants.userType == 'agency') {
      await fameLinkFun.getCollabLink(id!);
    } else {
      await Provider.of<HomeFeedProvider>(context, listen: false)
          .getImageFromShared();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeFeedProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: black,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChallengeScreen(),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ChallengeIconWidget(),
                ],
              ),
            ),
            title: provider.loading == true ||
                    provider.homeScreenModel.result == null
                ? Container()
                : Stack(
                    children: [
                      Center(
                        child: GradientText(
                          provider.homeScreenModel.result!.length != 0
                              ? provider.homeScreenModel
                                  .result![provider.currentPage].title!
                              : "",
                          gradient: LinearGradient(
                            colors: [
                              HexColor("0083FF"),
                              HexColor("8583FF"),
                              HexColor("FFFFFF"),
                              HexColor("FF9E9B"),
                              HexColor("FF4944"),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          provider.homeScreenModel.result!.length != 0
                              ? provider.homeScreenModel
                                  .result![provider.currentPage].title!
                              : "",
                          style: TextStyle(
                            fontSize: 20,
                            color: HexColor("FF9E9B"),
                          ),
                        ),
                      )
                    ],
                  ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: GestureDetector(
            onPanUpdate: (details) {
              if (provider.selectedProfileType.toString() ==
                  ProfileType.FAMELinks.toString()) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => FameLinksFeed()),
                    (Route<dynamic> route) => false);
                //gotoFameLinkUserProfileScreen(context);
              } else if (provider.selectedProfileType.toString() ==
                  ProfileType.FUNLinks.toString()) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => FunLinksUserProfile()),
                    (Route<dynamic> route) => false);
                //gotoFunLinksUserProfileScreen(context);
              } else if (provider.selectedProfileType.toString() ==
                  ProfileType.FOLLOWLinks.toString()) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => FollowLinksUserProfile()),
                    (Route<dynamic> route) => false);
                // gotoFollowLinksUserProfileScreen(context);
              } else if (provider.selectedProfileType.toString() ==
                  ProfileType.JOBLinks.toString()) {
              } else if (provider.selectedProfileType.toString() ==
                  ProfileType.STORELinks.toString()) {}
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/home_dial_dark.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: provider.loading == true
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              SizedBox(
                                height: ScreenUtil().screenHeight,
                                width: ScreenUtil().screenWidth,
                                child: provider.homeScreenModel.result != null
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            top: provider.currentPage > 0
                                                ? 72
                                                : 95.0),
                                        height: ScreenUtil().screenHeight,
                                        width: ScreenUtil().screenWidth,
                                        child: Column(
                                          children: <Widget>[
                                            if (provider.currentPage > 0) ...[
                                              IconButton(
                                                icon: Icon(
                                                  Icons.keyboard_arrow_up,
                                                  color: white,
                                                ),
                                                onPressed: () =>
                                                    provider.changeCurrentPage(
                                                        provider.homeScreenModel
                                                            .result!.length,
                                                        isReverse: true),
                                              ),
                                            ],
                                            provider.homeScreenModel.result!
                                                        .isNotEmpty &&
                                                    provider
                                                            .homeScreenModel
                                                            .result![provider
                                                                .currentPage]
                                                            .category ==
                                                        "post"
                                                ? Flexible(
                                                    child: GridView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 2,
                                                              mainAxisExtent:
                                                                  (ScreenUtil()
                                                                              .screenHeight *
                                                                          0.24)
                                                                      .ceilToDouble(),
                                                              crossAxisSpacing:
                                                                  25.0,
                                                              mainAxisSpacing:
                                                                  18.0),
                                                      shrinkWrap: false,
                                                      itemCount: provider
                                                          .homeScreenModel
                                                          .result![provider
                                                              .currentPage]
                                                          .postResult!
                                                          .length,
                                                      /*homeScreenList.isNotEmpty&&homeScreenList[provider.currentPage].category ==
                                                        "post"?*/
                                                      padding: EdgeInsets.only(
                                                          left: 40.0,
                                                          right: 40.0,
                                                          bottom: 0.0,
                                                          top: 0.0),
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        PostResult?
                                                            postDetails =
                                                            provider
                                                                .homeScreenModel
                                                                .result![provider
                                                                    .currentPage]
                                                                .postResult![index];
                                                        return PostsGridWidget(
                                                            postResult:
                                                                postDetails);
                                                      },
                                                    ),
                                                  )
                                                : provider
                                                            .homeScreenModel
                                                            .result!
                                                            .isNotEmpty &&
                                                        provider
                                                                .homeScreenModel
                                                                .result![provider
                                                                    .currentPage]
                                                                .category ==
                                                            "trendz"
                                                    ? Flexible(
                                                        child: GridView.builder(
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 2,
                                                              mainAxisExtent:
                                                                  (ScreenUtil()
                                                                              .screenHeight *
                                                                          0.23)
                                                                      .ceilToDouble(),
                                                              crossAxisSpacing:
                                                                  25.0,
                                                              mainAxisSpacing:
                                                                  18.0),
                                                          shrinkWrap: false,
                                                          itemCount: provider
                                                              .homeScreenModel
                                                              .result![provider
                                                                  .currentPage]
                                                              .trendzResult!
                                                              .length,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 40.0,
                                                                  right: 40.0,
                                                                  bottom: 0.0,
                                                                  top: 0.0),
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            TrendzResult?
                                                                postDetails =
                                                                provider
                                                                    .homeScreenModel
                                                                    .result![
                                                                        provider
                                                                            .currentPage]
                                                                    .trendzResult![index];
                                                            return TrendzGridWidget(
                                                                postResult:
                                                                    postDetails);
                                                          },
                                                        ),
                                                      )
                                                    : provider
                                                                .homeScreenModel
                                                                .result!
                                                                .isNotEmpty &&
                                                            provider
                                                                    .homeScreenModel
                                                                    .result![
                                                                        provider
                                                                            .currentPage]
                                                                    .category ==
                                                                "user"
                                                        ? Flexible(
                                                            child: GridView
                                                                .builder(
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                  crossAxisCount:
                                                                      2,
                                                                  mainAxisExtent:
                                                                      (ScreenUtil().screenHeight *
                                                                              0.23)
                                                                          .ceilToDouble(),
                                                                  crossAxisSpacing:
                                                                      25.0,
                                                                  mainAxisSpacing:
                                                                      18.0),
                                                              shrinkWrap: false,
                                                              itemCount: provider
                                                                  .homeScreenModel
                                                                  .result![provider
                                                                      .currentPage]
                                                                  .userResult!
                                                                  .length,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          40.0,
                                                                      right:
                                                                          40.0,
                                                                      bottom:
                                                                          0.0,
                                                                      top: 0.0),
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                UserResult? postDetails = provider
                                                                    .homeScreenModel
                                                                    .result![
                                                                        provider
                                                                            .currentPage]
                                                                    .userResult![index];
                                                                return UserGridWidget(
                                                                  postResult:
                                                                      postDetails,
                                                                );
                                                              },
                                                            ),
                                                          )
                                                        : Flexible(
                                                            child: GridView
                                                                .builder(
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                  crossAxisCount:
                                                                      2,
                                                                  mainAxisExtent:
                                                                      (ScreenUtil().screenHeight *
                                                                              0.246)
                                                                          .ceilToDouble(),
                                                                  crossAxisSpacing:
                                                                      25.0,
                                                                  mainAxisSpacing:
                                                                      18.0),
                                                              shrinkWrap: false,
                                                              itemCount: 6,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          40.0,
                                                                      right:
                                                                          40.0,
                                                                      bottom:
                                                                          0.0,
                                                                      top: 0.0),
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                PostResult? postDetails = provider
                                                                    .homeScreenModel
                                                                    .result![
                                                                        provider
                                                                            .currentPage]
                                                                    .postResult![index];
                                                                return PostsGridWidget(
                                                                    postResult:
                                                                        postDetails);
                                                              },
                                                            ),
                                                          ),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: white,
                                                ),
                                                onPressed: () =>
                                                    provider.changeCurrentPage(
                                                        provider.homeScreenModel
                                                            .result!.length,
                                                        isReverse: false)),
                                            const SizedBox(
                                              height: 26.0,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          'No famelinks found',
                                          style: TextStyle(color: white),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
