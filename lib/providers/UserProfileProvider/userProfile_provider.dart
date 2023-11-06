import 'dart:convert';
import 'dart:io';

import 'package:famelink/databse/db_provider.dart';
import 'package:famelink/models/Profile_Model.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../databse/localdata.dart';
import '../../ui/otherUserProfile/model/OtherUserProfileFollowLinksModel.dart';

class UserProfileProvider extends ChangeNotifier {
  ///Base Url
  final requestBaseUrl = ApiProvider.baseUrl;

  ///Setter
  bool isLoadings = true;

  String? _resMessage = '';

  bool isFromProfilePage = false;
  bool titleWonClicked = false;
  bool trendsSetClicked = false;
  bool yourMusicClicked = false;
  bool isDrawerOpen = false;
  bool isAnimating = false;
  bool boolReadMore = false;
  bool readMoreText = false;

  //Getter
  bool get isLoading => isLoadings;

  String? get resMessage => _resMessage;

  bool get getIsFromProfilePage => isFromProfilePage;

  bool get getTitleWonClicked => titleWonClicked;

  bool get getTrendsSetClicked => trendsSetClicked;

  bool get getYourMusicClicked => yourMusicClicked;

  bool get getIsDrawerOpen => isDrawerOpen;
  bool get getIsAnimating => isAnimating;
  bool get getBoolReadMore => boolReadMore;
  bool get getReadMoreText => readMoreText;
  final ApiProvider _api = ApiProvider();

  List<OtherUserProfileFollowLinksModelResult>
      otherUserProfileFollowLinksModelResult =
      <OtherUserProfileFollowLinksModelResult>[];

  Future<List<OtherUserProfileFollowLinksModelResult>?>
      getUserProfileFollowLinks() async {
    otherUserProfileFollowLinksModelResult.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    print(" getOtherUserProfileFollowLinks(); $id");
    var result = await _api.getFameLinkOtherAPIFollowLinks(id!, 1);
    if (result != null) {
      if (result.success!) {
        otherUserProfileFollowLinksModelResult.addAll(result.result!);
        print(
            "getFameLinkOtherAPIFollowLinksl ${otherUserProfileFollowLinksModelResult.length}");
        notifyListeners();
        return otherUserProfileFollowLinksModelResult;
      } else {
        Constants.toastMessage(msg: result.message);
        return otherUserProfileFollowLinksModelResult;
      }
      // });
    }
  }

  userlocalMe({
    BuildContext? context,
  }) async {
    isLoadings = true;
    print("object=========================");
    notifyListeners();
    try {
      var req = await Localdata().gethivedata("userMe");

      if (req != null) {
        var res = json.decode(req);

        print("res1$res");
        _resMessage = "Login successfully!";

        notifyListeners();
        final mobile = res['result']['mobileNumber'];
        final isRegistered = res['result']['isRegistered'];
        ProfileResponse val = ProfileResponse.fromJson(res);
        Constants.userType = val.result!.type;
        ApiProvider.s3UrlPath = val.result!.s3!.s3UrlPath;
        ApiProvider.famelinks = val.result!.s3!.bucket!.famelinks;
        ApiProvider.funlinks = val.result!.s3!.bucket!.funlinks;
        ApiProvider.followlinks = val.result!.s3!.bucket!.followlinks;
        ApiProvider.profile = val.result!.s3!.bucket!.profile;
        ApiProvider.avatar = val.result!.s3!.bucket!.avatar;
        ApiProvider.cluboffer = val.result!.s3!.bucket!.cluboffer;
        ApiProvider.challenges = val.result!.s3!.bucket!.challenges;
        ApiProvider.trendz = val.result!.s3!.bucket!.trendz;
        notifyListeners();
        await DatabaseProvider().setMobileNumber(mobile);
        await DatabaseProvider().setIsRegistered(isRegistered);
        if (val.result!.profileImageType == "avatar") {
          print("object=========================avatar");
          await DatabaseProvider().setProfileImage(
              '${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${val.result!.profileImage}',
              'avatar');
        } else if (val.result!.profileImageType == "image") {
          print("object=========================image");
          await DatabaseProvider().setProfileImage(
              '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${val.result!.profileImage}',
              'image');
        }
        isLoadings = false;
        notifyListeners();
      } else {
        final res = json.decode(req!);

        _resMessage = res['message'];

        print(res);
        isLoadings = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      isLoadings = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      isLoadings = false;
      _resMessage = "Please try again`";
      notifyListeners();

      print(":::: $e");
    }
  }

  //Login
  userMe({
    BuildContext? context,
  }) async {
    // isLoadings = true;
    print("object=========================");
    // notifyListeners();
    final token = await DatabaseProvider().getToken();
    // dynamic token = DatabaseProvider().getToken();

    Map<String, String> hearders = {
      HttpHeaders.authorizationHeader: token.toString()
    };

    String url = "$requestBaseUrl/users/me";
    try {
      http.Response req = await http.get(Uri.parse(url), headers: hearders);

      if (req.statusCode == 200) {
        var res = json.decode(req.body);

        Localdata().sethivedata(res, "userMe");

        print("res$res");
        _resMessage = "Login successfully!";

        notifyListeners();
        final mobile = res['result']['mobileNumber'];
        final isRegistered = res['result']['isRegistered'];
        ProfileResponse val = ProfileResponse.fromJson(res);
        Constants.userType = val.result!.type;
        ApiProvider.s3UrlPath = val.result!.s3!.s3UrlPath;
        ApiProvider.famelinks = val.result!.s3!.bucket!.famelinks;
        ApiProvider.funlinks = val.result!.s3!.bucket!.funlinks;
        ApiProvider.followlinks = val.result!.s3!.bucket!.followlinks;
        ApiProvider.profile = val.result!.s3!.bucket!.profile;
        ApiProvider.avatar = val.result!.s3!.bucket!.avatar;
        ApiProvider.cluboffer = val.result!.s3!.bucket!.cluboffer;
        ApiProvider.challenges = val.result!.s3!.bucket!.challenges;
        ApiProvider.trendz = val.result!.s3!.bucket!.trendz;
        notifyListeners();
        await DatabaseProvider().setMobileNumber(mobile);
        await DatabaseProvider().setIsRegistered(isRegistered);
        if (val.result!.profileImageType == "avatar") {
          await DatabaseProvider().setProfileImage(
              '${val.result!.s3!.s3UrlPath}/${val.result!.s3!.bucket!.avatar}/${val.result!.profileImage}',
              'avatar');
        } else if (val.result!.profileImageType == "image") {
          await DatabaseProvider().setProfileImage(
              '${val.result!.s3!.s3UrlPath}/${val.result!.s3!.bucket!.profile}/${val.result!.profileImage}',
              'image');
        }
        isLoadings = false;
        notifyListeners();
      } else {
        final res = json.decode(req.body);

        _resMessage = res['message'];

        print(res);
        isLoadings = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      isLoadings = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      isLoadings = false;
      _resMessage = "Please try again`";
      notifyListeners();

      print(":::: $e");
    }
  }

  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }

  void changeIsFromProfilePage(bool value) {
    isFromProfilePage = value;
    notifyListeners();
  }

  void changeTitleWonClicked(bool value) {
    titleWonClicked = value;
    notifyListeners();
  }

  void changeTrendsSetClicked(bool value) {
    trendsSetClicked = value;
    notifyListeners();
  }

  void changeYourMusicClicked(bool value) {
    yourMusicClicked = value;
    notifyListeners();
  }

  void changeIsDrawerOpen(bool value) {
    isDrawerOpen = value;
    notifyListeners();
  }

  void changeIsAnimating(bool value) {
    print("changeIsAnimating $value");
    isAnimating = value;
    notifyListeners();
  }

  void changeBoolReadMore(bool value) {
    boolReadMore = value;
    notifyListeners();
  }

  void changeReadMoreText(bool value) {
    readMoreText = value;
    notifyListeners();
  }
}
