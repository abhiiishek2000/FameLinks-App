import 'package:famelink/util/Validator.dart';
import 'package:famelink/util/appStrings.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../function/otplogin.dart';

class enterPhoneNumber extends StatelessWidget {
  const enterPhoneNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Otplogin>(
      builder: (context, provider, child) {
        return Container(
          height: 50,
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(5)),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            border: Border.all(width: 1.0, color: lightRed),
            borderRadius: BorderRadius.all(
                Radius.circular(5.0) //                 <--- border radius here
                ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 10,
                height: 50,
                child: TextFormField(
                  // focusNode: AlwaysDisabledFocusNode(),
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  controller: provider.plusCodeNumber,
                  style: GoogleFonts.nunitoSans(
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w400),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    return Validator.validateFormField(
                        value!,
                        strErrorEmptyPhoneNumber,
                        strInvalidPhoneNumber,
                        Constants.PHONE_VALIDATION);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: '+',
                    hintStyle: GoogleFonts.nunitoSans(
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                width: 40,
                height: 50,
                child: TextFormField(
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  controller: provider.phoneCodeNumber,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  style: GoogleFonts.nunitoSans(
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    hintText: 'Code',
                    hintStyle: GoogleFonts.nunitoSans(
                        fontSize: ScreenUtil().setSp(16),
                        color: darkGray,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: VerticalDivider(
                  thickness: 1,
                  color: lightRed,
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: TextFormField(
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(10),
                    ],
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    controller: provider.phoneNumber,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      hintText: 'Enter Phone Number',
                      hintStyle: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(16),
                          color: darkGray,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
