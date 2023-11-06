import 'package:dio/dio.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/HallOfFameModel.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/BrandAmbassadorsScreen.dart';
import 'package:famelink/ui/notification/notification_screen.dart';
import 'package:famelink/ui/profile/agency_profile_screen.dart';
import 'package:famelink/ui/profile/brand_profile_screen.dart';
import 'package:famelink/ui/profile/profile_screen.dart';
import 'package:famelink/util/UnicornOutlineButton.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/config/image.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

import 'FameChatScreen.dart';
import 'authentication/login_screen.dart';
import 'challenge/challenge_screen.dart';

class HallOfFameScreen extends StatefulWidget {
  @override
  _HallOfFameScreenState createState() => _HallOfFameScreenState();
}

class _HallOfFameScreenState extends State<HallOfFameScreen>
    with TickerProviderStateMixin {
  AnimationController? _speedDialController;
  final ApiProvider _api = ApiProvider();
  Result? hallOfFameModel;
  String selectedCountry = "india";
  String? selectedState;
  String? selectedDistrict;
  String selectedAge = "groupA";
  String selectedYear = "";
  bool yearHalf = false;
  List<String> stateList = [];
  List<String> districtList = [];
  List<String> yearList = [];

  int? currentMonth;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speedDialController = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy');
    var formatterMonth = new DateFormat('MM');
    String currentYear = formatter.format(now);
    selectedYear = currentYear;
    currentMonth = int.parse(formatterMonth.format(now));
    int length = (int.parse(currentYear) - 2021)+1;
    for(int i=0; i<length; i++){
      yearList.add((int.parse(currentYear) - i).toString());
    }
    getFirstStates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        openBackgroundColor: appBackgroundColor,
        closedBackgroundColor: appBackgroundColor,
        controller: _speedDialController,
        child: UnicornOutlineButton(
          strokeWidth:
          ScreenUtil()
              .setSp(2),
          bottomLeftRadius:
          ScreenUtil()
              .setSp(28),
          bottomRightRadius:
          ScreenUtil()
              .setSp(28),
          topLeftRadius:
          ScreenUtil()
              .setSp(28),
          topRightRadius:
          ScreenUtil()
              .setSp(28),
          gradient: LinearGradient(
              begin: Alignment
                  .centerLeft,
              end: Alignment
                  .centerRight,
              colors: [
                profileBorder1,
                profileBorder2,
                profileBorder3,
                profileBorder4
              ]),
          onPressed: () {
            if (!_speedDialController!.isDismissed) {
              _speedDialController!.reverse();
            }else{
              _speedDialController!.animateTo(100);
            }
          },
          child: Container(
            height: ScreenUtil().setSp(56),
            width: ScreenUtil().setSp(56),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().setSp(28)),
            ),
            padding: EdgeInsets.all(ScreenUtil().setSp(18)),
            child: SvgPicture.asset(
              home,
            ),
          ),
        ),
        speedDialChildren: <SpeedDialChild>[
          SpeedDialChild(
            backgroundColor: white,
            label: 'Notification',
            child: IconButton(
                onPressed: () {
                  if (!_speedDialController!.isDismissed) {
                    _speedDialController!.reverse();
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationScreen()),
                  );
                },
                icon: SvgPicture.asset(notifications, color: black)), onPressed: (){

          },
          ),
          SpeedDialChild(
            backgroundColor: white,
            label: 'Message',
            child: IconButton(
                onPressed: () {
                  if (!_speedDialController!.isDismissed) {
                    _speedDialController!.reverse();
                  }
                  Constants.profileUserId = Constants.userId;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => FameChatScreen()),
                  );
                },
                icon: SvgPicture.asset(messages, color: black)), onPressed: (){

          },
          ),
          /*SpeedDialChild(
            backgroundColor: white,
            label: 'Hall of Fame',
            child: IconButton(
                onPressed: () {
                  if (!_speedDialController.isDismissed) {
                    _speedDialController.reverse();
                  }
                },
                icon: SvgPicture.asset(halloffame, color: black)),
          ),*/
          SpeedDialChild(
            backgroundColor: white,
            label: 'Trendz',
            child: IconButton(
                onPressed: () async {
                  if (!_speedDialController!.isDismissed) {
                    _speedDialController!.reverse();
                  }
                  var result = await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ChallengeScreen()),
                  );
                  if (result != null) {
                    Map map = result;
                    FormData formData = FormData.fromMap({
                      "challengeId": map['challengeId'],
                      "description": map['description'],
                      "closeUp": map['closeUp'],
                      "medium": map['medium'],
                      "long": map['long'],
                      "pose1": map['pose1'],
                      "pose2": map['pose2'],
                      "additional": map['additional'],
                      "video": map['video'],
                    });
                    Api.uploadPost.call(context,
                        method: "media/contest",
                        param: formData, onResponseSuccess: (Map object) {
                      var snackBar = SnackBar(
                        content: Text('Uploaded'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  }
                },
                icon: SvgPicture.asset(challenge, color: black)), onPressed: (){

          },
          ),
          SpeedDialChild(
              backgroundColor: white,
              label: 'Profile',
              onPressed: () async {
                if (!_speedDialController!.isDismissed) {
                  _speedDialController!.reverse();
                }
                Constants.profileUserId = Constants.userId;
                var result;
                if(Constants.userType == "agency"){
                  result = await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AgencyProfileScreen()));
                }else if(Constants.userType == "brand"){
                  result = await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BrandProfileScreen()));
                }else {
                  result = await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen()));
                }
                if (result != null && result == true) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }
              },
              child: SvgPicture.asset(profile, color: black)),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        color: appBackgroundColor,
        padding: EdgeInsets.only(top: ScreenUtil().setSp(55)),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: ScreenUtil().setSp(10),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BrandAmbassadorsScreen()),
                    );
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/svg/brand_ambassadors.svg",
                        color: buttonBlue,
                      ),
                      Text('Ambassadors',
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w400,
                              color: buttonBlue,
                              fontSize: ScreenUtil().setSp(10))),
                    ],
                  ),
                ),
                Expanded(
                  child: Text('Hall of Fame',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.fascinateInline(
                          fontWeight: FontWeight.w900,
                          color: black,
                          fontSize: ScreenUtil().setSp(30))),
                ),
                SvgPicture.asset("assets/icons/svg/search.svg",
                    color: lightGray),
                SizedBox(
                  width: ScreenUtil().setSp(15),
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setSp(13),
            ),
            Row(
              children: [
                SizedBox(
                  width: ScreenUtil().setSp(15),
                ),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text("District",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            fontSize:
                            ScreenUtil().setSp(14),
                            color: darkGray)),
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(14),
                        color: darkGray),
                    value: selectedDistrict,
                    items: districtList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w400,
                                fontSize:
                                ScreenUtil().setSp(14),
                                color: darkGray)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDistrict = newValue;
                      });
                      _profile();
                    },
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setSp(8),
                ),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text("State",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            fontSize:
                            ScreenUtil().setSp(14),
                            color: darkGray)),
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(14),
                        color: darkGray),
                    value: selectedState,
                    items: stateList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w400,
                                fontSize:
                                ScreenUtil().setSp(14),
                                color: darkGray)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedState = newValue;
                      });
                      getDistrict();
                    },
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setSp(15),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(16),
                    bottom: ScreenUtil().setHeight(8),
                    left: ScreenUtil().setWidth(22),
                    right: ScreenUtil().setWidth(22)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap:(){
                                setState(() {
                                  selectedAge = "groupA";
                                });
                                _profile();
                              },
                              child: CircleAvatar(
                                backgroundColor: selectedAge == "groupA" ? lightRed:lightGray,
                                radius: ScreenUtil().radius(23),
                                child: CircleAvatar(
                                  backgroundColor: white,
                                  radius: ScreenUtil().radius(21),
                                  backgroundImage: AssetImage(
                                      "assets/images/model.png"),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().radius(16),
                              child: VerticalDivider(
                                width: 1,
                                color: selectedAge == "groupA" ? lightRed:lightGray,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap:(){
                                setState(() {
                                  selectedAge = "groupB";
                                });
                                _profile();
                              },
                              child: CircleAvatar(
                                backgroundColor: selectedAge == "groupB" ? lightRed:lightGray,
                                radius: ScreenUtil().radius(23),
                                child: CircleAvatar(
                                  backgroundColor: white,
                                  radius: ScreenUtil().radius(21),
                                  backgroundImage: AssetImage(
                                      "assets/images/groupB.png"),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().radius(16),
                              child: VerticalDivider(
                                width: 1,
                                color: selectedAge == "groupB" ? lightRed:lightGray,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap:(){
                                setState(() {
                                  selectedAge = "groupC";
                                });
                                _profile();
                              },
                              child: CircleAvatar(
                                backgroundColor: selectedAge == "groupC" ? lightRed:lightGray,
                                radius: ScreenUtil().radius(23),
                                child: CircleAvatar(
                                  backgroundColor: white,
                                  radius: ScreenUtil().radius(21),
                                  backgroundImage: AssetImage(
                                      "assets/images/groupC.png"),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().radius(16),
                              child: VerticalDivider(
                                width: 1,
                                color: selectedAge == "groupC" ? lightRed:lightGray,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap:(){
                                setState(() {
                                  selectedAge = "groupD";
                                });
                                _profile();
                              },
                              child: CircleAvatar(
                                backgroundColor: selectedAge == "groupD" ? lightRed:lightGray,
                                radius: ScreenUtil().radius(23),
                                child: CircleAvatar(
                                  backgroundColor: white,
                                  radius: ScreenUtil().radius(21),
                                  backgroundImage: AssetImage(
                                      "assets/images/groupD.png"),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().radius(16),
                              child: VerticalDivider(
                                width: 1,
                                color: selectedAge == "groupD" ? lightRed:lightGray,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap:(){
                                setState(() {
                                  selectedAge = "groupE";
                                });
                                _profile();
                              },
                              child: CircleAvatar(
                                backgroundColor: selectedAge == "groupE" ? lightRed:lightGray,
                                radius: ScreenUtil().radius(23),
                                child: CircleAvatar(
                                  backgroundColor: white,
                                  radius: ScreenUtil().radius(21),
                                  backgroundImage: AssetImage(
                                      "assets/images/groupE.png"),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().radius(16),
                              child: VerticalDivider(
                                width: 1,
                                color: selectedAge == "groupE" ? lightRed:lightGray,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap:(){
                                setState(() {
                                  selectedAge = "groupF";
                                });
                                _profile();
                              },
                              child: CircleAvatar(
                                backgroundColor: selectedAge == "groupF" ? lightRed:lightGray,
                                radius: ScreenUtil().radius(23),
                                child: CircleAvatar(
                                  backgroundColor: white,
                                  radius: ScreenUtil().radius(21),
                                  backgroundImage: AssetImage(
                                      "assets/images/groupF.png"),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().radius(16),
                              child: VerticalDivider(
                                width: 1,
                                color: selectedAge == "groupF" ? lightRed:lightGray,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setSp(16)),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setSp(16)))),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            ScreenUtil().setSp(16)),
                                        topRight: Radius.circular(
                                            ScreenUtil().setSp(16))),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [lightRedWhite, lightRed])),
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(16),
                                    bottom: ScreenUtil().setHeight(8),
                                    left: ScreenUtil().setWidth(5),
                                    right: ScreenUtil().setWidth(5)),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        hallOfFameModel != null && hallOfFameModel!.winner != null ? hallOfFameModel!.winner!.winnerTitles!.title!:"",
                                        style: GoogleFonts.kaushanScript(
                                            fontSize: ScreenUtil().setSp(16),
                                            color: white,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        hallOfFameModel != null  && hallOfFameModel!.winner != null ? hallOfFameModel!.winner!.name!:"",
                                        style: GoogleFonts.kaushanScript(
                                            fontSize: ScreenUtil().setSp(20),
                                            color: white,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setSp(20),
                              ),
                              Stack(
                                children: [
                                  Center(
                                    child: Container(
                                        width: ScreenUtil().setSp(177),
                                        height: ScreenUtil().setSp(180),
                                        margin: EdgeInsets.all(
                                            ScreenUtil().setSp(1)),
                                        alignment: Alignment.center,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().setSp(8)),
                                          child: Image.network(
                                              "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${hallOfFameModel != null  && hallOfFameModel!.winner != null ? hallOfFameModel!.winner!.profileImage:""}",
                                              fit: BoxFit.cover,width:
                                          ScreenUtil().setSp(177),
                                            height:
                                            ScreenUtil().setSp(180),),
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: ScreenUtil().setSp(25),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: ScreenUtil().setSp(15),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Container(
                                              width:
                                                  ScreenUtil().setSp(90),
                                              height:
                                                  ScreenUtil().setSp(90),
                                              alignment: Alignment.center,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        ScreenUtil()
                                                            .setSp(45)),
                                                child: Image.network(
                                                    "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${hallOfFameModel != null && hallOfFameModel!.runnerUp1 != null ? hallOfFameModel!.runnerUp1!.profileImage:""}",
                                                    fit: BoxFit.cover,width:
                                                ScreenUtil().setSp(90),
                                                  height:
                                                  ScreenUtil().setSp(90),),
                                              )),
                                        ),
                                        Text(hallOfFameModel != null  && hallOfFameModel!.runnerUp1 != null? hallOfFameModel!.runnerUp1!.winnerTitles!.title!:"",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                color: black,
                                                fontSize:
                                                    ScreenUtil().setSp(12))),
                                        Text('1st RunnerUp',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w600,
                                                color: buttonBlue,
                                                fontSize:
                                                    ScreenUtil().setSp(12)))
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Container(
                                              width:
                                                  ScreenUtil().setSp(90),
                                              height:
                                                  ScreenUtil().setSp(90),
                                              alignment: Alignment.center,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        ScreenUtil()
                                                            .setSp(45)),
                                                child: Image.network(
                                                    "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${hallOfFameModel != null  && hallOfFameModel!.runnerUp2 != null ? hallOfFameModel!.runnerUp2!.profileImage:""}",
                                                    fit: BoxFit.cover,width:
                                                ScreenUtil().setSp(90),
                                                  height:
                                                  ScreenUtil().setSp(90),),
                                              )),
                                        ),
                                        Text(hallOfFameModel != null   && hallOfFameModel!.runnerUp2 != null ? hallOfFameModel!.runnerUp2!.winnerTitles!.title!:"",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                color: black,
                                                fontSize:
                                                    ScreenUtil().setSp(12))),
                                        Text('2nd RunnerUp',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w600,
                                                color: buttonBlue,
                                                fontSize:
                                                    ScreenUtil().setSp(12)))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setSp(15),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setSp(21),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: ScreenUtil().setSp(8)),
                child: Text('Timeline',
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w400,
                        color: black,
                        fontSize: ScreenUtil().setSp(12))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: ScreenUtil().setSp(108),bottom: ScreenUtil().setSp(12)),
              child: SizedBox(
                height: ScreenUtil().setSp(50),
                child: ListView.builder(
                  itemCount: yearList.length,
                  shrinkWrap: true,
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: ScreenUtil().setSp(17.5)),
                          child: SizedBox(
                            width: index == 0 && currentMonth! <= 6 ? ScreenUtil().setSp(70):ScreenUtil().setSp(140),
                            child: Divider(
                              thickness: 1,
                              height: 1,
                              color: black,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap:(){
                                setState(() {
                                  selectedYear = yearList.elementAt(index);
                                  yearHalf = false;
                                });
                                _profile();
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: ScreenUtil().setSp(22),right: ScreenUtil().setSp(28)),
                                child: Column(
                                  children: [
                                    Container(
                                      height: ScreenUtil().setSp(35),
                                      width: ScreenUtil().setSp(15),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:Alignment.center,
                                            child: VerticalDivider(
                                              thickness: 1,
                                              width: 1,
                                              color: black,
                                            ),
                                          ),
                                          Align(
                                            alignment:Alignment.center,
                                            child: Visibility(visible: selectedYear == yearList.elementAt(index)&& !yearHalf,child: Image.asset("assets/images/select_year.png")),
                                          )
                                        ],
                                      ),
                                    ),
                                    Text(yearList.elementAt(index),
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            color: black,
                                            fontSize: ScreenUtil().setSp(10))),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible:index > 0 || currentMonth! >6,
                              child: InkWell(
                                onTap:(){
                                  setState(() {
                                    selectedYear = yearList.elementAt(index);
                                    yearHalf = true;
                                  });
                                  _profile();
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: ScreenUtil().setSp(29),right: ScreenUtil().setSp(22)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: ScreenUtil().setSp(4)),
                                        child: SizedBox(
                                          height: ScreenUtil().setSp(25),
                                          width: ScreenUtil().setSp(15),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment:Alignment.center,
                                                child: VerticalDivider(
                                                  thickness: 1,
                                                  width: 1,
                                                  color: black,
                                                ),
                                              ),
                                              Align(
                                                alignment:Alignment.center,
                                                child: Visibility(visible: selectedYear == yearList.elementAt(index) && yearHalf,child: Image.asset("assets/images/select_year.png")),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text('H2',
                                          style: GoogleFonts.poly(
                                              fontWeight: FontWeight.w400,
                                              color: black,
                                              fontSize: ScreenUtil().setSp(9),
                                          fontStyle: FontStyle.italic)),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _profile() async {
    Map<String, dynamic> map = {
      "state": selectedState,
      "district": selectedDistrict,
      "ageGroup": selectedAge,
      "year": selectedYear,
      "halfYear": yearHalf ?"true":"false",
    };
    Api.get.call(context, method: "users/halloffame", param: map,
        onResponseSuccess: (Map<dynamic,dynamic> object) async {
          var result = HallOfFameModel.fromJson(object);
          hallOfFameModel = result.result;
          print('RESPONSE ${result.result}');
          setState(() {});
        });
  }

  void getFirstStates() async {
    bool internet = await Constants.isInternetAvailable();
    if (internet) {
      Constants.progressDialog(true, context);
      var result = await _api.getStates(selectedCountry);
      if (result != null) {
        Constants.progressDialog(false, context);
        if (result.success!) {
          stateList = result.result!.states!;
          if(stateList.length > 0) {
            selectedState = stateList.elementAt(0);
          }
          setState(() {});
          getDistrict();
        } else {
          stateList = [];
          setState(() {});
          Constants.toastMessage(msg: result.message);
        }
      }
    }
  }

  void getStates() async {
    bool internet = await Constants.isInternetAvailable();
    if (internet) {
      Constants.progressDialog(true, context);
      var result = await _api.getStates(selectedCountry);
      if (result != null) {
        Constants.progressDialog(false, context);
        if (result.success!) {
          stateList = result.result!.states!;
          setState(() {});
        } else {
          stateList = [];
          setState(() {});
          Constants.toastMessage(msg: result.message);
        }
      }
    }
  }

  void getDistrict() async {
    bool internet = await Constants.isInternetAvailable();
    if (internet) {
      Constants.progressDialog(true, context);
      var result = await _api.getDistrict(selectedCountry, selectedState!);
      if (result != null) {
        Constants.progressDialog(false, context);
        if (result.success!) {
          districtList = result.result!.districts!;
          if(districtList.length > 0) {
            selectedDistrict = districtList.elementAt(0);
          }
          setState(() {});
          _profile();
        } else {
          districtList = [];
          setState(() {});
          Constants.toastMessage(msg: result.message);
        }
      }
    }
  }
}
