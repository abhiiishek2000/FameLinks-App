import 'package:flutter/material.dart';

class FaceFilter {
  double? faceSharpen;
  double? faceBrightness;
  double? foundationColorMultiply;
  double? eyesSharpen;
  double? bgBlur;
  double? skinBrightness;
  double? contrast;

  FaceFilter(
      {@required this.faceSharpen,
      @required this.faceBrightness,
      @required this.foundationColorMultiply,
      @required this.eyesSharpen,
      @required this.bgBlur,
      @required this.skinBrightness,
      @required this.contrast});
}
