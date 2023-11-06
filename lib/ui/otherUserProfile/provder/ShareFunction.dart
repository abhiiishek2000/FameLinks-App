
import 'dart:async';
import 'dart:io';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../dio/api/api.dart';
import '../../../models/CommentListResponse.dart';
import '../../../networking/config.dart';
import '../../../providers/FeedProvider/GetPerticularFollowLinksProfileProvider.dart';
import '../../../util/constants.dart';

class ShareFunction{
  String defaultPath = '';
  void onShare(String path, String type, int index,BuildContext context) async {
    final particularFollowLink =
    Provider.of<GetParticularFollowLinksProfileProvider>(context);
    if (type == "video") {
      var dir = await getApplicationDocumentsDirectory();
      bool fileExists = await File("${dir.path}/${path}").exists();
      if (fileExists) {
        Constants.progressDialog(true, context);
        File _watermarkImage =
        await getImageFileFromAssets('images/watermarkvideo.png');
        String _desFile = await _destinationFile;
        FFmpegKit.execute(
            "-i ${File("${dir.path}/${particularFollowLink.getParticularFunUserProfileModelResultList.result![index].media != null ? particularFollowLink.getParticularFunUserProfileModelResultList.result![index].media![0].type : defaultPath}").path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-75 -codec:a copy ${_desFile}")
        // "-i ${videoPath} -i ${_musicFile} -c copy -filter_complex [0:a]aformat = fltp:44100:stereo,apad[0a];[1] aformat=fltp:44100:stereo,volume=1.5[1a];[0a] [1a] amerge[a] -map 0:v -map [a] -ac 2 -y -shortest ${_desFile}")
            .then((return_code) async {
          Constants.progressDialog(false, context);
          Share.shareFiles(
            [_desFile],
            text:
            '${ApiProvider.shareUrl}post/famelinks/${particularFollowLink.getParticularFunUserProfileModelResultList.result![index].sId}',
          );
        });
      } else {
        Constants.progressDialog(true, context);
        Dio dio = Dio();
        unawaited(dio.download(
            "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${path}",
            "${dir.path}/${path}", onReceiveProgress: (rec, total) async {
          print("Rec: $rec , Total: $total");
          if (rec == total) {
            File _watermarkImage =
            await getImageFileFromAssets('images/watermarkvideo.png');
            String _desFile = await _destinationFile;
            FFmpegKit.execute(
                "-i ${File("${dir.path}/${particularFollowLink.getParticularFunUserProfileModelResultList.result![index].media != null ? particularFollowLink.getParticularFunUserProfileModelResultList.result![index].media![0].type : defaultPath}").path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-75 -codec:a copy ${_desFile}")
            // "-i ${videoPath} -i ${_musicFile} -c copy -filter_complex [0:a]aformat = fltp:44100:stereo,apad[0a];[1] aformat=fltp:44100:stereo,volume=1.5[1a];[0a] [1a] amerge[a] -map 0:v -map [a] -ac 2 -y -shortest ${_desFile}")
                .then((return_code) async {
              Constants.progressDialog(false, context);
              Share.shareFiles(
                [_desFile],
                text:
                '${ApiProvider.shareUrl}post/famelinks/${particularFollowLink.getParticularFunUserProfileModelResultList.result![index].sId}',
              );
            });
          }
        }));
      }
    } else {
      final Directory temp = await getTemporaryDirectory();
      final File imageFile = File('${temp.path}/tempImage.jpg');
      Dio dio = Dio();
      Constants.progressDialog(true, context);
      final response = await dio.download(
        '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${particularFollowLink.getParticularFunUserProfileModelResultList.result![index].media != null ? particularFollowLink.getParticularFunUserProfileModelResultList.result![index].media![0].path : defaultPath}',
        imageFile.path,
        onReceiveProgress: (count, total) async {
          print("Rec: $count , Total: $total");
          if (count == total) {
            File _watermarkImage =
            await getImageFileFromAssets('images/watermark.png');
            String _desFile = await _destinationImageFile;
            FFmpegKit.execute(
                "-i ${imageFile.path} -i ${_watermarkImage.path} -filter_complex overlay=W-w:H-h-150 ${_desFile}")
                .then((return_code) async {
              Constants.progressDialog(false, context);
              Share.shareFiles(
                [_desFile],
                text:
                '${ApiProvider.shareUrl}post/famelinks/${particularFollowLink.getParticularFunUserProfileModelResultList.result![index].sId}',
              );
            });
          }
        },
      );
      print(response.data.toString());
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

  // getCommentData(String type, String postId, bool isFollowLink,BuildContext context) async {
  //   commentPage = 1;
  //   Map<String, String> map = {"page": commentPage.toString()};
  //   Api.get.call(context, method: "media/${type}/comment/${postId}", param: map,
  //       onResponseSuccess: (Map object) {
  //         var result = CommentListResponse.fromJson(object);
  //         if (result.success == true) {
  //           print("==${result.message}");
  //         }
  //         // setState(() {
  //         commentResult = result.result;
  //         commentList = result.result!.data!;
  //         // });
  //         notifyListeners();
  //       });
  // }


}