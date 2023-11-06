import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_back_to_close/toast.dart';
import 'package:famelink/databse/filesavecache.dart';
import 'package:famelink/ui/followLinks/provider/FollowLinksFeedProvider.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/widgets/FeedVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../databse/currentvideo.dart';
import '../../../nativeads/nativeadsprovider.dart';
import '../../../networking/config.dart';

class FollowLinksFeed extends StatefulWidget {
  const FollowLinksFeed({Key? key}) : super(key: key);

  @override
  State<FollowLinksFeed> createState() => _FollowLinksFeedState();
}

class _FollowLinksFeedState extends State<FollowLinksFeed> {
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
    return Consumer<FollowLinksFeedProvider>(
        builder: (context, provider, child) {
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
            prefs.remove("followFeedPage");
            provider.followLinkList.clear();
            // provider.myController!.jumpToPage(0);

            provider.getFollowLinkFeedData();
            provider.changeIndex(0, true);
          },
          child: PageView.builder(
            controller: provider.myController,
            scrollDirection: Axis.vertical,
            //allowImplicitScrolling: true,clipBehavior: Clip.antiAlias,pageSnapping: true,
            itemCount: provider.followLinkList.length,
            //  ignore: missing_return,
            itemBuilder: (context, index2) {
              if (provider.followLinkList[index2].type == "famelinks") {
                if (provider.followLinkList[index2].media![0].type.toString() ==
                    "video" && provider.followLinkList[index2].media!.length==1) {
                  debugPrint(
                      "101010101010-Videos ${provider.followLinkList[index2].media![0].path}");
                  return FeedVideoPlayer(
                      videoUrl:
                          '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.followLinkList[index2].media![0].path}');
                } else if(provider.followLinkList[index2].media!.length==1){
                  return CachedNetworkImage(
                    imageUrl:
                    '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.followLinkList[index2].media![0].path}',
                    errorWidget: (context, url, error) {
                      print("ER::${error.toString()}");
                      return Icon(Icons.error, color: white);
                    },
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  );
                } else {
                  return PageView.builder(
                    itemCount: provider.followLinkList[index2].media!.length,
                    scrollDirection: Axis.horizontal,
                    controller: provider.smoothPageController!,
                    itemBuilder: (BuildContext context, int i) {
                      print(
                          "Amarjeet  ${provider.followLinkList.length} $index2 ${ApiProvider.s3UrlPath} ${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.followLinkList[index2].media![0].path.toString()}");
                      if (index2 == 0) {
                        Filecache()
                            .savecache(
                            '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.followLinkList[index2].media![0].path.toString()}')
                            .then((value) {
                          Filecache()
                              .savecache(
                              '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.followLinkList[index2].media![0].path.toString()}')
                              .then((value) {
                            Filecache().savecache(
                                '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.followLinkList[index2].media![0].path.toString()}');
                          });
                        });
                      } else {
                        if ((index2 + 3) < provider.followLinkList.length) {
                          Filecache().savecache(
                              '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.followLinkList[index2].media![0].path.toString()}');
                        }
                      }

                      return provider.followLinkList[index2].type == "famelinks"
                          ? provider.followLinkList[index2].media![i].type
                          .toString() ==
                          "video"
                          ? FeedVideoPlayer(
                          videoUrl:
                          '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.followLinkList[index2].media![i].path}')
                          : SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl:
                            '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.followLinkList[index2].media![i].path}',
                            errorWidget: (context, url, error) {
                              print("ER::${error.toString()}");
                              return Icon(Icons.error, color: white);
                            },
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                          ))
                          : provider.followLinkList[index2].type == "funlinks"
                          ? provider.followLinkList[index2].media![i].type
                          .toString() ==
                          "video"
                          ? FeedVideoPlayer(
                          videoUrl:
                          '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.followLinkList[index2].media![i].path}')
                          : SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl:
                            '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.followLinkList[index2].media![i].path}',
                            errorWidget: (context, url, error) {
                              print("ER::${error.toString()}");
                              return Icon(Icons.error, color: white);
                            },
                            fit: BoxFit.cover,
                            height:
                            MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                          ))
                          : provider.followLinkList[index2].type ==
                          "followlinks"
                          ? provider.followLinkList[index2].media![i].type
                          .toString() ==
                          "video"
                          ? FeedVideoPlayer(
                          videoUrl:
                          '${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${provider.followLinkList[index2].media![i].path}')
                          : SizedBox(
                          height:
                          MediaQuery.of(context).size.height,
                          width:
                          MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl:
                            '${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${provider.followLinkList[index2].media![i].path}',
                            errorWidget: (context, url, error) {
                              print("ER::${error.toString()}");
                              return Icon(Icons.error,
                                  color: white);
                            },
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context)
                                .size
                                .height,
                            width:
                            MediaQuery.of(context).size.width,
                          ))
                          : Container();
                    },
                    onPageChanged: (value) {
                      debugPrint("On Page Change $value");
                    },
                  );
                }
              } else if (provider.followLinkList[index2].type == "funlinks") {
                if (provider.followLinkList[index2].media![0].type.toString() ==
                    "video") {
                  return FeedVideoPlayer(
                      videoUrl:
                          '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.followLinkList[index2].media![0].path}');
                } else {
                  return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        imageUrl:
                            '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.followLinkList[index2].media![0].path}',
                        errorWidget: (context, url, error) {
                          print("ER::${error.toString()}");
                          return Icon(Icons.error, color: white);
                        },
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ));
                }
              } else if (provider.followLinkList[index2].type ==
                  "followlinks" ) {
                if (provider.followLinkList[index2].media![0].type.toString() ==
                    "video" && provider.followLinkList[index2].media!.length==1) {
                  return FeedVideoPlayer(
                      videoUrl:
                          '${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${provider.followLinkList[index2].media![0].path}');
                } else if (provider.followLinkList[index2].media![0].type
                        .toString() ==
                    "ads") {
                  return Consumer<Nativeadsprovider>(
                    builder: (context, nativeadsprovider, child) {
                      return nativeadsprovider.nativeAdIsLoaded
                          ? Container(
                              color: Colors.red,
                              height: 300,
                              child: AdWidget(ad: nativeadsprovider.nativeAd!),
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
                } else if(provider.followLinkList[index2].media!.length==1){
                  return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        imageUrl:
                            '${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${provider.followLinkList[index2].media![0].path}',
                        errorWidget: (context, url, error) {
                          print("ER::${error.toString()}");
                          return Icon(Icons.error, color: white);
                        },
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ));
                } else{
                  return PageView.builder(
                    itemCount: provider.followLinkList[index2].media!.length,
                    scrollDirection: Axis.horizontal,
                    controller: provider.smoothPageController!,
                    itemBuilder: (BuildContext context, int i) {
                      print(
                          "Amarjeet  ${provider.followLinkList.length} $index2 ${ApiProvider.s3UrlPath} ${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.followLinkList[index2].media![0].path.toString()}");
                      if (index2 == 0) {
                        Filecache()
                            .savecache(
                            '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.followLinkList[index2].media![0].path.toString()}')
                            .then((value) {
                          Filecache()
                              .savecache(
                              '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.followLinkList[index2].media![0].path.toString()}')
                              .then((value) {
                            Filecache().savecache(
                                '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.followLinkList[index2].media![0].path.toString()}');
                          });
                        });
                      } else {
                        if ((index2 + 3) < provider.followLinkList.length) {
                          Filecache().savecache(
                              '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.followLinkList[index2].media![0].path.toString()}');
                        }
                      }

                      return provider.followLinkList[index2].type == "famelinks"
                          ? provider.followLinkList[index2].media![i].type
                          .toString() ==
                          "video"
                          ? FeedVideoPlayer(
                          videoUrl:
                          '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.followLinkList[index2].media![i].path}')
                          : SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl:
                            '${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${provider.followLinkList[index2].media![i].path}',
                            errorWidget: (context, url, error) {
                              print("ER::${error.toString()}");
                              return Icon(Icons.error, color: white);
                            },
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                          ))
                          : provider.followLinkList[index2].type == "funlinks"
                          ? provider.followLinkList[index2].media![i].type
                          .toString() ==
                          "video"
                          ? FeedVideoPlayer(
                          videoUrl:
                          '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.followLinkList[index2].media![i].path}')
                          : SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl:
                            '${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}/${provider.followLinkList[index2].media![i].path}',
                            errorWidget: (context, url, error) {
                              print("ER::${error.toString()}");
                              return Icon(Icons.error, color: white);
                            },
                            fit: BoxFit.cover,
                            height:
                            MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                          ))
                          : provider.followLinkList[index2].type ==
                          "followlinks"
                          ? provider.followLinkList[index2].media![i].type
                          .toString() ==
                          "video"
                          ? FeedVideoPlayer(
                          videoUrl:
                          '${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${provider.followLinkList[index2].media![i].path}')
                          : SizedBox(
                          height:
                          MediaQuery.of(context).size.height,
                          width:
                          MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl:
                            '${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${provider.followLinkList[index2].media![i].path}',
                            errorWidget: (context, url, error) {
                              print("ER::${error.toString()}");
                              return Icon(Icons.error,
                                  color: white);
                            },
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context)
                                .size
                                .height,
                            width:
                            MediaQuery.of(context).size.width,
                          ))
                          : Container();
                    },
                    onPageChanged: (value) {
                      debugPrint("On Page Change $value");
                    },
                  );
                }
              } else {
                debugPrint(
                    "Inside the ListView Builder ${provider.followLinkList[index2].media!.length}");
                return Container();
              }
              return Container();
            },
            onPageChanged: (value) async {
              if (provider.followLinkList[value].NewPostsAvailable == true) {
                provider.newpostavailable(context);
              }
              Currentvideo.setvideoindex(value, "currentindexfollow");
              if (provider.followLinkList[value + 2].media![0].type
                      .toString() ==
                  "ads") {
                final asdcall =
                    Provider.of<Nativeadsprovider>(context, listen: false);

                asdcall.initializeAd("ca-app-pub-3940256099942544/1044960115");
              }
              debugPrint(
                  "On Page Changed ${value.toString()}  ${provider.followLinkList.length}");
              if (value == provider.followLinkList.length - 3) {
                await provider.getFollowLinkFeedData(paginate: true);
              } else {
                provider.changeIndex(value, true);
              }
            },
          ),
        ),
      );
    });
  }
}
