import 'dart:io';

import 'package:famelink/models/LocationResponse.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/profile_UI/PhotoImageScreen.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/custom_snack_bar.dart';
import 'package:famelink/util/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/AuthProvider/auth_provider.dart';

registerDialog(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.only(
                left: ScreenUtil().setWidth(26),
                right: ScreenUtil().setWidth(26)),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setStates) {
                  final provider1 = Provider.of<AuthenticationProvider>(context,listen: false);
                  provider1.selectProfile("Individual");
                  provider1.selectGender("Male");
              return Consumer<AuthenticationProvider>(
                  builder: (context, provider, child) {

                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(50)),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setSp(16))),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 4),
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 4.0,
                                ),
                              ]),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    top: ScreenUtil().setHeight(19),
                                    bottom: ScreenUtil().setHeight(19),
                                    left: ScreenUtil().setWidth(37),
                                    right: ScreenUtil().setWidth(36)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Let’s begin...',
                                        style: GoogleFonts.kaushanScript(
                                            fontSize: ScreenUtil().setSp(24),
                                            color: white,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(4),
                              ),
                              Container(
                                color: appBackgroundColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 25.h,
                                        child: Row(
                                          children: [
                                            Text(
                                              'Type',
                                              style: GoogleFonts.nunitoSans(
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                color: black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              child: ListView.separated(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: provider
                                                    .profileTypes.length,
                                                separatorBuilder:
                                                    ((context, index) =>
                                                        SizedBox(
                                                          width: 4.w,
                                                        )),
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      provider.selectProfile(
                                                          provider.profileTypes[
                                                              index]);
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.w),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: provider
                                                                      .setectedProfileType ==
                                                                  provider.profileTypes[
                                                                      index]
                                                              ? darkGray
                                                              : white,
                                                          border: Border.all(
                                                            width: 1,
                                                            color: provider
                                                                        .setectedProfileType ==
                                                                    provider.profileTypes[
                                                                        index]
                                                                ? darkGray
                                                                : darkGray,
                                                          )),
                                                      child: Center(
                                                        child: Text(
                                                          provider.profileTypes[
                                                              index],
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(12),
                                                            color: provider
                                                                        .setectedProfileType ==
                                                                    provider.profileTypes[
                                                                        index]
                                                                ? white
                                                                : darkGray,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                      CustomTextFieldWidget(
                                        keyboardType: TextInputType.name,
                                        hintText: 'Enter Your Name',
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.trim().length < 3) {
                                            return 'Enter your full name';
                                          }
                                        },
                                        controller: provider.signUpController,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[a-zA-Z ]")),
                                        ],
                                      ),
                                      SizedBox(height: 16.h),
                                      CustomTextFieldWidget(
                                        readOnly: true,
                                        ontap: () =>
                                            provider.selectDoB(context),
                                        keyboardType: TextInputType.name,
                                        hintText: 'Birth of Date',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please provide birth of date';
                                          }
                                        },
                                        controller: provider.dobController,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[a-zA-Z ]")),
                                        ],
                                      ),
                                      SizedBox(height: 16.h),
                                      Container(
                                        height: 60.h,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Gender',
                                              style: GoogleFonts.nunitoSans(
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                color: black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(width: 16.w),
                                            Expanded(
                                              child: ListView.separated(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    provider.genders.length,
                                                separatorBuilder:
                                                    ((context, index) =>
                                                        SizedBox(
                                                          width: 24.w,
                                                        )),
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      provider.selectGender(
                                                          provider.genders[
                                                                  index]
                                                              ['gender']!);
                                                    },
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height: 40.h,
                                                          width: 40.h,
                                                          decoration:
                                                              BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: provider
                                                                              .setectedGender ==
                                                                          provider.genders[index]
                                                                              [
                                                                              'gender']
                                                                      ? darkGray
                                                                      : white,
                                                                  border: Border
                                                                      .all(
                                                                    width: 1,
                                                                    color: provider.setectedGender ==
                                                                            provider.genders[index]['gender']
                                                                        ? darkGray
                                                                        : darkGray,
                                                                  )),
                                                          child: Center(
                                                            child: SvgPicture
                                                                .asset(
                                                              provider.genders[
                                                                      index]
                                                                  ['icon']!,
                                                              color: provider
                                                                          .setectedGender ==
                                                                      provider.genders[
                                                                              index]
                                                                          [
                                                                          'gender']
                                                                  ? white
                                                                  : darkGray,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          provider.genders[
                                                              index]['gender']!,
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(12),
                                                            color: darkGray,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                      TypeAheadFormField<AddressLocation>(
                                        direction: AxisDirection.up,
                                        getImmediateSuggestions: true,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter location';
                                          }
                                        },
                                        textFieldConfiguration:
                                            TextFieldConfiguration(
                                                controller: provider
                                                    .locationController,
                                                keyboardType: TextInputType
                                                    .multiline,
                                                minLines: 1,
                                                maxLines: 3,
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize: ScreenUtil()
                                                        .setSp(16),
                                                    color: black,
                                                    fontStyle: FontStyle
                                                        .normal),
                                                decoration: InputDecoration(
                                                    suffixIcon: Icon(
                                                      Icons.search,
                                                      color: lightGray,
                                                    ),
                                                    filled: true,
                                                    fillColor: white,
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              255,
                                                              122,
                                                              131,
                                                              255)),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color: lightGray),
                                                    ),
                                                    hintText:
                                                        'Enter District Name to Search',
                                                    hintStyle:
                                                        GoogleFonts.nunitoSans(
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(14),
                                                            color: darkGray,
                                                            fontStyle: FontStyle
                                                                .italic),
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 10,
                                                            vertical: 8))),
                                        suggestionsBoxDecoration:
                                            const SuggestionsBoxDecoration(
                                          hasScrollbar: true,
                                        ),
                                        suggestionsCallback: (pattern) {
                                          return provider.getLocation(pattern);
                                        },
                                        hideSuggestionsOnKeyboardHide: true,
                                        itemBuilder: (context, suggestion) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "${suggestion.district},${suggestion.state},${suggestion.country}",
                                              style: GoogleFonts.nunitoSans(
                                                  color: darkGray,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize:
                                                      ScreenUtil().setSp(12)),
                                            ),
                                          );
                                        },
                                        transitionBuilder: (context,
                                            suggestionsBox, controller) {
                                          return suggestionsBox;
                                        },
                                        onSuggestionSelected:
                                            (suggestion) async {
                                          provider.selectedLocation(suggestion);
                                        },
                                      ),
                                      SizedBox(height: 16.h),
                                      CustomTextFieldWidget(
                                        keyboardType: TextInputType.name,
                                        hintText: '@username',
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.trim().length < 3) {
                                            return 'Enter Username';
                                          }
                                        },
                                        controller: provider.nickNameController,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[a-zA-Z ]")),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: ScreenUtil().setHeight(2),
                              ),

                              ///get started
                              InkWell(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    provider.register(context);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: appBackgroundColor,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            ScreenUtil().setSp(16)),
                                        bottomRight: Radius.circular(
                                            ScreenUtil().setSp(16))),
                                  ),
                                  height: ScreenUtil().setHeight(63),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Get Started',
                                        style: GoogleFonts.nunitoSans(
                                            color: black,
                                            fontSize: ScreenUtil().setSp(20),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(8),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_rounded,
                                        color: black,
                                        size: 29,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: ScreenUtil().setWidth(23)),
                            child: InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PhotoImageScreen(
                                              runtypes: 'register',
                                            ))),
                                child: provider.selectedProfile == null &&
                                        provider.selectedAvatar == null
                                    ? CircleAvatar(
                                        radius: 50,
                                        backgroundColor: lightGray,
                                        child: CircleAvatar(
                                          radius: 49,
                                          backgroundColor: white,
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            color: lightGray,
                                            size: ScreenUtil().radius(35),
                                          ),
                                        ),
                                      )
                                    : provider.selectedProfile != null
                                        ? Container(
                                            width: 100.0,
                                            height: 100.0,
                                            decoration: BoxDecoration(
                                                color: white,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: lightGray),
                                                image: new DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: FileImage(provider
                                                        .selectedProfile!))),
                                          )
                                        : Container(
                                            width: 100.0,
                                            height: 100.0,
                                            decoration: BoxDecoration(
                                                color: darkBlue,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: lightGray),
                                                image: new DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        '${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${provider.selectedAvatar!}'))),
                                          )),
                          ),
                        ),
                        if (provider.isLoading == true)
                          Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          )
                      ],
                    ),
                  ),
                );
              });
            }));
      });
}
