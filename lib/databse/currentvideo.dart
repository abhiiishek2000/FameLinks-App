import 'package:shared_preferences/shared_preferences.dart';

class Currentvideo {
  static setvideoindex(int index, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int ind = index % 10;
    print("srtindex $ind");
    prefs.setInt(key, ind);
  }

  Future<int?> getvideoindex(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? index = prefs.getInt(key);
    return index;
  }
}
