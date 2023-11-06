import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';

class CheckAppUpdateProvider extends ChangeNotifier{
  AppUpdateInfo? _updateInfo;
   Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      _updateInfo = info;
      notifyListeners();
      if (_updateInfo != null &&
          _updateInfo!.updateAvailability ==
              UpdateAvailability.updateAvailable) {
        InAppUpdate.performImmediateUpdate()
            .catchError((e) => log(e.toString()));
      }
    }).catchError((e) {
      // showSnack(e.toString());
    });
  }
}