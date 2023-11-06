import 'dart:convert';
import 'dart:io';

import 'package:famelink/databse/db_provider.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/providers/UserProfileProvider/userProfile_provider.dart';
import 'package:famelink/ui/authentication/OTPScreen.dart';
import 'package:famelink/ui/authentication/login_screen.dart';
import 'package:famelink/ui/home_feed/view/main_feed_screen.dart';
import 'package:famelink/ui/startTour/open_tour_screen.dart';
import 'package:famelink/util/constants.dart';
import 'package:famelink/util/routers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../models/LocationResponse.dart';
import '../../ui/homedial/model/RegistrationModel.dart';

class AuthenticationProvider extends ChangeNotifier {
  ///Base Url
  final requestBaseUrl = ApiProvider.loginUrl;

  ///Setter
  bool? _isLoading = false;
  String? _resMessage = '';

  //Getter
  bool? get isLoading => _isLoading;
  String? get resMessage => _resMessage;

  List<String> profileTypes = ['Individual', 'Agency', 'Brand'];
  List<Map<String, String>> genders = [
    {'gender': 'Male', 'icon': 'assets/icons/ic_male.svg'},
    {'gender': 'Female', 'icon': 'assets/icons/ic_female.svg'},
    {'gender': 'Other', 'icon': 'assets/icons/ic_other.svg'}
  ];
  String? setectedProfileType;
  String? setectedGender;
  final locationController = TextEditingController();
  final signUpController = TextEditingController();
  final nickNameController = TextEditingController();
  final dobController = TextEditingController();
  DateTime? selectedDob;
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  File? selectedProfile;
  String? selectedAvatar;
  String? selectAvatarStatus;
  RegistrationModel? registrationModel;
  ApiProvider _api = ApiProvider();
  AddressLocation? location;

  void selectProfile(String value) {
    setectedProfileType = value;
    notifyListeners();
  }

  void selectGender(String value) {
    setectedGender = value;
    notifyListeners();
  }

  void selectedLocation(AddressLocation value) {
    location = value;
    locationController.text =
        "${value.district}, ${value.state}, ${value.country}";
    notifyListeners();
  }

  void selectDoB(BuildContext context) async {
    selectedDob = await selectDate(context);
    if (selectedDob != null) {
      dobController.text = '${dateFormat.format(selectedDob!).toString()}';
      notifyListeners();
    }
  }

  void selectProfilePic(File value) {
    selectedProfile = value;
    notifyListeners();
  }

  void selectAvatarPic(String value) {
    selectedAvatar = value;
    notifyListeners();
  }

  void selectAvatarPicStatus(String value) {
    selectAvatarStatus = value;
    notifyListeners();
  }

  //Login
  void loginUser({
    required String mobileNumber,
    required String code,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/users/login";

    final body = {"mobileNumber": mobileNumber, "code": code};
    print("body$body");

    try {
      _isLoading = true;
      notifyListeners();
      http.Response req = await http.post(Uri.parse(url), body: body);

      if (req.statusCode == 200) {
        final res = json.decode(req.body);

        print("res$res");
        _isLoading = false;
        _resMessage = "Login successful!";
        notifyListeners();
        print("res${res['result']['otpHash']}");
        String otpHash = res['result']['otpHash'].toString();
        PageNavigator(ctx: context!).nextPage(
            page: OTPScreen(
          otpHash: otpHash,
        ));
      } else {
        final res = json.decode(req.body);

        _resMessage = res['message'];

        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again`";
      notifyListeners();

      print(":::: $e");
    }
  }

  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }

  void otpVerification({
    required String otp,
    required String pushToken,
    required String otpHash,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();
    String url = "${requestBaseUrl}users/verifyOtp";

    final body = {"otp": otp, "pushToken": pushToken, "otpHash": otpHash};
    print("url-->$url");
    print("body$body");

    try {
      _isLoading = true;
      notifyListeners();
      http.Response req = await http.post(Uri.parse(url), body: body);

      if (req.statusCode == 200) {
        final res = json.decode(req.body);

        print("res$res");
        _isLoading = false;
        _resMessage = "Login successful!";
        final token = res['result']['token'];
        final id = res['result']['_id'];
        print("token=================$token");
        final accountRecoveryOption = res['result']['accountRecoveryOption'];
        // final id = res['result']['id'];
        await DatabaseProvider().saveToken(token);
        DatabaseProvider().saveUserId(id);
        DatabaseProvider().setIsLoggedIn(true);
        DatabaseProvider().setIsFirstLoggedIn(true);

        if (accountRecoveryOption == true) {
          showDialog<bool>(
            context: context!,
            builder: (BuildContext context) => AlertDialog(
              title: Text('Welcome'),
              content: Text('Do you want to restore you Account'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    DatabaseProvider().prefClear(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()),
                      (route) => route.isFirst,
                    );
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () async {
                    //userMe(context: context);
                    await UserProfileProvider().userMe();
                    final isRegistered =
                        await DatabaseProvider().getisRegistered();
                    if (isRegistered == true) {
                      DatabaseProvider().setIsTourShown(true);
                      DatabaseProvider().setIsFameLinksTourShown(true);
                      DatabaseProvider().setIsFunLinksTourShown(true);
                      DatabaseProvider().setIsFollowLinksTourShown(true);

                      PageNavigator(ctx: context!)
                          .nextPageOnly(page: MainFeedScreen());
                      print("object=========================true");
                    } else if (isRegistered == false) {
                      DatabaseProvider().setIsTourShown(false);
                      DatabaseProvider().setIsFameLinksTourShown(false);
                      DatabaseProvider().setIsFunLinksTourShown(false);
                      DatabaseProvider().setIsFollowLinksTourShown(false);
                      PageNavigator(ctx: context!)
                          .nextPageOnly(page: OpenTourScreen());
                    }
                  },
                  child: const Text('YES'),
                ),
              ],
            ),
          );
        } else {
          //userMe(context: context);
          await UserProfileProvider().userMe();
          final isRegistered = await DatabaseProvider().getisRegistered();
          if (isRegistered == true) {
            DatabaseProvider().setIsTourShown(true);
            DatabaseProvider().setIsFameLinksTourShown(true);
            DatabaseProvider().setIsFunLinksTourShown(true);
            DatabaseProvider().setIsFollowLinksTourShown(true);

            PageNavigator(ctx: context!).nextPageOnly(page: MainFeedScreen());
            print("object=========================true");
          } else if (isRegistered == false) {
            DatabaseProvider().setIsTourShown(false);
            DatabaseProvider().setIsFameLinksTourShown(false);
            DatabaseProvider().setIsFunLinksTourShown(false);
            DatabaseProvider().setIsFollowLinksTourShown(false);
            PageNavigator(ctx: context!).nextPageOnly(page: OpenTourScreen());
          }
        }
      } else {
        final res = json.decode(req.body);

        _resMessage = res['message'];

        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();

      print(":::: $e");
    }
  }

  Future<List<AddressLocation>> getLocation(String query) async {
    List<AddressLocation> matches = <AddressLocation>[];
    if (query.length >= 3 && query.length < 20) {
      var response = await ApiProvider().getLocation(query);
      if (response != null) {
        final result = LocationResponse.fromJson(response.toJson());
        return result.result!;
      } else {
        return matches;
      }
    } else {
      return matches;
    }
  }

  Future<DateTime?> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        // firstDate: DateTime(1800, 8),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime.now());
    if (picked != null) {
      return picked;
    } else {
      return null;
    }
  }

  void register(BuildContext context) async {
    if (signUpController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter your name',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG,
      );
    } else if (locationController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please select your location',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG,
      );
    } else if (dobController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please select your Date of Birth',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG,
      );
    } else {
      Constants.progressDialog(true, context);
      _isLoading = true;
      notifyListeners();
      var result = await _api.registration(
          context: context,
          name: signUpController.text,
          continent: "Asia",
          country: location!.country ?? "india",
          district: location!.district ?? "",
          gender:
              setectedGender != null ? setectedGender!.toLowerCase() : 'male',
          state: location!.state ?? "",
          type: setectedProfileType != null
              ? setectedProfileType!.toLowerCase()
              : 'individual',
          username: nickNameController.text,
          dob: dobController.text,
          imageAvatar: selectedAvatar ?? "",
          imageType: selectAvatarStatus,
          imgFile: selectedProfile ?? null);
      if (result != null) {
        _isLoading = false;
        registrationModel = result;
        notifyListeners();
        Navigator.pop(context);
        await DatabaseProvider()
            .setIsRegistered(registrationModel!.result!.isRegistered!);
        if (registrationModel!.result!.profileImageType == "avatar") {
          DatabaseProvider().setProfileImage(
              '${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${registrationModel!.result!.profileImage}',
              'avatar');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainFeedScreen()),
              (route) => false);
        } else if (registrationModel!.result!.profileImageType == "image") {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainFeedScreen()),
              (route) => false);
        } else if (registrationModel!.result!.profileImageType == "") {
          DatabaseProvider().setProfileImage('', 'noImage');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainFeedScreen()),
              (route) => false);
        }
      }
    }
  }
}
