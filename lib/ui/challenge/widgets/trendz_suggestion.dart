import 'package:famelink/util/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/config/color.dart';

class TrendzSuggestion extends StatefulWidget {
  const TrendzSuggestion({Key? key}) : super(key: key);

  @override
  State<TrendzSuggestion> createState() => _TrendzSuggestionState();
}

class _TrendzSuggestionState extends State<TrendzSuggestion> {
  final trendzNameController  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        toolbarHeight: ScreenUtil().setHeight(61),
        backgroundColor: appBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(
          TextSpan(children: <TextSpan>[
            TextSpan(
                text: "Submit ",
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w600,
                    color: black,
                    fontSize: ScreenUtil().setSp(16))),
            TextSpan(
                text: "your ",
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w400,
                    color: black,
                    fontSize: ScreenUtil().setSp(14))),
            TextSpan(
                text: "Trendz",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(16),
                    color: lightRed)),
            TextSpan(
                text: " ideas",
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w400,
                    color: black,
                    fontSize: ScreenUtil().setSp(14))),
          ]),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '2/3 left for today',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(11),
                      color: darkGrey),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44),
            child: Column(
              children: [
                Text(
                  'If your Trendz is selected by any Brand or Agency, then you would get 1000 Fame Coins',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(11),
                      color: buttonBlue),
                ),
                CustomTextFieldWidget(
                  keyboardType: TextInputType.name,
                  hintText: 'Trendz Name',
                  validator: (value) {
                    if (value!.isEmpty ||
                        value.trim().length < 3) {
                      return 'Enter your full name';
                    }
                  },
                  controller: trendzNameController,

                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
