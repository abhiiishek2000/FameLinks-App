import 'package:carousel_slider/carousel_slider.dart';
import 'package:famelink/databse/AppDatabase.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/OpenChallengesResponse.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/funlinks/FunLinksChallengeScreen.dart';
import 'package:famelink/util/AdHelper.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:group_button/group_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'SearchProfileScreen.dart';

class FunLinksContestantScreen extends StatefulWidget {
  @override
  _FunLinksContestantScreenState createState() =>
      _FunLinksContestantScreenState();
}

class _FunLinksContestantScreenState extends State<FunLinksContestantScreen> {
  final ApiProvider _api = ApiProvider();
  TextEditingController nameController = TextEditingController();
  int page = 1;
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
  List<OpenChallengesResult> openChallengesResult = [];
  List<String> countryList = [];
  List<String> stateList = [];
  List<String> districtList = [];
  int selectedTab = 0;
  int selectedAge = -1;
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
  double height = 400;
  bool silverCollapsed = false;
  NativeAd? _ad;

  // TODO: Add _isAdLoaded
  bool _isAdLoaded = false;
  ScrollController contestantScrollController = ScrollController();
  PageController pageController = PageController(keepPage: true);

  void searchData(String search) async {
    Map<String, dynamic> param = {
      "page": page.toString(),
      "search": search,
    };
    Api.get.call(context, method: "users/search", param: param,
        onResponseSuccess: (Map object) {
      setState(() {});
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

  void _openChallenges() async {
    Map<String, dynamic> param = {"page": page.toString()};
    Api.get.call(context, method: "challenges/funlinks/explore", param: param,
        onResponseSuccess: (Map object) {
      var result = OpenChallengesResponse.fromJson(object);
      if (result.result!.length > 0) {
        openChallengesResult.addAll(result.result!);
        setState(() {});
        print('RESPONSE ${result.result.toString()}');
      } else {
        page--;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _ad!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _openChallenges();
    _ad = NativeAd(
      adUnitId: AdHelper.funlinksExplore,
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
          silverCollapsed = false;
          setState(() {});
        }
      }
      if (contestantScrollController.position.maxScrollExtent ==
          contestantScrollController.position.pixels) {
        page++;
        _openChallenges();
      }
    });
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      // isNavigationOn=false;
                    });
                  },
                  icon: Icon(Icons.arrow_back, color: black)),
              backgroundColor: appBackgroundColor,
              expandedHeight: ScreenUtil().setSp(440),
              pinned: true,
              title: Text(silverCollapsed ? "Explore Contestants" : "",
                  style: GoogleFonts.nunitoSans(
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w600,
                      color: lightRed)),
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  background: SingleChildScrollView(
                    key: _childKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: ScreenUtil().setSp(80),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setSp(1),
                                  left: ScreenUtil().setSp(32),
                                  right: ScreenUtil().setSp(16),
                                  bottom: ScreenUtil().setSp(10)),
                              child: TextFormField(
                                textAlign: TextAlign.start,
                                textAlignVertical: TextAlignVertical.center,
                                controller: nameController,
                                textInputAction: TextInputAction.search,
                                onFieldSubmitted: (value) async {
                                  var result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SearchProfileScreen(
                                                  "funlinks", value)));
                                  if (result != null) {
                                    Navigator.pop(context, result);
                                  }
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.5),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightRed,
                                          width: ScreenUtil().radius(2)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenUtil().radius(16))),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: lightGray,
                                          width: ScreenUtil().radius(2)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenUtil().radius(16))),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(10)),
                                    hintText: 'Search',
                                    hintStyle: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(14),
                                        color: lightGray,
                                        fontWeight: FontWeight.w400),
                                    prefixIcon: IconButton(
                                        onPressed: () async {
                                          if (nameController.text.isNotEmpty) {
                                            var result = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SearchProfileScreen(
                                                            "funlinks",
                                                            nameController
                                                                .text)));
                                            if (result != null) {
                                              Navigator.pop(context, result);
                                            }
                                          }
                                        },
                                        icon: Icon(Icons.search,
                                            color: lightGray))),
                              ),
                            )),
                            /*InkWell(
                              child: Padding(padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(1),
                                  right: ScreenUtil().setWidth(19)),child: SvgPicture.asset("assets/icons/svg/contestant_filter.svg",color: lightGray)),
                              onTap: () {
                                showGetStartedDialog();
                              },
                            ),*/
                          ],
                        ),
                        Container(
                          width: ScreenUtil().screenWidth,
                          height: ScreenUtil().setSp(330),
                          color: appBackgroundColor,
                          child: Stack(
                            children: [
                              CarouselSlider(
                                  items: [1].map((i) {
                                    _ad!.load();
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                color: appBackgroundColor),
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
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        pageController = PageController(
                                            keepPage: true, initialPage: index);
                                      });
                                    },
                                    scrollDirection: Axis.horizontal,
                                  )),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: ScreenUtil().setHeight(10)),
                                  child: SmoothPageIndicator(
                                    controller: pageController,
                                    count: 5,
                                    axisDirection: Axis.horizontal,
                                    effect: SlideEffect(
                                        spacing: 10.0,
                                        radius: 3.0,
                                        dotWidth: 6.0,
                                        dotHeight: 6.0,
                                        paintStyle: PaintingStyle.stroke,
                                        strokeWidth: 1.5,
                                        dotColor: Colors.white,
                                        activeDotColor: lightRed),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            /*SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(
                        icon: SvgPicture.asset(
                            "assets/icons/svg/tab_famelinks.svg",
                            color: _tabController.index == 0
                                ? darkGray
                                : lightGray),
                      ),
                      Tab(
                          icon: SvgPicture.asset(
                              "assets/icons/svg/tab_funlinks.svg",
                              color: _tabController.index == 1
                                  ? darkGray
                                  : lightGray)),

                      Tab(
                          icon: SvgPicture.asset(
                              "assets/icons/svg/tab_followlinks.svg",
                              color: _tabController.index == 2
                                  ? darkGray
                                  : lightGray)),
                      // Tab(text: "Challenges"),
                    ],
                    labelColor: darkGray,
                    unselectedLabelColor: lightGray,
                    indicatorColor: darkGray,
                    unselectedLabelStyle: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(14)),
                    labelStyle: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w700,
                        fontSize: ScreenUtil().setSp(14)),
                  ),
                ),
                pinned: true,
              ),*/
          ];
        },
        controller: contestantScrollController,
        body: body(),
      ),
    );
  }

  Widget body() {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    final double itemHeight = itemWidth + 30;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
      child: openChallengesResult.isEmpty
          ? Center(
              child: Text("No Data!",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            )
          : ListView.builder(
              itemCount: openChallengesResult.length,
              padding: EdgeInsets.zero,
              itemBuilder: (openContext, index) {
                OpenChallengesResult openChallenges =
                    openChallengesResult[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(9),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () async {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           FunLinksContestantScreen()),
                                // );
                                ChallengesModelData challengesModelData =
                                    ChallengesModelData(
                                        id: "",
                                        challengeId:
                                            openChallengesResult[index].sId!,
                                        challengeName:
                                            openChallengesResult[index]
                                                .hashTag!,
                                        postId: "");

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FunLinksChallengeScreen(
                                              challengesModelData,
                                              "",
                                              openChallengesResult[index]
                                                  .giftCoins
                                                  .toString()),
                                    ));

                                // var result = await Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => ChallengeDetailsScreen(null,openChallengesResult[index])));
                                // if (result != null) {
                                //   Navigator.pop(context,result);
                                // }
                              },
                              child: Text('${openChallenges.hashTag}',
                                  style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: ScreenUtil().setSp(12),
                                      color: black)),
                            ),
                            Text(
                                '${openChallenges.sponsor != null ? "by ${openChallenges.sponsor}" : ""}',
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(12),
                                    color: lightGray)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(107),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: openChallenges.posts!.length,
                        itemBuilder: (BuildContext context, int index) {
                          var size = MediaQuery.of(context).size;
                          final double itemWidth = size.width / 4;
                          //  Result result = openChallenges.posts;
                          // String post = "";
                          // bool isVideo = false;
                          // if(result.images != null) {
                          //   for (int i = 0; i <
                          //       result.images.length; i++) {
                          //     Media postMedia = result.images[i];
                          //     if (i == 0 && postMedia.path != null) {
                          //       post = postMedia.path;
                          //     } else
                          //     if (i == 1 && postMedia.path != null) {
                          //       post = postMedia.path;
                          //     } else
                          //     if (i == 2 && postMedia.path != null) {
                          //       post = postMedia.path;
                          //     } else
                          //     if (i == 3 && postMedia.path != null) {
                          //       post = postMedia.path;
                          //     } else
                          //     if (i == 4 && postMedia.path != null) {
                          //       post = postMedia.path;
                          //     } else
                          //     if (i == 5 && postMedia.path != null) {
                          //       post = postMedia.path;
                          //     } else
                          //     if (i == 6 && postMedia.path != null) {
                          //       isVideo = true;
                          //       post = postMedia.path;
                          //     }
                          //   }
                          // }
                          return InkWell(
                            onTap: () {
                              ChallengesModelData challengesModelData =
                                  ChallengesModelData(
                                      id: "",
                                      challengeId: openChallenges.sId!,
                                      challengeName: openChallenges.hashTag!,
                                      postId: "");
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (ontext) =>
                              //           ChallengeFameLinkFullPostScreen(openChallenges.posts, index, 1,openChallenges.sId,openChallenges.type)),
                              // );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setSp(4),
                                  bottom: ScreenUtil().setSp(4),
                                  left: ScreenUtil().setSp(2),
                                  right: ScreenUtil().setSp(2)),
                              child: Container(
                                  color: Colors.blue,
                                  width: itemWidth,
                                  height: ScreenUtil().setHeight(107),
                                  child: Stack(
                                    children: [
                                      // VideoPlayerScreen(
                                      //     "${openChallenges.posts[index].images[0].path}",
                                      //     ApiProvider.funPostImageBaseUrl,
                                      //     0,
                                      //     0,
                                      //     null,
                                      //     0,
                                      //     0,
                                      //     false,
                                      //     this.videoController,
                                      //     true),

                                      Image.network(
                                        '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${openChallenges.posts![index].media?[0]?.path}-xs',
                                        fit: BoxFit.cover,
                                        width: itemWidth,
                                        height: itemHeight,
                                      ),
                                      Center(
                                        child: Container(
                                          height: ScreenUtil().setHeight(32.94),
                                          width: ScreenUtil().setWidth(40),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      ScreenUtil().radius(5)))),
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: black,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: lightGray,
                    )
                  ],
                );
              },
            ),
    );
  }

  String convertToAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);
    return '${diff.inDays}d';
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
                                      // searchData("");
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
                                      // searchData("");
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
