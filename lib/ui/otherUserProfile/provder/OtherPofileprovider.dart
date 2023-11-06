import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../../dio/api/api.dart';
import '../../../models/LocationResponse.dart';
import '../../../models/Profile_Model.dart';
import '../../../models/store_model.dart';
import '../../../networking/config.dart';
import '../../../util/constants.dart';
import '../../Famelinkprofile/function/famelinkFun.dart';
import '../OtherFameLinksModel.dart' as fameLinks;
import '../model/GetParticularUserProfileModel.dart';
import '../model/OtherUserProfileFollowLinksModel.dart' as followlink;
import '../model/OtherUserProfileFollowlinksPostModel.dart';
import '../model/OtherUserProfileFunLinksModel.dart' as followlink;

class OtherPofileprovider extends ChangeNotifier {
  TextEditingController fameCoinController = TextEditingController();
  Key key = UniqueKey();
  Key keys = UniqueKey();
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
  int followPage = 0;
  List<OtherUserProfileFunlinksPostModelResult>
      getParticularFollowUserProfileModelResultList =
      <OtherUserProfileFunlinksPostModelResult>[];
  List<VideoPlayerController> videoFollowController = [];

  int? selectPhase = 0;

  // var  userId = ApiProvider.profileUserId;
  bool isShowDropDown = false;
  DateTime selectedDate = DateTime.now();
  String selectDistrict = "_";
  String selectState = "_";

  String selectCountry = "_";
  String selectContinent = "_";
  String? titleWon;

  bool titleWonClicked = false;
  bool trendsSetClicked = false;
  bool yourMusicClicked = false;
  bool yourVideoClicked = false;
  bool requestClicked = false;

  String selectGender = "_";

  bool isShowRightButton = false;
  List<AddressLocation> locationList = <AddressLocation>[];
  List<fameLinks.OtherFameLinksModelResult> profileFameLinksList =
      <fameLinks.OtherFameLinksModelResult>[];
  List<fameLinks.Posts> userPosts = <fameLinks.Posts>[];
  List<followlink.ProfileFunLinksModelResultPosts> userPostsfun =
      <followlink.ProfileFunLinksModelResultPosts>[];
  List<followlink.Posts> userPostsfollow = <followlink.Posts>[];
  List<followlink.OtherUserProfileFunLinksModelResult>
      otherUserProfileFunLinksModel =
      <followlink.OtherUserProfileFunLinksModelResult>[];
  List<followlink.OtherUserProfileFollowLinksModelResult>
      otherUserProfileFollowLinksModelResult =
      <followlink.OtherUserProfileFollowLinksModelResult>[];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController districtNameController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();

  bool isDarkMode = true;
  String selectDateOfBirth = '_';
  String dropdownValue = "Individual";
  SharedPreferences? prefs;
  final List<Map> myProducts =
      List.generate(100000, (index) => {"id": index, "name": "Product $index"})
          .toList();
  MyProfileResult? upperProfileData;
  var profileImage;
  var avtarImage;
  var noImage;
  List<Store> myStoreResult = [];
  int page = 1;
  final ScrollController scrollController = ScrollController();

  profile(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = await prefs.getString("id");
    print("profile $id");
    avtarImage = prefs.getString("avatarImage");
    profileImage = prefs.getString("profileImage");
    noImage = prefs.getString("noImage");
    Api.get.call(context, method: "users/${id}", param: {},
        onResponseSuccess: (Map object) async {
      var result = ProfileResponse.fromJson(object);
      upperProfileData = result.result;
      Constants.userType = result.result!.type;
      print('RESPONSE ${result.result}');

      notifyListeners();
    });
  }

  String? followStatus, followUnfollow;
  final ApiProvider _api = ApiProvider();

  int funindex = 0;

  bool isloading = true;

  getProfile(BuildContext context, String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ids = prefs!.getString("id");
    print("getprofile $id");
    funindex++;
    await getOtherUserProfileFunLinks(id ?? ids!, 1);
    //UserProfileProvider().getUserProfileFollowLinks();
    await getOtherUserProfileFollowLinks(id, 1);
    getFollowLinkProfile(id, context, 1);
    FameLinkFun().getFunLinkProfile(id, context, 1);
    FameLinkFun().getProfileFameLinksData(id, context, 1);
    if (Constants.userType != 'brand') {
      await getOtherUserProfile(id, 1);
      FameLinkFun().getFameLinksFeed(
          profileFameLinksList[0].sId! ?? id, context,
          isPaginate: false);
    } else {
      await FameLinkFun().getStoreLink(id!);
      await myFamelinks(id);
    }
    FameLinkFun().getFunLinkFeed(otherUserProfileFunLinksModel[0].sId! ?? id,
        isPaginate: false);
    FameLinkFun().getFollowLinkFeed(
        otherUserProfileFollowLinksModelResult[0].sId! ?? id, context,
        isPaginate: false);

    isloading = false;
    notifyListeners();
  }

  int fai = 1;
  int fni = 1;
  int foi = 1;

  getFollowLinkProfile(id, context, int page) async {
    FameLinkFun().followload = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ids = prefs!.getString("id");
    FameLinkFun().followPageForPost++;
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
        FameLinkFun().profileFollowLinksList = result.result!;
        FameLinkFun().postsListOfFollowLink.addAll(result.result![0].posts!);
        if (result.result![0].posts!.length == 0) {
          FameLinkFun().followload = false;
        } else {
          FameLinkFun().followload = true;
        }

        if (FameLinkFun().acceptValue == true) {
          for (int i = 0;
              i < FameLinkFun().profileFollowLinksList.length;
              i++) {
            if (FameLinkFun().profileFollowLinksList[i].requests!.length > 0) {
              requestClicked = true;
            }
          }
        }
        Constants.fameCoins =
            FameLinkFun().profileFollowLinksList[0].masterUser!.fameCoins!;
        // keys = UniqueKey();

        return FameLinkFun().profileFollowLinksList;
      } else {
        Constants.toastMessage(msg: result.message);
        return FameLinkFun().profileFollowLinksList;
      }
    }
  }

  alldataclear() {
    getParticularUserProfileModelResultList.clear();
    myStoreResult.clear();
    otherUserProfileFunLinksModel.clear();
    otherUserProfileFollowLinksModelResult.clear();
    otherUserProfileFunLinksModel.clear();
    profileFameLinksList.clear();
    userPosts.clear();
    userPostsfun.clear();
    userPostsfollow.clear();
    isfame = true;
    isfun = true;
    isfollow = true;
    fai = 1;
    fni = 1;
    foi = 1;
    notifyListeners();
  }

  Future<List<StoreModel>?> myFamelinks(String id) async {
    var result = await _api.getStoreLinkOtherAPI(id!, page);
    myStoreResult.clear();
    print(" myFamelinks(); $id");
    if (result != null) {
      // setState(() {
      if (result.success!) {
        myStoreResult.addAll(result.result!);
        //return myStoreResul!;
        notifyListeners();
      } else {
        Constants.toastMessage(msg: result.message);
        //return myStoreResult;
      }

      //   });
    }
    print("myFamelinks");
  }

  bool isfame = false;
  getOtherUserProfile(String id, int funindex) async {
    isfame = false;
    // profileFameLinksList.clear();
    var result = await _api.getFameLinkOtherAPI(id!, funindex);

    if (result != null) {
      if (result.success!) {
        //profileFameLinksList = result.result!;
        profileFameLinksList.addAll(result.result!);
        userPosts.addAll(result.result![0].posts!);
        if (result.result![0].posts!.length == 0) {
          isfame = false;
        } else {
          isfame = true;
        }
        notifyListeners();
        print("Profile Follow Status ${userPosts.length}");
        //return profileFameLinksList;
      } else {
        Constants.toastMessage(msg: result.message);
        //return profileFameLinksList;
      }
      // });
    }
    // print("getOtherUserProfile");
  }

  String phaseoneload = "";
  String phasetowload = "";
  String phasethreeload = "";
  bool isfun = true;

  Future<List<followlink.OtherUserProfileFunLinksModelResult>?>
      getOtherUserProfileFunLinks(String id, int fnindex) async {
    if (fnindex == 1) {
      userPostsfun.clear();
    }
    phasethreeload = "Video Loading...";
    isfun = false;
    // notifyListeners();
    var result = await _api.getFameLinkOtherAPIFunLinks(id!, fnindex);
    if (result != null) {
      //  setState(() {
      if (result.success!) {
        otherUserProfileFunLinksModel.addAll(result.result!);
        if (result.result![0].posts!.length > 0) {
          userPostsfun.addAll(result.result![0].posts!);
          if (result.result![0].posts!.length == 0) {
            isfun = false;
          } else {
            isfun = true;
          }
          print(otherUserProfileFunLinksModel);
        } else {
          phasethreeload = "No More Video Found";
        }
        //return otherUserProfileFunLinksModel;
      } else {
        Constants.toastMessage(msg: result.message);
        //return otherUserProfileFunLinksModel;
      }
      // });
    }
    notifyListeners();
  }

  bool isfollow = true;
  Future<List<followlink.OtherUserProfileFollowLinksModelResult>?>
      getOtherUserProfileFollowLinks(String id, int foindex) async {
    if (foindex == 1) {
      userPostsfollow.clear();
    }
    print(" getOtherUserProfileFollowLinks(); $id");
    // widget.selectPhase = 2;
    otherUserProfileFollowLinksModelResult.clear();
    isfollow = false;
    var result = await _api.getFameLinkOtherAPIFollowLinks(id!, foindex);
    if (result != null) {
      //setState(() {
      if (result.success!) {
        otherUserProfileFollowLinksModelResult.addAll(result.result!);
        userPostsfollow.addAll(result.result![0].posts!);
        if (result.result![0].posts!.length == 0) {
          isfollow = false;
        } else {
          isfollow = true;
        }
        print(result.result!);
        notifyListeners();
        //return otherUserProfileFollowLinksModelResult;
      } else {
        Constants.toastMessage(msg: result.message);
        //return otherUserProfileFollowLinksModelResult;
      }
      // });
    }
  }

  Future getFollowFameStatus(String id) async {
    profileFameLinksList[0].followStatus = "Following";
    notifyListeners();
    var result = await _api.getFoloowStatusAPI(id);
    print(result['message']);
    if (result['success'] == true) {}
  }

  Future getUnFollowFameStatus(String id) async {
    profileFameLinksList[0].followStatus = 'Follow';
    notifyListeners();
    var result = await _api.getUnFoloowStatusAPI(id);
    print(result['message']);
    if (result['success'] == true) {}
  }

  Future getFollowFunStatus(String id) async {
    otherUserProfileFunLinksModel[0].followStatus = "Following";
    notifyListeners();
    var result = await _api.getFoloowStatusAPI(id);
    print(result['message']);
    if (result['success'] == true) {}
  }

  Future getUnFollowFunStatus(String id) async {
    otherUserProfileFunLinksModel[0].followStatus = 'Follow';
    notifyListeners();
    var result = await _api.getUnFoloowStatusAPI(id);
    print(result['message']);
    if (result['success'] == true) {}
  }

  Future getFollowFollowStatus(String id) async {
    otherUserProfileFollowLinksModelResult[0].followStatus = "Following";
    notifyListeners();
    var result = await _api.getFoloowStatusAPI(id);
    print(result['message']);
    if (result['success'] == true) {}
  }

  Future getUnFollowFollowStatus(String id) async {
    otherUserProfileFollowLinksModelResult[0].followStatus = 'Follow';
    notifyListeners();
    var result = await _api.getUnFoloowStatusAPI(id);
    print(result['message']);
    if (result['success'] == true) {}
  }
}
