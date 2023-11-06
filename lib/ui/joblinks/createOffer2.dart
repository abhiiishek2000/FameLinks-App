import 'package:famelink/ui/joblinks/reviewPromoters.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateOffer2 extends StatefulWidget {
  CreateOffer2({Key? key}) : super(key: key);

  @override
  State<CreateOffer2> createState() => _CreateOffer2State();
}

class _CreateOffer2State extends State<CreateOffer2> {
  TextEditingController msgController = TextEditingController();
  double reach = 170.0;

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
                Text("2/2",
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
              child: Padding(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(24), right: ScreenUtil().setWidth(24), top: 30.h),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Attached your Creatives if you want them to be used by the Promoter",
                      style: GoogleFonts.nunitoSans(
                        fontSize: ScreenUtil().setSp(10),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        color: darkGray
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      width: MediaQuery.of(context).size.width - 48.w,
                      height: 80.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: EdgeInsets.only(right: index == 3 ? 0.w : 8.w),
                            child: Container(
                              height: 80.h,
                              width: 80.h,
                              decoration: BoxDecoration(
                                border: Border.all(color: lightGray, width: 1.r),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.file_upload_outlined, color: lightGray, size: 30.r,),
                                  Text(
                                    "Upload Image",
                                    style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(10),
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      color: darkGray
                                    ),
                                  ),
                                ]
                              )
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(ScreenUtil().radius(10.r)),
                          color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: msgController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        cursorColor: black,
                        minLines: 1,
                        maxLines: 5,
                        maxLength: 50,
                        validator: (v){
                          if(v!.isEmpty){
                            return 'Enter message';
                          }else{
                            return null;
                          }
                        },
                        style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: lightGray),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 13.w, right: 13.w, top: 20.h, bottom: 20.h),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                            borderSide: BorderSide(
                                color: lightGray, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(ScreenUtil().radius(10)),
                            borderSide: BorderSide(color: lightRed, width: 1),
                          ),
                          hintText: 'Short Message to the promoter',
                          hintStyle: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(14),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              color: lightGray)
                        ),
                      ),
                    ),
                    SizedBox(height: 35.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Offer Cost: ',
                          style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Colors.blue
                          ),
                        ),
                        Expanded(
                          child: SliderTheme(
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
                              max: 400.0,
                              value: reach.roundToDouble(),
                              divisions: 40,
                              label: '${reach.round()}',
                              onChanged: (value) {
                                setState(() {
                                  reach = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    InkWell(
                      onTap:(){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ReviewPromoters()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Proceed to Payment ',
                            style: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: orange
                            ),
                          ),
                          Icon(Icons.arrow_forward, color: orange, size: 30.r)
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Text(
                      'How it works?',
                      style: GoogleFonts.nunitoSans(
                        fontSize: ScreenUtil().setSp(12),
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        color: darkGray
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Step 1: Create your Offer with proper details\nStep 2: Complete Payment\nStep 3: Your offer is sent to prospective Influencers who will apply\nStep 4: You select an influncer of your choice\nStep 5: The Influncer post your Graphic / Video content and try to get the required reach\nStep 6: Required Reach is achieved\nStep 7: Payment made to the Influencer',
                      style: GoogleFonts.nunitoSans(
                        fontSize: ScreenUtil().setSp(12),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: darkGray
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Note',
                      style: GoogleFonts.nunitoSans(
                        fontSize: ScreenUtil().setSp(12),
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        color: darkGray
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 6.h),
                          child: Container(
                            height: 6.h,
                            width: 6.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: black,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.h),
                        Flexible(
                          child: Text(
                            'Once the post reached 75% of its milestone, the cost equevalent to achieved % shall be awarded to the promoter, when the offer is closed after the days agreed.',
                            style: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              color: darkGray
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 6.h),
                          child: Container(
                            height: 6.h,
                            width: 6.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: black,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.h),
                        Flexible(
                          child: Text(
                            'Once a Promoter posts your content, the offer can’t be rolled back / cancelled.',
                            style: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              color: darkGray
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 6.h),
                          child: Container(
                            height: 6.h,
                            width: 6.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: black,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.h),
                        Flexible(
                          child: Text(
                            'You can reach out to our support team via messaging “BudLinks Support” in case you need any assistance.',
                            style: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              color: darkGray
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}