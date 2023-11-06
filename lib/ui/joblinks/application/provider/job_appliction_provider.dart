// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../dio/api/api.dart';
import '../../../../dio/api/apimanager.dart';
import '../../../../networking/config.dart';
import '../../models/ApplicantsModel.dart';

class JobLinksApplicationProvider extends ChangeNotifier {
  Key keys = UniqueKey();
  int page = 1;
  ScrollController fameScrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  List<Applicants> applicantsList = <Applicants>[];
  List<Applicant> applicantsResult = <Applicant>[];
  bool isExpanded = true;
  int ftCount = 0;
  int inCount = 0;
  TextEditingController ftController = TextEditingController();
  TextEditingController inController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bustController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController hipController = TextEditingController();
  TextEditingController eyeController = TextEditingController();
  String? strWorkExp;
  List exp = ['Fresher', 'Experienced'];
  String? strComplexion;
  List complexion = ['Very Fair', 'Fair', 'Light', 'Medium', 'Dark'];
  List<VideoPlayerController> controller = [];

  bool isBookmark = false, isSort = false, isSearch = false, isFilter = false;

  getApplicants(id, BuildContext context) async {
    Map<String, dynamic> param = {
      "page": '$page',
    };

    Api.get.call(context,
        method: "joblinks/applicants/$id",
        param: param,
        isLoading: false, onResponseSuccess: (Map<dynamic, dynamic> object) {
      var result = ApplicantsModel.fromJson(object);
      applicantsList = <Applicants>[];
      if (result.result!.length > 0) {
        applicantsList.addAll(result.result!);
        applicantsResult = result.result![0].applicants!;
        for (var item in applicantsList[0].applicants!) {
          if (item.status == 'shortlisted') {
            item.isShortlisted = true;
            item.isHired = false;
          } else if (item.status == 'hired') {
            item.isHired = true;
            item.isShortlisted = false;
          } else {
            item.isShortlisted = false;
            item.isHired = false;
          }

          controller.add(VideoPlayerController.network(
              '${ApiProvider.joblinks}${item.greetVideo}')
            ..addListener(() {
              for (var items in controller) {
                if (items.value.position == items.value.duration) {
                  print('video Ended');
                  // if (mounted) {
                  //  // setState(() {
                  //     item.isPlaying = false;
                  // //  });
                  //   notifyListeners();
                  // }
                }
              }
            })
            ..initialize());
        }
        notifyListeners();
      }
    });
  }

  showMore(bool index) {
    isExpanded = !index;
    for (int i = 0; i < applicantsList[0].applicants!.length; i++) {
      applicantsList[0].applicants![i].isSwipe = isExpanded;
    }
    notifyListeners();
  }

  singleSwipe(int index, bool val) {
    applicantsList[0].applicants![index].isSwipe = val;
    notifyListeners();
  }

  updateList(type, {value}) {
    switch (type) {
      case 'bookmark':
        isBookmark = !isBookmark;
        if (isBookmark) {
          isSort = false;
          isSearch = false;
          isFilter = false;
          applicantsList[0].applicants = applicantsResult.where((e) {
            return e.isShortlisted == true;
          }).toList();
        } else {
          applicantsList[0].applicants = applicantsResult;
        }
        break;
      case 'sort':
        isSort = !isSort;
        isBookmark = false;
        isSearch = false;
        isFilter = false;
        List<Applicant> list = applicantsResult;
        list.sort((a, b) {
          return isSort
              ? a.name!.toLowerCase().compareTo(b.name!.toLowerCase())
              : b.name!.toLowerCase().compareTo(a.name!.toLowerCase());
        });
        applicantsList[0].applicants = list;
        break;
      case 'search':
        if (value != null) {
          applicantsList[0].applicants = applicantsResult
              .where((e) => e.name!.toLowerCase().contains(value.toLowerCase()))
              .toList();
        } else {
          isSearch = !isSearch;
          if (isSearch) {
            isBookmark = false;
            isSort = false;
            isFilter = false;
            searchController.clear();
          } else {
            applicantsList[0].applicants = applicantsResult;
          }
        }
        break;
      case 'filter':
        if (value != null) {
          applicantsList[0].applicants = applicantsResult.where((e) {
            if (e.hiringProfile!.experienceLevel != null) {
              return e.hiringProfile!.experienceLevel
                      .toString()
                      .toLowerCase() ==
                  strWorkExp.toString().toLowerCase();
            } else {
              var b = e.hiringProfile!.height!.foot.toString().toLowerCase() ==
                      ftController.text.trim().toLowerCase() ||
                  e.hiringProfile!.height!.inch.toString().toLowerCase() ==
                      inController.text.trim().toLowerCase() ||
                  e.hiringProfile!.weight.toString().toLowerCase() ==
                      weightController.text.trim().toLowerCase() ||
                  e.hiringProfile!.bust.toString().toLowerCase() ==
                      bustController.text.trim().toLowerCase() ||
                  e.hiringProfile!.waist.toString().toLowerCase() ==
                      waistController.text.trim().toLowerCase() ||
                  e.hiringProfile!.hip.toString().toLowerCase() ==
                      hipController.text.trim().toLowerCase() ||
                  e.hiringProfile!.eyeColor.toString().toLowerCase() ==
                      eyeController.text.trim().toLowerCase() ||
                  e.hiringProfile!.complexion.toString().toLowerCase() ==
                      strComplexion.toString().toLowerCase();
              return b;
            }
          }).toList();
        } else {
          isFilter = !isFilter;
          if (isFilter) {
            isBookmark = false;
            isSort = false;
            isSearch = false;
            ftController.clear();
            inController.clear();
            weightController.clear();
            bustController.clear();
            waistController.clear();
            hipController.clear();
            eyeController.clear();
            strComplexion = null;
          } else {
            applicantsList[0].applicants = applicantsResult;
          }
        }
        break;
    }
    notifyListeners();
  }

  Future<void> shortlist(context, jobId, userId, bool val, index) async {
    Map<String, dynamic> param = {
      "jobId": '"$jobId"',
      "userId": '"$userId"',
      "shortlist": val.toString(),
    };
    await ApiManager.post(param: param, url1: "joblinks/shortlist")
        .then((value) async {
      if (value.statusCode == 200) {
        applicantsList[0].applicants![index].isShortlisted = val;
        int i = applicantsResult.indexWhere((e) =>
            e.id.toString() ==
            applicantsList[0].applicants![index].id.toString());
        applicantsResult[i].isShortlisted = val;
        notifyListeners();
      } else {
        Map map = jsonDecode(value.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('${map["message"]}'),
            duration: const Duration(seconds: 2),
          ),
        );
        print(value.body);
      }
    });
  }

  Future<void> hire(jobId, userId, bool val, index, context) async {
    Map<String, dynamic> param = {
      "jobId": '"$jobId"',
      "userId": '"$userId"',
      "closeJob": val.toString(),
    };

    await ApiManager.post(param: param, url1: "joblinks/hire")
        .then((value) async {
      if (value.statusCode == 200) {
        Navigator.pop(context);
        applicantsList[0].applicants![index].isHired = val;
        int i = applicantsResult.indexWhere((e) =>
            e.id.toString() ==
            applicantsList[0].applicants![index].id.toString());
        applicantsResult[i].isHired = val;
        notifyListeners();
      } else {
        print(value.body);
      }
    });
  }
}
