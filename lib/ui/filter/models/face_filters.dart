import 'face_filter.dart';

class FaceBeautyList {
  static List<FaceFilter> faceBeautyList = [

    FaceFilter(
        contrast: 0.0,
        eyesSharpen: 0.0,
        bgBlur: 0.1,
        skinBrightness: 0.0,
        faceSharpen: 0.0,
        foundationColorMultiply: 0.0,
        faceBrightness: 0.0),
    FaceFilter(
        contrast: 5.0,
        eyesSharpen: 5.0,
        bgBlur: 1.0,
        skinBrightness: 5.0,
        faceSharpen: 5.0,
        foundationColorMultiply: 5.0,
        faceBrightness: 5.0),
    FaceFilter(
        contrast: 7.0,
        eyesSharpen: 5.0,
        bgBlur: 2.0,
        skinBrightness: 10.0,
        faceSharpen: 7.0,
        foundationColorMultiply: 10.0,
        faceBrightness: 7.0),
    FaceFilter(
        contrast: 9.0,
        eyesSharpen: 9.0,
        bgBlur: 3.0,
        skinBrightness: 15.0,
        faceSharpen: 9.0,
        foundationColorMultiply: 15.0,
        faceBrightness: 10.0),
    FaceFilter(
        contrast: 11.0,
        eyesSharpen: 10.0,
        bgBlur: 4.0,
        skinBrightness: 20.0,
        faceSharpen: 10.0,
        foundationColorMultiply: 20.0,
        faceBrightness: 15.0),
    FaceFilter(
        contrast: 15.0,
        eyesSharpen: 15.0,
        bgBlur: 5.0,
        skinBrightness: 30.0,
        faceSharpen: 15.0,
        foundationColorMultiply: 30.0,
        faceBrightness: 30.0),
  ];
}