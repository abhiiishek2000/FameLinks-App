import 'package:famelink/common/common_image.dart';
import 'package:famelink/ui/joblinks/brandDetailApplication.dart';
import 'package:famelink/ui/joblinks/createJob.dart';
import 'package:famelink/ui/otherUserProfile/OtherFameLinksModel.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class JobLinkNameField extends StatefulWidget {
  int? i;
  JobLinkNameField({ this.i}) ;

  @override
  State<JobLinkNameField> createState() => _JobLinkNameFieldState();
}

class _JobLinkNameFieldState extends State<JobLinkNameField> {
  int index = 2;
  int tabIndex = 0;
  TextEditingController descController = TextEditingController();
  final _scroll = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState((){
      if(index == 2){
        tabIndex = 1;
      }
      if(widget.i != null){
        index = widget.i!;
        tabIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, right: 12.w),
      child: Column(
        children: <Widget>[
          index == 4 || index == 5 ? Container() :
          Container(
            width: ScreenUtil().screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(CommonImage.bottom_shape_container),
                fit: BoxFit.fill,
              ),
            ),
            padding: EdgeInsets.only(top: 5.h, left: 3.w, right: 8.w, bottom: 8.h),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(children: [
                      SizedBox(width: 8.w),
                      Image.asset(
                        "assets/icons/two.png",
                        height: 30.h,
                        width: 30.h,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Sejal Shailesh Patel',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: black,
                        ),
                      ),
                    ]),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 2.h, bottom: 2.h),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(CommonImage.funLinksStoreEditButton),
                              fit: BoxFit.fill,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Edit Profile',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 14.sp,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              color: white.withOpacity(0.75),
                            ),
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Padding(
                  padding: EdgeInsets.only(left: 9.w),
                  child: Divider(
                    height: 1.h,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 7.h),
                Padding(
                  padding: EdgeInsets.only(left: 9.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: [
                        SizedBox(
                          width: ScreenUtil().screenWidth * 0.50.w,
                          child: Text(
                            "Ujjain, Madhya Pradesh, India",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunitoSans(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Text(
                          '10',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        SizedBox(
                          height: 15.68.h,
                          width: 21.33.w,
                          child: Image.asset(
                            CommonImage.funLinksStoreHosportIcon,
                            height: 15.68.h,
                            width: 21.33.w,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ]),
                      Row(children: [
                        SizedBox(
                          height: 16.h,
                          width: 16.w,
                          child: Image.asset(
                            CommonImage.funLinksStoreCoinsIcon,
                            height: 15.h,
                            width: 21.w,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          '200k',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
                SizedBox(height: 7.h),
              ],
            ),
          ),
          index == 4 || index == 5 ? Container() :
          SizedBox(height: 16.h),
          index == 3 || index == 4 || index == 5 ? Container() :
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 116.h,
                width: 110.w,
                child: Stack(
                  children: [
                    Image.asset("assets/icons/rect.png"),
                    Positioned(
                      top: 6.5.h,
                      left: 3.w,
                      child: Image.asset(
                        "assets/icons/girl.png",
                        height: 105.h,
                        width: 105.w,
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            color:
                            Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: white
                                    .withOpacity(
                                    0.5),
                                width: 2.w)),
                        child: Icon(
                            Icons.play_arrow,
                            color: white
                                .withOpacity(0.5)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Greeting message:',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        InkWell(
                          onTap: () {},
                          child: Container(
                              padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 2.h, bottom: 2.h),
                              decoration: BoxDecoration(
                                  border: Border.all(color: orange),
                                  borderRadius: BorderRadius.circular(4.r)
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Edit Message',
                                style: GoogleFonts.nunitoSans(
                                  fontSize: 12.sp,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  color: white,
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      height: 91.h,
                      width: MediaQuery.of(context).size.width - 155.w,
                      child: TextFormField(
                        controller: descController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        cursorColor: black,
                        maxLines: 5,
                        style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: white
                        ),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5.r),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(ScreenUtil().radius(1.r)),
                              borderSide: BorderSide(
                                  color: white.withOpacity(0.6), width: 1
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(ScreenUtil().radius(1.r)),
                              borderSide: BorderSide(color: white.withOpacity(0.6), width: 1),
                            ),
                            hintText: 'Hi <<Name>>,Thank you so much for reaching me out and finding my profile suitable for your project requirement. Shall revert soon and hope to work with you. -Sejal',
                            hintStyle: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: white
                            )
                        ),
                      ),
                    ),
                  ]
              ),
            ],
          ),
          index == 3 || index == 4 || index == 5 ? Container() :
          SizedBox(height: 20.h),
          index == 3
              ? Row(
            children: [
              Text(
                'Job Created: ',
                style: GoogleFonts.nunitoSans(
                  fontSize: 12.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  color: white,
                ),
              ),
              Spacer(),
              InkWell(
                  onTap:(){},
                  child: Container(
                    height: 28.h,
                    width: 28.w,
                    decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: lightGray),
                        borderRadius: BorderRadius.circular(6.r)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(4), left: ScreenUtil().setWidth(5)),
                      child: SvgPicture.asset(
                        "assets/icons/svg/jobedit.svg",
                        height: ScreenUtil().setHeight(16),
                        width: ScreenUtil().setWidth(16),
                      ),
                    ),
                  )
              ),
            ],
          ): Row(
            children: [
              Text(
                'Job Profiles: ',
                style: GoogleFonts.nunitoSans(
                  fontSize: 12.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  color: white,
                ),
              ),
              SizedBox(width: 17.w),
              index == 2 ? Container() :
              InkWell(
                onTap:(){
                  setState(() {
                    tabIndex = 0;
                  });
                },
                child: IntrinsicWidth(
                  child: Column(
                    children: [
                      Text(
                        'Front Faces',
                        style: GoogleFonts.nunitoSans(
                            fontSize: 12.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: tabIndex == 0 ? FontWeight.w700 : FontWeight.w400,
                            color: tabIndex == 0 ? white : white.withOpacity(0.6)
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Container(
                          height: 1,
                          color: tabIndex == 0 ? orange : Colors.transparent
                      )
                    ],
                  ),
                ),
              ),
              index == 2 ? Container() :
              SizedBox(width: 24.w),
              InkWell(
                onTap:(){
                  setState(() {
                    tabIndex = 1;
                  });
                },
                child: IntrinsicWidth(
                  child: Column(
                    children: [
                      Text(
                        'Behind the Scenes',
                        style: GoogleFonts.nunitoSans(
                            fontSize: 12.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: tabIndex == 1 ? FontWeight.w700 : FontWeight.w400,
                            color: tabIndex == 1 ? white : white.withOpacity(0.6)
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Container(
                          height: 1,
                          color: tabIndex == 1 ? orange : Colors.transparent
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              index == 5 ? Container() :
              InkWell(
                  onTap:(){},
                  child: Container(
                    height: 28.h,
                    width: 28.w,
                    decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: lightGray),
                        borderRadius: BorderRadius.circular(6.r)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(4), left: ScreenUtil().setWidth(5)),
                      child: SvgPicture.asset(
                        "assets/icons/svg/jobedit.svg",
                        height: ScreenUtil().setHeight(16),
                        width: ScreenUtil().setWidth(16),
                      ),
                    ),
                  )
              ),
            ],
          ),
          SizedBox(height: 12.h),
          index == 3 ? Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(20), left: ScreenUtil().setWidth(12), right: ScreenUtil().setWidth(12)),
                child: jobs(),
              )
          ) :
          index == 5 ? tabIndex == 0 ? jobs() : jobs() :
          tabIndex == 0
              ? Column(
              children: [
                Row(
                    children: [
                      Text(
                        'Available for:',
                        style: GoogleFonts.nunitoSans(
                            fontSize: 12.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: white
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Container(
                        height: 50.h,
                        width: 160.w,
                        child: ListView.builder(
                            itemCount: 4,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            primary: false,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int i){
                              return Padding(
                                padding: EdgeInsets.only(right: ScreenUtil().setWidth(12), top: ScreenUtil().setWidth(10)),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/svg/photoshoot.svg",
                                      height: ScreenUtil().setHeight(16),
                                      width: ScreenUtil().setWidth(16),
                                      color: orange,
                                    ),
                                    SizedBox(height: ScreenUtil().setHeight(10),),
                                    Text('Print',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w400,
                                          color: white,
                                          fontSize: ScreenUtil().setSp(12),
                                          height: 0.16,
                                        )
                                    ),
                                  ],
                                ),
                              );
                            }
                        ),
                      ),
                    ]
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              children: [
                                Text('Height: ',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    color: white,
                                    fontSize: ScreenUtil().setSp(12),
                                    height: 0.22,
                                  ),
                                ),
                                Text('5’ 6”',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: white,
                                    fontSize: ScreenUtil().setSp(12),
                                    height: 0.22,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Text('Weight: ',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    color: white,
                                    fontSize: ScreenUtil().setSp(12),
                                    height: 0.22,
                                  ),
                                ),
                                Text('56kg',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: white,
                                    fontSize: ScreenUtil().setSp(12),
                                    height: 0.22,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Text('Vitals: ',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    color: white,
                                    fontSize: ScreenUtil().setSp(12),
                                    height: 0.22,
                                  ),
                                ),
                                Text('B 34, W 28, H 30',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: white,
                                    fontSize: ScreenUtil().setSp(12),
                                    height: 0.22,
                                  ),
                                ),
                              ]
                          ),
                          SizedBox(height: 20.h),
                          Row(
                              children: [
                                Text('Eye Color: ',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    color: white,
                                    fontSize: ScreenUtil().setSp(12),
                                    height: 0.22,
                                  ),
                                ),
                                Text('Blue',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: white,
                                    fontSize: ScreenUtil().setSp(12),
                                    height: 0.22,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Text('Complexion: ',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    color: white,
                                    fontSize: ScreenUtil().setSp(12),
                                    height: 0.22,
                                  ),
                                ),
                                Text('Very Fair',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: white,
                                    fontSize: ScreenUtil().setSp(12),
                                    height: 0.22,
                                  ),
                                ),
                              ]
                          ),
                          SizedBox(height: 13.h),
                        ]
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Interested Locations:',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w700,
                        color: white,
                        fontSize: ScreenUtil().setSp(14),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      height: 95.h,
                      width: 130.w,
                      child: Wrap(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.zero,
                              itemCount: 3,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 8.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(height: 5.h, width: 5.w, decoration: BoxDecoration(
                                          color: white,
                                          shape: BoxShape.circle
                                      ),),
                                      SizedBox(width: 5.w),
                                      Text('Delhi',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w400,
                                          color: white,
                                          fontSize: ScreenUtil().setSp(12),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16.h),
                Container(
                    height: 110.h,
                    child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: (){
                              setState(() {
                                show(context);
                              });
                            },
                            child: Container(
                              height: ScreenUtil().setHeight(116),
                              width: ScreenUtil().setWidth(116),
                              child: Image.asset("assets/icons/Rectangle 495.png", height: 116.h, width: 116.h,),
                            ),
                          );
                        })
                ),
                SizedBox(height: 16.h),
              ]
          ): Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    children: [
                      Text(
                        'Available for:',
                        style: GoogleFonts.nunitoSans(
                            fontSize: 12.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: white
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Container(
                        height: 50.h,
                        width: 160.w,
                        child: ListView.builder(
                            itemCount: 2,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            primary: false,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int i){
                              return Padding(
                                padding: EdgeInsets.only(right: ScreenUtil().setWidth(12), top: ScreenUtil().setWidth(10)),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/svg/photoshoot.svg",
                                      height: ScreenUtil().setHeight(16),
                                      width: ScreenUtil().setWidth(16),
                                      color: orange,
                                    ),
                                    SizedBox(height: ScreenUtil().setHeight(10),),
                                    Text('Print',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w400,
                                          color: white,
                                          fontSize: ScreenUtil().setSp(12),
                                          height: 0.16,
                                        )
                                    ),
                                  ],
                                ),
                              );
                            }
                        ),
                      ),
                    ]
                ),
                SizedBox(height: 16.h),
                Text('Awards Won: ',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w700,
                    color: white,
                    fontSize: ScreenUtil().setSp(14),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Text('1. Won Best Photographer of the year from Cine\nAssociation of India\n2. Won International trophy for something useless that i give a shit about',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w400,
                      color: white,
                      fontSize: ScreenUtil().setSp(12),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text('Work Experience: ',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w700,
                    color: white,
                    fontSize: ScreenUtil().setSp(14),
                  ),
                ),
                Text('Won Best Photographer of the year from Cine Lorem ipsum dolor sit amet, consectetur adipiscing elit. In convallis odio quis scelerisque in fringilla elementum tempus.Mauris ac nulla eget ipsum bibendum nunc.Ullamcorper velit, vulputate egestas dictumst sodales tortor, amet morbi.Tortor, amet magna velit et tristique integer.Blandit arcu leo vitae sed senectus mattis... more',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w400,
                    color: white,
                    fontSize: ScreenUtil().setSp(12),
                  ),
                ),
                SizedBox(height: 16.h),
                Text('Interested Locations:',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w700,
                    color: white,
                    fontSize: ScreenUtil().setSp(14),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, top: 5.h),
                  child: Container(
                    height: 95.h,
                    width: 130.w,
                    child: Wrap(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            padding: EdgeInsets.zero,
                            itemCount: 3,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 5.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(height: 5.h, width: 5.w, decoration: BoxDecoration(
                                        color: white,
                                        shape: BoxShape.circle
                                    ),),
                                    SizedBox(width: 5.w),
                                    Text('Delhi',
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w400,
                                        color: white,
                                        fontSize: ScreenUtil().setSp(12),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                    height: 110.h,
                    child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        physics: ClampingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: (){
                              setState(() {
                                show(context);
                              });
                            },
                            child: Container(
                              height: ScreenUtil().setHeight(116),
                              width: ScreenUtil().setWidth(116),
                              child: Image.asset("assets/icons/Rectangle 495.png", height: 116.h, width: 116.h,),
                            ),
                          );
                        })
                ),
                SizedBox(height: 16.h),
              ]
          ),
        ],
      ),
    );
  }

  Container jobs() {
    return Container(
      child: ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        primary: false,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(16)),
            child: Container(
              decoration: BoxDecoration(
                  color: white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.2))),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(10), left: ScreenUtil().setWidth(24)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IntrinsicWidth(
                              child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 14.5.h, right: 10.w),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
                                            child: Text('Female, 18-28 yrs',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w700,
                                                color: white,
                                                fontSize: ScreenUtil().setSp(16),
                                                height: 0.22,
                                                shadows: <Shadow>[
                                                  Shadow(
                                                    offset: Offset(0.0, 2.0),
                                                    blurRadius: 2.0,
                                                    color: Color(0xff000000).withOpacity(0.25),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: ScreenUtil().setWidth(12),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
                                            child: Text('5’ 6”',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w400,
                                                  color: black,
                                                  fontSize: ScreenUtil().setSp(16),
                                                  height: 0.22,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 2.0),
                                                      blurRadius: 2.0,
                                                      color: Color(0xff000000).withOpacity(0.25),
                                                    ),
                                                  ],
                                                )
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 13.h),
                                      child: Container(
                                        height: 1,
                                        decoration: BoxDecoration(
                                            color: white,
                                            boxShadow: [
                                              BoxShadow(
                                                offset: Offset(0, 2),
                                                color: white,
                                                blurRadius: 2.0,
                                              ),
                                            ]
                                        ),
                                      ),
                                    ),
                                  ]
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: Container(
                                height: 50.h,
                                width: 105.w,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: ListView.builder(
                                      itemCount: 1,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (BuildContext context, int i){
                                        return Padding(
                                          padding: EdgeInsets.only(right: ScreenUtil().setWidth(12), top: ScreenUtil().setWidth(10)),
                                          child: Column(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/svg/photoshoot.svg",
                                                height: ScreenUtil().setHeight(25),
                                                width: ScreenUtil().setWidth(25),
                                                color: orange,
                                              ),
                                              SizedBox(height: ScreenUtil().setHeight(10),),
                                              Text('Print',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    color: white,
                                                    fontSize: ScreenUtil().setSp(12),
                                                    height: 0.16,
                                                    shadows: <Shadow>[
                                                      Shadow(
                                                        offset: Offset(0.0, 2.0),
                                                        blurRadius: 2.0,
                                                        color: Color(0xff000000).withOpacity(0.25),
                                                      ),
                                                    ],
                                                  )
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: ScreenUtil().setHeight(20), right: ScreenUtil().setWidth(12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Mumbai',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w700,
                                      color: white,
                                      fontSize: ScreenUtil().setSp(14),
                                      height: 0.19,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 2.0,
                                          color: Color(0xff000000).withOpacity(0.25),
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: ScreenUtil().setHeight(24), right: ScreenUtil().setWidth(6)),
                          child: Container(
                            height: 100.h,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: 2,
                                scrollDirection: Axis.horizontal,
                                controller: _scroll,
                                itemBuilder: (context, i1) {
                                  return i1 == 0
                                      ? Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width - 80,
                                              child: Text(
                                                'Models required for Ethenic Wear shoot',
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w700,
                                                  color: white,
                                                  fontSize: ScreenUtil().setSp(22),
                                                  height: 1.2,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 2.0),
                                                      blurRadius: 2.0,
                                                      color: Color(0xff000000).withOpacity(0.25),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Spacer(),
                                            InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    // scr(1);
                                                  });
                                                },
                                                child: Icon(Icons.arrow_forward_ios_rounded, color: white.withOpacity(0.8), size: ScreenUtil().radius(15),)
                                            )
                                          ],
                                        ),
                                        SizedBox(height: ScreenUtil().setHeight(20),),
                                        Text(
                                          'From 15-Sep-21 till 20-Sep-21',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w600,
                                            color: black,
                                            fontSize: ScreenUtil().setSp(12),
                                            height: 0.16,
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(0.0, 2.0),
                                                blurRadius: 2.0,
                                                color: Color(0xff000000).withOpacity(0.25),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ) : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                // scr(0);
                                              });
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(15)),
                                              child: Icon(Icons.arrow_back_ios_rounded, color: white.withOpacity(0.8), size: 15),
                                            ),
                                          ),
                                          SizedBox(width: ScreenUtil().setWidth(10),),
                                          Container(
                                            width: MediaQuery.of(context).size.width - 88,
                                            child: Text(
                                              "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                              // trimLines: 4,
                                              // trimMode: TrimMode.Line,
                                              // colorClickableText: white,
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                color: white,
                                                fontSize: ScreenUtil().setSp(14),
                                                height: 1.2,
                                                shadows: <Shadow>[
                                                  Shadow(
                                                    offset: Offset(0.0, 2.0),
                                                    blurRadius: 2.0,
                                                    color: Color(0xff000000).withOpacity(0.25),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: ScreenUtil().setHeight(20)),
                                      Padding(
                                        padding: EdgeInsets.only(left: ScreenUtil().setWidth(24)),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Deadline: 13-Sep-21',
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                color: white,
                                                fontSize: ScreenUtil().setSp(14),
                                                height: 0.16,
                                                shadows: <Shadow>[
                                                  Shadow(
                                                    offset: Offset(0.0, 2.0),
                                                    blurRadius: 2.0,
                                                    color: Color(0xff000000).withOpacity(0.25),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 30.0),
                                              child: Text(
                                                'Close',
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w700,
                                                  color: white,
                                                  fontSize: ScreenUtil().setSp(14),
                                                  height: 0.16,
                                                  shadows: <Shadow>[
                                                    Shadow(
                                                      offset: Offset(0.0, 2.0),
                                                      blurRadius: 2.0,
                                                      color: Color(0xff000000).withOpacity(0.25),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: ScreenUtil().setHeight(31)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  'Faces',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w700,
                                    color: white,
                                    fontSize: ScreenUtil().setSp(14),
                                    height: 0.16,
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 2.0),
                                        blurRadius: 2.0,
                                        color: Color(0xff000000).withOpacity(0.25),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              SvgPicture.asset("assets/icons/svg/share.svg", color: white),
                              Spacer(),
                              InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => CreateJob()),
                                  );
                                },
                                child: Container(
                                  height: 30.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                    color: white.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: orange),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Edit Job',
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w600,
                                        color: white,
                                        fontSize: ScreenUtil().setSp(12),
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0.0, 2.0),
                                            blurRadius: 2.0,
                                            color: Color(0xff000000).withOpacity(0.25),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(right: ScreenUtil().setWidth(12)),
                                child: Padding(
                                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(3)),
                                  child: Text(
                                    '3 days ago',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      color: white,
                                      fontSize: ScreenUtil().setSp(10),
                                      height: 0.13,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 2.0,
                                          color: Color(0xff000000).withOpacity(0.25),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(8)),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0.0, 8.0),
                            blurRadius: 30.0,
                            color: Color(0xff000000).withOpacity(0.40),
                          )
                        ]
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(16), right: ScreenUtil().setWidth(15), top: ScreenUtil().setHeight(13), bottom: ScreenUtil().setHeight(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(
                                context, MaterialPageRoute(
                                  builder: (context) => BrandDetailApplication()
                              ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Applications',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    color: black,
                                    fontSize: ScreenUtil().setSp(12),
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Row(
                                  children: [
                                    Container(
                                      height: 60.h,
                                      width: MediaQuery.of(context).size.width - 120.w,
                                      child: ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: 4,
                                          scrollDirection: Axis.horizontal,
                                          controller: _scroll,
                                          itemBuilder: (context, i2) {
                                            return Padding(
                                              padding: EdgeInsets.only(right: 15.w),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: Offset(0, 2),
                                                          color: black,
                                                          blurRadius: 2.r,
                                                        ),
                                                      ]
                                                  ),
                                                  child: Image.asset("assets/icons/two.png", height: 50.h, width: 50.h,)
                                              ),
                                            );
                                          }
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.w),
                                      child: Text(
                                        '20 more',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w400,
                                          color: white,
                                          fontSize: ScreenUtil().setSp(12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.all(1.r),
              child: Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Container(
                    height: 300.h,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: EdgeInsets.only(right: 15.w),
                            child: Container(
                              height: 300.h,
                              width: MediaQuery.of(context).size.width - 100.w,
                              child: SvgPicture.asset("assets/icons/svg/icon.svg",),
                            ),
                          );
                        }
                    )
                ),
              )
          );
        }
    );
  }
}
