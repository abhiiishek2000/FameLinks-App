import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_back_to_close/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../databse/currentvideo.dart';
import '../../../databse/filesavecache.dart';
import '../../../nativeads/nativeadsprovider.dart';
import '../../../networking/config.dart';
import '../../../util/config/color.dart';
import '../../../util/widgets/FeedVideoPlayer.dart';
import '../provider/FameLinksFeedProvider.dart';

class FeedView extends StatefulWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
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
    return Consumer<FameLinksFeedProvider>(builder: (context, provider, child) {
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
            prefs.remove("fameFeedPage");

            print("start first");
            provider.feedList.clear();
            provider.famePagination = 1;
            provider.changeIndex(0, true);
            //  provider.smoothPageController!.jumpToPage(0);
            provider.getMe();
          },
          child: InkWell(
            onTap: () {
              if (provider.getIsProfileUI == true) {
                provider.changeIsProfileUI(false);
              } else {
                provider.changeIsProfileUI(true);
              }
            },
            child: PageView.builder(
              controller: provider.myController,
              scrollDirection: Axis.vertical,
              itemCount: provider.feedList.length,
              itemBuilder: (context, index2) {
                print(
                    "Amarjeet  ${provider.feedList.length} $index2 ${ApiProvider.s3UrlPath} ${ApiProvider.famelinks}/${provider.feedList[index2].media?[0].path}");
                if (index2 == 0) {
                  Filecache()
                      .savecache(
                          '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.feedList[index2].media?[0].path}')
                      .then((value) {
                    Filecache()
                        .savecache(
                            '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.feedList[index2 + 1].media?[0].path}')
                        .then((value) {
                      Filecache().savecache(
                          '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.feedList[index2 + 2].media?[0].path}');
                    });
                  });
                } else {
                  print(
                      "currentindex2 ${index2 + 3} ${provider.feedList.length} ");
                  if ((index2 + 3) < provider.feedList.length) {
                    print("currentindex $index2 ${provider.feedList.length} ");
                    Filecache().savecache(
                        '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.feedList[index2 + 3].media?[0].path}');
                  }
                }
                if (provider.feedList[index2] == null) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(color: appBackgroundColor),
                  );
                } else if (provider.feedList[index2].media!.length == 1) {
                  print(
                      "===--> ${provider.feedList[index2].media![0].type.toString()}");
                  if (provider.feedList[index2].media![0].type.toString() ==
                      "video") {
                    return FeedVideoPlayer(
                      videoUrl:
                          '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.feedList[index2].media?[0].path}',
                    );
                  } else if (provider.feedList[index2].media![0].type
                          .toString() ==
                      "ads") {
                    return Consumer<Nativeadsprovider>(
                      builder: (context, nativeadsprovider, child) {
                        return nativeadsprovider.nativeAdIsLoaded
                            ? Container(
                                // color: Colors.red,
                                height: double.infinity,
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
                      child: provider.feedList[index2].media![0].image ??
                          CachedNetworkImage(
                            imageUrl:
                                '${provider.feedList[index2].user!.type == "agency" ? ApiProvider.profile : provider.feedList[index2].user!.type == "brand" ? ApiProvider.profile : "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}"}/${provider.feedList[index2].media![0].path.toString()}',
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
                  return PageView.builder(
                    itemCount: provider.feedList[index2].media!.length,
                    scrollDirection: Axis.horizontal,
                    controller: provider.smoothPageController,
                    itemBuilder: (BuildContext context, int i) {
                      print(
                          "Amarjeet2midea  ${provider.feedList.length} $index2 ${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.feedList[index2].media?[i].path}");
                      if (index2 == 0) {
                        Filecache()
                            .savecache(
                                '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.feedList[index2].media?[i].path}')
                            .then((value) {
                          Filecache()
                              .savecache(
                                  '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.feedList[index2 + 1].media?[i].path}')
                              .then((value) {
                            Filecache().savecache(
                                '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.feedList[index2 + 2].media?[i].path}');
                          });
                        });
                      } else {
                        print("indexprint   $index2 $i");
                        if (i > 1) {
                          print("indexprint2   $index2 $i");

                          Filecache().savecache(
                              '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.feedList[index2 + 3].media?[i].path}');
                        }
                      }
                      return SizedBox(
                          height: ScreenUtil().screenHeight,
                          width: ScreenUtil().screenWidth,
                          child: provider.feedList[index2].media![i].type
                                      .toString() ==
                                  "video"
                              ? FeedVideoPlayer(
                                  videoUrl:
                                      "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.feedList[index2].media?[i].path}",
                                )
                              : provider.feedList[index2].media![i].image ??
                                  CachedNetworkImage(
                                    imageUrl:
                                        '${provider.feedList[index2].user!.type == "agency" ? ApiProvider.profile : provider.feedList[index2].user!.type == "brand" ? ApiProvider.profile : "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}"}/${provider.feedList[index2].media![i].path.toString()}',
                                    errorWidget: (context, url, error) {
                                      print("ER::${error.toString()}");
                                      return Icon(Icons.error, color: white);
                                    },
                                    fit: BoxFit.cover,
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                  ));
                    },
                    onPageChanged: (value) {
                      debugPrint("OnPageChange $value");
                    },
                  );
                }
              },
              onPageChanged: (value) async {
                Currentvideo.setvideoindex(value, "currentindexfame");
                print("set index");
                if (provider.feedList[value + 2].media![0].type.toString() ==
                    "ads") {
                  print("adscall");
                  final asdcall =
                      Provider.of<Nativeadsprovider>(context, listen: false);

                  asdcall
                      .initializeAd("ca-app-pub-3940256099942544/1044960115");
                }
                // dataFameLink.getIndex
                log("===> pageIndex:- ${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.feedList[value].media?[0].path}");
                log("On Page Changed ${value.toString()} ${provider.feedList.length}");
                if (value == provider.feedList.length - 3) {
                  provider.getFameLinkFeedData(paginate: true);
                  provider.changeIndex(value, false);
                } else {
                  provider.changeIndex(value, true);
                }
                if (provider.feedList[value].NewPostsAvailable == true) {
                  provider.newpostavailable(context);
                }
              },
            ),
          ),
        ),
      );
    });
  }
}
