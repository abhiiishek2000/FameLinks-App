import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/fameLinks/provider/FameLinksFeedProvider.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../databse/filesavecache.dart';
import '../ui/followLinks/provider/FollowLinksFeedProvider.dart';
import '../ui/funlinks/provider/FunLinksFeedProvider.dart';

class Sharefiles {
  String defaultPath = '';

  void onShareFame(String path, String type, int index, int ind,
      BuildContext context) async {
    final dataFameLink =
        Provider.of<FameLinksFeedProvider>(context, listen: false);
    if (type == "video") {
      var dir = await getApplicationDocumentsDirectory();
      File _watermarkImage =
          await getImageFileFromAssets('images/watermarkvideo.png');
      String _desFile = await _destinationFile;
      var cachfile = await Filecache()
          .getcache("${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/$path");
      FFmpegKit.execute(
              "-i $cachfile -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-75 -codec:a copy ${_desFile}")
// "-i ${videoPath} -i ${_musicFile} -c copy -filter_complex [0:a]aformat = fltp:44100:stereo,apad[0a];[1] aformat=fltp:44100:stereo,volume=1.5[1a];[0a] [1a] amerge[a] -map 0:v -map [a] -ac 2 -y -shortest ${_desFile}")
          .then((return_code) async {
// Constants.progressDialog(false, context);
        Share.shareFiles(
          [_desFile],
          text:
              '${ApiProvider.shareUrl}post/famelinks/${dataFameLink.feedList[index].id}',
        );
      });
    } else {
      log('download');
      try {
        File _watermarkImage =
            await getImageFileFromAssets('images/watermarkimage.png');
        String _desFile = await _destinationImageFile;
        FFmpegKit.execute(
                "-i ${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/$path -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-10 -codec:a copy  ${_desFile}")
            .then((return_code) async {
          Share.shareFiles(
            [_desFile],
            text:
                '${ApiProvider.shareUrl}post/famelinks/${dataFameLink.feedList[index].id}',
          );
        });
      } catch (e) {
        log('$e');
      }
    }
  }

  void onShareFun(String path, String type, int index, int ind,
      BuildContext context) async {
    final dataFameLink =
        Provider.of<FunLinksFeedProvider>(context, listen: false);
    print(
        "file path ${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${dataFameLink.funLinksList[index].media![ind].path}");
    if (type == "video") {
      var dir = await getApplicationDocumentsDirectory();
      File _watermarkImage =
          await getImageFileFromAssets('images/watermarkvideo.png');
      String _desFile = await _destinationFile;
      var cachfile = await Filecache()
          .getcache("${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/$path");
      FFmpegKit.execute(
              "-i $cachfile -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-75 -codec:a copy ${_desFile}")
          .then((return_code) async {
        Share.shareFiles(
          [_desFile],
          text:
              '${ApiProvider.shareUrl}post/famelinks/${dataFameLink.funLinksList[index].id}',
        );
      });
    } else {
      try {
        log('downloaded $path');
        File _watermarkImage =
            await getImageFileFromAssets('images/watermarkimage.png');
        String _desFile = await _destinationImageFile;
        FFmpegKit.execute(
                "-i ${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/$path -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-10 -codec:a copy  ${_desFile}")
            .then((return_code) async {
// Constants.progressDialog(false, context);
          Share.shareFiles(
            [_desFile],
            text:
                '${ApiProvider.shareUrl}post/famelinks/${dataFameLink.funLinksList[index].id}',
          );
        });
      } catch (e) {
        log('$e');
      }
    }
  }

  void onShareFollow(String path, String type, int index, int ind,
      BuildContext context) async {
    final dataFameLink =
        Provider.of<FollowLinksFeedProvider>(context, listen: false);
    print(
        "file path ${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${dataFameLink.followLinkList[index].media![ind].path}");
    if (type == "video") {
      var dir = await getApplicationDocumentsDirectory();
      File _watermarkImage =
          await getImageFileFromAssets('images/watermarkvideo.png');
      String _desFile = await _destinationFile;
      var cachfile = await Filecache()
          .getcache("${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/$path");
      FFmpegKit.execute(
              "-i $cachfile -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-75 -codec:a copy ${_desFile}")
          .then((return_code) async {
        Share.shareFiles(
          [_desFile],
          text:
              '${ApiProvider.shareUrl}post/famelinks/${dataFameLink.followLinkList[index].id}',
        );
      });
    } else {
      try {
        log('downloaded $path');
        File _watermarkImage =
            await getImageFileFromAssets('images/watermarkimage.png');
        String _desFile = await _destinationImageFile;
        FFmpegKit.execute(
                "-i ${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/$path -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-10 -codec:a copy  ${_desFile}")
            .then((return_code) async {
// Constants.progressDialog(false, context);
          Share.shareFiles(
            [_desFile],
            text:
                '${ApiProvider.shareUrl}post/famelinks/${dataFameLink.followLinkList[index].id}',
          );
        });
      } catch (e) {
        log('$e');
      }
    }
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/watermark.png');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
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

  Future<String> get _destinationImageFile async {
    String directory;
    final String videoName = '${DateTime.now().millisecondsSinceEpoch}.png';
    if (Platform.isAndroid) {
// Handle this part the way you want to save it in any directory you wish.
      final List<Directory>? dir =
          await getExternalStorageDirectories(type: StorageDirectory.pictures);
      directory = dir!.first.path;
      return File('$directory/$videoName').path;
    } else {
      final Directory dir = await getLibraryDirectory();
      directory = dir.path;
      return File('$directory/$videoName').path;
    }
  }
}
