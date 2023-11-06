import 'package:famelink/databse/fetchlocaldata.dart';
import 'package:famelink/networking/config.dart';
import 'package:flutter/material.dart';

import '../../../databse/db_provider.dart';
import '../../../providers/UserProfileProvider/userProfile_provider.dart';
import '../../../util/constants.dart';
import '../../homedial/model/HomeScreenModel.dart';
import '../../latest_profile/ProfileFameLinksModel.dart';

enum ProfileType { FAMELinks, JOBLinks, FUNLinks, FOLLOWLinks, STORELinks }

class HomeFeedProvider extends UserProfileProvider {
  bool isProfileUI = false;
  ProfileType? selectedProfileType;
  HomeScreenModel homeScreenModel = HomeScreenModel();
  bool loading = false;
  bool isDarkMode = false;
  String? profileFameLinksImage;
  var avtarImage;
  var profileImage;
  int currentPage = 0;
  var noImage;
  ApiProvider _api = ApiProvider();
  List<ProfileFameLinksModelResult> profileFameLinksList =
      <ProfileFameLinksModelResult>[];

  void changeDialerView(bool value) {
    isProfileUI = value;
    notifyListeners();
  }

  void changeProfileType(ProfileType value) {
    selectedProfileType = value;
    notifyListeners();
  }

  void changeThemeMode(bool value) {
    isDarkMode = value;
    notifyListeners();
  }

  getImageFromShared() async {
    String? ids = await DatabaseProvider().getUserId();
    print("--------------------ids$ids");
    var result = await _api.getFameLinkProfileAPI(ids);
    DatabaseProvider().getProfileImage().then((value) {
      avtarImage = value;
    });
    profileImage = DatabaseProvider().getProfileImage();
    noImage = DatabaseProvider().getProfileImage();
    if (result != null) {
      profileFameLinksList.addAll(result.result!);
      if (profileFameLinksList[0].profileImageType != null) {
        if (profileFameLinksList[0].profileImageType == "avatar") {
          profileFameLinksImage =
              "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${profileFameLinksList[0].profileImage}";
          print("profileFameLinksImage========$profileFameLinksImage");
          notifyListeners();
        } else if (profileFameLinksList[0].profileImageType == "image") {
          profileFameLinksImage =
              "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${profileFameLinksList[0].profileImage}";
          notifyListeners();
          print("profileFameLinksImage========$profileFameLinksImage");
        }
      }
    }
    notifyListeners();
  }

  getPostData() async {
    loading = true;
    try {
      homeScreenModel = await getFameLinkFeed();
      loading = false;
    } catch (e) {
      loading = false;
    }

    notifyListeners();
  }

  getFameLinkFeed() async {
    var result = await _api.getFameLinkFeed();
    if (result != null) {
      if (result.success.toString() == 'true') {
        print(result.result);
        // homeScreenList.addAll(result.result);
        return result;
      } else {
        Constants.toastMessage(msg: result.message);
        return result;
      }
    }
  }

  getfeedlink() async {
    loading = true;
    var result1 = await Fetchlocaldata().getFameLinkFeed();
    print("localdata  $result1");
    if (result1 != null) {
      homeScreenModel = result1;
      loading = false;
      notifyListeners();
    }
  }

  changeCurrentPage(int length, {required bool isReverse}) {
    debugPrint("Current Page Length ${currentPage.toString()}");
    debugPrint("homeScreenList Main List Length ${length.toString()}");
    if (isReverse) {
      currentPage--;
      notifyListeners();
    } else if (currentPage + 1 == int.parse(length.toString())) {
      changeProfileType(ProfileType.FAMELinks);
      // Fluttertoast.showToast(msg: 'No More Page Available');
    } else {
      currentPage++;
      notifyListeners();
      debugPrint("Current Page Length ${currentPage.toString()}");
    }
  }

  Future<bool> checkIsShown() async {
    var result = await Fetchlocaldata().getHomeFeedLocalData();
    if (result != null) {
      Duration diff = DateTime.now().difference(DateTime.parse(result.date!));
      if (diff.inDays > 1) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}
