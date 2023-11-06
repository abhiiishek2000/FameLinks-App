import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/color.dart';

class CustomTextFieldWidget extends StatelessWidget {
  CustomTextFieldWidget(
      {Key? key,
      this.borderColor,
      this.hintText,
      this.keyboardType,
      this.inputFormatters,
      this.fillColor,
      this.maxLine,
      this.validator,
      this.ontap,
      this.readOnly,
      this.controller})
      : super(key: key);

  Color? borderColor;
  Color? fillColor;
  String? hintText;
  int? maxLine;
  FormFieldValidator<String>? validator;
  TextEditingController? controller;
  TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;
  VoidCallback? ontap;
  bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: ontap,
      readOnly: readOnly ?? false,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLine ?? 1,
      onChanged: (text) {},
      validator: validator,
      controller: controller,
      style: GoogleFonts.nunitoSans(
          fontSize: ScreenUtil().setSp(16),
          color: black,
          fontStyle: FontStyle.normal),
      decoration: InputDecoration(
          filled: true,
          fillColor: fillColor ?? white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: borderColor ?? Color.fromARGB(255, 122, 131, 255)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor ?? lightGray),
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.nunitoSans(
              fontSize: ScreenUtil().setSp(14),
              color: darkGray,
              fontStyle: FontStyle.italic),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
    );
  }
}
