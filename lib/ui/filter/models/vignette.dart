import 'package:flutter/material.dart';

enum VignetteType { none, radial, topAndBottom, leftAndRight }

class Vignette {
  VignetteType? vignetteType;
  double? amount;

  Vignette({@required this.vignetteType, @required this.amount});
}
