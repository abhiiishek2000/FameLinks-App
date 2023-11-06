import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/config/color.dart';

class enterEmail extends StatelessWidget {
   enterEmail({Key? key, required this.emailController}) : super(key: key);
final TextEditingController emailController;
  @override
  Widget build(BuildContext context) {
    return  Container(
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
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextFormField(
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  hintText: 'Enter Email',
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
  }
}
