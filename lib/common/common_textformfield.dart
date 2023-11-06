import 'package:flutter/material.dart';

class CommonTextFormField extends StatelessWidget {
  TextEditingController? controller;
  String? hintText;
  TextInputAction? textInputAction;
  var validator;
  TextInputType? keyboardType;
  int? maxLength;
  bool? obscureText;
  bool? isReadyOnly;
  Color? fillColors;
  Color? underLineColors;
  Widget? suffixIcon;
  TextStyle? hintStyle;
  void Function()? onTaps;
  double? bottomPadding;
  TextStyle? style;
  FocusNode? focusNode;
  void Function(String)? onChange;
  EdgeInsets? scrollPadding;

  CommonTextFormField({
    this.style,
    this.textInputAction,
    this.onChange,
    this.maxLength,
    this.controller,
    this.hintText,
    this.onTaps,
    this.hintStyle,
    this.underLineColors,
    this.suffixIcon,
    this.bottomPadding,
    this.fillColors,
    this.isReadyOnly,
    this.obscureText,
    this.keyboardType,
    this.focusNode,
    this.scrollPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTaps,
      onChanged: onChange,
      focusNode: focusNode,
      scrollPadding: scrollPadding ?? EdgeInsets.all(20.0),
      // readOnly: isReadyOnly!,
      obscureText: obscureText!,
      maxLength: maxLength,
      textInputAction: textInputAction,
      validator: validator,
      controller: controller,
      style: style,
      cursorColor: Colors.black,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: bottomPadding!),
        suffixIcon: suffixIcon,
        counterText: "",
        hintText: hintText,
        hintStyle: hintStyle,
        filled: true,
        fillColor: fillColors,
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: underLineColors!,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: underLineColors!,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: underLineColors!,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: underLineColors!,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: underLineColors!,
          ),
        ),
      ),
    );
  }
}

class CommonTextFormFieldPatName extends StatelessWidget {
  TextEditingController? controller;
  String? hintText;
  TextInputAction? textInputAction;
  void Function()? validator;
  TextInputType? keyboardType;
  int? maxLength;
  bool? obscureText;
  bool? isReadyOnly;
  Color? fillColors;
  Color? underLineColors;
  Widget? suffixIcon;
  TextStyle? hintStyle;
  void Function()? onTaps;
  double? bottomPadding;
  TextStyle? style;
  String? prefixTexts;
  void Function(String)? onChange;

  CommonTextFormFieldPatName({
    this.style,
    this.textInputAction,
    this.validator,
    this.onChange,
    this.maxLength = 1024,
    this.controller,
    this.hintText,
    this.onTaps,
    this.hintStyle,
    this.underLineColors = Colors.white,
    this.suffixIcon,
    this.bottomPadding,
    this.fillColors,
    this.isReadyOnly = false,
    this.obscureText = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTaps,
      onChanged: onChange,
      readOnly: isReadyOnly!,
      obscureText: obscureText!,
      maxLength: maxLength,
      textAlign: TextAlign.right,
      textInputAction: textInputAction,
      controller: controller,
      style: style,
      cursorColor: Colors.black,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixText: prefixTexts,
        contentPadding: EdgeInsets.only(bottom: bottomPadding!),
        suffixIcon: suffixIcon,
        counterText: "",
        hintText: hintText,
        hintStyle: hintStyle,
        filled: true,
        fillColor: fillColors,
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: underLineColors!,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: underLineColors!,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: underLineColors!,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: underLineColors!,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: underLineColors!,
          ),
        ),
      ),
    );
  }
}
