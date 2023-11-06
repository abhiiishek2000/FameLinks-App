import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:famelink/databse/AppDatabase.dart';
import 'package:famelink/media_compression_provider.dart';
import 'package:famelink/models/FileModel.dart';
import 'package:famelink/ui/filter/filter_image.dart';
import 'package:famelink/ui/upload/famelink_upload_video.dart';
import 'package:famelink/ui/upload/upload_screen_two.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:famelink/util/custom_snack_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';
import 'package:video_trimmer/video_trimmer.dart';

import '../trimmer_view.dart';

class UploadScreenOne extends StatefulWidget {
  ChallengesModelData? challengesModelData;
  bool? userProfile;

  UploadScreenOne({this.challengesModelData, this.userProfile});

  @override
  _UploadScreenOneState createState() => _UploadScreenOneState();
}

class _UploadScreenOneState extends State<UploadScreenOne> {
  File? mainCropImageFile;
  File? closeUpImageFile;
  File? mediumImageFile;
  File? longImageFile;
  File? poseOneImageFile;
  File? poseTwoImageFile;
  File? additionalImageFile;
  File? videoFile;
  VideoPlayerController? _videoPlayerController;
  final cropKey = GlobalKey<CropState>();
  File? videoThumbnail;
  Trimmer _trimmer = Trimmer();
  // Subscription? _subscription;
  ValueNotifier<double> _counter = ValueNotifier<double>(0);
  List<FileModel> imageList = <FileModel>[];
  List<FileModel> mainImageList = <FileModel>[];
  int imagePos = 0;

  PageController pageController =
      PageController(keepPage: true, initialPage: 0);

  @override
  void dispose() {
    super.dispose();
    // _subscription!.unsubscribe();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      Constants.playing = false;
    });
    // _subscription = VideoCompress.compressProgress$.subscribe((progress) {
    //   debugPrint('progress: $progress');
    //   _counter.value = progress;
    //   if (progress >= 100) {
    //     progressDialog(false, context);
    //   }
    // });
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
                      (BuildContext? context, double? value, Widget? child) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        toolbarHeight: ScreenUtil().setHeight(61),
        backgroundColor: appBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(
              text: "Select ",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  color: black,
                  fontSize: ScreenUtil().setSp(18))),
          TextSpan(
              text: "Photos & Video",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(18),
                  color: lightRed)),
        ])),
      ),
      body: Container(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///preview
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      width: ScreenUtil().screenWidth / 2,
                      height: ScreenUtil().screenHeight / 2.5,
                      decoration: BoxDecoration(
                          color: imageList.length > 0
                              ? Colors.transparent
                              : lightGray,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(ScreenUtil().radius(5)),
                              topRight: Radius.circular(ScreenUtil().radius(5)),
                              bottomLeft:
                                  Radius.circular(ScreenUtil().radius(5)),
                              bottomRight:
                                  Radius.circular(ScreenUtil().radius(5)))),
                      child: imageList.length > 0
                          ? Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: CarouselSlider.builder(
                                      itemCount: imageList.length,
                                      itemBuilder:
                                          (BuildContext context, int itemIndex,
                                                  int pageViewIndex) =>
                                              InkWell(
                                                child: Stack(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(
                                                        width: ScreenUtil()
                                                            .setSp(200),
                                                        height: ScreenUtil()
                                                            .setSp(400),
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            child: Image.file(
                                                              imageList[
                                                                      itemIndex]
                                                                  .file,
                                                              fit: BoxFit.cover,
                                                            )),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: AspectRatio(
                                                        aspectRatio: 3 / 4,
                                                        child: Stack(
                                                          children: [
                                                            Align(
                                                              alignment: Alignment
                                                                  .bottomLeft,
                                                              child: SizedBox(
                                                                width: 70,
                                                                height: 18,
                                                                child:
                                                                    ElevatedButton(
                                                                  style: ButtonStyle(
                                                                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
                                                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.7)),
                                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(00),
                                                                            topRight:
                                                                                Radius.circular(00),
                                                                            bottomLeft:
                                                                                Radius.circular(5),
                                                                            bottomRight:
                                                                                Radius.circular(00),
                                                                          ),
                                                                          side: BorderSide(color: Colors.white.withOpacity(0.7))))),
                                                                  child: Text(
                                                                      "Tablets",
                                                                      style: GoogleFonts.nunitoSans(
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          color: Colors
                                                                              .red,
                                                                          fontSize:
                                                                              ScreenUtil().setSp(10))),
                                                                  onPressed:
                                                                      () async {
                                                                    print(
                                                                        'ppppp');
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            DottedBorder(
                                                              borderType:
                                                                  BorderType
                                                                      .RRect,
                                                              radius: Radius
                                                                  .circular(5),
                                                              color: Colors.red,
                                                              child: Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                color: Colors
                                                                    .transparent,
                                                              )),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: AspectRatio(
                                                        aspectRatio: 9 / 16,
                                                        child: Stack(
                                                          children: [
                                                            Align(
                                                              alignment: Alignment
                                                                  .bottomLeft,
                                                              child: SizedBox(
                                                                width: 80,
                                                                height: 18,
                                                                child:
                                                                    ElevatedButton(
                                                                  style: ButtonStyle(
                                                                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
                                                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.7)),
                                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(00),
                                                                            topRight:
                                                                                Radius.circular(00),
                                                                            bottomLeft:
                                                                                Radius.circular(5),
                                                                            bottomRight:
                                                                                Radius.circular(00),
                                                                          ),
                                                                          side: BorderSide(color: Colors.white.withOpacity(0.7))))),
                                                                  child: Text(
                                                                      "Wide Phone",
                                                                      style: GoogleFonts.nunitoSans(
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          color:
                                                                              buttonBlue,
                                                                          fontSize:
                                                                              ScreenUtil().setSp(9))),
                                                                  onPressed:
                                                                      () async {
                                                                    print(
                                                                        'ppppp');
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            DottedBorder(
                                                              borderType:
                                                                  BorderType
                                                                      .RRect,
                                                              color: buttonBlue,
                                                              child: Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                color: Colors
                                                                    .transparent,
                                                              )),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: AspectRatio(
                                                        aspectRatio: 1 / 2,
                                                        child: Stack(
                                                          children: [
                                                            Align(
                                                              alignment: Alignment
                                                                  .bottomLeft,
                                                              child: SizedBox(
                                                                width: 80,
                                                                height: 18,
                                                                child:
                                                                    ElevatedButton(
                                                                  style: ButtonStyle(
                                                                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
                                                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.7)),
                                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(00),
                                                                            topRight:
                                                                                Radius.circular(00),
                                                                            bottomLeft:
                                                                                Radius.circular(5),
                                                                            bottomRight:
                                                                                Radius.circular(00),
                                                                          ),
                                                                          side: BorderSide(color: Colors.white.withOpacity(0.7))))),
                                                                  child: Text(
                                                                      "Long Phone",
                                                                      style: GoogleFonts.nunitoSans(
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          color:
                                                                              black,
                                                                          fontSize:
                                                                              ScreenUtil().setSp(10))),
                                                                  onPressed:
                                                                      () async {
                                                                    print(
                                                                        'ppppp');
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            DottedBorder(
                                                              borderType:
                                                                  BorderType
                                                                      .RRect,
                                                              color: black,
                                                              child: Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                color: Colors
                                                                    .transparent,
                                                              )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                onTap: () {
                                                  _cropImage(mainImageList[
                                                              itemIndex]
                                                          .file)
                                                      .then((value) async {
                                                    print(value!.path);
                                                    int pos =
                                                        imageList[itemIndex]
                                                            .position;
                                                    if (pos == 0) {
                                                      closeUpImageFile = value;
                                                      Constants.closeUp =
                                                          await MultipartFile
                                                              .fromFile(
                                                                  value.path,
                                                                  filename:
                                                                      "${value.path.split('/').last}");
                                                    } else if (pos == 1) {
                                                      mediumImageFile = value;
                                                      Constants.medium =
                                                          await MultipartFile
                                                              .fromFile(
                                                                  value.path,
                                                                  filename:
                                                                      "${value.path.split('/').last}");
                                                    } else if (pos == 2) {
                                                      longImageFile = value;
                                                      Constants.long =
                                                          await MultipartFile
                                                              .fromFile(
                                                                  value.path,
                                                                  filename:
                                                                      "${value.path.split('/').last}");
                                                    } else if (pos == 3) {
                                                      poseOneImageFile = value;
                                                      Constants.pose1 =
                                                          await MultipartFile
                                                              .fromFile(
                                                                  value.path,
                                                                  filename:
                                                                      "${value.path.split('/').last}");
                                                    } else if (pos == 4) {
                                                      poseTwoImageFile = value;
                                                      Constants.pose2 =
                                                          await MultipartFile
                                                              .fromFile(
                                                                  value.path,
                                                                  filename:
                                                                      "${value.path.split('/').last}");
                                                    } else if (pos == 5) {
                                                      additionalImageFile =
                                                          value;
                                                      Constants.additional =
                                                          await MultipartFile
                                                              .fromFile(
                                                                  value.path,
                                                                  filename:
                                                                      "${value.path.split('/').last}");
                                                    }
                                                    setState(() {
                                                      imageList
                                                          .removeAt(itemIndex);
                                                      imageList.insert(
                                                          itemIndex,
                                                          FileModel(
                                                              pos, value));
                                                    });
                                                  });
                                                },
                                              ),
                                      options: CarouselOptions(
                                        height: ScreenUtil().setSp(580),
                                        initialPage: 0,
                                        viewportFraction: 1,
                                        enableInfiniteScroll: false,
                                        reverse: false,
                                        autoPlay: false,
                                        autoPlayInterval: Duration(seconds: 3),
                                        autoPlayAnimationDuration:
                                            Duration(milliseconds: 800),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: true,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            pageController = PageController(
                                                keepPage: true,
                                                initialPage: index);
                                          });
                                        },
                                        scrollDirection: Axis.horizontal,
                                      )),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.all(ScreenUtil().setSp(10)),
                                    child: SmoothPageIndicator(
                                      controller: pageController,
                                      count: imageList.length,
                                      axisDirection: Axis.horizontal,
                                      effect: SlideEffect(
                                          spacing: 10.0,
                                          radius: 3.0,
                                          dotWidth: 6.0,
                                          dotHeight: 6.0,
                                          paintStyle: PaintingStyle.stroke,
                                          strokeWidth: 1.5,
                                          dotColor: Colors.white,
                                          activeDotColor: lightRed),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Icon(
                              Icons.camera_alt_outlined,
                              color: white,
                              size: ScreenUtil().radius(50),
                            ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                        onTap: () {
                          _cropImage(mainImageList[pageController.initialPage]
                                  .file)
                              .then((value) async {
                            print(value!.path);
                            int pos =
                                imageList[pageController.initialPage].position;
                            if (pos == 0) {
                              closeUpImageFile = value;
                              Constants.closeUp = await MultipartFile.fromFile(
                                  value.path,
                                  filename: "${value.path.split('/').last}");
                            } else if (pos == 1) {
                              mediumImageFile = value;
                              Constants.medium = await MultipartFile.fromFile(
                                  value.path,
                                  filename: "${value.path.split('/').last}");
                            } else if (pos == 2) {
                              longImageFile = value;
                              Constants.long = await MultipartFile.fromFile(
                                  value.path,
                                  filename: "${value.path.split('/').last}");
                            } else if (pos == 3) {
                              poseOneImageFile = value;
                              Constants.pose1 = await MultipartFile.fromFile(
                                  value.path,
                                  filename: "${value.path.split('/').last}");
                            } else if (pos == 4) {
                              poseTwoImageFile = value;
                              Constants.pose2 = await MultipartFile.fromFile(
                                  value.path,
                                  filename: "${value.path.split('/').last}");
                            } else if (pos == 5) {
                              additionalImageFile = value;
                              Constants.additional =
                                  await MultipartFile.fromFile(value.path,
                                      filename:
                                          "${value.path.split('/').last}");
                            }
                            setState(() {
                              imageList.removeAt(pageController.initialPage);
                              imageList.insert(pageController.initialPage,
                                  FileModel(pos, value));
                            });
                          });
                        },
                        child: Padding(
                          child: SvgPicture.asset("assets/icons/svg/crop.svg",
                              color: lightRed),
                          padding: EdgeInsets.all(10),
                        )),
                    InkWell(
                        onTap: () async {
                          List<File> croppedImages = [];
                          croppedImages
                              .add(imageList[pageController.initialPage].file);
                          var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FilterImage(
                                        files: croppedImages,
                                      )));
                          if (result != null) {
                            File value = File('$result');
                            int pos =
                                imageList[pageController.initialPage].position;
                            if (pos == 0) {
                              closeUpImageFile = value;
                              Constants.closeUp = await MultipartFile.fromFile(
                                  value.path,
                                  filename: "${value.path.split('/').last}");
                            } else if (pos == 1) {
                              mediumImageFile = value;
                              Constants.medium = await MultipartFile.fromFile(
                                  value.path,
                                  filename: "${value.path.split('/').last}");
                            } else if (pos == 2) {
                              longImageFile = value;
                              Constants.long = await MultipartFile.fromFile(
                                  value.path,
                                  filename: "${value.path.split('/').last}");
                            } else if (pos == 3) {
                              poseOneImageFile = value;
                              Constants.pose1 = await MultipartFile.fromFile(
                                  value.path,
                                  filename: "${value.path.split('/').last}");
                            } else if (pos == 4) {
                              poseTwoImageFile = value;
                              Constants.pose2 = await MultipartFile.fromFile(
                                  value.path,
                                  filename: "${value.path.split('/').last}");
                            } else if (pos == 5) {
                              additionalImageFile = value;
                              Constants.additional =
                                  await MultipartFile.fromFile(value.path,
                                      filename:
                                          "${value.path.split('/').last}");
                            }
                            setState(() {
                              imageList.removeAt(pageController.initialPage);
                              imageList.insert(pageController.initialPage,
                                  FileModel(pos, value));
                            });
                          }
                        },
                        child: Padding(
                          child: SvgPicture.asset(
                              "assets/icons/svg/img_filter.svg"),
                          padding: EdgeInsets.all(10),
                        ))
                  ],
                )
              ],
            ),

            ///upload images
            Container(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //video
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FameLinkUploadVideo()));
                          print("amarpath $result");

                          if (result != null) {
                            _trimmer.loadVideo(videoFile: File(result));
                            setState(() {});
                            showSnackBar(
                                context: context,
                                message: "Compressing...",
                                isError: false);
                            await Provider.of<MediaCompressionProvider>(context,
                                    listen: false)
                                .compressVideo(context, File(result),
                                    onSave: (String? path) async {
                              videoFile = File(path!);
                              setState(() {});
                              videoThumbnail =
                                  await Provider.of<MediaCompressionProvider>(
                                          context,
                                          listen: false)
                                      .getVideoThumbnail(videoFile!);
                              setState(() {});
                              showSnackBar(
                                  context: context,
                                  message: "Compressing Done",
                                  isError: false);
                            });
                          }
                        },
                        child: Consumer<MediaCompressionProvider>(
                            builder: (context, provider, child) {
                          return Container(
                            width: ScreenUtil().setWidth(65),
                            height: ScreenUtil().setHeight(116),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 4),
                                    blurRadius: 4.0,
                                    color: Colors.black.withOpacity(0.25),
                                  )
                                ],
                                color: white,
                                borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(ScreenUtil().radius(5)),
                                    topRight:
                                        Radius.circular(ScreenUtil().radius(5)),
                                    bottomLeft:
                                        Radius.circular(ScreenUtil().radius(5)),
                                    bottomRight: Radius.circular(
                                        ScreenUtil().radius(5)))),
                            child: provider.isLoading
                                ? Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: LinearProgressIndicator(
                                          color: Colors.orange,
                                        ),
                                      )
                                    ],
                                  )
                                : videoFile != null
                                    ? Stack(
                                        children: [
                                          SizedBox(
                                            height: ScreenUtil().setHeight(116),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: VideoViewer(
                                                  trimmer: _trimmer),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              height:
                                                  ScreenUtil().setHeight(34),
                                              width: ScreenUtil().setWidth(34),
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  border: Border.all(
                                                    width:
                                                        ScreenUtil().setSp(1),
                                                    color: white,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              ScreenUtil()
                                                                  .radius(8)))),
                                              child: Icon(
                                                Icons.play_arrow,
                                                color: white,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: InkWell(
                                              onTap: () {
                                                videoFile = null;
                                                Constants.video = null;
                                                setState(() {});
                                              },
                                              child: Padding(
                                                  padding: EdgeInsets.all(
                                                      ScreenUtil().setSp(8.73)),
                                                  child: SvgPicture.asset(
                                                      "assets/icons/svg/delete.svg",
                                                      height: ScreenUtil()
                                                          .setSp(15),
                                                      width: ScreenUtil()
                                                          .setSp(15))),
                                            ),
                                          )
                                        ],
                                      )
                                    : Center(
                                        child: Container(
                                          height: ScreenUtil().setHeight(34),
                                          width: ScreenUtil().setWidth(34),
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                width: ScreenUtil().setSp(1),
                                                color: lightGray,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      ScreenUtil().radius(8)))),
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: lightGray,
                                          ),
                                        ),
                                      ),
                          );
                        }),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(3.40),
                      ),
                      Text('Video',
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenUtil().setSp(10),
                              color: Colors.black.withOpacity(0.5))),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(116),
                    width: ScreenUtil().setWidth(1),
                    child: Padding(
                      padding:
                          EdgeInsets.only(bottom: ScreenUtil().setHeight(15)),
                      child: VerticalDivider(
                        width: 1,
                        thickness: 1,
                        color: lightRed,
                      ),
                    ),
                  ),
                  //closeup
                  Column(
                    children: [
                      GestureDetector(
                        onTap: closeUp,
                        child: Container(
                          width: ScreenUtil().setWidth(65),
                          height: ScreenUtil().setHeight(116),
                          decoration: BoxDecoration(
                              color: white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 4),
                                  blurRadius: 4.0,
                                  color: Colors.black.withOpacity(0.25),
                                )
                              ],
                              borderRadius: BorderRadius.only(
                                  topLeft:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  topRight:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  bottomLeft:
                                      Radius.circular(ScreenUtil().radius(5)),
                                  bottomRight:
                                      Radius.circular(ScreenUtil().radius(5)))),
                          child: closeUpImageFile != null
                              ? Stack(children: [
                                  SizedBox(
                                    height: ScreenUtil().setHeight(116),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.file(closeUpImageFile!,
                                          fit: BoxFit.cover,
                                          width: ScreenUtil().setWidth(65)),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: InkWell(
                                      onTap: () {
                                        imageList.remove(
                                            FileModel(0, closeUpImageFile!));
                                        mainImageList.remove(
                                            FileModel(0, closeUpImageFile!));
                                        closeUpImageFile = null;
                                        Constants.closeUp = null;
                                        setState(() {});
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.all(
                                              ScreenUtil().setSp(8.73)),
                                          child: SvgPicture.asset(
                                              "assets/icons/svg/delete.svg",
                                              height: ScreenUtil().setSp(15),
                                              width: ScreenUtil().setSp(15))),
                                    ),
                                  )
                                ])
                              : Center(
                                  child: Container(
                                    height: ScreenUtil().setHeight(34),
                                    width: ScreenUtil().setWidth(34),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                        width: ScreenUtil().setSp(1),
                                        color: lightGray,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          ScreenUtil().radius(8),
                                        ),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: lightGray,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(3.40),
                      ),
                      Text('Close up',
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenUtil().setSp(10),
                              color: Colors.black.withOpacity(0.5))),
                    ],
                  ),
                  //medium
                  Column(
                    children: [
                      GestureDetector(
                        onTap: medium,
                        child: Container(
                            width: ScreenUtil().setWidth(65),
                            height: ScreenUtil().setHeight(116),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 4),
                                    blurRadius: 4.0,
                                    color: Colors.black.withOpacity(0.25),
                                  )
                                ],
                                color: white,
                                borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(ScreenUtil().radius(5)),
                                    topRight:
                                        Radius.circular(ScreenUtil().radius(5)),
                                    bottomLeft:
                                        Radius.circular(ScreenUtil().radius(5)),
                                    bottomRight: Radius.circular(
                                        ScreenUtil().radius(5)))),
                            child: mediumImageFile != null
                                ? Stack(children: [
                                    SizedBox(
                                      height: ScreenUtil().setHeight(116),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.file(mediumImageFile!,
                                            fit: BoxFit.cover,
                                            width: ScreenUtil().setWidth(65)),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {
                                          imageList.remove(
                                              FileModel(1, mediumImageFile!));
                                          mainImageList.remove(
                                              FileModel(1, mediumImageFile!));
                                          mediumImageFile = null;
                                          Constants.medium = null;
                                          setState(() {});
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.all(
                                                ScreenUtil().setSp(8.73)),
                                            child: SvgPicture.asset(
                                                "assets/icons/svg/delete.svg",
                                                height: ScreenUtil().setSp(15),
                                                width: ScreenUtil().setSp(15))),
                                      ),
                                    )
                                  ])
                                : Center(
                                    child: Container(
                                      height: ScreenUtil().setHeight(34),
                                      width: ScreenUtil().setWidth(34),
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                            width: ScreenUtil().setSp(1),
                                            color: lightGray,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenUtil().radius(8)))),
                                      child: Icon(
                                        Icons.add,
                                        color: lightGray,
                                      ),
                                    ),
                                  )),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(3.40),
                      ),
                      Text('Medium',
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenUtil().setSp(10),
                              color: Colors.black.withOpacity(0.5))),
                    ],
                  ),

                  //long
                  Column(
                    children: [
                      GestureDetector(
                        onTap: long,
                        child: Container(
                            width: ScreenUtil().setWidth(65),
                            height: ScreenUtil().setHeight(116),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 4),
                                    blurRadius: 4.0,
                                    color: Colors.black.withOpacity(0.25),
                                  )
                                ],
                                color: white,
                                borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(ScreenUtil().radius(5)),
                                    topRight:
                                        Radius.circular(ScreenUtil().radius(5)),
                                    bottomLeft:
                                        Radius.circular(ScreenUtil().radius(5)),
                                    bottomRight: Radius.circular(
                                        ScreenUtil().radius(5)))),
                            child: longImageFile != null
                                ? Stack(children: [
                                    SizedBox(
                                      height: ScreenUtil().setHeight(116),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.file(longImageFile!,
                                            fit: BoxFit.cover,
                                            width: ScreenUtil().setWidth(65)),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {
                                          imageList.remove(
                                              FileModel(2, longImageFile!));
                                          mainImageList.remove(
                                              FileModel(2, longImageFile!));
                                          longImageFile = null;
                                          Constants.long = null;
                                          setState(() {});
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.all(
                                                ScreenUtil().setSp(8.73)),
                                            child: SvgPicture.asset(
                                                "assets/icons/svg/delete.svg",
                                                height: ScreenUtil().setSp(15),
                                                width: ScreenUtil().setSp(15))),
                                      ),
                                    )
                                  ])
                                : Center(
                                    child: Container(
                                      height: ScreenUtil().setHeight(34),
                                      width: ScreenUtil().setWidth(34),
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                            width: ScreenUtil().setSp(1),
                                            color: lightGray,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenUtil().radius(8)))),
                                      child: Icon(
                                        Icons.add,
                                        color: lightGray,
                                      ),
                                    ),
                                  )),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(3.40),
                      ),
                      Text('Long',
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenUtil().setSp(10),
                              color: Colors.black.withOpacity(0.5))),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //pose1
                  Column(
                    children: [
                      GestureDetector(
                        onTap: poseOne,
                        child: Container(
                            width: ScreenUtil().setWidth(65),
                            height: ScreenUtil().setHeight(116),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 4),
                                    blurRadius: 4.0,
                                    color: Colors.black.withOpacity(0.25),
                                  )
                                ],
                                color: white,
                                borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(ScreenUtil().radius(5)),
                                    topRight:
                                        Radius.circular(ScreenUtil().radius(5)),
                                    bottomLeft:
                                        Radius.circular(ScreenUtil().radius(5)),
                                    bottomRight: Radius.circular(
                                        ScreenUtil().radius(5)))),
                            child: poseOneImageFile != null
                                ? Stack(children: [
                                    SizedBox(
                                      height: ScreenUtil().setHeight(116),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.file(poseOneImageFile!,
                                            fit: BoxFit.cover,
                                            width: ScreenUtil().setWidth(65)),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {
                                          imageList.remove(
                                              FileModel(3, poseOneImageFile!));
                                          mainImageList.remove(
                                              FileModel(3, poseOneImageFile!));
                                          poseOneImageFile = null;
                                          Constants.pose1 = null;
                                          setState(() {});
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.all(
                                                ScreenUtil().setSp(8.73)),
                                            child: SvgPicture.asset(
                                                "assets/icons/svg/delete.svg",
                                                height: ScreenUtil().setSp(15),
                                                width: ScreenUtil().setSp(15))),
                                      ),
                                    )
                                  ])
                                : Center(
                                    child: Container(
                                      height: ScreenUtil().setHeight(34),
                                      width: ScreenUtil().setWidth(34),
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                            width: ScreenUtil().setSp(1),
                                            color: lightGray,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenUtil().radius(8)))),
                                      child: Icon(
                                        Icons.add,
                                        color: lightGray,
                                      ),
                                    ),
                                  )),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(3.40),
                      ),
                      Text('Pose 1',
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenUtil().setSp(10),
                              color: Colors.black.withOpacity(0.5))),
                    ],
                  ),
                  //pose two
                  Column(
                    children: [
                      GestureDetector(
                        onTap: poseTwo,
                        child: Container(
                            width: ScreenUtil().setWidth(65),
                            height: ScreenUtil().setHeight(116),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 4),
                                    blurRadius: 4.0,
                                    color: Colors.black.withOpacity(0.25),
                                  )
                                ],
                                color: white,
                                borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(ScreenUtil().radius(5)),
                                    topRight:
                                        Radius.circular(ScreenUtil().radius(5)),
                                    bottomLeft:
                                        Radius.circular(ScreenUtil().radius(5)),
                                    bottomRight: Radius.circular(
                                        ScreenUtil().radius(5)))),
                            child: poseTwoImageFile != null
                                ? Stack(children: [
                                    SizedBox(
                                      height: ScreenUtil().setHeight(116),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.file(poseTwoImageFile!,
                                            fit: BoxFit.cover,
                                            width: ScreenUtil().setWidth(65)),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {
                                          imageList.remove(
                                              FileModel(4, poseTwoImageFile!));
                                          mainImageList.remove(
                                              FileModel(4, poseTwoImageFile!));
                                          poseTwoImageFile = null;
                                          Constants.pose2 = null;
                                          setState(() {});
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.all(
                                                ScreenUtil().setSp(8.73)),
                                            child: SvgPicture.asset(
                                                "assets/icons/svg/delete.svg",
                                                height: ScreenUtil().setSp(15),
                                                width: ScreenUtil().setSp(15))),
                                      ),
                                    )
                                  ])
                                : Center(
                                    child: Container(
                                      height: ScreenUtil().setHeight(34),
                                      width: ScreenUtil().setWidth(34),
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                            width: ScreenUtil().setSp(1),
                                            color: lightGray,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenUtil().radius(8)))),
                                      child: Icon(
                                        Icons.add,
                                        color: lightGray,
                                      ),
                                    ),
                                  )),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(3.40),
                      ),
                      Text('Pose 2',
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenUtil().setSp(10),
                              color: Colors.black.withOpacity(0.5))),
                    ],
                  ),
                  //additional
                  Column(
                    children: [
                      GestureDetector(
                        onTap: additionalImage,
                        child: Container(
                            width: ScreenUtil().setWidth(65),
                            height: ScreenUtil().setHeight(116),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 4),
                                    blurRadius: 4.0,
                                    color: Colors.black.withOpacity(0.25),
                                  )
                                ],
                                color: white,
                                borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(ScreenUtil().radius(5)),
                                    topRight:
                                        Radius.circular(ScreenUtil().radius(5)),
                                    bottomLeft:
                                        Radius.circular(ScreenUtil().radius(5)),
                                    bottomRight: Radius.circular(
                                        ScreenUtil().radius(5)))),
                            child: additionalImageFile != null
                                ? Stack(children: [
                                    SizedBox(
                                      height: ScreenUtil().setHeight(116),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.file(additionalImageFile!,
                                            fit: BoxFit.cover,
                                            width: ScreenUtil().setWidth(65)),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {
                                          imageList.remove(FileModel(
                                              5, additionalImageFile!));
                                          mainImageList.remove(FileModel(
                                              5, additionalImageFile!));
                                          additionalImageFile = null;
                                          Constants.additional = null;
                                          setState(() {});
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.all(
                                                ScreenUtil().setSp(8.73)),
                                            child: SvgPicture.asset(
                                                "assets/icons/svg/delete.svg",
                                                height: ScreenUtil().setSp(15),
                                                width: ScreenUtil().setSp(15))),
                                      ),
                                    )
                                  ])
                                : Center(
                                    child: Container(
                                      height: ScreenUtil().setHeight(34),
                                      width: ScreenUtil().setWidth(34),
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                            width: ScreenUtil().setSp(1),
                                            color: lightGray,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenUtil().radius(8)))),
                                      child: Icon(
                                        Icons.add,
                                        color: lightGray,
                                      ),
                                    ),
                                  )),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(3.40),
                      ),
                      Text('Additional',
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenUtil().setSp(10),
                              color: Colors.black.withOpacity(0.5))),
                    ],
                  ),

                  InkWell(
                    onTap: () async {
                      if (closeUpImageFile != null ||
                          mediumImageFile != null ||
                          longImageFile != null ||
                          poseOneImageFile != null ||
                          poseTwoImageFile != null ||
                          additionalImageFile != null ||
                          videoFile != null) {
                        Map<String, File> screenTwoData = {
                          "closeUp": closeUpImageFile != null
                              ? closeUpImageFile!
                              : File(""),
                          "medium": mediumImageFile != null
                              ? mediumImageFile!
                              : File(""),
                          "long":
                              longImageFile != null ? longImageFile! : File(""),
                          "pose1": poseOneImageFile != null
                              ? poseOneImageFile!
                              : File(""),
                          "pose2": poseTwoImageFile != null
                              ? poseTwoImageFile!
                              : File(""),
                          "additional": additionalImageFile != null
                              ? additionalImageFile!
                              : File(""),
                          "video": videoFile != null ? videoFile! : File(""),
                          'video_tmb': videoThumbnail != null
                              ? videoThumbnail!
                              : File('')
                        };
                        if (screenTwoData.length > 0) {
                          //print(widget.challengesModelData.challengeName);
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UploadScreenTwo(
                                      screenTwoData: screenTwoData,
                                      challengesModelData: widget
                                                  .challengesModelData !=
                                              null
                                          ? widget.challengesModelData!
                                          : null))); //userProfile: widget.userProfile,
                          if (result != null) {
                            Navigator.pop(context, result);
                          }
                        }
                      } else {
                        showSnackBar(
                            context: context,
                            message: "Please upload video or photos",
                            isError: true);
                      }
                    },
                    child: Container(
                      width: ScreenUtil().setWidth(40),
                      height: ScreenUtil().setHeight(40),
                      margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                      decoration: BoxDecoration(
                          color: white,
                          border: Border.all(
                            width: ScreenUtil().setSp(2),
                            color: lightRed,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().radius(20)))),
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward,
                          color: lightRed,
                          size: ScreenUtil().radius(30),
                        ),
                      ),
                    ),
                  ),
                  /* Container(
                    width: ScreenUtil().setWidth(65),
                    height: ScreenUtil().setHeight(116),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(ScreenUtil().radius(10)),
                            topRight:
                                Radius.circular(ScreenUtil().radius(10)),
                            bottomLeft:
                                Radius.circular(ScreenUtil().radius(10)),
                            bottomRight:
                                Radius.circular(ScreenUtil().radius(10)))),
                    child: IconButton(
                        onPressed: () async {
                          Map<String, File> screenTwoData = {
                            "closeUp": closeUpImageFile,
                            "medium": mediumImageFile,
                            "long": longImageFile,
                            "pose1": poseOneImageFile,
                            "pose2": poseTwoImageFile,
                            "additional": additionalImageFile,
                            "video": videoFile,
                          };
                          if (screenTwoData.length > 0) {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UploadScreenTwo(
                                        screenTwoData: screenTwoData)));
                            if (result != null && result == true) {
                              Navigator.pop(context, true);
                            }
                          }
                        },
                        icon: Icon(
                          Icons.arrow_forward_rounded,
                          color: white,
                          size: ScreenUtil().radius(50),
                        )),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future closeUp() async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () async {
                      try {
                        final pickedFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (pickedFile == null) return;
                        mainCropImageFile = File(pickedFile.path);
                        mainImageList.remove(FileModel(0, mainCropImageFile!));
                        mainImageList.add(FileModel(0, mainCropImageFile!));
                        _cropImage(mainCropImageFile).then((value) async {
                          print(value!.path);
                          imagePos = 0;
                          setState(() {
                            closeUpImageFile = value;
                            imageList.remove(FileModel(0, mainCropImageFile!));
                            imageList.add(FileModel(0, value));
                          });
                          int bytes =
                              await File(closeUpImageFile!.path).length();
                          var imageSize = (bytes) / (1000);
                          if (imageSize > 150) {
                            print("==> File size is $imageSize");
                          } else {
                            print("==> File size is $imageSize");
                          }
                          Constants.closeUp = await MultipartFile.fromFile(
                              value.path,
                              filename:
                                  "${File(pickedFile.path).path.split('/').last}");
                        });
                      } on PlatformException catch (e) {
                        print('FAILED $e');
                      }
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () async {
                    try {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (image == null) return;
                      mainCropImageFile = File(image.path);
                      mainImageList.remove(FileModel(0, mainCropImageFile!));
                      mainImageList.add(FileModel(0, mainCropImageFile!));
                      _cropImage(mainCropImageFile).then((value) async {
                        print(value!.path);
                        imagePos = 0;
                        setState(() {
                          closeUpImageFile = value;
                          imageList.remove(FileModel(0, mainCropImageFile!));
                          imageList.add(FileModel(0, value));
                        });
                        int bytes = await File(closeUpImageFile!.path).length();
                        var imageSize = (bytes) / (1000);
                        if (imageSize > 150) {
                          print("==> File size is $imageSize");
                        } else {}
                        Constants.closeUp = await MultipartFile.fromFile(
                            value.path,
                            filename:
                                "${File(image.path).path.split('/').last}");
                      });
                    } on PlatformException catch (e) {
                      print('FAILED $e');
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future medium() async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () async {
                      try {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image == null) return;
                        mainCropImageFile = File(image.path);
                        mainImageList.remove(FileModel(1, mainCropImageFile!));
                        mainImageList.add(FileModel(1, mainCropImageFile!));
                        _cropImage(mainCropImageFile).then((value) async {
                          print(value!.path);
                          setState(() {
                            mediumImageFile = value;
                            imageList.remove(FileModel(1, mainCropImageFile!));
                            imageList.add(FileModel(1, value));
                          });
                          int bytes =
                              await File(mediumImageFile!.path).length();
                          var imageSize = (bytes) / (1000);
                          if (imageSize > 150) {
                            print("==> File size is $imageSize");
                          } else {}
                          Constants.medium = await MultipartFile.fromFile(
                              value.path,
                              filename:
                                  "${File(image.path).path.split('/').last}");
                        });
                      } on PlatformException catch (e) {
                        print('FAILED $e');
                      }
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () async {
                    try {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (image == null) return;
                      mainCropImageFile = File(image.path);
                      mainImageList.remove(FileModel(1, mainCropImageFile!));
                      mainImageList.add(FileModel(1, mainCropImageFile!));
                      _cropImage(mainCropImageFile).then((value) async {
                        print(value!.path);
                        setState(() {
                          mediumImageFile = value;
                          imageList.remove(FileModel(1, mainCropImageFile!));
                          imageList.add(FileModel(1, value));
                        });
                        int bytes = await File(mediumImageFile!.path).length();
                        var imageSize = (bytes) / (1000);
                        if (imageSize > 150) {
                          print("==> File size is $imageSize");
                        } else {}
                        Constants.medium = await MultipartFile.fromFile(
                            value.path,
                            filename:
                                "${File(image.path).path.split('/').last}");
                      });
                    } on PlatformException catch (e) {
                      print('FAILED $e');
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future long() async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () async {
                      try {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image == null) return;
                        mainCropImageFile = File(image.path);
                        mainImageList.remove(FileModel(2, mainCropImageFile!));
                        mainImageList.add(FileModel(2, mainCropImageFile!));
                        _cropImage(mainCropImageFile).then((value) async {
                          print(value!.path);
                          setState(() {
                            longImageFile = value;
                            imageList.remove(FileModel(2, mainCropImageFile!));
                            imageList.add(FileModel(2, value));
                          });
                          int bytes = await File(longImageFile!.path).length();
                          var imageSize = (bytes) / (1000);
                          if (imageSize > 150) {
                            print("==> File size is $imageSize");
                          } else {}
                          Constants.long = await MultipartFile.fromFile(
                              value.path,
                              filename:
                                  "${File(image.path).path.split('/').last}");
                        });
                      } on PlatformException catch (e) {
                        print('FAILED $e');
                      }
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () async {
                    try {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (image == null) return;
                      mainCropImageFile = File(image.path);
                      mainImageList.remove(FileModel(2, mainCropImageFile!));
                      mainImageList.add(FileModel(2, mainCropImageFile!));
                      _cropImage(mainCropImageFile).then((value) async {
                        print(value!.path);
                        setState(() {
                          longImageFile = value;
                          imageList.remove(FileModel(2, mainCropImageFile!));
                          imageList.add(FileModel(2, value));
                        });
                        int bytes = await File(longImageFile!.path).length();
                        var imageSize = (bytes) / (1000);
                        if (imageSize > 150) {
                          print("==> File size is $imageSize");
                        } else {}
                        Constants.long = await MultipartFile.fromFile(
                            value.path,
                            filename:
                                "${File(image.path).path.split('/').last}");
                      });
                    } on PlatformException catch (e) {
                      print('FAILED $e');
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future poseOne() async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () async {
                      try {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image == null) return;
                        mainCropImageFile = File(image.path);
                        mainImageList.remove(FileModel(3, mainCropImageFile!));
                        mainImageList.add(FileModel(3, mainCropImageFile!));
                        _cropImage(mainCropImageFile).then((value) async {
                          print(value!.path);
                          setState(() {
                            poseOneImageFile = value;
                            imageList.remove(FileModel(3, mainCropImageFile!));
                            imageList.add(FileModel(3, value));
                          });
                          int bytes =
                              await File(poseOneImageFile!.path).length();
                          var imageSize = (bytes) / (1000);
                          if (imageSize > 150) {
                            print("==> File size is $imageSize");
                          } else {}
                          Constants.pose1 = await MultipartFile.fromFile(
                              value.path,
                              filename:
                                  "${File(image.path).path.split('/').last}");
                        });
                      } on PlatformException catch (e) {
                        print('FAILED $e');
                      }
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () async {
                    try {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (image == null) return;
                      mainCropImageFile = File(image.path);
                      mainImageList.remove(FileModel(3, mainCropImageFile!));
                      mainImageList.add(FileModel(3, mainCropImageFile!));
                      _cropImage(mainCropImageFile).then((value) async {
                        print(value!.path);
                        setState(() {
                          poseOneImageFile = value;
                          imageList.remove(FileModel(3, mainCropImageFile!));
                          imageList.add(FileModel(3, value));
                        });
                        int bytes = await File(poseOneImageFile!.path).length();
                        var imageSize = (bytes) / (1000);
                        if (imageSize > 150) {
                          print("==> File size is $imageSize");
                        } else {}
                        Constants.pose1 = await MultipartFile.fromFile(
                            value.path,
                            filename:
                                "${File(image.path).path.split('/').last}");
                      });
                    } on PlatformException catch (e) {
                      print('FAILED $e');
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future poseTwo() async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () async {
                      try {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image == null) return;
                        mainCropImageFile = File(image.path);
                        mainImageList.remove(FileModel(4, mainCropImageFile!));
                        mainImageList.add(FileModel(4, mainCropImageFile!));
                        _cropImage(mainCropImageFile).then((value) async {
                          print(value!.path);
                          setState(() {
                            poseTwoImageFile = value;
                            imageList.remove(FileModel(4, mainCropImageFile!));
                            imageList.add(FileModel(4, value));
                          });
                          int bytes =
                              await File(mainCropImageFile!.path).length();
                          var imageSize = (bytes) / (1000);
                          if (imageSize > 150) {
                            print("==> File size is $imageSize");
                          } else {}
                          Constants.pose2 = await MultipartFile.fromFile(
                              value.path,
                              filename:
                                  "${File(image.path).path.split('/').last}");
                        });
                      } on PlatformException catch (e) {
                        print('FAILED $e');
                      }
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () async {
                    try {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (image == null) return;
                      mainCropImageFile = File(image.path);
                      mainImageList.remove(FileModel(4, mainCropImageFile!));
                      mainImageList.add(FileModel(4, mainCropImageFile!));
                      _cropImage(mainCropImageFile).then((value) async {
                        print(value!.path);
                        setState(() {
                          poseTwoImageFile = value;
                          imageList.remove(FileModel(4, mainCropImageFile!));
                          imageList.add(FileModel(4, value));
                        });
                        int bytes =
                            await File(mainCropImageFile!.path).length();
                        var imageSize = (bytes) / (1000);
                        if (imageSize > 150) {
                          print("==> File size is $imageSize");
                        } else {}
                        Constants.pose2 = await MultipartFile.fromFile(
                            value.path,
                            filename:
                                "${File(image.path).path.split('/').last}");
                      });
                    } on PlatformException catch (e) {
                      print('FAILED $e');
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future additionalImage() async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () async {
                      try {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image == null) return;
                        mainCropImageFile = File(image.path);
                        mainImageList.remove(FileModel(5, mainCropImageFile!));
                        mainImageList.add(FileModel(5, mainCropImageFile!));
                        _cropImage(mainCropImageFile).then((value) async {
                          print(value!.path);
                          setState(() {
                            additionalImageFile = value;
                            imageList.remove(FileModel(5, mainCropImageFile!));
                            imageList.add(FileModel(5, value));
                          });
                          int bytes =
                              await File(mainCropImageFile!.path).length();
                          var imageSize = (bytes) / (1000);
                          if (imageSize > 150) {
                            print("==> File size is $imageSize");
                          } else {}
                          Constants.additional = await MultipartFile.fromFile(
                              value.path,
                              filename:
                                  "${File(image.path).path.split('/').last}");
                        });
                      } on PlatformException catch (e) {
                        print('FAILED $e');
                      }
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () async {
                    try {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (image == null) return;
                      mainCropImageFile = File(image.path);
                      mainImageList.remove(FileModel(5, mainCropImageFile!));
                      mainImageList.add(FileModel(5, mainCropImageFile!));
                      _cropImage(mainCropImageFile).then((value) async {
                        print(value!.path);
                        setState(() {
                          additionalImageFile = value;
                          imageList.remove(FileModel(5, mainCropImageFile!));
                          imageList.add(FileModel(5, value));
                        });
                        int bytes =
                            await File(mainCropImageFile!.path).length();
                        var imageSize = (bytes) / (1000);
                        if (imageSize > 150) {
                          print("==> File size is $imageSize");
                        } else {}
                        Constants.additional = await MultipartFile.fromFile(
                            value.path,
                            filename:
                                "${File(image.path).path.split('/').last}");
                      });
                    } on PlatformException catch (e) {
                      print('FAILED $e');
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String> get _destinationFile async {
    String directory;
    if (Platform.isAndroid) {
      // Handle this part the way you want to save it in any directory you wish.
      final List<Directory?>? dir =
          await getExternalStorageDirectories(type: StorageDirectory.pictures);
      directory = dir!.first!.path;
      return directory;
    } else {
      final Directory dir = await getLibraryDirectory();
      directory = dir.path;
      return directory;
    }
  }

  Future video(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () async {
                      try {
                        Navigator.of(context).pop();
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.video,
                          allowCompression: false,
                        );
                        if (result != null) {
                          File file = File(result.files.single.path!);
                          // print("ORG:::${_getVideoSize(file: file)}");
                          print(file.path);
                          var filePath = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TrimmerView(file)));
                          if (filePath != null) {
                            // videoFile = File(filePath);
                            // progressDialog(true, context);
                            // final MediaInfo? info =
                            //     await VideoCompress.compressVideo(
                            //   videoFile!.path,
                            //   quality: VideoQuality.MediumQuality,
                            //   deleteOrigin: false,
                            //   includeAudio: true,
                            // );
                            MediaCompressionProvider()
                                .compressVideo(context, filePath,
                                    onSave: (String? outputPath) async {
                              videoFile = File(outputPath!);
                              Constants.video = await MultipartFile.fromFile(
                                  videoFile!.path,
                                  filename:
                                      "${File(file.path).path.split('/').last}");
                              _trimmer.loadVideo(videoFile: videoFile!);
                            });
                            setState(() {});
                          }
                        }
                      } on PlatformException catch (e) {
                        print('FAILED $e');
                      }
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () async {
                    try {
                      final video = await ImagePicker()
                          .pickVideo(source: ImageSource.camera);
                      if (video == null) return;
                      if (video != null) {
                        File file = File(video.path);
                        // print("ORG:::${_getVideoSize(file: file)}");
                        print(file.path);
                        var filePath = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TrimmerView(file)));
                        if (filePath != null) {
                          videoFile = File(filePath);
                          progressDialog(true, context);
                          // print("TRIMM:::${_getVideoSize(file: videoFile)}");
                          // String  _desFile = await _destinationFile;
                          // print("DEST:::${_desFile}");
                          // final MediaInfo? info =
                          //     await VideoCompress.compressVideo(
                          //   videoFile!.path,
                          //   quality: VideoQuality.MediumQuality,
                          //   deleteOrigin: false,
                          //   includeAudio: true,
                          // );
                          // print(info!.path);
                          // videoFile = File(info.path!);

                          MediaCompressionProvider()
                              .compressVideo(context, filePath,
                                  onSave: (String? outputPath) async {
                            videoFile = File(outputPath!);
                            Constants.video = await MultipartFile.fromFile(
                                videoFile!.path,
                                filename:
                                    "${File(file.path).path.split('/').last}");
                            _trimmer.loadVideo(videoFile: videoFile!);
                          });

                          setState(() {});
                        }
                      }
                    } on PlatformException catch (e) {
                      print('FAILED $e');
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) {
      return '0 B';
    }
    const List<String> suffixes = <String>[
      'B',
      'KB',
      'MB',
      'GB',
      'TB',
      'PB',
      'EB',
      'ZB',
      'YB',
    ];
    final int i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  String _getVideoSize({@required File? file}) =>
      formatBytes(file!.lengthSync(), 2);

  Future<File?> _cropImage(profileImageFile) async {
    return await ImageCropper().cropImage(
        sourcePath: profileImageFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 2),
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
          title: 'Cropper',
        ));
  }
}
