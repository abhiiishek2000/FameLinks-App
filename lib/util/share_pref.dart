import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static final AppPreference _appPreference = AppPreference._internal();

  factory AppPreference() {
    return _appPreference;
  }

  AppPreference._internal();

  late SharedPreferences _preferences;

  Future<void> initialAppPreference() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future clear() async {
    await _preferences.clear();
  }

  Future setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  String getString(String key, {String defValue = ''}) {
    return _preferences.getString(key) != null
        ? (_preferences.getString(key) ?? '')
        : defValue;
  }

  Future setBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  bool getBool(String key, {bool defValue = false}) {
    return _preferences.getBool(key) ?? defValue;
  }

  Future clearSharedPreferences() async {
    await _preferences.clear();
  }

}