import 'package:famelink/ui/joblinks/brandPage.dart';
import 'package:famelink/ui/joblinks/createOffer2.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CreateOffer extends StatefulWidget {


  @override
  State<CreateOffer> createState() => _CreateOfferState();
}

class _CreateOfferState extends State<CreateOffer> {
  int index = 0;
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  ScrollController locationScrollController = ScrollController();
  String time = '';
  double reach = 10000.0;
  List ageGroup = ['0 - 2', '2 - 6', '6 - 12', '12 - 18', '18 - 28', '28 - 40', '40 - 60', '60+', ];
  List ageSelected = [];
  int genderIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(16), right: ScreenUtil().setWidth(25), top: ScreenUtil().setHeight(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_rounded, color: black, size: ScreenUtil().radius(20),)
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "Create ",
                          style: GoogleFonts.roboto(
                              fontSize: ScreenUtil().setSp(18),
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              height: 0.25,
                              color: black
                          ),
                        ),
                        TextSpan(
                          text: "Offer",
                          style: GoogleFonts.roboto(
                            fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            height: 0.25,
                            color: orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text("1/2",
                  style: GoogleFonts.roboto(
                    fontSize: ScreenUtil().setSp(12),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    height: 0.16,
                    color: darkGray,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(24), right: ScreenUtil().setWidth(24)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 30.h),
                          child: Text(
                            "Offer Type: ",
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: black
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.w, top: 22.h),
                            child: IntrinsicWidth(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text('Posting',
                                            style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: darkGray,
                                              fontSize: ScreenUtil().setSp(14),
                                            ),
                                          ),
                                          SizedBox(
                                            width: ScreenUtil().setWidth(5),
                                          ),
                                          Icon(Icons.arrow_drop_down_sharp, size: 30.r, color: darkGray,),
                                        ],
                                      ),
                                      Container(
                                        height: 1,
                                        color: darkGray,
                                      ),
                                    ]
                                )
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(top: 30.h),
                          child: Text(
                            "Club: ",
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: black
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.w, top: 22.h),
                            child: IntrinsicWidth(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text('Rising Club',
                                            style: GoogleFonts.nunitoSans(
                                              fontWeight: FontWeight.w400,
                                              color: darkGray,
                                              fontSize: ScreenUtil().setSp(14),
                                            ),
                                          ),
                                          SizedBox(
                                            width: ScreenUtil().setWidth(5),
                                          ),
                                          Icon(Icons.arrow_drop_down_sharp, size: 30.r, color: darkGray,),
                                        ],
                                      ),
                                      Container(
                                        height: 1,
                                        color: darkGray,
                                      ),
                                    ]
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(15), right: ScreenUtil().setWidth(24), top: ScreenUtil().setHeight(25)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            if(index == 1 || index == 2){
                              setState(() {
                                index = 0;
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10.w),
                                child: Container(
                                  height: ScreenUtil().setHeight(14),
                                  width: ScreenUtil().setWidth(14),
                                  decoration: BoxDecoration(
                                      color: index == 0 ? orange : white,
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(color: black)
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: ScreenUtil().setWidth(6)),
                                child: Text(
                                  "FollowLinks",
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: index == 0 ? FontWeight.w700 : FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      color: Color(0xff4B4E58)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 30.w),
                        InkWell(
                          onTap: (){
                            if(index == 0 || index == 2){
                              setState(() {
                                index = 1;
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: ScreenUtil().setWidth(8)),
                                child: Container(
                                  height: ScreenUtil().setHeight(14),
                                  width: ScreenUtil().setWidth(14),
                                  decoration: BoxDecoration(
                                      color: index == 1 ? orange : white,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(color: black)
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: ScreenUtil().setWidth(6)),
                                child: Text(
                                  "FunLinks",
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: index == 1 ? FontWeight.w700 : FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      color: Color(0xff4B4E58)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 40.h),
                    child: Container(
                      height: 1,
                      color: lightGray,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Start By:",
                          style: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: black
                          ),
                        ),
                        SizedBox(width: 8.w),
                        InkWell(
                          onTap:(){
                            setState(() {
                              selectDate(context);
                            });
                          },
                          child: Container(
                            width: 100.w,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 2.w, right: 2.w),
                                  child: Row(
                                    children: [
                                      Text(
                                        dateController.text,
                                        style: GoogleFonts.nunitoSans(
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            color: black
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(Icons.calendar_today_sharp, size: 12.r),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5.h,),
                                Container(
                                  height: 1,
                                  color: lightGray,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          "at",
                          style: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: black
                          ),
                        ),
                        SizedBox(width: 8.w),
                        InkWell(
                          onTap:(){
                            selectTime();
                          },
                          child: Column(
                            children: [
                              Text(
                                timeController.text,
                                style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(12),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    color: black
                                ),
                              ),
                              SizedBox(height: 5.h,),
                              Container(
                                height: 1,
                                width: 38.w,
                                color: lightGray,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          time.toUpperCase(),
                          style: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: black
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 45.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expected Reach:',
                          style: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              color: black
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackHeight: 1.5,
                                  trackShape: RoundedRectSliderTrackShape(),
                                  activeTrackColor: lightGray,
                                  inactiveTrackColor: lightGray,
                                  thumbColor: black,
                                  overlayColor: Colors.transparent,
                                  overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
                                  tickMarkShape: RoundSliderTickMarkShape(),
                                  activeTickMarkColor: Colors.transparent,
                                  inactiveTickMarkColor: Colors.transparent,
                                  valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                                  valueIndicatorColor: Colors.transparent,
                                  valueIndicatorTextStyle: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      color: black
                                  ),
                                ),
                                child: Slider(
                                  min: 0.0,
                                  max: 25000.0,
                                  value: reach.roundToDouble(),
                                  divisions: 20,
                                  label: '${reach.round()}',
                                  onChanged: (value) {
                                    setState(() {
                                      reach = value;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.w, top: 8.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'in',
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          color: darkGray
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Container(
                                      width: 38.w,
                                      child: IntrinsicWidth(
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              textAlign: TextAlign.center,
                                              controller: daysController,
                                              keyboardType: TextInputType.number,
                                              textInputAction: TextInputAction.next,
                                              cursorColor: black,
                                              validator: (v){
                                                if(v!.isEmpty){
                                                  return 'Enter no. of days';
                                                }else{
                                                  return null;
                                                }
                                              },
                                              style: GoogleFonts.nunitoSans(
                                                  fontSize: ScreenUtil().setSp(12),
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  color: black),
                                              decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.zero,
                                                  border: InputBorder.none,
                                                  isDense: true,
                                                  hintText: '10',
                                                  hintStyle: GoogleFonts.nunitoSans(
                                                      fontSize: ScreenUtil().setSp(12),
                                                      fontStyle: FontStyle.normal,
                                                      fontWeight: FontWeight.w400,
                                                      color: black)),
                                            ),
                                            SizedBox(height: 3.h),
                                            Container(height: 1, color: lightGray),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'Days',
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          color: darkGray
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 16.h),
                    child: Container(
                      height: 1,
                      color: lightGray,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 30.h),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                          child: Text(
                            "Category:",
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                color: black
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Container(
                            height: 30.h,
                            child: TextField(
                              onChanged: (_) {},
                              onSubmitted: (_) {},
                              controller: categoryController,
                              maxLines: 1,
                              keyboardType: TextInputType.multiline,
                              style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                color: black,
                                height: 2,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                isDense: true,
                                hintText: 'Search Categories',
                                hintStyle: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(12),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  color: lightGray,
                                  height: 2,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: lightGray, width: 1)
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: lightGray, width: 1)
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.all(5.r),
                                  child: SvgPicture.asset(
                                    "assets/icons/svg/search.svg",
                                    color: lightGray,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Text(
                            '0 left',
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                color: orange
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 45.w, top: 10.h, right: 16.w),
                    child: Text(
                      '#Makeup, #Beauty Product, #Saloon Product',
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: black
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, top: 20.h, right: 60.w),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(ScreenUtil().radius(8)),
                        border: Border.all(color: Color(0xff9B9B9B)),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                        child: Column(
                          children: [
                            Container(
                              height: 30.h,
                              child: TextField(
                                onChanged: (_) {},
                                onSubmitted: (_) {},
                                controller: locationController,
                                maxLines: 1,
                                keyboardType: TextInputType.multiline,
                                style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(12),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                    color: black,
                                    height: 1
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Choose Promter Locations',
                                  hintStyle: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(12),
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                      color: lightGray,
                                      height: 1
                                  ),
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.all(5.r),
                                    child: SvgPicture.asset(
                                      "assets/icons/svg/search.svg",
                                      color: lightGray,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: lightGray, width: 1)
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: lightGray, width: 1)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: ScreenUtil().setHeight(10), bottom: ScreenUtil().setHeight(10)),
                              child: Scrollbar(
                                controller: locationScrollController,
                                isAlwaysShown: true,
                                thickness: 3,
                                trackVisibility: true,
                                radius: Radius.circular(50),
                                child: Container(
                                  height: 90,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    controller: locationScrollController,
                                    itemCount: 2,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    primary: false,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Padding(
                                        padding: EdgeInsets.only(top: ScreenUtil().setHeight(3)),
                                        child: Text(
                                          "Ujjain, Madhyapradesh, India\nUtterpradesh, India\nTamil Nadu, India\nAhmedabad, Gujarat, India",
                                          style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(12),
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.italic,
                                              color: Color(0xff4B4E58)
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(24), left: ScreenUtil().setWidth(24), right: ScreenUtil().setWidth(24)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                          child: Text(
                            'Age  ',
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w600,
                                color: black,
                                fontSize: ScreenUtil().setSp(14),
                                letterSpacing: 0.6
                            ),
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.all(0.0),
                            primary: false,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 2,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                            ),
                            itemCount: ageGroup.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext ctx, index) {
                              return InkWell(
                                onTap: (){
                                  setState(() {
                                    if(ageSelected.contains(ageGroup[index])){
                                      ageSelected.remove(ageGroup[index]);
                                    }else{
                                      ageSelected.add(ageGroup[index]);
                                    }
                                  });
                                },
                                child: Wrap(
                                  children: [
                                    Container(
                                      width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(ScreenUtil().radius(15)),
                                        border: Border.all(color: black),
                                        color: ageSelected.contains(ageGroup[index]) ? Color(0xff4B4E58) : Colors.white,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(top: ScreenUtil().setHeight(6), bottom: ScreenUtil().setHeight(6)),
                                        child: Text(
                                          ageGroup[index],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(12),
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              color: ageSelected.contains(ageGroup[index]) ? white : black
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(20), left: ScreenUtil().setWidth(24), right: ScreenUtil().setWidth(24)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                          child: Text(
                            'Gender  ',
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w600,
                                color: black,
                                fontSize: ScreenUtil().setSp(14),
                                letterSpacing: 0.6
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              if(genderIndex == 1 || genderIndex == 2){
                                setState(() {
                                  genderIndex = 0;
                                });
                              }
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                height: ScreenUtil().setHeight(40),
                                width: ScreenUtil().setWidth(40),
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                    color: genderIndex == 0 ? darkGray : white,
                                    border: Border.all(
                                      color:  genderIndex == 0 ? white : lightGray,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(20)))),
                                child: SvgPicture.asset(
                                    "assets/icons/svg/male.svg",
                                    color:  genderIndex == 0
                                        ? white
                                        : lightGray,
                                    fit: BoxFit.scaleDown
                                ),
                              ),
                              Text(
                                'Male',
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w600,
                                    color: genderIndex == 0
                                        ? black
                                        : lightGray,
                                    fontSize: ScreenUtil().setSp(12),
                                    letterSpacing: 0.6
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                if(genderIndex == 0 || genderIndex == 2){
                                  setState(() {
                                    genderIndex = 1;
                                  });
                                }
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: ScreenUtil().setHeight(40),
                                  width: ScreenUtil().setWidth(40),
                                  padding: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                      color: genderIndex == 1 ? darkGray : white,
                                      border: Border.all(
                                        color:  genderIndex == 1 ? white : lightGray,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(20)))),
                                  child: SvgPicture.asset(
                                      "assets/icons/svg/female.svg",
                                      color:  genderIndex == 1
                                          ? white
                                          : lightGray,
                                      fit: BoxFit.scaleDown
                                  ),
                                ),
                                Text(
                                  'Female',
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w600,
                                      color: genderIndex == 1
                                          ? black
                                          : lightGray,
                                      fontSize: ScreenUtil().setSp(12),
                                      letterSpacing: 0.6
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                if(genderIndex == 0 || genderIndex == 1){
                                  setState(() {
                                    genderIndex = 2;
                                  });
                                }
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: ScreenUtil().setHeight(40),
                                  width: ScreenUtil().setWidth(40),
                                  padding: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                      color: genderIndex == 2 ? darkGray : white,
                                      border: Border.all(
                                        color:  genderIndex == 2 ? white : lightGray,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(20)))),
                                  child: Image.asset(
                                      "assets/icons/line.png",
                                      color: genderIndex == 2
                                          ? white
                                          : lightGray,
                                      fit: BoxFit.scaleDown
                                  ),
                                ),
                                Text(
                                  'Other',
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w600,
                                      color: genderIndex == 2
                                          ? black
                                          : lightGray,
                                      fontSize: ScreenUtil().setSp(12),
                                      letterSpacing: 0.6
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateOffer2()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(24.r),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.arrow_forward, color: orange, size: 30.r)
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (newSelectedDate != null) {
      setState(() {
        dateController
          ..text = DateFormat("dd-MMM-yyyy").format(newSelectedDate)
          ..selection = TextSelection.fromPosition(
              TextPosition(
                  offset: dateController.text.length,
                  affinity: TextAffinity.upstream
              )
          );
      });
    }
  }

  selectTime() async {
    TimeOfDay? startTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (startTime != null) {
      setState(() {
        time = startTime.period.name;
        print((startTime.hour.toInt()/12).toString());
        timeController.text = (startTime.hour.toInt()%12).toInt().toString() + ':' + startTime.minute.toString();
      });
    }
  }
}