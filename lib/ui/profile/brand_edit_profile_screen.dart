import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/LocationResponse.dart';
import 'package:famelink/models/Profile_Model.dart';
import 'package:famelink/models/UsernameCheckModel.dart';
import 'package:famelink/models/likes_model.dart';
import 'package:famelink/models/login_model.dart';
import 'package:famelink/models/register_response.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/util/Validator.dart';
import 'package:famelink/util/appStrings.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../databse/fetchlocaldata.dart';
import '../../databse/localdata.dart';

class BrandEditProfileScreen extends StatefulWidget {
  MyProfileResult upperProfileData;
  bool isAgency;

  BrandEditProfileScreen(this.upperProfileData, this.isAgency);

  @override
  _BrandEditProfileScreenState createState() => _BrandEditProfileScreenState();
}

class _BrandEditProfileScreenState extends State<BrandEditProfileScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController phoneCodeNumber = TextEditingController();
  TextEditingController plusCodeNumber = TextEditingController();
  TextEditingController otpNumber = TextEditingController();
  TextEditingController webController = TextEditingController();
  TextEditingController fileController = TextEditingController();
  final GlobalKey<FormState> _editFormKey = GlobalKey<FormState>();
  bool showPassword = true;
  bool isOTPLogin = false;
  bool isOTPEmailLogin = false;
  int _start = 30;
  String otpHash = "";
  Timer? _timer;
  String type = "individual";

  final ApiProvider _api = ApiProvider();
  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  File? profileImageFile;

  List<AddressLocation> locationList = <AddressLocation>[];
  List<File> imageList = <File>[];
  AddressLocation? locationModel;
  bool selectDate = false;
  final apiDateFormat = DateFormat('dd-MM-yyyy');
  final dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
  DateTime pickUpSelectedDate = DateTime.now();

  int selectButtonIndex = 3;
  int selectedTypeIndex = 0;

  bool? isUserNameAvialble;

  Future<List<AddressLocation>?> _getAddressLocation(String query) async {
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
    getlocal();
    super.initState();
    if (widget.upperProfileData != null) {
      setData();
    } else {
      _myInfo();
    }
  }

  getlocal() async {
    var result = await Fetchlocaldata().profile1();
    if (result != null) {
      widget.upperProfileData = result.result!;
    }
  }

  _myInfo() async {
    Api.get.call(context, method: "users/${Constants.userId}", param: {},
        onResponseSuccess: (Map object) {
      Localdata().sethivedata(object, "profile1");
      var result = ProfileResponse.fromJson(object);
      widget.upperProfileData = result.result!;
      setState(() {
        setData();
      });
    });
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
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenUtil().setSp(55))),
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(profileImageFile!))))
                          : widget.upperProfileData != null &&
                                  widget.upperProfileData.profileImage != null
                              ? Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(35)),
                                  width: ScreenUtil().setSp(110),
                                  height: ScreenUtil().setSp(110),
                                  decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenUtil().setSp(55))),
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
                                method: "users/check/username/${text}",
                                param: {},
                                isLoading: false, onResponseSuccess:
                                    (Map<dynamic, dynamic> object) {
                              var result = UsernameCheckModel.fromJson(object);
                              isUserNameAvialble = result.result!.isAvailable;
                              setState(() {});
                            });
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
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.red,
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

                    ///Phone
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(10),
                          left: ScreenUtil().setWidth(44),
                          right: ScreenUtil().setWidth(44)),
                      child: TextFormField(
                        focusNode: AlwaysDisabledFocusNode(),
                        onTap: () {
                          showUpdateMobileDialog(
                              context, numberController.text);
                        },
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.phone,
                        textAlignVertical: TextAlignVertical.center,
                        controller: numberController,
                        textInputAction: TextInputAction.done,
                        style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(14),
                            color: black,
                            fontWeight: FontWeight.w400),
                        validator: (value) {
                          return Validator.validateFormField(
                              value!,
                              strErrorEmptyPhone,
                              strInvalidPhone,
                              Constants.PHONE_OR_EMAIL_VALIDATION);
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
                          hintText: 'Phone Number',
                          hintStyle: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(14),
                              color: lightGray,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),

                    ///Email
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(10),
                          left: ScreenUtil().setWidth(44),
                          right: ScreenUtil().setWidth(44)),
                      child: TextFormField(
                        focusNode: AlwaysDisabledFocusNode(),
                        onTap: () {
                          showUpdateEmailDialog(context, emailController.text);
                        },
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.emailAddress,
                        textAlignVertical: TextAlignVertical.center,
                        controller: emailController,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          return Validator.validateFormField(
                              value!,
                              strErrorEmptyEmail,
                              strInvalidEmail,
                              Constants.PHONE_OR_EMAIL_VALIDATION);
                        },
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
                          focusedErrorBorder: OutlineInputBorder(
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
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.red,
                                width: ScreenUtil().radius(1)),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().radius(5))),
                          ),
                          contentPadding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(13.73)),
                          hintText: 'Email ID',
                          hintStyle: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(12),
                              color: lightGray,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),

                    ///web URL
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(10),
                          left: ScreenUtil().setWidth(44),
                          right: ScreenUtil().setWidth(44)),
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        controller: webController,
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
                          hintText: 'Website URL',
                          hintStyle: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(12),
                              color: lightGray,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),

                    ///Upload
                    InkWell(
                      onTap: () {
                        if (imageList.length < 2) {
                          closeUp();
                        } else {
                          var snackBar = SnackBar(
                            content: Text('max 2 doc allowed'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(15),
                            left: ScreenUtil().setWidth(44),
                            right: ScreenUtil().setWidth(44)),
                        child: Row(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: imageList.length == 0
                                      ? 1
                                      : imageList.length,
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(16),
                                      right: ScreenUtil().setWidth(24)),
                                  itemBuilder: (followersContext, index) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              imageList.length > 0
                                                  ? imageList[index]
                                                      .path
                                                      .split('/')
                                                      .last
                                                  : widget.upperProfileData
                                                                  .verificationStatus !=
                                                              null ||
                                                          widget
                                                              .upperProfileData
                                                              .verificationStatus!
                                                              .isNotEmpty
                                                      ? widget.upperProfileData
                                                          .verificationStatus!
                                                      : "Upload Doc for Verification",
                                              style: GoogleFonts.nunitoSans(
                                                  fontSize:
                                                      ScreenUtil().setSp(14),
                                                  color: black,
                                                  fontWeight: FontWeight.w700),
                                              textAlign: TextAlign.start),
                                        ),
                                        Visibility(
                                          visible: imageList.length > 0,
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  imageList.removeAt(index);
                                                });
                                              },
                                              icon: Icon(Icons.close,
                                                  color: black)),
                                        )
                                      ],
                                    );
                                  }),
                            ),
                            Visibility(
                              visible: imageList.length == 0,
                              child: Text("(COI & PAN)",
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(12),
                                      color: darkGray,
                                      fontWeight: FontWeight.w300)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(44),
                          right: ScreenUtil().setWidth(44)),
                      child: Divider(
                        thickness: 1,
                        height: 1,
                        color: lightGray,
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

  showUpdateMobileDialog(BuildContext context, String mobile) {
    phoneNumber.text = mobile;
    phoneCodeNumber.text = "91";
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: TextStyle(color: lightRed)),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setStates) {
          return AlertDialog(
            content: isOTPLogin ? enterOTPNumber() : enterPhoneNumber(),
            actions: [
              cancelButton,
              TextButton(
                child: Text("Submit", style: TextStyle(color: lightRed)),
                onPressed: () async {
                  if (isOTPLogin) {
                    _handleOTPIn();
                  } else {
                    if (phoneCodeNumber.text.length > 1 &&
                        phoneNumber.text.isNotEmpty) {
                      await _loginService(setStates);
                    } else if (phoneCodeNumber.text.length <= 1) {
                      Constants.toastMessage(msg: "Enter Phone Code");
                    } else if (phoneNumber.text.isEmpty) {
                      Constants.toastMessage(msg: "Enter Phone Number");
                    }
                  }
                },
              ),
            ],
          );
        });
      },
    );
  }

  showUpdateEmailDialog(BuildContext context, String email) {
    emailController.text = email;
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: TextStyle(color: lightRed)),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setStates) {
          return AlertDialog(
            content: isOTPEmailLogin ? enterOTPNumber() : enterEmail(),
            actions: [
              cancelButton,
              TextButton(
                child: Text("Submit", style: TextStyle(color: lightRed)),
                onPressed: () async {
                  if (isOTPEmailLogin) {
                    widget.upperProfileData.email = emailController.text;
                    _handleOTPEmailIn();
                  } else {
                    if (emailController.text.isNotEmpty) {
                      await _emailLoginService(setStates);
                    } else if (emailController.text.isEmpty) {
                      Constants.toastMessage(msg: "Enter Email");
                    }
                  }
                },
              ),
            ],
          );
        });
      },
    );
  }

  Widget enterEmail() {
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

  Widget enterPhoneNumber() {
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
              focusNode: AlwaysDisabledFocusNode(),
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              controller: plusCodeNumber,
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
              controller: phoneCodeNumber,
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
                controller: phoneNumber,
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
  }

  Widget enterOTPNumber() {
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
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              inputFormatters: [
                new LengthLimitingTextInputFormatter(6),
              ],
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              controller: otpNumber,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              obscureText: showPassword,
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
                      showPassword = !showPassword;
                    });
                  },
                  icon: showPassword
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
      ),
    );
  }

  _loginService(StateSetter setStates) async {
    Map<String, dynamic> map = {
      "mobileNumber": phoneNumber.text,
      "code": phoneCodeNumber.text
    };
    Api.post.call(context,
        method: "users/contact",
        param: map,
        isLoading: false, onResponseSuccess: (Map object) async {
      var result = LoginResponse.fromJson(object);
      this.otpHash = result.result!.otpHash!;
      setStates(() {
        isOTPLogin = true;
      });
      startTimer();
    });
  }

  _emailLoginService(StateSetter setStates) async {
    Map<String, dynamic> map = {"email": emailController.text};
    Api.post.call(context, method: "users/email", param: map, isLoading: false,
        onResponseSuccess: (Map object) async {
      var result = LoginResponse.fromJson(object);
      this.otpHash = result.result!.otpHash!;
      setStates(() {
        isOTPEmailLogin = true;
      });
      startTimer();
    });
  }

  Future<void> _handleOTPIn() async {
    if (otpNumber.text.length != 6) {
      //_mobileVerify();
      Constants.toastMessage(msg: "Enter 6-digit code!");
    } else {
      Map<String, dynamic> map = {
        "otp": int.parse(otpNumber.text),
        "otpHash": otpHash
      };
      Api.post.call(context,
          method: "users/contact/verify", param: map, isLoading: false,
          onResponseSuccess: (Map<dynamic, dynamic> object) async {
        var result = RegisterResponse.fromJson(object);
        isOTPLogin = false;
        Navigator.pop(context);
        Constants.toastMessage(msg: result.message);
      });
    }
  }

  Future<void> _handleOTPEmailIn() async {
    if (otpNumber.text.length != 6) {
      Constants.toastMessage(msg: "Enter 6-digit code!");
    } else {
      Map<String, dynamic> map = {
        "otp": int.parse(otpNumber.text),
        "otpHash": otpHash
      };
      Api.post.call(context,
          method: "users/email/verify",
          param: map,
          isLoading: false, onResponseSuccess: (Map object) async {
        var result = RegisterResponse.fromJson(object);
        isOTPEmailLogin = false;
        Navigator.pop(context);
        Constants.toastMessage(msg: result.message);
      });
    }
  }

  void startTimer() {
    if (isOTPLogin) {
      if (_timer != null) {
        _timer!.cancel();
        _timer = null;
      } else {
        _timer = new Timer.periodic(
          const Duration(seconds: 1),
          (Timer timer) => setState(
            () {
              if (_start < 1) {
                timer.cancel();
                _timer = null;
              } else {
                _start = _start - 1;
              }
            },
          ),
        );
      }
    }
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
                        if (pickedFile != null) {
                          _cropImage(profileImageFile!).then((value) async {
                            Constants.profileImage = await MultipartFile.fromFile(
                                value!.path,
                                filename:
                                    "${File(pickedFile.path).path.split('/').last}");
                            setState(() {
                              profileImageFile = value;
                            });
                            uploadPic();
                          });
                        }
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
                      if (pickedFile != null) {
                        _cropImage(profileImageFile!).then((value) async {
                          Constants.profileImage = await MultipartFile.fromFile(
                              value!.path,
                              filename:
                                  "${File(pickedFile.path).path.split('/').last}");
                          setState(() {
                            profileImageFile = value;
                          });
                          uploadPic();
                        });
                      }
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

  Future<File?> _cropImage(File image) async {
    return await ImageCropper().cropImage(
        sourcePath: image.path,
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
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
  }

  void _editProfileApi() async {
    if (_editFormKey.currentState!.validate() && locationModel != null) {
      if (userNameController.text.toLowerCase().contains("famelinks") ||
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
      } else if (isUserNameAvialble != null && isUserNameAvialble!) {
        FormData formData = FormData.fromMap({
          "username": userNameController.text,
          "name": nameController.text,
          "type": type.toString(),
          "bio": bioController.text,
          "profession": professionController.text,
          "district": locationModel!.district,
          "state": locationModel!.state,
          "country": locationModel!.country,
          "continent": locationModel!.continent,
          "websiteUrl": webController.text,
        });
        if (webController.text.isNotEmpty) {
          formData.fields.add(MapEntry(
              "${widget.isAgency ? "agencyWebsite" : "brandWebsite"}",
              webController.text));
        }
        for (int i = 0; i < imageList.length; i++) {
          formData.files.addAll([
            MapEntry("${widget.isAgency ? "agencyDoc" : "brandDoc"}",
                await MultipartFile.fromFile(imageList[i].path)),
          ]);
        }
        Api.uploadPut.call(context, method: "users/update", param: formData,
            onResponseSuccess: (Map object) {
          Navigator.pop(context, true);
        });
      } else {
        FormData formData = FormData.fromMap({
          "username": userNameController.text,
          "name": nameController.text,
          "type": type.toString(),
          "bio": bioController.text,
          "profession": professionController.text,
          "websiteUrl": webController.text,
          "district": locationModel!.district,
          "state": locationModel!.state,
          "country": locationModel!.country,
          "continent": locationModel!.continent,
        });
        if (webController.text.isNotEmpty) {
          formData.fields.add(MapEntry(
              "${widget.isAgency ? "agencyWebsite" : "brandWebsite"}",
              webController.text));
        }
        for (int i = 0; i < imageList.length; i++) {
          formData.files.addAll([
            MapEntry("${widget.isAgency ? "agencyDoc" : "brandDoc"}",
                await MultipartFile.fromFile(imageList[i].path)),
          ]);
        }
        Api.uploadPut.call(context, method: "users/update", param: formData,
            onResponseSuccess: (Map object) {
          Navigator.pop(context, true);
        });
      }
    } else {
      Constants.toastMessage(msg: "select Location");
    }
  }

  Future<List<AddressLocation>?> getLocation(String query) async {
    var result = await _api.getLocation(query);
    if (result != null) {
      if (result.success!) {
        locationList.addAll(result.result!);
        return locationList;
      } else {
        Constants.toastMessage(msg: result.message);
        return locationList;
      }
    }
  }

  void uploadPic() async {
    FormData formData = FormData.fromMap({});
    formData.files.addAll([
      MapEntry("profileImage", Constants.profileImage!),
    ]);
    Api.uploadPut.call(context,
        method: "users/profile/image/upload",
        param: formData, onResponseSuccess: (Map object) {
      var result = LikesResponse.fromJson(object);
      Constants.toastMessage(msg: result.message);
    });
  }

  void setData() {
    professionController.text = widget.upperProfileData.profession! != null
        ? widget.upperProfileData.profession!
        : "";
    nameController.text = widget.upperProfileData.name! != null
        ? widget.upperProfileData.name!
        : "";
    userNameController.text = widget.upperProfileData.username! != null
        ? widget.upperProfileData.username!
        : "";
    numberController.text = widget.upperProfileData.mobileNumber != null
        ? widget.upperProfileData.mobileNumber.toString()
        : "";
    emailController.text = widget.upperProfileData.email! != null
        ? widget.upperProfileData.email!
        : "";
    bioController.text =
        widget.upperProfileData.bio != null ? widget.upperProfileData.bio! : "";
    placeController.text = widget.upperProfileData.district != null
        ? "${widget.upperProfileData.district} ${widget.upperProfileData.state}, ${widget.upperProfileData.country}"
        : "";
    webController.text =
        widget.isAgency && widget.upperProfileData.agency != null
            ? "${widget.upperProfileData.agency!.websiteUrl}"
            : widget.upperProfileData.brand != null
                ? "${widget.upperProfileData.brand!.websiteUrl}"
                : "";
    type = widget.upperProfileData.type! != null
        ? widget.upperProfileData.type!
        : "individual";

    if (type == "individual") {
      selectedTypeIndex = 0;
    } else if (type == "agency") {
      selectedTypeIndex = 1;
    } else if (type == "brand") {
      selectedTypeIndex = 2;
    }
    locationModel = new AddressLocation();
    locationModel!.district = widget.upperProfileData.district;
    locationModel!.state = widget.upperProfileData.state;
    locationModel!.country = widget.upperProfileData.country;
    locationModel!.continent = widget.upperProfileData.country;
  }

  Future closeUp() async {
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
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image == null) return;
                        File closeUpImageFile = File(image.path);
                        _cropImage(closeUpImageFile).then((value) async {
                          print(value!.path);
                          setState(() {
                            closeUpImageFile = value;
                            imageList.add(value);
                          });
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
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (image == null) return;
                      File closeUpImageFile = File(image.path);
                      _cropImage(closeUpImageFile).then((value) async {
                        print(value!.path);
                        setState(() {
                          closeUpImageFile = value;
                          imageList.add(value);
                        });
                        // MultipartFile closeUp = await MultipartFile.fromFile(
                        //     closeUpImageFile.path,
                        //     filename:
                        //     "${File(image.path).path.split('/').last}");
                        // Constants.imageList.add(closeUp);
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
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
