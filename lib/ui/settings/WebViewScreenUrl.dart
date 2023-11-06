import 'dart:io';

import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreenUrl extends StatefulWidget {
  String name;
  String url;

  WebViewScreenUrl(this.name, this.url);

  @override
  _WebViewScreenUrlState createState() => _WebViewScreenUrlState();
}

class _WebViewScreenUrlState extends State<WebViewScreenUrl> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backwardsCompatibility: true,
        iconTheme: IconThemeData(color: black),
        toolbarHeight: ScreenUtil().setHeight(61),
        backgroundColor: appBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(
              text: widget.name,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  color: lightRed,
                  fontSize: ScreenUtil().setSp(18))),
        ])),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:
            !widget.url.contains("http") ? "https://${widget.url}" : widget.url,
      ),
    );
  }
}
