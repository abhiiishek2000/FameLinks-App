import 'package:famelink/ui/authentication/login_screen.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/config/image.dart';
import 'package:famelink/util/config/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class StartTourScreen extends StatefulWidget {

  @override
  _StartTourScreenState createState() => _StartTourScreenState();
}

class _StartTourScreenState extends State<StartTourScreen> {

  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(159), // here the desired height
          child: Padding(
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(48),
              left: ScreenUtil().setWidth(40),
              right: ScreenUtil().setWidth(30.71),
            ),
            child: _topBar(context),
          )),
      body: IntroductionScreen(
        isProgress: false,
        globalBackgroundColor: appBackgroundColor,
        rawPages: [
          Container(
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(40),top: ScreenUtil().setHeight(36)),
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30),bottom: ScreenUtil().setHeight(40)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //_topBar(context),
                Text('You be the judge',
                    style: GoogleFonts.kaushanScript(
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(24),
                        color: black)),
                Row(
                  children: [
                    Container(
                      child: Image.asset("assets/icons/tour_famlinks.png"),
                      margin:
                      EdgeInsets.only(top: ScreenUtil().setWidth(23)),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: ScreenUtil().setWidth(22),top: ScreenUtil().setWidth(23)),
                      width: ScreenUtil().setWidth(260),
                      child: Text(letOpinion,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenUtil().setSp(14),
                              color: black)),
                    ),
                  ],
                ),
                Container(
                  margin:
                  EdgeInsets.only(top: ScreenUtil().setWidth(23)),
                  child: Image.asset(
                    startdataone,
                    width: ScreenUtil().setWidth(332),
                    height: ScreenUtil().setHeight(307),
                  ),
                ),
                // Container(
                //   alignment: Alignment.bottomRight,
                //   child:
                //       ElevatedButton(onPressed: () {},
                //           child: Text('Next')),
                // ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(40),top: ScreenUtil().setHeight(7)),
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30),bottom: ScreenUtil().setHeight(40)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Hall of Fame',
                        style: GoogleFonts.kaushanScript(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(24),
                            color: darkBlue)),
                    Image.asset(crownicon,width: ScreenUtil().setWidth(60),
                    height: ScreenUtil().setHeight(60)),

                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(21)),
                  width: ScreenUtil().setWidth(311),
                  child: Text(hallOfFame,
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(14),
                          color: black)),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(21)),
                  child: Image.asset(hallofFame),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(40),top: ScreenUtil().setHeight(36)),
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30),bottom: ScreenUtil().setHeight(40)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //_topBar(context),
                Text.rich(TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: "Entertain on ",
                      style: GoogleFonts.kaushanScript(
                          fontWeight: FontWeight.w400,

                          fontSize: ScreenUtil().setSp(24),
                          color: black)),
                  TextSpan(
                      text: "FunLinks",
                      style: GoogleFonts.kaushanScript(
                          fontWeight: FontWeight.w400,

                          fontSize: ScreenUtil().setSp(24),
                          color: lightRed))
                ])),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(21)),
                      width: ScreenUtil().setWidth(229),
                      child: Text(letOpinion,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenUtil().setSp(14),
                              color: black)),
                    ),
                    Image.asset(video,width: ScreenUtil().setWidth(80),height: ScreenUtil().setHeight(70),)

                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  margin:
                  EdgeInsets.only(top: ScreenUtil().setWidth(23)),
                  child: Image.asset(
                    startfun,
                  ),
                ),
                // Container(
                //   alignment: Alignment.bottomRight,
                //   child:
                //       ElevatedButton(onPressed: () {},
                //           child: Text('Next')),
                // ),
              ],
            ),
          ),
        ],
        initialPage: selectedPage,
        done: Container(
            height: ScreenUtil().setHeight(38),
            decoration:BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [lightRedWhite, lightRed]),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(ScreenUtil().radius(30)),
                  topLeft: Radius.circular(ScreenUtil().radius(30)),
                  topRight: Radius.circular(ScreenUtil().radius(30))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Register',
                  style: GoogleFonts.nunitoSans(
                      color:white,
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Icon(Icons.arrow_forward_rounded,color: white,),
              ],
            )),
        onDone: () => goToHome(context),
        showSkipButton: false,
       /* skip: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.arrow_back_outlined,color: black,),
            SizedBox(
              width: ScreenUtil().setWidth(10),
            ),
            Text(
              'Previous',
              style: GoogleFonts.nunitoSans(
                  color:black,
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        onSkip: () {
          setState(() {
            selectedPage--;
          });
        },*/
        next: Container(
          height: ScreenUtil().setHeight(38),
            decoration:BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [lightRedWhite, lightRed]),
           borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(ScreenUtil().radius(30)),
            topLeft: Radius.circular(ScreenUtil().radius(30)),
            topRight: Radius.circular(ScreenUtil().radius(30))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Next',
              style: GoogleFonts.nunitoSans(
                  color:white,
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(10),
            ),
            Icon(Icons.arrow_forward_rounded,color: white,),
          ],
        )),
        showNextButton: true,
        onChange: (count){
          setState(() {
            selectedPage = count;
          });
        },
      ),
    );
  }

  final pageDecor = PageDecoration(
      fullScreen: true,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
      bodyTextStyle: TextStyle(color: Color(0xFF262626)),
      contentMargin: EdgeInsets.all(8));

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );

  Widget _topBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: ScreenUtil().setSp(75),
              height: ScreenUtil().setSp(75),
              padding: EdgeInsets.all(ScreenUtil().setSp(18)),
              decoration: new BoxDecoration(
                border: Border.all(
                    color: Colors.white, width: ScreenUtil().setSp(2)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [lightRedWhite, lightRed]),
                shape: BoxShape.circle,
              ),
              child:
              SvgPicture.asset("assets/icons/svg/logo_splash.svg"),
            ),
            Text(selectedPage == 2 ?funlinks:famelinks,
                style: GoogleFonts.kaushanScript(
                    fontWeight: FontWeight.w400,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0, 4),
                        blurRadius: 4.0,
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ],
                    fontSize: ScreenUtil().setSp(24),
                    color: lightRed)),
          ],
        ),
        Visibility(
          visible: selectedPage != 2,
          child: InkWell(
            onTap: () => goToHome(context),
            child: Row(
              children: [
                Text(
                  'Skip',
                  style: GoogleFonts.nunitoSans(
                      color: buttonBlue,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w600),
                ),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: buttonBlue,
                  size: ScreenUtil().radius(25),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
