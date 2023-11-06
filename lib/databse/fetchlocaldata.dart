import 'dart:convert';
import 'dart:developer';
import 'package:famelink/databse/models/home_feed_local.dart';

import '../models/Profile_Model.dart';
import '../ui/homedial/model/HomeScreenModel.dart';
import '../ui/latest_profile/ProfileFameLinkCopy.dart';
import '../ui/latest_profile/ProfileFameLinksModel.dart';
import '../ui/latest_profile/ProfileFollowLinksModel.dart';
import '../ui/otherUserProfile/model/FameLinkUserProfileModel.dart';
import '../ui/otherUserProfile/model/FollowLinkUserProfileModel.dart';
import '../ui/otherUserProfile/model/FunLinkUserProfileModel.dart';
import 'localdata.dart';

class Fetchlocaldata {
  Localdata localdata = Localdata();
  Future<FameLinkUserProfileModel?> famlinklocal() async {
    var data = await localdata.gethivedata("getFameLinksProfile");
    if (data != null) {
      return FameLinkUserProfileModel.fromJson(jsonDecode(data));
    }
  }

  funlinklocal() async {
    var data = await localdata.gethivedata("getFunLinksProfile");
    log("fundata $data");
    if (data != null) {
      return FunLinkUserProfileModel.fromJson(jsonDecode(data));
    }
  }

  follwlinklocal() async {
    var data = await localdata.gethivedata("getFollowLinksProfile");
    print("getfollow $data");
    if (data != null) {
      return FollowLinkUserProfileModel.fromJson(jsonDecode(data));
    }
  }

  getFameLinkFeed() async {
    var data = await localdata.gethivedata("getFameLinkFeed");
    print("getfeed $data");
    if (data != null) {
      return HomeScreenModel.fromJson(jsonDecode(data));
    }
  }

  profilefamelink() async {
    var data = await localdata.gethivedata("profilefamelink");
    print("getfeed $data");
    if (data != null) {
      return ProfileFameLinksModel.fromJson(jsonDecode(data));
    }
  }

  profile1() async {
    var data = await localdata.gethivedata("profile1");
    print("getfeed $data");
    if (data != null) {
      return ProfileResponse.fromJson(jsonDecode(data));
    }
  }

  profileFunlink() async {
    var data = await localdata.gethivedata("profilefunlink");
    print("getfeed $data");
    if (data != null) {
      return ProfileFunLinksModel.fromJson(jsonDecode(data));
    }
  }

  profileFollowlink() async {
    var data = await localdata.gethivedata("profileFollowlink");
    print("getfeed $data");
    if (data != null) {
      return ProfileFollowLinksModel.fromJson(jsonDecode(data));
    }
  }

 Future<HomeFeedLocal?> getHomeFeedLocalData() async {
    var data = await localdata.gethivedata("homeFeedLoginData");
    print("homeLocalfeed $data");
    if (data != null) {
      return HomeFeedLocal.fromJson(jsonDecode(data));
    }else{
      return null;
    }
  }
}
