import 'dart:async';
import 'dart:ui';

import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/config/image.dart';
import 'package:famelink/util/config/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../util/widgets/custom_fab.dart';
import '../registerToContest/register_to_contest_screen.dart';

class FunlinksFeedScreen extends StatefulWidget {
  @override
  _FunlinksFeedScreenState createState() => _FunlinksFeedScreenState();
}

class _FunlinksFeedScreenState extends State<FunlinksFeedScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    print(ScreenUtil().screenHeight);
    return SafeArea(
        child: Scaffold(
          floatingActionButton: CustomFab(isProfile: false),
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: true,
          // floatingActionButton: CustomFab(),
          appBar: AppBar(
            toolbarHeight: ScreenUtil().setHeight(61),
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text.rich(TextSpan(children: <TextSpan>[
              TextSpan(
                  text: funlinks,
                  style: GoogleFonts.kanit(
                      fontWeight: FontWeight.w400,
                      color: lightRed,
                      fontSize: ScreenUtil().setSp(14))),
              TextSpan(
                  text: ' |$followlinks',
                  style: GoogleFonts.kanit(
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(14),
                      color: lightGray))
            ])),
            actions: [
              Container(
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: lightRed,
                    size: ScreenUtil().setHeight(30),
                  ),
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => RegisterToContestScreen()),
                    // );
                  },
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(funlinksmodel), fit: BoxFit.fill)),
                height: ScreenUtil().setHeight(812),
                width: ScreenUtil().setWidth(375),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: ScreenUtil().setHeight(61)),
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                //margin: EdgeInsets.only(right: 10, top: 10),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: white,
                                    size: ScreenUtil().setHeight(30),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              Container(
                                //margin: EdgeInsets.only(right: 10, top: 10),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.share_outlined,
                                    color: white,
                                    size: ScreenUtil().setHeight(30),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(20),
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      width: ScreenUtil().setWidth(375),
                      height: ScreenUtil().setHeight(281),
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: darkBlue,
                                    ),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                                child: Column(
                                  children: [
                                    IconButton(
                                      icon: SvgPicture.asset(
                                        fullheart,
                                        color: lightGray,
                                        width: ScreenUtil().setWidth(25),
                                        height: ScreenUtil().setHeight(25),
                                      ),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: SvgPicture.asset(
                                        halfheart,
                                        color: lightGray,
                                        width: ScreenUtil().setWidth(25),
                                        height: ScreenUtil().setHeight(25),
                                      ),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: SvgPicture.asset(
                                        emptyheart,
                                        color: lightGray,
                                        width: ScreenUtil().setWidth(25),
                                        height: ScreenUtil().setHeight(25),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Image.asset(
                                  infoiconnotselected,
                                  width: ScreenUtil().setWidth(32),
                                  height: ScreenUtil().setHeight(32),
                                ),
                                onPressed: () {},
                              ),
                              Text(
                                'Katherine vulve',
                                style: GoogleFonts.poppins(
                                    fontSize: ScreenUtil().setSp(16),
                                    color: white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20))),
                                      builder: (context) => buildSheet());
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: SvgPicture.asset(
                                    comment,
                                    color: white,
                                    width: ScreenUtil().setWidth(32),
                                    height: ScreenUtil().setHeight(32),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('#Girls-Make U up',
                                      style: TextStyle(color: white)),
                                  Text(
                                    '2/5',
                                    style: TextStyle(color: white),
                                  ),
                                ],
                              ),
                              Container(
                                // child: Material(
                                //     type: MaterialType.transparency,
                                //     child: Ink(
                                //       decoration: BoxDecoration(
                                //         border: Border.all(
                                //             color: lightRed,
                                //             width: ScreenUtil().setWidth(4)),
                                //         color: white,
                                //         shape: BoxShape.circle,
                                //       ),
                                //       child: InkWell(
                                //         onTap: () {},
                                //         child: Padding(
                                //           padding: EdgeInsets.symmetric(
                                //               horizontal: ScreenUtil().setWidth(14),
                                //               vertical: ScreenUtil().setHeight(14)),
                                //           child: SvgPicture.asset(
                                //             home,
                                //             width: ScreenUtil().setWidth(18.46),
                                //             height: ScreenUtil().setHeight(20),
                                //             color: darkBlue,
                                //           ),
                                //         ),
                                //       ),
                                //     )),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              )
            ],
          ),
        ));
  }

  // void showGetStartedDialog() {
  //   showGeneralDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       barrierLabel:
  //       MaterialLocalizations.of(context).modalBarrierDismissLabel,
  //       barrierColor: Colors.black45,
  //       transitionDuration: const Duration(milliseconds: 0),
  //       pageBuilder: (BuildContext buildContext, Animation animation,
  //           Animation secondaryAnimation) {
  //         return Material(
  //           type: MaterialType.transparency,
  //           child: Container(
  //             alignment: Alignment.topLeft,
  //             padding: EdgeInsets.only(
  //                 left: ScreenUtil().setWidth(63),
  //                 top: ScreenUtil().setHeight(170)),
  //             width: ScreenUtil().setWidth(375),
  //             height: ScreenUtil().setHeight(812),
  //             color: Colors.transparent,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   '''Let's begin...''',
  //                   style: GoogleFonts.kaushanScript(
  //                       fontSize: ScreenUtil().setSp(24),
  //                       color: lightRed,
  //                       fontWeight: FontWeight.normal),
  //                 ),
  //                 Container(
  //                   alignment: Alignment.center,
  //                   padding: EdgeInsets.symmetric(horizontal: 10),
  //                   width: ScreenUtil().setWidth(250),
  //                   height: ScreenUtil().setHeight(40),
  //                   decoration: BoxDecoration(
  //                       color: white.withOpacity(0.5),
  //                       border: Border.all(
  //                         color: lightRed,
  //                       ),
  //                       borderRadius: BorderRadius.all(Radius.circular(5))),
  //                   child: TextField(
  //                     textAlign: TextAlign.left,
  //                     cursorColor: black,
  //                     style: GoogleFonts.poppins(
  //                         fontSize: ScreenUtil().setSp(14),
  //                         color: darkGray,
  //                         fontWeight: FontWeight.normal),
  //                     decoration: InputDecoration(
  //                       border: InputBorder.none,
  //                       hintText: 'Name',
  //                       hintStyle: GoogleFonts.poppins(
  //                           fontSize: ScreenUtil().setSp(14),
  //                           color: darkGray,
  //                           fontWeight: FontWeight.normal),
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
  //                   width: ScreenUtil().setWidth(240),
  //                   height: ScreenUtil().setHeight(60),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                     children: [
  //                       Text(
  //                         'Gender - ',
  //                         style: GoogleFonts.poppins(
  //                             fontSize: ScreenUtil().setSp(14),
  //                             color: white,
  //                             fontWeight: FontWeight.bold),
  //                       ),
  //                       SvgPicture.asset(
  //                         maleunselected,
  //                         height: 65,
  //                         width: 40,
  //                       ),
  //                       SvgPicture.asset(
  //                         femaleselected,
  //                         height: 65,
  //                         width: 40,
  //                       ),
  //                       SvgPicture.asset(
  //                         othersunselected,
  //                         height: 65,
  //                         width: 40,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Container(
  //                   alignment: Alignment.centerLeft,
  //                   width: ScreenUtil().setWidth(245),
  //                   height: ScreenUtil().setHeight(125),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         'Age',
  //                         style: GoogleFonts.poppins(
  //                             fontSize: ScreenUtil().setSp(14),
  //                             color: white,
  //                             fontWeight: FontWeight.bold),
  //                       ),
  //                       chipList(),
  //                     ],
  //                   ),
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
  //                   width: ScreenUtil().setWidth(250),
  //                   height: ScreenUtil().setHeight(35),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                     children: [
  //                       Text(
  //                         'Type',
  //                         style: GoogleFonts.poppins(
  //                             fontSize: ScreenUtil().setSp(14),
  //                             color: white,
  //                             fontWeight: FontWeight.bold),
  //                       ),
  //                       typeChipList(),
  //                     ],
  //                   ),
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
  //                   width: ScreenUtil().setWidth(250),
  //                   child: ElevatedButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: Padding(
  //                       padding: EdgeInsets.symmetric(
  //                           vertical: ScreenUtil().setHeight(10)),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Text(
  //                             'Get Started',
  //                             style: GoogleFonts.poppins(
  //                                 color: lightRed,
  //                                 fontSize: ScreenUtil().setSp(18),
  //                                 fontWeight: FontWeight.w600),
  //                           ),
  //                           Icon(
  //                             Icons.arrow_forward_rounded,
  //                             color: lightRed,
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                     style: ButtonStyle(
  //                         backgroundColor: MaterialStateProperty.all<Color>(
  //                             Colors.transparent),
  //                         shape:
  //                         MaterialStateProperty.all<RoundedRectangleBorder>(
  //                             RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.only(
  //                                   topLeft: Radius.circular(30),
  //                                   topRight: Radius.circular(30),
  //                                   bottomLeft: Radius.circular(0),
  //                                   bottomRight: Radius.circular(30),
  //                                 ),
  //                                 side: BorderSide(color: lightRed)))),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  // chipList() {
  //   return Wrap(
  //     spacing: 8.0,
  //     children: <Widget>[
  //       _buildChip(' 0-5 ', white.withOpacity(0.5)),
  //       _buildChip('6-13', white.withOpacity(0.5)),
  //       _buildChip('14-18', white.withOpacity(0.5)),
  //       _buildChip('18-28', white.withOpacity(0.5)),
  //       _buildChip('29-40', white.withOpacity(0.5)),
  //       _buildChip('41-50', white.withOpacity(0.5)),
  //       _buildChip('51-60', white.withOpacity(0.5)),
  //       _buildChip('60+', white.withOpacity(0.5))
  //     ],
  //   );
  // }
  //
  // Widget _buildChip(String label, Color color) {
  //   return Chip(
  //     label: Text(
  //       label,
  //       style: TextStyle(color: darkGray, fontSize: ScreenUtil().setSp(12)),
  //     ),
  //     backgroundColor: color,
  //     elevation: 6.0,
  //     shadowColor: Colors.grey[60],
  //     padding: EdgeInsets.symmetric(horizontal: 6),
  //   );
  // }
  //
  // typeChipList() {
  //   return Wrap(
  //     spacing: 8,
  //     children: <Widget>[
  //       _buildChip('Individual', white.withOpacity(0.5)),
  //       _buildChip('Agency', white.withOpacity(0.5)),
  //       _buildChip('Brand', white.withOpacity(0.5)),
  //     ],
  //   );
  // }

  Widget buildSheet() => Container(
    child: ListView.builder(
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text('This is the comment line'),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('1 day ago'),
                Text('5 replies'),
                Row(
                  children: [
                    Text('50 likes'),
                    Icon(Icons.circle),
                    Icon(Icons.subdirectory_arrow_left_outlined),
                  ],
                )
              ],
            ),
          ),
        );
      },
    ),
  );

  Widget getWidget() {
    return Container();
  }
}
