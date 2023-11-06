import 'dart:convert';

import 'package:flutter/material.dart';

FameLinkUserProfileModel fameLinkUserProfileModelFromJson(String str) =>
    FameLinkUserProfileModel.fromJson(json.decode(str));

String fameLinkUserProfileModelToJson(FameLinkUserProfileModel data) =>
    json.encode(data.toJson());

class FameLinkUserProfileModel {
  FameLinkUserProfileModel({
    this.result,
    this.message,
    this.success,
  });

  List<FameLinkUserProfileModelResult>? result;

  String? message;
  bool? success;

  factory FameLinkUserProfileModel.fromJson(Map<String, dynamic> json) =>
      FameLinkUserProfileModel(
        result: List<FameLinkUserProfileModelResult>.from(json["result"]
            .map((x) => FameLinkUserProfileModelResult.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "message": message,
        "success": success,
      };
}

class FameLinkUserProfileModelResult {
  FameLinkUserProfileModelResult(
      {this.id,
      this.description,
      this.district,
      this.state,
      this.country,
      this.likes0Count,
      this.NewPostsAvailable,
      this.likes1Count,
      this.likes2Count,
      this.commentsCount,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.challenges,
      this.type,
      this.followStatus,
      this.likeStatus,
      this.ambassadorTrendz,
      this.famelinksContest,
      this.media,
      this.purchaseUrl,
      this.buttonName,
      this.name,
      this.hashTag,
      this.price,
      this.tags,
      this.winnerTitles});

  String? id;
  String? description;
  String? district;
  String? state;
  Country? country;
  int? likes0Count;
  bool? NewPostsAvailable;
  int? likes1Count;
  int? likes2Count;
  int? commentsCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  List<Challenge>? challenges;
  String? type;
  String? followStatus;
  dynamic likeStatus;
  bool? ambassadorTrendz;
  bool? famelinksContest;
  List<Media>? media;
  String? purchaseUrl;
  String? buttonName;
  String? name;
  List<String>? hashTag;
  int? price;
  int? tags;
  List<String>? winnerTitles;

  factory FameLinkUserProfileModelResult.fromJson(Map<String, dynamic> json) =>
      FameLinkUserProfileModelResult(
        id: json["_id"],
        description: json["description"],
        district: json["district"],
        state: json["state"],
        country: countryValues.map[json["country"]],
        likes0Count: json["likes0Count"],
        NewPostsAvailable: json["NewPostsAvailable"],
        likes1Count: json["likes1Count"],
        likes2Count: json["likes2Count"],
        commentsCount: json["commentsCount"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        challenges: json["challenges"] == null
            ? null
            : List<Challenge>.from(
                json["challenges"].map((x) => Challenge.fromJson(x))),
        type: json["type"],
        followStatus: json["followStatus"],
        likeStatus: json["likeStatus"],
        ambassadorTrendz: json["ambassadorTrendz"],
        famelinksContest: json["famelinksContest"],
        media: json["media"] == null
            ? null
            : List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
        purchaseUrl: json['purchaseUrl'],
        buttonName: json['buttonName'],
        name: json['name'],
        hashTag:
            json["hashTag"] == null ? null : List<String>.from(json["hashTag"]),
        price: json['price'],
        tags: json['tags'],
        winnerTitles: json["winnerTitles"] == null
            ? null
            : List<String>.from(json["winnerTitles"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "description": description,
        "district": district,
        "state": state,
        "country": countryValues.reverse![country],
        "likes0Count": likes0Count,
        "NewPostsAvailable": NewPostsAvailable,
        "likes1Count": likes1Count,
        "likes2Count": likes2Count,
        "commentsCount": commentsCount,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "user": user == null ? null : user!.toJson(),
        "challenges": List<dynamic>.from(challenges!.map((x) => x.toJson())),
        "type": type,
        "followStatus": followStatus,
        "likeStatus": likeStatus,
        "ambassadorTrendz": ambassadorTrendz,
        "famelinksContest": famelinksContest,
        "media": List<dynamic>.from(media!.map((x) => x.toJson())),
        'purchaseUrl': this.purchaseUrl,
        'buttonName': this.buttonName,
        'name': this.name,
        'hashTag': this.hashTag,
        'price': this.price,
        'tags': this.tags,
        'winnerTitles': this.winnerTitles,
      };

  static List<FameLinkUserProfileModelResult> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<FameLinkUserProfileModelResult>(
              (item) => FameLinkUserProfileModelResult.fromJson(item))
          .toList();
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

enum Country { INDIA }

final countryValues = EnumValues({"india": Country.INDIA});

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
        "type": type,
      };
}

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
    this.profileImageType,
  });

  String? id;
  String? name;
  String? type;
  String? username;
  dynamic dob;
  dynamic bio;
  dynamic profession;
  dynamic profileImage;
  dynamic profileImageType;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        type: json["type"],
        username: json["username"],
        dob: json["dob"],
        bio: json["bio"],
        profession: json["profession"],
        profileImage: json["profileImage"],
        profileImageType: json["profileImageType"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "type": type,
        "username": username,
        "dob": dob,
        "bio": bio,
        "profession": profession,
        "profileImage": profileImage,
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
