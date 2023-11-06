// To parse this JSON data, do
//
//     final myFollowersResponse = myFollowersResponseFromJson(jsonString);

import 'dart:convert';

MyFollowersResponse myFollowersResponseFromJson(String str) => MyFollowersResponse.fromJson(json.decode(str));

String myFollowersResponseToJson(MyFollowersResponse data) => json.encode(data.toJson());

class MyFollowersResponse {
  MyFollowersResponse({
    this.result,
    this.message,
    this.success,
  });

  List<MyFollowersResult>? result;
  String? message;
  bool? success;

  factory MyFollowersResponse.fromJson(Map<dynamic, dynamic> json) => MyFollowersResponse(
    result: json["result"] == null ? null : List<MyFollowersResult>.from(json["result"].map((x) => MyFollowersResult.fromJson(x))),
    message: json["message"] == null ? null : json["message"],
    success: json["success"] == null ? null : json["success"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message == null ? null : message,
    "success": success == null ? null : success,
  };
}

class MyFollowersResult {
  MyFollowersResult({
    this.id,
    this.name,
    this.username,
    this.type,
    this.profileImage,
    this.profileImageType,
    this.district,
    this.state,
    this.country,
    this.followStatus,
    this.chatId,
    this.suggestionfollowStatus,
  });

  String? id;
  String? name;
  String? username;
  String? type;
  String? profileImage;
  String? profileImageType;
  String? district;
  String? state;
  String? country;
  String? followStatus;
  String? suggestionfollowStatus;
  String? chatId;

  factory MyFollowersResult.fromJson(Map<String, dynamic> json) => MyFollowersResult(
    id: json["_id"] == null ? null : json["_id"],
    name: json["name"] == null ? null : json["name"],
    username: json["username"] == null ? null : json["username"],
    type: json["type"] == null ? null : json["type"],
    profileImage: json["profileImage"] == null ? null : json["profileImage"],
    profileImageType: json["profileImageType"] == null ? null : json["profileImageType"],
    district: json["district"] == null ? null : json["district"],
    state: json["state"] == null ? null : json["state"],
    country: json["country"] == null ? null : json["country"],
    chatId: json["chatId"] == null ? null : json["chatId"],
    followStatus: json["followStatus"] == null ? null : json["followStatus"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "name": name == null ? null : name,
    "username": username == null ? null : username,
    "type": type == null ? null : type,
    "profileImage": profileImage == null ? null : profileImage,
    "district": district == null ? null : district,
    "state": state == null ? null : state,
    "country": country == null ? null : country,
    "chatId": chatId == null ? null : chatId,
    "followStatus": followStatus == null ? null : followStatus,
  };
}
