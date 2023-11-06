import 'dart:io';

import 'package:dio/dio.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/LocationResponse.dart';
import 'package:famelink/models/Profile_Model.dart';
import 'package:famelink/models/UsernameCheckModel.dart';
import 'package:famelink/models/likes_model.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/util/Validator.dart';
import 'package:famelink/util/appStrings.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  MyProfileResult upperProfileData;

  EditProfileScreen(this.upperProfileData);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  final GlobalKey<FormState> _editFormKey = GlobalKey<FormState>();
  String ageGroup = "groupD";

  String type = "individual";

  final ApiProvider _api = ApiProvider();
  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  File? profileImageFile;

  List<AddressLocation> locationList = <AddressLocation>[];

  AddressLocation? locationModel;
  bool selectDate = false;
  final apiDateFormat = DateFormat('dd-MM-yyyy');
  final dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
  DateTime pickUpSelectedDate = DateTime.now();

  int selectButtonIndex = 3;
  int selectedTypeIndex = 0;
  int firstYear = 0;
  int lastYear = 0;

  bool? isUserNameAvialble;

  Future<void> _pickUpSelectDate(BuildContext context) async {
    if (selectButtonIndex == 0) {
      firstYear = 0;
      lastYear = 4;
    } else if (selectButtonIndex == 1) {
      firstYear = 4;
      lastYear = 12;
    } else if (selectButtonIndex == 2) {
      firstYear = 12;
      lastYear = 18;
    } else if (selectButtonIndex == 3) {
      firstYear = 18;
      lastYear = 28;
    } else if (selectButtonIndex == 4) {
      firstYear = 28;
      lastYear = 40;
    } else if (selectButtonIndex == 5) {
      firstYear = 40;
      lastYear = 50;
    } else if (selectButtonIndex == 6) {
      firstYear = 50;
      lastYear = 60;
    } else if (selectButtonIndex == 7) {
      firstYear = 60;
      lastYear = 150;
    }
    final today = DateTime.now();
    print("DATE:::$firstYear:::$lastYear");
    final eighteenY = DateTime(today.year - firstYear, today.month, today.day);
    final eighteenX = DateTime(today.year - lastYear, today.month, today.day);
    if (dobController.text.isEmpty) {
      pickUpSelectedDate = eighteenY;
    }
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: pickUpSelectedDate,
        lastDate: eighteenY,
        firstDate: eighteenX);
    if (picked != null && picked != pickUpSelectedDate)
      setState(() {
        selectDate = true;
        pickUpSelectedDate = picked;
        dobController.text = apiDateFormat.format(pickUpSelectedDate);
      });
  }

  Future<List<AddressLocation>> _getAddressLocation(String query) async {
    List<AddressLocation> matches = <AddressLocation>[];
    if (query.length >= 3) {
      return await getLocation(query);
    } else {
      return matches;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.upperProfileData != null) {
      setData();
    } else {
      _myInfo();
    }
  }

  _myInfo() async {
    Api.get.call(context, method: "users/${Constants.userId}", param: {},
        onResponseSuccess: (Map object) {
      var result = ProfileResponse.fromJson(object as Map<String, dynamic>);
      widget.upperProfileData = result.result!;
      setState(() {
        setData();
      });
    }, onProgress: (double percentage) {}, isLoading: false, contentType: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: appBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(
              text: 'Edit',
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w400,
                  color: black,
                  fontSize: ScreenUtil().setSp(18))),
          TextSpan(
              text: ' Profile',
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(18),
                  color: lightRed))
        ])),
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: _editFormKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        uploadProfilePic();
                      },
                      child: profileImageFile != null
                          ? Container(
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(35)),
                              width: ScreenUtil().setSp(110),
                              height: ScreenUtil().setSp(110),
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(profileImageFile!))))
                          : widget.upperProfileData.profileImage != null
                              ? Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(35)),
                                  width: ScreenUtil().setSp(110),
                                  height: ScreenUtil().setSp(110),
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${widget.upperProfileData.profileImage}'))))
                              : Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(35)),
                                  child: CircleAvatar(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: ScreenUtil().setSp(55),
                                        ),
                                        Icon(Icons.camera_alt_outlined),
                                      ],
                                    ),
                                    radius: ScreenUtil().setSp(55),
                                  ),
                                ),
                    ),

                    ///username
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(10),
                          left: ScreenUtil().setWidth(44),
                          right: ScreenUtil().setWidth(44)),
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        controller: userNameController,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          return Validator.validateFormField(
                              value!,
                              strErrorEmptyUserName,
                              strErrorInvalidUserName,
                              Constants.MIN_CHAR_VALIDATION);
                        },
                        onChanged: (text) {
                          if (text.length >= 6) {
                            Api.get.call(context,
                                method: "users/check/username/$text",
                                param: {},
                                isLoading: false,
                                onResponseSuccess: (Map object) {
                              var result = UsernameCheckModel.fromJson(
                                  object as Map<String, dynamic>);
                              isUserNameAvialble = result.result!.isAvailable;
                              setState(() {});
                            },
                                onProgress: (double percentage) {},
                                contentType: '');
                          }
                        },
                        style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            color: buttonBlue,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightGray),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightRed),
                            ),
                            contentPadding: EdgeInsets.only(
                                bottom: ScreenUtil().setHeight(0)),
                            hintText: 'username',
                            prefixText:
                                "${userNameController.text.startsWith("@") ? "" : "@"}",
                            hintStyle: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(12),
                                color: buttonBlue,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400),
                            suffix: isUserNameAvialble != null
                                ? isUserNameAvialble!
                                    ? SvgPicture.asset(
                                        "assets/icons/svg/done.svg",
                                        height: ScreenUtil().setSp(16),
                                        width: ScreenUtil().setSp(16))
                                    : Icon(
                                        Icons.close,
                                        color: Colors.red,
                                        size: 16,
                                      )
                                : null),
                      ),
                    ),

                    ///name
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(10),
                          left: ScreenUtil().setWidth(44),
                          right: ScreenUtil().setWidth(44)),
                      child: TextFormField(
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(20),
                        ],
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        controller: nameController,
                        textInputAction: TextInputAction.done,
                        style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(16),
                            color: black,
                            fontWeight: FontWeight.w400),
                        validator: (value) {
                          return Validator.validateFormField(
                              value!,
                              strErrorEmptyName,
                              strInvalidName,
                              Constants.NORMAL_VALIDATION);
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: lightRed, width: ScreenUtil().radius(1)),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().radius(5))),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: lightGray,
                                width: ScreenUtil().radius(1)),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().radius(5))),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: lightRed, width: ScreenUtil().radius(1)),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().radius(5))),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.red,
                                width: ScreenUtil().radius(1)),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().radius(5))),
                          ),
                          contentPadding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(13.73)),
                          hintText: 'Name',
                          hintStyle: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(16),
                              color: lightGray,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),

                    ///PROFESSION
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(10),
                          left: ScreenUtil().setWidth(44),
                          right: ScreenUtil().setWidth(44)),
                      child: TextFormField(
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(30),
                        ],
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        controller: professionController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(16),
                            color: black,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: lightRed, width: ScreenUtil().radius(1)),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().radius(5))),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: lightGray,
                                width: ScreenUtil().radius(1)),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().radius(5))),
                          ),
                          contentPadding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(13.73)),
                          hintText: 'Profession',
                          hintStyle: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(16),
                              color: lightGray,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),

                    /// bio
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(10),
                          left: ScreenUtil().setWidth(44),
                          right: ScreenUtil().setWidth(44)),
                      child: TextFormField(
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(300),
                        ],
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        controller: bioController,
                        minLines: 4,
                        maxLines: 6,
                        keyboardType: TextInputType.multiline,
                        style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(14),
                            color: black,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: lightRed, width: ScreenUtil().radius(1)),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().radius(5))),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: lightGray,
                                width: ScreenUtil().radius(1)),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().radius(5))),
                          ),
                          contentPadding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(5),
                            right: ScreenUtil().setWidth(5),
                            top: ScreenUtil().setHeight(8),
                            bottom: ScreenUtil().setHeight(7),
                          ),
                          hintText: 'Bio',
                          hintStyle: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(14),
                              color: lightGray,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),

                    ///LOCATION
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(10),
                          left: ScreenUtil().setWidth(44),
                          right: ScreenUtil().setWidth(44)),
                      child: TypeAheadFormField<AddressLocation>(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: placeController,
                          style: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(14),
                              color: black,
                              fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: lightRed,
                                  width: ScreenUtil().radius(1)),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().radius(5))),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: lightGray,
                                  width: ScreenUtil().radius(1)),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().radius(5))),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: lightRed,
                                  width: ScreenUtil().radius(1)),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().radius(5))),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red,
                                  width: ScreenUtil().radius(1)),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().radius(5))),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(13.73)),
                            hintText: 'Location',
                            hintStyle: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(14),
                                color: lightGray,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          return await _getAddressLocation(pattern);
                        },
                        validator: (value) {
                          return Validator.validateFormField(
                              value!,
                              strErrorEmptyLocation,
                              strInvalidLocation,
                              Constants.NORMAL_VALIDATION);
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(
                                "${suggestion.district} ${suggestion.state}, ${suggestion.country}"),
                          );
                        },
                        transitionBuilder:
                            (context, suggestionsBox, controller) {
                          return suggestionsBox;
                        },
                        onSuggestionSelected: (suggestion) {
                          this.locationModel = suggestion;
                          setState(() {
                            placeController.text =
                                "${suggestion.district} ${suggestion.state}, ${suggestion.country}";
                          });
                        },
                      ),
                    ),

                    ///DOB
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(10),
                          left: ScreenUtil().setWidth(44),
                          right: ScreenUtil().setWidth(44)),
                      child: TextFormField(
                        onTap: () {
                          _pickUpSelectDate(context);
                        },
                        focusNode: AlwaysDisabledFocusNode(),
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        controller: dobController,
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.done,
                        style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(12),
                            color: black,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: lightRed, width: ScreenUtil().radius(1)),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().radius(5))),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: lightGray,
                                width: ScreenUtil().radius(1)),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().radius(5))),
                          ),
                          contentPadding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(13.73)),
                          hintText: 'Date of birth',
                          hintStyle: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(12),
                              color: lightGray,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),

                    ///age
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(18),
                          left: ScreenUtil().setWidth(44),
                          right: ScreenUtil().setWidth(44)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            child: Text(
                              'Age',
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  color: lightGray,
                                  fontWeight: FontWeight.w600),
                            ),
                            padding: EdgeInsets.only(
                              right: ScreenUtil().setWidth(10),
                            ),
                          ),
                          Expanded(
                            child: GroupButton(
                              // textPadding: EdgeInsets.only(
                              //     left: ScreenUtil().setSp(0),
                              //     right: ScreenUtil().setSp(0)),
                              // runSpacing: ScreenUtil().setSp(9),
                              // groupingType: GroupingType.wrap,
                              // spacing: ScreenUtil().setSp(5),
                              // mainGroupAlignment: MainGroupAlignment.start,
                              // buttonHeight: ScreenUtil().setSp(24),
                              // buttonWidth: ScreenUtil().setSp(57),
                              isRadio: true,

                              // direction: Axis.horizontal,
                              onSelected: (index, isSelected) {
                                selectButtonIndex = index;
                                if (index == 0) {
                                  ageGroup = "groupA";
                                } else if (index == 1) {
                                  ageGroup = "groupB";
                                } else if (index == 2) {
                                  ageGroup = "groupC";
                                } else if (index == 3) {
                                  ageGroup = "groupD";
                                } else if (index == 4) {
                                  ageGroup = "groupE";
                                } else if (index == 5) {
                                  ageGroup = "groupF";
                                } else if (index == 6) {
                                  ageGroup = "groupG";
                                } else if (index == 7) {
                                  ageGroup = "groupH";
                                }
                                print('$ageGroup');
                                setState(() {
                                  dobController.text = "";
                                });
                              },
                              buttons: [
                                "0-4",
                                "4-12",
                                "12-18",
                                "18-28",
                                "28-40",
                                "40-50",
                                "50-60",
                                "60+"
                              ],
                              // selectedButton: selectButtonIndex,
                              // selectedTextStyle: GoogleFonts.nunitoSans(
                              //   fontWeight: FontWeight.w400,
                              //   fontSize: ScreenUtil().setSp(12),
                              //   color: white,
                              // ),
                              // unselectedTextStyle: GoogleFonts.nunitoSans(
                              //   fontWeight: FontWeight.w400,
                              //   fontSize: ScreenUtil().setSp(12),
                              //   color: lightGray,
                              // ),
                              // selectedColor: darkGray,
                              // unselectedColor: Colors.transparent,
                              // selectedBorderColor: lightGray,
                              // unselectedBorderColor: lightGray,
                              // borderRadius: BorderRadius.circular(
                              //     ScreenUtil().radius(25)),
                              // selectedShadow: <BoxShadow>[
                              //   BoxShadow(color: Colors.transparent)
                              // ],
                              // unselectedShadow: <BoxShadow>[
                              //   BoxShadow(color: Colors.transparent)
                              // ],
                            ),
                          )
                        ],
                      ),
                    ),

                    ///type
                    /*Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(29),
                          left: ScreenUtil().setWidth(44),
                          right: ScreenUtil().setWidth(44)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            child: Text(
                              'Type',
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(14),
                                  color: lightGray,
                                  fontWeight: FontWeight.w600),
                            ),
                            padding: EdgeInsets.only(
                                right: ScreenUtil().setWidth(5)),
                          ),
                          Expanded(
                            child: GroupButton(
                              textPadding: EdgeInsets.only(
                                  left: ScreenUtil().setSp(0),
                                  right: ScreenUtil().setSp(0)),
                              runSpacing: ScreenUtil().setSp(9),
                              groupingType: GroupingType.wrap,
                              spacing: ScreenUtil().setSp(5),
                              mainGroupAlignment: MainGroupAlignment.start,
                              buttonHeight: ScreenUtil().setSp(24),
                              buttonWidth: ScreenUtil().setSp(80),
                              isRadio: true,
                              direction: Axis.horizontal,
                              onSelected: (index, isSelected) {
                                setState(() {
                                  if (index == 0) {
                                    type = 'individual';
                                  }
                                  if (index == 1) {
                                    type = 'agency';
                                  }
                                  if (index == 2) {
                                    type = 'brand';
                                  }
                                });

                                print('$type');
                                print(
                                    '$index button is ${isSelected ? 'selected' : 'unselected'}');
                              },
                              buttons: ["Individual", "Agency", "Brand"],
                              selectedButton: selectedTypeIndex,
                              selectedTextStyle: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(12),
                                color: white,
                              ),
                              unselectedTextStyle: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(12),
                                color: lightGray,
                              ),
                              selectedColor: darkGray,
                              unselectedColor: Colors.transparent,
                              selectedBorderColor: lightGray,
                              unselectedBorderColor: lightGray,
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().radius(25)),
                              selectedShadow: <BoxShadow>[
                                BoxShadow(color: Colors.transparent)
                              ],
                              unselectedShadow: <BoxShadow>[
                                BoxShadow(color: Colors.transparent)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),*/

                    ///BUTTON
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _editProfileApi();
            },
            child: Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(20),
                  bottom: ScreenUtil().setHeight(20)),
              width: ScreenUtil().setWidth(158),
              height: ScreenUtil().setHeight(40),
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [lightRedWhite, lightRed]),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Submit',
                    style: GoogleFonts.nunitoSans(
                        color: white,
                        fontWeight: FontWeight.w700,
                        fontSize: ScreenUtil().setSp(22)),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(27),
                  ),
                  Icon(Icons.arrow_forward, color: Colors.white)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future uploadProfilePic() async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () async {
                      try {
                        final pickedFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        profileImageFile = File(pickedFile!.path);
                        _cropImage().then((value) async {
                          Constants.profileImage = await MultipartFile.fromFile(
                              value!.path,
                              filename:
                                  "${File(pickedFile.path).path.split('/').last}");
                          setState(() {
                            profileImageFile = value as File?;
                          });
                          uploadPic();
                        });
                      } on PlatformException catch (e) {
                        print('FAILED $e');
                      }
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () async {
                    try {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      profileImageFile = File(pickedFile!.path);
                      _cropImage().then((value) async {
                        Constants.profileImage = await MultipartFile.fromFile(
                            value!.path,
                            filename:
                                "${File(pickedFile.path).path.split('/').last}");
                        setState(() {
                          profileImageFile = value as File?;
                        });
                        uploadPic();
                      });
                    } on PlatformException catch (e) {
                      print('FAILED $e');
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<File?> _cropImage() async {
    return await ImageCropper().cropImage(
      sourcePath: profileImageFile!.path,
      aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 4),
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      // androidUiSettings: AndroidUiSettings(
      //     toolbarTitle: 'Cropper',
      //     toolbarColor: Colors.deepOrange,
      //     toolbarWidgetColor: Colors.white,
      //     initAspectRatio: CropAspectRatioPreset.original,
      //     lockAspectRatio: false),
      // iosUiSettings: IOSUiSettings(
      //   title: 'Cropper',
      // )
    );
  }

  void _editProfileApi() async {
    print("editprofile");

    if (_editFormKey.currentState!.validate() && locationModel != null) {
      if (userNameController.text.isNotEmpty &&
              userNameController.text.toLowerCase().contains("famelinks") ||
          userNameController.text.toLowerCase().contains("fame_links") ||
          userNameController.text.toLowerCase().contains("fame.links")) {
        Constants.toastMessage(
            msg:
                "This username is not available, Please chose some other username");
      } else if (nameController.text.toLowerCase().contains("famelinks") ||
          nameController.text.toLowerCase().contains("fame_links") ||
          nameController.text.toLowerCase().contains("fame.links")) {
        Constants.toastMessage(
            msg: "This name is not available, Please chose some other name");
      } else if (userNameController.text.isNotEmpty &&
          isUserNameAvialble != null &&
          isUserNameAvialble!) {
        Map<String, dynamic> map = {
          "username": userNameController.text,
          "name": nameController.text,
          "type": type.toString(),
          "bio": bioController.text,
          "profession": professionController.text,
          "district": locationModel!.district,
          "state": locationModel!.state,
          "country": locationModel!.country,
          "continent": locationModel!.continent
        };
        if (ageGroup.isNotEmpty) {
          map.putIfAbsent("ageGroup", () => ageGroup);
        }
        if (dobController.text.isNotEmpty) {
          map.putIfAbsent("dob", () => dobController.text);
        }
        Api.put.call(context, method: "users/update", param: map,
            onResponseSuccess: (Map object) {
          Navigator.pop(context, true);
        },
            onRetry: (String message) {},
            onProgress: (double percentage) {},
            isLoading: false);
      } else if (isUserNameAvialble == null) {
        Map<String, dynamic> map = {
          "username": userNameController.text,
          "name": nameController.text,
          "type": type.toString(),
          "bio": bioController.text,
          "profession": professionController.text,
          "district": locationModel!.district,
          "state": locationModel!.state,
          "country": locationModel!.country,
          "continent": locationModel!.continent
        };
        if (ageGroup.isNotEmpty) {
          map.putIfAbsent("ageGroup", () => ageGroup);
        }
        if (dobController.text.isNotEmpty) {
          map.putIfAbsent("dob", () => dobController.text);
        }
        Api.put.call(context, method: "users/update", param: map,
            onResponseSuccess: (Map object) {
          Navigator.pop(context, true);
        },
            onRetry: (String message) {},
            onProgress: (double percentage) {},
            isLoading: false);
      } else {
        Constants.toastMessage(msg: "username not available");
      }
    } else {
      Constants.toastMessage(msg: "select Location");
    }
  }

  Future<List<AddressLocation>> getLocation(String query) async {
    var result = await _api.getLocation(query);
    if (result != null) {
      if (result.success!) {
        locationList.addAll(result.result!);
        // return locationList;
      } else {
        Constants.toastMessage(msg: result.message!);
        // return locationList;
      }
    }
    return locationList;
  }

  void uploadPic() async {
    print("uploadpic");
    FormData formData = FormData.fromMap({});
    formData.files.addAll([
      MapEntry("profileImage", Constants.profileImage!),
    ]);
    Api.uploadPut.call(context,
        method: "users/profile/image/upload",
        param: formData, onResponseSuccess: (Map object) {
      var result = LikesResponse.fromJson(object as Map<String, dynamic>);
      Constants.toastMessage(msg: result.message);
    },
        onRetry: (String message) {},
        onProgress: (double percentage) {},
        isLoading: false);
  }

  void setData() {
    professionController.text = widget.upperProfileData.profession.toString();
    nameController.text = widget.upperProfileData.name.toString();
    userNameController.text = widget.upperProfileData.username.toString();
    bioController.text = widget.upperProfileData.bio.toString();
    placeController.text = widget.upperProfileData.district != null
        ? "${widget.upperProfileData.district} ${widget.upperProfileData.state}, ${widget.upperProfileData.country}"
        : "";
    dobController.text = widget.upperProfileData.dob != null
        ? apiDateFormat.format(DateTime.parse(widget.upperProfileData.dob!))
        : "";
    pickUpSelectedDate = widget.upperProfileData.dob != null
        ? DateTime.parse(widget.upperProfileData.dob!)
        : DateTime(
            DateTime.now().year - 12, DateTime.now().month, DateTime.now().day);
    ageGroup = widget.upperProfileData.ageGroup.toString();
    type = widget.upperProfileData.type.toString();
    if (ageGroup == "groupA") {
      selectButtonIndex = 0;
    } else if (ageGroup == "groupB") {
      selectButtonIndex = 1;
    } else if (ageGroup == "groupC") {
      selectButtonIndex = 2;
    } else if (ageGroup == "groupD") {
      selectButtonIndex = 3;
    } else if (ageGroup == "groupE") {
      selectButtonIndex = 4;
    } else if (ageGroup == "groupF") {
      selectButtonIndex = 5;
    } else if (ageGroup == "groupG") {
      selectButtonIndex = 6;
    } else if (ageGroup == "groupH") {
      selectButtonIndex = 7;
    }

    if (type == "individual") {
      selectedTypeIndex = 0;
    } else if (type == "agency") {
      selectedTypeIndex = 1;
    } else if (type == "brand") {
      selectedTypeIndex = 2;
    }
    locationModel = new AddressLocation(
        continent: "", country: "", district: "", state: "");
    locationModel!.district = widget.upperProfileData.district;
    locationModel!.state = widget.upperProfileData.state;
    locationModel!.country = widget.upperProfileData.country;
    locationModel!.continent = widget.upperProfileData.country;
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
