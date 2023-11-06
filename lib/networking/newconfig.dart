import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../nativeads/Nativeadsapp.dart';
import '../ui/otherUserProfile/model/FameLinkUserProfileModel.dart';
import '../ui/otherUserProfile/model/FollowLinkUserProfileModel.dart';
import '../ui/otherUserProfile/model/FunLinkUserProfileModel.dart';
import 'config.dart';

class NewApiProvider {
  ApiProvider api = ApiProvider();

  Future<FameLinkUserProfileModel?> getSharefamelink(String id,String? userid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    Response response = await api.dio.get(
      "media/followlinks?page=&followlinks=next",
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: token,
        },
      ),
    );
    log("getFollowLinkProfileAPI ${response.data}");
    if (response.data['result'].length > 0) {
      api.fameads.addAll(response.data['result']);
      // log("logfameads ${fameads.length}");
      for (var i = 0; i < api.fameads.length; i++) {
        if (i % 6 == 0 &&
            api.fameads[i]['media'][0]['type'] != "ads" &&
            i != 0) {
          api.mydata.insert(i, NativeadsApp.adslist);
          api.mydata.add(api.fameads[i]);
        } else {
          api.mydata.add(api.fameads[i]);
        }
      }
      log("am123 $api.mydata");
      Map<String, dynamic> data1 = {"result": api.mydata};

      return FameLinkUserProfileModel.fromJson(data1);
    }
    return null;
  }

  Future<FunLinkUserProfileModel?> getSharefunlink(String id,String? userid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    Response response = await api.dio.get(
      "media/followlinks?page=&followlinks=next",
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: token,
        },
      ),
    );
    log("getFollowLinkProfileAPI ${response.data}");
    if (response.data['result'].length > 0) {
      api.funads.addAll(response.data['result']);

      for (var i = 0; i < api.funads.length; i++) {
        if (i % 6 == 0 &&
            api.funads[i]['media'][0]['type'] != "ads" &&
            i != 0) {
          api.fundata.insert(i, NativeadsApp.funadslist);

          api.fundata.add(api.funads[i]);
        } else {
          api.fundata.add(api.funads[i]);
        }
      }
      log("am123 ${api.fundata}");
      Map<String, dynamic> data1 = {"result": api.fundata};

      return FunLinkUserProfileModel.fromJson(data1);
    }
    return null;
  }

  Future<FollowLinkUserProfileModel?> getSharefollowlink(String id,String? userid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    Response response = await api.dio.get(
      "media/followlinks?page=&followlinks=next",
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: token,
        },
      ),
    );
    log("getFollowLinkProfileAPI ${response.data}");
    if (response.data['result'].length > 0) {
      api.followads.addAll(response.data['result']);

      for (var i = 0; i < api.followads.length; i++) {
        if (i % 6 == 0 &&
            api.followads[i]['media'][0]['type'] != "ads" &&
            i != 0) {
          api.followdata.insert(i, NativeadsApp.adslist);

          api.followdata.add(api.followads[i]);
        } else {
          api.followdata.add(api.followads[i]);
        }
      }

      Map<String, dynamic> data1 = {"result": api.followdata};

      return FollowLinkUserProfileModel.fromJson(data1);
    }
    return null;
  }
}
