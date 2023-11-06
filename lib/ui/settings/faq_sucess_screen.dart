import 'package:famelink/networking/config.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'WebViewScreen.dart';

class FAQSuccessScreen extends StatefulWidget {
  const FAQSuccessScreen({Key? key}) : super(key: key);

  @override
  _FAQSuccessScreenState createState() => _FAQSuccessScreenState();
}

class _FAQSuccessScreenState extends State<FAQSuccessScreen> {

  TextEditingController commentController = new TextEditingController();
  final ApiProvider _api = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: ScreenUtil().screenWidth,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left:ScreenUtil().setWidth(35),right: ScreenUtil().setWidth(35)),
                child: Text("Thanks for your support request. Our representative shall reach you out soon with a possible solution. Untill then, please bare with us",textAlign : TextAlign.center,style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenUtil().setSp(14),
                    color: black)),
              ),
              InkWell(
                onTap: (){
                  Navigator.pop(context, true);
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: ScreenUtil().setSp(34),
                      bottom: ScreenUtil().setSp(100)),
                  width: ScreenUtil().setWidth(250),
                  height: ScreenUtil().setHeight(50),
                  decoration: new BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [lightRedWhite, lightRed]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Go Back',
                        style: GoogleFonts.nunitoSans(
                            color: white,
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(18)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

}
