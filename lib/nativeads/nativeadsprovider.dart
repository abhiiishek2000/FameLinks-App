import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_native_mobile_ads/google_native_mobile_ads.dart';

class Nativeadsprovider extends ChangeNotifier {
  NativeAd? nativeAd;
  bool nativeAdIsLoaded = false;
  bool hasError = false;

  initializeAd(String adUnitId) {
    hasError = false;
    nativeAd = NativeAd(
      adUnitId: adUnitId,

      /// This does the job to show fullscreen ads
      customOptions:
          NativeAdCustomOptions.defaultConfig(NativeAdSize.fullScreen).toMap,
      nativeAdOptions: NativeAdOptions(
        adChoicesPlacement: AdChoicesPlacement.topLeftCorner,
        mediaAspectRatio: MediaAspectRatio.any,
        videoOptions: VideoOptions(
          clickToExpandRequested: true,
          customControlsRequested: true,
          startMuted: false,
        ),
        //shouldRequestMultipleImages: true,
      ),
      request: const AdRequest(),

      /// This needs not to be changed
      factoryId: NativeAdConfig.adFactoryId,
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) async {
          print('$NativeAd loaded.');

          hasError = false;
          nativeAdIsLoaded = true;
          notifyListeners();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$NativeAd failedToLoad: $error');
          if (error.code == 3) {
            print('google out of ads for this config.');
          }

          hasError = true;
          notifyListeners();
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
      ),
    )..load();
  }
}
