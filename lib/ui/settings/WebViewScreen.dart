import 'dart:io';

import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  String name;

  WebViewScreen(this.name);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
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
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
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
        initialUrl: widget.name == "Terms of Usage & Services"
            ? 'https://famelinks.app/terms.html'
            : widget.name == "FAQ section"
                ? 'https://famelinks.app/faqs.html'
                : widget.name == "Stages of FameLinks"
                    ? 'https://famelinks.app/stages.html'
                    : widget.name == "Community Guidelines"
                        ? 'https://famelinks.app/community.html'
                        : 'https://famelinks.app/privacy.html',
      ),
    );
  }
}
