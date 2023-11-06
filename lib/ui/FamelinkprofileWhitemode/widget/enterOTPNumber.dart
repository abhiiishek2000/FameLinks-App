import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../util/config/color.dart';
import '../../Famelinkprofile/function/famelinkFun.dart';

class enterOTPNumberWhitemode extends StatefulWidget {
  enterOTPNumberWhitemode({Key? key, required this.otpNumber})
      : super(key: key);
  final TextEditingController otpNumber;

  @override
  State<enterOTPNumberWhitemode> createState() =>
      _enterOTPNumberWhitemodeState();
}

class _enterOTPNumberWhitemodeState extends State<enterOTPNumberWhitemode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        border: Border.all(width: 1.0, color: lightGray),
        borderRadius: BorderRadius.all(
            Radius.circular(5.0) //                 <--- border radius here
            ),
      ),
      child: Consumer<FameLinkFun>(
        builder: (context, provider, child) {
          return Row(
            children: [
              Expanded(
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                  ],
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  controller: widget.otpNumber,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  obscureText: provider.showPassword,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                    hintText: 'Enter OTP',
                    hintStyle: GoogleFonts.nunitoSans(
                        fontSize: ScreenUtil().setSp(16),
                        color: darkGray,
                        fontWeight: FontWeight.w400),
                    prefixIcon: IconButton(
                      onPressed: () async {},
                      padding: EdgeInsets.all(0),
                      icon: SvgPicture.asset("assets/icons/svg/keyOtp.svg"),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        setState(() {
                          provider.showPassword = !provider.showPassword;
                        });
                      },
                      icon: provider.showPassword
                          ? Icon(
                              Icons.remove_red_eye_outlined,
                              color: darkGray,
                            )
                          : SvgPicture.asset("assets/icons/svg/hideOtp.svg",
                              color: darkGray),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
