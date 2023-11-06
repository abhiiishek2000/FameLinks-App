import 'dart:async';
import 'dart:ui' as UI;

import 'package:famelink/models/RecommendationModel.dart';
import 'package:famelink/models/store_model.dart';
import 'package:famelink/ui/latest_profile/ProfileFameLinksModel.dart' as fame;
import 'package:famelink/ui/latest_profile/ProfileFameLinksModel.dart' as posts;
import 'package:famelink/ui/latest_profile/ProfileFollowLinksModel.dart';
import 'package:famelink/ui/latest_profile/ProfileFollowLinksModel.dart'
    as followPosts;
import 'package:famelink/ui/latest_profile/ProfileFunLinksModel.dart';
import 'package:famelink/ui/latest_profile/ProfileFunLinksModel.dart'
    as funPosts;
import 'package:famelink/ui/latest_profile/StoreProfileModel.dart';
import 'package:famelink/ui/otherUserProfile/model/FameLinkUserProfileModel.dart';
import 'package:famelink/ui/otherUserProfile/model/FollowLinkUserProfileModel.dart';
import 'package:famelink/ui/otherUserProfile/model/GetParticularUserProfileModel.dart';
import 'package:famelink/ui/otherUserProfile/model/OtherUserProfileFunlinksPostModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../../databse/db_provider.dart';
import '../../../databse/fetchlocaldata.dart';
import '../../../dio/api/api.dart';
import '../../../main.dart';
import '../../../models/Profile_Model.dart';
import '../../../networking/config.dart';
import '../../../util/constants.dart';
import '../../latest_profile/CollabProfileModel.dart';
import '../../latest_profile/ProfileFameLinksModel.dart';

class FameLinkFun extends ChangeNotifier {
  late Animation<Offset> animation;
  late AnimationController animacon;
  bool clubshow = false;
  final double xOffset = 200;

  bool selfPrifilewhitemode = false;
  var avtarImage;
  Timer? timer;
  int start = 30;
  var profileFameLinkImage;
  var profileImage;
  var noImage;
  var userId;
  String? id;
  bool isDarkMode = true;
  List fameDialer = [];
  List fameDialerwhite = [];
  Key keys = UniqueKey();
  List<UI.Image> fameItems = <UI.Image>[];
  List<UI.Image> funItems = <UI.Image>[];
  List<UI.Image> followItems = <UI.Image>[];
  List<UI.Image> jobItems = <UI.Image>[];
  MyProfileResult? upperProfileData;
  bool ispagination = false;
  fame.ProfileFameLinksModel profileFameLinksModelResult =
      fame.ProfileFameLinksModel();
  List funDialer = [];
  List followDialer = [];
  List jobDialer = [];

  String selectDateOfBirth = '_';
  AnimationController? controller;
  final ScrollController scrollController = ScrollController();
  final ScrollController scrollControllerpage = ScrollController();
  final ApiProvider _api = ApiProvider();

  showClub() {
    clubshow = !clubshow;
    print("clubshow $clubshow");
    notifyListeners();
  }

  Future getRequest(String id, String id2) async {
    var result = await _api.getRequestAPI(id);
    if (result != null) {
      //  setState(() {
      Fluttertoast.showToast(msg: result['message']);
      getFollowLinkProfile(id2 ?? id, context, 1);
      if (profileFollowLinksList[0].requests!.length > 0) {
        requestClicked = true;
        acceptValue = true;
      }
      //  fameLinkFun!.keys = UniqueKey();
      // });
      notifyListeners();
    }
  }

  List<FameLinkUserProfileModelResult> dataFameLink = [];

  List<FollowLinksResult> dataFollowLink = [];
  int followFeedPage = 0;

  List<posts.ProfileFameLinksModelResult> profileFameLinksList =
      <ProfileFameLinksModelResult>[];
  List<ProfileFunLinksModelResult> profileFunLinksList =
      <ProfileFunLinksModelResult>[];
  List<ProfileFollowLinksModelResult> profileFollowLinksList =
      <ProfileFollowLinksModelResult>[];
  List<StoreM> store = <StoreM>[];
  List<CollabData> collab = <CollabData>[];
  int? collabCount, collabRecommendationCount;
  List<RecommendationData> recommendations = <RecommendationData>[];
  List<Collab> collabSubData = <Collab>[];
  List<Collab> brandCollabSubData = <Collab>[];
  List<FunlinksPost> funLinkData = <FunlinksPost>[];
  List<FollowlinksPost> followLinkData = <FollowlinksPost>[];

  bool titleWonClicked = false;
  bool trendsSetClicked = false;
  bool yourMusicClicked = false;
  bool yourVideoClicked = false;
  bool requestClicked = false;
  bool acceptValue = false;
  bool showPassword = true;
  int selectPhase = 0;
  String? titleWon;
  List<fame.Posts> famevideo = [];

  int famePage = 0;
  GetParticularUserProfileModel? getParticularUserProfileModel;
  List<GetParticularUserProfileModelResult>
      getParticularUserProfileModelResultList =
      <GetParticularUserProfileModelResult>[];
  List<VideoPlayerController> videofameController = [];

  int funPage = 0;
  List<OtherUserProfileFunlinksPostModelResult>
      getParticularFunUserProfileModelResultList =
      <OtherUserProfileFunlinksPostModelResult>[];
  List<VideoPlayerController> videoFunController = [];
  bool? profileFameLInkLoading = true;
  int followPage = 0;
  List<OtherUserProfileFunlinksPostModelResult>
      getParticularFollowUserProfileModelResultList =
      <OtherUserProfileFunlinksPostModelResult>[];
  List<VideoPlayerController> videoFollowController = [];

//List<home.Result> homeScreenList = <home.Result>[];
  List<Store> myFameResult = [];
  List<funPosts.ProfileFunLinksModelResultPosts> postsListOfFunLink =
      <funPosts.ProfileFunLinksModelResultPosts>[];
  List<posts.Posts> postsListOfFameLink = <posts.Posts>[];
  List<followPosts.ProfileFollowLinksModelResultPosts> postsListOfFollowLink =
      <followPosts.ProfileFollowLinksModelResultPosts>[];
  int famePageForPost = 0, funPageForPost = 0, followPageForPost = 0;

  Future getFameLinksFeed(String id, context,
      {required bool isPaginate}) async {
    if (isPaginate) {
      famePage++;
    } else {
      famePage = 1;
    }
    var result = await _api.getParticularUserProfile(id, famePage);
    List<GetParticularUserProfileModelResult> emptyData = [];
    print("a,ama ${result!.result!.length} ");
    if (result != null) {
      if (result.success.toString() == 'true') {
        print(result.result);
        getParticularUserProfileModel = result;
        if (result.result!.length != 0) {
          getParticularUserProfileModelResultList.addAll(result.result!);
          if (result.result!.length >= 6) {
            getParticularUserProfileModelResultList.addAll(emptyData);
          }
        }

        return result;
      } else {
        Constants.toastMessage(msg: result.message);
        return result;
      }
    }
  }

  Future getFunLinkFeed(String id, {required bool isPaginate}) async {
    if (isPaginate) {
      funPage++;
    } else {
      funPage = 1;
    }
    var result = await _api.getParticularUserProfileFunLinks(id, funPage);
    List<OtherUserProfileFunlinksPostModelResult> emptyData = [];
    if (result != null) {
      if (result.success.toString() == 'true') {
        print(result.result);
        // otherUserProfileFollowLinksModel = result;
        if (result.result!.length != 0) {
          getParticularFunUserProfileModelResultList.addAll(result.result!);
          if (result.result!.length >= 6) {
            getParticularFunUserProfileModelResultList.addAll(emptyData);
          }
        }
        return result;
      } else {
        Constants.toastMessage(msg: result.message);
        return result;
      }
    }

    return result;
  }

  Future getFollowLinkFeed(String id, context,
      {required bool isPaginate}) async {
    if (isPaginate) {
      followPage++;
    } else {
      followPage = 1;
    }
    var result = await _api.getParticularUserProfileFollowLinks(id, followPage);

    if (result != null) {
      if (result.success.toString() == 'true') {
        print(result.result);
        // otherUserProfileFollowLinksModel = result;
        if (result.result!.length != 0) {
          getParticularFollowUserProfileModelResultList.addAll(result.result!);
        }
        return result;
      } else {
        Constants.toastMessage(msg: result!.message);
        return getParticularFollowUserProfileModelResultList;
      }
    }
  }

  getStoreLinkProfile(context) async {
    Map<String, dynamic> map = {"page": '1'};
    Api.get.call(context,
        method: "users/brand/products/me",
        param: map,
        isLoading: false, onResponseSuccess: (Map object) async {
      var result = StoreModel.fromJson(object);
      if (result.result!.length > 0) {
        myFameResult = result.result!;
      }
    });
  }

  getStoreLink(String id) async {
    var result = await _api.getStoreLinkProfileAPI(id);
    if (result != null) {
      if (result.success.toString() == 'true') {
        print(result.result);
        store = result.result!;

        Constants.fameCoins = profileFameLinksList[0].masterUser!.fameCoins!;
        return profileFameLinksList;
      } else {
        Constants.toastMessage(msg: result.message);
        return profileFameLinksList;
      }
    }
  }

  getCollabLink(String id) async {
    var result = await _api.getCollabLinkProfileAPI(id);
    if (result != null) {
      if (result.success.toString() == 'true') {
        print(result.result);
        collab = result.result!;

        for (var index in collab) {
          collabSubData = index.userCollabs!;
          brandCollabSubData = index.brandCollabs!;
          funLinkData = index.funlinksPosts!;
          collabCount = index.collabs;
          collabRecommendationCount = index.recommendations;
        }

        print(result.result![0].followlinksPosts![0].media);

        Constants.fameCoins = profileFameLinksList[0].masterUser!.fameCoins!;
        return profileFameLinksList;
      } else {
        Constants.toastMessage(msg: result.message);
        return profileFameLinksList;
      }
    }
  }

  getAgencyRecommendations(String id) async {
    var result = await _api.getAgencyRecommendationAPI(id);
    if (result != null) {
      if (result.success.toString() == 'true') {
        print(result.data);

        recommendations = result.data!;

        return recommendations;
      } else {
        Constants.toastMessage(msg: result.message);
        return profileFameLinksList;
      }
    }
  }

  getFameLinkProfile(String id, BuildContext context) async {
    famePageForPost++;
    var result = await _api.getFameLinkProfileAPI(id, pageNo: famePageForPost);
    if (result != null) {
      if (result.success.toString() == 'true') {
        print(result.result);
        titleWonClicked = false;
        trendsSetClicked = false;
        yourVideoClicked = false;
        yourMusicClicked = false;
        requestClicked = false;
        profileFameLinksList = result.result!;
        postsListOfFameLink.addAll(result.result![0].posts!);

        debugPrint("2222222222----------3333333333333 ${result.result![0]}");
        for (int i = 0; i < profileFameLinksList[0].titlesWon!.length; i++) {
          if (profileFameLinksList[0].titlesWon![i].level == "country") {
            titleWon = profileFameLinksList[0].titlesWon![i].title;
          } else if (profileFameLinksList[0].titlesWon![i].level == "state") {
            titleWon = profileFameLinksList[0].titlesWon![i].title;
          } else if (profileFameLinksList[0].titlesWon![i].level ==
              "district") {
            titleWon = profileFameLinksList[0].titlesWon![i].title;
          }
        }

        Constants.fameCoins = profileFameLinksList[0].masterUser!.fameCoins!;
        return result;
      } else {
        Constants.toastMessage(msg: result.message);
        return result;
      }
    }
  }

  bool funload = true;

  getFunLinkProfile(id, context, int page) async {
    funload = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ids = prefs!.getString("id");
    funPageForPost++;
    var result = await _api.getFunLinkProfileAPI(ids, pageNo: page);
    if (result != null) {
      if (result.success.toString() == 'true') {
        print(result.result);
        titleWonClicked = false;
        trendsSetClicked = false;
        yourVideoClicked = false;
        yourMusicClicked = false;
        requestClicked = false;
        profileFunLinksList = result.result!;
        postsListOfFunLink.addAll(result.result![0].posts!);
        if (result.result![0].posts!.length == 0) {
          funload = false;
        } else {
          funload = true;
        }

        Constants.fameCoins = profileFunLinksList[0].masterUser!.fameCoins!;
        debugPrint(
            "11111----------1111111111------- ${profileFunLinksList[0].profileImage}");
        debugPrint("11111----------2222222222------- ${result.result}");
        return profileFunLinksList;
      } else {
        Constants.toastMessage(msg: result.message);
        return profileFunLinksList;
      }
    }
  }

  getFunLinkProfilelocal() async {
    funPageForPost++;
    var result = await Fetchlocaldata().profileFunlink();
    if (result != null) {
      if (result.success.toString() == 'true') {
        print(result.result);
        titleWonClicked = false;
        trendsSetClicked = false;
        yourVideoClicked = false;
        yourMusicClicked = false;
        requestClicked = false;
        profileFunLinksList = result.result!;
        postsListOfFunLink.addAll(result.result![0].posts!);
        Constants.fameCoins = profileFunLinksList[0].masterUser!.fameCoins!;
        debugPrint(
            "11111----------1111111111------- ${profileFunLinksList[0].profileImage}");
        debugPrint("11111----------2222222222------- ${result.result}");
        return profileFunLinksList;
      } else {
        Constants.toastMessage(msg: result.message);
        return profileFunLinksList;
      }
    }
  }

  getFollowLinkProfilelocal() async {
    followPageForPost++;
    var result = await Fetchlocaldata().profileFollowlink();
    if (result != null) {
      if (result.success.toString() == 'true') {
        print(result.result);
        // selectPhase = 2;
        titleWonClicked = false;
        trendsSetClicked = false;
        yourVideoClicked = false;
        yourMusicClicked = false;
        requestClicked = false;
        profileFollowLinksList = result.result!;
        postsListOfFollowLink.addAll(result.result![0].posts!);
        if (acceptValue == true) {
          for (int i = 0; i < profileFollowLinksList.length; i++) {
            if (profileFollowLinksList[i].requests!.length > 0) {
              requestClicked = true;
            }
          }
        }
        Constants.fameCoins = profileFollowLinksList[0].masterUser!.fameCoins!;
        // keys = UniqueKey();

        return profileFollowLinksList;
      } else {
        Constants.toastMessage(msg: result.message);
        return profileFollowLinksList;
      }
    }
  }

  bool followload = true;

  getFollowLinkProfile(id, context, int page) async {
    followload = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ids = prefs!.getString("id");
    followPageForPost++;
    var result = await _api.getFollowLinkProfileAPI(ids, pageNo: page);
    if (result != null) {
      if (result.success.toString() == 'true') {
        print(result.result);
        // selectPhase = 2;
        titleWonClicked = false;
        trendsSetClicked = false;
        yourVideoClicked = false;
        yourMusicClicked = false;
        requestClicked = false;
        profileFollowLinksList = result.result!;
        postsListOfFollowLink.addAll(result.result![0].posts!);
        if (result.result![0].posts!.length == 0) {
          followload = false;
        } else {
          followload = true;
        }

        if (acceptValue == true) {
          for (int i = 0; i < profileFollowLinksList.length; i++) {
            if (profileFollowLinksList[i].requests!.length > 0) {
              requestClicked = true;
            }
          }
        }
        Constants.fameCoins = profileFollowLinksList[0].masterUser!.fameCoins!;
        // keys = UniqueKey();

        return profileFollowLinksList;
      } else {
        Constants.toastMessage(msg: result.message);
        return profileFollowLinksList;
      }
    }
  }

  getFameLinkProfile2() async {
    FameLinkFun().famePageForPost++;
    var result = await Fetchlocaldata().profilefamelink();

    if (result != null) {
      if (result.success.toString() == 'true') {
        print(result.result);
        titleWonClicked = false;
        trendsSetClicked = false;
        yourVideoClicked = false;
        yourMusicClicked = false;
        requestClicked = false;
        profileFameLinksList = result.result!;

        postsListOfFameLink.addAll(result.result![0].posts!);

        debugPrint("2222222222----------3333333333333 ${result.result![0]}");
        for (int i = 0; i < profileFameLinksList[0].titlesWon!.length; i++) {
          if (profileFameLinksList[0].titlesWon![i].level == "country") {
            titleWon = profileFameLinksList[0].titlesWon![i].title;
          } else if (profileFameLinksList[0].titlesWon![i].level == "state") {
            titleWon = profileFameLinksList[0].titlesWon![i].title;
          } else if (profileFameLinksList[0].titlesWon![i].level ==
              "district") {
            titleWon = profileFameLinksList[0].titlesWon![i].title;
          }
        }

        Constants.fameCoins = profileFameLinksList[0].masterUser!.fameCoins!;
        return result;
      } else {
        Constants.toastMessage(msg: result.message);
        return result;
      }
    }
    // notifyListeners();
  }

  getProfileFameLinkslocal() async {
    //  profileFameLInkLoading = true;
    print("getProfileFameLinkslocal");
    var res = await getFameLinkProfile2();

    if (res != null) {
      profileFameLinksModelResult = res;
      famevideo.addAll(res.result![0].posts!);
      profileFameLInkLoading = false;

      notifyListeners();
    }
  }

  bool fameload = true;

  getProfileFameLinksData(String? id, BuildContext context, int page) async {
    fameload = false;
    if (page == 1) {
      famevideo.clear();
    }
    // profileFameLInkLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ids = prefs!.getString("id");
    var res = (await _api.getFameLinkProfileAPI(ids!, pageNo: page))!;
    profileFameLinksModelResult = res;
    famevideo.addAll(res.result![0].posts!);
    if (res.result![0].posts!.length == 0) {
      fameload = false;
    } else {
      fameload = true;
    }
    print("getProfileFameLinksonline ${res.result![0].posts!.length} $id");
    profileFameLInkLoading = false;

    notifyListeners();
  }

  setselfprothame(bool val) {
    selfPrifilewhitemode = val;
    print("them change $val");
    notifyListeners();
  }

  double posiondrlf = -280.r;
  double posiondrri = 0.r;
  double posionsclf = 0.r;
  double posionscri = 0.r;
  bool isdrower = false;

  therprofiledrower(bool val) {
    isdrower = !val;
    if (isdrower == true) {
      posiondrlf = 0.r;
      posiondrri = 160.r;
      posionsclf = 180.r;
      posionscri = -180.r;
    } else {
      posiondrlf = -280.r;
      posiondrri = 0.r;
      posionsclf = 0.r;
      posionscri = 0.r;
    }
    notifyListeners();
  }

  void init(int? ids2, String? status, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ids = prefs!.getString("id");
    id = await DatabaseProvider().getUserId();
    profileImage = DatabaseProvider().getProfileImage();
    DatabaseProvider().getProfileImage().then((value) {
      avtarImage = value;
    });
    noImage = DatabaseProvider().getProfileImage();
    Constants.userType = prefs.getString("type");
    getProfileFameLinkslocal();
    await getProfileFameLinksData(id.toString(), context, 1);
    //_profile();

    getFollowLinkProfilelocal();
    await getFollowLinkProfile(ids ?? id, context, 1);
    if (Constants.userType == 'brand') {
      await getStoreLinkProfile(context);
      await getStoreLink(id!);
    } else {}
    //  UserProfileProvider().getFunLinkProfilelocal();
    getFunLinkProfile(id ?? ids, context, 1);

    _loadImage(fameDialer, 0);
    _loadImage(funDialer, 1);
    _loadImage(followDialer, 2);
    _loadImage(jobDialer, 3);
    profile(context);

    if (Constants.userType != 'brand' ||
        Constants.userType != "agency" ||
        getParticularUserProfileModelResultList.length == 0) {
      famePage = 0;
      getParticularUserProfileModel = null;
      getParticularUserProfileModelResultList.clear();
      videofameController.clear();
      //getFameLinksFeed(profileFameLinksList[0].sId!, context);
    } else if (getParticularFunUserProfileModelResultList.length == 0) {
      funPage = 0;
      getFunLinkFeed(profileFunLinksList[0].sId!, isPaginate: false);
      getParticularFunUserProfileModelResultList.clear();
      videoFunController.clear();
    } else if (getParticularFollowUserProfileModelResultList.length == 0) {
      followPage = 0;
      getParticularFollowUserProfileModelResultList.clear();
      videoFollowController.clear();
      getFollowLinkFeed(profileFollowLinksList[0].sId!, context,
          isPaginate: false);
    }
    notifyListeners();
    // setState(() {});
  }

  profile(BuildContext context) async {
    Api.get.call(context, method: "users/$id", param: {},
        onResponseSuccess: (Map object) async {
      var result = ProfileResponse.fromJson(object);
      upperProfileData = result.result;
      print('RESPONSE ${result.result}');
      // setState(() {});
      notifyListeners();
    });
  }

  void test() {
    print('ok');
  }

  logoutfun(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs!.remove('isLoggedIn');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyApp(),
      ),
    );
  }

  profiles(BuildContext context) async {
    Api.get.call(context, method: "users/me", param: {},
        onResponseSuccess: (Map object) async {
      var result = ProfileResponse.fromJson(object);
      upperProfileData = result.result;
      Constants.fameCoins = upperProfileData!.fameCoins!;
      Constants.verificationStatus = upperProfileData!.verificationStatus!;
      if (upperProfileData!.brand! != null && //bannerMedia
          upperProfileData!.brand!.bannerMedia!.length < 5) {
        upperProfileData!.brand!.bannerMedia!.add("");
      }
      print('RESPONSE ${result.result}');
      notifyListeners();
      // setState(() {});
    });
  }

  Future<UI.Image?> _loadImage(List imageAssetPath, i) async {
    for (var item in imageAssetPath) {
      final ByteData data = await rootBundle.load(item);
      final codec = await UI.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetHeight: 60,
        targetWidth: 60,
      );
      var frame = await codec.getNextFrame();
      if (i == 0) {
        fameItems.add(frame.image);
      } else if (i == 1) {
        funItems.add(frame.image);
      } else if (i == 2) {
        followItems.add(frame.image);
      } else {
        jobItems.add(frame.image);
      }
    }
    notifyListeners();
  }
}
