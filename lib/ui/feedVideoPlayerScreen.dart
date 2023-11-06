import 'package:famelink/networking/config.dart';
import 'package:famelink/util/constants.dart';
import 'package:famelink/util/loading_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'funlinks/provider/FunLinksFeedProvider.dart';


class FeedVideoPlayerScreen extends StatefulWidget {
  int index;
  int verticalIndex;
  int currentPageIndex;
  int currentVerticalPageIndex;
  bool isMute;
  // String _videos;
  String basePath;
  bool isPaused;
  OnFeedVideoScreenListener listener;
  // bool isPlaying;
  // bool isInitialized;

  VideoPlayerController videoController;

  FeedVideoPlayerScreen(
      // this._videos,
      this.basePath,
      this.index,
      this.currentPageIndex,
      this.listener,
      this.verticalIndex,
      this.currentVerticalPageIndex,
      this.isMute,
      this.videoController,
      this.isPaused,
      // this.isPlaying
      );

  @override
  _FeedVideoPlayerState createState() => _FeedVideoPlayerState();
}

abstract class OnFeedVideoScreenListener {
  void onProfileClick();
  void onPlayingChange(bool isPlaying);
}

class _FeedVideoPlayerState extends State<FeedVideoPlayerScreen> {
  VideoPlayerController? _controller;

  bool isLiked = false;
  bool isLoading = true;
  // bool initialized = true;
  // bool _isPlaying = true;
  bool isAfterDownLoading = true;
  bool isFollow = false;

  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _controller = widget.videoController;
      // _isPlaying = widget.isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
//    print('Check Navigation '+isNavigationOn.toString());

    // _controller = widget.videoController;
    // _isPlaying = widget.isPlaying;
    // initialized = widget.isInitialized;
    // if(_controller.value.position == _controller.value.duration) {
    //   print('video Ended');
    //   if(mounted) {
    //     setState(() {
    //       Constants.playing = false;
    //     });
    //  }
    // }
    debugPrint("IND_VIDEO::${widget.index}:::${widget.currentPageIndex}");
    if (widget.index == widget.currentPageIndex &&
        widget.verticalIndex == widget.currentVerticalPageIndex &&
        // !widget.isPaused == false &&
        Constants.initialized &&
        Constants.playing &&
        isAfterDownLoading) {
      if (widget.isMute) {
        _controller!.setVolume(1);
        // _controller.play();
      } else {
        // _controller.pause();
        _controller!.setVolume(0);
      }
      setState(() {

        if( Provider.of<FunLinksFeedProvider>(context).getIsNavigationOn ==false)
          _controller!.play();
      });
    } else {
      if (_controller != null && _controller!.value.isPlaying) {
        setState(() {
          _controller!.pause();
        });
      }
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GestureDetector(
            onLongPressUp: () {
              isAfterDownLoading = true;
              _controller!.play();
            },
            onLongPress: () {
              _controller!.pause();
            },
            onTap: () {
              // print("++++++++==========");
              if (widget.listener != null) {
                widget.listener.onProfileClick();
              }
            },
            child: Center(
              child: _controller != null && _controller!.value.isInitialized
                  ? AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              )
                  : Container(
                color: Colors.black,
              ),
            ),
          ),
          _controller != null && _controller!.value.isInitialized
              ? SizedBox()
              : buildLoading(),
          widget.basePath == "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}"
              ? GestureDetector(
            onLongPressUp: () {
              _controller!.play();
            },
            onLongPress: () {
              _controller!.pause();
            },
            onTap: () {
              setState(() {
                Constants.isClicked = !Constants.isClicked;
                if (widget.listener != null) {
                  widget.listener
                      .onPlayingChange(_controller!.value.isPlaying);
                }
              });
            },
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomCenter,
                        stops: [
                          0,
                          0.21
                        ],
                        colors: [
                          Colors.black.withOpacity(0.23),
                          Colors.transparent,
                        ])),
              ),
            ),
          )
              : GestureDetector(
            onLongPressUp: () {
              _controller!.play();
            },
            onLongPress: () {
              _controller!.pause();
            },
            onTap: () {
              setState(() {
                Constants.isClicked = !Constants.isClicked;
                if (widget.listener != null) {
                  widget.listener
                      .onPlayingChange(_controller!.value.isPlaying);
                }
              });
            },
            child: Container(
              /*decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomCenter,
                      stops: [0, 0.21],
                      colors: [
                        Colors.black.withOpacity(0.23),
                        Colors.transparent,
                      ])),*/
            ),
          ),
          widget.basePath == "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}"
              ? GestureDetector(
            onLongPressUp: () {
              _controller!.play();
            },
            onLongPress: () {
              _controller!.pause();
            },
            onTap: () {
              setState(() {
                Constants.isClicked = !Constants.isClicked;
                if (widget.listener != null) {
                  widget.listener
                      .onPlayingChange(_controller!.value.isPlaying);
                }
              });
            },
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.15),
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomRight,
                          stops: [0, 0.2, 0.8, 1]))),
            ),
          )
              : GestureDetector(
            onLongPressUp: () {
              _controller!.play();
            },
            onLongPress: () {
              _controller!.pause();
            },
            onTap: () {
              setState(() {
                Constants.isClicked = !Constants.isClicked;
                if (widget.listener != null) {
                  widget.listener
                      .onPlayingChange(_controller!.value.isPlaying);
                }
              });
            },
            child: Container(
              /*decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black
                              .withOpacity(0.05),
                          Colors.black
                              .withOpacity(0.15),
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomRight,
                        stops: [0, 0.2, 0.8, 1]))*/
            ),
          ),
          _controller != null &&
              !_controller!.value.isPlaying &&
              _controller!.value.isInitialized
              ? Center(
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black12,
              mini: true,
              onPressed: () async {
                if (_controller != null) {
                  await _controller!.seekTo(Duration.zero);
                }
                setState(() {
                  isAfterDownLoading = true;
                  widget.isPaused = false;
                  Constants.playing = true;
                });
              },
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 50,
              ),
            ),
          )
              : InkWell(
              onTap: () async {
                setState(() {
                  widget.isPaused = true;
                  Constants.playing = false;
                });
              },
              child: Container(height: 50, width: 50))
        ],
      ),
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading ? LoadingView() : SizedBox.shrink(),
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   isAfterDownLoading = false;
  //   if(_controller != null) {
  //     _controller.pause();
  //   }
  //   _controller.dispose();
  //   _controller = null;
  // }

  void onPause(bool status) {
    if (_controller != null) {
      if (status) {
        if (this.mounted) {
          isAfterDownLoading = false;
          setState(() {
            Constants.playing = false;
          });
        }
      } else {
        if (this.mounted) {
          setState(() {
            Constants.playing = true;
          });
        }
      }
      // status ? _controller.pause() : _controller.play();
    } else {
      _controller = null;
      isAfterDownLoading = false;
    }
  }

  void onPlayCheck() {
    if (_controller != null &&
        widget.isPaused &&
        widget.index == widget.currentPageIndex) {
      _controller!.play();
    }
  }

  bool onIsPlaying() {
    if (_controller != null) {
      return _controller!.value.isPlaying;
    } else {
      return false;
    }
  }

  void onMute(bool status) {
    if (_controller != null && _controller!.value.isPlaying) {
      status ? _controller!.setVolume(0) : _controller!.setVolume(1);
    } else {
      widget.isMute = !status;
    }
  }
}
