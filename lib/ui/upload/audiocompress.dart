import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../media_compression_provider.dart';

class AudioCompess extends StatefulWidget {
  const AudioCompess({super.key});

  @override
  State<AudioCompess> createState() => _AudioCompessState();
}

class _AudioCompessState extends State<AudioCompess> {
  filepic() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files![0].path!);

      MediaCompressionProvider().compressAudio(context, file,
          onSave: (String? outputPath) async {
        print("value2 $outputPath");
        final player = AudioPlayer();
        await player.play(outputPath!);
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  filepic();
                },
                child: Text("picker"))
          ],
        ),
      ),
    );
  }
}
