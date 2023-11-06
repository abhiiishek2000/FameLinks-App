import 'dart:convert';
import 'dart:developer';

import 'package:famelink/networking/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../dio/api/api.dart';
import '../../../../dio/api/apimanager.dart';
import '../../../../models/LocationResponse.dart';
import '../../../../models/userUpdateResponse.dart';
import '../../../../util/constants.dart';
import '../../../Famelinkprofile/function/famelinkFun.dart';
import '../../models/JobCategoriesModel.dart';

class HiringProfileProvider extends ChangeNotifier {
  List<String> complexionList = [
    'very fair',
    'fair',
    'light',
    'medium',
    'dark'
  ];
  String? sComplexion;

  updateDropdown(value) {
    sComplexion = value;
    notifyListeners();
  }

  TextEditingController interestedController = TextEditingController();

  int index = 0;
  int experienceIndex = 0;
  int ftCount = 0;
  int inCount = 0;

  final crewKey = GlobalKey<FormState>();
  final facesKey = GlobalKey<FormState>();

  final ApiProvider _api = ApiProvider();
  TextEditingController workController = TextEditingController();
  ScrollController workScrollController = ScrollController();
  TextEditingController awardsController = TextEditingController();
  ScrollController awardsScrollController = ScrollController();
  TextEditingController otherController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  ScrollController locationScrollController = ScrollController();
  List<AddressLocation> locationList = <AddressLocation>[];
  List<AddressLocation> selectedLocationList = <AddressLocation>[];
  TextEditingController famelocationController = TextEditingController();
  ScrollController famelocationScrollController = ScrollController();
  List<AddressLocation> famelocationList = <AddressLocation>[];
  List<AddressLocation> fameselectedLocationList = <AddressLocation>[];

  List<Result>? categoryList = <Result>[];
  List<Result>? categoryfacelist = <Result>[];

  // List<JobCategories> searchCategoryList = <JobCategories>[];
  // TextEditingController professionController = TextEditingController();
  List categorySelected = [];
  List<Result>? categorybehind = <Result>[];
  List<Result>? categoryface = [];
  ScrollController categoryScrollController = ScrollController();

  // List<JobCategories> fameCategoryList = <JobCategories>[];
  // List<JobCategories> fameSearchCategoryList = <JobCategories>[];
  List fameCategorySelected = []; //same
  ScrollController fameCategoryScrollController = ScrollController();

  TextEditingController ftController = TextEditingController();
  TextEditingController inController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bustController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController hipController = TextEditingController();
  TextEditingController eyeController = TextEditingController();

  // TextEditingController complexions = TextEditingController();
  List locationlist = [];
  List locationlistface = [];

  changeindex(int ind) {
    index = ind;
    notifyListeners();
  }

  selectcategory(int ind) {
    notifyListeners();
  }

  expselsect(int ind) {
    experienceIndex = ind;
    notifyListeners();
  }

  bool loasface = true;

  addcot(String val, BuildContext context, id) async {
    var data = await _api.addjobCategories(val);
    categorySelected.add(data!.result![0].sId);
    if (id == null) {
      createBTS(context);
    } else {
      updateBTS(context, id);
    }
  }

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

  init() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (ApiProvider.userType == "agency") {
      index = 1;
    }
    notifyListeners();
  }

  createFF(BuildContext context) async {
    if (sComplexion == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('select complexion'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else if (fameCategorySelected.isEmpty &&
        interestedController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Enter or select interested category'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else if (locationlistface.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Select interested location'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else {
      dynamic height = {'foot': ftController.text, 'inch': inController.text};
      print(jsonEncode(height));

      dynamic body = {
        "height": jsonEncode(height),
        "weight": weightController.text,
        "bust": bustController.text,
        "waist": waistController.text,
        "hip": hipController.text,
        "eyeColor": eyeController.text,
        "complexion": sComplexion,
        "interestCat": jsonEncode(fameCategorySelected),
        "interestedLoc": jsonEncode(locationlistface),
      };

      print(body);

      await ApiManager.post(param: body, url1: "joblinks/createProfile/faces")
          .then((value) async {
        print(value.body);
        if (value.statusCode == 200) {
          FameLinkFun provider =
              Provider.of<FameLinkFun>(context, listen: false);
          provider.init();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Profile created successfuly'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      });
    }
  }

  updateFF(BuildContext context) async {
    if (sComplexion == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('select complexion'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else if (fameCategorySelected.isEmpty &&
        interestedController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Enter or select interested category'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else if (locationlistface.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Select interested location'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else {
      dynamic height = {'foot': ftController.text, 'inch': inController.text};
      print(jsonEncode(height));

      dynamic body = {
        "height": jsonEncode(height),
        "weight": weightController.text,
        "bust": bustController.text,
        "waist": waistController.text,
        "hip": hipController.text,
        "eyeColor": eyeController.text,
        "complexion": sComplexion,
        "interestCat": jsonEncode(fameCategorySelected),
        "interestedLoc": jsonEncode(locationlistface),
      };

      print(body);

      Api.patch.call(context, method: "joblinks/profile/faces", param: body,
          onResponseSuccess: (Map object) {
        var result = UserUpdatedResponse.fromJson(object);
        print(result);
        if (result.success!) {
          FameLinkFun provider =
              Provider.of<FameLinkFun>(context, listen: false);
          provider.init();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('${result.message}'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      });
    }
  }

  createBTS(BuildContext context) async {
    if (categorySelected.isEmpty && otherController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content:
              Text('Enter profession or select profession from above list'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else if (locationlist.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Select interested location'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else {
      dynamic body = {
        "experienceLevel": experienceIndex == 0 ? 'fresher' : 'experienced',
        "workExperience": workController.text,
        "achievements": awardsController.text,
        "interestCat": jsonEncode(categorySelected),
        "interestedLoc": jsonEncode(locationlist),
      };

      await ApiManager.post(param: body, url1: "joblinks/createProfile/crew")
          .then((value) async {
        print(value.body);
        if (value.statusCode == 200) {
          FameLinkFun provider =
              Provider.of<FameLinkFun>(context, listen: false);
          provider.init();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Profile created successfuly'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      });
    }
  }

  updateBTS(BuildContext context, id) async {
    if (categorySelected.isEmpty && otherController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content:
              Text('Enter profession or select profession from above list'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else if (locationlist.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Select interested location'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else {
      dynamic body = {
        "experienceLevel": experienceIndex == 0 ? 'fresher' : 'experienced',
        "workExperience": workController.text,
        "achievements": awardsController.text,
        "interestCat": jsonEncode(categorySelected),
        "interestedLoc": jsonEncode(locationlist),
      };

      Api.patch.call(context, method: "joblinks/profile/crew", param: body,
          onResponseSuccess: (Map object) {
        var result = UserUpdatedResponse.fromJson(object);
        print(result);
        if (result.success!) {
          FameLinkFun provider =
              Provider.of<FameLinkFun>(context, listen: false);
          provider.init();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('${result.message}'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      });
    }
  }
}
