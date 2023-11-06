import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../../../nativeads/nativeadsprovider.dart';
import '../../../../networking/config.dart';
import '../../../../providers/FeedProvider/GetPerticularFollowLinksProfileProvider.dart';
import '../../../../util/constants.dart';
import '../../../../util/widgets/FeedVideoPlayer.dart';
import '../../../Famelinkprofile/function/famelinkFun.dart';

class FollowscrollFeed extends StatelessWidget {
  FollowscrollFeed({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return Consumer2<GetParticularFollowLinksProfileProvider, FameLinkFun>(
        builder: (context, provider, fameLinkFun, child) {
      return RefreshIndicator(
        onRefresh: () {
          return fameLinkFun.getFollowLinkFeed(id!, context, isPaginate: false);
          // particularFollowLink.getParticularFunUserProfileModelResultList.result!.clear();
        },
        child: provider.getParticularFunUserProfileModelResultList.result!
                    .length !=
                0
            ? PageView.builder(
                controller: provider.controller,
                scrollDirection: Axis.vertical,
                itemCount: provider
                    .getParticularFunUserProfileModelResultList.result!.length,
                itemBuilder: (BuildContext context, int index) {
                  if (provider.getParticularFunUserProfileModelResultList
                          .result![index].media!.length ==
                      1) {
                    return SizedBox(
                      height: ScreenUtil().screenHeight,
                      width: ScreenUtil().screenWidth,
                      child: provider.getParticularFunUserProfileModelResultList
                                  .result![index].media![0].type ==
                              "video"
                          ? FeedVideoPlayer(
                              videoUrl:
                                  "${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${provider.getParticularFunUserProfileModelResultList.result![index].media![0].path}",
                            )
                          : provider.getParticularFunUserProfileModelResultList
                                      .result![index].media![0].type ==
                                  "ads"
                              ? Consumer<Nativeadsprovider>(
                                  builder: (context, nativeadsprovider, child) {
                                    return nativeadsprovider.nativeAdIsLoaded
                                        ? Container(
                                            // color: Colors.red,
                                            height: double.infinity,
                                            child: AdWidget(
                                                ad: nativeadsprovider
                                                    .nativeAd!),
                                          )
                                        : Container(
                                            child: Center(
                                              child: Text(
                                                "ads not loads",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          );
                                  },
                                )
                              : provider
                                      .getParticularFunUserProfileModelResultList
                                      .result![index]
                                      .media![0]
                                      .image ??
                                  CachedNetworkImage(
                                    imageUrl:
                                        "${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${provider.getParticularFunUserProfileModelResultList.result![index].media![0].path}",
                                    fit: BoxFit.cover,
                                  ),
                    );
                  } else {
                    //count=particularFollowLink.getParticularFunUserProfileModelResultList.result![index].media.length;
                    return PageView.builder(
                      itemCount: provider
                          .getParticularFunUserProfileModelResultList
                          .result![index]
                          .media!
                          .length,
                      controller: provider.smoothPageController,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int i) {
                        return SizedBox(
                          height: ScreenUtil().screenHeight,
                          width: ScreenUtil().screenWidth,
                          child: provider
                                      .getParticularFunUserProfileModelResultList
                                      .result![index]
                                      .media![i]
                                      .type ==
                                  "video"
                              ? FeedVideoPlayer(
                                  videoUrl:
                                      "${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${provider.getParticularFunUserProfileModelResultList.result![index].media![i].path}",
                                )
                              : provider
                                      .getParticularFunUserProfileModelResultList
                                      .result![index]
                                      .media![i]
                                      .image ??
                                  CachedNetworkImage(
                                    imageUrl:
                                        "${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${provider.getParticularFunUserProfileModelResultList.result![index].media![i].path}",
                                    fit: BoxFit.cover,
                                  ),
                        );
                      },
                      onPageChanged: (value) {
                        //  setState(() {
                        if (provider.getParticularFunUserProfileModelResultList
                                .result![index] !=
                            null) {
                          // for(int i = 0; i<=dataFameLink[index2].media.length; i++){
                          if (provider
                                  .getParticularFunUserProfileModelResultList
                                  .result![index]
                                  .media![value]
                                  .type ==
                              'video') {
                            Constants.playing = true;
                          } else {
                            Constants.playing = false;
                          }
                          // }
                        } else {
                          Constants.playing = false;
                        }
                        provider.ind = value;
                        // });
                      },
                    );
                  }
                },
                onPageChanged: (value) async {
                  debugPrint("On Page Changed ${value.toString()}");
                  provider.changeIndex(value);
                  if (provider.getParticularFunUserProfileModelResultList
                          .result![value + 3].media![0].type
                          .toString() ==
                      "ads") {
                    print("adscall");
                    final asdcall =
                        Provider.of<Nativeadsprovider>(context, listen: false);

                    asdcall
                        .initializeAd("ca-app-pub-3940256099942544/1044960115");
                  }
                  if (provider.getParticularFunUserProfileModelResultList
                          .result![value] !=
                      null) {
                    if (provider.getParticularFunUserProfileModelResultList
                            .result![value].media![0].type ==
                        'video') {
                      Constants.playing = true;
                    } else {
                      Constants.playing = false;
                    }
                  } else {
                    Constants.playing = false;
                  }
                  debugPrint("On Page Changed ${value.toString()}");
                  if (value ==
                      provider.getParticularFunUserProfileModelResultList
                              .result!.length -
                          1) {
                    await fameLinkFun.getFollowLinkFeed(id, context,
                        isPaginate: true);
                  }
                },
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
    ;
  }
}
