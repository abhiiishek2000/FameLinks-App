import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../networking/config.dart';

class Animaruinprovider extends ChangeNotifier {
  late Animation<double> animation;
  late AnimationController animController;
  late Animation<double> animationbud0;
  late AnimationController animControllerbud0;

  int antime = 300;
  int antimelong = 500;

  List budlist = [
    ApiProvider.userType == 'brand'
        ? "assets/icons/ic_store.png"
        : "assets/icons/darkFamelinkIcon.png",
    "assets/icons/dark_videolink_icon.png",
    "assets/icons/dark_follower_icon.png",
    "assets/icons/darkJoblinkIcon.png"
  ];

  intslize() {
    animation = Tween<double>(
      begin: 0,
      end: .5 * math.pi,
    ).animate(animController)
      ..addListener(() {
        // Empty setState because the updated value is already in the animation field
        notifyListeners();
      });

    animationbud0 = Tween<double>(
      begin: 0,
      end: .5 * math.pi,
    ).animate(animControllerbud0)
      ..addListener(() {
        // Empty setState because the updated value is already in the animation field
        notifyListeners();
      });
  }

  bool showanimation = false;

  animationshow(bool val) {
    showanimation = val;

    notifyListeners();
  }

  click2() {
    print("budanimation");
    animationbud0 = Tween<double>(
      begin: 0,
      end: -.5 * math.pi,
    ).animate(animControllerbud0)
      ..addListener(() {
        // Empty setState because the updated value is already in the animation field
      });
  }

  int a = 0;
  int b = 1;
  int c = 2;
  int d = 3;

  click3() {
    print("budanimation");
    animationbud0 = Tween<double>(
      begin: 0,
      end: .5 * math.pi,
    ).animate(animControllerbud0)
      ..addListener(() {
        // Empty setState because the updated value is already in the animation field
      });
  }

  click4() {
    print("budanimation");
    animationbud0 = Tween<double>(
      begin: 0,
      end: -1 * math.pi,
    ).animate(animControllerbud0)
      ..addListener(() {
        // Empty setState because the updated value is already in the animation field
      });
  }
}
