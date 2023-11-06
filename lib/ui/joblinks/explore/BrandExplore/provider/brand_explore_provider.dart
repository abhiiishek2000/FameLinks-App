import 'package:famelink/dio/api/api.dart';
import 'package:famelink/ui/joblinks/jobController.dart';
import 'package:famelink/ui/joblinks/models/BrandAgencyExplore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandExploreProvider extends ChangeNotifier {
  JobController controller = Get.put(JobController());

  int page = 1;

  ScrollController scrollCtrl = ScrollController();
  TextEditingController searchCtrl = TextEditingController();

  List<ProfileModel> profileList = [], profileListResult = [];
  List<SavedModel> savedTalentList = [], savedTalentListResult = [];

  int selectedTabIndex = 0;

  int get currentTabIndex => selectedTabIndex;

  updateTabIndex(int index) {
    selectedTabIndex = index;
    searchCtrl.clear();
    notifyListeners();
  }

  updateList(value) {
    switch (currentTabIndex) {
      case 0:
        profileList = profileListResult
            .where((e) => e.name!.toLowerCase().contains(value.toLowerCase()))
            .toList();
        savedTalentList = savedTalentListResult
            .where((e) => e.name!.toLowerCase().contains(value.toLowerCase()))
            .toList();
        break;
      case 1:
        profileList = profileListResult
            .where((e) => e.name!.toLowerCase().contains(value.toLowerCase()))
            .toList();
        break;
      case 2:
        savedTalentList = savedTalentListResult
            .where((e) => e.name!.toLowerCase().contains(value.toLowerCase()))
            .toList();
        break;
    }
    notifyListeners();
  }

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

  @override
  bool get wantKeepAlive => true;

  String capitalize(val) {
    return val[0].toString().toUpperCase() + val.substring(1);
  }

  void getData(BuildContext context, val) async {
    Map<String, dynamic> param = {
      "page": '$page',
      "search": val,
    };

    Api.get.call(context,
        method: "joblinks/explore/brandAgency",
        param: param,
        contentType: "application/x-www-form-urlencoded",
        isLoading: false, onResponseSuccess: (Map<dynamic, dynamic> object) {
      var result = BrandAgencyModel.fromJson(object);
      if (result.success!) {
        profileList = result.result!.profiles ?? [];
        profileListResult = result.result!.profiles ?? [];
        print(result.result!.savedTalents.toString());
        savedTalentList = result.result!.savedTalents ?? [];
        savedTalentListResult = result.result!.savedTalents ?? [];
        notifyListeners();
      } else {
        page == 1 ? page : page--;
      }
    });
  }
}
