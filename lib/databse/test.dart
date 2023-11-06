import 'package:flutter/material.dart';

import 'filesavecache.dart';

class testApk extends StatefulWidget {
  const testApk({Key? key}) : super(key: key);

  @override
  State<testApk> createState() => _testApkState();
}

class _testApkState extends State<testApk> {
  List data = ["a", "b", "c", "d", "e"];
  int a = 0;
  String? path;
  @override
  Widget build(BuildContext context) {
    Filecache()
        .getcache("https://mirchistatus.com/files/download/id/60014")
        .then((value) {
      path = value;
    });

    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
            onPageChanged: (value) {
              print(value);
            },
            scrollDirection: Axis.vertical,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int i) {
              return Column(
                children: [
                  Text("index $i"),
                  ElevatedButton(
                      onPressed: () {
                        var b = ["j", "kl"];

                        data.addAll(b);
                        a++;
                        setState(() {});
                      },
                      child: Text("add"))
                ],
              );
            }),
        // child: SingleChildScrollView(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       ElevatedButton(
        //           onPressed: () {
        //             Filecache().savecache(
        //                 "https://mirchistatus.com/files/download/id/60014");
        //           },
        //           child: Text('data')),
        //       ElevatedButton(
        //           onPressed: () {
        //             // Singledownload().singledownloads();
        //             // Filecache().getcache(
        //             //     "https://mirchistatus.com/files/download/id/60014");
        //
        //             FameLinksFeedProvider().getFameLinkFeedData(context);
        //           },
        //           child: Text('getdata')),
        //       // FeedVideoPlayer(
        //       //     videoUrl:
        //       //         "/data/user/0/app.famelinks/cache/libCachedImageData/c520b500-df31-11ed-a37b-034a449e40c7.bin")
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
