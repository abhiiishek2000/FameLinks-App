import 'package:flutter/material.dart';
import 'package:famelink/models/notification_model.dart';
import 'package:intl/intl.dart';
import '../../dio/api/api.dart';

class GetNotificationProvider extends ChangeNotifier {
  List<Result> myNotificationResult = [];
  bool isUnreadMessage = false;
  bool isUnreadNotifications = false;
  int page = 1;
  final dateFormat = DateFormat('dd-MM-yyyy');
  final monthFormat = DateFormat('MM');

  List<Result> get getMyNotificationResult {
    return myNotificationResult;
  }

  void addNotifications(List<Result> value) {
    myNotificationResult.addAll(value);
    notifyListeners();
  }

  void emptyNotification() {
    myNotificationResult.clear();
    notifyListeners();
  }

  void changeUnreadNotifications(bool value) {
    isUnreadNotifications = true;
    notifyListeners();
  }

  void changeUnreadMessage(bool value) {
    isUnreadMessage = true;
    notifyListeners();
  }

   void getNotifications(BuildContext context, {bool? isPaginate}) async {
    if (isPaginate == true) {
      page++;
      notifyListeners();
    } else {
      emptyNotification();
      page = 1;
      emptyNotification();
    }
    Map<String, dynamic> formData = {
      "page": page.toString(),
    };
    Api.get.call(context, method: "users/notifications", param: formData,
        onResponseSuccess: (Map<dynamic, dynamic> object) {
      List<Result> todayList = [];
      List<Result> yesterdayList = [];
      List<Result> lastWeekList = [];
      List<Result> lastMonthList = [];
      var result = MyNotificationResponse.fromJson(object);
      for (int i = 0; i < result.result!.length; i++) {
        Result resultModel = result.result![i];
        DateTime date = DateTime.parse(resultModel.updatedAt!);
        DateTime today = dateFormat.parse(dateFormat.format(DateTime.now()));
        DateTime yesterday = dateFormat
            .parse(dateFormat.format(DateTime.now()))
            .subtract(Duration(days: 1));
        DateTime updatedAt = dateFormat.parse(dateFormat.format(date));
        if (updatedAt.compareTo(today) == 0) {
          if (todayList.length == 0) {
            resultModel.durationTime = "Today";
          }
          todayList.add(resultModel);
        } else if (updatedAt.compareTo(yesterday) == 0) {
          if (yesterdayList.length == 0) {
            resultModel.durationTime = "Yesterday";
          }
          yesterdayList.add(resultModel);
        } else if (updatedAt.month < today.month) {
          if (lastMonthList.length == 0) {
            resultModel.durationTime = "Last Month";
          }
          lastMonthList.add(resultModel);
        } else {
          print("API_MONTH::${updatedAt.month}");
          print("TODAY_MONTH::${today.month}");
          if (lastWeekList.length == 0) {
            resultModel.durationTime = "Last Week";
          }
          lastWeekList.add(resultModel);
        }
      }
      addNotifications(todayList);
      addNotifications(yesterdayList);
      addNotifications(lastWeekList);
      addNotifications(lastMonthList);
      Api.patch.call(context,
          method: "users/notifications/mark-as-read",
          param: {},
          onResponseSuccess: (Map object) {});
    });
  }
}
