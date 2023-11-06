import 'package:famelink/networking/config.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BrandAmbassadorsScreen extends StatefulWidget {

  @override
  _BrandAmbassadorsScreenState createState() => _BrandAmbassadorsScreenState();
}

class _BrandAmbassadorsScreenState extends State<BrandAmbassadorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: appBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text.rich(TextSpan(children: <TextSpan>[
              TextSpan(
                  text:
                  "Famelinks",
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w400,
                      color: black,
                      fontSize: ScreenUtil().setSp(22))),
              TextSpan(
                  text: " Ambassadors",
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(18),
                      color: lightRed)),
            ])),
            SizedBox(
              width: ScreenUtil().setSp(13),
            ),
            SvgPicture.asset(
              "assets/icons/svg/brand_ambassadors.svg",
              color: buttonBlue,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: ScreenUtil().setSp(31),
              ),
              Expanded(
                child: Text('To become our Brand Ambassador, please email to famelinksapp@gmail.com',
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w700,
                        color: black,
                        fontSize: ScreenUtil().setSp(10))),
              ),
              SizedBox(
                width: ScreenUtil().setSp(23),
              ),
              Text('Ujjain',
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w400,
                      color: black,
                      fontSize: ScreenUtil().setSp(12))),
              SizedBox(
                width: ScreenUtil().setSp(50),
              ),
              SvgPicture.asset("assets/icons/svg/vertical_dropdown.svg"),
              SizedBox(
                width: ScreenUtil().setSp(24),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(left:ScreenUtil().setSp(30)),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: ScreenUtil().setSp(10),
                    ),
                    Text('Madhya Pradesh',
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            color: black,
                            fontSize: ScreenUtil().setSp(12))),
                    SizedBox(
                      height: ScreenUtil().setSp(12),
                    ),
                    SizedBox(
                      height: ScreenUtil().setSp(105),
                      child: ListView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(right:ScreenUtil().setSp(26)),
                            child: Column(
                              children: [
                                Container(
                                    width: ScreenUtil().setSp(60),
                                    height: ScreenUtil().setSp(60),
                                    alignment: Alignment.center,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          ScreenUtil().setSp(index == 0 ?8:30)),
                                      child: Image.network(
                                          "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/famelinks-05ca6d66-0abd-4d9e-b6c8-40ce54e1ab24",
                                          fit: BoxFit.cover),
                                    )),
                                Text('Kulwant Jatra',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w700,
                                        color: black,
                                        fontSize:
                                        ScreenUtil().setSp(12))),
                                Text('Madhya Pradesh',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w400,
                                        color: darkGray,
                                        fontSize:
                                        ScreenUtil().setSp(12)))
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right:ScreenUtil().setSp(14)),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: lightGray,
                      ),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
