import 'package:famelink/ui/otherUserProfile/model/FameLinkUserProfileModel.dart';
import 'package:flutter/foundation.dart';

import '../../databse/fetchlocaldata.dart';
import '../../ui/fameLinks/provider/FameLinksFeedProvider.dart';

class Localdataprovider extends ChangeNotifier {
  Fetchlocaldata fetchlocaldata = Fetchlocaldata();
  getFamlink() async {
    var result1 = await fetchlocaldata.famlinklocal();

    FameLinkUserProfileModel? model = result1;
    print("localdata  $result1");

    notifyListeners();
    // fameLinkUserProfileModel = model;
  }
}
