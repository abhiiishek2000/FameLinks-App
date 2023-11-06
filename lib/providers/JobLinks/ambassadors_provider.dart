import 'package:flutter/material.dart';

class GetAmbassadorsProvider extends ChangeNotifier {
  bool isClicked = false;
  int index = 3;

  bool get getIsClicked {
    return isClicked;
  }

  void changeIsClicked(bool value) {
    isClicked = value;
    notifyListeners();
  }
  int get getIndex {
    return index;
  }

  void changeIndex(int value) {
    index = value;
    notifyListeners();
  }
}
