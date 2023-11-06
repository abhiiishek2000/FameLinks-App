import 'dart:io';

import 'package:famelink/databse/filesavecache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CachedImageWidget extends StatefulWidget {
  const CachedImageWidget({Key? key, required this.imgUrl, this.fit})
      : super(key: key);
  final String imgUrl;
  final BoxFit? fit;

  @override
  State<CachedImageWidget> createState() => _CachedImageWidgetState();
}

class _CachedImageWidgetState extends State<CachedImageWidget> {
  String? path;

  @override
  void initState() {
    print('filepath ${widget.imgUrl}');
    Filecache.getCacheImage(widget.imgUrl).then((value) {
      path = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return path != null
        ? Container(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(File(path!)),
                    fit: widget.fit ?? BoxFit.cover)),
          )
        : Container(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
