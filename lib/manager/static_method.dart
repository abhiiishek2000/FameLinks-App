import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../util/config/color.dart';

class STM {
  void redirect2page(context, route) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route),
    );
  }

  void replacePage(context, route) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => route,
      ),
    );
  }

  void back2Previous(context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      SystemNavigator.pop();
    }
  }

  Widget imageView(url, {width, height, fit = BoxFit.fill, name = '', radius}) {
    print(url);
    return url.toString().contains('assets')
        ? Image.asset(
            '$url',
            width: width,
            height: height,
            fit: fit,
          )
        : CachedNetworkImage(
            imageUrl: url ??
                'https://www.famunews.com/wp-content/themes/newsgamer/images/dummy.png',
            placeholder: (context, url) => Container(
              width: width,
              height: height,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,

                  colors: [Color(0xffffdfb2), Color(0xffffd49c)],
                  stops: [0.0, 1.0],
                ),
                shape: radius != null ? BoxShape.rectangle : BoxShape.circle,
              ),
              child: CircularProgressIndicator(
                strokeWidth: 0.6,
                color: black,
              ),
            ),
            imageBuilder: (context, ip) => Container(
              width: width,
              height: height,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: radius != null ? BoxShape.rectangle : BoxShape.circle,
                borderRadius: radius != null
                    ? BorderRadius.circular(radius)
                    : radius,
                image: DecorationImage(
                  image: ip,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              width: width,
              height: height,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffffdfb2), Color(0xffffd49c)],
                  stops: [0.0, 1.0],
                ),
                shape: radius != null ? BoxShape.rectangle : BoxShape.circle,
              ),
              child: Text(
                '${name.isNotEmpty ? name[0].toUpperCase() : ''}',
                style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  color: black,
                  fontSize: ScreenUtil().setSp(20),
                ),
              ),
            ),
          );
  }
}
