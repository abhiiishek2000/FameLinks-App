import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  String _token = '';
  bool isRegistered = false;

  String _userId = '';

  String get token => _token;

  String get userId => _userId;

  saveToken(String token) async {
    SharedPreferences value = await _pref;

    value.setString('token', token);
    //print("neifwejfojwef$token");
  }

  void saveUserId(String id) async {
    SharedPreferences value = await _pref;

    value.setString('id', id);
  }

  void setIsLoggedIn(bool? isLoggedIn) async {
    SharedPreferences value = await _pref;

    value.setBool('isLoggedIn', isLoggedIn!);
  }

  void setIsFirstLoggedIn(bool isFirstLoggedIn) async {
    SharedPreferences value = await _pref;

    value.setBool('isFirstLoggedIn', isFirstLoggedIn);
  }

  setMobileNumber(int mobileNumber) async {
    SharedPreferences value = await _pref;

    value.setInt('mobileNumber', mobileNumber);
  }

  setIsRegistered(bool isRegistered) async {
    SharedPreferences value = await _pref;

    value.setBool('isRegistered', isRegistered);
  }

  setProfileImage(String profileImage, String type) async {
    SharedPreferences value = await _pref;
    if (type == "avatar") {
      value.setString('avatar', profileImage);
    } else {
      value.setString('image', profileImage);
    }

    //print("neifwejfojwef$token");
  }

  Future<String> getProfileImage() async {
    SharedPreferences value = await _pref;

    if (value.containsKey("avatar") == true) {
      if (value.containsKey('avatar')) {
        String data = value.getString('avatar')!;
        _token = data;
        notifyListeners();
        return data;
      } else {
        _token = '';
        notifyListeners();
        return '';
      }
    } else {
      if (value.containsKey('image')) {
        String data = value.getString('image')!;
        _token = data;
        notifyListeners();
        return data;
      } else {
        _token = '';
        notifyListeners();
        return '';
      }
    }
    return '';
  }

  Future<bool> getisRegistered() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('isRegistered')) {
      bool data = value.getBool('isRegistered')!;
      isRegistered = data;
      notifyListeners();
      return data;
    } else {
      isRegistered = false;
      notifyListeners();
      return false;
    }
  }

  Future<String> getToken() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('token')) {
      String data = value.getString('token')!;
      _token = data;
      notifyListeners();
      return data;
    } else {
      _token = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getUserId() async {
    SharedPreferences value = await _pref;
    if (value.containsKey('id')) {
      String data = value.getString('id')!;
      _userId = data;
      notifyListeners();
      return data;
    } else {
      _userId = '';
      notifyListeners();
      return '';
    }
  }

  void logOut(BuildContext context) async {
    final value = await _pref;

    value.clear();

    // PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
  }

  void prefClear(BuildContext context) async {
    final value = await _pref;

    value.clear();

    // PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
  }

  void setIsTourShown(bool isTourShown) async {
    SharedPreferences value = await _pref;

    value.setBool('isTourShown', isTourShown);
  }

  void setIsFameLinksTourShown(bool isTourShown) async {
    SharedPreferences value = await _pref;

    value.setBool('isFameLinksTourShown', isTourShown);
  }

  void setIsFunLinksTourShown(bool isTourShown) async {
    SharedPreferences value = await _pref;

    value.setBool('isFunLinksTourShown', isTourShown);
  }

  void setIsFollowLinksTourShown(bool isTourShown) async {
    SharedPreferences value = await _pref;

    value.setBool('isFollowLinksTourShown', isTourShown);
  }

  Future<bool> getIsTourShown() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('isTourShown')) {
      bool data = value.getBool('isTourShown')!;
      notifyListeners();
      return data;
    } else {
      notifyListeners();
      return false;
    }
  }

  Future<bool> getIsFameLinksTourShown() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('isFameLinksTourShown')) {
      bool data = value.getBool('isFameLinksTourShown')!;
      notifyListeners();
      return data;
    } else {
      notifyListeners();
      return false;
    }
  }

  Future<bool> getIsFunLinksTourShown() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('isFunLinksTourShown')) {
      bool data = value.getBool('isFunLinksTourShown')!;
      notifyListeners();
      return data;
    } else {
      notifyListeners();
      return false;
    }
  }

  Future<bool> getIsFollowLinksTourShown() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('isFollowLinksTourShown')) {
      bool data = value.getBool('isFollowLinksTourShown')!;
      notifyListeners();
      return data;
    } else {
      notifyListeners();
      return false;
    }
  }
}
