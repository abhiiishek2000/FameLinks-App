import 'package:famelink/ui/home_feed/provider/home_feed_provider.dart';
import 'package:flutter/material.dart';

class TourDialogProvider extends ChangeNotifier {
  ProfileType? selectedProfileType;
  bool isDarkMode = false;

  void changeProfileType(ProfileType value) {
    selectedProfileType = value;
    notifyListeners();
  }
}
