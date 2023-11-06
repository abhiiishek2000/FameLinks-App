import 'package:famelink/networking/config.dart';
import 'package:famelink/util/constants.dart';
import 'package:famelink/util/widgets/FeedVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../../../nativeads/nativeadsprovider.dart';
import '../../../../providers/FeedProvider/GetParticularUserProfileProvider.dart';
import '../../../Famelinkprofile/function/famelinkFun.dart';

class scrollFeed extends StatelessWidget {
  scrollFeed({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return Consumer2<GetParticularFameLinksProfileProvider, FameLinkFun>(
        builder: (context, particularFameLink, fameLinkFun, child) {
      return RefreshIndicator(
        onRefresh: () {
          return fameLinkFun.getFameLinksFeed(id, context, isPaginate: false);
          // particularFameLink.getParticularFunUserProfileModelResultList.result.clear();
        },
        child: particularFameLink.getParticularFunUserProfileModelResultList
                    .result!.length !=
                0
            ? PageView.builder(
                controller: particularFameLink.controller,
                scrollDirection: Axis.vertical,
                itemCount: particularFameLink
                    .getParticularFunUserProfileModelResultList.result!.length,
                itemBuilder: (BuildContext context, int index) {
                  //   particularFameLink!.ad!.load();
                  if (particularFameLink
                          .getParticularFunUserProfileModelResultList
                          .result![index]
                          .media!
                          .length ==
                      1) {
                    particularFameLink.count = particularFameLink
                        .getParticularFunUserProfileModelResultList
                        .result![index]
                        .media!
                        .length;
                    return SizedBox(
                      height: ScreenUtil().screenHeight,
                      width: ScreenUtil().screenWidth,
                      child: particularFameLink
                                  .getParticularFunUserProfileModelResultList
                                  .result![index]
                                  .media![0]
                                  .type ==
                              "video"
                          ? FeedVideoPlayer(
                              videoUrl:
                                  "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${particularFameLink.getParticularFunUserProfileModelResultList.result![index].media![0].path}",
                            )
                          : particularFameLink
                                      .getParticularFunUserProfileModelResultList
                                      .result![index]
                                      .media![0]
                                      .type ==
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
                              : particularFameLink
                                      .getParticularFunUserProfileModelResultList
                                      .result![index]
                                      .media![0]
                                      .image ??
                                  Image.network(
                                    "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${particularFameLink.getParticularFunUserProfileModelResultList.result![index].media![0].path}",
                                    fit: BoxFit.fill,
                                  ),
                    );
                  } else {
                    //count=particularFameLink.getParticularFunUserProfileModelResultList.result[index].media.length;
                    return PageView.builder(
                      itemCount: particularFameLink
                          .getParticularFunUserProfileModelResultList
                          .result![index]
                          .media!
                          .length,
                      controller: particularFameLink.smoothPageController,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int i) {
                        return SizedBox(
                          height: ScreenUtil().screenHeight,
                          width: ScreenUtil().screenWidth,
                          child: particularFameLink
                                      .getParticularFunUserProfileModelResultList
                                      .result![index]
                                      .media![i]
                                      .type ==
                                  "video"
                              ? FeedVideoPlayer(
                                  videoUrl:
                                      "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${particularFameLink.getParticularFunUserProfileModelResultList.result![index].media![i].path}",
                                )
                              : particularFameLink
                                      .getParticularFunUserProfileModelResultList
                                      .result![index]
                                      .media![i]
                                      .image ??
                                  Image.network(
                                    "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${particularFameLink.getParticularFunUserProfileModelResultList.result![index].media![i].path}",
                                    fit: BoxFit.fill,
                                  ),
                        );
                      },
                      onPageChanged: (value) {
                        // setState(() {
                        if (particularFameLink
                                .getParticularFunUserProfileModelResultList
                                .result![index] !=
                            null) {
                          // for(int i = 0; i<=dataFameLink[index2].media.length; i++){
                          if (particularFameLink
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
                        particularFameLink.ind = value;
                        //});
                      },
                    );
                  }
                },
                onPageChanged: (value) async {
                  debugPrint("On Page Changed ${value.toString()}");
                  particularFameLink.changeIndex(value);
                  if (particularFameLink
                          .getParticularFunUserProfileModelResultList
                          .result![value] !=
                      null) {
                    if (particularFameLink
                            .getParticularFunUserProfileModelResultList
                            .result![value]
                            .media![0]
                            .type ==
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
                      particularFameLink
                              .getParticularFunUserProfileModelResultList
                              .result!
                              .length -
                          1) {
                    await fameLinkFun.getFameLinksFeed(id!, context,
                        isPaginate: true);
                  }
                  // if (value == getParticularUserProfileModelResultList.length - 1) {
                  //     page++;
                  //     await getFameLinkFeed(id: getParticularUserProfileModelResultList[value].sId);
                  //   }
                },
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }
}
