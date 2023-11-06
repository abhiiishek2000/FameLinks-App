import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../../dio/api/api.dart';
import '../../../../../dio/api/apimanager.dart';
import '../../../models/Brandsavetalents.dart' as brandtalent;
import '../../../models/exploretalentapplied.dart' as talentapplied;
import '../model/user_explore_model.dart';

class UserExploreProvider extends ChangeNotifier {
  int page = 1;
  ScrollController scrollCtrl = ScrollController();

  int selectedTabIndex = 0;

  int get currentTabIndex => selectedTabIndex;

  updateTabIndex(int index) {
    selectedTabIndex = index;
    searchController.clear();
    notifyListeners();
  }

  List<talentapplied.Result> appliedList = [], appliedListResult = [];
  List<talentapplied.Result> hiredList = [], hiredListResult = [];
  List<talentapplied.Result> savedList = [], savedListResult = [];
  List<talentapplied.Result> shortlistedList = [], shortlistedListResult = [];

  var requestTypeList = [
    'Applied',
    'Saved',
    'Hired',
    'Shortlisted',
  ];
  String sRequestType = 'Applied';

  updateDropdown(context, value) {
    switch (value) {
      case 'Applied':
        appliedList = appliedListResult;
        if (appliedListResult.length == 0) {
          getJobRequest(context, "appliedJobs");
        }
        break;
      case 'Saved':
        savedList = savedListResult;
        if (savedListResult.length == 0) {
          getJobRequest(context, "savedJobs");
        }
        break;
      case 'Hired':
        hiredList = hiredListResult;
        if (hiredListResult.length == 0) {
          getJobRequest(context, "hiredJobs");
        }
        break;
      case 'Shortlisted':
        shortlistedList = shortlistedListResult;
        if (shortlistedListResult.length == 0) {
          getJobRequest(context, "shortlistedJobs");
        }
        break;
    }
    sRequestType = value;
    searchController.clear();
    notifyListeners();
  }

  void getJobRequest(context, type) async {
    Map<String, dynamic> param = {
      "page": '$page',
    };
    Api.get.call(
      context,
      method: "joblinks/$type",
      param: param,
      isLoading: false,
      onResponseSuccess: (Map object) {
        var result = talentapplied.Exploretalentapplied.fromJson(
            object as Map<String, dynamic>);
        if (result.result!.length > 0) {
          switch (type) {
            case 'appliedJobs':
              appliedList = result.result!;
              appliedListResult = result.result!;
              break;
            case 'savedJobs':
              savedList = result.result!;
              savedListResult = result.result!;
              break;
            case 'hiredJobs':
              hiredList = result.result!;
              hiredListResult = result.result!;
              break;
            case 'shortlistedJobs':
              shortlistedList = result.result!;
              shortlistedListResult = result.result!;
              break;
          }
          notifyListeners();
        } else {
          page == 1 ? page : page--;
        }
      },
      onProgress: (double percentage) {},
      contentType: '',
    );
  }

  TextEditingController searchController = TextEditingController();
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

  List<brandtalent.Result> savedTalentList = [], savedTalentListResult = [];

  void getSavedTalents(BuildContext context) async {
    Map<String, dynamic> param = {
      "page": '$page',
    };
    Api.get.call(
      context,
      method: "joblinks/savedTalents",
      param: param,
      isLoading: false,
      onResponseSuccess: (Map object) {
        var result = brandtalent.Brandsavetalents.fromJson(
            object as Map<String, dynamic>);
        if (result.result!.length > 0) {
          savedTalentList = result.result!;
          savedTalentListResult = result.result!;
          notifyListeners();
        } else {
          page == 1 ? page : page--;
        }
      },
      onProgress: (double percentage) {},
      contentType: '',
    );
  }

  List<JobInvitesModel> jobInviteList = [], jobInviteListResult = [];

  void getJobInvites(BuildContext context) async {
    Map<String, dynamic> param = {
      "page": '$page',
    };
    Api.get.call(
      context,
      method: "joblinks/jobInvites",
      param: param,
      isLoading: false,
      onProgress: (double percentage) {},
      contentType: '',
      onResponseSuccess: (Map object) {
        var result = JobInvitesResult.fromJson(object as Map<String, dynamic>);
        if (result.result!.length > 0) {
          jobInviteList = result.result!;
          jobInviteListResult = result.result!;
          notifyListeners();
        } else {
          page == 1 ? page : page--;
        }
      },
    );
  }

  updateExpanded(index) {
    jobInviteList[index].expanded = !jobInviteList[index].expanded!;
    notifyListeners();
  }

  Future<void> withdrawJob(BuildContext context, id) async {
    await ApiManager.post(param: null, url1: "/joblinks/withdrawJob/$id")
        .then((value) async {
      print(value.body);
      if (value.statusCode == 200) {
        var snackBar = SnackBar(
          content: Text(jsonDecode(value.body)['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        notifyListeners();
      } else {
        print(value.body);
      }
    });
  }

  Future<void> inviteAction(context, action, id) async {
    await ApiManager.post(
      // param: null,
      url1: "joblinks/$action?jobId=$id",
    ).then((value) async {
      print(value.body);
      if (value.statusCode == 200) {
        var snackBar = SnackBar(
          content: Text(jsonDecode(value.body)['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        notifyListeners();
      } else {
        print(value.body);
      }
    });
  }

  updateList(value) {
    switch (currentTabIndex) {
      case 0:
        updateRequestList(value);
        break;
      case 1:
        savedTalentList = savedTalentListResult
            .where((e) => e.name!.toLowerCase().contains(value.toLowerCase()))
            .toList();
        break;
      case 2:
        jobInviteList = jobInviteListResult
            .where((e) => e.jobDetails![0].createdBy![0].name!
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
        break;
    }
    notifyListeners();
  }

  updateRequestList(value) {
    switch (sRequestType) {
      case "Applied":
        appliedList = appliedListResult
            .where((e) => e.createdBy![0].name!
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
        break;
      case "Saved":
        savedList = savedListResult
            .where((e) => e.createdBy![0].name!
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
        break;
      case "Hired":
        hiredList = hiredListResult
            .where((e) => e.createdBy![0].name!
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
        break;
      case "Shortlisted":
        shortlistedList = shortlistedListResult
            .where((e) => e.createdBy![0].name!
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
        break;
    }
  }

  Future<void> saveUnsaveJobs(BuildContext context, id) async {
    await ApiManager.post(
            param: null, url1: "joblinks/saveUnsaveJob/$id?action=unsave")
        .then((value) async {
      print(value.body);
      if (value.statusCode == 200) {
        //  setState(() {
        getSavedTalents(context);
        // });
        notifyListeners();
      } else {
        print(value.body);
      }
    });
  }

  String capitalize(val) {
    return val[0].toString().toUpperCase() + val.substring(1);
  }
}
