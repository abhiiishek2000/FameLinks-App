import 'package:flutter/cupertino.dart';

import '../../models/Followsuggestionsmodel.dart';
import '../../models/followlinkExploresayhi.dart';
import '../../networking/config.dart';

class Followexploreprovider extends ChangeNotifier {
  bool loadsayhi = true;
  bool loadfollow = true;

  FollowlinkExploresayhi? followlinkExploresayhi = FollowlinkExploresayhi();
  Followsuggestionsmodel? followsuggestionsmodel = Followsuggestionsmodel();

  followlinksayhi() async {
    var res = await ApiProvider().followexploresayhi();
    if (res != null) {
      followlinkExploresayhi = res;
      loadsayhi = false;
      notifyListeners();
    }
  }

  followsuggest() async {
    var res = await ApiProvider().followexploresuggestion();
    if (res != null) {
      followsuggestionsmodel = res;
      loadfollow = false;
      notifyListeners();
    }
  }

  Future getFollowStatus(id) async {
    var result = await ApiProvider().getFoloowStatusAPI(id);
    print(result['message']);

    if (result['success'] == true) {
      followsuggest();
    }
  }
}
