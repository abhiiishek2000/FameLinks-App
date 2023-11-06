import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:famelink/providers/FeedVideoProvider/FeedVideoProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../databse/filesavecache.dart';

class FeedVideoPlayer extends StatefulWidget {
  const FeedVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);
  final String videoUrl;

  @override
  State<FeedVideoPlayer> createState() => _FeedVideoPlayerState();
}

class _FeedVideoPlayerState extends State<FeedVideoPlayer>
    with TickerProviderStateMixin {
  late VideoPlayerController controller;
  late AnimationController _controller;
  late Animation animation;
  final Key videoWidgetKey = const Key('video-widget');

  @override
  void initState() {
    final feedpro = Provider.of<FeedVideoProvider>(context, listen: false);
    feedpro.Loading();
    Filecache().getcache(widget.videoUrl).then((val) {
      controller = VideoPlayerController.file(File(val),
          videoPlayerOptions: VideoPlayerOptions(
              allowBackgroundPlayback: false, mixWithOthers: false))
        ..initialize().then((value) {
          feedpro.notLoading();

          init();
          initAnim();
        });
      // providerv2.pathlink1 = val;
      print("pathlink1 ${val} ");
      log('${widget.videoUrl} videokiurl');

      controller.addListener(() {
        if (controller.value.isInitialized) {
          //  Provider.of<FeedVideoProvider>(context, listen: false).notLoading();
        }
      });
    });

    super.initState();
  }

  init() async {
    await controller.play();
    await controller.setLooping(true);
  }

  initAnim() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween(begin: 0, end: 1).animate(_controller);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    //controller.dispose();
    controller.pause();
    controller.setLooping(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FeedVideoProvider>(builder: (context, provider, child) {
      return Scaffold(
          backgroundColor: Colors.black,
          body: provider.isLoading
              ? CachedNetworkImage(
                  imageUrl: '${widget.videoUrl}-xs',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fill,
                )
              : GestureDetector(
                  onLongPress: () {
                    provider.changeIsPausedStatus(controller);
                  },
                  onLongPressUp: () {
                    provider.changeIsPausedStatus(controller);
                  },
                  onTap: () {
                    _controller.forward();
                    provider.changeMuteStatus(controller);
                  },
                  child: VisibilityDetector(
                    key: videoWidgetKey,
                    onVisibilityChanged: (VisibilityInfo info) {
                      var visiblePercentage = info.visibleFraction * 100;
                      if (visiblePercentage < 50) {
                        controller.pause();
                      } else {
                        controller.play();
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          VideoPlayer(controller),
                          Align(
                            alignment: Alignment.center,
                            child: AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) => Opacity(
                                      opacity: _controller.value,
                                      child: FloatingActionButton(
                                        backgroundColor:
                                            Colors.black.withOpacity(0.50),
                                        elevation: 0,
                                        onPressed: () {},
                                        child: Icon(provider.isMute
                                            ? Icons.volume_up
                                            : Icons.volume_off),
                                      ),
                                    )),
                          )
                        ],
                      ),
                    ),
                  ),
                ));
    });
  }
}
