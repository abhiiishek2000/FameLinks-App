import 'dart:io';

import 'package:famelink/media_compression_provider.dart';
import 'package:famelink/ui/trimmer_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_trimmer/video_trimmer.dart';

class MediaCompressionTest extends StatefulWidget {
  const MediaCompressionTest({Key? key}) : super(key: key);

  @override
  State<MediaCompressionTest> createState() => _MediaCompressionTestState();
}

class _MediaCompressionTestState extends State<MediaCompressionTest> {
  File? videoFile;
  File? compressedVideoFile;
  File? thumbnail;
  File? compressedThumb;
  int? videoSize;
  int? compressedVideoSize;
  int? thumbSize;
  int? compressedthumbSize;
  VideoPlayerController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Consumer<MediaCompressionProvider>(
          builder: (context, provider, child) {
        return provider.isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('name'),
                    if (compressedThumb != null)
                      Image.file(
                        compressedThumb!,
                        height: 150,
                        width: 150,
                      ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => uploadImage(),
                        child: Text('Upload'),
                      ),
                    ),
                    Text(
                        'Media Size ---> ${thumbnail != null ? (thumbSize! / 1024) : 0}Kb'),
                    Text(
                        'Compressed Media Size ---> ${compressedThumb != null ? (compressedthumbSize! / 1024) : 0}Kb'),
                    Center(
                        child: ElevatedButton(
                      onPressed: () async {
                        try {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.video,
                            allowCompression: true,
                          );
                          if (result != null) {
                            videoFile = File(result.files.single.path!);
                            var trimmedFile = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TrimmerView(videoFile!)));
                            if (trimmedFile != null) {
                              var trimmedVideoFile = await File(trimmedFile);
                              videoSize = await trimmedVideoFile.lengthSync();

                              await Provider.of<MediaCompressionProvider>(
                                      context,
                                      listen: false)
                                  .compressVideo(context, File(trimmedFile),
                                      onSave: (String? path) async {
                                compressedVideoFile = File(path!);
                                setState(() {});
                                // Provider.of<MediaCompressionProvider>(context,
                                //         listen: false)
                                //     .extractThumbnail(videoFile!,
                                //         onSave: (String? path) async {
                                //   compressedThumb = File(path!);
                                //   compressedthumbSize =
                                //       await compressedThumb!.lengthSync();
                                //   setState(() {});
                                // });
                              });
                              // controller = VideoPlayerController.file(
                              //     compressedVideoFile!);
                              // await controller!.initialize();
                              // compressedVideoSize =
                              //     await trimmedVideoFile.length();
                              setState(() {});
                            }
                          }
                        } on PlatformException catch (e) {
                          print('FAILED $e');
                        }
                      },
                      child: Text('Upload Video'),
                    )),
                    if (compressedVideoFile != null) ...[
                      Column(
                        children: [
                          Container(
                              height: 500,
                              width: 300,
                              child: VideoPlayer(controller!)),
                          ElevatedButton(
                              onPressed: () async {
                                await controller!.play();
                              },
                              child: Text('Play'))
                        ],
                      )
                    ],
                    Text(
                        'Video Size ---> ${videoSize != null ? videoSize : 0}Kb'),
                    Text(
                        'Compressed Video Size ---> ${compressedVideoSize != null ? compressedVideoSize : 0}Kb'),
                  ],
                ),
              );
      })),
    );
  }

  Future uploadImage() async {
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
                        thumbnail = File(pickedFile.path);
                        thumbSize = await thumbnail!.lengthSync();
                        setState(() {});
                        _cropImage(thumbnail).then((value) async {
                          compressedThumb =
                              await Provider.of<MediaCompressionProvider>(
                                      context,
                                      listen: false)
                                  .getThumbnailImage(value!);
                          compressedthumbSize =
                              await compressedThumb!.lengthSync();
                          setState(() {});
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
                      thumbnail = File(image.path);
                      thumbSize = await thumbnail!.lengthSync();
                      setState(() {});
                      _cropImage(thumbnail).then((value) async {
                        compressedThumb =
                            await Provider.of<MediaCompressionProvider>(context,
                                    listen: false)
                                .getThumbnailImage(value!);
                        compressedthumbSize =
                            await compressedThumb!.lengthSync();
                        setState(() {});
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
