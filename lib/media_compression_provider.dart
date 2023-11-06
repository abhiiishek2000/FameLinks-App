import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

class MediaCompressionProvider extends ChangeNotifier {
  File? media;
  double? mediaSize;
  File? compressedFile;
  double? compressedSize;
  bool isLoading = false;

  void changeLoadingState(bool value) {
    isLoading = value;
    notifyListeners();
  }

  bool get getLoading => isLoading;

  Future<File?> uploadProfilePic(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () async {
                      Navigator.pop(context);
                      try {
                        final pickedFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);

                        if (pickedFile != null) {
                          media = File(pickedFile.path);
                          notifyListeners();
                        }
                        // if (pickedFile != null) {
                        //   _cropImage().then((value) async {
                        //     media = value!;
                        //     notifyListeners();
                        //     calMediaSize();
                        //   });
                        // }
                        // ;
                      } on PlatformException catch (e) {
                        print('FAILED $e');
                      }
                    }),
                ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () async {
                    Navigator.pop(context);
                    try {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (pickedFile != null) {
                        Navigator.pop(context);
                        media = File(pickedFile.path);
                        notifyListeners();
                      }
                      // if (pickedFile != null) {
                      //   _cropImage().then((value) async {
                      //     media = value!;
                      //     notifyListeners();
                      //     calMediaSize();
                      //   });
                      // }
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
    if (media != null) {
      mediaSize = await media!.length() / 1024;
      notifyListeners();
      if (mediaSize! > 200.0) {
        changeLoadingState(true);
        final result = await FlutterImageCompress.compressWithFile(
          media!.absolute.path,
          minWidth: 1000,
          minHeight: 500,
          quality: 70,
        );

        final targetSize = 200 * 1024;
        if (result!.length > targetSize) {
          final factor = targetSize / result.length;
          final targetQuality = (70 * factor).round();
          final compressed = await FlutterImageCompress.compressWithFile(
            media!.absolute.path,
            minWidth: 1000,
            minHeight: 500,
            quality: targetQuality,
          );
          changeLoadingState(false);
          // Save the compressed image to file
          return File(
              media!.path + "${DateTime.now().millisecondsSinceEpoch}.jpg")
            ..writeAsBytesSync(compressed!);
        } else {
          changeLoadingState(false);
          return File(
              media!.path + "${DateTime.now().millisecondsSinceEpoch}.jpg")
            ..writeAsBytesSync(result);
        }
      } else {
        return media!;
      }
    } else {
      return null;
    }
  }

  Future<File?> _cropImage() async {
    return await ImageCropper().cropImage(
        sourcePath: media!.path,
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
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
  }

  void calMediaSize() async {
    if (media != null) {
      mediaSize = await media!.length() / 1024;
      notifyListeners();
      mediaCompress();
    }
  }

  void mediaCompress() {
    if (mediaSize! > 200.0) {
      compressImageFile(media!);
    }
  }

  Future<File> compressImageFile(File file) async {
    if ((file.lengthSync() / 1024) > 250.0) {
      changeLoadingState(true);
      final result = await FlutterImageCompress.compressWithFile(
        file.absolute.path,
        minWidth: 1000,
        minHeight: 500,
        quality: 70,
      );

      final targetSize = 250 * 1024;
      if (result!.length > targetSize) {
        final factor = targetSize / result.length;
        final targetQuality = (70 * factor).round();
        final compressed = await FlutterImageCompress.compressWithFile(
          file.absolute.path,
          minWidth: 1000,
          minHeight: 500,
          quality: targetQuality,
        );
        // Save the compressed image to file
        changeLoadingState(false);
        return File(file.path + "${DateTime.now().millisecondsSinceEpoch}.jpg")
          ..writeAsBytesSync(compressed!);
      } else {
        changeLoadingState(false);
        return File(file.path + "${DateTime.now().millisecondsSinceEpoch}.jpg")
          ..writeAsBytesSync(result);
      }
    } else {
      return file;
    }
  }

  Future<File> getThumbnailImage(File file) async {
    if ((file.lengthSync() / 1024) > 10.0) {
      changeLoadingState(true);
      final result = await FlutterImageCompress.compressWithFile(
        file.absolute.path,
        minWidth: 150,
        minHeight: 150,
        quality: 70,
      );

      final targetSize = 10 * 1024;
      if (result!.length > targetSize) {
        final factor = targetSize / result.length;
        final targetQuality = (70 * factor).round();
        final compressed = await FlutterImageCompress.compressWithFile(
          file.absolute.path,
          minWidth: 150,
          minHeight: 150,
          quality: targetQuality,
        );
        // Save the compressed image to file
        changeLoadingState(false);
        return File(file.path + "${DateTime.now().millisecondsSinceEpoch}.jpg")
          ..writeAsBytesSync(compressed!);
      } else {
        changeLoadingState(false);
        return File(file.path + "${DateTime.now().millisecondsSinceEpoch}.jpg")
          ..writeAsBytesSync(result);
      }
    } else {
      return file;
    }
  }

  Future<void> compressVideo(BuildContext context, File file,
      {required Function(String? outputPath) onSave}) async {
    changeLoadingState(true);
    if (file.lengthSync() < 3120) {
      onSave(file.path);
      changeLoadingState(false);
      return;
    }
    // Get video duration
    final probeResult = await FFprobeKit.getMediaInformation(file.path);
    final duration = await probeResult.getDuration();

    // Calculate video bitrate
    final int targetSizeBytes = 2 * 1024 * 1024; // 2MB in bytes
    final int audioBitrate = 64 * 1000; // 64kbps audio bitrate
    final int audioStreamSizeBytes = ((audioBitrate * duration) / 8).round();
    final int remainingSizeBytes = targetSizeBytes - audioStreamSizeBytes;
    final double videoBitrate = (remainingSizeBytes * 8) / duration;
    final outputPath =
        '${file.path + "${DateTime.now().millisecondsSinceEpoch}.mp4"}';
    FFmpegKitConfig.enableLogCallback((log) {
      final message = log.getMessage();
      print(message);
    });

    FFmpegKit.executeAsync(
        '-i ${file.path} -vf scale=640:-1 -b:v 1500k -c:v mpeg4 -c:a aac -b:a 64k $outputPath',
        (session) async {
      final state =
          FFmpegKitConfig.sessionStateToString(await session.getState());
      final returnCode = await session.getReturnCode();

      debugPrint("FFmpeg process exited with state $state and rc $returnCode");

      if (ReturnCode.isSuccess(returnCode)) {
        debugPrint("compress processing completed successfully.");
        debugPrint('Video compress successfully saved');
        changeLoadingState(false);
        onSave(outputPath);
        changeLoadingState(false);
      } else {
        debugPrint("FFmpeg compress processing failed.");
        debugPrint('Couldn\'t compress the video');
        changeLoadingState(false);
        onSave(null);
      }
    });

    // if (await file.length() > 3 * 1024 * 1024) {
    //   print('compressing');
    //   changeLoadingState(true);
    //   await VideoCompress.setLogLevel(0);
    //   MediaInfo? info = await VideoCompress.compressVideo(
    //     file.path,
    //     quality: VideoQuality.LowQuality,
    //     frameRate: (targetSize * 8) ~/ 90,
    //     deleteOrigin: true,
    //   );
    //   print('compressing done');
    //   changeLoadingState(false);
    //   return
    //     File(file.path + "${DateTime.now().millisecondsSinceEpoch}.mp4")
    //       ..writeAsBytesSync(File(info!.path!).readAsBytesSync());
    //
    // } else {
    //   return file;
    // }
  }

  Future<void> compressAudio(BuildContext context, File file,
      {required Function(String? outputPath) onSave}) async {
    changeLoadingState(true);

    // Get video duration
    final probeResult = await FFprobeKit.getMediaInformation(file.path);
    final duration = await probeResult.getDuration();

    // Calculate video bitrate
    final int targetSizeBytes = 2 * 1024 * 1024; // 2MB in bytes
    final int audioBitrate = 64 * 1000; // 64kbps audio bitrate
    final int audioStreamSizeBytes = ((audioBitrate * duration) / 8).round();
    final int remainingSizeBytes = targetSizeBytes - audioStreamSizeBytes;
    final double videoBitrate = (remainingSizeBytes * 8) / duration;
    final outputPath =
        '${file.path + "${DateTime.now().millisecondsSinceEpoch}.mp3"}';
    FFmpegKitConfig.enableLogCallback((log) {
      final message = log.getMessage();
      print(message);
    });

    FFmpegKit.executeAsync('-i ${file.path} -map 0:3 -vn -b:a 320k $outputPath',
        (session) async {
      final state =
          FFmpegKitConfig.sessionStateToString(await session.getState());
      final returnCode = await session.getReturnCode();

      debugPrint("FFmpeg process exited with state $state and rc $returnCode");

      if (ReturnCode.isSuccess(returnCode)) {
        debugPrint("compress processing completed successfully.");
        debugPrint('audio compress successfully saved');
        changeLoadingState(false);
        onSave(outputPath);
        changeLoadingState(false);
      } else {
        debugPrint("FFmpeg compress processing failed.");
        debugPrint('Couldn\'t compress the audio');
        changeLoadingState(false);
        onSave(null);
      }
    });

    // if (await file.length() > 3 * 1024 * 1024) {
    //   print('compressing');
    //   changeLoadingState(true);
    //   await VideoCompress.setLogLevel(0);
    //   MediaInfo? info = await VideoCompress.compressVideo(
    //     file.path,
    //     quality: VideoQuality.LowQuality,
    //     frameRate: (targetSize * 8) ~/ 90,
    //     deleteOrigin: true,
    //   );
    //   print('compressing done');
    //   changeLoadingState(false);
    //   return
    //     File(file.path + "${DateTime.now().millisecondsSinceEpoch}.mp4")
    //       ..writeAsBytesSync(File(info!.path!).readAsBytesSync());
    //
    // } else {
    //   return file;
    // }
  }

  Future<File> getVideoThumbnail(File file) async {
    changeLoadingState(true);
    final thumbnailFile = await VideoCompress.getFileThumbnail(
      file.path,
      quality: 20, // default(100)
      position: -1, // default(-1)
    );
    changeLoadingState(false);
    return thumbnailFile;
  }

  void extractThumbnail(File file,
      {required Function(String? outputPath) onSave}) async {
    changeLoadingState(true);
    final outputPath =
        '${file.path + "thumbnail_${DateTime.now().millisecondsSinceEpoch}.jpg"}';
    FFmpegKitConfig.enableLogCallback((log) {
      final message = log.getMessage();
      print(message);
    });

    FFmpegKit.executeAsync(
        '-i ${file.path} -ss 00:00:01 -vframes 1 $outputPath', (session) async {
      final state =
          FFmpegKitConfig.sessionStateToString(await session.getState());
      final returnCode = await session.getReturnCode();

      debugPrint("FFmpeg process exited with state $state and rc $returnCode");

      if (ReturnCode.isSuccess(returnCode)) {
        debugPrint("compress processing completed successfully.");
        debugPrint('Video compress successfully saved');
        changeLoadingState(false);
        onSave(outputPath);
      } else {
        debugPrint("FFmpeg compress processing failed.");
        debugPrint('Couldn\'t compress the video');
        changeLoadingState(false);
        onSave(null);
      }
    });
  }

  showProgressDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text("Compressing..."),
        ],
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
