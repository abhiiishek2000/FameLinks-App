import 'package:famelink/dio/api/api.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ImprovementFeedbackScreen extends StatefulWidget {
  const ImprovementFeedbackScreen({Key? key}) : super(key: key);

  @override
  _ImprovementFeedbackScreenState createState() =>
      _ImprovementFeedbackScreenState();
}

class _ImprovementFeedbackScreenState extends State<ImprovementFeedbackScreen> {
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
              text: 'Your',
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w400,
                  color: black,
                  fontSize: ScreenUtil().setSp(18))),
          TextSpan(
              text: ' Feedback',
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(18),
                  color: lightRed)),
          TextSpan(
              text: ' is Welcome',
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(18),
                  color: black))
        ])),
      ),
      body: Container(
          width: ScreenUtil().screenWidth,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(88)),
                  width: ScreenUtil().setWidth(273),
                  child: TextFormField(
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(500),
                    ],
                    controller: commentController,
                    minLines: 11,
                    maxLines: 11,
                    keyboardType: TextInputType.multiline,
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil().setSp(12),
                        color: darkGray),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(18),
                          left: ScreenUtil().setWidth(17),
                          right: ScreenUtil().setWidth(17)),
                      hintText: 'Please describe your suggestions to improve',
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
                      top: ScreenUtil().setHeight(150),
                      bottom: ScreenUtil().setHeight(187)),
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
      Api.post.call(context, method: "users/feedback", param: map,
          onResponseSuccess: (Map object) {
        Navigator.pop(context, true);
      });
    } else {
      Constants.toastMessage(msg: "Please describe your suggestions");
    }
  }
}
