// To parse this JSON data, do
//
//     final followLinkUserProfileModel = followLinkUserProfileModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

FollowLinkUserProfileModel followLinkUserProfileModelFromJson(String str) => FollowLinkUserProfileModel.fromJson(json.decode(str));

String followLinkUserProfileModelToJson(FollowLinkUserProfileModel data) => json.encode(data.toJson());

class FollowLinkUserProfileModel {
  FollowLinkUserProfileModel({
    this.result,
    this.message,
    this.success,
  });

  List<FollowLinksResult>? result;
  String? message;
  bool? success;

  factory FollowLinkUserProfileModel.fromJson(Map<String, dynamic> json) => FollowLinkUserProfileModel(
    result: List<FollowLinksResult>.from(json["result"].map((x) => FollowLinksResult.fromJson(x))),
    message: json["message"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message,
    "success": success,
  };
}

class FollowLinksResult {
  FollowLinksResult({
    this.id,
    this.description,
    this.district,
    this.state,
    this.country,
    this.likes0Count,
    this.likes1Count,
    this.NewPostsAvailable,
    this.likes2Count,
    this.commentsCount,
    this.createdAt,
    this.updatedAt,
    this.challenges,
    this.followStatus,
    this.likeStatus,
    this.media,
    this.type,
    this.winnerTitles,
    this.likesCount,
    this.tags,
    this.isWelcomeVideo,
    this.user,
  });

  String? id;
  String? description;
  String? district;
  String? state;
  Country? country;
  int? likes0Count;
  int? likes1Count;
  bool? NewPostsAvailable;
  int? likes2Count;
  int? commentsCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Challenge>? challenges;
  String? followStatus;
  dynamic likeStatus;
  List<Media>? media;
  String? type;
  List<dynamic>? winnerTitles;
  int? likesCount;
  List<Tag>? tags;
  int? isWelcomeVideo;
  User? user;

  factory FollowLinksResult.fromJson(Map<String, dynamic> json) => FollowLinksResult(
    id: json["_id"],
    description: json["description"] == null ? null : json["description"],
    district: json["district"],
    state: json["state"] == null ? null : json["state"],
    country: json["country"] == null ? null : countryValues.map[json["country"]],
    likes0Count: json["likes0Count"] == null ? null : json["likes0Count"],
    likes1Count: json["likes1Count"] == null ? null : json["likes1Count"],
    NewPostsAvailable: json["NewPostsAvailable"] == null ? null : json["NewPostsAvailable"],
    likes2Count: json["likes2Count"] == null ? null : json["likes2Count"],
    commentsCount: json["commentsCount"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    challenges: List<Challenge>.from(json["challenges"].map((x) => Challenge.fromJson(x))),
    followStatus: json["followStatus"],
    likeStatus: json["likeStatus"],
    media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
    type: json["type"],
    winnerTitles: json["winnerTitles"] == null ? null : List<dynamic>.from(json["winnerTitles"].map((x) => x)),
    likesCount: json["likesCount"] == null ? null : json["likesCount"],
    tags: json["tags"] == null ? null : List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
    isWelcomeVideo: json["isWelcomeVideo"] == null ? null : json["isWelcomeVideo"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "description": description == null ? null : description,
    "district": district,
    "state": state == null ? null : state,
    "country": country == null ? null : countryValues.reverse![country],
    "likes0Count": likes0Count == null ? null : likes0Count,
    "likes1Count": likes1Count == null ? null : likes1Count,
    "NewPostsAvailable": NewPostsAvailable == null ? null : NewPostsAvailable,
    "likes2Count": likes2Count == null ? null : likes2Count,
    "commentsCount": commentsCount,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "challenges": List<dynamic>.from(challenges!.map((x) => x.toJson())),
    "followStatus": followStatus,
    "likeStatus": likeStatus,
    "media": List<dynamic>.from(media!.map((x) => x.toJson())),
    //"type": resultTypeValues.reverse[type],
    "winnerTitles": winnerTitles == null ? null : List<dynamic>.from(winnerTitles!.map((x) => x)),
    "likesCount": likesCount == null ? null : likesCount,
    "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x.toJson())),
    "isWelcomeVideo": isWelcomeVideo == null ? null : isWelcomeVideo,
    "user": user == null ? null : user!.toJson(),
  };
}

class Challenge {
  Challenge({
    this.id,
    this.hashTag,
  });

  String? id;
  String? hashTag;

  factory Challenge.fromJson(Map<String, dynamic> json) => Challenge(
    id: json["_id"],
    hashTag: json["hashTag"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "hashTag": hashTag,
  };
}

enum Country { INDIA, QDQEFDQF }

final countryValues = EnumValues({
  "india": Country.INDIA,
  "qdqefdqf": Country.QDQEFDQF
});

class Media {
  Media({
    this.path,
    this.type,
  });

  String? path;
  String? type;
  Image? image;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    path: json["path"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "path": path,
    //"type": mediaTypeValues.reverse[type],
  };
}

//enum MediaType { VIDEO, CLOSE_UP, IMAGE }

// final mediaTypeValues = EnumValues({
//   "closeUp": MediaType.CLOSE_UP,
//   "image": MediaType.IMAGE,
//   "video": MediaType.VIDEO
// });

class Tag {
  Tag({
    this.id,
    this.username,
  });

  String? id;
  String? username;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json["_id"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
  };
}

enum ResultType { FAMELINKS, FOLLOWLINKS ,FUNLINKS}

// final resultTypeValues = EnumValues({
//   "famelinks": ResultType.FAMELINKS,
//   "followlinks": ResultType.FOLLOWLINKS,
//   "funlinks": ResultType.FUNLINKS
// });

class User {
  User({
    this.id,
    this.name,
    this.type,
    this.username,
    this.dob,
    this.bio,
    this.profession,
    this.profileImage,
    this.avatarImage,
    this.profileImageType,
  });

  String? id;
  String? name;
  String? type;
  String? username;
  DateTime? dob;
  String? bio;
  String? profession;
  String? profileImage;
  String? avatarImage;
  dynamic profileImageType;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    type: json["type"],
    username: json["username"],
    dob: DateTime.parse(json["dob"]),
    bio: json["bio"] == null ? null : json["bio"],
    profession: json["profession"] == null ? null : json["profession"],
    profileImage: json["profileImage"] == null ? null : json["profileImage"],
    avatarImage: json["avatarImage"] == null ? null : json["avatarImage"],
    profileImageType: json["profileImageType"] == null ? null : json["profileImageType"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "type": type,
    "username": username,
    "dob": dob!.toIso8601String(),
    "bio": bio == null ? null : bio,
    "profession": profession == null ? null : profession,
    "profileImage": profileImage == null ? null : profileImage,
    "avatarImage": avatarImage == null ? null : avatarImage,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
