// To parse this JSON data, do
//
//     final collabs = collabsFromJson(jsonString);

import 'dart:convert';

Collabs collabsFromJson(String str) => Collabs.fromJson(json.decode(str));

String collabsToJson(Collabs data) => json.encode(data.toJson());

class Collabs {
  Collabs({
    this.result,
    this.message,
    this.success,
  });

  List<CollabData>? result;
  String? message;
  bool? success;

  factory Collabs.fromJson(Map<String, dynamic> json) => Collabs(
    result: List<CollabData>.from(json["result"].map((x) => CollabData.fromJson(x))),
    message: json["message"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message,
    "success": success,
  };
}

class CollabData {
  CollabData({
    this.id,
    this.name,
    this.bio,
    this.profileImage,
    this.restrictedList,
    this.isRegistered,
    this.isBlocked,
    this.isDeleted,
    this.url,
    this.masterUser,
    this.funlinksPosts,
    this.followlinksPosts,
    this.trendzsSponsored,
    this.followStatus,
    this.brandCollabs,
    this.userCollabs,
    this.recommendations,
    this.collabs,
    this.chatId,
  });

  String? id;
  String? name;
  dynamic bio;
  dynamic profileImage;
  List<dynamic>? restrictedList;
  bool? isRegistered;
  bool? isBlocked;
  bool? isDeleted;
  String? url;
  MasterUser? masterUser;
  List<FunlinksPost>? funlinksPosts;
  List<FollowlinksPost>? followlinksPosts;
  List<dynamic>? trendzsSponsored;
  String? followStatus;
  List<Collab>? brandCollabs;
  List<Collab>? userCollabs;
  int? recommendations;
  int? collabs;
  dynamic chatId;

  factory CollabData.fromJson(Map<String, dynamic> json) => CollabData(
    id: json["_id"],
    name: json["name"],
    bio: json["bio"],
    profileImage: json["profileImage"],
    restrictedList: List<dynamic>.from(json["restrictedList"].map((x) => x)),
    isRegistered: json["isRegistered"],
    isBlocked: json["isBlocked"],
    isDeleted: json["isDeleted"],
    url: json["url"],
    masterUser: MasterUser.fromJson(json["masterUser"]),
    funlinksPosts: json["funlinksPosts"]!=null?List<FunlinksPost>.from(json["funlinksPosts"].map((x) => FunlinksPost.fromJson(x))):[],
    followlinksPosts: json["followlinksPosts"]!=null?List<FollowlinksPost>.from(json["followlinksPosts"].map((x) => FollowlinksPost.fromJson(x))):[],
    trendzsSponsored: List<dynamic>.from(json["trendzsSponsored"].map((x) => x)),
    followStatus: json["followStatus"],
    brandCollabs: List<Collab>.from(json["brandCollabs"].map((x) => Collab.fromJson(x))),
    userCollabs: List<Collab>.from(json["userCollabs"].map((x) => Collab.fromJson(x))),
    recommendations: json["recommendations"],
    collabs: json["Collabs"],
    chatId: json["chatId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "bio": bio,
    "profileImage": profileImage,
    "restrictedList": List<dynamic>.from(restrictedList!.map((x) => x)),
    "isRegistered": isRegistered,
    "isBlocked": isBlocked,
    "isDeleted": isDeleted,
    "url": url,
    "masterUser": masterUser!.toJson(),
    "funlinksPosts": List<dynamic>.from(funlinksPosts!.map((x) => x.toJson())),
    "followlinksPosts": List<dynamic>.from(followlinksPosts!.map((x) => x.toJson())),
    "trendzsSponsored": List<dynamic>.from(trendzsSponsored!.map((x) => x)),
    "followStatus": followStatus,
    "brandCollabs": List<dynamic>.from(brandCollabs!.map((x) => x.toJson())),
    "userCollabs": List<dynamic>.from(userCollabs!.map((x) => x.toJson())),
    "recommendations": recommendations,
    "Collabs": collabs,
    "chatId": chatId,
  };
}

class Collab {
  Collab({
    this.id,
    this.userId,
    this.type,
    this.profileImage,
  });

  String? id;
  String? userId;
  String? type;
  String? profileImage;

  factory Collab.fromJson(Map<String, dynamic> json) => Collab(
    id: json["_id"],
    userId: json["userId"],
    type: json["type"],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "type": type,
    "profileImage": profileImage,
  };
}

class FollowlinksPost {
  FollowlinksPost({
    this.id,
    this.media,
    this.status,
  });

  String? id;
  List<String>? media;
  bool? status;

  factory FollowlinksPost.fromJson(Map<String, dynamic> json) => FollowlinksPost(
    id: json["_id"],
    media: List<String>.from(json["media"].map((x) => x)),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "media": List<dynamic>.from(media!.map((x) => x)),
    "status": status,
  };
}

class FunlinksPost {
  FunlinksPost({
    this.id,
    this.video,
    this.status,
  });

  String? id;
  String? video;
  bool? status;

  factory FunlinksPost.fromJson(Map<String, dynamic> json) => FunlinksPost(
    id: json["_id"],
    video: json["video"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "video": video,
    "status": status,
  };
}

class MasterUser {
  MasterUser({
    this.id,
    this.district,
    this.state,
    this.country,
    this.continent,
    this.profileImage,
    this.fameCoins,
    this.username,
  });

  String? id;
  String? district;
  String? state;
  String? country;
  dynamic continent;
  dynamic profileImage;
  int? fameCoins;
  String? username;

  factory MasterUser.fromJson(Map<String, dynamic> json) => MasterUser(
    id: json["_id"],
    district: json["district"],
    state: json["state"],
    country: json["country"],
    continent: json["continent"],
    profileImage: json["profileImage"],
    fameCoins: json["fameCoins"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "district": district,
    "state": state,
    "country": country,
    "continent": continent,
    "profileImage": profileImage,
    "fameCoins": fameCoins,
    "username": username,
  };
}
