import 'dart:io';

import 'package:famelink/media_compression_provider.dart';
import 'package:famelink/ui/preview.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:video_trimmer/video_trimmer.dart';

class TrimmerView extends StatefulWidget {
  final File file;

  const TrimmerView(this.file);

  @override
  _TrimmerViewState createState() => _TrimmerViewState();
}

class _TrimmerViewState extends State<TrimmerView> {
  final Trimmer _trimmer = Trimmer();

  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;

  @override
  void initState() {
    super.initState();

    _loadVideo();
  }

  void _loadVideo() {
    _trimmer.loadVideo(videoFile: widget.file);
  }

  Future<String?> _saveVideo() async {
    setState(() {
      _progressVisibility = true;
    });

    String _value;

    await _trimmer
        .saveTrimmedVideo(
        startValue: _startValue,
        endValue: _endValue,
        storageDir: StorageDir.externalStorageDirectory,
        videoFileName: basename(widget.file.path).replaceFirst(".mp4", ""),
        onSave: (String? outputPath) {})
        .then((value) {
      setState(() {
        _progressVisibility = false;
      });
    });

    //return _value;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return false;
        } else {
          return true;
        }
      },
      child: Consumer<MediaCompressionProvider>(builder: (context,provider,child){
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            title: const Text("Video Trimmer"),
            actions: [
              IconButton(
                  onPressed: _progressVisibility
                      ? null
                      : () async {
                    setState(() {
                      _progressVisibility = true;
                    });
                    await _trimmer.saveTrimmedVideo(
                        startValue: _startValue,
                        endValue: _endValue,
                        storageDir: Platform.isAndroid
                            ? StorageDir.externalStorageDirectory
                            : StorageDir.temporaryDirectory,
                        videoFileName: basename(widget.file.path+"${DateTime.now().millisecondsSinceEpoch}")
                            .replaceFirst(".mp4", ""),
                        onSave: (outputPath) {
                          setState(() {
                            _progressVisibility = false;
                          });
                          print("OUTPUT:::${outputPath!}");
                          Navigator.pop(context, outputPath);
                        });
                  },
                  icon: Icon(Icons.done, color: Colors.white))
            ],
          ),
          body: Builder(
            builder: (context) => Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Visibility(
                        visible: provider.isLoading || _progressVisibility,
                        child: const LinearProgressIndicator(
                          backgroundColor: Colors.red,
                        ),
                      ),
                      Expanded(
                        child: VideoViewer(trimmer: _trimmer),
                      ),
                      Center(
                        child: TrimEditor(
                          trimmer: _trimmer,
                          viewerHeight: 50.0,
                          viewerWidth: MediaQuery.of(context).size.width,
                          maxVideoLength: const Duration(seconds: 30),
                          onChangeStart: (value) {
                            _startValue = value;
                          },
                          onChangeEnd: (value) {
                            _endValue = value;
                          },
                          onChangePlaybackState: (value) {
                            setState(() {
                              _isPlaying = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: TextButton(
                    child: _isPlaying
                        ? const Icon(
                      Icons.pause,
                      size: 80.0,
                      color: Colors.white,
                    )
                        : const Icon(
                      Icons.play_arrow,
                      size: 80.0,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      bool playbackState = await _trimmer.videPlaybackControl(
                        startValue: _startValue,
                        endValue: _endValue,
                      );
                      setState(() {
                        _isPlaying = playbackState;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}