import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:famelink/ui/joblinks/models/JobCategoriesModel.dart';

import '../../../../networking/config.dart';
import '../../../../util/constants.dart';

class Professionpro extends ChangeNotifier {
  TextEditingController otherController = TextEditingController();

  List<Result>? categoryList = <Result>[];
  List<Result>? categoryfacelist = <Result>[];
  // List<JobCategories> searchCategoryList = <JobCategories>[];
  // TextEditingController professionController = TextEditingController();
  List categorySelected = []; //ttt
  List<Result>? categorybehind = <Result>[];
  List<Result>? categoryface = [];
  final ApiProvider _api = ApiProvider();

  selectcategory(int ind) {
    notifyListeners();
  }

  searchCategories(String query, type) {
    // setState(() async {
    if (query.isNotEmpty) {
      if (type == 'crew') {
        categorybehind = [];
        print("search query2 ${categoryList!.length}");
        categoryList!.forEach((item) {
          if (item.jobName!.toLowerCase().contains(query.toLowerCase())) {
            // setState(() {
            log(item.jobName.toString());
            categorybehind!.add(item);

            // for (var item in categoryList) {
            //   for (var selectedItem in categorySelected) {
            //     // if (selectedItem.id!.contains(item.id!)) {
            //     //   item.isSelected = selectedItem.isSelected;
            //     // }
            //   }
            // }
            //   });
          }
          notifyListeners();
        });
      } else {
        categoryface = [];
        categoryfacelist!.forEach((item) {
          if (item.jobName!.toLowerCase().contains(query.toLowerCase())) {
            // setState(() {
            categoryface!.add(item);
            // for (var item in facesCategoryList) {
            //   for (var selectedItem in facesCategorySelected) {
            //     if (selectedItem.id!.contains(item.id!)) {
            //       item.isSelected = selectedItem.isSelected;
            //     }
            //   }
            // }
            // });
          }
          notifyListeners();
        });
      }
    } else {
      categoryface = categoryfacelist;
      categorybehind = categoryList;
      notifyListeners();
    }
    // });
  }

  bool loasface = true;
  getfaceCategories() async {
    var result = await _api.getCategories("faces");
    if (result != null) {
      if (result.success!) {
        categoryfacelist = result.result;
        categoryface = result.result;

        loasface = false;
        notifyListeners();
      } else {
        Constants.toastMessage(msg: result.message!);
        return categoryfacelist;
      }
    }
  }

  getCategories() async {
    var result = await _api.getCategories("crew");
    if (result != null) {
      if (result.success!) {
        categoryList = result!.result;
        categorybehind = result!.result;

        notifyListeners();
      } else {
        Constants.toastMessage(msg: result.message!);
        return categoryList;
      }
    }
  }
}
