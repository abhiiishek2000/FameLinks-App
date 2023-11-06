import 'dart:io';
import 'dart:typed_data';

import 'package:famelink/ui/filter/saved_file_location.dart';
import 'package:famelink/ui/filter/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:ui' as ui;

class SaveImage {
  static Future<dynamic> saveImage(
      BuildContext context,
      GlobalKey _repaintBoundaryKey,
      PageController pageController,
      int length) async {
    bool havePermission = await _checkPermission();
    if (havePermission) {
      print("Permission granted");
      return _savePngBytes(_repaintBoundaryKey, context, pageController, length);
    } else {
      print("Permission not granted");
    }
  }

  static dynamic _savePngBytes(GlobalKey _repaintBoundaryKey, BuildContext context,
      PageController pageController, int length) async {
    showLoading(context, "Processing...");

    List<String> imageNames = [];
    List<Uint8List> imageBytesList = [];

    for (int i = 0; i < length; i++) {
      pageController.jumpToPage(i);
      //
      await Future.delayed(const Duration(milliseconds: 10));
      RenderRepaintBoundary boundary = _repaintBoundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 8.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      String imageName =
          DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";
      imageNames.add(imageName);
      imageBytesList.add(pngBytes);
      var path = await _destinationFile;
      String fullPath = '$path/${imageName}';
      print("local file full path ${fullPath}");
      File file = File(fullPath);
      await file.writeAsBytes(pngBytes);
      print(file.path);
      // final result = await ImageGallerySaver.saveImage(pngBytes,
      //     name: imageName, quality: 100);
      Navigator.pop(context);
      return file.path;
    }


    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => SavedFileLocation(
    //               paths: imageNames,
    //               imageBytes: imageBytesList,
    //             )));
  }
  static Future<String> get _destinationFile async {
    String directory;
    if (Platform.isAndroid) {
      // Handle this part the way you want to save it in any directory you wish.
      final List<Directory>? dir =
      await getExternalStorageDirectories(type: StorageDirectory.pictures);
      directory = dir!.first.path;
      return directory;
    } else {
      final Directory dir = await getLibraryDirectory();
      directory = dir.path;
      return directory;
    }
  }
  static Future<bool> _checkPermission() async {
    // NSPhotoLibraryAddUsageDescription add in info.plist
    // Add storage read write permission in manifest
    var permissionStatus = await Permission.storage.status;
    if (permissionStatus != PermissionStatus.granted) {
      var result = await Permission.storage.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    } else {
      // saveToGallery();
      return true;
    }
  }
}
