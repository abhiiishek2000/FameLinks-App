import 'package:carousel_slider/carousel_slider.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/contestant_model.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/contestants/SearchProfileScreen.dart';
import 'package:famelink/ui/otherUserProfile/OthersProfile.dart';
import 'package:famelink/ui/profile/agency_profile_screen.dart';
import 'package:famelink/ui/profile/brand_profile_screen.dart';
import 'package:famelink/ui/profile/profile_screen.dart';
import 'package:famelink/util/AdHelper.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';

class ContestantScreen extends StatefulWidget {
  const ContestantScreen({Key? key}) : super(key: key);

  @override
  _ContestantScreenState createState() => _ContestantScreenState();
}

class _ContestantScreenState extends State<ContestantScreen> {
  List<String> recommendeditems = [
    'Recommended',
    'Trending',
    'New',
  ];
  List<String> recommendeditems2 = [
    'Your District',
    'Your State',
    'Your Country',
    'World'
  ];

  List<String> ageItems = [
    "0-4",
    "4-12",
    "12-18",
    "18-28",
    "28-40",
    "40-50",
    "50-60",
    "60+"
  ];
  final ApiProvider _api = ApiProvider();
  List<Result> myFameResult = [];
  List<String> countryList = [];
  List<String> stateList = [];
  List<String> districtList = [];
  int selectedTab = 0;
  int selectedTab2 = 0;
  int selectedAge = -1;
  int page = 1;
  bool _value = false;
  int val = -1;
  int genderIndex = -1;
  String type = "recommended";
  String district = "";
  String state = "";
  String country = "";
  String continent = "";
  String gender = "";
  String ageGroup = "";
  String? selectedContinent;
  String? selectedCountry;
  String? selectedState;
  String? selectedDistrict;
  final GlobalKey _childKey = GlobalKey();
  bool isHeightCalculated = false;
  double height = 454;
  bool silverCollapsed = false;
  ScrollController contestantScrollController = ScrollController();
  PageController pageController = PageController(keepPage: true);
  NativeAd? _ad;

  // TODO: Add _isAdLoaded
  bool _isAdLoaded = false;

  void _myFamelinks() async {
    Map<String, dynamic> params = {
      "page": page.toString(),
    };
    if (type.isNotEmpty) {
      params.putIfAbsent("type", () => type);
    }
    if (district.isNotEmpty) {
      params.putIfAbsent("district", () => district);
    }
    if (state.isNotEmpty) {
      params.putIfAbsent("state", () => state);
    }
    if (country.isNotEmpty) {
      params.putIfAbsent("country", () => country);
    }
    if (continent.isNotEmpty) {
      params.putIfAbsent("continent", () => continent);
    }
    if (gender.isNotEmpty) {
      params.putIfAbsent("gender", () => gender);
    }
    if (ageGroup.isNotEmpty) {
      params.putIfAbsent("ageGroup", () => ageGroup);
    }
    Api.get.call(context,
        method: "users/contestants",
        param: params,
        isLoading: false, onResponseSuccess: (Map<dynamic, dynamic> object) {
      var result = ContestantResponse.fromJson(object);
      myFameResult = result.result!;
      setState(() {});
    });
  }

  void _moreFamelinks() async {
    Map<String, dynamic> params = {
      "page": page.toString(),
    };
    if (type.isNotEmpty) {
      params.putIfAbsent("type", () => type);
    }
    if (district.isNotEmpty) {
      params.putIfAbsent("district", () => district);
    }
    if (state.isNotEmpty) {
      params.putIfAbsent("state", () => state);
    }
    if (country.isNotEmpty) {
      params.putIfAbsent("country", () => country);
    }
    if (continent.isNotEmpty) {
      params.putIfAbsent("continent", () => continent);
    }
    if (gender.isNotEmpty) {
      params.putIfAbsent("gender", () => gender);
    }
    if (ageGroup.isNotEmpty) {
      params.putIfAbsent("ageGroup", () => ageGroup);
    }
    Api.get.call(context,
        method: "users/contestants",
        param: params,
        isLoading: false, onResponseSuccess: (Map object) {
      var result = ContestantResponse.fromJson(object);
      if (result.result!.length > 0) {
        myFameResult.addAll(result.result!);
        setState(() {});
        print('RESPONSE ${result.result.toString()}');
      } else {
        page--;
      }
    });
  }

  void getCountry(StateSetter setStates) async {
    bool internet = await Constants.isInternetAvailable();
    if (internet) {
      Constants.progressDialog(true, context);
      var result = await _api.getCountry(selectedContinent!);
      if (result != null) {
        Constants.progressDialog(false, context);
        if (result.success!) {
          countryList = result.result!.countries!;
          setStates(() {});
        } else {
          countryList = [];
          setStates(() {});
          Constants.toastMessage(msg: result.message);
        }
      }
    }
  }

  void getStates(StateSetter setStates) async {
    bool internet = await Constants.isInternetAvailable();
    if (internet) {
      Constants.progressDialog(true, context);
      var result = await _api.getStates(selectedCountry!);
      if (result != null) {
        Constants.progressDialog(false, context);
        if (result.success!) {
          stateList = result.result!.states!;
          setStates(() {});
        } else {
          stateList = [];
          setStates(() {});
          Constants.toastMessage(msg: result.message);
        }
      }
    }
  }

  void getDistrict(StateSetter setStates) async {
    bool internet = await Constants.isInternetAvailable();
    if (internet) {
      Constants.progressDialog(true, context);
      var result = await _api.getDistrict(selectedCountry!, selectedState!);
      if (result != null) {
        Constants.progressDialog(false, context);
        if (result.success!) {
          districtList = result.result!.districts!;
          setStates(() {});
        } else {
          districtList = [];
          setStates(() {});
          Constants.toastMessage(msg: result.message);
        }
      }
    }
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initGoogleMobileAds();
    _ad = NativeAd(
      adUnitId: AdHelper.famelinksExplore,
      factoryId: 'famelink',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );
    _ad!.load();

    _myFamelinks();
    contestantScrollController.addListener(() {
      if (contestantScrollController.offset > height - 150 &&
          !contestantScrollController.position.outOfRange) {
        if (!silverCollapsed) {
          // do what ever you want when silver is collapsing !

          silverCollapsed = true;
          setState(() {});
        }
      }
      if (contestantScrollController.offset <= height - 150 &&
          !contestantScrollController.position.outOfRange) {
        if (silverCollapsed) {
          // do what ever you want when silver is expanding !

          silverCollapsed = false;
          setState(() {});
        }
      }
      if (contestantScrollController.position.maxScrollExtent ==
          contestantScrollController.position.pixels) {
        page++;
        _moreFamelinks();
      }
    });
    _ad!.load();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _ad!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!isHeightCalculated) {
        isHeightCalculated = true;
        setState(() {
          height = (_childKey.currentContext!.findRenderObject() as RenderBox)
              .size
              .height;
        });
      }
    });

    return body();
  }

  Widget body() {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 3;
    final double itemHeight = itemWidth + 45;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().setHeight(330),
          color: appBackgroundColor,
          child: CarouselSlider(
              items: [1].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: appBackgroundColor),
                        child: _isAdLoaded
                            ? Container(
                                child: AdWidget(ad: _ad!),
                                alignment: Alignment.center,
                              )
                            : Container());
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: ScreenUtil().setHeight(330),
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    pageController =
                        PageController(keepPage: true, initialPage: index);
                  });
                },
                scrollDirection: Axis.horizontal,
              )),
        ),
        Container(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().setSp(35),
          color: appBackgroundColor,
          child: Row(
            children: [
              Container(
                width: ScreenUtil().screenWidth - 100.w,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recommendeditems.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setSp(7),
                        top: ScreenUtil().setSp(10)),
                    itemBuilder: (storyiconContext, index) {
                      return InkWell(
                        onTap: () {
                          if (selectedTab != index) {
                            if (index == 0) {
                              type = "recommended";
                              district = selectedDistrict != null
                                  ? selectedDistrict!
                                  : "";
                              state =
                                  selectedState != null ? selectedState! : "";
                              country = selectedCountry != null
                                  ? selectedCountry!
                                  : "";
                              continent = "";
                            } else if (index == 1) {
                              type = "trending";
                              district = selectedDistrict != null
                                  ? selectedDistrict!
                                  : "";
                              state =
                                  selectedState != null ? selectedState! : "";
                              country = selectedCountry != null
                                  ? selectedCountry!
                                  : "";
                              continent = "";
                            } else if (index == 2) {
                              type = "";
                              district = Constants.district;
                              state = "";
                              country = "";
                              continent = "";
                            } else if (index == 3) {
                              type = "";
                              district = "";
                              state = Constants.state;
                              country = "";
                              continent = "";
                            } else if (index == 4) {
                              type = "";
                              district = "";
                              state = "";
                              country = Constants.country;
                              continent = "";
                            } else if (index == 5) {
                              type = "";
                              district = "";
                              state = "";
                              country = "";
                              continent = "";
                            }
                          }
                          _myFamelinks();
                          setState(() {
                            selectedTab = index;
                          });
                        },
                        child: IntrinsicWidth(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(recommendeditems[index],
                                        style: GoogleFonts.nunitoSans(
                                            fontSize: ScreenUtil().setSp(14),
                                            fontWeight: selectedTab == index
                                                ? FontWeight.w700
                                                : FontWeight.w600,
                                            color: selectedTab == index
                                                ? black
                                                : lightGray)),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(8),
                                    ),
                                    VerticalDivider(
                                      thickness: ScreenUtil().setSp(1),
                                      width: ScreenUtil().setSp(1),
                                      color: lightGray,
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(8),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(4),
                              ),
                              Padding(
                                child: Divider(
                                  thickness: ScreenUtil().setSp(1),
                                  height: ScreenUtil().setSp(1),
                                  color:
                                      selectedTab == index ? black : lightGray,
                                ),
                                padding: EdgeInsets.only(
                                    right: ScreenUtil().setSp(17)),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Spacer(),
              InkWell(
                onTap: () async {
                  var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SearchProfileScreen("famelinks", "")));
                  if (result != null) {
                    Navigator.pop(context, result);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h, bottom: 2.h),
                  child: SvgPicture.asset(
                    "assets/icons/svg/search.svg",
                    height: 19.h,
                    width: 19.w,
                    color: lightGray,
                  ),
                ),
              ),
              SizedBox(width: 32.w),
              InkWell(
                onTap: () {
                  showGetStartedDialog();
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 6.w, top: 8.h),
                  child: SvgPicture.asset(
                    "assets/icons/svg/jobfilter.svg",
                    height: 21.h,
                    width: 21.w,
                    color: darkGray,
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              height: 50,
              width: ScreenUtil().screenWidth - 100.w,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendeditems2.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setSp(7), top: ScreenUtil().setSp(10)),
                  itemBuilder: (storyiconContext, index) {
                    return InkWell(
                      onTap: () {
                        if (selectedTab2 != index) {
                          if (index == 0) {
                            type = "recommended";
                            district = selectedDistrict != null
                                ? selectedDistrict!
                                : "";
                            state = selectedState != null ? selectedState! : "";
                            country =
                                selectedCountry != null ? selectedCountry! : "";
                            continent = "";
                          } else if (index == 1) {
                            type = "trending";
                            district = selectedDistrict != null
                                ? selectedDistrict!
                                : "";
                            state = selectedState != null ? selectedState! : "";
                            country =
                                selectedCountry != null ? selectedCountry! : "";
                            continent = "";
                          } else if (index == 2) {
                            type = "";
                            district = Constants.district;
                            state = "";
                            country = "";
                            continent = "";
                          } else if (index == 3) {
                            type = "";
                            district = "";
                            state = Constants.state;
                            country = "";
                            continent = "";
                          } else if (index == 4) {
                            type = "";
                            district = "";
                            state = "";
                            country = Constants.country;
                            continent = "";
                          } else if (index == 5) {
                            type = "";
                            district = "";
                            state = "";
                            country = "";
                            continent = "";
                          }
                        }
                        _myFamelinks();
                        setState(() {
                          selectedTab2 = index;
                        });
                      },
                      child: IntrinsicWidth(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IntrinsicHeight(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(recommendeditems2[index],
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: selectedTab2 == index
                                              ? FontWeight.w500
                                              : FontWeight.w300,
                                          color: selectedTab2 == index
                                              ? black
                                              : lightGray)),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(8),
                                  ),
                                  VerticalDivider(
                                    thickness: ScreenUtil().setSp(1),
                                    width: ScreenUtil().setSp(1),
                                    color: lightGray,
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(8),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(4),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          childAspectRatio: (itemWidth / itemHeight),
          padding: EdgeInsets.only(
              top: ScreenUtil().setSp(8),
              left: ScreenUtil().setSp(3.5),
              right: ScreenUtil().setSp(3.5)),
          children: List.generate(myFameResult.length, (index) {
            return InkWell(
              onTap: () {
                Constants.profileUserId = myFameResult[index].sId;
                if (Constants.userId == Constants.profileUserId) {
                  if (myFameResult[index].type == "individual") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                  } else if (myFameResult[index].type == "agency") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AgencyProfileScreen()));
                  } else if (myFameResult[index].type == "brand") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BrandProfileScreen()));
                  }
                } else {
                  if (myFameResult[index].type == "individual") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OtherProfile(
                                  id: myFameResult[index].sId!,
                                  selectPhase: 0,
                                )));
                  } else if (myFameResult[index].type == "agency") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OtherProfile(
                                  id: myFameResult[index].sId!,
                                  selectPhase: 0,
                                )));
                  } else if (myFameResult[index].type == "brand") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OtherProfile(
                                  id: myFameResult[index].sId!,
                                  selectPhase: 0,
                                )));
                  }
                }
              },
              child: Container(
                margin: EdgeInsets.only(
                    bottom: ScreenUtil().setSp(7),
                    left: ScreenUtil().setSp(3.5),
                    right: ScreenUtil().setSp(3.5)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Colors.blue,
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      child: myFameResult[index].images!.length > 0 &&
                              myFameResult[index].images![0].image != null
                          ? Image.network(
                              '${myFameResult[index].type == "agency" ? ApiProvider.profile : myFameResult[index].type == "brand" ? ApiProvider.profile : "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}"}/${myFameResult[index].images![0].image}-xs',
                              fit: BoxFit.cover,
                              width: itemWidth,
                              height: itemHeight,
                            )
                          : Container(
                              width: itemWidth,
                              height: itemHeight,
                              color: lightGray,
                              child: Center(
                                child: Icon(Icons.image_not_supported),
                              ),
                            ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                  myFameResult[index].name != null
                                      ? myFameResult[index].name!
                                      : "",
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(10))),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                                myFameResult[index].country != null
                                    ? myFameResult[index].country!
                                    : "",
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w600,
                                    color: countryColor,
                                    fontSize: ScreenUtil().setSp(8)))
                          ],
                        ),
                        height: ScreenUtil().setHeight(28),
                        color: Colors.white.withOpacity(0.2),
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setSp(4),
                            right: ScreenUtil().setSp(4)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                myFameResult[index].images!.length > 0 &&
                                        myFameResult[index]
                                                .images![0]
                                                .likesCount !=
                                            null
                                    ? "${NumberFormat.compactCurrency(
                                        decimalDigits: 0,
                                        symbol:
                                            '', // if you want to add currency symbol then pass that in this else leave it empty.
                                      ).format(myFameResult[index].images![0].likesCount)}"
                                    : "",
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(8))),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: ScreenUtil().setSp(8),
                            )
                          ],
                        ),
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setSp(3),
                            top: ScreenUtil().setSp(3)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  void showGetStartedDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              insetPadding: EdgeInsets.zero,
              elevation: 2,
              backgroundColor: white,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setStates) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  child: Text(
                                    'Age',
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(14),
                                        color: black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(28),
                                      top: ScreenUtil().setHeight(16),
                                      bottom: ScreenUtil().setHeight(5)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(28)),
                                  child: GroupButton(
                                    textPadding: EdgeInsets.only(
                                        left: ScreenUtil().setSp(0),
                                        right: ScreenUtil().setSp(0)),
                                    runSpacing: ScreenUtil().setSp(9),
                                    groupingType: GroupingType.wrap,
                                    spacing: ScreenUtil().setSp(5),
                                    crossGroupAlignment:
                                        CrossGroupAlignment.center,
                                    buttonHeight: ScreenUtil().setSp(24),
                                    isRadio: true,
                                    direction: Axis.horizontal,
                                    onSelected: (index, ageSelected) {
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
                                        selectedAge = index;
                                      });
                                    },
                                    buttons: ageItems,
                                    selectedButton: selectedAge,
                                    selectedTextStyle: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: ScreenUtil().setSp(12),
                                      color: Colors.white,
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
                                        ScreenUtil().radius(15)),
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
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  child: Text(
                                    'Gender',
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(14),
                                        color: black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(16),
                                      right: ScreenUtil().setHeight(34)),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(0)),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setStates(() {
                                              genderIndex = 0;
                                              gender = "male";
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                height: ScreenUtil().setSp(40),
                                                width: ScreenUtil().setSp(40),
                                                padding: EdgeInsets.zero,
                                                decoration: BoxDecoration(
                                                    color: genderIndex == 0
                                                        ? darkGray
                                                        : white,
                                                    border: Border.all(
                                                      color: genderIndex == 0
                                                          ? white
                                                          : lightGray,
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            ScreenUtil()
                                                                .setSp(20)))),
                                                child: SvgPicture.asset(
                                                    "assets/icons/svg/male.svg",
                                                    color: genderIndex == 0
                                                        ? white
                                                        : lightGray,
                                                    fit: BoxFit.scaleDown),
                                              ),
                                              SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(3),
                                              ),
                                              Text(
                                                "Male",
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: lightGray),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            width: ScreenUtil().setWidth(21)),
                                        InkWell(
                                          onTap: () {
                                            setStates(() {
                                              genderIndex = 1;
                                              gender = "female";
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                height: ScreenUtil().setSp(40),
                                                width: ScreenUtil().setSp(40),
                                                padding: EdgeInsets.zero,
                                                decoration: BoxDecoration(
                                                    color: genderIndex == 1
                                                        ? darkGray
                                                        : white,
                                                    border: Border.all(
                                                      color: genderIndex == 1
                                                          ? white
                                                          : lightGray,
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            ScreenUtil()
                                                                .setSp(20)))),
                                                child: SvgPicture.asset(
                                                    "assets/icons/svg/female.svg",
                                                    color: genderIndex == 1
                                                        ? white
                                                        : lightGray,
                                                    fit: BoxFit.scaleDown),
                                              ),
                                              SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(3),
                                              ),
                                              Text(
                                                "Female",
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: lightGray),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            width: ScreenUtil().setWidth(21)),
                                        InkWell(
                                          onTap: () {
                                            setStates(() {
                                              genderIndex = 2;
                                              gender = "other";
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                height: ScreenUtil().setSp(40),
                                                width: ScreenUtil().setSp(40),
                                                padding: EdgeInsets.zero,
                                                decoration: BoxDecoration(
                                                    color: genderIndex == 2
                                                        ? darkGray
                                                        : white,
                                                    border: Border.all(
                                                      color: genderIndex == 2
                                                          ? white
                                                          : lightGray,
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            ScreenUtil()
                                                                .setSp(20)))),
                                                child: Image.asset(
                                                    "assets/icons/line.png",
                                                    color: genderIndex == 2
                                                        ? white
                                                        : lightGray),
                                              ),
                                              SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(3),
                                              ),
                                              Text(
                                                "Other",
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    color: lightGray),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Container()),
                          Expanded(
                            child: Row(
                              children: [
                                InkWell(
                                  child: Text(
                                    'Worlwide',
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w600,
                                        color: darkGray,
                                        fontSize: ScreenUtil().setSp(14)),
                                  ),
                                  onTap: () {
                                    setStates(() {
                                      val = val == 0 ? -1 : 0;
                                    });
                                  },
                                ),
                                Radio(
                                  activeColor: darkGray,
                                  value: 0,
                                  groupValue: val,
                                  onChanged: (value) {
                                    setStates(() {
                                      val = val == 0 ? -1 : 0;
                                    });
                                    print("VALUE::${val}");
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setSp(28),
                            right: ScreenUtil().setSp(28)),
                        child: Divider(
                          color: darkGray,
                          height: ScreenUtil().setSp(1),
                          thickness: ScreenUtil().setSp(1),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setSp(28),
                                  right: ScreenUtil().setSp(20)),
                              child: Wrap(
                                children: [
                                  DropdownButton<String>(
                                    isExpanded: true,
                                    hint: Text("Continent",
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(14),
                                            color: darkGray)),
                                    value: selectedContinent,
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(14),
                                        color: darkGray),
                                    items: <String>[
                                      "asia",
                                      "europe",
                                      "south america",
                                      "north america",
                                      "africa",
                                      "antarctica",
                                      "australia"
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                color: darkGray)),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setStates(() {
                                        selectedContinent = newValue;
                                      });
                                      getCountry(setStates);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: ScreenUtil().setWidth(
                                  (ScreenUtil().screenWidth / 2) - 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: ScreenUtil().setSp(28)),
                                    child: SizedBox(
                                      width: ScreenUtil().setWidth(
                                          (ScreenUtil().screenWidth / 2) - 50),
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        hint: Text("Country",
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                color: darkGray)),
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(14),
                                            color: darkGray),
                                        value: selectedCountry,
                                        items: countryList.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(14),
                                                    color: darkGray)),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setStates(() {
                                            selectedCountry = newValue;
                                          });
                                          getStates(setStates);
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: ScreenUtil().setSp(28)),
                                    child: SizedBox(
                                      width: ScreenUtil().setWidth(
                                          (ScreenUtil().screenWidth / 2) - 50),
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        hint: Text("State",
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                color: darkGray)),
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(14),
                                            color: darkGray),
                                        value: selectedState,
                                        items: stateList.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(14),
                                                    color: darkGray)),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setStates(() {
                                            selectedState = newValue;
                                          });
                                          getDistrict(setStates);
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: ScreenUtil().setSp(28)),
                                    child: SizedBox(
                                      width: ScreenUtil().setWidth(
                                          (ScreenUtil().screenWidth / 2) - 50),
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        hint: Text("District",
                                            style: GoogleFonts.nunitoSans(
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                color: darkGray)),
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(14),
                                            color: darkGray),
                                        value: selectedDistrict,
                                        items: districtList.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.nunitoSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(14),
                                                    color: darkGray)),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setStates(() {
                                            selectedDistrict = newValue;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setSp(35),
                                      bottom: ScreenUtil().setSp(28)),
                                  child: Center(
                                      child: InkWell(
                                    onTap: () {
                                      if (val == 0) {
                                        continent = "";
                                        country = "";
                                        state = "";
                                        district = "";
                                      } else {
                                        continent = selectedContinent != null
                                            ? selectedContinent!
                                            : "";
                                        country = selectedCountry != null
                                            ? selectedCountry!
                                            : selectedTab == 4
                                                ? Constants.country
                                                : "";
                                        state = selectedState != null
                                            ? selectedState!
                                            : selectedTab == 3
                                                ? Constants.state
                                                : "";
                                        district = selectedDistrict != null
                                            ? selectedDistrict!
                                            : selectedTab == 2
                                                ? Constants.district
                                                : "";
                                      }
                                      _myFamelinks();
                                      Navigator.pop(context);
                                    },
                                    child: Text("Done",
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w700,
                                            fontSize: ScreenUtil().setSp(14),
                                            color: black)),
                                  )))),
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setSp(35),
                                      bottom: ScreenUtil().setSp(28)),
                                  child: Center(
                                      child: InkWell(
                                    onTap: () {
                                      selectedAge = -1;
                                      genderIndex = -1;
                                      ageGroup = "";
                                      gender = "";
                                      val = -1;
                                      selectedContinent = null;
                                      selectedCountry = null;
                                      selectedState = null;
                                      selectedDistrict = null;
                                      setStates(() {});
                                      if (val == 0) {
                                        continent = "";
                                        country = "";
                                        state = "";
                                        district = "";
                                      } else {
                                        continent = selectedContinent != null
                                            ? selectedContinent!
                                            : "";
                                        country = selectedCountry != null
                                            ? selectedCountry!
                                            : "";
                                        state = selectedState != null
                                            ? selectedState!
                                            : "";
                                        district = selectedDistrict != null
                                            ? selectedDistrict!
                                            : "";
                                      }
                                      if (selectedTab == 2) {
                                        district = Constants.district;
                                      } else if (selectedTab == 3) {
                                        state = Constants.state;
                                      } else if (selectedTab == 4) {
                                        country = Constants.country;
                                      }
                                      _myFamelinks();
                                      Navigator.pop(context);
                                    },
                                    child: Text("Reset All",
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(14),
                                            color: black)),
                                  )))),
                        ],
                      )
                    ],
                  ),
                );
              }));
        });
  }
}
