import 'dart:async';
import 'dart:io';

import 'package:country_codes/country_codes.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/CountryModel.dart';
import 'package:famelink/models/Profile_Model.dart';
import 'package:famelink/models/google_login_model.dart';
import 'package:famelink/models/login_model.dart';
import 'package:famelink/models/otp_model.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/providers/AuthProvider/auth_provider.dart';
import 'package:famelink/ui/authentication/TroubleLogin.dart';
import 'package:famelink/ui/home_feed/component/home_feed.dart';
import 'package:famelink/ui/home_feed/view/main_feed_screen.dart';
import 'package:famelink/ui/startTour/open_tour_screen.dart';
import 'package:famelink/util/Validator.dart';
import 'package:famelink/util/appStrings.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/config/image.dart';
import 'package:famelink/util/config/text.dart';
import 'package:famelink/util/constants.dart';
import 'package:famelink/util/keychain.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../util/widgets/button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController phoneCodeNumber = TextEditingController();

  String otpHash = "";
  List<Country> countryList = [];
  String token = "";

  Country? countryModel;

  var isWrongCode = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );
  GoogleSignInAccount? _currentUser;

  DateTime? currentBackPressTime;
  final TextEditingController controller = TextEditingController();
  // FirebaseMessaging _firebaseMessaging = Constants.firebaseMessaging;

  Future<List<Country>> _getAddressLocation(String query) async {
    List<Country> matches = <Country>[];
    if (query.isNotEmpty) {
      matches.addAll(countryList);
      matches.retainWhere(
          (s) => s.code!.toLowerCase().contains(query.toLowerCase()));
    } else {
      return countryList;
    }
    return matches;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountry();
  }

  @override
  Widget build(BuildContext context) {
    // CountryDetails details = CountryCodes.detailsForLocale();
    // print(details.dialCode);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: DoubleBack(
        message: 'Press back again to exit app',
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              Center(
                child: Container(
                  //height: 600,
                  //width: 700,
                  child: Image.asset(
                    "assets/images/model.png",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //topSection(),
              Container(
                margin: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height / 2) - 50),
                //padding: EdgeInsets.fromLTRB(0, 0, 0, 13),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: ScreenUtil().setSp(100),
                      height: ScreenUtil().setSp(100),
                      padding: EdgeInsets.all(ScreenUtil().setSp(18)),
                      decoration: new BoxDecoration(
                        border: Border.all(
                            color: Colors.white, width: ScreenUtil().setSp(2)),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [lightRedWhite, lightRed]),
                        shape: BoxShape.circle,
                      ),
                      child:
                          SvgPicture.asset("assets/icons/svg/logo_splash.svg"),
                    ),
                    title(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(42),
                          ScreenUtil().setWidth(32),
                          ScreenUtil().setWidth(42),
                          0),
                      child: Column(
                        children: [
                          enterPhoneNumber(),

                          SizedBox(
                            height: ScreenUtil().setSp(4),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(20),
                                right: ScreenUtil().setWidth(20)),
                            child: Row(
                              children: [
                                Text(
                                    countryModel != null
                                        ? '${countryModel!.country} selected'
                                        : "",
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(10),
                                        color: buttonBlue,
                                        fontWeight: FontWeight.w700)),
                                Expanded(
                                    child: Center(
                                  child: Visibility(
                                    visible: isWrongCode,
                                    child: Text('Wrong Country Code',
                                        style: GoogleFonts.nunitoSans(
                                            fontSize: ScreenUtil().setSp(10),
                                            color: lightRed,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ))
                              ],
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setSp(25),
                                bottom: ScreenUtil().setSp(16)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: ScreenUtil().setSp(20),
                                  child: Divider(
                                    height: ScreenUtil().setSp(1),
                                    thickness: ScreenUtil().setSp(1),
                                    color: lightGray,
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setSp(10),
                                ),
                                Text('or',
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w400,
                                        color: black,
                                        fontSize: ScreenUtil().setSp(12))),
                                SizedBox(
                                  width: ScreenUtil().setSp(10),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setSp(20),
                                  child: Divider(
                                    height: ScreenUtil().setSp(1),
                                    thickness: ScreenUtil().setSp(1),
                                    color: lightGray,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          googleLoginButton(),
                          // !isOTPLogin && Platform.isIOS
                          //     ? appleLoginButton()
                          //     : Container(),
                        ],
                      ),
                    ),
                    bottomSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget topSection() {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     height: (MediaQuery.of(context).size.height / 2) - 20,
  //     decoration: BoxDecoration(shape: BoxShape.circle),
  //     child: Arc(
  //       edge: Edge.BOTTOM,
  //       arcType: ArcType.CONVEX,
  //       height: ScreenUtil().setHeight(100),
  //       child: Image.asset(placeHolder,
  //           fit: BoxFit.cover, width: MediaQuery.of(context).size.width),
  //     ),
  //   );
  // }

  Widget title() {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(375),
      height: ScreenUtil().setHeight(50),
      child: Center(
        child: Row(
          children: [
            Container(
              width: ScreenUtil().setWidth(90),
            ),
            Text.rich(TextSpan(children: <TextSpan>[
              TextSpan(
                text: "Fame",
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenUtil().setSp(36),
                    color: lightRed,
                    shadows: [
                      Shadow(
                        offset: Offset(0.0, 2.0), //position of shadow
                        blurRadius: 2.0, //blur intensity of shadow
                        color: Colors.black
                            .withOpacity(0.6), //color of shadow with opacity
                      ),

                      //add more shadow with different position offset here
                    ]),
              )
            ])),
            Text.rich(TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "Links",
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w700,
                      fontSize: ScreenUtil().setSp(36),
                      color: black,
                      shadows: [
                        Shadow(
                          offset: Offset(0.0, 2.0), //position of shadow
                          blurRadius: 2.0, //blur intensity of shadow
                          color: Colors.black
                              .withOpacity(0.6), //color of shadow with opacity
                        ),

                        //add more shadow with different position offset here
                      ]))
            ])),
          ],
        ),
      ),
    );
  }

  Widget enterPhoneNumber() {
    return Container(
      height: ScreenUtil().setSp(50),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        border: Border.all(width: ScreenUtil().setSp(1), color: buttonBlue),
        borderRadius: BorderRadius.all(Radius.circular(ScreenUtil()
                .setSp(8)) //                 <--- border radius here
            ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: ScreenUtil().setSp(85),
            height: ScreenUtil().setSp(55),
            child: TypeAheadFormField<Country>(
              textFieldConfiguration: TextFieldConfiguration(
                controller: phoneCodeNumber,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                style: GoogleFonts.nunitoSans(
                    color: darkGray,
                    fontStyle: FontStyle.italic,
                    fontSize: ScreenUtil().setSp(14),
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  prefixText: "+",
                  prefixIcon: Icon(
                    Icons.flag,
                    color: darkGray,
                  ),
                  hintText: 'Code',
                  hintStyle: GoogleFonts.nunitoSans(
                      fontSize: ScreenUtil().setSp(14),
                      color: darkGray,
                      fontStyle: FontStyle.italic,
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
                    "${suggestion.country}",
                    //style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSuggestionSelected: (suggestion) {
                this.countryModel = suggestion;
                setState(() {
                  phoneCodeNumber.text = "${suggestion.code}";
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: VerticalDivider(
              width: 1,
              thickness: 1,
              color: darkGray,
            ),
          ),
          Consumer<AuthenticationProvider>(builder: (context, auth, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (auth.resMessage != '') {
                // showMessage(
                //     message: auth.resMessage, context: context);

                ///Clear the response message to avoid duplicate
                auth.clear();
              }
            });
            return Expanded(
              child: TextFormField(
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(17),
                ],
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                controller: phoneNumber,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                style: GoogleFonts.nunitoSans(
                    fontSize: ScreenUtil().setSp(14),
                    fontStyle: FontStyle.italic,
                    color: darkGray,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                    hintText: 'Enter Phone Number',
                    hintStyle: GoogleFonts.nunitoSans(
                        fontSize: ScreenUtil().setSp(14),
                        fontStyle: FontStyle.italic,
                        color: darkGray,
                        fontWeight: FontWeight.w400),
                    suffixIcon: Consumer<AuthenticationProvider>(
                        builder: (context, auth, child) {
                      return auth.isLoading == true
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20.h,
                                  width: 20.h,
                                  child: CircularProgressIndicator(
                                    semanticsLabel: 'Login....',
                                    strokeWidth: 3,
                                    color: orange,
                                  ),
                                ),
                              ],
                            )
                          : IconButton(
                              onPressed: () async {
                                Country country = Country();
                                country.code = phoneCodeNumber.text;
                                print(countryList.contains(country));
                                if (!countryList.contains(country)) {
                                  setState(() {
                                    isWrongCode = true;
                                  });
                                } else if (phoneCodeNumber.text.length > 1 &&
                                    phoneNumber.text.isNotEmpty) {
                                  setState(() {
                                    isWrongCode = false;
                                  });
                                  print("phoneCodeNumber${phoneNumber.text}");

                                  auth.loginUser(
                                      mobileNumber: phoneNumber.text.toString(),
                                      code: phoneCodeNumber.text,
                                      context: context);
                                  // auth.isLoading;
                                  // await _loginService();
                                } else if (phoneNumber.text.isEmpty) {
                                  setState(() {
                                    isWrongCode = false;
                                  });
                                  Constants.toastMessage(
                                      msg: "Enter Phone Number");
                                }
                                context = context;
                              },
                              icon: Icon(
                                Icons.arrow_forward_rounded,
                                color: darkGray,
                              ),
                            );
                    })),
              ),
            );
          }),
        ],
      ),
    );
  }

  Future<void> _handleSignIn() async {
    Constants.progressDialog1(true, context);
    Constants.firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
    );
    Constants.firebaseMessaging.getToken().then((token) {
      this.token = token!; // Print the Token in Console
    });
    print("Sign In Success");
    //GoogleSignIn().signIn();
    //_googleSignIn.signOut();
    //_googleSignIn.signIn();
    _googleSignIn.signIn().then((result) {
      print("Sign In Success");
      result!.authentication.then((googleKey) {
        _signInWithGoogle(_googleSignIn.currentUser!.email);
        Constants.progressDialog1(false, context);
      }).catchError((err) {
        Constants.progressDialog1(false, context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: black,
            content: Text('Google login failed'),
          ),
        );
      });
    }).catchError((err) {
      Constants.progressDialog1(false, context);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //       backgroundColor: black,
      //       content: Text('Google login failed'),
      //     ),
      //   );
    });
    Constants.progressDialog1(false, context);
  }

  Future<void> _handleAppleSignIn() async {
    Constants.firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
    );
    Constants.firebaseMessaging.getToken().then((token) {
      this.token =
          token!; //                              Print the Token in Console
    });
    await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    ).then((value) async {
      if (value.email != null) {
        await KeyChainAccess().putKeyChain(email: value.email);
      }
      final cred = await KeyChainAccess().getKeyChain();
      if (cred == null) {
        showEmailIDDialog(context);
      } else {
        print("--------------------- $cred");

        print("===========================>${cred["email"]}");
        debugPrint(cred["email"]);
        Constants.toastMessage(msg: cred["email"]);
        _signInWithApple(value.email ?? cred["email"], "");
      }
    });
  }

  Widget googleLoginButton() {
    return InkWell(
      onTap: () {
        _handleSignIn();
        //_signInWithGoogle("hardikponkia2@gmail.com");
      },
      child: Container(
        padding: EdgeInsets.only(
            top: ScreenUtil().setSp(10), bottom: ScreenUtil().setSp(7)),
        decoration: BoxDecoration(
          border: Border.all(width: ScreenUtil().setSp(1), color: lightGray),
          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil()
                  .setSp(8)) //                 <--- border radius here
              ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/svg/google.svg"),
            SizedBox(
              width: ScreenUtil().setSp(16),
            ),
            Text("Sign in with Google",
                style: GoogleFonts.nunitoSans(
                    fontSize: ScreenUtil().setSp(14),
                    color: darkGray,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget appleLoginButton() {
    /*return SignInWithAppleButton(
      onPressed: () async {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        print(credential);

        // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
        // after they have been validated with Apple (see `Integration` section for more information on how to do this)
      },
    );*/
    return InkWell(
      onTap: () {
        _handleAppleSignIn();
      },
      child: Container(
        padding: EdgeInsets.only(
            top: ScreenUtil().setSp(10), bottom: ScreenUtil().setSp(7)),
        margin: EdgeInsets.only(
          top: ScreenUtil().setSp(12),
          left: ScreenUtil().setSp(20),
          right: ScreenUtil().setSp(20),
        ),
        decoration: BoxDecoration(
          color: darkGray,
          border: Border.all(width: ScreenUtil().setSp(1), color: darkGray),
          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil()
                  .setSp(8)) //                 <--- border radius here
              ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/svg/apple.svg"),
            SizedBox(
              width: ScreenUtil().setSp(16),
            ),
            Text("Sign in with Apple",
                style: GoogleFonts.nunitoSans(
                    fontSize: ScreenUtil().setSp(14),
                    color: white,
                    fontWeight: FontWeight.w600)),
          ],
        ),
        // child: MyPrefixButton(
        //   label: googleLogin,
        //   prefixLabel: 'G ',
        //   labelColor: Colors.white,
        //   topLeft: 0,
        //   topRight: 30,
        //   bottomLeft: 30,
        //   bottomRight: 0,
        //   foregroundColor: buttonBlue,
        //   backgroundColor: buttonBlue,
        //   borderColor: buttonBlue,
        // ),
      ),
    );
  }

  Widget bottomSection() {
    return Container(
      margin: EdgeInsets.all(ScreenUtil().radius(15)),
      height: ScreenUtil().setHeight(70),
      padding: EdgeInsets.fromLTRB(0, 1, 0, 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: InkWell(
            onTap: () {
              setState(() {
                // isOTPLogin = false;
              });
            }, /*
            child: Row(
              children: [
                Icon(Icons.arrow_back, color: buttonBlue),
                SizedBox(
                  width: ScreenUtil().setWidth(6.75),
                ),
                Text('Back',
                    style: GoogleFonts.nunitoSans(
                        fontSize: ScreenUtil().setSp(14),
                        color: buttonBlue,
                        fontWeight: FontWeight.w600))
              ],
            ),*/
          )),
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(8)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ontext) => TroubleLogin()),
                );
              },
              child: Text(
                loginTrouble,
                style: GoogleFonts.nunitoSans(
                    fontSize: ScreenUtil().setSp(12),
                    color: black,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // _loginService() async {
  //   Map<String, String> map = {
  //     "mobileNumber": phoneNumber.text,
  //     "code": phoneCodeNumber.text
  //   };
  //   Api.post.call(context, method: "users/login", param: map,
  //       onResponseSuccess: (Map<dynamic,dynamic> object) {
  //     print("RES:::$object");
  //     var result = LoginResponse.fromJson(object);
  //     this.otpHash = result.result!.otpHash!;
  //     FocusScope.of(context).unfocus();
  //     setState(() {
  //       isOTPLogin = true;
  //     });
  //     startTimer();
  //   });
  // }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Constants.toastMessage(msg: 'Double tap to exit the App');
      return Future.value(false);
    }
    return Future.value(true);
  }

  _signInWithGoogle(String email) async {
    if (this.token.isEmpty) {
      Constants.firebaseMessaging.getToken().then((token) async {
        this.token = token!; // Print the Token in Console
        Map<String, String> map = {
          "email": email,
          "pushToken": this.token,
        };
        Api.post.call(context, method: "users/login/email", param: map,
            onResponseSuccess: (Map<dynamic, dynamic> object) async {
          var result = GoogleLoginResponse.fromJson(object);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLoggedIn', true);
          prefs.setBool('isFirstLoggedIn', true);
          prefs.setString('token', result.result!.token!);
          prefs.setString('id', result.result!.id!);
          Constants.otp = result.message.toString();
          Constants.token = result.result!.token;
          //getUserProfile();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainFeedScreen()));
        });
      });
    } else {
      Map<String, String> map = {
        "email": email,
        "pushToken": this.token,
      };
      print("TOKEN::${this.token}");
      Api.post.call(context, method: "users/login/email", param: map,
          onResponseSuccess: (Map object) async {
        var result = GoogleLoginResponse.fromJson(object);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setBool('isFirstLoggedIn', true);
        prefs.setString('token', result.result!.token!);
        prefs.setString('id', result.result!.id!);
        Constants.otp = result.message.toString();
        Constants.token = result.result!.token;
        //getUserProfile();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainFeedScreen()));
      });
    }
  }

  _signInWithApple(String email, String mobile) async {
    if (this.token.isEmpty) {
      Constants.firebaseMessaging.getToken().then((token) async {
        this.token = token!; // Print the Token in Console
        Map<String, String> map = {
          "email": email,
          "pushToken": this.token,
        };
        Api.post.call(context, method: "users/login/email", param: map,
            onResponseSuccess: (Map object) async {
          var result = GoogleLoginResponse.fromJson(object);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLoggedIn', true);
          prefs.setBool('isFirstLoggedIn', true);
          prefs.setString('token', result.result!.token!);
          prefs.setString('id', result.result!.id!);
          Constants.otp = result.message.toString();
          Constants.token = result.result!.token;
          await KeyChainAccess().putKeyChain(email: email);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => OpenTourScreen()));
        });
      });
    } else {
      Map<String, String> map = {
        "email": email,
        "pushToken": this.token,
      };
      Api.post.call(context, method: "users/login/email", param: map,
          onResponseSuccess: (Map object) async {
        var result = GoogleLoginResponse.fromJson(object);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setBool('isFirstLoggedIn', true);
        prefs.setString('token', result.result!.token!);
        prefs.setString('id', result.result!.id!);
        Constants.otp = result.message.toString();
        Constants.token = result.result!.token;
        await KeyChainAccess().putKeyChain(email: email);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => OpenTourScreen()));
      });
    }
  }

  void getLocale() async {
    await CountryCodes.init();
  }

  void getCountry() async {
    Api.get.call(context, method: "location/country-code", param: {},
        onResponseSuccess: (Map<dynamic, dynamic> object) {
      var result = CountryModel.fromJson(object);
      countryList.addAll(result.result!.data!);
      if (countryList.length > 0) {
        setState(() {
          countryModel = countryList.elementAt(0);
          phoneCodeNumber.text = countryList.elementAt(0).code!;
        });
      }
    });
  }

  void showEmailIDDialog(BuildContext context) {
    TextEditingController emailTextController = TextEditingController();
    emailTextController.clear();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.only(
                  left: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - 213) / 2),
                  right: ScreenUtil()
                      .setWidth((ScreenUtil().screenWidth - 213) / 2)),
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setStates) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(
                          Radius.circular(ScreenUtil().setSp(16))),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          color: black25,
                          blurRadius: 4.0,
                        ),
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular(ScreenUtil().setSp(16)),
                                topRight:
                                    Radius.circular(ScreenUtil().setSp(16))),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [lightRedWhite, lightRed])),
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(21),
                            bottom: ScreenUtil().setHeight(12),
                            left: ScreenUtil().setWidth(5),
                            right: ScreenUtil().setWidth(5)),
                        child: Center(
                          child: Text(
                            'Enter email',
                            style: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(14),
                                color: white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(4),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft:
                                  Radius.circular(ScreenUtil().setSp(16)),
                              bottomRight:
                                  Radius.circular(ScreenUtil().setSp(16))),
                          color: appBackgroundColor,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(14),
                                  left: ScreenUtil().setWidth(20),
                                  right: ScreenUtil().setWidth(20)),
                              child: TextFormField(
                                textAlign: TextAlign.start,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.name,
                                controller: emailTextController,
                                textInputAction: TextInputAction.done,
                                style: GoogleFonts.nunitoSans(
                                    fontSize: ScreenUtil().setSp(14),
                                    color: darkGray,
                                    fontWeight: FontWeight.w700),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: white25,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: lightGray,
                                        width: ScreenUtil().radius(1)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenUtil().radius(8))),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: buttonBlue,
                                        width: ScreenUtil().radius(1)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenUtil().radius(8))),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: lightGray,
                                        width: ScreenUtil().radius(1)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenUtil().radius(8))),
                                  ),
                                  hintText: "example@mail.com",
                                  contentPadding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(11)),
                                  hintStyle: GoogleFonts.nunitoSans(
                                      fontStyle: FontStyle.italic,
                                      fontSize: ScreenUtil().setSp(14),
                                      color: lightGray,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setSp(32),
                                  bottom: ScreenUtil().setSp(20)),
                              child: IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: InkWell(
                                          onTap: () async {
                                            if (emailTextController
                                                .text.isNotEmpty) {
                                              Navigator.pop(context);
                                              _signInWithApple(
                                                  emailTextController.text, "");
                                            }
                                          },
                                          child: Text("Submit",
                                              style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                      ScreenUtil().setSp(14),
                                                  color: black)),
                                        ),
                                      ),
                                    ),
                                    VerticalDivider(
                                      thickness: 1,
                                      width: 1,
                                      color: lightGray,
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancel",
                                              style: GoogleFonts.nunitoSans(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                      ScreenUtil().setSp(14),
                                                  color: lightGray)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }));
        });
  }
}
