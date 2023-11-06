// To parse this JSON data, do
//
//     final myInfoResponse = myInfoResponseFromJson(jsonString);

import 'dart:convert';

MyInfoResponse myInfoResponseFromJson(String str) => MyInfoResponse.fromJson(json.decode(str));

String myInfoResponseToJson(MyInfoResponse data) => json.encode(data.toJson());

class MyInfoResponse {
  MyInfoResponse({
    this.result,
    this.message,
    this.success,
  });

  List<MyProfileResult>? result;
  String? message;
  bool? success;

  factory MyInfoResponse.fromJson(Map<String, dynamic> json) => MyInfoResponse(
    result: json["result"] == null ? null : List<MyProfileResult>.from(json["result"].map((x) => MyProfileResult.fromJson(x))),
    message: json["message"] == null ? null : json["message"],
    success: json["success"] == null ? null : json["success"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : List<MyProfileResult>.from(result!.map((x) => x.toJson())),
    "message": message == null ? null : message,
    "success": success == null ? null : success,
  };
}

class MyProfileResult {
  MyProfileResult({
    this.id,
    this.gender,
    this.dob,
    this.bio,
    this.profession,
    this.district,
    this.state,
    this.country,
    this.isRegistered,
    this.name,
    this.profileImage,
    this.followingCount,
    this.followersCount,
    this.likesCount,
    this.registeredForContest,
    this.winnerTitle,
    this.runnerUp,
    this.countryLevel,
    this.score,
  });

  String? id;
  String ?gender;
  dynamic dob;
  String? bio;
  String? profession;
  String? district;
  String? state;
  String? country;
  bool? isRegistered;
  String? name;
  dynamic profileImage;
  int? followingCount;
  int? followersCount;
  int? likesCount;
  bool? registeredForContest;
  String? winnerTitle;
  String? runnerUp;
  String? countryLevel;
  String? score;

  factory MyProfileResult.fromJson(Map<String, dynamic> json) => MyProfileResult(
    id: json["_id"] == null ? null : json["_id"],
    gender: json["gender"] == null ? null : json["gender"],
    dob: json["dob"],
    bio: json["bio"] == null ? null : json["bio"],
    profession: json["profession"] == null ? null : json["profession"],
    district: json["district"] == null ? null : json["district"],
    state: json["state"] == null ? null : json["state"],
    country: json["country"] == null ? null : json["country"],
    isRegistered: json["isRegistered"] == null ? null : json["isRegistered"],
    name: json["name"] == null ? null : json["name"],
    profileImage: json["profileImage"],
    followingCount: json["followingCount"] == null ? null : json["followingCount"],
    followersCount: json["followersCount"] == null ? null : json["followersCount"],
    likesCount: json["likesCount"] == null ? null : json["likesCount"],
    registeredForContest: json["registeredForContest"] == null ? null : json["registeredForContest"],
    winnerTitle: json["winnerTitle"] == null ? null : json["winnerTitle"],
    runnerUp: json["runnerUp"] == null ? null : json["runnerUp"],
    countryLevel: json["countryLevel"] == null ? null : json["countryLevel"],
    score: json["score"] == null ? null : json["score"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "gender": gender == null ? null : gender,
    "dob": dob,
    "bio": bio == null ? null : bio,
    "profession": profession == null ? null : profession,
    "district": district == null ? null : district,
    "state": state == null ? null : state,
    "country": country == null ? null : country,
    "isRegistered": isRegistered == null ? null : isRegistered,
    "name": name == null ? null : name,
    "profileImage": profileImage,
    "followingCount": followingCount == null ? null : followingCount,
    "followersCount": followersCount == null ? null : followersCount,
    "likesCount": likesCount == null ? null : likesCount,
    "registeredForContest": registeredForContest == null ? null : registeredForContest,
    "winnerTitle": winnerTitle == null ? null : winnerTitle,
    "runnerUp": runnerUp == null ? null : runnerUp,
    "countryLevel": countryLevel == null ? null : countryLevel,
    "score": score == null ? null : score,
  };
}
