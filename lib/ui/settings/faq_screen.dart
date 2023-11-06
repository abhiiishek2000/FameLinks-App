import 'package:famelink/dio/api/api.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'WebViewScreen.dart';
import 'faq_sucess_screen.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  TextEditingController commentController = new TextEditingController();
  final ApiProvider _api = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              text: 'Describe your',
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w400,
                  color: black,
                  fontSize: ScreenUtil().setSp(18))),
          TextSpan(
              text: ' Issue',
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(18),
                  color: lightRed)),
        ])),
      ),
      body: Container(
          width: ScreenUtil().screenWidth,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(39),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(55),
                      right: ScreenUtil().setWidth(56)),
                  child: Text(
                      "We apologize for the inconvenience caused.  Please visit our",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w300,
                          fontSize: ScreenUtil().setSp(14),
                          color: black)),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(8),
                ),
                InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ontext) => WebViewScreen("FAQ section")),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'FAQ section',
                        style: GoogleFonts.nunitoSans(
                            color: buttonBlue,
                            fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(8),
                      ),
                      Image.asset("assets/icons/link.png", color: lightGray)
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(45),
                ),
                Text("or lodge a support request below",
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w300,
                        fontSize: ScreenUtil().setSp(14),
                        color: black)),
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(46)),
                  width: ScreenUtil().setWidth(280),
                  child: TextFormField(
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(500),
                    ],
                    controller: commentController,
                    minLines: 11,
                    maxLines: 11,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(16),
                          left: ScreenUtil().setWidth(17),
                          right: ScreenUtil().setWidth(19)),
                      hintText: 'Describe your issue',
                      hintStyle: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(12),
                          color: lightGray),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenUtil().setSp(8))),
                        borderSide: BorderSide(
                          width: 1,
                          color: buttonBlue,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setSp(8)),
                        borderSide: BorderSide(
                          width: 1,
                          color: buttonBlue,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(114),
                      bottom: ScreenUtil().setHeight(108)),
                  width: ScreenUtil().setWidth(200),
                  height: ScreenUtil().setHeight(40),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    side: BorderSide(color: lightRed)))),
                    onPressed: () async {
                      _addFeedbackApi();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Submit',
                          style: GoogleFonts.nunitoSans(
                              color: lightRed,
                              fontWeight: FontWeight.w700,
                              fontSize: ScreenUtil().setSp(22)),
                        ),
                        SizedBox(
                          width: ScreenUtil().setSp(25),
                        ),
                        Icon(Icons.arrow_forward,
                            color: lightRed, size: ScreenUtil().setSp(30))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _addFeedbackApi() async {
    if (commentController.text.isNotEmpty) {
      Map<String, dynamic> map = {
        "body": commentController.text,
      };
      Api.post.call(context, method: "users/report/issue", param: map,
          onResponseSuccess: (Map object) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ontext) => FAQSuccessScreen()),
        );
      });
    } else {
      Constants.toastMessage(msg: "Describe your issue");
    }
  }
}
