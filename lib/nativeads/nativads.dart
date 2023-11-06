import 'package:flutter/material.dart';
import 'package:google_native_mobile_ads/google_native_mobile_ads.dart';

import 'getnativeadswidget.dart';

class NativeadsShow extends StatefulWidget {
  const NativeadsShow({Key? key}) : super(key: key);

  @override
  State<NativeadsShow> createState() => _NativeadsShowState();
}

class _NativeadsShowState extends State<NativeadsShow> {
  // final _controller = NativeAdmobController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller.setAdUnitID("ca-app-pub-8256017943830665/6689105191");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: Colors.grey,
        height: double.infinity,
        child: GetNativeAdWidget(
          adUnitId: 'ca-app-pub-3940256099942544/1044960115',
          customOptions:
              NativeAdCustomOptions.defaultConfig(NativeAdSize.fullScreen)
                  .toMap,
        ),
      ),
    ));
    ;
  }
}
