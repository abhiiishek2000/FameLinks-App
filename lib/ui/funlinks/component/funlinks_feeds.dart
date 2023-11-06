import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_back_to_close/toast.dart';
import 'package:famelink/databse/filesavecache.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/widgets/FeedVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../databse/currentvideo.dart';
import '../../../nativeads/nativeadsprovider.dart';
import '../../../networking/config.dart';
import '../provider/FunLinksFeedProvider.dart';

class FunLinksFeed extends StatefulWidget {
  const FunLinksFeed({Key? key}) : super(key: key);

  @override
  State<FunLinksFeed> createState() => _FunLinksFeedState();
}

class _FunLinksFeedState extends State<FunLinksFeed> {
  bool get _isAndroid => Theme.of(context).platform == TargetPlatform.android;
  int waitForSecondBackPress = 2;
  int onFirstBackPress = 1;
  void resetBackTimeout() {
    Future.delayed(Duration(seconds: 2), () {
      onFirstBackPress = 1;
      print("object");
    });
  }

  TextStyle textStyle = const TextStyle(fontSize: 14, color: Colors.white);
  Color background = const Color(0xAA000000);
  double backgroundRadius = 20;

  @override
  Widget build(BuildContext context) {
    return Consumer<FunLinksFeedProvider>(builder: (context, provider, child) {
      return WillPopScope(
        onWillPop: () async {
          provider.myController!.jumpToPage(0);

          if (onFirstBackPress == 1) {
            onFirstBackPress = 2;

            Toast.show(
              "Press back again to exit app",
              context,
              duration: waitForSecondBackPress,
              gravity: Toast.bottom,
              textStyle: textStyle,
              backgroundColor: background,
              backgroundRadius: backgroundRadius,
            );
            resetBackTimeout();
            return false;
          } else {
            Navigator.of(context).pop(true);
            exit(0);
            return false;
          }
        },
        child: RefreshIndicator(
          onRefresh: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove("funFeedPage");
            provider.funLinksList.clear();
            provider.funFeedPage = 0;
            // provider.myController!.jumpToPage(0);
            provider.getFunLinkFeedData();
            provider.changeIndex(0, true);
          },
          child: InkWell(
            onTap: () {
              if (provider.getIsProfileUI == true) {
                provider.changeIsProfileUI(false);
                provider.changeOnClickPageImage(false);
              } else {
                provider.changeOnClickPageImage(!provider.getOnClickPageImage);
              }
            },
            child: PageView.builder(
              controller: provider.myController,
              scrollDirection: Axis.vertical,
              itemCount: provider.funLinksList.length,
              itemBuilder: (context, index2) {
                print(
                    "Amarjeet  ${provider.funLinksList.length} $index2 ${ApiProvider.s3UrlPath} ${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.funLinksList[index2].media![0].path.toString()}");
                if (index2 == 0) {
                  Filecache()
                      .savecache(
                          '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.funLinksList[index2].media![0].path.toString()}')
                      .then((value) {
                    Filecache()
                        .savecache(
                            '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.funLinksList[index2].media![0].path.toString()}')
                        .then((value) {
                      Filecache().savecache(
                          '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.funLinksList[index2].media![0].path.toString()}');
                    });
                  });
                } else {
                  if ((index2 + 3) < provider.funLinksList.length) {
                    print(
                        "currentindex $index2 ${provider.funLinksList.length}");
                    Filecache().savecache(
                        '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.funLinksList[index2].media![0].path.toString()}');
                  }
                }

                if (provider.funLinksList[index2] == null) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(color: appBackgroundColor),
                      child: Container(
                        alignment: Alignment.center,
                      ));
                } else if (provider.funLinksList[index2].media!.length == 1) {
                  if (provider.funLinksList[index2].media![0].type.toString() ==
                      "video") {
                    return Stack(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: FeedVideoPlayer(
                              videoUrl:
                                  "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.funLinksList[index2].media![0].path.toString()}",
                            )),
                      ],
                    );
                  } else if (provider.funLinksList[index2].media![0].type
                          .toString() ==
                      "ads") {
                    return Consumer<Nativeadsprovider>(
                      builder: (context, nativeadsprovider, child) {
                        return nativeadsprovider.nativeAdIsLoaded
                            ? Container(
                                color: Colors.red,
                                height: 300,
                                child:
                                    AdWidget(ad: nativeadsprovider.nativeAd!),
                              )
                            : Container(
                                child: Center(
                                  child: Text(
                                    "ads not loads",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                      },
                    );
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        imageUrl:
                            '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.funLinksList[index2].media![0].path.toString()}',
                        errorWidget: (context, url, error) {
                          print("ER::${error.toString()}");
                          return Icon(Icons.error, color: white);
                        },
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ),
                    );
                  }
                } else {
                  return SizedBox(
                      height: ScreenUtil().screenHeight,
                      width: ScreenUtil().screenWidth,
                      child: provider.funLinksList[index2].media![0].type
                                  .toString() ==
                              "video"
                          ? FeedVideoPlayer(
                              videoUrl:
                                  '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.funLinksList[index2].media![0].path.toString()}',
                            )
                          : CachedNetworkImage(
                              imageUrl:
                                  '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.funLinksList[index2].media![0].path.toString()}',
                              errorWidget: (context, url, error) {
                                print("ER::${error.toString()}");
                                return Icon(Icons.error, color: white);
                              },
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                            ));
                }
              },
              onPageChanged: (value) async {
                if (provider.funLinksList[value].NewPostsAvailable == true) {
                  provider.newpostavailable(context);
                }
                Currentvideo.setvideoindex(value, "currentindexfun");
                if (provider.funLinksList[value + 2].media![0].type
                        .toString() ==
                    "ads") {
                  final asdcall =
                      Provider.of<Nativeadsprovider>(context, listen: false);

                  asdcall
                      .initializeAd("ca-app-pub-3940256099942544/1044960115");
                }
                debugPrint(
                    "On Page Changed $value  ${provider.funLinksList.length}");
                if (value == provider.funLinksList.length - 3) {
                  provider.getFunLinkFeedData(paginate: true);
                } else {
                  provider.changeIndex(value, true);
                }
              },
            ),
          ),
        ),
      );
    });
  }
}
