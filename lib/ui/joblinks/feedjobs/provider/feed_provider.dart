import 'dart:convert';

import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../dio/api/apimanager.dart';
import '../../../../networking/config.dart';
import '../../models/joblinkfeedmodel.dart' as joblinkfeed;

class JobLinksFeedProvider extends ChangeNotifier {
  Key keys = UniqueKey();
  bool isDarkMode = false;
  bool isProfileUI = false;
  bool isOnPageTurning = false;
  bool isOnPageHorizontalTurning = false;
  final ApiProvider _api = ApiProvider();
  int page = 1;
  int searchPage = 1;
  List jobList = [];

  TabController? tabController;
  int selectedTabIndex = 0;

  int get currentTabIndex => selectedTabIndex;

  updateTabIndex(int index) {
    for (var e in exploreJobList) {
      e.selectedPage = 0;
    }
    selectedTabIndex = index;
    notifyListeners();
  }

  updateExploreSlider(int index) {
    int i = exploreJobList[index].selectedPage!;
    exploreJobList[index].selectedPage = i == 0 ? 1 : 0;
    notifyListeners();
  }

  updateYourSlider(int index) {
    int i = yourJobList[index].selectedPage!;
    yourJobList[index].selectedPage = i == 0 ? 1 : 0;
    notifyListeners();
  }

  PageController pageCtrl = PageController();

  updateTalentSlider(int index) {
    int page = exploreTalentList[index].selectedPage == 1 ? 0 : 1;
    exploreTalentList[index].selectedPage = page;
    notifyListeners();
  }

  updateTalentPage(int index) {
    if (exploreTalentList[index].selectedPage == 0) {
      exploreTalentList[index].pageCtrl!.jumpToPage(1);
      notifyListeners();
    }
  }

  updatePastSlider(int index) {
    int i = pastJobList[index].selectedPage!;
    pastJobList[index].selectedPage = i == 0 ? 1 : 0;
    notifyListeners();
  }

  List list = ['Explore Jobs', 'Your Jobs', 'Explore Talents', 'Past Jobs'];
  List<joblinkfeed.ExploreJobsModel> exploreJobList = [];
  List<joblinkfeed.YourJobsModel> yourJobList = [];
  List<joblinkfeed.ExploreTalentsModel> exploreTalentList = [];
  List<joblinkfeed.PastJobsModel> pastJobList = [];

  List<joblinkfeed.JobInvite> jobForInviteList = [];

  List<Map<String, String>> ageGroup = [
    {
      'groupA': '0-4',
      'groupB': '4-12',
      'groupC': '12-18',
      'groupD': '18-28',
      'groupE': '18-28',
      'groupF': '28-40',
      'groupG': '40-50',
      'groupH': '50 -60',
      'groupI': '60+'
    }
  ];

  bool loadjob = true;

  getJobLinksFeed(page) async {
    var result = await _api.getJobLinkfeed(page);
    if (result != null) {
      print(result.toString());
      loadjob = false;
      exploreJobList = result.result!.exploreJobs ?? [];
      yourJobList = result.result!.yourJobs ?? [];
      exploreTalentList = result.result!.exploreTalents ?? [];
      pastJobList = result.result!.pastJobs ?? [];
      notifyListeners();
    }
  }

  getJobsForInvites(page, id) async {
    joblinkfeed.JobInviteResult? result = await _api.getOpenJobs(page, id);
    bool? success = result!.success;
    if (success!) {
      jobForInviteList = result.result!;
    }
    notifyListeners();
  }

  init() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    Constants.token = sharedPreferences.getString("token");
    Constants.userId = sharedPreferences.getString("id");
    notifyListeners();
  }

  changeswap(bool bul, index) {
    jobList[index].isSwipe = bul;
    notifyListeners();
  }

  // void getJobs(context, {pg}) async {
  //   jobList.clear();
  //   if (pg != null) {
  //     page = pg;
  //   }
  //   Map<String, dynamic> param = {
  //     "page": '$page',
  //   };
  //   Api.get.call(context,
  //       method: "joblinks/feed",
  //       param: param,
  //       isLoading: false, onResponseSuccess: (Map object) {
  //     var result = FameJobsModel.fromJson(object as Map<String, dynamic>);
  //     if (result.result!.length > 0) {
  //       jobList.addAll(result.result!);
  //       //  setState(() {});
  //       if (jobList != null) {
  //         for (var item in jobList) {
  //           if (item.applicationsStatus == null) {
  //             item.applicationsStatus = 'apply';
  //           }
  //         }
  //       }
  //       notifyListeners();
  //       print(jobList.length);
  //     } else {
  //       page == 1 ? page : page--;
  //     }
  //   }, onProgress: (double percentage) {}, contentType: '');
  // }

  // void getSearch(context, val) async {
  //   jobList.clear();
  //   Map<String, dynamic> param = {
  //     "page": searchPage.toString(),
  //   };
  //   try {
  //     Api.get.call(context,
  //         method: "joblinks/searchJobs/$val",
  //         param: param,
  //         isLoading: false, onResponseSuccess: (Map object) {
  //       var result = FameJobsModel.fromJson(object as Map<String, dynamic>);
  //       if (result.result!.length > 0) {
  //         jobList.addAll(result.result!);
  //
  //         if (jobList != null) {
  //           for (var item in jobList) {
  //             if (item.applicationsStatus == null) {
  //               item.applicationsStatus = 'apply';
  //             }
  //           }
  //         }
  //         notifyListeners();
  //         print(jobList.length);
  //       } else {
  //         searchPage == 1 ? searchPage : searchPage--;
  //       }
  //     }, onProgress: (double percentage) {}, contentType: '');
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  updateLoader(int index) {
    jobForInviteList[index].loader = true;
    notifyListeners();
  }

  Future<void> inviteJobs(type, id, jobID, index) async {
    Map<String, dynamic> param = {
      "jobId": jobID,
    };
    await ApiManager.post(
      param: param,
      url1: "joblinks/invitation/$type/$id?jobId=$jobID",
    ).then((value) async {
      print(value.body);
      if (value.statusCode == 200) {
        jobForInviteList[index].invitation =
            !jobForInviteList[index].invitation!;
        jobForInviteList[index].loader = !jobForInviteList[index].loader!;
        notifyListeners();
      } else {
        print(value.body);
      }
    });
  }

  Future<void> saveUnsaveJobs(action, id, index) async {
    print(id);
    await ApiManager.post(
            param: {"userId": jsonEncode(id), "save": action},
            url1: "joblinks/saveUnsaveJob/$id?action=$action")
        .then((value) async {
      print(value.body);
      if (value.statusCode == 200) {
        // setState(() {
        exploreJobList[index].savedStatus = !exploreJobList[index].savedStatus!;
        //  });
        notifyListeners();
      } else {
        print(value.body);
      }
    });
  }

  Future<void> saveUnsavetilent(bool action, String id, int index) async {
    print(id);
    await ApiManager.post(
            param: {"userId": jsonEncode(id), "save": action.toString()},
            url1: "joblinks/saveTalent")
        .then((value) async {
      print(value.body);
      if (value.statusCode == 200) {
        // setState(() {
        exploreTalentList[index].saved = !exploreTalentList[index].saved!;
        //  });
        notifyListeners();
      } else {
        print(value.body);
      }
    });
  }

  Future<void> applyJobs(context, id, index) async {
    await ApiManager.post(param: null, url1: "/joblinks/applyJob/$id")
        .then((value) async {
      print(value.body);
      if (value.statusCode == 200) {
        exploreJobList[index].isapplied = true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Job applied successfuly'),
            duration: const Duration(seconds: 2),
          ),
        );
        notifyListeners();
      } else {
        print(value.body);
      }
    });
  }

  Future<void> closeJob(context, id, index) async {
    await ApiManager.post(
      param: {'close': 'true'},
      url1: "joblinks/closeJob/$id",
    ).then((value) async {
      print(value.body);
      var result = jsonDecode(value.body);
      var success = result['success'];
      var message = result['message'];
      if (value.statusCode == 200 && success) {
        yourJobList.removeAt(index);
        getJobLinksFeed(page);
        tabController!.animateTo(3);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('$message'),
            duration: const Duration(seconds: 2),
          ),
        );
        notifyListeners();
      } else {
        print(value.body);
      }
    });
  }

  Future<void> withdrawJob(context, id, index) async {
    await ApiManager.post(param: null, url1: "/joblinks/withdrawJob/$id")
        .then((value) async {
      print(value.body);
      if (value.statusCode == 200) {
        // setState(() {
        jobList[index].applicationsStatus = 'apply';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Job withdrawn successfuly'),
            duration: const Duration(seconds: 2),
          ),
        );
        notifyListeners();
        // });
      } else {
        print(value.body);
      }
    });
  }

  String capitalize(val) {
    return val[0].toString().toUpperCase() + val.substring(1);
  }
}
