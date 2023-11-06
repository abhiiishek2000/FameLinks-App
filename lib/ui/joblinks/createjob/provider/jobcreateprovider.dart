import 'dart:convert';

import 'package:famelink/dio/api/apimanager.dart';
import 'package:famelink/models/LocationResponse.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/joblinks/createjob/provider/professionpro.dart';
import 'package:famelink/ui/joblinks/models/JobCategoriesModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../dio/api/api.dart';
import '../../../../models/userUpdateResponse.dart';
import '../../../../util/constants.dart';
import '../../feedjobs/provider/feed_provider.dart';

class JobCreateprovider extends ChangeNotifier {
  int index = 0;
  int experienceIndex = 0;
  int genderIndex = 0;
  static final crewKey = GlobalKey<FormState>();
  static final facesKey = GlobalKey<FormState>();
  TextEditingController facetitleController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController facedescriptionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController facesstartController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController facesendController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController facestotalController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController facesdeadlineController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  TextEditingController facesotherController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  List<String> footList = ["4", "5", "6", "7", "8"];
  String? sFoot;
  List<String> inchList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11"
  ];
  String? sInch;

  // TextEditingController ftController = TextEditingController();
  // TextEditingController inController = TextEditingController();
  List selectedIndex = [];
  List<Map<String, String>> ageGroup1 = [
    {
      'groupA': '0 - 4',
      'groupB': '4 - 12',
      'groupC': '12 - 18',
      'groupD': '18 - 28',
      'groupE': '28 - 40',
      'groupF': '40 - 60',
      'groupG': '50 - 60',
      'groupH': '60+',
    }
  ];
  List ageGroup = [
    '0 - 4',
    '4 - 12',
    '12 - 18',
    '18 - 28',
    '28 - 40',
    '40 - 60',
    '50 - 60',
    '60+'
  ];
  String? ageSelected;
  int ftCount = 0;
  int inCount = 0;

  final ApiProvider _api = ApiProvider();
  TextEditingController locationController = TextEditingController();
  ScrollController locationScrollController = ScrollController();
  List<AddressLocation> locationList = <AddressLocation>[];
  dynamic selectedLocation;

  TextEditingController famelocationController = TextEditingController();
  ScrollController famelocationScrollController = ScrollController();
  List<AddressLocation> famelocationList = <AddressLocation>[];
  dynamic facesselectedLocation;

  JobCategoriesModel? categoryList;
  List searchCategoryList = [];
  TextEditingController professionController = TextEditingController();
  List categorySelected = [];
  ScrollController categoryScrollController = ScrollController();

  List facesCategoryList = [];
  List facesSearchCategoryList = [];
  TextEditingController facesprofessionController = TextEditingController();
  List facesCategorySelected = [];
  ScrollController facesCategoryScrollController = ScrollController();

  getAddressLocation(String query, isFrom) async {
    // setState(() async {
    // List<AddressLocation> matches = <AddressLocation>[];
    if (query.length >= 3) {
      return await getLocation(query, isFrom);
    } else {
      // return matches;
    }
    notifyListeners();
    // });
  }

  changeexperienceIndex(int ind) {
    experienceIndex = ind;
    notifyListeners();
  }

  changeage(String ind) {
    ageSelected = ind;
    notifyListeners();
  }

  changeFoot(String s) {
    sFoot = s;
    notifyListeners();
  }

  changeInch(String s) {
    sInch = s;
    notifyListeners();
  }

  changegender(int val) {
    genderIndex = val;
    notifyListeners();
  }

  selectcot(int ind) {
    print(ind);
    notifyListeners();
  }

  // Future<List<AddressLocation>?>
  getLocation(String query, isFrom) async {
    // setState(() async {
    var result = await _api.getLocation(query);
    if (result != null) {
      if (result.success!) {
        //  setState(() {
        if (isFrom == 'crew') {
          locationList.addAll(result.result!);
          // return locationList;
        } else {
          famelocationList.addAll(result.result!);
          // return famelocationList;
        }
        //  });
      } else {
        Constants.toastMessage(msg: result.message!);
        // return locationList;
      }
    }
    notifyListeners();
    //  });
  }

  addcotface(String val, BuildContext context, String id) async {
    var data = await _api.addjobCategories(val);
    categorySelected.add(data!.result![0].sId);

    if (id == null) {
      createFaces(context);
    } else {
      updateFaces(context, id);
    }
  }

  addcotcrew(String val, BuildContext context, String id) async {
    var data = await _api.addjobCategories(val);
    facesCategorySelected.add(data!.result![0].sId);
    if (id == null) {
      createCrew(context);
    } else {
      updateCrew(context, id);
    }
  }

  searchCategories(String query, type) {
    // setState(() async {
    if (query.isNotEmpty) {
      if (type == 'crew') {
        //categoryList.clear();
        for (var item in searchCategoryList) {
          if (item.jobName!.toLowerCase().contains(query.toLowerCase())) {
            // setState(() {
            // categoryList.add(item);
            // for (var item in categoryList) {
            //   for (var selectedItem in categorySelected) {
            //     // if (selectedItem.id!.contains(item.id!)) {
            //     //   item.isSelected = selectedItem.isSelected;
            //     // }
            //   }
            // }
            //   });
          }
        }
      } else {
        facesCategoryList.clear();
        for (var item in facesSearchCategoryList) {
          if (item.jobName!.toLowerCase().contains(query.toLowerCase())) {
            // setState(() {
            facesCategoryList.add(item);
            for (var item in facesCategoryList) {
              for (var selectedItem in facesCategorySelected) {
                if (selectedItem.id!.contains(item.id!)) {
                  item.isSelected = selectedItem.isSelected;
                }
              }
            }
            // });
          }
        }
      }
      notifyListeners();
    } else {
      getCategories();
    }
    // });
  }

  // Future<List<JobCategories>>
  getCategories() async {
    // categoryList.clear();
    searchCategoryList.clear();
    var result = await _api.getCategories("crew");
    if (result != null) {
      if (result.success!) {
        //  setState(() {
        for (var item in result.result!) {
          if (item.jobType == 'crew') {
            categoryList = result;
          } else {
            facesCategoryList.add(item);
            facesSearchCategoryList.add(item);
            if (facesCategorySelected.isNotEmpty) {
              for (var item in facesCategoryList) {
                for (var selectedItem in facesCategorySelected) {
                  if (selectedItem.id!.contains(item.id!)) {
                    item.isSelected = selectedItem.isSelected;
                  }
                }
              }
            }
          }
        }
        notifyListeners();
        //  });
      } else {
        Constants.toastMessage(msg: result.message!);
        // return categoryList;
      }
    }
  }

  createFaces(BuildContext context) async {
    facesCategorySelected =
        Provider.of<Professionpro>(context, listen: false).categorySelected;
    print(facesCategorySelected);
    if (!facesKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Please fill the details'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else if (ageSelected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Select age group'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else if (facesCategorySelected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Enter or select your profession'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else if (famelocationController.text.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Select interested location'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else {
      List category = [];
      List<Map<String, String>> age = [
        {
          'groupA': '0 - 4',
          'groupB': '4 - 12',
          'groupC': '12 - 18',
          'groupD': '18 - 28',
          'groupE': '18 - 28',
          'groupF': '28 - 40',
          'groupG': '40 - 50',
          'groupH': '50 - 60',
          'groupI': '60+'
        }
      ];
      String? age1;

      for (var item in age) {
        for (var i in item.entries) {
          if (ageSelected == i.value) {
            age1 = i.key;
          }
        }
      }

      List<String> strarray = famelocationController.text.split(",");

      Map locat = {
        "district": strarray[0],
        "state": strarray[1],
        "country": strarray[2],
      };

      dynamic height = {'foot': sFoot, 'inch': sInch};
      print(jsonEncode(height));

      dynamic body = {
        "jobType": 'faces',
        "title": facetitleController.text,
        "jobLocation": jsonEncode(locat),
        "description": facedescriptionController.text,
        "startDate": facesstartController.text,
        "endDate": facesendController.text,
        "deadline": facesdeadlineController.text,
        "ageGroup": age1.toString(),
        'height': jsonEncode(height),
        'gender': genderIndex == 0
            ? 'male'
            : genderIndex == 1
                ? 'female'
                : 'all',
        "jobCategory": jsonEncode(facesCategorySelected),
      };

      print(body);

      await ApiManager.post(param: body, url1: "joblinks/createJob/faces")
          .then((value) async {
        if (value.statusCode == 200) {
          clearData();
          JobLinksFeedProvider provider =
              Provider.of<JobLinksFeedProvider>(context, listen: false);
          provider.getJobLinksFeed(1);
          if (provider.tabController != null) {
            provider.tabController!.animateTo(1);
          }
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Job created successfuly'),
              duration: const Duration(seconds: 2),
            ),
          );
        } else {
          print(value.body);
        }
      });
    }
  }

  updateFaces(BuildContext context, id) async {
    facesCategorySelected =
        Provider.of<Professionpro>(context, listen: false).categorySelected;

    if (!facesKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Please fill the details'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else if (ageSelected == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Select age group'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else if (facesCategorySelected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Enter or select your profession'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else if (famelocationController.text.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Select interested location'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else {
      List category = [];
      List<Map<String, String>> age = [
        {
          'groupA': '0 - 4',
          'groupB': '4 - 12',
          'groupC': '12 - 18',
          'groupD': '18 - 28',
          'groupE': '18 - 28',
          'groupF': '28 - 40',
          'groupG': '40 - 50',
          'groupH': '50 - 60',
          'groupI': '60+'
        }
      ];
      String? age1;

      for (var item in age) {
        for (var i in item.entries) {
          if (ageSelected == i.value) {
            age1 = i.key;
          }
        }
      }

      List<String> strarray = famelocationController.text.split(",");

      Map locat = {
        "district": strarray[0],
        "state": strarray[1],
        "country": strarray[2],
      };

      dynamic height = {'foot': sFoot, 'inch': sInch};
      print(jsonEncode(height));

      dynamic body = {
        "jobType": 'faces',
        "title": facetitleController.text,
        "jobLocation": jsonEncode(locat),
        "description": facedescriptionController.text,
        "startDate": facesstartController.text,
        "endDate": facesendController.text,
        "deadline": facesdeadlineController.text,
        "ageGroup": age1.toString(),
        'height': jsonEncode(height),
        'gender': genderIndex == 0
            ? 'male'
            : genderIndex == 1
                ? 'female'
                : 'all',
        "jobCategory": jsonEncode(facesCategorySelected),
      };
      print("Update");

      print(body);
      print(id);

      Api.patch.call(context,
          method: "joblinks/updateJob/faces/$id",
          param: body, onResponseSuccess: (Map object) {
        var result = UserUpdatedResponse.fromJson(object);
        print(result);
        if (result.success!) {
          JobLinksFeedProvider provider =
              Provider.of<JobLinksFeedProvider>(context, listen: false);
          provider.getJobLinksFeed(1);
          if (provider.tabController != null) {
            provider.tabController!.animateTo(1);
          }
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

  createCrew(BuildContext context) async {
    categorySelected =
        Provider.of<Professionpro>(context, listen: false).categorySelected;
    if (!crewKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Please fill the details'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else if (categorySelected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Enter or select your profession'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else if (locationController.text.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Select interested location'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else {
      List<String> strarray = locationController.text.split(",");

      Map locat = {
        "district": strarray[0],
        "state": strarray[1],
        "country": strarray[2],
      };

      dynamic body = {
        "jobType": 'crew',
        "title": titleController.text,
        "description": descriptionController.text,
        "experienceLevel": experienceIndex == 0
            ? 'fresher'
            : experienceIndex == 1
                ? 'experienced'
                : 'any',
        "startDate": startController.text,
        "endDate": endController.text,
        "deadline": deadlineController.text,
        "jobLocation": jsonEncode(locat),
        "jobCategory": jsonEncode(categorySelected),
      };

      print(body);

      Api.post.call(context, method: "joblinks/createJob/crew", param: body,
          onResponseSuccess: (Map object) {
        var result = UserUpdatedResponse.fromJson(object);
        print(result);
        if (result.success!) {
          clearData();
          JobLinksFeedProvider provider =
              Provider.of<JobLinksFeedProvider>(context, listen: false);
          provider.getJobLinksFeed(1);
          if (provider.tabController != null) {
            provider.tabController!.animateTo(1);
          }
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

  updateCrew(BuildContext context, id) async {
    categorySelected =
        Provider.of<Professionpro>(context, listen: false).categorySelected;
    if (!crewKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Please fill the details'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else if (categorySelected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Enter or select your profession'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else if (locationController.text.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Select interested location'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    } else {
      List<String> strarray = locationController.text.split(",");

      Map locat = {
        "district": strarray[0],
        "state": strarray[1],
        "country": strarray[2],
      };

      dynamic body = {
        "jobType": 'crew',
        "title": titleController.text,
        "description": descriptionController.text,
        "experienceLevel": experienceIndex == 0
            ? 'fresher'
            : experienceIndex == 1
                ? 'experienced'
                : 'any',
        "startDate": startController.text,
        "endDate": endController.text,
        "deadline": deadlineController.text,
        "jobLocation": jsonEncode(locat),
        "jobCategory": jsonEncode(categorySelected),
      };

      print(body);

      Api.patch.call(context,
          method: "joblinks/updateJob/crew/$id",
          param: body, onResponseSuccess: (Map object) {
        var result = UserUpdatedResponse.fromJson(object);
        print(result);
        if (result.success!) {
          JobLinksFeedProvider provider =
              Provider.of<JobLinksFeedProvider>(context, listen: false);
          provider.getJobLinksFeed(1);
          if (provider.tabController != null) {
            provider.tabController!.animateTo(1);
          }
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

  clearData() {
    //Clear faces fields
    facetitleController.clear();
    famelocationController.clear();
    facedescriptionController.clear();
    facesstartController.clear();
    facesendController.clear();
    facestotalController.clear();
    facesdeadlineController.clear();
    ageSelected = null;
    genderIndex = 0;
    sFoot = null;
    sInch = null;
    facesCategorySelected = [];

    //Clear crew fields
    titleController.clear();
    locationController.clear();
    descriptionController.clear();
    experienceIndex = 0;
    startController.clear();
    endController.clear();
    deadlineController.clear();
    categorySelected = [];
  }

  DateTime? startDate;
  DateTime? facesstartDate;

  selectStartDate(BuildContext context) async {
    startDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (startDate != null) {
      // setState(() {
      startController
        ..text = DateFormat("dd-MM-yyyy").format(startDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: startController.text.length,
            affinity: TextAffinity.upstream));
      //  });
      notifyListeners();
    }
  }

  selectEndDate(BuildContext context) async {
    print("enddate");
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: startDate!,
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (newSelectedDate != null) {
      // setState(() {
      endController
        ..text = DateFormat("dd-MM-yyyy").format(newSelectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: endController.text.length,
            affinity: TextAffinity.upstream));

      totalController.text =
          newSelectedDate.difference(startDate!).inDays.toString();
      // });
    }
  }

  selectDeadlineDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (newSelectedDate != null) {
      //  setState(() {
      deadlineController
        ..text = DateFormat("dd-MM-yyyy").format(newSelectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: deadlineController.text.length,
            affinity: TextAffinity.upstream));
      // });
      notifyListeners();
    }
  }

  facesselectStartDate(BuildContext context) async {
    facesstartDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (facesstartDate != null) {
      //setState(() {
      facesstartController
        ..text = DateFormat("dd-MM-yyyy").format(facesstartDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: facesstartController.text.length,
            affinity: TextAffinity.upstream));
      // });
      notifyListeners();
    }
  }

  facesselectEndDate(BuildContext context) async {
    DateTime? newSelectedDate1 = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: facesstartDate!,
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (newSelectedDate1 != null) {
      //  setState(() {
      facesendController
        ..text = DateFormat("dd-MM-yyyy").format(newSelectedDate1)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: facesendController.text.length,
            affinity: TextAffinity.upstream));

      facestotalController.text =
          newSelectedDate1.difference(facesstartDate!).inDays.toString();
      //});
      notifyListeners();
    }
  }

  facesselectDeadlineDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (newSelectedDate != null) {
      //  setState(() {
      facesdeadlineController
        ..text = DateFormat("dd-MM-yyyy").format(newSelectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: facesdeadlineController.text.length,
            affinity: TextAffinity.upstream));
      // });
      notifyListeners();
    }
  }
}
