import 'package:famelink/networking/config.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:famelink/models/contestant_model.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../dio/api/api.dart';

class ContestantProvider extends ChangeNotifier {
  List<String> recommendedItems = [
    'Recommended',
    'Trending',
    'New',
  ];
  List<String> recommendedItems2 = [
    'Your District',
    'Your State',
    'Your Country',
    'World'
  ];

  List<String> ageItems = [
    "0-4",
    "4-12",
    "12-18",
    "18-28",
    "28-40",
    "40-50",
    "50-60",
    "60+"
  ];

  final ApiProvider _api = ApiProvider();
  List<Result> myFameResult = [];
  List<String> countryList = [];
  List<String> stateList = [];
  List<String> districtList = [];
  int selectedTab = 0;
  int selectedTab2 = 0;
  int selectedAge = -1;
  int page = 1;
  int val = -1;
  int genderIndex = -1;
  String type = "recommended";
  String district = "";
  String state = "";
  String country = "";
  String continent = "";
  String gender = "";
  String ageGroup = "";
  String? selectedContinent;
  String? selectedCountry;
  String? selectedState;
  String? selectedDistrict;
  final GlobalKey childKey = GlobalKey();
  bool isHeightCalculated = false;
  double height = 454;
  bool silverCollapsed = false;
  ScrollController contestantScrollController = ScrollController();
  PageController pageController = PageController(keepPage: true);
  NativeAd? _ad;
  bool isLoading = false;
  // TODO: Add _isAdLoaded
  bool _isAdLoaded = false;

  void myFamelinks(BuildContext context) async {
    Map<String, dynamic> params = {
      "page": '$page',
    };
    if (type.isNotEmpty) {
      params.putIfAbsent("type", () => type);
    }
    if (district.isNotEmpty) {
      params.putIfAbsent("district", () => district);
    }
    if (state.isNotEmpty) {
      params.putIfAbsent("state", () => state);
    }
    if (country.isNotEmpty) {
      params.putIfAbsent("country", () => country);
    }
    if (continent.isNotEmpty) {
      params.putIfAbsent("continent", () => continent);
    }
    if (gender.isNotEmpty) {
      params.putIfAbsent("gender", () => gender);
    }
    if (ageGroup.isNotEmpty) {
      params.putIfAbsent("ageGroup", () => ageGroup);
    }
    isLoading = true;
    notifyListeners();
    Api.get.call(context,
        method: "users/contestants",
        param: params,
        isLoading: false, onResponseSuccess: (Map<dynamic, dynamic> object) {
      var result = ContestantResponse.fromJson(object);
      isLoading = false;
      myFameResult = result.result!;
      notifyListeners();
    });
  }

  void moreFamelinks(BuildContext context) async {
    Map<String, dynamic> params = {
      "page": '$page',
    };
    if (type.isNotEmpty) {
      params.putIfAbsent("type", () => type);
    }
    if (district.isNotEmpty) {
      params.putIfAbsent("district", () => district);
    }
    if (state.isNotEmpty) {
      params.putIfAbsent("state", () => state);
    }
    if (country.isNotEmpty) {
      params.putIfAbsent("country", () => country);
    }
    if (continent.isNotEmpty) {
      params.putIfAbsent("continent", () => continent);
    }
    if (gender.isNotEmpty) {
      params.putIfAbsent("gender", () => gender);
    }
    if (ageGroup.isNotEmpty) {
      params.putIfAbsent("ageGroup", () => ageGroup);
    }
    isLoading = true;
    notifyListeners();
    Api.get.call(context,
        method: "users/contestants",
        param: params,
        isLoading: false, onResponseSuccess: (Map object) {
      var result = ContestantResponse.fromJson(object);
      if (result.result!.length > 0) {
        isLoading = false;
        myFameResult.addAll(result.result!);
        notifyListeners();
        print('RESPONSE ${result.result.toString()}');
      } else {
        page--;
        isLoading = false;
        notifyListeners();
      }
    });
  }

  void getCountry(BuildContext context) async {
    bool internet = await Constants.isInternetAvailable();
    if (internet) {
      Constants.progressDialog(true, context);
      var result = await _api.getCountry(selectedContinent!);
      if (result != null) {
        Constants.progressDialog(false, context);
        if (result.success!) {
          countryList = result.result!.countries!;
         notifyListeners();
        } else {
          countryList = [];
          notifyListeners();
          Constants.toastMessage(msg: result.message);
        }
      }
    }
  }

  void getStates(BuildContext context) async {
    bool internet = await Constants.isInternetAvailable();
    if (internet) {
      Constants.progressDialog(true, context);
      var result = await _api.getStates(selectedCountry!);
      if (result != null) {
        Constants.progressDialog(false, context);
        if (result.success!) {
          stateList = result.result!.states!;
          notifyListeners();
        } else {
          stateList = [];
          notifyListeners();
          Constants.toastMessage(msg: result.message);
        }
      }
    }
  }

  void getDistrict(BuildContext context) async {
    bool internet = await Constants.isInternetAvailable();
    if (internet) {
      Constants.progressDialog(true, context);
      var result = await _api.getDistrict(selectedCountry!, selectedState!);
      if (result != null) {
        Constants.progressDialog(false, context);
        if (result.success!) {
          districtList = result.result!.districts!;
          notifyListeners();
        } else {
          districtList = [];
          notifyListeners();
          Constants.toastMessage(msg: result.message);
        }
      }
    }
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }
 void changeSilverCollapsed(bool value){
   silverCollapsed = value;
   notifyListeners();
 }
 void changeIsHeightCalculated(bool value){
   isHeightCalculated = value;
   notifyListeners();
 }
 void changeHeight(double value){
   height = value;
   notifyListeners();
 }
 void changeSelectedTab(int value){
   selectedTab = value;
   notifyListeners();
 }
 void changeSelected2Tab(int value){
   selectedTab2 = value;
   notifyListeners();
 }
 void changeType(String value){
   type = value;
   notifyListeners();
 }
 void changeDistrict(String value){
   district = value;
   notifyListeners();
 }
 void changeState(String value){
   state = value;
   notifyListeners();
 }
 void changeCountry(String value){
   country = value;
   notifyListeners();
 } void changeSelectedCountry(String value){
   selectedCountry = value;
   notifyListeners();
 }
  void changeSelectedState(String value){
    selectedState = value;
    notifyListeners();
  }
 void changeContinent(String value){
   continent = value;
   notifyListeners();
 } void changeSelectedContinent(String value){
    selectedContinent = value;
   notifyListeners();
 }
  void changeSelectedDistrict(String value){
    selectedDistrict = value;
    notifyListeners();
  }
 void changeAgeGroup(String value){
   ageGroup = value;
   notifyListeners();
 }
 void changeGender(String value){
   gender = value;
   notifyListeners();
 }
 void changeAge(int value){
   selectedAge = value;
   notifyListeners();
 }
 void changVal(int value){
   val = value;
   notifyListeners();
 }
 void changGenderIndex(int value){
   genderIndex = value;
   notifyListeners();
 }
void resetAll(){
  selectedAge = -1;
  genderIndex = -1;
  ageGroup = "";
  gender = "";
  val = -1;
  selectedContinent = null;
  selectedCountry = null;
  selectedState = null;
  selectedDistrict = null;
  notifyListeners();
}
}
