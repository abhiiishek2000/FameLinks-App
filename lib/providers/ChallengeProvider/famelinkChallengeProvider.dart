import 'package:famelink/models/ChallengeSlider.dart';
import 'package:famelink/models/MyFunLinksResponse.dart';
import 'package:famelink/models/OpenChallengesResponse.dart';
import 'package:famelink/models/WinnersModel.dart';
import 'package:famelink/models/upcoming_challenges_model.dart';
import 'package:flutter/material.dart';

import '../../models/AddRatingResponse.dart';

class ChallengeScreenProvider extends ChangeNotifier {
  List<OpenChallengesResult> openChallengesResult = [];
  List<BannerImage> openChallengesBanner = [];
  List<BannerImage> upcomingChallengesBanner = [];
  List<UpcomingChallengesResult> upcomingChallengesResult = [];
  List<WinnersResult> winnersResult = [];
  bool loading = false;
  PageController pageController = PageController(keepPage: true);
  PageController upComingPageController = PageController(keepPage: true);
  PageController pageDetailController = PageController(keepPage: true);
  String ageGroup = 'groupE';
  int endTime = 0;
  List<MyFunLinksResult> challengeList = [];
  bool isOnPageTurning = false;

  List<OpenChallengesResult> get getPostsOfChallenge {
    return openChallengesResult;
  }

  void changePostsOfChallenge(List<OpenChallengesResult> value) {
    openChallengesResult = value;
    notifyListeners();
  }
 void updateRatingStatus(OpenChallengesResult value,AddRatingResponseResult status, int index){
   openChallengesResult.removeAt(index);
   OpenChallengesResult result = value;
   result.rating =status;
   openChallengesResult.insert(index, value);
   notifyListeners();
 }
  List<BannerImage> get getChallengeSlider {
    return openChallengesBanner;
  }

  void changeChallengeSlider(List<BannerImage> value) {
    openChallengesBanner = value;
    notifyListeners();
  }

  List<BannerImage> get getUpcomingChallengesBanner {
    return upcomingChallengesBanner;
  }

  void changeUpcomingChallengesBanner(List<BannerImage> value) {
    upcomingChallengesBanner = value;
    notifyListeners();
  }

  List<UpcomingChallengesResult> get getUpcomingChallengesResult {
    return upcomingChallengesResult;
  }

  void changeUpcomingChallengesResult(List<UpcomingChallengesResult> value) {
    upcomingChallengesResult = value;
    notifyListeners();
  }


  List<WinnersResult> get getWinnersResult {
    return winnersResult;
  }

  void changeWinnersResult(List<WinnersResult> value) {
    winnersResult = value;
    notifyListeners();
  }

  PageController get getPageController {
    return pageController;
  }

  void changePageController(PageController value) {
    pageController = value;
    notifyListeners();
  }

  PageController get getPageDetailController {
    return pageDetailController;
  }

  void changePageDetailController(PageController value) {
    pageDetailController = value;
    notifyListeners();
  }

  PageController get getUpComingPageController {
    return upComingPageController;
  }

  void changeUpComingPageController(PageController value) {
    upComingPageController = value;
    notifyListeners();
  }

  bool get getLoading {
    return loading;
  }

  void changeLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  String get getAgeGroup {
    return ageGroup;
  }

  void changeAgeGroup(String value) {
    ageGroup = value;
    notifyListeners();
  }

  int get getEndTime {
    return endTime;
  }

  void changeEndTime(int value) {
    endTime = value;
    notifyListeners();
  }

  List<MyFunLinksResult> get getChallengeList {
    return challengeList;
  }

  void changeChallengeList(List<MyFunLinksResult> value) {
    challengeList = value;
    notifyListeners();
  }

  bool get getIsOnPageTurning {
    return isOnPageTurning;
  }

  void changeIsOnPageTurning(bool value) {
    isOnPageTurning = value;
    notifyListeners();
  }
}
