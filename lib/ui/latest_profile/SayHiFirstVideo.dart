import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/Famelinkprofile/ProfileFameLink.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../media_compression_provider.dart';

class SayHiFirstVideo extends StatefulWidget {
  final String? links;
  const SayHiFirstVideo({Key? key, this.links}) : super(key: key);

  @override
  _SayHiFirstVideoState createState() => _SayHiFirstVideoState();
}

class _SayHiFirstVideoState extends State<SayHiFirstVideo> {
  final ApiProvider _api = ApiProvider();
  List<CameraDescription>? cameras;
  bool responseData = false;
  CameraController? controller;
  Timer? _timer;
  int _start = 30;
  String? videoPath;
  List<CameraDescription>? _availableCameras;
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
    _getAvailableCameras();

    //loadCamera();
  }

  // void loadCamera() async {
  //   //Constants.progressDialog(true, context);
  //   cameras = await availableCameras().then((value) {
  //     controller = CameraController(value[1], ResolutionPreset.max);
  //     controller.initialize().then((_) {
  //
  //       setState(() {
  //        return _getAvailableCameras();
  //       });
  //     });
  //   });
  // }

  Future<void> _getAvailableCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    _availableCameras = await availableCameras();
    _initCamera(_availableCameras!.last);
  }

  Future<void> _initCamera(CameraDescription description) async {
    controller =
        CameraController(description, ResolutionPreset.max, enableAudio: true);

    try {
      await controller!.initialize().then((value) {});
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  void _toggleCameraLens() {
    // get current lens direction (front / rear)
    final lensDirection = controller!.description.lensDirection;
    CameraDescription newDescription;

    setState(() {
      if (lensDirection == CameraLensDirection.front) {
        newDescription = _availableCameras!.firstWhere((description) =>
            description.lensDirection == CameraLensDirection.back);
      } else {
        newDescription = _availableCameras!.firstWhere((description) =>
            description.lensDirection == CameraLensDirection.front);
      }

      if (newDescription != null) {
        _initCamera(newDescription);
      } else {
        print('Asked camera not available');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        //backwardsCompatibility: true,
        iconTheme: IconThemeData(color: black),
        toolbarHeight: ScreenUtil().setHeight(61),
        backgroundColor: appBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(
              text: 'Set',
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(18),
                  color: lightRed)),
          TextSpan(
              text: ' your First Video',
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w400,
                  color: black,
                  fontSize: ScreenUtil().setSp(18))),
        ])),
      ),
      body: responseData == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              width: ScreenUtil().screenWidth,
              child: Stack(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: AspectRatio(
                          aspectRatio: 0.54, // 1/0.9
                          child: ClipRect(
                            child: Transform.scale(
                              scale: 1 / 0.6,
                              child: Center(
                                child: controller != null
                                    ? CameraPreview(controller!)
                                    : SizedBox(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //   AspectRatio(
                      //   aspectRatio: 1,
                      //   child: ClipRect(
                      //     child: Transform.scale(
                      //       scale: 1 / 0.7,
                      //       child: Center(
                      //         child: AspectRatio(
                      //           aspectRatio: 1/0.7,
                      //             child: controller != null && controller.value.isInitialized
                      //                 ? CameraPreview(controller)
                      //                 : Container(),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // FittedBox(
                      //   fit: BoxFit.fitWidth,
                      //   child: SizedBox(
                      //     width: MediaQuery.of(context).size.width,
                      //     height:
                      //     MediaQuery.of(context).size.width / controller.value.aspectRatio,
                      //     child: controller != null && controller.value.isInitialized
                      //         ? CameraPreview(controller)
                      //         : Container(),
                      //   ),
                      // ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(91),
                              right: ScreenUtil().setWidth(55)),
                          child: Container(
                            padding:
                                EdgeInsets.only(top: ScreenUtil().setHeight(1)),
                            height: ScreenUtil().setHeight(25),
                            alignment: Alignment.center,
                            color: yellow,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(20),
                                  right: ScreenUtil()
                                      .setWidth(0)), //left:91,right:55
                              child: Text(
                                  '${_printDuration(Duration(seconds: _start))}',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      fontSize: ScreenUtil().setSp(12),
                                      color: buttonBlue)),
                            ),
                          ),
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 30, bottom: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rajvi shah',
                            style: TextStyle(color: Colors.transparent),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: ScreenUtil().setHeight(27)),
                            width: ScreenUtil().setSp(52),
                            height: ScreenUtil().setSp(52),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(isStart
                                      ? EdgeInsets.all(ScreenUtil().setSp(15))
                                      : EdgeInsets.zero),
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      Colors.transparent),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(
                                              ScreenUtil().setSp(26))),
                                          side: BorderSide(
                                              color: white,
                                              width: ScreenUtil().setSp(2))))),
                              onPressed: () async {
                                setState(() {
                                  isStart = !isStart;
                                });
                                if (isStart) {
                                  _start = 30;
                                  startVideoRecording();
                                  startTimer();
                                } else {
                                  if (_timer != null) {
                                    _timer!.cancel();
                                    _timer = null;
                                  }
                                  stopVideoRecording().then((file) async {
                                    if (file != null) {
                                      setState(() {
                                        responseData = true;
                                      });
                                      MediaCompressionProvider().compressVideo(
                                          context, File(file.path),
                                          onSave: (String? info) async {
                                        File thumbnailFile =
                                            await MediaCompressionProvider()
                                                .getVideoThumbnail(
                                                    File(file.path));

                                        _api
                                            .addFameLinkAPI(
                                                "true",
                                                File(info!),
                                                widget.links!,
                                                context,
                                                thumbnailFile)
                                            .then((value) {
                                          print("afterupload $value");
                                          if (widget.links == "contest") {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfileFameLink(
                                                      selectPhase: 0,
                                                    ),
                                              ),
                                            );
                                          } else if (widget.links ==
                                              "followlinks") {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfileFameLink(
                                                      selectPhase: 2,
                                                ),
                                              ),
                                            );
                                          } else if (widget.links ==
                                              "funlinks") {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfileFameLink(
                                                      selectPhase: 1,
                                                ),
                                              ),
                                            );
                                          }
                                        });
                                      });
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
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().setSp(5)),
                                      )
                                    : BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: lightRed,
                                      ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                //print("-----------------${controller.description.lensDirection}");
                                // _initCamera(_availableCameras.first);
                                _toggleCameraLens();
                                // print("=====================${controller.description.lensDirection}");
                                // if(controller.description.lensDirection == CameraLensDirection.back ){
                                //   _initCamera(_availableCameras.last);
                                // }else{
                                //   _initCamera(_availableCameras.first);
                                // }
                                // if(_availableCameras.first == true){
                                //   _initCamera(_availableCameras.last);
                                // }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 18), //15
                              child: Image.asset(
                                'assets/icons/camerarotation.png',
                                height: 40,
                                width: 40,
                                color: white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(20),
                          top: ScreenUtil().setWidth(11),
                          bottom: ScreenUtil().setWidth(33)),
                      child: Text("${isStart ? "Stop" : "Start"} Recording",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w700,
                              fontSize: ScreenUtil().setSp(12),
                              color: lightRed)),
                    ),
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
                setState(() {
                  responseData = true;
                });

                MediaCompressionProvider().compressVideo(context,File(file!.path),onSave: (String? info) async{
                  File thumbnailFile= await  MediaCompressionProvider().getVideoThumbnail(File(file.path));

                  _api
                      .addFameLinkAPI("true", File(info!), widget.links!,
                          context, thumbnailFile)
                      .then((value) {
                    print("afterupload $value");
                    if (widget.links == "contest") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileFameLink(
                            selectPhase: 0,
                          ),
                        ),
                      );
                    } else if (widget.links == "followlinks") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileFameLink(
                            selectPhase: 2,
                          ),
                        ),
                      );
                    } else if (widget.links == "funlinks") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileFameLink(
                            selectPhase: 1,
                          ),
                        ),
                      );
                    }
                  });
                });
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
    final CameraController cameraController = controller!;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      //return null;
    }

    try {
      return cameraController.stopVideoRecording();
    } on CameraException catch (e) {
      //return e;
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
