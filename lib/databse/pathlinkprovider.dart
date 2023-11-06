import 'package:flutter/material.dart';

class Pathlink extends ChangeNotifier {
  String? pathlink1;
  String? pathlink3;

  setpath1(String path) {
    pathlink1 = path.toString();
    notifyListeners();
  }

  setpath2(String path) {
    pathlink3 = path.toString();
    notifyListeners();
  }
}
