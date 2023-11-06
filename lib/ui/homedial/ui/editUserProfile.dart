import 'dart:io';

import 'package:dio/dio.dart';
import 'package:famelink/common/common_image.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/LocationResponse.dart';
import 'package:famelink/models/likes_model.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/providers/UserProfileProvider/edit_user_profile_provider.dart';
import 'package:famelink/ui/Famelinkprofile/ProfileFameLink.dart';
import 'package:famelink/ui/homedial/model/CheckUserNameModel.dart';
import 'package:famelink/ui/profile_UI/PhotoImageScreen.dart';
import 'package:famelink/util/Validator.dart';
import 'package:famelink/util/appStrings.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:famelink/util/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditUserProfile extends StatefulWidget {
  final int? runType;
  String? name;
  String? profession;
  String? bio;
  String? imagUrl;
  String? imageType;
  String? userName;
  String? district;
  String? state;
  String? country;
  String? dob;
  String? imageTypeFromEdit;
  bool? isProfileUpdate;

  EditUserProfile(
      {this.runType,
      this.name,
      this.profession,
      this.bio,
      this.imagUrl,
      this.imageType,
      this.isProfileUpdate,
      this.userName,
      this.district,
      this.state,
      this.country,
      this.imageTypeFromEdit,
      this.dob});

  @override
  EditUserProfileState createState() => EditUserProfileState();
}

class EditUserProfileState extends State<EditUserProfile> {
  static String selectAvatar = "";
  static String selectAvatarType = "";
  static File? selectImageFilePath;

  // static bool isProfileUpdate = false;

  _init() {
    debugPrint("222 runType ${widget.runType}");
    debugPrint("222 name ${widget.name}");
    debugPrint("222 profession ${widget.profession}");
    debugPrint("222 bio ${widget.bio}");
    debugPrint("222 imagUrl ${widget.imagUrl}");
    debugPrint("222 userName ${widget.userName}");
    debugPrint("222 district ${widget.district}");
    debugPrint("222 state ${widget.state}");
    debugPrint("222 country ${widget.country}");
    debugPrint("222 dob ${widget.dob}");
    if (widget.name.toString() != 'null' &&
        widget.name.toString() != 'false' &&
        widget.name!.isNotEmpty) {
      Provider.of<UserEditProfileProvider>(context, listen: false)
          .nameController
          .text = widget.name.toString();
    } else {
      Provider.of<UserEditProfileProvider>(context, listen: false)
          .nameController
          .clear();
    }
    if (widget.dob.toString() != 'null' &&
        widget.dob.toString() != 'false' &&
        widget.dob!.isNotEmpty) {
      Provider.of<UserEditProfileProvider>(context, listen: false)
          .dobController
          .text = widget.dob.toString();
    } else {
      Provider.of<UserEditProfileProvider>(context, listen: false)
          .dobController
          .clear();
    }
    if (widget.profession.toString() != 'null' &&
        widget.profession.toString() != 'false' &&
        widget.profession!.isNotEmpty) {
      Provider.of<UserEditProfileProvider>(context, listen: false)
          .professionController
          .text = widget.profession.toString();
    } else {
      Provider.of<UserEditProfileProvider>(context, listen: false)
          .professionController
          .clear();
    }

    if (widget.bio.toString() != 'null' &&
        widget.bio.toString() != 'false' &&
        widget.bio!.isNotEmpty) {
      Provider.of<UserEditProfileProvider>(context, listen: false)
          .bioController
          .text = widget.bio.toString();
    } else {
      Provider.of<UserEditProfileProvider>(context, listen: false)
          .bioController
          .clear();
    }

    if (widget.userName.toString() != 'null' &&
        widget.userName.toString() != 'false' &&
        widget.userName!.isNotEmpty) {
      Provider.of<UserEditProfileProvider>(context, listen: false)
          .userNameController
          .text = widget.userName.toString();
    } else {
      Provider.of<UserEditProfileProvider>(context, listen: false)
          .userNameController
          .clear();
    }
    if (widget.district.toString() != 'null' &&
        widget.district.toString() != 'false' &&
        widget.district!.isNotEmpty &&
        widget.state.toString() != 'null' &&
        widget.state.toString() != 'false' &&
        widget.state!.isNotEmpty &&
        widget.country.toString() != 'null' &&
        widget.country.toString() != 'false' &&
        widget.country!.isNotEmpty) {
      Provider.of<UserEditProfileProvider>(context, listen: false)
          .locationCountry = widget.country;
      Provider.of<UserEditProfileProvider>(context, listen: false)
          .locationState = widget.state;
      Provider.of<UserEditProfileProvider>(context, listen: false)
          .locationDistrict = widget.district;
      Provider.of<UserEditProfileProvider>(context, listen: false)
              .placeController
              .text =
          '${widget.district.toString()}, ${widget.state.toString()}, ${widget.country.toString()}';
    } else {
      Provider.of<UserEditProfileProvider>(context, listen: false)
          .locationCountry = "";
      Provider.of<UserEditProfileProvider>(context, listen: false)
          .locationState = "";
      Provider.of<UserEditProfileProvider>(context, listen: false)
          .locationDistrict = "";
      Provider.of<UserEditProfileProvider>(context, listen: false)
          .placeController
          .text = '';
    }
    if (widget.imageType == "avatar") {
      if (widget.imagUrl.toString() != 'null' && widget.imagUrl!.isNotEmpty) {
        setState(() {
          selectAvatar =
              '${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${widget.imagUrl}';
          selectAvatarType = "liveAvtar";
        });
      }
    } else if (widget.imageType == "image") {
      if (widget.imagUrl.toString() != 'null' && widget.imagUrl!.isNotEmpty) {
        setState(() {
          selectAvatar =
              '${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${widget.imagUrl}';
          selectAvatarType = "liveFile";
        });
      }
    }
  }

  String? selectProfilePhoto;

  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final GlobalKey<FormState> _editFormKey = GlobalKey<FormState>();
  String ageGroup = "groupD";

  String type = "individual";

  final ApiProvider _api = ApiProvider();
  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  File? profileImageFile;

  AddressLocation? locationModel;
  int selectButtonIndex = 3;
  int selectedTypeIndex = 0;
  int firstYear = 0;
  int lastYear = 0;

  bool? isUserNameAvialble;

  @override
  void initState() {
    _init();
    // TODO: implement initState
    super.initState();
  }

  refresh() {
    Provider.of<UserEditProfileProvider>(context, listen: false)
        .changeKey(UniqueKey());
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: Provider.of<UserEditProfileProvider>(context, listen: false).getKey,
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileFameLink(
                selectPhase: widget.runType!,
              ),
            ),
          );
          return true;
        },
        child: Consumer<UserEditProfileProvider>(
            builder: (context, userEditProfileData, child) {
          return Scaffold(
            key: homeScaffoldKey,
            appBar: AppBar(
              iconTheme: IconThemeData(color: black),
              backgroundColor: appBackgroundColor,
              elevation: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileFameLink(
                        selectPhase: widget.runType!,
                      ),
                    ),
                  );
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              centerTitle: true,
              title: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Edit',
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w400,
                        color: black,
                        fontSize: ScreenUtil().setSp(18),
                      ),
                    ),
                    TextSpan(
                      text: ' Profile',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtil().setSp(18),
                          color: lightRed),
                    )
                  ],
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Form(
                    key: _editFormKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 45.0),
                              child: Text(
                                (widget.runType.toString() == '0')
                                    ? "FameLinks data"
                                    : (widget.runType.toString() == '3')
                                        ? "JobLinks data"
                                        : (widget.runType.toString() == '1')
                                            ? "FunLinks data"
                                            : (widget.runType.toString() == '2')
                                                ? "FollowLinks"
                                                : "No Select",
                                style: GoogleFonts.nunitoSans(
                                  color: HexColor("#FF5C28"),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhotoImageScreen(
                                    getRunScreen: 'editProfile',
                                    name: userEditProfileData.getName.text
                                        .toString(),
                                    dob: userEditProfileData.getDOB.text
                                        .toString(),
                                    district: userEditProfileData
                                        .getLocationDistrict
                                        .toString(),
                                    country: userEditProfileData
                                        .getLocationCountry
                                        .toString(),
                                    bio: userEditProfileData.getBio.text
                                        .toString(),
                                    pro: userEditProfileData.getProfession.text
                                        .toString(),
                                    runtypes: widget.runType.toString(),
                                    state: userEditProfileData.getLocationState
                                        .toString(),
                                    username: userEditProfileData
                                        .getUserName.text
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(10)),
                                  width: 144,
                                  height: 144,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Image.asset(
                                      CommonImage.editProfileShapeCircle,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 15.0,
                                  left: 6.8,
                                  child: widget.imageType! == "avatar" ||
                                          selectAvatar == "avatar"
                                      ? CircleAvatar(
                                          radius: 62,
                                          backgroundImage: NetworkImage(
                                              "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${widget.imagUrl!.toString()}"))
                                      : selectAvatarType == "file"
                                          ? CircleAvatar(
                                              radius: 62,
                                              backgroundImage: FileImage(
                                                  selectImageFilePath!))
                                          : CircleAvatar(
                                              radius: 62,
                                              backgroundImage: NetworkImage(
                                                  "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${widget.imagUrl!.toString()}")),
                                ),
                                Positioned(
                                  bottom: 12.0,
                                  right: 20.0,
                                  child: CircleAvatar(
                                    child: SizedBox(
                                      height: 22,
                                      width: 22,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: ScreenUtil().setSp(55),
                                          ),
                                          Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.black,
                                            size: 13,
                                          ),
                                        ],
                                      ),
                                    ),
                                    radius: 12,
                                  ),
                                ),
                              ],
                            ),
                            // :
                          ),

                          ///name
                          Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(10),
                                left: ScreenUtil().setWidth(44),
                                right: ScreenUtil().setWidth(44)),
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              textAlignVertical: TextAlignVertical.center,
                              controller: userEditProfileData.getName,
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
                                      color: HexColor("#9B9B9B"),
                                      width: ScreenUtil().radius(1)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenUtil().radius(5))),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HexColor("#9B9B9B"),
                                      width: ScreenUtil().radius(1)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenUtil().radius(5))),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HexColor("#9B9B9B"),
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
                              controller: userEditProfileData.getProfession,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(16),
                                  color: black,
                                  fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HexColor("#9B9B9B"),
                                      width: ScreenUtil().radius(1)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenUtil().radius(5))),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HexColor("#9B9B9B"),
                                      width: ScreenUtil().radius(1)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenUtil().radius(5))),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HexColor("#9B9B9B"),
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
                              controller: userEditProfileData.getBio,
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
                                      color: HexColor("#9B9B9B"),
                                      width: ScreenUtil().radius(1)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenUtil().radius(5))),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HexColor("#9B9B9B"),
                                      width: ScreenUtil().radius(1)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenUtil().radius(5))),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HexColor("#9B9B9B"),
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
                          SizedBox(
                            height: 40.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 45.0, right: 45.0, bottom: 0.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Master data",
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(14),
                                    color: HexColor("#FF5C28"),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  width: ScreenUtil().screenWidth * 0.53,
                                  color: HexColor("#FFA88C"),
                                  child: Text(""),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(44),
                                right: ScreenUtil().setWidth(44)),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 50,
                                      width: ScreenUtil().screenWidth - 150,
                                      child: TextFormField(
                                        textAlign: TextAlign.start,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        controller:
                                            userEditProfileData.getUserName,
                                        textInputAction: TextInputAction.done,
                                        validator: (value) {
                                          return Validator.validateFormField(
                                              value!,
                                              strErrorEmptyUserName,
                                              strErrorInvalidUserName,
                                              Constants.MIN_CHAR_VALIDATION);
                                        },
                                        onChanged: (value) {
                                          if (value.toString().isNotEmpty &&
                                              value.toString().trim().length !=
                                                  0 &&
                                              value.toString().isNotEmpty) {
                                            verifyNickName(value.toString());
                                          } else {}
                                        },
                                        style: GoogleFonts.nunitoSans(
                                            fontSize: ScreenUtil().setSp(12),
                                            color: buttonBlue,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400),
                                        readOnly: (userEditProfileData
                                                    .getIsShowDropDown ==
                                                true)
                                            ? true
                                            : false,
                                        decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              bottom:
                                                  ScreenUtil().setHeight(0)),
                                          hintText: 'username',
                                          prefixText:
                                              "${userEditProfileData.getUserName.text.startsWith("@") ? "" : "@"}",
                                          hintStyle: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(12),
                                              color: buttonBlue,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0, bottom: 5.0),
                                      child: userEditProfileData
                                                  .getIsValidNickName ==
                                              '0'
                                          ? Container()
                                          : (userEditProfileData
                                                      .getIsValidNickName ==
                                                  '1')
                                              ? SvgPicture.asset(
                                                  "assets/icons/svg/done.svg",
                                                  height:
                                                      ScreenUtil().setSp(16),
                                                  width: ScreenUtil().setSp(16),
                                                  color: Colors.green,
                                                )
                                              : Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                  size: 16,
                                                ),
                                    ),
                                  ],
                                ),
                                Container(
                                  color: HexColor("#9B9B9B"),
                                  height: 1,
                                  width: ScreenUtil().screenWidth,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),

                          ///LOCATION
                          ///
                          Stack(
                            //overflow: Overflow.visible,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(10),
                                    left: ScreenUtil().setWidth(44),
                                    right: ScreenUtil().setWidth(44)),
                                child: TextFormField(
                                  controller: userEditProfileData.getPlace,
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: ScreenUtil().setSp(14),
                                      color: black,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor("#9B9B9B"),
                                          width: ScreenUtil().radius(1)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenUtil().radius(5))),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor("#9B9B9B"),
                                          width: ScreenUtil().radius(1)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenUtil().radius(5))),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor("#9B9B9B"),
                                          width: ScreenUtil().radius(1)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenUtil().radius(5))),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red,
                                          width: ScreenUtil().radius(1)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenUtil().radius(5))),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(13.73)),
                                    hintText: 'Location',
                                    hintStyle: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(14),
                                        color: lightGray,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onChanged: (value) {
                                    if (value.toString().isNotEmpty &&
                                        value.toString().trim().length != 0 &&
                                        value.toString().isNotEmpty) {
                                      userEditProfileData
                                          .changeIsShowDropDown(true);
                                      List<AddressLocation> locationList =
                                          <AddressLocation>[];
                                      userEditProfileData
                                          .changeLocationList(locationList);
                                      getLocation(value.toString());
                                    } else {
                                      userEditProfileData
                                          .changeIsShowDropDown(false);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 80.0,
                              ),
                              Positioned(
                                bottom: 50.0,
                                left: 45.0,
                                height: 50,
                                width: ScreenUtil().screenWidth - 80,
                                child: Visibility(
                                  visible:
                                      (userEditProfileData.getIsShowDropDown ==
                                              true &&
                                          int.parse(userEditProfileData
                                                  .getLocationList.length
                                                  .toString()) !=
                                              0),
                                  child: Container(
                                    padding: EdgeInsets.zero,
                                    margin: EdgeInsets.zero,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemCount: userEditProfileData
                                          .getLocationList.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: <Widget>[
                                            const SizedBox(
                                              height: 3.0,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                debugPrint(
                                                    "123-123-123-123-123-123 Location 123-123-123-123-");
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  right: 30.0,
                                                  left: 5.0,
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: 5.0, bottom: 5.0),
                                                width: ScreenUtil().screenWidth,
                                                child: InkWell(
                                                  onTap: () {
                                                    print("===========");
                                                    userEditProfileData
                                                        .changeLocationDistrict(
                                                            userEditProfileData
                                                                .getLocationList[
                                                                    index]
                                                                .district
                                                                .toString());
                                                    userEditProfileData
                                                        .changeLocationState(
                                                            userEditProfileData
                                                                .getLocationList[
                                                                    index]
                                                                .state
                                                                .toString());
                                                    userEditProfileData
                                                        .changeLocationCountry(
                                                            userEditProfileData
                                                                .getLocationList[
                                                                    index]
                                                                .country
                                                                .toString());
                                                    userEditProfileData
                                                            .placeController
                                                            .text =
                                                        "${userEditProfileData.getLocationList[index].district},${userEditProfileData.getLocationList[index].state},${userEditProfileData.getLocationList[index].country}";
                                                    userEditProfileData
                                                        .changeIsShowDropDown(
                                                            false);
                                                  },
                                                  child: Text(
                                                      '${userEditProfileData.getLocationList[index].district},${userEditProfileData.getLocationList[index].state},${userEditProfileData.getLocationList[index].country}'),
                                                ),
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          ///DOB
                          Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(10),
                                left: ScreenUtil().setWidth(44),
                                right: ScreenUtil().setWidth(44)),
                            child: TextFormField(
                              onTap: () {
                                _selectDate(context);
                              },
                              focusNode: AlwaysDisabledFocusNode(),
                              textAlign: TextAlign.start,
                              textAlignVertical: TextAlignVertical.center,
                              controller: userEditProfileData.getDOB,
                              keyboardType: TextInputType.datetime,
                              textInputAction: TextInputAction.done,
                              style: GoogleFonts.nunitoSans(
                                  fontSize: ScreenUtil().setSp(12),
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

                          ///BUTTON
                        ],
                      ),
                    ),
                  ),
                ),
                SubmitButton(text: 'Submit', onPressed: _editProfileApi)
              ],
            ),
          );
        }),
      ),
    );
  }

  bool isMoveNextScreen = false;

  void _editProfileApi() async {
    Constants.progressDialog(true, context);
    await updateIndicator();
    await userUpdate();
    if (isMoveNextScreen == true) {
      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      //     ProfileFameLink(runSelectPhase: widget.runType)), (Route<dynamic> route) => false);
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ProfileFameLink(runSelectPhase: widget.runType),
      //   ),
      // );
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => ProfileFameLink(runSelectPhase: widget.runType),
      //   ),
      // );
      Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => ProfileFameLink(
                  selectPhase: widget.runType!,
                )),
        ModalRoute.withName('/'),
      );
    }
  }

  Future<List<AddressLocation>?> getLocation(String query) async {
    var result = await _api.getLocation(query);
    final userEditProfileData =
        Provider.of<UserEditProfileProvider>(context, listen: false);

    if (result != null) {
      debugPrint("111-111-111-111- Result ${result.toString()}");
      if (result.success == true) {
        debugPrint("222-222-222-222- Result ${result.toString()}");
        userEditProfileData.locationList.addAll(result.result!);
        userEditProfileData.changeKey(UniqueKey());
        return userEditProfileData.getLocationList;
      } else {
        Constants.toastMessage(msg: result.message);
        return userEditProfileData.getLocationList;
      }
    }
  }

  CheckUserNameModel? _checkUserNameModel;

  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  String? strings;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        // firstDate: DateTime(1800, 8),
        firstDate: DateTime(150, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        strings = dateFormat.format(picked);
        selectedDate = picked;
      });
      Provider.of<UserEditProfileProvider>(context).dobController.text =
          strings.toString();
      debugPrint("123123-123123123- ${strings.toString()}");
    }
  }

  Future updateIndicator() async {
    final userEditProfileData =
        Provider.of<UserEditProfileProvider>(context, listen: false);
    debugPrint(
        "111-111-111-111- updateIndicator ${userEditProfileData.getIsShowDropDown.toString()}");
    //File file = File("as");
    Map params;
    var result;
    print("isProfileUpdate===================${widget.isProfileUpdate}");
    if (widget.isProfileUpdate == false) {
      result = await _api.userIndicator(
        isProfileUpdates: widget.isProfileUpdate,
        name: (userEditProfileData.getName.text.toString().isNotEmpty)
            ? userEditProfileData.getName.text.toString()
            : "",
        professions:
            (userEditProfileData.getProfession.text.toString().isNotEmpty)
                ? userEditProfileData.getProfession.text.toString()
                : "",
        bio: (userEditProfileData.getBio.text.toString().isNotEmpty)
            ? userEditProfileData.getBio.text.toString()
            : "",
        types: (widget.runType.toString() == '0')
            ? "famelinks"
            : (widget.runType.toString() == '3')
                ? "joblinks"
                : (widget.runType.toString() == '1')
                    ? "funlinks"
                    : (widget.runType.toString() == '2')
                        ? "followlinks"
                        : "No Select",
      );
    } else if (widget.isProfileUpdate == true) {
      if (widget.imageTypeFromEdit == "editImage") {
        result = await _api.userIndicator(
          isProfileUpdates: widget.isProfileUpdate,
          profileFile: selectImageFilePath,
          name: (userEditProfileData.getName.text.toString().isNotEmpty)
              ? userEditProfileData.getName.text.toString()
              : "",
          professions:
              (userEditProfileData.getProfession.text.toString().isNotEmpty)
                  ? userEditProfileData.getProfession.text.toString()
                  : "",
          bio: (userEditProfileData.getBio.text.toString().isNotEmpty)
              ? userEditProfileData.getBio.text.toString()
              : "",
          types: (widget.runType.toString() == '0')
              ? "famelinks"
              : (widget.runType.toString() == '3')
                  ? "joblinks"
                  : (widget.runType.toString() == '1')
                      ? "funlinks"
                      : (widget.runType.toString() == '2')
                          ? "followlinks"
                          : "No Select",
        );
      } else if (widget.imageTypeFromEdit == "editAvatar") {
        result = await _api.userIndicator(
          isProfileUpdates: widget.isProfileUpdate,
          avatarImage: selectAvatar,
          name: (userEditProfileData.getName.text.toString().isNotEmpty)
              ? userEditProfileData.getName.text.toString()
              : "",
          professions:
              (userEditProfileData.getProfession.text.toString().isNotEmpty)
                  ? userEditProfileData.getProfession.text.toString()
                  : "",
          bio: (userEditProfileData.getBio.text.toString().isNotEmpty)
              ? userEditProfileData.getBio.text.toString()
              : "",
          types: (widget.runType.toString() == '0')
              ? "famelinks"
              : (widget.runType.toString() == '3')
                  ? "joblinks"
                  : (widget.runType.toString() == '1')
                      ? "funlinks"
                      : (widget.runType.toString() == '2')
                          ? "followlinks"
                          : "No Select",
        );
      }
    }

    print("========result$result");

    if (result != null) {
      if (result == '1') {
        setState(() {
          isMoveNextScreen = true;
        });
      } else {
        setState(() {
          isMoveNextScreen = false;
        });
        // Constants.toastMessage(msg: "Something went to wrong");
      }
    }
  }

  Future userUpdate() async {
    final userEditProfileData =
        Provider.of<UserEditProfileProvider>(context, listen: false);

    debugPrint(
        "111-111-111-111- userUpdate ${userEditProfileData.getDOB.text.toString()}");
    debugPrint(
        "111-111-111-111- userUpdate ${userEditProfileData.getIsShowDropDown.toString()}");

    Map params;
    var result = await _api.updateUser(
      dob: (userEditProfileData.getDOB.text.toString().isNotEmpty)
          ? userEditProfileData.getDOB.text.toString()
          : "",
      locationCountry: userEditProfileData.getLocationCountry.toString(),
      locationDistrict: userEditProfileData.getLocationDistrict.toString(),
      locationState: userEditProfileData.getLocationState.toString(),
      username: (userEditProfileData.getUserName.text.toString().isNotEmpty)
          ? userEditProfileData.getUserName.text.toString()
          : "",
    );

    if (result != null) {
      debugPrint("111-111-111-111- userUpdate Result ${result.toString()}");
      if (result.toString() == '1') {
        setState(() {
          isMoveNextScreen = true;
        });
      } else {
        setState(() {
          isMoveNextScreen = false;
        });
        //Constants.toastMessage(msg: "Something went to wrong");
      }
    }
  }

  Future verifyNickName(String query) async {
    final userEditProfileData =
        Provider.of<UserEditProfileProvider>(context, listen: false);

    userEditProfileData.changeIsValidNickName("4");
    userEditProfileData.changeKey(UniqueKey());
    debugPrint(
        "111-111-111-111- verifyNickName ${userEditProfileData.getIsShowDropDown.toString()}");
    var result = await _api.verifyUserName(query);

    if (result != null) {
      debugPrint("111-111-111-111- verifyNickName Result ${result.toString()}");
      if (result.success == true) {
        debugPrint(
            "222-222-222-222-  verifyNickName Result ${result.toString()}");
        setState(() {
          _checkUserNameModel = result;
        });
        userEditProfileData.getUserName.text = query;

        if (_checkUserNameModel!.result!.isAvailable == true) {
          userEditProfileData.changeIsValidNickName("1");
          userEditProfileData.changeKey(UniqueKey());
          debugPrint(
              "222-222-222-222- inside verifyNickName Result Avilable ${userEditProfileData.getIsValidNickName}");
        } else {
          userEditProfileData.changeIsValidNickName("4");
          userEditProfileData.changeKey(UniqueKey());
        }
      } else {
        Constants.toastMessage(msg: result.message);
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
        param: formData, onResponseSuccess: (Map<dynamic, dynamic> object) {
      var result = LikesResponse.fromJson(object);
      Constants.toastMessage(msg: result.message);
    });
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
