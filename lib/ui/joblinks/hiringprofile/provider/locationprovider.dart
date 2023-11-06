import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/LocationResponse.dart';
import '../../../../networking/config.dart';
import '../../../../providers/UserProfileProvider/edit_user_profile_provider.dart';
import '../../../../util/constants.dart';

class Locationpro extends ChangeNotifier {
  final ApiProvider _api = ApiProvider();
  List<AddressLocation> locationList = <AddressLocation>[];
  TextEditingController get getPlace => placeController;
  TextEditingController placeController = TextEditingController();
  Key key = UniqueKey();

  bool isShowDropDown = false;
  changeIsShowDropDown(bool value) {
    getLocationList.clear();
    notifyListeners();
  }

  String? locationState;
  String? locationDistrict;
  String? locationCountry;
  String? updateUserName;

  List<AddressLocation> get getLocationList => locationList;

  Future<List<AddressLocation>?> getLocation(String query) async {
    var result = await _api.getLocation(query);

    if (result != null) {
      debugPrint("111-111-111-111- Result ${result.toString()}");
      if (result.success == true) {
        locationList.clear();
        debugPrint("222-222-222-222- Result ${result.toString()}");
        locationList.addAll(result.result!);
        changeKey(UniqueKey());
        return getLocationList;
      } else {
        Constants.toastMessage(msg: result.message);
        return getLocationList;
      }
    }
  }

  changeLocationDistrict(String value) {
    locationDistrict = value;
    notifyListeners();
  }

  changeLocationState(String value) {
    locationState = value;
    notifyListeners();
  }

  changeLocationCountry(String value) {
    locationCountry = value;
    notifyListeners();
  }

  changeLocationList(List<AddressLocation> value) {
    locationList = value;
    notifyListeners();
  }

  changeKey(Key value) {
    key = value;
    notifyListeners();
  }
}
