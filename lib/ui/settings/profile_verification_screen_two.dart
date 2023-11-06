import 'dart:io';

import 'package:dio/dio.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_trimmer/video_trimmer.dart';

class ProfileVideoVerificationScreenTwo extends StatefulWidget {
  String? videoPath;

  ProfileVideoVerificationScreenTwo({this.videoPath});

  @override
  _ProfileVideoVerificationScreenTwoState createState() =>
      _ProfileVideoVerificationScreenTwoState();
}

class _ProfileVideoVerificationScreenTwoState
    extends State<ProfileVideoVerificationScreenTwo> {
  final ApiProvider _api = ApiProvider();
  int _value = -1;
  Trimmer _trimmer = Trimmer();
  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  ValueNotifier<double> _counter = ValueNotifier<double>(0);

  // Subscription _subscription;

  @override
  void dispose() {
    super.dispose();
    // _subscription.unsubscribe();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _trimmer.loadVideo(videoFile: File(widget.videoPath!));
    // _subscription = VideoCompress.compressProgress$.subscribe((progress) {
    //   debugPrint('progress: $progress');
    //   _counter.value = progress;
    //   if (progress >= 100) {
    //     progressDialog(false, context);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        toolbarHeight: ScreenUtil().setHeight(61),
        backgroundColor: appBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(
              text: 'Verify',
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(18),
                  color: lightRed)),
          TextSpan(
              text: ' your Profile',
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w400,
                  color: black,
                  fontSize: ScreenUtil().setSp(18))),
        ])),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(38),
                    right: ScreenUtil().setWidth(38)),
                child: Text(
                    "To verify your profile, please take a selfie Video and submit it for verification.\n(Name , age , place , Phone number)",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(12),
                        color: black)),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(38),
                    right: ScreenUtil().setWidth(38)),
                child: Text(
                    "Please show your Front Face, Right Profile & Left Profile.",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w700,
                        fontSize: ScreenUtil().setSp(12),
                        color: black)),
              ),
              Container(
                margin: EdgeInsets.only(top: ScreenUtil().setWidth(37)),
                height: ScreenUtil().setHeight(350),
                child: Stack(
                  children: [
                    VideoViewer(trimmer: _trimmer),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        child: _isPlaying
                            ? const Icon(
                                Icons.pause,
                                size: 30.0,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.play_arrow,
                                size: 30.0,
                                color: Colors.white,
                              ),
                        onPressed: () async {
                          bool playbackState =
                              await _trimmer.videPlaybackControl(
                            startValue: _startValue,
                            endValue: _endValue,
                          );
                          setState(() {
                            _isPlaying = playbackState;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              // Center(
              //   child: TrimEditor(
              //     trimmer: _trimmer,
              //     viewerHeight: 50.0,
              //     circlePaintColor: lightRed,
              //     borderPaintColor: lightRed,
              //     scrubberPaintColor: lightRed,
              //     durationTextStyle: GoogleFonts.nunitoSans(
              //         color: lightRed, fontWeight: FontWeight.w400),
              //     viewerWidth: (MediaQuery.of(context).size.width),
              //     maxVideoLength: const Duration(seconds: 30),
              //     onChangeStart: (value) {
              //       _startValue = value;
              //     },
              //     onChangeEnd: (value) {
              //       _endValue = value;
              //     },
              //     onChangePlaybackState: (value) {
              //       setState(() {
              //         _isPlaying = value;
              //       });
              //     },
              //   ),
              // ),
              InkWell(
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setWidth(20),
                      bottom: ScreenUtil().setWidth(20)),
                  child: Text("Record Again",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtil().setSp(12),
                          color: lightRed)),
                ),
              ),
              InkWell(
                onTap: () {
                  _saveVideo().then((outputPath) async {
                    print('OUTPUT PATH: $outputPath');
                    // progressDialog(true, context);

                    Navigator.pop(context, outputPath);
                    // await _uploadContestData();
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                  width: ScreenUtil().setWidth(200),
                  height: ScreenUtil().setHeight(40),
                  decoration: new BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [lightRedWhite, lightRed]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Review & Submit',
                        style: GoogleFonts.nunitoSans(
                            color: white,
                            fontWeight: FontWeight.w700,
                            fontSize: ScreenUtil().setSp(14)),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(27),
                      ),
                      Icon(Icons.arrow_forward, color: Colors.white)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void progressDialog(bool isLoading, BuildContext context) {
    AlertDialog dialog = AlertDialog(
      backgroundColor: Colors.black,
      content: Container(
          color: Colors.black,
          height: 60.0,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Compressing",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                SizedBox(height: 8),
                ValueListenableBuilder<double>(
                  builder:
                      (BuildContext context, double? value, Widget? child) {
                    // This builder will only get called when the _counter
                    // is updated.
                    return LinearPercentIndicator(
                      lineHeight: 10.0,
                      percent: value! / 100,
                      backgroundColor: Colors.white,
                      progressColor: Colors.black26,
                    );
                  },
                  valueListenable: _counter,
                  // The child parameter is most helpful if the child is
                  // expensive to build and does not depend on the value from
                  // the notifier.
                ),
                SizedBox(height: 15),
              ],
            ),
          )),
      contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
    );
    if (!isLoading) {
      Navigator.of(context).pop();
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return dialog;
          });
    }
  }

  Future<String> _saveVideo() async {
    String? _value;

    await _trimmer
        .saveTrimmedVideo(
            startValue: _startValue,
            endValue: _endValue,
            storageDir: StorageDir.externalStorageDirectory,
            videoFileName: "${File(widget.videoPath!).path.split('/').last}"
                .replaceFirst(".mp4", ""),
            onSave: (String? outputPath) {})
        .then((value) {
      setState(() {
        //zz_value = value;
      });
    });

    return _value!;
  }

  Future<void> _uploadContestData() async {
    var formData = FormData.fromMap({
      "video": Constants.video,
    });
    Api.uploadPost.call(context,
        method: "users/profile/verify",
        param: formData, onResponseSuccess: (Map object) {
      Navigator.pop(context, false);
    });
  }
}
