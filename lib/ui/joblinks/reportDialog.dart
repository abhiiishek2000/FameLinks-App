import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:famelink/dio/api/apimanager.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportDialog extends StatefulWidget {
  String id;
  String type;
  ReportDialog(this.id, this.type);

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  String reportIndex = 'Nudity';
  List report = ['Nudity', 'Vulgarity', 'Abusive Content', 'Racism', 'Copyright Issues', 'Other'];

  Future<void> reportApi(val) async {
    dynamic param = {
      // 'body': val.toString(),
      'type': val.toString().substring(0).toLowerCase()
    };  
    if(widget.type == 'job'){
      await ApiManager.post(param: param, url1: "/users/report/post/${widget.id}").then((value) async {
        if (value.statusCode == 200) {
          setState((){
            Navigator.pop(context);
            var snackBar = SnackBar(
              content: Text('Reported Successfully'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        } else{
          print(value);
        }
      });
    } else{
      await ApiManager.post(param: param, url1: "/users/report/${widget.id}").then((value) async {
        if (value.statusCode == 200) {
          setState((){
            Navigator.pop(context);
            var snackBar = SnackBar(
              content: Text('Reported Successfully'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        } else{
          print(value);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
          type: MaterialType.transparency,
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.only(left: 70, right: 70),
                  child: Container(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Wrap(children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60.h,
                              decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xffFFA88C), Color(0xffFF5C28)],
                                stops: [0.0, 1.0],
                              ),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Report Post',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      color: white,
                                      fontSize: ScreenUtil().setSp(14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 2,
                              color: black
                            ),
                            SizedBox(height: 30),
                            ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: 6,
                              padding:EdgeInsets.zero,
                              itemBuilder: (context, reportInd) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        reportIndex = report[reportInd];
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          reportIndex == report[reportInd]
                                          ? "assets/icons/selectedRadio.png"
                                          : "assets/icons/radioCircle.png",
                                          height: ScreenUtil().setHeight(14),
                                          width: ScreenUtil().setWidth(14),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: ScreenUtil().setHeight(7.5), left: ScreenUtil().setWidth(6)),
                                          child: Text(
                                            report[reportInd],
                                            style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(14),
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              height: 0.16,
                                              color: reportIndex == report[reportInd] ? black : lightGray
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            ),
                            Container(
                              height: 1,
                              color: lightGray
                            ),
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        reportApi(reportIndex);
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 5.h, left: 35.w),
                                      child: Text(
                                        "Submit",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(14),
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          height: 0.16,
                                          color: black
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 50,
                                    child: VerticalDivider(
                                      color: lightGray,
                                      thickness: 1,
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: (){
                                      setState((){
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Padding(
                                     padding: EdgeInsets.only(top: 5.h, right: 35.w),
                                      child: Text(
                                        "Cancel",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(14),
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          height: 0.16,
                                          color: lightGray
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  )))),
    );
  }
}
