import 'dart:async';

import 'package:camera/camera.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/settings/profile_verification_screen_two.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileVideoVerificationScreen extends StatefulWidget {
  const ProfileVideoVerificationScreen({Key? key}) : super(key: key);

  @override
  _ProfileVideoVerificationScreenState createState() =>
      _ProfileVideoVerificationScreenState();
}

class _ProfileVideoVerificationScreenState
    extends State<ProfileVideoVerificationScreen> {
  final ApiProvider _api = ApiProvider();
  List<CameraDescription>? cameras;
  CameraController? controller;
  Timer? _timer;
  int _start = 15;
  String? videoPath;

  bool isStart = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCamera();
  }

  void loadCamera() async {
    cameras = await availableCameras().then((value) {
      controller = CameraController(value[1], ResolutionPreset.max);
      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        //backwardsCompatibility: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
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
          width: ScreenUtil().screenWidth,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(27),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(49),
                      right: ScreenUtil().setWidth(48)),
                  child: Text(
                      "To verify your profile, please take a selfie Video using FameLinks Camera and submit it for verification.",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(12),
                          color: black)),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(49),
                      right: ScreenUtil().setWidth(48)),
                  child: Text(
                      "Please show your Front Face, Right Profile & Left Profile.",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtil().setSp(12),
                          color: black)),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(27),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(350),
                      child:
                          controller != null && controller!.value.isInitialized
                              ? CameraPreview(controller!)
                              : Container(),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(91),
                            right: ScreenUtil().setWidth(91)),
                        child: Text(
                            '${_printDuration(Duration(seconds: _start))}',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w700,
                                fontSize: ScreenUtil().setSp(12),
                                color: buttonBlue)),
                      ),
                    )
                  ],
                ),
                /*InkWell(
                  onTap: (){
                    _start = 15;
                    startVideoRecording();
                    startTimer();
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(27)),
                    width: ScreenUtil().setWidth(52),
                    height: ScreenUtil().setHeight(52),
                    decoration: new BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [lightRedWhite, lightRed]),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),*/
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(27)),
                  width: ScreenUtil().setSp(52),
                  height: ScreenUtil().setSp(52),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            isStart
                                ? EdgeInsets.all(ScreenUtil().setSp(15))
                                : EdgeInsets.zero),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(ScreenUtil().setSp(26))),
                                side: BorderSide(
                                    color: white,
                                    width: ScreenUtil().setSp(2))))),
                    onPressed: () async {
                      isStart = !isStart;
                      setState(() {});
                      if (isStart) {
                        _start = 15;
                        startVideoRecording();
                        startTimer();
                      } else {
                        if (_timer != null) {
                          _timer!.cancel();
                          _timer = null;
                        }
                        stopVideoRecording().then((file) async {
                          if (mounted) setState(() {});
                          if (file != null) {
                            print('Video recorded to ${file.path}');
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProfileVideoVerificationScreenTwo(
                                            videoPath: file.path)));
                            if (result != null) {
                              if (result == true) {
                                _start = 15;
                                setState(() {});
                              } else {
                                Navigator.pop(context, result);
                              }
                            }
                          }
                        });
                      }
                    },
                    child: Container(
                      width: ScreenUtil().setSp(50),
                      height: ScreenUtil().setSp(50),
                      decoration: isStart
                          ? BoxDecoration(
                              color: lightRed,
                              borderRadius:
                                  BorderRadius.circular(ScreenUtil().setSp(5)),
                            )
                          : BoxDecoration(
                              shape: BoxShape.circle,
                              color: lightRed,
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setWidth(11),
                      bottom: ScreenUtil().setWidth(33)),
                  child: Text("${isStart ? "Stop" : "Start"} Recording",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtil().setSp(12),
                          color: lightRed)),
                ),
                /*Container(
                  margin: EdgeInsets.only(
                      bottom: ScreenUtil().setHeight(108)),
                  width: ScreenUtil().setWidth(200),
                  height: ScreenUtil().setHeight(40),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(lightRed),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(00),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    side: BorderSide(color: lightRed)))),
                    onPressed: () async {
                      _addFeedbackApi();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Submit',
                          style: GoogleFonts.nunitoSans(
                              color: white,
                              fontWeight: FontWeight.w700,
                              fontSize: ScreenUtil().setSp(22)),
                        ),
                        SizedBox(
                          width: ScreenUtil().setSp(25),
                        ),
                        Icon(Icons.arrow_forward,
                            color: Colors.white, size: ScreenUtil().setSp(30))
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
          )),
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    } else {
      _timer = new Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) => setState(
          () {
            if (_start < 1) {
              timer.cancel();
              _timer = null;
              isStart = !isStart;
              stopVideoRecording().then((file) async {
                if (mounted) setState(() {});
                if (file != null) {
                  print('Video recorded to ${file.path}');
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProfileVideoVerificationScreenTwo(
                                  videoPath: file.path)));
                  if (result != null) {
                    if (result == true) {
                      _start = 15;
                      setState(() {});
                    } else {
                      Navigator.pop(context, result);
                    }
                  }
                }
              });
            } else {
              _start = _start - 1;
            }
          },
        ),
      );
    }
  }

  Future<void> startVideoRecording() async {
    final CameraController cameraController = controller!;

    if (cameraController == null || !cameraController.value.isInitialized) {
      // showInSnackBar('Error: select a camera first.');
      return;
    }

    if (cameraController.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }

    try {
      await cameraController.startVideoRecording();
    } on CameraException catch (e) {
      // _showCameraException(e);
      return;
    }
  }

  Future<XFile?> stopVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return null;
    }

    try {
      return cameraController.stopVideoRecording();
    } on CameraException catch (e) {
      return null;
    }
  }

  void _addFeedbackApi() async {
    /* if (commentController.text.isNotEmpty) {
      var map = {
        "body": commentController.text,
      };
      print(map.toString());
      Constants.progressDialog(true, context);
      var result = await _api.addRepostFAQ(map);
      Constants.progressDialog(false, context);
      if (result != null) {
        if (result.success) {
          Navigator.pop(context);
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ontext) => FAQSuccessScreen()),
          );
        } else {
          Constants.toastMessage(msg: result.message);
        }
      }
    }else{
      Constants.toastMessage(msg: "Describe your issue");
    }*/
  }
}
