import 'package:famelink/ui/filter/utils/save_image.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';

showSaveToGalleryAlert(
    BuildContext context, GlobalKey _repaintBoundaryKey,PageController pageController,int length) {
  showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title:
              Text('Save Image${length != 1 ? 's' : ''}'),
          content: Text(
              "Are you sure you want to save this image${length != 1 ? 's' : ''}?"),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(color: lightRed, letterSpacing: 1.5),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: lightRed),
              child: const Text(
                "Yes",
                style: TextStyle(color: Colors.white, letterSpacing: 1.5),
              ),
              onPressed: () async {
                SaveImage.saveImage(context,_repaintBoundaryKey,pageController,length).then((value) {
                  if(value != null) {
                    Navigator.pop(context, value);
                  }
                });

              },
            ),
          ],
        );
      });
}
