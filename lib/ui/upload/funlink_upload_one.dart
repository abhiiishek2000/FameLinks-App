import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:famelink/databse/AppDatabase.dart';
import 'package:famelink/models/funlinks_songs_model.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/FunlinkMusicList.dart';
import 'package:famelink/ui/upload/funlink_upload_two.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class FunLinkUploadScreenOne extends StatefulWidget {
  ChallengesModelData? challengesModelData;
  String? musicId;
  String? musicName;
  String? audio;
  bool? userProfile;

  FunLinkUploadScreenOne(
      {this.challengesModelData,
        this.musicId,
        this.musicName,
        this.audio,
        this.userProfile});

  @override
  _FunLinkUploadScreenOneState createState() => _FunLinkUploadScreenOneState();
}

class _FunLinkUploadScreenOneState extends State<FunLinkUploadScreenOne> {
  List<CameraDescription>? cameras;
  CameraController? controller;
  Timer? _timer;
  int _start = 15;
  int _startTime = 15;
  String? videoPath;
  int cameraPos = 0;
  bool isFlashOn = false;
  bool enableAudio = true;
  VideoPlayerController? _videoPlayerController;
  AudioPlayer audioPlayer = AudioPlayer();
  bool isStart = false;
  bool isPause = false;

  bool isMusic = false;

  Map<String, dynamic>? songMap;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      Constants.playing = false;
    });
    print("AUDIO_2:::${widget.userProfile}");
    if (widget.audio != null && widget.audio!.isNotEmpty) {
      ResultSongs resultSongs = ResultSongs(
          song: '',
          by: '',
          name: '',
          thumbnail: '',
          duration: '',
          isPlay: true,
          isSaved: true);
      resultSongs.id = widget.musicId!;
      resultSongs.song = widget.audio!;
      resultSongs.name = widget.musicName!;
      resultSongs.by = "";
      downloadFile(widget.audio, resultSongs);
    }
    loadCamera();
  }

  void loadCamera() async {
    cameraPos = 0;
    cameras = await availableCameras().then((value) {
      controller = CameraController(value[0], ResolutionPreset.high,
          enableAudio: enableAudio);
      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {

        });
      });
      return [controller!.description];
    });
  }

  void loadCamera1() async {
    cameraPos = 1;
    cameras = await availableCameras().then((value) {
      controller = CameraController(value[1], ResolutionPreset.high,
          enableAudio: enableAudio);
      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
      return [controller!.description];
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    audioPlayer.release();
    super.dispose();
  }

  Future<void> downloadFile(mediaPath, ResultSongs resultSongs) async {
    var dir = await getApplicationDocumentsDirectory();
    Dio dio = Dio();

    try {
      print("path ${dir.path}");
      await dio.download("${ApiProvider.s3UrlPath}${ApiProvider.funlinksMusic}}$mediaPath",
          "${dir.path}/test.mp3", onReceiveProgress: (rec, total) {
            print("Rec: $rec , Total: $total");
            if (rec == total) {
              songMap = {"path": "${dir.path}/test.mp3", "model": resultSongs};
              setState(() {});
            }
          });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: white.withOpacity(0.5)),
        backgroundColor: darkBlue,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(
              text: "Upload",
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  color: white,
                  fontSize: ScreenUtil().setSp(18))),
          TextSpan(
              text: ' Video',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(18),
                  color: lightRed)),
        ])),
        actions: [
          IconButton(
              onPressed: () async {
                if (songMap != null) {
                  print("==> video path: ${videoPath}");
                  ResultSongs resultSongs = songMap!['model'];
                  Constants.progressDialog(true, context);
                  String _desFile = await _audioFile;
                  FFmpegKit
                      .execute(
                      "-i ${videoPath} -f mp3 -ab 192000 -vn ${_desFile}")
                      .then((value) async {
                    Constants.progressDialog(false, context);
                    print("Return code2---------- ${widget.userProfile}");

                    final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FunLinkUploadScreenTwo(
                              videoPath: videoPath,
                              musicId: resultSongs,
                              musicPath: _desFile,
                              challengesModelData:
                              widget.challengesModelData,
                              userProfile: widget.userProfile,
                            )));
                    if (result != null) {
                      Navigator.pop(context, result);
                    }
                  });
                } else {
                  if(videoPath != null){
                    print("==> video path: ${videoPath}");
                    Constants.progressDialog(true, context);
                    String _desFile = await _audioFile;
                    FFmpegKit
                        .execute(
                        "-i ${videoPath} -f mp3 -ab 192000 -vn ${_desFile}")
                        .then((value) async {
                      Constants.progressDialog(false, context);
                      print("Return code3------------ ${widget.userProfile}");

                      final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FunLinkUploadScreenTwo(
                                videoPath: videoPath,
                                musicPath: _desFile,
                                challengesModelData:
                                widget.challengesModelData,
                                userProfile: widget.userProfile,
                              )));
                      if (result != null) {
                        Navigator.pop(context, result);
                      }
                    });
                  }

                }
              },
              icon: Icon(Icons.arrow_forward))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: controller!=null?
                    controller!.value.isInitialized
                        ? CameraPreview(controller!)
                        : Container()
                        :Container(),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Visibility(
                      visible: isStart,
                      child: Padding(
                        padding: EdgeInsets.only(top: ScreenUtil().setHeight(28)),
                        child: Text('${_printDuration(Duration(seconds: _start))}',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w700,
                                fontSize: ScreenUtil().setSp(14),
                                color: lightRed)),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Visibility(
                            child: SizedBox(
                              width: ScreenUtil().screenWidth,
                              height: ScreenUtil().setSp(20),
                              child: Marquee(
                                  text: songMap != null
                                      ? "${(songMap!['model'] as ResultSongs).name} (${(songMap!['model'] as ResultSongs).by})"
                                      : "",
                                  velocity: 50.0,
                                  showFadingOnlyWhenScrolling: true,
                                  fadingEdgeStartFraction: 0.1,
                                  fadingEdgeEndFraction: 0.1,
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400, color: white)),
                            ),
                            visible: songMap != null),
                        Container(
                          margin: EdgeInsets.only(top: ScreenUtil().setSp(10)),
                          height: ScreenUtil().setSp(65),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(color: lightRed),
                                            color: Colors.white),
                                        padding: EdgeInsets.all(ScreenUtil().setSp(4)),
                                        child: SvgPicture.asset(
                                            "assets/icons/svg/video_effect.svg"),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(3),
                                      ),
                                      Text("Effects",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w400,
                                              color: white,
                                              fontSize: ScreenUtil().setSp(10))),
                                    ],
                                    mainAxisSize: MainAxisSize.min,
                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: ScreenUtil().setHeight(13),
                                    right: ScreenUtil().setSp(5)),
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
                                    isStart = !isStart;
                                    setState(() {});
                                    if (isStart) {
                                      _start = _startTime;
                                      if(songMap!=null){
                                        await audioPlayer.play(songMap!['path']);
                                        startVideoRecording().then((value) async {
                                          startTimer();
                                        });
                                      }else{
                                        startVideoRecording().then((value) async {
                                          startTimer();
                                        });
                                      }

                                    } else {
                                      _timer?.cancel();
                                      _timer = null;
                                      stopVideoRecording().then((file) async {
                                        if (mounted) setState(() {});
                                        await audioPlayer.stop();
                                        videoPath = file!=null?file.path:"";
                                        if (songMap != null) {
                                          String _desFile =
                                          await _destinationFile;
                                          String _musicFile = songMap!['path'];
                                          ResultSongs resultSongs =
                                          songMap!['model'];
                                          Constants.progressDialog(true, context);
                                          FFmpegKit
                                              .execute(
                                              "-i ${videoPath} -i ${_musicFile} -map 0:0 -map 1:0 -shortest ${_desFile}")
                                              .then((return_code) async {
                                            Constants.progressDialog(
                                                false, context);
                                            videoPath = _desFile;
                                            print("Return code $return_code");
                                            print(
                                                "Return code 4----------${widget.userProfile}");

                                            final result = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FunLinkUploadScreenTwo(
                                                          videoPath: videoPath,
                                                          musicId: resultSongs,
                                                          challengesModelData: widget
                                                              .challengesModelData,
                                                          userProfile:
                                                          widget.userProfile,
                                                        )));
                                            if (result != null) {
                                              Navigator.pop(context, result);
                                            }
                                          });
                                        } else {
                                          Constants.progressDialog(true, context);
                                          String _desFile = await _audioFile;
                                          FFmpegKit
                                              .execute(
                                              "-i ${videoPath} -f mp3 -ab 192000 -vn ${_desFile}")
                                              .then((value) async {
                                            Constants.progressDialog(
                                                false, context);
                                            print(
                                                "Return code5------------ ${widget.userProfile}");

                                            final result = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FunLinkUploadScreenTwo(
                                                          videoPath: videoPath,
                                                          musicPath: _desFile,
                                                          challengesModelData: widget
                                                              .challengesModelData,
                                                          userProfile:
                                                          widget.userProfile,
                                                        )));
                                            if (result != null) {
                                              Navigator.pop(context, result);
                                            }
                                          });
                                        }
                                        _videoPlayerController =
                                            VideoPlayerController.file(
                                                File(videoPath!));
                                        await _videoPlayerController!
                                            .initialize()
                                            .then((_) {
                                          setState(() {});
                                        });
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
                              Visibility(
                                visible: isStart,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: ScreenUtil().setHeight(13),
                                      left: ScreenUtil().setSp(5)),
                                  width: ScreenUtil().setSp(42),
                                  height: ScreenUtil().setSp(42),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(isPause
                                            ? EdgeInsets.all(ScreenUtil().setSp(15))
                                            : EdgeInsets.zero),
                                        backgroundColor: MaterialStateProperty.all<Color>(
                                            Colors.transparent),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(
                                                    ScreenUtil().setSp(21))),
                                                side: BorderSide(
                                                    color: white,
                                                    width: ScreenUtil().setSp(2))))),
                                    onPressed: () async {
                                      isPause = !isPause;
                                      setState(() {});
                                      if (isPause) {
                                        pauseTimer();
                                        pauseVideoRecording()
                                            .then((value) async {});
                                      } else {
                                        startTimer();
                                        resumeVideoRecording()
                                            .then((value) async {});
                                      }
                                    },
                                    child: isPause
                                        ? Container(
                                      width: ScreenUtil().setSp(40),
                                      height: ScreenUtil().setSp(40),
                                      decoration: BoxDecoration(
                                        color: lightRed,
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().setSp(20)),
                                      ),
                                    )
                                        : Container(
                                      width: ScreenUtil().setSp(40),
                                      height: ScreenUtil().setSp(40),
                                      child: Center(
                                          child: Icon(Icons.pause,
                                              color: white)),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      try {
                                        FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                          type: FileType.video,
                                          allowCompression: false,
                                        );
                                        if (result != null) {
                                          videoPath = result.files.single.path!;
                                          _videoPlayerController =
                                              VideoPlayerController.file(
                                                  File(videoPath!));
                                          await _videoPlayerController!
                                              .initialize()
                                              .then((_) {
                                            setState(() {});
                                          });
                                          if (widget.audio != null &&
                                              widget.audio!.isNotEmpty) {
                                            String _desFile = await _destinationFile;
                                            String _musicFile = songMap!['path'];
                                            ResultSongs resultSongs = songMap!['model'];
                                            Constants.progressDialog(true, context);
                                            FFmpegKit
                                                .execute(
                                                "-i ${videoPath} -i ${_musicFile} -map 0:0 -map 1:0 -shortest ${_desFile}")
                                            // "-i ${videoPath} -i ${_musicFile} -c copy -filter_complex [0:a]aformat = fltp:44100:stereo,apad[0a];[1] aformat=fltp:44100:stereo,volume=1.5[1a];[0a] [1a] amerge[a] -map 0:v -map [a] -ac 2 -y -shortest ${_desFile}")
                                                .then((return_code) async {
                                              Constants.progressDialog(false, context);
                                              videoPath = _desFile;
                                              print("Return code $return_code");
                                              print(
                                                  "Return code6---------- ${widget.userProfile}");

                                              final result = await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FunLinkUploadScreenTwo(
                                                            videoPath: videoPath,
                                                            musicId: resultSongs,
                                                            challengesModelData: widget
                                                                .challengesModelData,
                                                            userProfile:
                                                            widget.userProfile,
                                                          )));
                                              if (result != null) {
                                                Navigator.pop(context, result);
                                              }
                                            });
                                          } else {
                                            Constants.progressDialog(true, context);
                                            String _desFile = await _audioFile;
                                            FFmpegKit
                                                .execute(
                                                "-i ${videoPath} -f mp3 -ab 192000 -vn ${_desFile}")
                                                .then((value) async {
                                              Constants.progressDialog(false, context);
                                              print(
                                                  "Return code7--------- ${widget.userProfile}");

                                              final result = await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FunLinkUploadScreenTwo(
                                                            videoPath: videoPath,
                                                            musicPath: _desFile,
                                                            challengesModelData: widget
                                                                .challengesModelData,
                                                            userProfile:
                                                            widget.userProfile,
                                                          )));
                                              if (result != null) {
                                                Navigator.pop(context, result);
                                              }
                                            });
                                          }
                                        }
                                      } on PlatformException catch (e) {
                                        print('FAILED $e');
                                      }
                                    },
                                    child: _videoPlayerController != null
                                        ? Column(
                                      children: [
                                        Container(
                                            height: ScreenUtil().setHeight(38),
                                            width: ScreenUtil().setWidth(38),
                                            child: ClipRect(
                                                child: OverflowBox(
                                                    maxWidth:
                                                    ScreenUtil().setWidth(38),
                                                    maxHeight: ScreenUtil()
                                                        .setHeight(38),
                                                    alignment: Alignment.center,
                                                    child: FittedBox(
                                                      fit: BoxFit.cover,
                                                      alignment: Alignment.center,
                                                      child: Container(
                                                          height:
                                                          _videoPlayerController!
                                                              .value
                                                              .size
                                                              .height,
                                                          width:
                                                          _videoPlayerController!
                                                              .value
                                                              .size
                                                              .width,
                                                          child: VideoPlayer(
                                                              _videoPlayerController!)),
                                                    )))),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(3),
                                        ),
                                        Text("Upload",
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w400,
                                                color: white,
                                                fontSize:
                                                ScreenUtil().setSp(10))),
                                      ],
                                      mainAxisSize: MainAxisSize.min,
                                    )
                                        : Column(
                                      children: [
                                        Container(
                                            height: ScreenUtil().setHeight(38),
                                            width: ScreenUtil().setWidth(38),
                                            child: ClipRect(
                                                child: OverflowBox(
                                                    maxWidth:
                                                    ScreenUtil().setWidth(38),
                                                    maxHeight: ScreenUtil()
                                                        .setHeight(38),
                                                    alignment: Alignment.center,
                                                    child: FittedBox(
                                                      fit: BoxFit.cover,
                                                      alignment: Alignment.center,
                                                      child: Image.asset(
                                                          "assets/icons/gallery.png"),
                                                    )))),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(3),
                                        ),
                                        Text("Upload",
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w400,
                                                color: white,
                                                fontSize:
                                                ScreenUtil().setSp(10))),
                                      ],
                                      mainAxisSize: MainAxisSize.min,
                                    ),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(14),
                              left: ScreenUtil().setWidth(12.24)),
                          child: Column(
                            children: [
                              InkWell(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(14),
                                    bottom: ScreenUtil().setHeight(14),
                                    left: ScreenUtil().setWidth(12.24),
                                    right: ScreenUtil().setWidth(12.24),
                                  ),
                                  child: Icon(
                                      enableAudio ? Icons.mic : Icons.mic_off,
                                      color: white),
                                ),
                                onTap: () async {
                                  isStart = false;
                                  enableAudio = !enableAudio;
                                  controller!.dispose();
                                  await audioPlayer.stop();
                                  cameraPos == 0 ? loadCamera() : loadCamera1();
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Wrap(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(14),
                              right: ScreenUtil().setWidth(12.24)),
                          child: Column(
                            children: [
                              InkWell(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(14),
                                    bottom: ScreenUtil().setHeight(14),
                                    left: ScreenUtil().setWidth(12.24),
                                    right: ScreenUtil().setWidth(12.24),
                                  ),
                                  child: SvgPicture.asset(
                                      "assets/icons/svg/camera_flash.svg"),
                                ),
                                onTap: () {
                                  isFlashOn = !isFlashOn;
                                  controller!.setFlashMode(
                                      isFlashOn ? FlashMode.torch : FlashMode.off);
                                },
                              ),
                              SizedBox(height: ScreenUtil().setHeight(24.5)),
                              InkWell(
                                  onTap: () {
                                    cameraPos == 0 ? loadCamera1() : loadCamera();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(14),
                                      bottom: ScreenUtil().setHeight(14),
                                      left: ScreenUtil().setWidth(12.24),
                                      right: ScreenUtil().setWidth(12.24),
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/icons/svg/camera_switch.svg"),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Wrap(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(106.53),
                              right: ScreenUtil().setWidth(12.24)),
                          child: Column(
                            children: [
                              // SvgPicture.asset("assets/icons/svg/facemask.svg"),
                              // SizedBox(height: ScreenUtil().setHeight(30.5)),
                              // SvgPicture.asset("assets/icons/svg/play.svg"),
                              // SizedBox(height: ScreenUtil().setHeight(30.5)),
                              // SvgPicture.asset("assets/icons/svg/filter.svg"),
                              // SizedBox(height: ScreenUtil().setHeight(30.5)),
                              InkWell(
                                  onTap: () async {
                                    final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FunlinkMusicList()));
                                    if (result != null) {
                                      songMap = result;
                                      enableAudio = !enableAudio;
                                      controller!.dispose();
                                      cameraPos == 0 ? loadCamera() : loadCamera1();
                                      setState(() {});
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(14),
                                      bottom: ScreenUtil().setHeight(14),
                                      left: ScreenUtil().setWidth(12.24),
                                      right: ScreenUtil().setWidth(12.24),
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/icons/svg/music.svg"),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
          Container(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(13)),
            height: ScreenUtil().setHeight(79),
            color: darkBlue,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _startTime = _startTime == 15 ? 30 : 15;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            child: Text(_startTime == 30 ? "" : "30 Sec",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400,
                                    color: white,
                                    fontSize: ScreenUtil().setSp(10))),
                            padding:
                            EdgeInsets.only(bottom: ScreenUtil().setSp(20)),
                          ),
                        ],
                        mainAxisSize: MainAxisSize.min,
                      ),
                    ),
                    flex: 1),
                InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_startTime == 30 ? "30 Sec" : "15 Sec",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              color: white,
                              fontSize: ScreenUtil().setSp(10))),
                      Text(".",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              color: white,
                              fontSize: ScreenUtil().setSp(20))),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                ),
                Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _startTime = _startTime == 15 ? 30 : 15;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            child: Text(_startTime == 30 ? "15 Sec" : "",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400,
                                    color: white,
                                    fontSize: ScreenUtil().setSp(10))),
                            padding:
                            EdgeInsets.only(bottom: ScreenUtil().setSp(20)),
                          ),
                        ],
                        mainAxisSize: MainAxisSize.min,
                      ),
                    ),
                    flex: 1),
              ],
            ),
          )
        ],
      ),
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
      _timer?.cancel();
      _timer = null;
    } else {
      _timer = new Timer.periodic(
        const Duration(seconds: 1),
            (Timer timer) => setState(
              () {
            if (_start < 1) {
              isStart = !isStart;
              setState(() {});
              timer.cancel();
              _timer = null;
              stopVideoRecording().then((file) async {
                if (mounted) setState(() {});
                await audioPlayer.stop();
                videoPath = file!.path;
                if (songMap != null) {
                  String _desFile = await _destinationFile;
                  String _musicFile = songMap!['path'];
                  ResultSongs? resultSongs = songMap!['model'];
                  Constants.progressDialog(true, context);
                  FFmpegKit
                      .execute(
                      "-i ${videoPath} -i ${_musicFile} -map 0:0 -map 1:0 -shortest ${_desFile}")
                  // "-i ${videoPath} -i ${_musicFile} -c copy -filter_complex [0:a]aformat = fltp:44100:stereo,apad[0a];[1] aformat=fltp:44100:stereo,volume=1.5[1a];[0a] [1a] amerge[a] -map 0:v -map [a] -ac 2 -y -shortest ${_desFile}")
                      .then((return_code) async {
                    Constants.progressDialog(false, context);
                    videoPath = _desFile;
                    print("Return code $return_code");
                    print("Return code ${widget.userProfile}");

                    final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FunLinkUploadScreenTwo(
                              videoPath: videoPath,
                              musicId: resultSongs,
                              challengesModelData:
                              widget.challengesModelData,
                              userProfile: widget.userProfile,
                            )));
                    if (result != null) {
                      Navigator.pop(context, result);
                    }
                  });
                } else {
                  Constants.progressDialog(true, context);
                  String _desFile = await _audioFile;
                  FFmpegKit
                      .execute(
                      "-i ${videoPath} -f mp3 -ab 192000 -vn ${_desFile}")
                      .then((value) async {
                    Constants.progressDialog(false, context);
                    print("Return code1------- ${widget.userProfile}");

                    final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FunLinkUploadScreenTwo(
                              videoPath: videoPath,
                              musicPath: _desFile,
                              challengesModelData:
                              widget.challengesModelData,
                              userProfile: widget.userProfile,
                            )));
                    if (result != null) {
                      Navigator.pop(context, result);
                    }
                  });
                }
                _videoPlayerController =
                    VideoPlayerController.file(File(videoPath!));
                await _videoPlayerController!.initialize().then((_) {
                  setState(() {});
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

  void pauseTimer() {
    _timer?.cancel();
    _timer = null;
  }

  Future<String> get _destinationFile async {
    String directory;
    final String videoName = '${DateTime.now().millisecondsSinceEpoch}.mp4';
    if (Platform.isAndroid) {
      // Handle this part the way you want to save it in any directory you wish.
      final List<Directory>? dir =
      await getExternalStorageDirectories(type: StorageDirectory.movies);
      directory = dir!.first.path;
      return File('$directory/$videoName').path;
    } else {
      final Directory dir = await getLibraryDirectory();
      directory = dir.path;
      return File('$directory/$videoName').path;
    }
  }

  Future<String> get _audioFile async {
    String directory;
    final String videoName = '${DateTime.now().millisecondsSinceEpoch}.mp3';
    if (Platform.isAndroid) {
      // Handle this part the way you want to save it in any directory you wish.
      final List<Directory>? dir =
      await getExternalStorageDirectories(type: StorageDirectory.music);
      directory = dir!.first.path;

      return File('$directory/$videoName').path;
    } else {
      final Directory dir = await getLibraryDirectory();
      directory = dir.path;
      return File('$directory/$videoName').path;
    }
  }

  Future<void> startVideoRecording() async {
    final CameraController cameraController = controller!;

    if (!cameraController.value.isInitialized) {
      // showInSnackBar('Error: select a camera first.');
      return;
    }

    if (cameraController.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }

    try {
      await cameraController.startVideoRecording();
    } on CameraException {
      // _showCameraException(e);
      return;
    }
  }

  Future<void> resumeVideoRecording() async {
    final CameraController cameraController = controller!;

    if (!cameraController.value.isInitialized) {
      // showInSnackBar('Error: select a camera first.');
      return;
    }

    try {
      await cameraController.resumeVideoRecording();
    } on CameraException {
      // _showCameraException(e);
      return;
    }
  }

  Future<void> pauseVideoRecording() async {
    final CameraController cameraController = controller!;

    if (!cameraController.value.isInitialized) {
      // showInSnackBar('Error: select a camera first.');
      return;
    }
    try {
      await cameraController.pauseVideoRecording();
    } on CameraException {
      // _showCameraException(e);
      return;
    }
  }

  Future<XFile?> stopVideoRecording() async {
    CameraController? cameraController = controller;

    if (!cameraController!.value.isRecordingVideo) {
      return null;
    }

    try {
      return cameraController.stopVideoRecording();
    } on CameraException {
      return null;
    }
  }
}