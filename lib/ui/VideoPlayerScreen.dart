// import 'package:famelink/util/loading_view.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:video_player/video_player.dart';
//
// import '../networking/config.dart';
//
// class VideoPlayerScreen extends StatefulWidget {
//   int index;
//   int verticalIndex;
//   int currentPageIndex;
//   int currentVerticalPageIndex;
//   bool isMute;
//   String _videos;
//   String basePath;
//   bool isPaused;
//   OnVideoScreenListener listener;
//
//
//   VideoPlayerScreen(this._videos, this.basePath, this.index,this.currentPageIndex, this.listener,this.verticalIndex,this.currentVerticalPageIndex,this.isMute,
//       this.videoController,this.isPaused);
//
//   @override
//   _VideoPlayerState createState() => _VideoPlayerState();
// }
//
// abstract class OnVideoScreenListener {
//   void onProfileClick();
//   void onPlayingChange(bool isPlaying);
// }
//
// class _VideoPlayerState extends State<VideoPlayerScreen>{
//   VideoPlayerController?  _controller;
//
//   bool isLiked = false;
//   bool isLoading = true;
//   bool initialized = false;
//   bool _isPlaying = false;
//   bool isAfterDownLoading = true;
//   bool isFollow = false;
//
//   SharedPreferences? sharedPreferences;
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     widget.videoController.onPause = onPause;
//     widget.videoController.onPlayCheck = onPlayCheck;
//     widget.videoController.onIsPlaying = onIsPlaying;
//     widget.videoController.onMute = onMute;
//     downloadFile();
//   }
//   /*@override
//   void didUpdateWidget(VideoPlayerScreen oldWidget) {
//     if (oldWidget.isMute != widget.isMute) {
//       if (widget.isMute) {
//         _controller.play();
//       } else {
//         _controller.pause();
//       }
//     }
//     super.didUpdateWidget(oldWidget);
//   }*/
//   Future<void> downloadFile() async {
//     // sharedPreferences = await SharedPreferences.getInstance();
//     // var dir = await getApplicationDocumentsDirectory();
//     // DateTime dateTime = DateTime.now();
//     // print("TIME:::${dateTime.millisecondsSinceEpoch}");
//     // if (sharedPreferences.getInt("Time") != null) {
//     //   DateTime _pickedDate =
//     //       DateTime.fromMillisecondsSinceEpoch(sharedPreferences.getInt("Time"));
//     //
//     //   print(dateTime.difference(_pickedDate).inDays);
//     //   if (dateTime.difference(_pickedDate).inDays >= 1) {
//     //     dir.deleteSync(recursive: true);
//     //   }
//     // }
//     // bool fileExists = await File("${dir.path}/${widget._videos}").exists();
//     _controller =
//     VideoPlayerController.network(widget.basePath.isNotEmpty ? "${widget.basePath}/${widget._videos}":widget._videos)
//       ..addListener(() {
//         if(_controller!.value.position == _controller!.value.duration) {
//           print('video Ended');
//           if(mounted) {
//             setState(() {
//               _isPlaying = false;
//             });
//           }
//         }
//       })
//       ..initialize().then((_) {
//         setState(() {
//           if(_controller != null) {
//             _controller!.setLooping(true);
//             initialized = true;
//           }
//           isLoading = false;
//           _isPlaying = true;
//         });
//       });
//     /*if (fileExists) {
//       _controller =
//           VideoPlayerController.file(File("${dir.path}/${widget._videos}"))
//             ..addListener(() {
//               if(_controller.value.position == _controller.value.duration) {
//                 print('video Ended');
//                 if(mounted) {
//                   setState(() {
//                     _isPlaying = false;
//                   });
//                 }
//               }
//             })
//             ..initialize().then((_) {
//               if(mounted) {
//                 setState(() {
//                   if(_controller != null) {
//                     _controller.setLooping(false);
//                     if(widget.isMute){
//                       _controller.setVolume(1);
//                     }else{
//                       _controller.setVolume(0);
//                     }
//                     initialized = true;
//                     // _controller.play();
//                   }
//                   isLoading = false;
//                   _isPlaying = true;
//                 });
//               }
//             });
//     } else {
//       sharedPreferences.setInt("Time", DateTime.now().millisecondsSinceEpoch);
//       Dio dio = Dio();
//
//       try {
//         print("path ${dir.path}");
//         unawaited(dio.download("${widget.basePath}/${widget._videos}",
//             "${dir.path}/${widget._videos}", onReceiveProgress: (rec, total) {
//               print("Rec: $rec , Total: $total");
//               if(rec == total){
//
//                 print("Download completed");
//               }
//             }));
//           _controller =
//           VideoPlayerController.network("${widget.basePath}/${widget._videos}")
//             ..addListener(() {
//               if(_controller.value.position == _controller.value.duration) {
//                 print('video Ended');
//                 if(mounted) {
//                   setState(() {
//                     _isPlaying = false;
//                   });
//                 }
//               }
//             })
//             ..initialize().then((_) {
//               if(mounted) {
//                 setState(() {
//                   if(_controller != null) {
//                     _controller.setLooping(false);
//                     if(widget.isMute){
//                       _controller.setVolume(1);
//                     }else{
//                       _controller.setVolume(0);
//                     }
//                     initialized = true;
//                     // _controller.play();
//                   }
//                   isLoading = false;
//                   _isPlaying = true;
//                 });
//               }
//             });
//
//       } catch (e) {
//         print(e);
//       }
//     }*/
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     debugPrint("IND_VIDEO::${widget.index}:::${widget.currentPageIndex}");
//     if (widget.index == widget.currentPageIndex && widget.verticalIndex == widget.currentVerticalPageIndex &&
//         !widget.isPaused &&
//         initialized && _isPlaying && isAfterDownLoading) {
//       if(widget.isMute){
//         _controller!.setVolume(1);
//         // _controller.play();
//       }else{
//         // _controller.pause();
//         _controller!.setVolume(0);
//       }
//       _controller!.play();
//     } else {
//       if(_controller != null && _controller!.value.isPlaying) {
//         _controller!.pause();
//       }
//     }
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         alignment: Alignment.center,
//         children: <Widget>[
//           GestureDetector(
//             onLongPressUp: (){
//               isAfterDownLoading = true;
//               _controller!.play();
//             },
//             onLongPress: () {
//               _controller!.pause();
//             },
//             onTap: () {
//               if (widget.listener != null) {
//                 widget.listener.onProfileClick();
//               }
//             },
//             child: Center(
//               child:
//               _controller != null && _controller!.value.isInitialized
//                   ? AspectRatio(
//                 aspectRatio: _controller!.value.aspectRatio,
//                 child: VideoPlayer(_controller!),
//               )
//                   : Container(
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           _controller != null && _controller!.value.isInitialized
//               ? SizedBox()
//               : buildLoading(),
//           widget.basePath == "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}"?GestureDetector(
//             onLongPressUp: () {
//               _controller!.play();
//             },
//             onLongPress: () {
//               _controller!.pause();
//             },
//             onTap: () {
//               setState(() {
//                 if (widget.listener != null) {
//                   widget.listener.onPlayingChange(_controller!.value.isPlaying);
//                 }
//               });
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                       begin: Alignment.topRight,
//                       end: Alignment.bottomCenter,
//                       stops: [0, 0.21],
//                       colors: [
//                         Colors.black.withOpacity(0.23),
//                         Colors.transparent,
//                       ])),
//             ),
//           ):GestureDetector(
//             onLongPressUp: () {
//               _controller!.play();
//             },
//             onLongPress: () {
//               _controller!.pause();
//             },
//             onTap: () {
//               setState(() {
//                 if (widget.listener != null) {
//                   widget.listener.onPlayingChange(_controller!.value.isPlaying);
//                 }
//               });
//             },
//             child: Container(
//               /*decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                       begin: Alignment.topRight,
//                       end: Alignment.bottomCenter,
//                       stops: [0, 0.21],
//                       colors: [
//                         Colors.black.withOpacity(0.23),
//                         Colors.transparent,
//                       ])),*/
//             ),
//           ),
//           widget.basePath == "${ApiProvider.s3UrlPath}/${ApiProvider.funlinks}"?GestureDetector(
//             onLongPressUp: () {
//               _controller!.play();
//             },
//             onLongPress: () {
//               _controller!.pause();
//             },
//             onTap: () {
//               setState(() {
//                 if (widget.listener != null) {
//                   widget.listener.onPlayingChange(_controller!.value.isPlaying);
//                 }
//               });
//             },
//             child: Container(
//                 decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                         colors: [
//                           Colors.transparent,
//                           Colors.transparent,
//                           Colors.black
//                               .withOpacity(0.05),
//                           Colors.black
//                               .withOpacity(0.15),
//                         ],
//                         begin: Alignment.topRight,
//                         end: Alignment.bottomRight,
//                         stops: [0, 0.2, 0.8, 1]))),
//           ):GestureDetector(
//             onLongPressUp: () {
//               _controller!.play();
//             },
//             onLongPress: () {
//               _controller!.pause();
//             },
//             onTap: () {
//               setState(() {
//                 if (widget.listener != null) {
//                   widget.listener.onPlayingChange(_controller!.value.isPlaying);
//                 }
//               });
//             },
//             child: Container(
//                 /*decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                         colors: [
//                           Colors.transparent,
//                           Colors.transparent,
//                           Colors.black
//                               .withOpacity(0.05),
//                           Colors.black
//                               .withOpacity(0.15),
//                         ],
//                         begin: Alignment.topRight,
//                         end: Alignment.bottomRight,
//                         stops: [0, 0.2, 0.8, 1]))*/),
//           ),
//           Visibility(
//               visible:_controller != null && !_controller!.value.isPlaying && _controller!.value.isInitialized,
//               child: Center(
//                 child: FloatingActionButton(
//                   backgroundColor: Colors.transparent,
//                   foregroundColor: Colors.black12,
//                   mini: true,
//                   onPressed: () async {
//                     if(_controller != null) {
//                       await _controller!.seekTo(Duration.zero);
//                     }
//                     setState(() {
//                       isAfterDownLoading = true;
//                       widget.isPaused = false;
//                       _isPlaying = true;
//                     });
//                   },
//                   child: Icon(
//                     Icons.play_arrow,
//                     color: Colors.white,
//                     size: 50,
//                   ),
//                 ),
//               ))
//         ],
//       ),
//     );
//   }
//
//   Widget buildLoading() {
//     return Positioned(
//       child: isLoading ? LoadingView() : SizedBox.shrink(),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     isAfterDownLoading = false;
//     if(_controller != null) {
//       _controller!.pause();
//     }
//     _controller!.dispose();
//     _controller = null;
//   }
//
//   void onPause(bool status) {
//     if (_controller != null) {
//       if(status){
//         if(this.mounted) {
//           isAfterDownLoading = false;
//           setState(() {
//             _isPlaying = false;
//           });
//         }
//       }else{
//         if(this.mounted) {
//           setState(() {
//             _isPlaying = true;
//           });
//         }
//       }
//       // status ? _controller.pause() : _controller.play();
//     }else{
//       _controller = null;
//       isAfterDownLoading = false;
//     }
//   }
//
//   void onPlayCheck() {
//     if (_controller != null && widget.isPaused && widget.index == widget.currentPageIndex) {
//       _controller!.play();
//     }
//   }
//
//   bool onIsPlaying() {
//     if (_controller != null) {
//       return _controller!.value.isPlaying;
//     }else{
//       return false;
//     }
//   }
//
//   void onMute(bool status) {
//     if(_controller != null && _controller!.value.isPlaying) {
//       status ? _controller!.setVolume(0) : _controller!.setVolume(1);
//     }else{
//       widget.isMute = !status;
//     }
//   }
// }
