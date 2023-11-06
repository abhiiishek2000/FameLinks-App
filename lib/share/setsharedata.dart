import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../databse/currentvideo.dart';
import '../databse/localdata.dart';
import '../networking/config.dart';
import '../ui/home_feed/provider/home_feed_provider.dart';
import '../ui/home_feed/view/main_feed_screen.dart';

class Setsharedata {
  ApiProvider api = ApiProvider();
  setfamelink(List<String> data, context) async {
    Map<String, dynamic> famelist = {
      "_id": data[3].replaceAll("%20", " "),
      "description": data[4].replaceAll("%20", " "),
      "district": data[5].replaceAll("%20", " "),
      "state": data[6].replaceAll("%20", " "),
      "country": data[7].replaceAll("%20", " "),
      "likes0Count": int.parse(data[8].toString()),
      "likes1Count": int.parse(data[9].toString()),
      "likes2Count": int.parse(data[10].toString()),
      "commentsCount": int.parse(data[11].toString()),
      "createdAt": "2023-04-19T05:40:03.936Z",
      "updatedAt": "2023-04-19T05:40:03.936Z",
      "user": {
        "_id": data[14].replaceAll("%20", " "),
        "name": data[15].replaceAll("%20", " "),
        "type": data[16].replaceAll("%20", " "),
        "username": data[17].replaceAll("%20", " "),
        "dob": data[18].replaceAll("%20", " "),
        "bio": data[19].replaceAll("%20", " "),
        "profession": data[20].replaceAll("%20", " "),
        "profileImage": data[21].replaceAll("%20", " "),
        "profileImageType": data[22].replaceAll("%20", " ")
      },
      "challenges": [],
      "followStatus": data[24].replaceAll("%20", " "),
      "type": data[25].replaceAll("%20", " "),
      "likeStatus": data[26].replaceAll("%20", " "),
      "ambassadorTrendz": bool.fromEnvironment(data[27].toString()),
      "famelinksContest": bool.fromEnvironment(data[28].toString()),
      "media": [
        {
          "path": data[29].replaceAll("%20", " "),
          "type": data[30].replaceAll("%20", " ")
        }
      ]
    };

    List dataf = [];

    dataf.add(famelist);
    var datas = await Localdata().gethivedata("getFameLinksProfile");
    var data2 = jsonDecode(datas!);

    data2!['result'].forEach((vad) {
      dataf.add(vad);
    });
    Map<String, dynamic> data1 = {"result": dataf};
    log("mydata2  ${data1}");
    await Localdata().sethivedata(data1, "getFameLinksProfile");

    await Currentvideo.setvideoindex(0, "currentindexfame");

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => MainFeedScreen(
                  initialSelect: ProfileType.FAMELinks,
                )),
        (Route<dynamic> route) => false);

    //
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => FameLinksFeed(),
    //   ),
    // );
  }

  setfunlink(List<String> data, context) async {
    Map<String, dynamic> famelist = {
      "_id": data[3].replaceAll("%20", " "),
      "description": data[4].replaceAll("%20", " "),
      "district": data[5].replaceAll("%20", " "),
      "state": data[6].replaceAll("%20", " "),
      "country": data[7].replaceAll("%20", " "),
      "seen": 0,
      "musicName": "fd",
      "musicId": "",
      "audio": "",
      "likesCount": int.parse(data[8].toString()),
      "commentsCount": int.parse(data[9].toString()),
      "tags": [],
      "talentCategory": [],
      "createdAt": "2023-04-19T05:40:03.936Z",
      "updatedAt": "2023-04-19T05:40:03.936Z",
      "user": {
        "_id": data[12].replaceAll("%20", " "),
        "name": data[13].replaceAll("%20", " "),
        "type": data[14].replaceAll("%20", " "),
        "username": data[15].replaceAll("%20", " "),
        "dob": data[16].replaceAll("%20", " "),
        "bio": data[17].replaceAll("%20", " "),
        "profession": data[18].replaceAll("%20", " "),
        "profileImage": data[19].replaceAll("%20", " "),
        "profileImageType": data[20].replaceAll("%20", " ")
      },
      "challenges": [],
      "followStatus": data[22].replaceAll("%20", " "),
      "likeStatus": data[23].replaceAll("%20", " "),
      "media": [
        {
          "path": data[24].replaceAll("%20", " "),
          "type": data[25].replaceAll("%20", " ")
        }
      ]
    };

    List dataf = [];

    dataf.add(famelist);
    var datas = await Localdata().gethivedata("getFunLinksProfile");
    var data2 = jsonDecode(datas!);

    data2!['result'].forEach((vad) {
      dataf.add(vad);
    });
    Map<String, dynamic> data1 = {"result": dataf};
    log("mydata2  ${data1}");
    await Localdata().sethivedata(data1, "getFunLinksProfile");

    await Currentvideo.setvideoindex(0, "currentindexfun");

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => MainFeedScreen(
                  initialSelect: ProfileType.FAMELinks,
                )),
        (Route<dynamic> route) => false);

    //
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => FameLinksFeed(),
    //   ),
    // );
  }

  setfollowlink(List<String> data, context) async {
    Map<String, dynamic> famelist = {
      "_id": data[3].replaceAll("%20", " "),
      "description": data[4].replaceAll("%20", " "),
      "district": data[5].replaceAll("%20", " "),
      "state": data[6].replaceAll("%20", " "),
      "country": data[7].replaceAll("%20", " "),
      "likes0Count": int.parse(data[8].toString()),
      "likes1Count": int.parse(data[9].toString()),
      "likes2Count": int.parse(data[10].toString()),
      "commentsCount": int.parse(data[11].toString()),
      "createdAt": "2023-04-19T05:40:03.936Z",
      "updatedAt": "2023-04-19T05:40:03.936Z",
      "user": {
        "_id": data[14].replaceAll("%20", " "),
        "name": data[15].replaceAll("%20", " "),
        "type": data[16].replaceAll("%20", " "),
        "username": data[17].replaceAll("%20", " "),
        "dob": data[18].replaceAll("%20", " "),
        "bio": data[19].replaceAll("%20", " "),
        "profession": data[20].replaceAll("%20", " "),
        "profileImage": data[21].replaceAll("%20", " "),
        "profileImageType": data[22].replaceAll("%20", " ")
      },
      "challenges": [],
      "tags": [],
      "followStatus": data[24].replaceAll("%20", " "),
      "type": data[25].replaceAll("%20", " "),
      "likeStatus": data[26].replaceAll("%20", " "),
      "winnerTitles": bool.fromEnvironment(data[27].toString()),
      "media": [
        {
          "path": data[28].replaceAll("%20", " "),
          "type": data[29].replaceAll("%20", " ")
        }
      ]
    };

    List dataf = [];

    dataf.add(famelist);
    var datas = await Localdata().gethivedata("getFollowLinksProfile");
    var data2 = jsonDecode(datas!);

    data2!['result'].forEach((vad) {
      dataf.add(vad);
    });
    Map<String, dynamic> data1 = {"result": dataf};
    log("mydata2  ${data1}");
    await Localdata().sethivedata(data1, "getFollowLinksProfile");

    await Currentvideo.setvideoindex(0, "currentindexfollow");

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => MainFeedScreen(
                  initialSelect: ProfileType.FAMELinks,
                )),
        (Route<dynamic> route) => false);

    //
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => FameLinksFeed(),
    //   ),
    // );
  }
}
