import 'package:famelink/models/LocationResponse.dart';
import 'package:flutter/material.dart';

class UserEditProfileProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  String? locationState;
  String? locationDistrict;
  String? locationCountry;
  String? updateUserName;
  bool isShowDropDown = false;
  List<AddressLocation> locationList = <AddressLocation>[];
  Key key = UniqueKey();
  String? isValidNickName = '0';

  TextEditingController get getName => nameController;

  TextEditingController get getDOB => dobController;

  TextEditingController get getProfession => professionController;

  TextEditingController get getUserName => userNameController;

  TextEditingController get getBio => bioController;

  TextEditingController get getPlace => placeController;

  String? get getLocationState => locationState;

  String? get getLocationDistrict => locationDistrict;

  String? get getLocationCountry => locationCountry;

  String? get getUpdateUserName => updateUserName;

  String? get getIsValidNickName => isValidNickName;

  bool get getIsShowDropDown => isShowDropDown;

  List<AddressLocation> get getLocationList => locationList;

  Key get getKey => key;

  changeNameResult(TextEditingController value) {
    nameController = value;
    notifyListeners();
  }

  changeDOBResult(TextEditingController value) {
    dobController = value;
    notifyListeners();
  }

  changeProfessionResult(TextEditingController value) {
    professionController = value;
    notifyListeners();
  }

  changeUserNameResult(TextEditingController value) {
    userNameController = value;
    notifyListeners();
  }

  changeBoiResult(TextEditingController value) {
    bioController = value;
    notifyListeners();
  }

  changePlaceResult(TextEditingController value) {
    placeController = value;
    notifyListeners();
  }

  changeLocationState(String value) {
    locationState = value;
    notifyListeners();
  }

  changeLocationDistrict(String value) {
    locationDistrict = value;
    notifyListeners();
  }

  changeLocationCountry(String value) {
    locationCountry = value;
    notifyListeners();
  }

  changeUpdateUserName(String value) {
    updateUserName = value;
    notifyListeners();
  }

  changeIsValidNickName(String value) {
    isValidNickName = value;
    notifyListeners();
  }

  changeIsShowDropDown(bool value) {
    isShowDropDown = value;
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
